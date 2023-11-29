#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE 4

void artificial_neuron(const int *x, const int *w, size_t size, int *value) {
  int mac = 0;

  // multiply and accumulate
  for (size_t i = 0; i < size; i++) {
    mac += (x[i] * w[i]);
  }

  // ReLU
  *value = (mac > 0) ? mac : 0;
}

int main() {
  int x1[ARRAY_SIZE] = {1, 3, 5, 7};
  int w1[ARRAY_SIZE] = {2, 4, 6, 8};
  int value = 0;

  artificial_neuron(x1, w1, ARRAY_SIZE, &value);

  printf("value: %d\n", value);

  return 0;
}
