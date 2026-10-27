Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE0606A327
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2DB640151;
	Tue, 27 Oct 2026 14:55:06 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A56040151
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:55:05 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3AE924CF60; Tue, 27 Oct 2026 14:55:05 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2075] pdump fails on hairpin queue
Date: Tue, 27 Oct 2026 13:55:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
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
Message-ID: <bug-2075-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2075

            Bug ID: 2075
           Summary: pdump fails on hairpin queue
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Message from Haan on Slack reported issue with dpdk-dumpcap with hairpin qu=
eue

Hello all,

I found a problem with dpdk-dumpcap that makes it fail to capture, it happe=
ns
if a DPDK program has a port that has a haripin queue, the first run fails =
with
Unknown error -22 , every later run on the same port fails with File exists.

Steps to reproduce:

1. Start testpmd with one hairpin queue per port:

   dpdk-testpmd -l 0-1 -a <PCI_ADDR> -- -i --rxq=3D1 --txq=3D1 --hairpinq=
=3D1
   testpmd> start

2. In another shell, run dumpcap:

   dpdk-dumpcap -i 0 -w /tmp/zzz.pcap

Result:

File: zzz.pcap
PDUMP: pdump_prepare_client_request(): client request for pdump enable/disa=
ble
failed
EAL: Error - exiting with code: 1
Packet dump enable on 0:0000:01:00.0 failed Unknown error -22

3. Run the same dumpcap command again:

Result:

File: zzz.pcap
PDUMP: pdump_prepare_client_request(): client request for pdump enable/disa=
ble
failed
EAL: Error - exiting with code: 1
Packet dump enable on 0:0000:01:00.0 failed File exists

Any idea how can I use it to capture even if there's a haripin queue?

--=20
You are receiving this mail because:
You are the assignee for the bug.=
