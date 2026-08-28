Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0903C61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61124025A;
	Fri, 28 Aug 2026 19:34:06 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DD84940151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:34:04 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C05DF4CF9D; Fri, 28 Aug 2026 19:34:04 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2012] memif: add_region accepts claimed region
 larger than file
Date: Fri, 28 Aug 2026 17:34:04 +0000
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
 target_milestone bug_group
Message-ID: <bug-2012-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2012

            Bug ID: 2012
           Summary: memif: add_region accepts claimed region larger than
                    file
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
             Group: security

Another AI discovered bug.

memif_msg_receive_add_region() in drivers/net/memif/memif_socket.c
validates the region index but takes the region size from the client
unchecked. It does not require ar->size to be non-zero, and it does not
confirm that the file descriptor passed with the message refers to a
file at least that large.

mmap() beyond the end of a file succeeds; the fault happens on access.
So a client that advertises a region larger than the file it actually
passes gets a mapping the server believes is fully backed, and any
access past the real end of the file faults the server with SIGBUS.

This also undermines the fix for the data-path descriptor validation
filed separately. That fix bounds each descriptor with
offset + length <=3D region_size, but region_size is the value the client
claimed. A descriptor that satisfies the bound against the claimed size
and lies past the real file size passes validation and still faults.
Fixing the data path without fixing this leaves the check looking sound
while resting on a peer-supplied number.

Suggested fix
-------------

Reject ar->size =3D=3D 0. fstat() the passed file descriptor and reject the
region if st_size is less than the claimed size.

Caveat that should be recorded rather than papered over: an fstat check
does not fully close this. A client can truncate the file after the
check, or after the mapping is established, and the access still faults.
Only F_SEAL_SHRINK prevents that, and sealing is not available on all fd
types in legitimate use. libmemif seals region 0 with F_SEAL_SHRINK, but
hugepage-backed and zero-copy buffer regions use MFD_HUGETLB or
hugetlbfs and are not sealed, so a server that required sealing would
disconnect conforming clients, including VPP zero-copy clients.

The proposed fix therefore checks the size with fstat and only logs when
the fd is not sealed. Whether the residual post-check shrink exposure is
accepted, or handled some other way, is an open design question that
spans DPDK, VPP and libmemif and should be settled jointly rather than
decided unilaterally in one stack.

A candidate patch exists privately and has not been posted. It can be
shared with the security team on request.

Reported by Arthur Chan <arthur.chan@adalogics.com> (Ada Logics), via
fuzzing.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
