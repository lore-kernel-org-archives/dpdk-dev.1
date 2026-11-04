Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36619606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 08:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4964026E;
	Wed,  4 Nov 2026 09:04:14 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id C0F9740151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 09:04:12 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A75274D0F9; Wed,  4 Nov 2026 09:04:12 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2092] net/pcap: filename truncation in secondary
 process
Date: Wed, 04 Nov 2026 08:04:11 +0000
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
 target_milestone
Message-ID: <bug-2092-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2092

            Bug ID: 2092
           Summary: net/pcap: filename truncation in secondary process
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

Summary: net/pcap is truncating silently and breaks secondary
The paths need to be larger and variable length

Longer worded AI version.

Component: drivers/net/pcap
Version: 26.11-rc2 (a13c105)

Description:
The vdev bus multi-process sync passes only the device name to a
secondary, not its arguments. To work around this, the pcap PMD
stores a copy of the devargs string in dev_private, which is
shared with secondaries:

    struct pmd_internals {
        ...
        char devargs[ETH_PCAP_ARG_MAXLEN];   /* 64 */

    strlcpy((*internals)->devargs, rte_vdev_device_args(vdev),
            ETH_PCAP_ARG_MAXLEN);

When a secondary probes, it parses internal->devargs and opens
its own pcap handles from that copy. The limit applies to the
whole argument string, not to each file name, so it is easy to
hit with one long path or with several short arguments.

The primary works normally because it parses the full string.
Only secondaries see the truncated copy, so the problem stays
hidden until something like dpdk-dumpcap, dpdk-pdump or
dpdk-proc-info attaches.

Effects in the secondary:
 - rx_pcap/tx_pcap open fails on the truncated path, so the
   attach fails.
 - Arguments after the cut point (snaplen, infinite_rx, ...)
   are dropped or mis-parsed.
 - If the cut lands on a path that exists, the secondary opens
   the wrong file. For tx_pcap, pcap_dump_open() creates or
   truncates that file.

Steps to reproduce:
 dpdk-testpmd --vdev 'net_pcap0,rx_pcap=3D<path, devargs 64+ bytes>' \
     -- -i
 dpdk-dumpcap -i net_pcap0 -w /tmp/x.pcapng

Works when the same file is under a short path, e.g. /tmp/a.pcap.

Expected: the secondary sees the same arguments as the primary.
Actual: the secondary probes with a truncated devargs string.

Suggested fix:
Copy the devargs with rte_strdup() so the full string sits in
shared memory, keep a pointer to it in pmd_internals, and free
it on close. Or at least fail the primary probe when the
string will not fit, instead of truncating silently.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
