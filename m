Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09EC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 23:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F9140A6E;
	Wed, 18 Jun 2025 01:08:47 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6D9F840279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:08:46 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4CD4A469E0; Wed, 18 Jun 2025 01:08:46 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1727] arparse LTO warnings
Date: Tue, 17 Jun 2025 23:08:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
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
Message-ID: <bug-1727-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17502017260.8BcB1Ec.2595619
Content-Transfer-Encoding: 7bit
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


--17502017260.8BcB1Ec.2595619
Date: Wed, 18 Jun 2025 01:08:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1727

            Bug ID: 1727
           Summary: arparse LTO warnings
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Enabling LTO detects more warnings in argparse test.
Looks like argparse is referencing invalid arguments before checking.

n function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_basic_param=E2=80=99 at
../app/test/test_argparse.c:118:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_bas=
ic_param=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_basic_param=E2=80=99 at
../app/test/test_argparse.c:123:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_bas=
ic_param=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:137:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:142:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:147:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:152:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:158:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:163:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:168:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_help=E2=80=99 at
../app/test/test_argparse.c:182:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_help=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_has_val=E2=80=99 at
../app/test/test_argparse.c:203:9:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_has=
_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:221:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:229:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:237:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:245:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:263:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:269:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:281:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_repeat=E2=80=99 at
../app/test/test_argparse.c:296:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_repeat=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_repeat=E2=80=99 at
../app/test/test_argparse.c:302:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_repeat=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_option=E2=80=99 at
../app/test/test_argparse.c:317:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_opt=
ion=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_option=E2=80=99 at
../app/test/test_argparse.c:323:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_opt=
ion=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_no_val=E2=
=80=99 at
../app/test/test_argparse.c:340:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_no_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_required_=
val=E2=80=99 at
../app/test/test_argparse.c:373:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_required_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_optional_=
val=E2=80=99 at
../app/test/test_argparse.c:417:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_optional_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_no_val=E2=
=80=99 at
../app/test/test_argparse.c:490:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_no_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_required_=
val=E2=80=99 at
../app/test/test_argparse.c:541:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_required_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_optional_=
val=E2=80=99 at
../app/test/test_argparse.c:605:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_optional_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_pos_autosave_parse_int=E2=80=99 at
../app/test/test_argparse.c:659:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_pos_autosave_parse_int=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_pos_callback_parse_int=E2=80=99 at
../app/test/test_argparse.c:721:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&dst->args[i], &src->args[i],
sizeof(src->args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_pos_callback_parse_int=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17502017260.8BcB1Ec.2595619
Date: Wed, 18 Jun 2025 01:08:46 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - arparse LTO warnings"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1727">1727</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>arparse LTO warnings
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
          <td>other
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
          <pre class=3D"bz_comment_text">Enabling LTO detects more warnings=
 in argparse test.
Looks like argparse is referencing invalid arguments before checking.

n function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_basic_param=E2=80=99 at
../app/test/test_argparse.c:118:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_bas=
ic_param=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_basic_param=E2=80=99 at
../app/test/test_argparse.c:123:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_bas=
ic_param=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:137:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:142:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:147:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:152:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:158:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:163:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_name=E2=80=99 at
../app/test/test_argparse.c:168:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_name=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_help=E2=80=99 at
../app/test/test_argparse.c:182:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_help=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_has_val=E2=80=99 at
../app/test/test_argparse.c:203:9:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_has=
_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:221:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:229:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:237:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_saver=E2=80=99 at
../app/test/test_argparse.c:245:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_saver=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:263:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:269:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_flags=E2=80=99 at
../app/test/test_argparse.c:281:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_flags=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_repeat=E2=80=99 at
../app/test/test_argparse.c:296:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_repeat=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_arg_repeat=E2=80=99 at
../app/test/test_argparse.c:302:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_arg=
_repeat=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_option=E2=80=99 at
../app/test/test_argparse.c:317:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_opt=
ion=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_invalid_option=E2=80=99 at
../app/test/test_argparse.c:323:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function =E2=80=98test_argparse_invalid_opt=
ion=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_no_val=E2=
=80=99 at
../app/test/test_argparse.c:340:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_no_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_required_=
val=E2=80=99 at
../app/test/test_argparse.c:373:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_required_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_autosave_parse_int_of_optional_=
val=E2=80=99 at
../app/test/test_argparse.c:417:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_autosave_parse_int_of_optional_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_no_val=E2=
=80=99 at
../app/test/test_argparse.c:490:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_no_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_required_=
val=E2=80=99 at
../app/test/test_argparse.c:541:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_required_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_optional_=
val=E2=80=99 at
../app/test/test_argparse.c:605:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_opt_callback_parse_int_of_optional_val=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_pos_autosave_parse_int=E2=80=99 at
../app/test/test_argparse.c:659:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_pos_autosave_parse_int=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |                                    ^
In function =E2=80=98test_argparse_copy=E2=80=99,
    inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/te=
st_argparse.c:108:2,
    inlined from =E2=80=98test_argparse_pos_callback_parse_int=E2=80=99 at
../app/test/test_argparse.c:721:8:
../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writin=
g 56 bytes into a
region of size 0 overflows the destination [-Wstringop-overflow=3D]
   96 |                 memcpy(&amp;dst-&gt;args[i], &amp;src-&gt;args[i],
sizeof(src-&gt;args[i]));
      |                 ^
../app/test/test_argparse.c: In function
=E2=80=98test_argparse_pos_callback_parse_int=E2=80=99:
../app/test/test_argparse.c:106:36: note: at offset 184 into destination ob=
ject
=E2=80=98obj=E2=80=99 of size 184
  106 |         static struct rte_argparse obj =3D argparse_templater();
      |
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
?id=3D1727">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17502017260.8BcB1Ec.2595619--
