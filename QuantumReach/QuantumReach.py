from dwave.system import DWaveSampler, EmbeddingComposite
import random

sampler = EmbeddingComposite(DWaveSampler())
Q = random.randint(0,1)
response = sampler.sample_qubo(Q, num_reads=5000, label='Quantum Reach')
print(response)

response2 = sampler.sample_qubo(Q, num_reads=1, label='Quantum Vote')
print(response2)
print(Q)

if Q is 1:
    print('Move 5.00 Algo to Alice')
else:
    print('Move 0.00 Algo to Alice')