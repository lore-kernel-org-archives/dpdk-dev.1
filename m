Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADE8CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 05:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D604042E;
	Tue,  4 Nov 2025 06:19:07 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id F28AA402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 06:19:05 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EE91E48A9B; Tue,  4 Nov 2025 06:19:05 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1823] mlx5: warnings when built with gcc-16
Date: Tue, 04 Nov 2025 05:19:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1823-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1823

            Bug ID: 1823
           Summary: mlx5: warnings when built with gcc-16
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

../drivers/net/mlx5/linux/mlx5_ethdev_os.c: In function =E2=80=98mlx5_link_=
update=E2=80=99:
../drivers/net/mlx5/linux/mlx5_ethdev_os.c:539:15: warning: =E2=80=98*(long=
 unsigned
int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))=E2=80=99=
 may be used
uninitialized [-Wmaybe-uninitialized]
  539 |         ret =3D !!memcmp(&dev->data->dev_link, &dev_link,
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  540 |                        sizeof(struct rte_eth_link));
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/mlx5/linux/mlx5_ethdev_os.c:515:29: note: =E2=80=98*(long un=
signed int
*)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))=E2=80=99 was=
 declared
here
  515 |         struct rte_eth_link dev_link;
      |                             ^~~~~~~~

--=20
You are receiving this mail because:
You are the assignee for the bug.=
