Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799E606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BF2400D7;
	Tue, 27 Oct 2026 17:03:49 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 4135A400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:03:48 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 354834D4DB; Tue, 27 Oct 2026 17:03:48 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2078] ip_frag: reassembled IPv4 total length wraps
 if only first fragment has options
Date: Tue, 27 Oct 2026 16:03:48 +0000
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
Message-ID: <bug-2078-3@https.bugs.dpdk.org/>
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
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2078

            Bug ID: 2078
           Summary: ip_frag: reassembled IPv4 total length wraps if only
                    first fragment has options
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

Created attachment 426
  --> https://bugs.dpdk.org/attachment.cgi?id=3D426&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-DWBZBYAG  [NOT SECURITY: ordinary bug]
ip_frag: reassembled IPv4 total length wraps if only first fragment has opt=
ions
Location: lib/ip_frag/rte_ipv4_reassembly.c:73  in ipv4_frag_reassemble()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


`rte_ipv4_frag_reassemble_packet()` can return a reassembled IPv4 datagram =
of
up to 65575 bytes whose `total_length` has wrapped to a value between 0 and=
 39,
instead of dropping it as oversized. This happens when the first fragment
carries IP options that the later fragments do not repeat, which is how
`rte_ipv4_fragment_packet()` itself fragments a datagram with non-copied
options, and the datagram is within 40 bytes of the 65535-byte maximum. The
application must also set `l3_len` from the IHL field, as the API documenta=
tion
asks. The in-tree callers (`examples/ip_reassembly`, `ipsec-secgw`, `lib/no=
de`)
hard-code `l3_len =3D 20` and do not hit it.

The size check added by commit 23fd984a5a6b ("ip_frag: reject oversized
reassembled datagrams") at `lib/ip_frag/rte_ipv4_reassembly.c:145` tests
`offset + length + l3_len` using the header length of the fragment that is
arriving. `ipv4_frag_reassemble()` then writes `total_length` as
`(uint16_t)(total_size + l3_len)` using the first fragment's header length,
which can be up to 40 bytes larger, so the sum wraps. There is no out-of-bo=
unds
access and an ASan/UBSan build reports nothing. The effect is a header that
contradicts the mbuf, and any receiver will drop the packet if it is forwar=
ded.
The attached reproducer sends three 8-fragment datagrams through `net_pcap`=
 on
the default build at 9a45341f18a1. The two control datagrams behave correct=
ly.
The third, with options only in the first fragment, is forwarded as 65575 b=
ytes
of IP with `total_length` 39. A patch that repeats the check in
`ipv4_frag_reassemble()` against the first fragment's header length, plus a
unit test, is attached.

## Details

This is an ordinary bug, not a security issue: the only effect is one wrong
header field in the reassembled
packet, with no out-of-bounds access, crash, hang or leak, and the malformed
result gives the sender nothing a
bad packet sent directly would not.

`rte_ipv4_frag_reassemble_packet()` limits the reassembled datagram to 65535
bytes using the header length of
the fragment that is arriving, and `ipv4_frag_reassemble()` then writes
`total_length` using the header length
of the first fragment. When the first fragment has IP options and the later
ones do not, the limit passes and
the 16-bit `total_length` wraps.

Tested at commit 9a45341f18a1 (26.11-rc1) with the default build in
`/src/build`. Eight fragments of one
datagram, received through `net_pcap` by an application that takes
`l2_len`/`l3_len` from `rte_net_get_ptype()`:

| fragment | IHL | offset | payload | sum tested at `rte_ipv4_reassembly.c:=
145`
|
|---|---|---|---|---|
| first | 15 (40 bytes of NOP options) | 0 | 8192 | 0 + 8192 + 60 |
| 2 to 7 | 5 | 8192 =E2=80=A6 49152 | 8192 | at most 49152 + 8192 + 20 |
| last | 5 | 57344 | 8171 | 57344 + 8171 + 20 =3D 65535, accepted |

The library returns one mbuf chain holding 65575 bytes of IP (60 bytes of
header, 65515 of payload) whose
header says `total_length` 39. The application transmits it as it is. The s=
ame
payload without options comes
out as 65535 / 65535, and with the options in all eight fragments the last
fragment is dropped and nothing is
forwarded, so the limit works as long as every fragment has the same header
length.

The check on arrival, `lib/ip_frag/rte_ipv4_reassembly.c:126` and `:145`:

```c
        ip_len =3D rte_be_to_cpu_16(ip_hdr->total_length) - mb->l3_len;
        =E2=80=A6
        if (ip_len <=3D 0 || ip_ofs + ip_len + mb->l3_len > UINT16_MAX) {
                IP_FRAG_MBUF2DR(dr, mb);
                return NULL;
        }
```

`mb` is the fragment at hand. For the last fragment `ip_ofs + ip_len` is wh=
at
`ip_frag_process()` stores as the
size of the whole payload (`lib/ip_frag/ip_frag_internal.c:141`,
`fp->total_size =3D ofs + len`), so the test
amounts to `total_size + l3_len of the last fragment`.

Once all fragments are there, `lib/ip_frag/rte_ipv4_reassembly.c:67`:

```c
        m =3D fp->frags[IP_FIRST_FRAG_IDX].mb;
        =E2=80=A6
        ip_hdr->total_length =3D rte_cpu_to_be_16((uint16_t)(fp->total_size=
 +
                m->l3_len));
```

`m` is now the first fragment, whose header is the one the reassembled pack=
et
keeps. In the example
`total_size` is 65515 and `m->l3_len` is 60; the sum is 65575 and the cast
leaves 39. Nothing between the two
places compares `total_size` with the first fragment's header length.

The two header lengths differ in ordinary traffic. Only options of the "cop=
ied"
class are repeated in later
fragments, and `rte_ipv4_fragment_packet()` builds its fragments that way
(`__create_ipopt_frag_hdr()`,
`lib/ip_frag/rte_ipv4_fragmentation.c:44`, skips NOP and every option for w=
hich
`RTE_IPV4_HDR_OPT_COPIED()` is
false). The first fragment can therefore have up to 40 bytes more header th=
an
the fragment the check sees.

The check at `:145` was added by commit 23fd984a5a6b ("ip_frag: reject
oversized reassembled datagrams") to
prevent this outcome; its comment says "The total_length field is 16 bits, =
so
otherwise it is silently truncated
while the mbuf still holds the full length". This is the case that change d=
oes
not cover.

The application has to set `l3_len` from the IHL field, which is what the A=
PI
asks for ("Incoming mbufs should
have its l2_len/l3_len fields setup correctly",
`lib/ip_frag/rte_ip_frag.h:216`). The in-tree callers
(`examples/ip_reassembly/main.c:340`,
`examples/ipsec-secgw/ipsec-secgw.c:2299`, `lib/node/ip4_reassembly.c:84`)
set `l3_len` to `sizeof(struct rte_ipv4_hdr)` for every fragment and do not
reach the wrap. IPv6 is not
affected: `rte_ipv6_frag_reassemble_packet()` tests `ip_ofs + ip_len` alone=
 and
`ipv6_frag_reassemble()` writes
the same quantity.

## Impact

An application that reassembles IPv4 with `l3_len` taken from the packet's =
IHL
(`rte_net_get_ptype()`,
`rte_ipv4_hdr_len()`), as the API asks, receives from
`rte_ipv4_frag_reassemble_packet()` a packet of up to
65575 bytes whose `total_length`, written by DPDK, is between 0 and 39 and
always smaller than the packet's own
header length, instead of having the oversized datagram dropped. It happens
only for a datagram within 40 bytes
of the 65535-byte maximum whose first fragment carries IP options the later
fragments do not repeat, so it is
rare in practice; the in-tree callers (`examples/ip_reassembly`, `ipsec-sec=
gw`,
`lib/node`) hard-code
`l3_len =3D 20` and never see it. The default build is affected, no offload=
 is
involved. To carry the full 65515
bytes in the 8 fragments the library keeps per datagram
(`RTE_LIBRTE_IP_FRAG_MAX_FRAG`), the ingress port must
accept frames of about 8.3 KB.

There is no out-of-bounds access inside `lib/ip_frag`; the ASan/UBSan build
(`/src/build-asan`) forwards the
same frame and reports nothing. The result is a header that contradicts the
mbuf. DPDK helpers that read
`total_length` afterwards mostly cope: `rte_ipv4_phdr_cksum()`
(`lib/net/rte_ip4.h:238`) still yields the true
payload length because the 16-bit subtraction undoes the wrap, and
`rte_ipv4_udptcp_cksum_mbuf()` returns the
same checksum as for the valid datagram with the same payload; only
`__rte_ipv4_udptcp_cksum()` gives up on such
a header (`lib/net/rte_ip4.h:256`). A forwarded copy claims a length below =
its
own header length and is dropped
by a receiver. The same wrapped header can also be produced with two short
frames, but that form relies on a
separate defect (fragments shorter than their `total_length` says are
accepted), not on this one.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
