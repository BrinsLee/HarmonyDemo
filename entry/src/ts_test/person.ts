export class Person {
  private age: number;
  private name: string;

  constructor (age: number, name: string) {
    this.age = age;
    this.name = name;
  }

  public getPersonInfo(): string {
    return `name: ${this.name}, age: ${this.age}`;
  }
}

// 默认导出
export class Employee extends Person {
  private department: string;

  constructor (age: number, name: string, job: string) {
    super(age, name);
    this.department = job;
  }

  public getEmployeeInfo(): string {
    return `${super.getPersonInfo()}, job: ${this.department}`;
  }
}