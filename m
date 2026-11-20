Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6560A2603
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD54140263;
	Fri, 20 Nov 2026 19:29:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 183BA400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 19:29:52 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 110A84EE71; Fri, 20 Nov 2026 19:29:52 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2152] ip_frag: IPv6 fragmentation overflows pkts_out
 on short first segment
Date: Fri, 20 Nov 2026 18:29:52 +0000
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
 target_milestone bug_group
Message-ID: <bug-2152-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2152

            Bug ID: 2152
           Summary: ip_frag: IPv6 fragmentation overflows pkts_out on
                    short first segment
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
             Group: security

```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-CN4C9II5  [high]  CWE-787  memory-safety
ip_frag: IPv6 fragmentation overflows pkts_out on short first segment
Location: lib/ip_frag/rte_ipv6_fragmentation.c:190  in
rte_ipv6_fragment_packet()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
```

A remote sender can make `rte_ipv6_fragment_packet()` in lib/ip_frag write
thousands of mbuf pointers past the end of the caller's `pkts_out[]` array,
crashing the data-path process. This affects applications that reassemble I=
Pv4
fragments, strip the outer header, and then fragment the inner IPv6 packet =
to a
smaller MTU. The unmodified `examples/ipsec-secgw --reassemble` is one such
application. A genuine ESP packet, re-cut so that its first IPv4 fragment e=
nds
inside the inner IPv6 header, crashes it, and re-cutting needs no key becau=
se
outer fragmentation is not authenticated. For an unauthenticated tunnel suc=
h as
6in4, any remote sender can do it with three ordinary frames.

The root cause is a missing length check. `rte_ipv4_fragment_packet()` reje=
cts
a first segment shorter than the IP header (added in 1edf7a796d), but the I=
Pv6
function sets `in_seg_data_pos =3D 40`
(`lib/ip_frag/rte_ipv6_fragmentation.c:105`) without checking that the first
segment holds 40 bytes. When it holds fewer, `data_len - in_seg_data_pos` w=
raps
in unsigned arithmetic and the end-of-segment equality test never fires. The
loop then keeps allocating fragments until a mempool is empty, storing each=
 one
at `pkts_out[out_pkt_pos]` (line 190) without consulting `nb_pkts_out`. The
sender controls the first segment's length because IPv4 reassembly chains
fragments in arrival order, so after `rte_pktmbuf_adj()` that segment holds
only the first few bytes of the inner header.

The number of pointers written equals the number of free mbufs (8189 in one
test), and the values are mbuf addresses, not sender-chosen bytes. Nothing
beyond a crash has been shown. The attached reproducer is a small 6in4 endp=
oint
built with ASan. With a 48-byte first fragment, the packet is forwarded as =
two
fragments. With an 8-byte first fragment and otherwise identical bytes, ASan
reports a stack-buffer-overflow write at line 190, and a plain build dies w=
ith
SIGSEGV.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
