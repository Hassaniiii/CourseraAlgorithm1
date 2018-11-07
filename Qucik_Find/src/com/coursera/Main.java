package com.coursera;

public class Main {
    private static int[] array = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    private static QuickFind qf;

    public static void main(String[] args) {
	    qf = new QuickFind(array.length);
        qf.union(3, 4);

        System.out.print(qf.connected(1, 5) + "\n");
        System.out.print(qf.connected(3, 4) + "\n");
    }
}

class QuickFind {
    private int[] id;

    public QuickFind(int N) {
        this.id = new int[N];
        this.initialize(N);
    }

    private void initialize(int N) {
        for (int i=0; i<N; i++)
            id[i] = i;
    }

    public boolean connected(int p, int q) {
        return id[p] == id[q];
    }

    public void union(int p, int q) {
        int pid = id[p];
        int qid = id[q];
        for (int i=0; i<id.length; i++) {
            if (id[i] == pid)
                id[i] = qid;
        }
    }

    public int[] getArray() {
        return id;
    }
}