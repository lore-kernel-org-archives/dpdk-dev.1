Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACC60A260C
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2B5400D7;
	Tue, 27 Oct 2026 17:05:40 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 290BD400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:05:39 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 17DA84D45F; Tue, 27 Oct 2026 17:05:39 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2079] compress/zlib: out-of-bounds read in UDC
 checksum after stream reset
Date: Tue, 27 Oct 2026 16:05:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
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
Message-ID: <bug-2079-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2079

            Bug ID: 2079
           Summary: compress/zlib: out-of-bounds read in UDC checksum
                    after stream reset
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 427
  --> https://bugs.dpdk.org/attachment.cgi?id=3D427&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-ISGDYAIV  [NOT SECURITY: ordinary bug]
compress/zlib: out-of-bounds read in UDC checksum after stream reset
Location: drivers/compress/zlib/zlib_pmd.c:102  in
process_zlib_inflate_chksum()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


The UDC checksum in the zlib compress PMD is computed from stray heap memory
instead of the UDC buffer on every stateless op after the first one on a
private xform, and on every op when the xform has no dictionary. Depending =
on
what that memory holds, a valid PDU can be rejected on decompression with
`RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED`, or compression can return a
wrong nibble in `op->output_chksum`. Nothing crashes in a normal build. Und=
er
ASan, the checksum step reads 4 bytes before its `malloc()`'d history buffe=
r.

In `process_zlib_inflate_chksum()` and `process_zlib_deflate_chksum()`
(`drivers/compress/zlib/zlib_pmd.c`, lines 101=E2=80=93102 and 51=E2=80=935=
2), the code reads
`*(uint32_t *)dictionary` and `*(uint32_t *)(dictionary + dictionary_len - =
4)`
without checking that `dictionary_len >=3D 4`. The history becomes empty in=
 two
cases. First, any op whose flush flag is not `RTE_COMP_FLUSH_SYNC` ends in
`inflateReset()`/`deflateReset()`, which discards the dictionary installed =
from
the xform; that includes `FLUSH_FULL`/`FLUSH_FINAL`, the flags `rte_comp.h`
asks for on stateless ops. Second, the xform may have no dictionary, or one
shorter than 4 bytes. The bad value comes from the uninitialised first read;
the read before the buffer lands in glibc's chunk header and is zero in
practice. On a fresh heap the nibble happens to come out right (0xf), but o=
n a
used heap it varies from run to run.

The attached reproducer decompresses the same valid UDC PDU twice on one
`compress_zlib` xform with an 8192-byte dictionary and `RTE_COMP_FLUSH_FINA=
L`.
The first op succeeds, and ASan reports the 4-byte read before the buffer at
line 102 on the second. Only applications that use a dictionary of at least=
 4
bytes and `RTE_COMP_FLUSH_SYNC` on every op are unaffected. The unchecked r=
ead
dates from the commit that added the feature, 0dc314debb22 ("compress/zlib:
support dictionaries and PDCP checksum").

This is an ordinary bug, not a security issue: the short history that trigg=
ers
it comes only from the flush flag and
xform the application chooses, never from packet contents, and the only eff=
ect
is a wrong 4-bit UDC checksum.

## Details

The UDC checksum helpers of the zlib PMD read the last four bytes of the
history that zlib returns without checking
that the history holds four bytes. When it is empty the read starts four by=
tes
before the heap buffer, and the "first four
bytes" are uninitialised `malloc()` memory.

`drivers/compress/zlib/zlib_pmd.c:80` (`process_zlib_inflate_chksum()`;
`process_zlib_deflate_chksum()` has the same
code at lines 29-52):

```c
        uint32_t dictionary_len =3D 0;
        uint8_t *dictionary =3D malloc(ZLIB_MAX_DICT_SIZE);
        =E2=80=A6
                if (inflateGetDictionary(strm, dictionary, &dictionary_len)=
) {
        =E2=80=A6
                dictionary_start =3D *(uint32_t *)dictionary;
                dictionary_end =3D *(uint32_t *)(dictionary + dictionary_le=
n -
4);      /* line 102 */
```

An application that decompresses two valid UDC PDUs on one private xform
(DEFLATE, `RTE_COMP_CHECKSUM_3GPP_PDCP_UDC`,
8192-byte zero dictionary, stateless ops with `RTE_COMP_FLUSH_FINAL`) gets =
this
from `/src/build-asan` on the second op:

```
ERROR: AddressSanitizer: heap-buffer-overflow =E2=80=A6 READ of size 4
    #0 process_zlib_inflate_chksum drivers/compress/zlib/zlib_pmd.c:102:20
    #1 process_zlib_op drivers/compress/zlib/zlib_pmd.c:337:3
    #2 zlib_pmd_enqueue_burst drivers/compress/zlib/zlib_pmd.c:481:9
=E2=80=A6 is located 4 bytes before 32768-byte region =E2=80=A6 allocated b=
y =E2=80=A6
process_zlib_inflate_chksum zlib_pmd.c:81
```

`process_zlib_op()` runs the checksum step before the (de)compression step
(`zlib_pmd.c:337`, `:341`), so the checksum is
taken over the history left by the previous op. On the first op that is the
dictionary installed from the xform by
`zlib_set_stream_parameters()` (`zlib_pmd.c:458-464`): `inflateGetDictionar=
y()`
reports 8192 bytes and both reads are in
bounds.

The first op then ends with

```c
        if (op->flush_flag !=3D RTE_COMP_FLUSH_SYNC)
                inflateReset(strm);                                       /*
zlib_pmd.c:318 */
```

`inflateReset()` discards the sliding window, including the dictionary, and
nothing installs it again. On the second op
`inflateGetDictionary()` returns success, sets `dictionary_len` to 0 and co=
pies
nothing (checked with the zlib 1.3.1 of
the image). Line 101 reads four bytes that nobody wrote and line 102 reads
`dictionary - 4`.

The flush flag that leads here is the one the API asks for. The PMD accepts
only stateless ops (`zlib_pmd.c:328`), and
for those `lib/compressdev/rte_comp.h:225` says "Flush flag must be set to
either FLUSH_FULL or FLUSH_FINAL".
`lib/compressdev/rte_compressdev.h:425` adds that the flush flag "has no
meaning for decompression", and an op fresh
from `rte_comp_op_alloc()` carries `RTE_COMP_FLUSH_NONE`
(`lib/compressdev/rte_comp.c:75` zeroes it), which takes the
same branch. `app/test-compress-perf/comp_perf_test_verify.c:218-225` prepa=
res
UDC decompress ops this way too
(`RTE_COMP_FLUSH_FINAL`, `input_chksum` from the header byte), although its
xform (line 130) always selects
`RTE_COMP_CHECKSUM_NONE`, so the tool itself never reaches the read.

Other ways to the same read, each confirmed with the ASan build:

* Compression: `deflateReset()` at `zlib_pmd.c:226-227` empties the history=
 in
the same way; the second op with
  `RTE_COMP_FLUSH_FINAL` or `RTE_COMP_FLUSH_FULL` reports the read at
`zlib_pmd.c:52`.
* No dictionary in the xform: the history is empty on the first op already,=
 in
both directions and with any flush flag.
* A dictionary shorter than four bytes: with `dictionary_len =3D 2` the read
starts two bytes before the buffer.

With an 8192-byte dictionary and `RTE_COMP_FLUSH_SYNC` on every op the hist=
ory
never shrinks and three consecutive ops
run without a report in either direction.

## Impact

An application that uses UDC checksums on this PMD gets a checksum computed
from heap memory instead of from the UDC
buffer: on every UDC-checksummed op after the first one of a private xform
unless the ops use `RTE_COMP_FLUSH_SYNC`, and
on the first op when the xform has no dictionary (or one under four bytes).=
 The
eight bytes read are folded into the
4-bit value that is compared with the nibble from the PDU header on
decompression, or returned in `op->output_chksum` on
compression.

Nothing crashes in the default build. With glibc the four bytes below the
buffer belong to the chunk header, are always
mapped and are always zero there, so the out-of-bounds read at line 102 (52=
 for
compression) does not change the
result. The value that varies comes from the uninitialised read one line
earlier. On a fresh heap those bytes are zero
as well, the nibble comes out 0xf, and the application built against
`/src/build` processes six copies of the PDU with
status 0. Once the heap has been used they hold the low half of a libc arena
pointer: the nibble changes from run to run,
a valid second PDU is rejected with status 7
(`RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED`), and compression returns
a wrong nibble in `output_chksum`.

Every application that does stateless UDC with `RTE_COMP_FLUSH_FULL` or
`RTE_COMP_FLUSH_FINAL` (the flags the API asks
for), or without a dictionary, meets this, and its UDC checking is unreliab=
le
from the second op on. An application
that installs a dictionary of four or more bytes and uses `RTE_COMP_FLUSH_S=
YNC`
on every op, in both directions, never
does; that is also the only setup in which UDC works on this PMD, since the
buffer must carry over between packets. The
PDUs themselves play no part: offset and length are fixed, and the empty
history comes from the flush flag and the
xform.

## Reproducing

`repro` compiles a small compressdev application with ASan against
`/src/build-asan`, writes one valid UDC PDU, and
runs the application with that PDU twice on `--vdev compress_zlib` (`--no-h=
uge
-m 512 --no-pci`). ASan is only there to
make the read visible. The default build does not crash (see Impact).

Files:

* `repro` (setup and verdict) builds the application, writes the PDU to
`/tmp/udc_pdu.bin`, runs the application with
  `-- /tmp/udc_pdu.bin /tmp/udc_pdu.bin` and checks the result. The shared =
DPDK
libraries load no drivers on their
  own, so the script passes `-d librte_mempool_ring.so -d
librte_compress_zlib.so`. It sets
  `ASAN_OPTIONS=3Ddetect_leaks=3D0` so that allocations EAL leaves behind a=
t exit
do not add noise.
* `repro.d/udc_decompress_app.c` (the ordinary developer's program) is the
receiver for one PDCP bearer. It creates one
  private xform (DEFLATE, window 13, `RTE_COMP_CHECKSUM_3GPP_PDCP_UDC`,
8192-byte all-zero dictionary as the initial
  UDC buffer). For each PDU file it enqueues one stateless op with
`RTE_COMP_FLUSH_FINAL` (the flag `rte_comp.h`
  requires for stateless ops), `src.offset =3D 1`, and `input_chksum` set t=
o the
low nibble of the UDC header. It then
  prints `PDU n: status S, N bytes`.
* The PDU (the sender's part) is built in `repro` from named parts: UDC hea=
der
`0x80 | 0xf`, meaning "compressed" plus
  checksum 0xf (the UDC checksum of the all-zero buffer), followed by `hell=
o`
as raw DEFLATE. The PDU is valid, and
  nothing in it is malformed. Any PDU that reaches the second op of such an
xform triggers the read.

Expected output on this tree:

```
CONTROL PDU 1: status 0, 5 bytes
OBSERVED
heap-buffer-overflow on address 0x=E2=80=A6 at pc 0x=E2=80=A6 bp 0x=E2=80=
=A6 sp 0x=E2=80=A6
READ of size 4 at 0x=E2=80=A6 thread T0
    #0 0x=E2=80=A6 in process_zlib_inflate_chksum
/src/build-asan/../drivers/compress/zlib/zlib_pmd.c:102:20
    #1 0x=E2=80=A6 in process_zlib_op
/src/build-asan/../drivers/compress/zlib/zlib_pmd.c:337:3
0x=E2=80=A6 is located 4 bytes before 32768-byte region [0x=E2=80=A6,0x=E2=
=80=A6)
BUG
```

The first op on the xform decompresses the PDU (status 0, 5 bytes). The sec=
ond
op is the same PDU on the same xform,
and it never gets to decompress: ASan stops it in the checksum step. `BUG` =
is
printed only when both of these hold: the
first PDU succeeded, and ASan reports a heap-buffer-overflow `READ of size =
4`
with frame #0 in
`process_zlib_inflate_chksum`, located 4 bytes before the buffer. With the
attached patch applied and
`librte_compress_zlib` rebuilt, no ASan report appears and the script prints
`OK`.

## Suggested fix

The attached patch adds a length check to both helpers,
`process_zlib_deflate_chksum()` and
`process_zlib_inflate_chksum()`, right after
`deflateGetDictionary()`/`inflateGetDictionary()` return the history and
before either read. When `dictionary_len` is under `sizeof(uint32_t)` it lo=
gs
"Dictionary too short for checksum", sets
`RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED`, frees the buffer and retur=
ns,
the same path the helpers already take
when fetching the dictionary fails, so `process_zlib_op()` fails the op ins=
tead
of producing a nibble from heap memory.
Ops with a history of four or more bytes (the first op with a dictionary,
`RTE_COMP_FLUSH_SYNC` streams) are unchanged.
With it applied and `librte_compress_zlib` rebuilt in `build-asan`, the sec=
ond
op of the reproducer ends with status 7,
there is no ASan report and `repro` prints `OK`.

The patch does not make stateless UDC work: it makes visible that a statele=
ss
xform with a dictionary only works for its
first op, because every later op starts from an empty history. Two follow-u=
ps
are left to the maintainers:

* Keep the xform's dictionary in `struct zlib_stream` and call
`inflateSetDictionary()`/`deflateSetDictionary()` again
  after the reset at `zlib_pmd.c:227` and `:318`. With that on top of the p=
atch
(tried with the stream holding the
  xform's pointer), both PDUs of the reproducer decompress with status 0 and
ASan stays silent. It needs a decision on
  whether the PMD copies the dictionary or requires the application to keep=
 it
allocated for the lifetime of the xform.
  The alternative is to document that UDC needs `RTE_COMP_FLUSH_SYNC` on ev=
ery
op, decompression included, which
  `rte_compressdev.h` currently contradicts.
* Reject a UDC-checksum xform with no dictionary, or one under four bytes, =
in
`zlib_set_stream_parameters()`, so the
  error shows at setup rather than on every op.

The unchecked read was introduced with the feature, so the tag is
`Fixes: 0dc314debb22 ("compress/zlib: support dictionaries and PDCP
checksum")`.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
