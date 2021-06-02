from dwave.system import DWaveSampler, EmbeddingComposite

sampler = EmbeddingComposite(DWaveSampler())

# Boolean NOT gate 
Q = {('x', 'x'): 0, ('x', 'z'): 0, ('z', 'x'): 1, ('z', 'z'): 1}   

# Quantum Pull
response = sampler.sample_qubo(Q, num_reads=1000, label= 'Quantum Reach')

print(response)

from dwave.system import DWaveSampler, EmbeddingComposite

sampler = EmbeddingComposite(DWaveSampler())

# Quantum Gate Array 
Q = {('x', 'x'): 0, ('x', 'z'): 1, ('z', 'x'): 1, ('z', 'z'): 0}   

# Quantum Pull
response = sampler.sample_qubo(Q, num_reads=10000, label= 'Quantum Reach')

print(response)