Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA31606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFE1400D7;
	Tue, 27 Oct 2026 17:14:30 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 73273400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:14:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 664AD4D34F; Tue, 27 Oct 2026 17:14:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2082] net/pcap: Rx timestamp overwrites mbuf
 buf_addr in secondary process
Date: Tue, 27 Oct 2026 16:14:28 +0000
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
Message-ID: <bug-2082-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2082

            Bug ID: 2082
           Summary: net/pcap: Rx timestamp overwrites mbuf buf_addr in
                    secondary process
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

Created attachment 430
  --> https://bugs.dpdk.org/attachment.cgi?id=3D430&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-80N5ICNL  [NOT SECURITY: ordinary bug]
net/pcap: Rx timestamp overwrites mbuf buf_addr in secondary process
Location: drivers/net/pcap/pcap_ethdev.c:423  in eth_pcap_rx()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Since v26.07, a DPDK secondary process that receives on a net_pcap port with
the Rx timestamp offload enabled crashes on the first packets it receives. =
In
the secondary, `eth_pcap_rx()` writes the 64-bit timestamp one byte before =
each
mbuf instead of into the timestamp dynamic field. This overwrites the low s=
even
bytes of `buf_addr`, so the next read or write of that mbuf's packet data g=
oes
to `timestamp >> 8`.

The cause is that `timestamp_dynfield_offset` and `timestamp_rx_dynflag` in
`drivers/net/pcap/pcap_ethdev.c` are per-process statics, starting at -1 an=
d 0.
They are only filled in by `eth_dev_configure()`, which runs in the primary.
The `timestamp_offloading` switch, by contrast, is copied into `struct
pcap_rx_queue` in shared `dev_private`. A secondary therefore sees the
primary's `true` and its own offset of -1.

This is a regression from 32fd14bf07f8 ("net/pcap: support nanosecond times=
tamp
precision"). Before that commit the field was registered in `pmd_pcap_probe=
()`
in every process. Only v26.07 and 26.11-rc1 are affected; 25.11 and earlier=
 are
not.

The attached reproducer runs a primary `dpdk-testpmd` with
`--enable-rx-timestamp` on an `rx_pcap=3D` port and an rxonly secondary. The
secondary segfaults on its second Rx burst, writing at the capture's timest=
amp
`>> 8` plus the 128-byte headroom, in the `rte_memcpy()` at line 392. Witho=
ut
the offload, the same pair runs cleanly. A live `iface=3D` port fails the s=
ame
way on ordinary traffic. If a capture timestamp happens to decode to a mapp=
ed
address, the next frame is silently written there instead of crashing.
Single-process applications and Tx-only secondaries are not affected.

A patch is attached. It moves the offset and flag into `pmd_internals` and =
the
Rx queue, alongside `timestamp_offloading`.

This is an ordinary regression, not a security issue: it fires on every pac=
ket
a secondary receives with the offload on,
whatever the packet contains, so the affected configuration has not worked =
at
all since v26.07, and nobody who can send
traffic or supply a capture gets anything beyond what the first ordinary pa=
cket
already does.

## Details

In a secondary process, `eth_pcap_rx()` stores the Rx timestamp at `(char
*)mbuf - 1` instead of in the timestamp dynamic
field. The 8-byte store replaces the low seven bytes of `mbuf->buf_addr` wi=
th
the timestamp.

Shown with two `dpdk-testpmd` processes from the ASan build and a capture f=
ile
whose 64 records all carry the timestamp
`0x414141414100 << 8` ns:

```
primary:    dpdk-testpmd -l 0-1 --no-pci --proc-type=3Dprimary --vdev
net_pcap0,rx_pcap=3Din.pcap \
                -- -i --total-num-mbufs=3D4096 --enable-rx-timestamp
secondary:  dpdk-testpmd -l 0-1 --no-pci --proc-type=3Dsecondary -- -i
--forward-mode=3Drxonly --no-flush-rx
            testpmd> start
```

(The reproducer adds `--file-prefix`, `--huge-dir` and, for ASan,
`--base-virtaddr` to both.)
The secondary dies in its second Rx burst with an ASan `SEGV on unknown add=
ress
0x414141414180`, a WRITE, in the
`rte_memcpy()` at `drivers/net/pcap/pcap_ethdev.c:392`. That address is the
timestamp shifted right by 8, plus the 128 bytes
of headroom. Without `--enable-rx-timestamp` the same pair receives the 64
frames and exits normally. The default (gcc,
non-ASan) build behaves the same way: the kernel logs `segfault at
414141414180`.

The offset and the flag of the dynamic field are static variables, so every
process has its own copy, and the copy starts
at -1:

```c
/* drivers/net/pcap/pcap_ethdev.c:63 */
static uint64_t timestamp_rx_dynflag;
static int timestamp_dynfield_offset =3D -1;
```

The only place that fills them in is `eth_dev_configure()`. The port is
configured by the primary; a secondary attaches
to it and never runs this code:

```c
/* drivers/net/pcap/pcap_ethdev.c:1028 */
        internals->timestamp_offloading =3D !!(rxmode->offloads &
RTE_ETH_RX_OFFLOAD_TIMESTAMP);

        if (internals->timestamp_offloading && timestamp_rx_dynflag =3D=3D =
0) {
                int ret =3D
rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
&timestamp_rx_dynflag);
```

The switch that enables the store is not per process. `eth_rx_queue_setup()`
copies it into the Rx queue
(`pcap_q->timestamp_offloading =3D internals->timestamp_offloading`, line 1=
253),
and `struct pcap_rx_queue` is part of
`dev_private`, which is shared memory. The secondary branch of
`pmd_pcap_probe()` (lines 2061-2096) attaches to the port
and installs `eth_pcap_rx` as `rx_pkt_burst` (line 2088) without touching t=
he
two statics. So the Rx function in a
secondary sees the primary's `true` and its own -1:

```c
/* drivers/net/pcap/pcap_ethdev.c:414 */
                if (pcap_q->timestamp_offloading) {                      /*
shared: set by the primary */
                        =E2=80=A6
                        uint64_t ns =3D (uint64_t)header->ts.tv_sec *
NSEC_PER_SEC
                                +  header->ts.tv_usec;

                        *RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,=
  /*
per process: still -1 */
                                           rte_mbuf_timestamp_t *) =3D ns;

                        mbuf->ol_flags |=3D timestamp_rx_dynflag;          =
    /*
per process: still 0 */
```

`RTE_MBUF_DYNFIELD(m, offset, type)` is `(type)((uintptr_t)(m) + (offset))`
(`lib/mbuf/rte_mbuf_dyn.h:228`) and `buf_addr`
is the first member of `struct rte_mbuf`. The low byte of `ns` lands in the
last byte of the
`struct rte_mempool_objhdr` in front of the mbuf (the top byte of its `iova=
`).
The other seven bytes become bytes 0-6 of
`buf_addr`; its top byte is zero already, so `buf_addr =3D=3D ns >> 8`.

Nothing resets `buf_addr` when a direct mbuf is freed and allocated again (=
it
is set once, in `rte_pktmbuf_init()`), so the
damage stays with the mbuf in the shared pool. In the example, burst 1 rece=
ives
32 frames: each is copied into a good
mbuf at line 392 and then the store at line 423 sets that mbuf's `buf_addr`=
 to
`0x414141414100`. `rxonly` frees the
32 mbufs, burst 2 gets them back from the lcore cache, and the copy at line=
 392
now writes the next frame to
`0x414141414100 + RTE_PKTMBUF_HEADROOM`. An application that looks at the
packet does not get that far: with
`set verbose 1` in the secondary, testpmd faults on the first burst, reading
the Ethernet header at `0x41414141418c`.

This is a regression from 32fd14bf07f8 ("net/pcap: support nanosecond times=
tamp
precision"), first released in
v26.07. Before it, `pmd_pcap_probe()` registered the field ahead of the
primary/secondary branch, in every process, so
only v26.07 and 26.11-rc1 are affected; 25.11 and earlier are not.

## Impact

Anyone who receives on a net_pcap port from a secondary process with the Rx
timestamp offload on hits this, on the first
packets, every time: since v26.07 that combination does not work. The
configuration is a supported one
(`Multiprocess aware =3D Y` in `doc/guides/nics/features/pcap.ini`) but nee=
ds two
non-default choices: the primary enables
`RTE_ETH_RX_OFFLOAD_TIMESTAMP` on a net_pcap port, and a secondary process
calls `rte_eth_rx_burst()` on it. Every packet
received that way leaves one mbuf of the shared pool with a wrong `buf_addr=
`,
whatever the packet contains.

* Live interface (`iface=3D`, `rx_iface=3D`): the timestamp is the kernel's
wall-clock time, which today gives a non-canonical
  address. The secondary crashes when the application first reads packet da=
ta,
or when the driver first reuses an mbuf.
  With `iface=3Dlo` and the testpmd pair above, three UDP datagrams sent to
127.0.0.1 end the secondary with a SEGV in the
  same `rte_memcpy()`.
* Capture file (`rx_pcap=3D`): the record timestamp selects the address and=
 the
following frame supplies the bytes. A
  capture with ordinary timestamps crashes the secondary the same way (a 20=
26
timestamp faults at `0x18e2040019a2cd`).
  A timestamp that happens to decode to a mapped address gives no crash: the
next frame is silently copied there,
  corrupting whatever that memory holds.

A single-process application is not affected (the same capture with the same
offload in one testpmd process is received
with the correct timestamp on all 64 packets), nor is a secondary that only
transmits.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
