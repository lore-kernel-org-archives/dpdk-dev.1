Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D86ECAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B014E4028B;
	Fri,  3 Oct 2025 13:45:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 635E940262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:45:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 540CB4889F; Fri,  3 Oct 2025 13:45:35 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1798] Meson can't find MLX5 build dependencies with
 clang
Date: Fri, 03 Oct 2025 11:45:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alialnu@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1798-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1798

            Bug ID: 1798
           Summary: Meson can't find MLX5 build dependencies with clang
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: alialnu@nvidia.com
  Target Milestone: ---

Created attachment 331
  --> http://bugs.dpdk.org/attachment.cgi?id=3D331&action=3Dedit
Meson logs with and without the first bad commit

MLX5 drivers are getting disabled due to missing dependency warnings:

Message: Disabling mlx5 [drivers/net/mlx5]: missing internal dependency
"common_mlx5"

Build command:
CC=3Dclang PKG_CONFIG_PATH=3D/opt/rdma-core/build/lib/pkgconfig meson
--werror --buildtype=3Ddebugoptimized build

OS: Ubuntu 22.04
Compiler: clang 14.0.0
Meson: 0.61.2

gcc does not reproduce.

$ PKG_CONFIG_PATH=3D:/opt/rdma-core/build/lib/pkgconfig pkg-config --modver=
sion
libibverbs
1.15.60.0

git-bisect points to 0681e15f42df ("build: validate libraries returned from
meson find function").

--=20
You are receiving this mail because:
You are the assignee for the bug.=
