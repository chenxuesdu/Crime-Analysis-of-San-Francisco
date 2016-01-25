package crimeAnalysis;

public enum DayOfWeek {
	MONDAY((byte)1), TUESDAY((byte)2), WEDNESDAY((byte)3), THURSDAY((byte)4), FRIDAY((byte)5), SATURDAY((byte)6), SUNDAY((byte)7);
	private byte value;
	private DayOfWeek(byte value) {
		this.value = value;
	}
	public byte getValue() {
		return value;
	}
}
