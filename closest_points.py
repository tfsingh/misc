# An algorithm for finding the distance between the closest
# pair of points in a set of points. Algorithm is based on
# Prof. Robbie Webel's lecture on D + C algorithms.
import math
import matplotlib.pyplot as plt

def closest_points(points):

    def distance(p1, p2):
        return math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)
    
    def brute_force(points):
        min_dist = float("inf")

        for i in range(len(points)):
            for j in range(i+1, len(points)):
                dist = distance(points[i], points[j])
                if dist < min_dist:
                    min_dist = dist

        return min_dist 

    def divide_and_conquer(p):
        n = len(p)

        if (n <= 5):
            return brute_force(p)
        p.sort(key=lambda x: x[0])

        delta = min(divide_and_conquer(p[:n//2]), divide_and_conquer(p[n//2:]))

        C = [x for x in p if abs(x[0] - p[n//2][0]) < delta]
        C.sort(key=lambda x: x[1])

        for i in range(len(C)):
            for j in range(i+1, min(i+10, len(C))):
                delta = min(delta, distance(C[i], C[j]))

        return delta
    
    return divide_and_conquer(points)

if __name__ == "__main__":
    points = [(1, 1), (3, 1), (1, 3), (3, 3), (2, 2), (5, 5), (7, 7), (5, 7), (7, 5)]
    #plt.scatter([x[0] for x in points], [x[1] for x in points])
    #plt.show()
    print(closest_points(points))
