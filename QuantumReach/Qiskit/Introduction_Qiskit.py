----------------
#Getting Started
----------------

from qiskit import ClassicalRegister, QuantumRegister, QuantumCircuit
from qiskit import execute

from qiskit import BasicAer

import numpy as np
np.set_printoptions(precision=3, supress=True)

-----------
#Backends
-----------

backend = BasicAer.get_backend('qasm_simulator')

q = QuantumRegister(1)
c = ClassicalRegister(1)
circuit = QuantumCircuit(q, c)
circuit.measure(q[0], c[0])

job = execute(circuit, backend, shots=100)
result = job.result()
result.get_counts(circuit)


backend = BasicAer.get_backend('statevector_simulator')

circuit = QuantumCircuit(q, c)
circuit.iden(q[0])
job = execute(circuit, backend)
state = job.result().get_statevector(circuit)
print(state)

------------
#Visualization
------------

from qiskit.tools.visualization import circuit_drawer
q = QuantumRegister(1)
c = ClassicalRegister(1)
circuit = QuantumCircuit(q, c)
circuit.measure(q[0], c[0])
circuit_drawer(circuit)

from qiskit.tools.visualization import plot_bloch_multivecotr
backend = BasicAer.get_backend('statevector_simulator')
circuit = QuantumCircuit(q, c)
circuit.iden(q[0])
job = execute(circuit, backend)
state = job.result().get_statevector(circuit)
print("Initial state")
plot_bloch_multivector(state)

circuit.h(q[0])
job = execute(circuit, backend)
state = job.result().get_statevector(circuit)
print("After a Hammard gate")
plot_bloch_multivector(state)

from qiskit.tools.visualization import plot_histogram
backend = BasicAer.get_backend('qasm_simulator')
q = QuantumRegister(1)
c = ClassicalRegister(1)
circuit = QuantumCircuit(q, c)
circuit.measure(q[0], c[0])
job = execute(circuit, backend, shots=1000)
print("initial state statistics")
plot_histogram(job.result().get_counts(circuit))

circuit = QuantumCircuit(q, c)
circuit.h(q[0])
circuit.measure(q[0], c[0])
job = execute(circuit, backend, shots=1000)
print("Statistics if we apply a Hadamard gate")
plot_histogram(job.result().get_counts(circuit))




