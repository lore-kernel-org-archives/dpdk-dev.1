Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D8606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A60402EE;
	Tue, 27 Oct 2026 17:21:47 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id ABA23400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:21:45 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 87CC84D3A7; Tue, 27 Oct 2026 17:21:45 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2084] crypto/openssl: 3DES-CTR reads past
 segment that ends at cipher offset
Date: Tue, 27 Oct 2026 16:21:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2084-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2084

            Bug ID: 2084
           Summary: crypto/openssl: 3DES-CTR reads past segment that ends
                    at cipher offset
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 432
  --> https://bugs.dpdk.org/attachment.cgi?id=3D432&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-CUYNXISN  [NOT SECURITY: ordinary bug]
crypto/openssl: 3DES-CTR reads past segment that ends at cipher offset
Location: drivers/crypto/openssl/rte_openssl_pmd.c:1205  in
process_openssl_cipher_des3ctr()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


The crypto_openssl PMD returns wrong data for 3DES-CTR ops that use a chain=
ed
source mbuf and a contiguous destination (out of place) when the cipher ran=
ge
starts exactly at the end of a source segment, or when the range includes a
zero-length segment. The op still completes with
`RTE_CRYPTO_OP_STATUS_SUCCESS`, but instead of the payload in the next mbuf,
the driver ciphers whatever memory follows the current segment's data. That=
 is
usually leftovers from an earlier packet in the same mbuf, or the neighbour=
ing
mempool object when the range is longer than the tailroom.

The problem is in `process_openssl_cipher_des3ctr()` in
`drivers/crypto/openssl/rte_openssl_pmd.c`. The segment-selection loop uses
`offset > rte_pktmbuf_data_len(m)`, so an offset equal to a segment's length
stops on that segment with `l =3D 0` bytes left. The byte loop reads `*src`
before checking `l`, then decrements it to -1. Because `!l` never becomes t=
rue
again, the switch to `m->next` never happens and all `cipher.data.length` b=
ytes
are read linearly.

The PMD accepts this layout, since it advertises
`RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT` and only rejects a segmented destinati=
on.
An application that always puts the header and the payload in separate mbufs
will therefore get wrong output on every packet. AES-CTR and the other
EVP-based ciphers in the same driver handle the same op correctly. No libra=
ry
or example in the tree submits such ops.

The attached reproducer builds a 16-byte header plus a 31-byte payload in t=
wo
chained mbufs and encrypts it with `cipher.data.offset =3D 16`. With the fi=
rst
segment split at 20 bytes, the decrypted result is the original payload. Wi=
th
the split at 16 bytes, the result is 31 `S` bytes from a previously freed
packet. No crash or ASan report occurs. A patch that advances to the next
non-empty segment before reading each byte is attached, along with two new
blockcipher test cases.

## Details

This is an ordinary bug, not a security issue: the mbuf layout and cipher
offset that trigger it are chosen by the
application itself, and no library, example or guest-facing path in the tree
builds such an op.

`process_openssl_cipher_des3ctr()` keeps reading from the first source segm=
ent
when the cipher range starts exactly at
the end of that segment: it never moves to the next mbuf of the chain. The =
op
completes with
`RTE_CRYPTO_OP_STATUS_SUCCESS`, but what was ciphered is the memory behind =
the
segment's data, not the payload.

Shown on `crypto_openssl` at commit 9a45341f18 (default build): a packet of=
 a
16-byte header and a 31-byte payload,
held in two chained mbufs, is encrypted out of place into a contiguous mbuf
with `cipher.data.offset =3D 16`,
`cipher.data.length =3D 31`, and the result is decrypted again as the peer =
would
do.

| cipher | first segment | peer decrypts |
|---|---|---|
| `RTE_CRYPTO_CIPHER_AES_CTR` | 16 bytes | `the payload of this very packet=
` |
| `RTE_CRYPTO_CIPHER_3DES_CTR` | 20 bytes | `the payload of this very packe=
t` |
| `RTE_CRYPTO_CIPHER_3DES_CTR` | 16 bytes | `SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS=
S` |

`S` is the content of an unrelated packet that used the first mbuf before a=
nd
was freed.

The code, `drivers/crypto/openssl/rte_openssl_pmd.c:1181`:

```c
        for (m =3D mbuf_src; m !=3D NULL && offset > rte_pktmbuf_data_len(m=
);
                        m =3D m->next)
                offset -=3D rte_pktmbuf_data_len(m);
        =E2=80=A6
        src =3D rte_pktmbuf_mtod_offset(m, uint8_t *, offset);
        l =3D rte_pktmbuf_data_len(m) - offset;
        =E2=80=A6
        for (n =3D 0; n < srclen; n++) {
                =E2=80=A6
                dst[n] =3D *(src++) ^ ebuf[n % 8];        /* 1205 */

                l--;
                if (!l) {
                        m =3D m->next;
                        if (m) {
                                src =3D rte_pktmbuf_mtod(m, uint8_t *);
                                l =3D rte_pktmbuf_data_len(m);
                        }
                }
        }
```

The first loop compares with `>`, so with `offset =3D=3D data_len` it stops=
 on the
segment that ends at the offset: `src`
points one byte past that segment's data and `l`, the number of bytes left =
in
the segment, is 0. The byte loop reads
`*src` before it looks at `l`, then decrements `l` to -1, and `!l` is never
true again. All `srclen` bytes are taken
linearly from `src`; nothing bounds the read to the mbuf's buffer.

In the example the offset 16 equals the length of the first segment, so the=
 31
bytes come from the tailroom of the
header mbuf, which still holds the previous packet. With the first segment =
20
bytes long, `l` starts at 4, reaches 0
after four bytes and the switch to the second mbuf happens as intended.

Two more observations with the same program, adapted to other segment layou=
ts:

- A zero-length segment inside the range has the same effect, because the i=
nner
assignment
  `l =3D rte_pktmbuf_data_len(m)` also produces `l =3D 0`: with segments of=
 20, 0
and 27 bytes the peer gets `the ` followed
  by 27 bytes that are not the payload.
- With a 3000-byte range and the default 2048-byte data room, the output is=
 the
3000 bytes of memory that follow the
  header in the first mbuf; 968 of them lie beyond the end of that mbuf's
buffer (`buf_addr + buf_len`), in the
  neighbouring object of the mempool. No crash results.

The other segment walkers of this file (`process_openssl_encryption_update(=
)`
at line 974 and its siblings) start with
the same `offset > data_len` loop, but they pass `l` as a length to
`EVP_*Update()` and then advance with
`for (m =3D m->next; =E2=80=A6)`, so `l =3D 0` is harmless there. That is w=
hy AES-CTR gives
the right result on the same op.

The layout is one the PMD accepts. `process_openssl_cipher_op()` only rejec=
ts a
segmented destination
(`rte_openssl_pmd.c:1699`); a chained `m_src` with a contiguous `m_dst` goe=
s on
to `process_openssl_cipher_des3ctr()`
at line 1724, and the device advertises `RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT`
(line 4185). The op's offset and length
are consistent with the mbuf chain.

## Impact

Affected are applications that give `crypto_openssl` a 3DES-CTR op (cipher =
only
or chained with auth, both go through
`process_openssl_cipher_op()`) with a chained source and a contiguous
destination, when the cipher range starts at
the beginning of a segment or spans an empty segment. No devargs or build
options are involved; the default build is
affected. The mbuf layout and the offset are the application's own choice.
Nothing in `lib/` or `examples/` submits
such ops: `lib/ipsec` and `lib/pdcp` do not accept 3DES-CTR, vhost crypto
always builds a single-segment source,
`l2fwd-crypto` works in place and `test-crypto-perf` uses cipher offset 0.

Where the layout puts the boundary at the cipher offset by design, e.g. a
header mbuf followed by a payload mbuf, the
op goes wrong on every packet, with a success status. On encryption the out=
put
is the keystream XORed with whatever
sits behind the first segment's data (leftovers of earlier packets in that
mbuf, and the neighbouring mempool object
when the range is longer than the tailroom), so the receiver never gets the
payload. On decryption the application
receives bytes derived from that memory instead of the plaintext. The
destination is written correctly sized; there
is no out-of-bounds write, and no crash was observed. The ASan build returns
the same bytes without a report, because
all mbufs of a pool sit in one allocation.

3DES-CTR together with out-of-place operation on chained mbufs is an uncomm=
on
combination; an application that uses
it with such a layout sees wrong output on its first test. AES-CTR and the
other EVP-based ciphers of the same PMD are
not affected.

## Reproducing

`repro` compiles `repro.d/encrypt_chained_packet.c` with gcc against the sh=
ared
libraries of the default build
`/src/build` (`pkg-config` from `meson-uninstalled`), then runs it twice wi=
th
`--no-huge -m 512 --no-pci --vdev crypto_openssl`, loading
`librte_mempool_ring.so` and `librte_crypto_openssl.so`
with `-d`. No devargs, build options or source changes are involved.

Files:

- `repro` (setup and verdict): builds the application, runs it once as a
control and once on the boundary layout,
  prints both results and decides.
- `repro.d/encrypt_chained_packet.c` (the application developer's part): an
ordinary cryptodev user. It checks that
  the device advertises `RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT`, creates a
cipher-only `RTE_CRYPTO_CIPHER_3DES_CTR`
  session, and lets one packet of another flow (256 `S` bytes) pass through=
 an
mbuf that it then frees. It builds the
  packet, 16 `H` header bytes followed by the payload from the command line=
, in
two chained mbufs split after the
  number of bytes given on the command line; the first of these mbufs is the
one the other flow just freed. It
  encrypts the packet out of place into a contiguous mbuf with
`cipher.data.offset =3D 16` and
  `cipher.data.length =3D strlen(payload)`, decrypts that mbuf with the same
session as the peer would, and prints
  `peer decrypts: <payload bytes>`. Every op must complete with
`RTE_CRYPTO_OP_STATUS_SUCCESS`, or the program exits
  with an error.

The payload is `the payload of this very packet` (31 bytes). The two runs
differ only in where the packet is split:

- control: first segment of 20 bytes (header plus 4 payload bytes); the peer
must get the payload back, otherwise
  the script stops with an error because the setup is broken;
- trigger: first segment of 16 bytes, so the segment ends exactly at
`cipher.data.offset`.

Expected output on the affected tree:

```
CONTROL  3des-ctr, first segment 20 bytes: peer decrypts 'the payload of th=
is
very packet'
OBSERVED 3des-ctr, first segment 16 bytes: peer decrypts
'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS'
BUG
```

`BUG` is printed when the trigger run returns only `S` bytes: the 31 bytes
behind the header in the first mbuf, left
there by the freed packet, were encrypted instead of the payload in the sec=
ond
mbuf. With the attached patch applied
(rebuilding `drivers/librte_crypto_openssl.so.27.0`) both runs return the
payload and the script prints `OK`. It takes
about 2.5 seconds.

## Suggested fix

The attached patch changes `process_openssl_cipher_des3ctr()` in
`drivers/crypto/openssl/rte_openssl_pmd.c` to move
to the next segment before reading a byte instead of after. At the top of t=
he
byte loop a `while (l =3D=3D 0)` advances
`m` to the next mbuf that still holds data and resets `src` and `l` from it=
; if
the chain ends before `srclen` bytes
were processed it jumps to `process_cipher_des3ctr_err`, so the op fails wi=
th
`RTE_CRYPTO_OP_STATUS_ERROR`. The old
switch after `l--` is removed. This covers the boundary case, empty segment=
s,
and a range that runs past the end of
the chain, which the current loop also reads linearly and reports as succes=
s;
that case now fails instead. Valid
input is ciphered as before. The other segment walkers of the file pass `l`=
 as
a length to OpenSSL and are left
alone.

The patch also adds two blockcipher test cases to
`app/test/test_cryptodev_des_test_vectors.h`: 3DES-128-CTR
encryption and decryption, out of place with an SGL source and a linear
destination, two segments of 256 bytes and
`cipher_offset =3D 256`, with the IV advanced by the 32 skipped blocks so t=
he
existing ciphertext vector applies. Both
fail on the unpatched driver and pass with the fix in
`cryptodev_openssl_autotest`.

```
Fixes: 8f675fc72d5c ("crypto/openssl: support scatter-gather")
Cc: stable@dpdk.org
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
