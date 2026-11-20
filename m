Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7927606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169DC40263;
	Fri, 20 Nov 2026 19:28:48 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id AE616400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 19:28:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 828594F2E2; Fri, 20 Nov 2026 19:28:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2151] ip_frag: output array overflow when
 fragmenting mbufs over 64 KB
Date: Fri, 20 Nov 2026 18:28:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-2151-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2151

            Bug ID: 2151
           Summary: ip_frag: output array overflow when fragmenting mbufs
                    over 64 KB
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
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
ANT-2026-KAH9I4A9  [high]  CWE-197  memory-safety
ip_frag: output array overflow when fragmenting mbufs over 64 KB
Location: lib/ip_frag/rte_ipv4_fragmentation.c:159  in
rte_ipv4_fragment_packet()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
```

A vhost guest can make a host DPDK application that fragments its packets w=
rite
past the end of the caller's `pkts_out[]` array. The written values are host
mbuf pointers, not guest-chosen data, and the guest needs only a single Tx
descriptor in the default `net_vhost` configuration. The result is stack or
adjacent-table corruption and a crash of the host data-path process. Code
execution has not been shown. Both `rte_ipv4_fragment_packet()` and
`rte_ipv6_fragment_packet()` are affected, in any application that fragments
received packets larger than the egress MTU based on `pkt_len`, as
`examples/ip_fragmentation` does.

The only check that `pkts_out[nb_pkts_out]` can hold every fragment is at
`lib/ip_frag/rte_ipv4_fragmentation.c:158-160` (and
`rte_ipv6_fragmentation.c:100`). It compares against
`(uint16_t)(pkt_in->pkt_len - header_len)`. The loop that follows walks the
whole mbuf chain and never looks at `nb_pkts_out` again. A chain of 65556 b=
ytes
or more therefore passes the check on its low 16 bits. The function then st=
ores
one pointer per fragment past the array and returns a count larger than
`nb_pkts_out` (45 for 16 slots), so the caller also reads those out-of-boun=
ds
entries. The vhost dequeue path puts no upper bound on frame length unless
`linear-buffer=3D1` is set. A remote sender can reach the same state throug=
h a
separate defect: reassembly ignores a failed `rte_pktmbuf_trim()`. That rou=
te
also needs jumbo frames, scattered Rx, and an application that reassembles
before it fragments. The attached reproducer has a vhost-user guest send a
65557-byte IPv4 frame to a forwarder modelled on `examples/ip_fragmentation=
`.
ASan reports a stack-buffer-overflow WRITE past `frags[16]` at
`rte_ipv4_fragmentation.c:258`. On a plain gcc build, larger frames end in a
"stack smashing detected" abort or SIGSEGV. The truncating check dates from
4c38e5532a07 ("ip_frag: refactor IPv4 fragmentation into a proper library").

--=20
You are receiving this mail because:
You are the assignee for the bug.=
