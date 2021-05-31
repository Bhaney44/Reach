'reach 0.1';
const x = 2 + 2;

const x = 2 + 2;
assert(x == 4);

const x = 2 + 2;
export const main = Reach.App(() => {
 const A = Participant('A', {
  see: Fun([UInt], Null),
 });
 deploy();
 A.interact.see(x);
 exit();
});

export const main = Reach.App(() => {
 const A = Participant('A', {
 });
 deploy();
 A.only(() => {
  const x = declassify(2 + 2); });
 A.publish(x);
 commit();
 exit();
});