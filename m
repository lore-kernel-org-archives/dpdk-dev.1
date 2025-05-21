Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C227BC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 15:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941C542DC1;
	Wed, 21 May 2025 17:20:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3216042DB0
 for <dev@dpdk.org>; Wed, 21 May 2025 17:20:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 18341467B0; Wed, 21 May 2025 17:20:35 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1709] net/mlx5 warnings when build with lto
Date: Wed, 21 May 2025 15:20:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1709-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17478408340.1EAeE70ea.2314293
Content-Transfer-Encoding: 7bit
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


--17478408340.1EAeE70ea.2314293
Date: Wed, 21 May 2025 17:20:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1709

            Bug ID: 1709
           Summary: net/mlx5 warnings when build with lto
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Suspect that temporary buffer may not be big enough.
LTO enables more inlining and therefore more bounds checking.

[3511/3591] Linking target drivers/librte_net_mlx5.so.25.2

In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [76, 52423=
6]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [84, 52424=
4]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [92, 52425=
2]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [100, 5242=
60]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [108, 5242=
68]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [116, 5242=
76]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [124, 5242=
84]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17478408340.1EAeE70ea.2314293
Date: Wed, 21 May 2025 17:20:34 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - net/mlx5 warnings when build with lto"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1709">1709</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/mlx5 warnings when build with lto
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Suspect that temporary buffer may =
not be big enough.
LTO enables more inlining and therefore more bounds checking.

[3511/3591] Linking target drivers/librte_net_mlx5.so.25.2

In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [76, 52423=
6]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [84, 52424=
4]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [92, 52425=
2]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [100, 5242=
60]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [108, 5242=
68]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [116, 5242=
76]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
In function =E2=80=98mlx5dr_action_prepare_decap_l3_data=E2=80=99,
    inlined from =E2=80=98mlx5dr_action_handle_tunnel_l3_to_l2=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2151:3,
    inlined from =E2=80=98mlx5dr_action_create_reformat_hws=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2221:9,
    inlined from =E2=80=98mlx5dr_action_create_reformat=E2=80=99 at
../drivers/net/mlx5/hws/mlx5dr_action.c:2278:8:
../drivers/net/mlx5/hws/mlx5dr_action.c:3630:17: warning: writing 4 bytes i=
nto
a region of size 0 [-Wstringop-overflow=3D]
 3630 |                 memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);=
 /*
data */
      |                 ^
../drivers/net/mlx5/hws/mlx5dr_action.c: In function
=E2=80=98mlx5dr_action_create_reformat=E2=80=99:
../drivers/net/mlx5/hws/mlx5dr_action.c:2131:17: note: at offset [124, 5242=
84]
into destination object =E2=80=98mh_data=E2=80=99 of size 64
 2131 |         uint8_t mh_data[MLX5DR_ACTION_REFORMAT_DATA_SIZE] =3D {0};
      |                 ^
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1709">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17478408340.1EAeE70ea.2314293--
