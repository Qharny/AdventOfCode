
const data = await Deno.readTextFile("input.txt");

const lines = data.split("\n").filter((line: string) => line.trim() !== "");

const Reports: number[][] = lines.map((line: string) => {
  return line.split(" ")
    .map((char: string) => parseInt(char, 10))
    .filter(Number.isFinite); // Exclude NaN values
});

const validateReport = (report: number[]): boolean => {
  if (report.length < 2) return false;

  const initialTrend = report[1] - report[0];

  for (let i = 0; i < report.length - 1; i++) {
    const difference = Math.abs(report[i] - report[i + 1]);
    const currentTrend = report[i + 1] - report[i];

    if (difference > 3) return true;              // Check if the difference exceeds 3
    if (report[i] === report[i + 1]) return true; // Check if two consecutive numbers are equal
    if ((initialTrend > 0 && currentTrend < 0) || (initialTrend < 0 && currentTrend > 0)) {
      return true; // Check for trend reversal
    }
  }

  return false;
};

const safeReports = Reports.filter((report: number[]) => !validateReport(report));

const numberOfSafeReports = safeReports.length;

console.table(safeReports);
console.log("Number of safe reports:", numberOfSafeReports);
console.log("Total reports:", Reports.length);
