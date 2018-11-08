package com.coursera;

public class Main {
    private static int[] array = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    private static Quick_Union qu;

    public static void main(String[] args) {
        qu = new Quick_Union(array.length);
        qu.union(1, 4);

        System.out.print(qu.connected(1, 4) + "\n");
        System.out.print(qu.connected(2, 3) + "\n");

        qu.union(5, 7);
        qu.union(3, 8);
        qu.union(1, 8);
        System.out.print(qu.connected(4, 3) + "\n");
    }
}

class Quick_Union {
    private int[] id;
    private int[] sz;

    public Quick_Union(int N) {
        id = new int[N];
        sz = new int[N];

        this.initialize(N);
    }

    private void initialize(int N) {
        for (int i=0; i<N; i++) {
            id[i] = i;
            sz[i] = 1;
        }
    }

    private int root(int i) {
        while (i != id[i]) {
            id[i] = id[id[i]];
            i = id[i];
        }
        return i;
    }

    public boolean connected(int p, int q) {
        return this.root(p) == this.root(q);
    }

    public void union(int p, int q) {
        int i = root(p);
        int j = root(q);

        if (i == j)
            return;

        if (sz[i] > sz[j]) {
            id[i] = j;
            sz[j] += sz[i];
        }
        else {
            id[j] = i;
            sz[i] += sz[j];
        }
    }
}