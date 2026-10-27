Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE8606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 311B0400D7;
	Tue, 27 Oct 2026 17:19:04 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 174E4400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:19:03 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EBA474D42E; Tue, 27 Oct 2026 17:19:02 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2083] net/pcap: scattered Rx truncates length to 16
 bits and crashes Tx
Date: Tue, 27 Oct 2026 16:19:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-2083-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2083

            Bug ID: 2083
           Summary: net/pcap: scattered Rx truncates length to 16 bits and
                    crashes Tx
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 431
  --> https://bugs.dpdk.org/attachment.cgi?id=3D431&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-VD4V3KPV  [NOT SECURITY: ordinary bug]
net/pcap: scattered Rx truncates length to 16 bits and crashes Tx
Location: drivers/net/pcap/pcap_ethdev.c:230  in eth_pcap_rx_jumbo()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


When `net_pcap` receives a capture record longer than 65535 bytes with Rx
scatter enabled, it builds an mbuf whose `pkt_len` is larger than the data
actually in its segment chain. The first code that walks the chain by `pkt_=
len`
then follows a NULL `next` pointer and the process dies with SIGSEGV. In
testpmd this happens in `io` forwarding to `tx_pcap`, in `rte_pktmbuf_read(=
)`
called from `eth_pcap_tx_dumper()`.

The cause is a width mismatch in `drivers/net/pcap/pcap_ethdev.c`.
`eth_pcap_rx()` holds the 32-bit `caplen` and stores all of it in `pkt_len`,
but passes it to `eth_pcap_rx_jumbo()` through a `uint16_t data_len`. A
68536-byte record therefore becomes a 2-segment chain holding 3000 bytes,
reported as `length=3D68536`. The crash happens whenever the chain ends up
holding fewer bytes than `min(pkt_len, snaplen)`:

- With testpmd's default mbufs, 67584 and 68536 bytes crash.
- 131072 and 262144 bytes do not crash with the default `snaplen`.

No out-of-bounds read or write was found; the failure is the NULL dereferen=
ce.
Such records are unusual. They come from a capture file with records above
about 64 KiB, or from live capture on a loopback interface whose MTU was
raised. On normal interfaces, libpcap's capture ring keeps frames below the
threshold.

At this commit the port must have `RTE_ETH_RX_OFFLOAD_SCATTER` enabled. From
v24.11 to v26.03, including the 24.11 and 25.11 LTS releases, the multi-seg=
ment
path was taken without any offload flag, so no setting is needed there.
`pkt_len` has carried the untruncated value since f5ead8f84f20 ("net/pcap: =
fix
blocking Rx").

The attached reproducer replays a one-frame pcap through testpmd with
`--enable-scatter` and crashes deterministically. A patch that widens the
parameter to 32 bits and caps the chain at `RTE_MBUF_MAX_NB_SEGS` is includ=
ed.

## Details

This is an ordinary bug, not a security issue: the oversized record comes f=
rom
the capture file the operator names
in `rx_pcap=3D` (or from a loopback interface whose MTU the operator raised=
), and
the result is a NULL-dereference crash
of the process replaying it, with no out-of-bounds read or write.

A record longer than 65535 bytes in an `rx_pcap` file, received by a `net_p=
cap`
port with the Rx scatter offload
enabled, leaves `eth_pcap_rx()` as an mbuf whose `pkt_len` is the full capt=
ured
length while its segment chain holds
only `caplen % 65536` bytes. The next code that walks the chain by `pkt_len`
follows a NULL `next` pointer.

Seen at commit 9a45341f18 (26.11-rc1) with a classic pcap file holding one
68536-byte Ethernet frame (65536 + 3000):

```
dpdk-testpmd -l 0-1 --no-huge -m 512 --no-pci \
    --vdev net_pcap0,rx_pcap=3Doversized.pcap,tx_pcap=3Dforwarded.pcap -- \
    -i --total-num-mbufs=3D4096 --enable-scatter --no-flush-rx --forward-mo=
de=3Dio
testpmd> set verbose 1
testpmd> start
```

With `--forward-mode=3Drxonly` the frame is reported as `length=3D68536 -
nb_segs=3D2`; two default testpmd mbufs
(2176-byte data room) hold at most 4352 bytes. In `io` mode
`/src/build-asan/app/dpdk-testpmd` stops with:

```
ERROR: AddressSanitizer: SEGV on unknown address 0x000000000028
The signal is caused by a READ memory access.
    #0 __rte_pktmbuf_read   lib/mbuf/rte_mbuf.c:811:14
    #1 rte_pktmbuf_read     lib/mbuf/rte_mbuf.h:1844:10
    #2 eth_pcap_tx_dumper   drivers/net/pcap/pcap_ethdev.c:560:10
    #3 rte_eth_tx_burst     lib/ethdev/rte_ethdev.h:6565:12
    #4 common_fwd_stream_transmit app/test-pmd/testpmd.h:945:10
```

The default gcc build (`/src/build/app/dpdk-testpmd`) dies with SIGSEGV on =
the
same input. A 65535-byte frame is
received as 31 segments and written to `tx_pcap` unchanged.

The cause is a width mismatch between `eth_pcap_rx()` and its helper. The
caller keeps the captured length in 32 bits
and stores all of it in `pkt_len`; the helper that builds the chain takes i=
t as
16 bits:

```c
/* drivers/net/pcap/pcap_ethdev.c:228 */
static int
eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
                const u_char *data, uint16_t data_len)          /* 16 bits =
*/
{
        /* Copy the first segment. */
        uint16_t len =3D rte_pktmbuf_tailroom(mbuf);
        =E2=80=A6
        data_len -=3D len;
        =E2=80=A6
        while (data_len > 0) {

/* drivers/net/pcap/pcap_ethdev.c:389 */
                uint32_t len =3D header->caplen;                    /* 32 b=
its */
                if (len <=3D rte_pktmbuf_tailroom(mbuf)) {
                        =E2=80=A6
                } else if (pcap_q->rx_scatter) {
                        if (unlikely(eth_pcap_rx_jumbo(pcap_q->mb_pool,
                                                       mbuf, packet, len) =
=3D=3D
-1)) {
                =E2=80=A6
                mbuf->pkt_len =3D len;                              /* line=
 409:
full value */
```

For the 68536-byte record, `data_len` arrives as 3000. The first mbuf takes=
 its
2048 bytes of tailroom, a second mbuf
takes the remaining 952, and the loop ends. `pkt_len` is then set to 68536.

Nothing limits `caplen` to 16 bits before this point. The `rx_pcap` handle
comes from
`pcap_open_offline_with_tstamp_precision()` (`open_single_rx_pcap()`, line
806), to which the `snaplen` devarg is not
applied, so the record length is bounded only by the capture file; a
262144-byte record (the value of
`ETH_PCAP_MAXIMUM_SNAPLEN`, line 51) is handed to the driver.

Which lengths go wrong: write `caplen =3D k * 65536 + r`. If `r` is at leas=
t the
first mbuf's tailroom, the chain holds
`r` bytes. If `r` is smaller, the first-segment copy still takes a full
tailroom, `data_len -=3D len` wraps, and the
chain ends up holding `65536 + r` bytes. The chain therefore matches `pkt_l=
en`
only below 65536 + tailroom. With the
2048-byte tailroom above, 67583 bytes is received correctly (32 segments),
67584 gives `nb_segs=3D1`, and 131072 and
262144 both give 31 segments. The helper never copies more than `caplen` by=
tes,
so the libpcap buffer is not over-read
and no mbuf is overrun; the defect is the short chain.

The short chain is fatal in the driver's own Tx path:

```c
/* drivers/net/pcap/pcap_ethdev.c:554 */
                len =3D rte_pktmbuf_pkt_len(mbuf);
                caplen =3D RTE_MIN(len, snaplen);                   /* 6553=
5 */
                =E2=80=A6
                data =3D rte_pktmbuf_read(mbuf, 0, caplen, temp_data);

                /* This could only happen if mbuf is bogus pkt_len > data_l=
en
*/
                RTE_ASSERT(data !=3D NULL);
```

`__rte_pktmbuf_read()` (`lib/mbuf/rte_mbuf.c:792`) accepts the request beca=
use
`off + len <=3D pkt_len`, copies the two
real segments, still has 62535 bytes to go, and reads `seg->data_len` throu=
gh
the NULL `seg->next` at line 811. It does
not return NULL for this mbuf, so the `RTE_ASSERT` would not catch it in a
debug build either. By the same reading
(not run), `rte_pktmbuf_copy()` (`lib/mbuf/rte_mbuf.c:668`) advances `seg =
=3D
seg->next` under the same `pkt_len`
bound, and `eth_pcap_tx()` (`tx_iface`, line 663) makes the same
`rte_pktmbuf_read()` call for a frame that passes its
multi-segment `len > snaplen` check.

The read is capped at `snaplen`, so the Tx path crashes only when the chain
holds fewer bytes than
`min(pkt_len, snaplen)`. With the default `snaplen` of 65535, the 131072- a=
nd
262144-byte records (31 segments,
65536 bytes) are forwarded without a crash; 67584 and 68536 bytes crash.

History: `pkt_len` has carried the untruncated value since f5ead8f84f20
("net/pcap: fix blocking Rx", first released
in v24.11), which dropped the `(uint16_t)` cast on `pkt_len` but left the
helper's parameter alone. Until f28abe77f516
("net/pcap: add Rx scatter offload", v26.07) the multi-segment path was tak=
en
for every frame larger than the first
mbuf, without an offload flag, so from v24.11 to v26.03 (including the 24.11
and 25.11 long-term releases) the bug
needs no Rx scatter setting. Only the commit above was run.

## Impact

An application replaying a capture through `net_pcap` crashes with SIGSEGV =
when
the capture holds a record of 65536
bytes plus the first mbuf's tailroom or more (67584 with testpmd's default
mbufs) whose chain ends up shorter than
`min(pkt_len, snaplen)` (most such lengths, not 131072 or 262144 with the
default `snaplen`) and the packet reaches code that
walks the chain by `pkt_len` (the driver's `tx_pcap` path in the run above;
`rxonly` forwarding does not crash). It is
a NULL dereference; no out-of-bounds read or write was found. At this commit
the port must also have
`RTE_ETH_RX_OFFLOAD_SCATTER` enabled (off by default); on v24.11 to v26.03 =
it
need not.

Users meet it rarely: captures of Ethernet traffic do not contain records t=
his
long, so it takes a capture with
records above about 64 KiB, such as one taken on a loopback interface with a
raised MTU. Live capture (`rx_iface`,
`iface`) is not protected by the `snaplen` devarg: the Rx handle opened at
probe time is given snaplen 0, which
libpcap treats as its 262144 maximum, and a 68536-byte frame on loopback wi=
th
the MTU raised to 200000 crashes testpmd
the same way. On normal interfaces libpcap's capture ring limits a frame to
about max(MTU, 65535) + 18 bytes, below
the threshold; a veth peer sending large TCP segments was captured at 65562
bytes at most (libpcap 1.10.6, Linux 6.1).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
