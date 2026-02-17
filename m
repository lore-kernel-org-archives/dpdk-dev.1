Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C9E9A047
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 20:34:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DDBC40261;
	Tue, 17 Feb 2026 21:34:04 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C97EF400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 21:34:02 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9AD664A656; Tue, 17 Feb 2026 21:34:02 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1883] rte_hash with big cap and key size of 64bytes
 and more can lead to key store corruption
Date: Tue, 17 Feb 2026 20:34:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1883-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

http://bugs.dpdk.org/show_bug.cgi?id=3D1883

            Bug ID: 1883
           Summary: rte_hash with big cap and key size of 64bytes and more
                    can lead to key store corruption
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

Created attachment 340
  --> http://bugs.dpdk.org/attachment.cgi?id=3D340&action=3Dedit
simple repro

I was experimenting with table size of 2^26 and key size of 64 bytes, and
noticed, that deletion was failing for some earlier added entries, after so=
me
digging it seems like the main problem is overflow in key_store offset
calculation, seems like there are multiple places, but as example

new_k =3D RTE_PTR_ADD(keys, slot_id * h->key_entry_size);

slot_id is u32, and h->key_entry_size is u32 as well, in my case at high
occupancy slot_id  can be very high(up to 67mil) which multiplied by 80 will
overflow u32 and will overwrite earlier entries.

lazy fix seem to be making h->key_entry_size u64

Attached simple repro.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
