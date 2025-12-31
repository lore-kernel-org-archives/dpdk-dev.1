Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836FEEEB565
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 17:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30DBB402A0;
	Wed, 31 Dec 2025 18:58:24 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2357C40267
 for <dev@dpdk.org>; Wed, 31 Dec 2025 18:58:23 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B80604714B; Wed, 31 Dec 2025 18:58:22 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1862] mlx5: errors when built with LTO
Date: Wed, 31 Dec 2025 17:58:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
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
Message-ID: <bug-1862-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1862

            Bug ID: 1862
           Summary: mlx5: errors when built with LTO
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with LTO and release flags causes lots of warnings in mlx5

[3686/3710] Linking target drivers/librte_net_mlx5.so.26.1
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [140, 5242=
48]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [12, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [140, 5242=
48]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [148, 5242=
56]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [20, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [148, 5242=
56]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [156, 5242=
64]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [28, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [156, 5242=
64]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [164, 5242=
72]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [36, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [164, 5242=
72]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [172, 5242=
80]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [44, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [172, 5242=
80]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [180, 5242=
88]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [52, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [180, 5242=
88]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2164:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2234:9:
../drivers/net/mlx5/hws/mlx5dr_action.c:3643:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3643 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [188, 5242=
96]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2144 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [60, 64] i=
nto
destination object =E2=80=98mh_data=E2=80=99 of size 64
../drivers/net/mlx5/hws/mlx5dr_action.c:2144:17: note: at offset [188, 5242=
96]
into destination object =E2=80=98mh_data=E2=80=99 of size 64

--=20
You are receiving this mail because:
You are the assignee for the bug.=
