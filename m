Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699ABC61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90DEA4025A;
	Fri, 28 Aug 2026 19:46:58 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED58E40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:46:56 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D603C4CFDC; Fri, 28 Aug 2026 19:46:56 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2017] memif: trust model not documented
Date: Fri, 28 Aug 2026 17:46:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-2017-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2017

            Bug ID: 2017
           Summary: memif: trust model not documented
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---
             Group: security

The AI generated security report raises the observation that memif has an
implicit set of assumptions about trust. These should be made explicit.
The AI generated text for this is.

Since there is no memif specification outside VPP's tree, DPDK should
also state its own normative requirements for a conforming client,
rather than deriving them from whatever VPP happens to do. At minimum:

  - regions are added before the rings that reference them;
  - the file descriptor passed with a region is at least as large as the
    claimed region size;
  - rings are added in order, exactly once;
  - a ring and its descriptor table lie within the region it names, at a
    naturally aligned offset;
  - private_hdr_size is zero;
  - log2_ring_size is no greater than the value the server advertised;
  - descriptor region, offset and length lie within the region they name.

Writing these down is what lets a server reject a non-conforming client
without the rejection being read as a DPDK bug, and gives VPP and
libmemif something to check themselves against.

Add something like this to memif.rst


Security considerations
-----------------------

The trust between the two roles is not symmetric. The client creates the
shared memory and passes the region file descriptors to the server, so
the client trusts the server. The server receives memory it did not
create, from a peer it did not choose.

Where the two ends are in different trust domains, for example either
side of a container boundary, the less trusted end should be configured
as the client.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
