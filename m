Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F5606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA147400D7;
	Tue, 27 Oct 2026 17:25:01 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id EE46A400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:25:00 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DF9D14D101; Tue, 27 Oct 2026 17:25:00 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2086] node: udp4_input ignores IHL and frame length
 when reading UDP port
Date: Tue, 27 Oct 2026 16:25:00 +0000
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
Message-ID: <bug-2086-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2086

            Bug ID: 2086
           Summary: node: udp4_input ignores IHL and frame length when
                    reading UDP port
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

Created attachment 433
  --> https://bugs.dpdk.org/attachment.cgi?id=3D433&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-51ZTOR1Y  [NOT SECURITY: ordinary bug]
node: udp4_input ignores IHL and frame length when reading UDP port
Location: lib/node/udp4_input.c:177  in udp4_input_node_process_scalar()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


The `udp4_input` graph node reads the UDP destination port at a fixed frame
offset (36) instead of locating the UDP header through the IPv4 header leng=
th,
so some datagrams are handed to the wrong user node or dropped. A UDP datag=
ram
that carries IPv4 options is dispatched on two option bytes rather than its
real destination port. An IPv4 frame with protocol 17 that is too short to =
hold
a UDP header is dispatched on padding or on bytes left in the mbuf by an
earlier packet. Nothing is read outside the mbuf data room and nothing cras=
hes;
the effect is misdelivery and loss of datagrams.

The read is in `udp4_input_node_process_scalar()` in `lib/node/udp4_input.c`
(around line 177), which checks neither the IHL field nor `data_len`. The n=
odes
in front of it do not guard against this either. `pkt_cls` deliberately rou=
tes
`L3_IPV4_EXT` packets to `ip4_lookup`, and `ip4_local` only checks that the
packet type is `L4_UDP`, which `rte_net_get_ptype()` sets from the IPv4
protocol field alone. This affects applications that build `ethdev_rx ->
pkt_cls -> ip4_lookup -> ip4_local -> udp4_input` and register a node with
`rte_node_udp4_usr_node_add()` / `rte_node_udp4_dst_port_add()`; no special
options are needed. With a node registered for port 5000, the attached
reproducer (a clang build fed through `net_pcap`) shows two cases:

- A datagram to unregistered port 5001 is dropped as expected, but the same
datagram with a 4-byte Router Alert option of value 5000 is delivered to the
port 5000 node.
- A 34-byte frame with no UDP header is dropped on a fresh mempool, but is
delivered to the port 5000 node after a burst of ordinary port 5000 traffic=
 has
passed through the pool.

In practice users would mostly see datagrams with IPv4 options to a registe=
red
port silently dropped. A separate defect on the next lines, where
`rte_hash_lookup_data()` stores a `void *` into the 2-byte `udplookup_node`,
makes gcc builds with a stack protector abort on every registered-port hit.=
 The
attached patch fixes both.

This is an ordinary bug, not a security issue: the misread bytes only decide
whether a datagram is dropped or handed
to a registered UDP node, which any sender can reach anyway by addressing t=
he
registered port; nothing is read
outside the mbuf, nothing crashes and nothing is returned to the sender.

## Details

`udp4_input` takes the UDP destination port of every packet from frame offs=
et
36 (Ethernet 14 + IPv4 20 + 2).
It reads neither the IHL field nor the length of the frame, so for IPv4 with
options, and for frames that end before
offset 38, the port it looks up is not the UDP destination port.
`lib/node/udp4_input.c:176-181`:

```c
                mbuf =3D (struct rte_mbuf *)objs[i];
                pkt_udp_hdr =3D rte_pktmbuf_mtod_offset(mbuf, struct rte_ud=
p_hdr
*,
                                                sizeof(struct rte_ether_hdr=
) +
                                                sizeof(struct rte_ipv4_hdr)=
);

                key_port.prt_dst =3D rte_cpu_to_be_16(pkt_udp_hdr->dst_port=
);
```

With a user node registered for port 5000 and nothing registered for 5001, =
this
51-byte frame is handed to the
port 5000 node although its UDP destination port is 5001 (commit 9a45341f18=
a1,
26.11-rc1):

```
offset  0  02 00 00 00 00 02 02 00 00 00 00 01 08 00=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Ethernet
offset 14  46 00 00 25 00 01 00 00 40 11 06 39 c0 00 02 01 0a 00 00 01=20=
=20=20=20
IPv4, IHL 6, protocol 17
offset 34  94 04 13 88=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
Router Alert option, value 0x1388 =3D 5000
offset 38  9c 40 13 89 00 0d 00 00 68 65 6c 6c 6f                          =
UDP
40000 -> 5001, "hello"
```

Offset 36, where the node reads, is the 16-bit value of the option. The same
datagram without the option is dropped.

The nodes in front of `udp4_input` do not make the fixed offset true:

* `pkt_cls` sends IPv4 with options to `ip4_lookup` on purpose: `p_nxt[]` h=
as
entries for `RTE_PTYPE_L3_IPV4_EXT`
  and `RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L2_ETHER` (`lib/node/pkt_cls.c:18`,
`:25`).
* `ip4_lookup` reads the destination address, checksum and TTL at fixed off=
sets
and nothing else
  (`lib/node/ip4_lookup.c:81-88`, same fields in `ip4_lookup_sse.h`). A /32
route added with
  `RTE_NODE_IP4_LOOKUP_NEXT_IP4_LOCAL` sends the packet to `ip4_local`.
* `ip4_local` only tests `(mbuf->packet_type & RTE_PTYPE_L4_MASK) =3D=3D
RTE_PTYPE_L4_UDP`
  (`lib/node/ip4_local.c:44-48`). That keeps fragments out, but says nothing
about where the UDP header is or whether
  one was received: `rte_net_get_ptype()` sets `RTE_PTYPE_L4_UDP` from the =
IPv4
protocol field
  (`lib/net/rte_net.c:433-434`) and for UDP only records `l4_len` (`:469-47=
0`).

**IPv4 options.** For the frame above `rte_net_get_ptype()` returns `L2_ETH=
ER |
L3_IPV4_EXT | L4_UDP`, all three
nodes pass it on, and `udp4_input` looks up 5000 and enqueues the mbuf to t=
he
user node. The reverse also holds:
a datagram that is addressed to port 5000 and carries a Router Alert option
with value 0 is looked up under 0 and
dropped.

**Short frames.** A 34-byte frame (Ethernet + IPv4 header with protocol 17,
nothing after it) has `data_len` 34;
the node reads bytes 36-37. They are inside the mbuf data room, so ASan and
UBSan report nothing; they hold whatever
the previous user of that mbuf received. After one burst of ordinary datagr=
ams
to port 5000 has gone through the pool,
the 34-byte frame is handed to the port 5000 node; sent to a fresh pool, the
same frame is dropped. On Ethernet, where
frames are padded to 60 bytes, no earlier packet is needed: for a 60-byte f=
rame
whose IPv4 total length is 20, bytes
36-37 are the frame's own padding, and padding of 0x1388 sends it to the po=
rt
5000 node. The node behind the edge is
given a "UDP datagram" that has no UDP header, selected by padding or by by=
tes
of another packet.

One thing stands in the way of seeing this on the prebuilt trees. A few lin=
es
further down
(`lib/node/udp4_input.c:182-184`) `rte_hash_lookup_data()` stores a `void *`
through `(void **)&udplookup_node`,
a 2-byte `rte_edge_t`. In `/src/build` (gcc) every lookup hit ends in `***
stack smashing detected ***`, and in
`/src/build-asan` in a `stack-buffer-overflow` report at line 182, so no
datagram is ever delivered there, ordinary
ones included. A clang build with default options survives the store and sh=
ows
the behaviour described here. With
that store changed to go through a `void *` temporary and nothing else, a g=
cc
ASan+UBSan build gives the same
results and no sanitizer output.

## Impact

Affected: applications that feed `ethdev_rx -> pkt_cls -> ip4_lookup ->
ip4_local -> udp4_input` and register a
node with `rte_node_udp4_usr_node_add()` / `rte_node_udp4_dst_port_add()`. =
No
offloads or devargs are needed and the
default build is affected. The API is experimental and has no caller in `ap=
p/`
or `examples/`.

UDP datagrams that carry IPv4 options are dispatched on two option bytes
instead of their destination port. A
datagram addressed to a registered port is normally dropped (the option val=
ue
does not match), and a datagram to an
unregistered port is handed to a registered node when the option value happ=
ens
to equal that node's port. A user
node that uses the same fixed offsets as the library then treats the option
bytes and the real UDP header as its UDP
header and payload. UDP with IPv4 options (Router Alert being the usual one=
) is
uncommon, so most applications would
see this as occasional unexplained loss of such datagrams.

IPv4 packets with protocol 17 that end before a complete UDP header are
dispatched on bytes that are not a UDP
header: the Ethernet padding of the frame itself, or, on a port that passes
frames shorter than 38 bytes (as
`net_pcap` does), stale bytes of an earlier packet in the same mbuf. Depend=
ing
on those bytes the frame is dropped or
given to a user node, which then reads a UDP length and payload that were n=
ever
received. Such frames only come from
broken or deliberately malformed senders.

There is no memory corruption in DPDK itself: the over-read is 2 bytes and
stays inside the data room. The
consequence is misdelivery and loss of datagrams, not a crash.

## Reproducing

`repro` builds DPDK from `/src` with clang into `/root/dpdk-build-clang`
(project default options, `platform=3Dgeneric`,
only the libraries and drivers the graph nodes and `net_pcap` need), compil=
es a
small graph application against it,
and runs that application four times, each time on one capture fed through
`net_pcap`. It takes about 70 seconds on
2 CPUs, nearly all of it the build, and is deterministic.

The prebuilt trees are not used: in `/src/build` and `/src/build-asan`
`udp4_input` aborts on every port lookup hit
(`rte_hash_lookup_data()` stores a `void *` into the 2-byte `udplookup_node=
`, a
separate defect), so nothing is ever
delivered there. The clang build survives that store and shows the behaviour
reported here.

Files:

* `repro` (setup and verdict): the build, the four runs, the check.
* `repro.d/udp_service.c` (the application developer's part): a UDP service=
 on
  `ethdev_rx -> pkt_cls -> ip4_lookup -> ip4_local -> udp4_input ->
udp_service`, set up as the `udp4_input` section
  of `doc/guides/prog_guide/graph_lib.rst` describes:
`rte_node_udp4_usr_node_add()`, a /32 route to `ip4_local`
  for 10.0.0.1, `rte_node_udp4_dst_port_add(5000, edge)`. Its node locates =
the
UDP header through the IHL field and
  counts the frames it was given (`served`), those whose UDP destination po=
rt
is not 5000
  (`served_for_another_port`) and those too short to hold a UDP header
(`served_without_udp_header`). `net_pcap`
  does not set `mbuf->packet_type`, which `ip4_local` needs, so an Rx callb=
ack
fills it with `rte_net_get_ptype()`,
  as a NIC would.
* `repro.d/make_sender_pcaps.py` (the remote sender's part): writes four
captures:
  - `closed_port.pcap`: one UDP datagram to 10.0.0.1 port 5001 (control);
  - `closed_port_with_option.pcap`: the same datagram with a 4-byte Router
Alert IPv4 option whose value is 5000,
    which puts 5000 at frame offset 36;
  - `no_udp_header.pcap`: a 34-byte frame, Ethernet plus an IPv4 header with
protocol 17 and nothing after it
    (control);
  - `open_port_x256_then_no_udp_header.pcap`: 256 ordinary datagrams to port
5000 (one graph Rx burst), then the
    34-byte frame, which therefore arrives in an mbuf one of them has used.

Expected output on commit 9a45341f18a1:

```
CONTROL  datagram to port 5001                                 received=3D1
served=3D0 served_for_another_port=3D0 served_without_udp_header=3D0
OBSERVED same datagram with an IPv4 option of value 5000       received=3D1
served=3D1 served_for_another_port=3D1 served_without_udp_header=3D0
CONTROL  34-byte frame without UDP header                      received=3D1
served=3D0 served_for_another_port=3D0 served_without_udp_header=3D0
OBSERVED 256 datagrams to port 5000, then the same frame       received=3D2=
57
served=3D257 served_for_another_port=3D0 served_without_udp_header=3D1
datagram to port 5001 served because of its IPv4 option: True
frame without UDP header served because of an earlier packet's bytes: True
BUG
```

`BUG` is printed when the datagram to 5001 is dropped without the option and
given to the port 5000 service with
it, or when the lone 34-byte frame is dropped but, after the 256 datagrams,=
 is
given to the service (257 served, one
without a UDP header). With the attached patch (which also takes the
`udplookup_node` store through a `void *`
temporary), the same script prints `served=3D0` for the option datagram,
`served=3D256` for the last capture, and `OK`.

## Suggested fix

The attached patch changes `lib/node/udp4_input.c` only. It adds
`udp4_input_udp_hdr_get()`, an always-inline
helper that locates the UDP header through the IHL field and returns NULL w=
hen
IHL is below 5, when the IPv4
`total_length` does not cover the UDP header, or when the first segment is
shorter than Ethernet + IHL + 8.
`udp4_input_node_process_scalar()` calls it where it used the fixed offset =
and
sends packets without a complete UDP
header to `pkt_drop` instead of looking them up. The `total_length` compari=
son
also rejects frames that are padded
beyond an IPv4 packet ending before the UDP header. This is the only place =
in
`lib/node` that reads past the base
IPv4 header, so no other node needs the same change.

The patch also fixes the `udplookup_node` store at line 184, the separate
defect that makes the prebuilt trees abort:
the `rte_hash_lookup_data()` result is taken through a `void *` temporary a=
nd
cast to `rte_edge_t`, the same way
`rte_node_udp4_dst_port_add()` stores it. The parsing change cannot go in
without it: applied alone to a clang
build, it moves that 8-byte store onto other stack slots and the burst of 2=
56
datagrams to port 5000 segfaults in
`rte_node_enqueue_x1()`. The two changes are best committed as a two-patch
series, the store fix first, each with
`Fixes: 51a3c7a1a9a5 ("node: add IPv4 UDP")`, `Cc: stable@dpdk.org`.

One behaviour change belongs in the commit message: datagrams to a register=
ed
port that carry IPv4 options are now
delivered to the user node instead of dropped, so user nodes must locate the
UDP header through the IPv4 header
length themselves.

With the patch, a clang build and a gcc ASan+UBSan build drop the datagram =
with
the option and the 34-byte frame,
serve the 256 ordinary datagrams, serve a datagram to port 5000 that carrie=
s an
option, and produce no sanitizer
output. No unit test is included: `app/test` has no graph-node data path te=
sts.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
