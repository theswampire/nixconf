#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define DEFAULT "default"
#define PERFORMANCE "performance"
#define POWERSAVE "powersave"
#define POWERSUPERSAVE "powersupersave"

bool dothing(char *profile) {
  printf("doing %s\n", profile);
  FILE *fptr;
  fptr = fopen("/sys/module/pcie_aspm/parameters/policy", "w");
  if (fptr == NULL) {
    printf("failed to open policy file");
    return false;
  }

  bool ok = fputs(profile, fptr) >= 0;
  fclose(fptr);
  if (!ok) {
    printf("failed to set pcie_aspm policy to %s\n", profile);
    return false;
  }

  printf("set pcie_aspm to %s\n", profile);

  return true;
}

bool printcurrent() {
  FILE *fptr;
  fptr = fopen("/sys/module/pcie_aspm/parameters/policy", "r");
  if (fptr == NULL) {
    printf("failed to open policy file");
    return false;
  }

  char buf[50];
  fgets(buf, 50, fptr);
  buf[strcspn(buf, "\r\n")] = 0;
  printf("current pcie_aspm policy is \"%s\"\n", buf);
  return true;
}

int main(int argc, char *argv[]) {

  if (argc != 2) {
    printf("aspm_powerswitch\n\ndefine power profile:\n\t- \"" DEFAULT
           "\"\n\t- \"" PERFORMANCE "\"\n\t- \"" POWERSAVE
           "\"\n\t- \"" POWERSUPERSAVE "\"\n");
    printcurrent();
    return -1;
  }

  bool success = false;
  if (strncmp(argv[1], DEFAULT, strlen(DEFAULT)) == 0) {
    success = dothing(DEFAULT);
  }
  if (strncmp(argv[1], PERFORMANCE, strlen(PERFORMANCE)) == 0) {
    success = dothing(PERFORMANCE);
  }
  if (strncmp(argv[1], POWERSAVE, strlen(POWERSAVE)) == 0) {
    success = dothing(POWERSAVE);
  }
  if (strncmp(argv[1], POWERSUPERSAVE, strlen(POWERSUPERSAVE)) == 0) {
    success = dothing(POWERSUPERSAVE);
  }
  if (!success) {
    return -1;
  }

  return 0;
}
