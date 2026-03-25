Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E041FEA83B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6964A402CE;
	Wed, 25 Mar 2026 10:44:15 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 77A294028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:44:14 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 62F144AD99; Wed, 25 Mar 2026 10:44:14 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [wishes/any Bug 1912] free mbufs should not have next and nb_segs
 initialized
Date: Wed, 25 Mar 2026 09:44:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: wishes
X-Bugzilla-Component: any
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-1912-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1912

            Bug ID: 1912
           Summary: free mbufs should not have next and nb_segs
                    initialized
           Product: wishes
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: any
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---
             Group: wishes-managers

The invariant about which mbuf fields are initialized for free mbufs (i.e.
mbufs held in a mempool) should only cover the refcnt and the constant fiel=
ds:
buf_addr, buf_iova, buf_len, pool, priv_size.
The "next" and "nb_segs" fields are the only remaining non-constant fields =
(in
addition to the refcnt) still covered, and they should not be.

When an mbuf has been allocated and the driver fills the mbuf's fields duri=
ng
Rx, the driver might as well also set the "next" and "nb_segs" fields (if it
doesn't already).
The performance cost of setting these two fields along with the other field=
s is
near zero.

Not having to initialize any mbuf fields when freeing an mbuf would reduce =
the
performance cost of freeing mbufs.
And in the FAST_FREE case (where the refcnt is known to be 1), the driver c=
an
free the mbufs without touching them at all.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
