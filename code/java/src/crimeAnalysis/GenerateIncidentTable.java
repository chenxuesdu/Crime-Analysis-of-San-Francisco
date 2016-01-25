package crimeAnalysis;



import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;
import org.apache.hadoop.mapred.FileOutputFormat;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reducer;
import org.apache.hadoop.mapred.Reporter;
import org.apache.hadoop.mapred.TextInputFormat;
import org.apache.hadoop.mapred.TextOutputFormat;

import org.apache.commons.lang3.StringUtils;


import sun.org.mozilla.javascript.internal.json.JsonParser.ParseException;

public class GenerateIncidentTable {
	public static final String DELIMITOR = "\t";
	public static class MyMapper extends MapReduceBase implements
			Mapper<LongWritable, Text, NullWritable, Text> {
		@Override
		public void map(LongWritable key, Text value,
				OutputCollector<NullWritable, Text> output, Reporter reporter)
				throws IOException {
			// TODO Auto-generated method stub
			String[] tokens = value.toString().split("\t");
			String[] newTokens = new String[10];
			
			for (int i = 0; i < 3; i++) {
				newTokens[i] = tokens[i];
			}
			newTokens[3] = String.valueOf(DayOfWeek.valueOf(tokens[3].toUpperCase()).getValue()); 
			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm");
			try {
				Date date = formatter.parse(tokens[4] + " " + tokens[5]); 
				newTokens[4] = String.valueOf(date.getTime());
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			for (int i = 5; i < 10; i++) {
				newTokens[i] = tokens[i+1];
			}
			String out = StringUtils.join(newTokens, DELIMITOR);		
			output.collect(NullWritable.get(), new Text(out));
		}
	}
	public static void main(String[] args) throws Exception {
		JobConf conf = new JobConf(GenerateIncidentTable.class);
		conf.setJobName("GenerateIncidentTable");

		conf.setMapperClass(MyMapper.class);
		
		conf.setMapOutputKeyClass(NullWritable.class);
		conf.setMapOutputValueClass(Text.class);

		conf.setOutputKeyClass(NullWritable.class);
		conf.setOutputValueClass(Text.class);
		
		FileInputFormat.setInputPaths(conf, new Path(args[0]));
		FileOutputFormat.setOutputPath(conf, new Path(args[1]));
		JobClient.runJob(conf);
	}
}

