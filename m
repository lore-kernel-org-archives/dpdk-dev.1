Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81208CD3442
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 19:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 895E34027C;
	Thu,  7 May 2026 21:03:00 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id B566C4026F
 for <dev@dpdk.org>; Thu,  7 May 2026 21:02:58 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso1724834eec.1
 for <dev@dpdk.org>; Thu, 07 May 2026 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778180578;
 x=1778785378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMq+cn1q/TisxPePKaUQmf4isfFWQILcieVMLZBjcjg=;
 b=k1AAWC5vDJl/KKm3AKiJWT4hP/vkRiKhi1zujdiIVFn/cACTazW6uRaqptHOAq0GVg
 A9sSIh/c09UJN7htli1AZUAbVRoiNPForZf+rysBe2AXDIcFRZl2xo3AXSQqErDIzd6y
 BLPygWa4UdpnAn3PsSfIDYuq/hrgSFi8mPJwUA34ReSGKpPzIotjwQt+EmVeXoAeO9cK
 BidgK0oOS/yhydap9ePE/N4+/NQjVHg9DngkoN8Rw4fdPvsct2RCPBuOtM2RiLal05jO
 5nnguvu4htuMYy65ANqf89gx2IQb1ivSXRWpGe1Ext0ixYZjV3rvVt4+oZgVt4Feuzbs
 a1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180578; x=1778785378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMq+cn1q/TisxPePKaUQmf4isfFWQILcieVMLZBjcjg=;
 b=b0wBb5erFI07G/5r3pH8PThf6a8zDvpVkR2NjBz55MDPFtB+2T6vArVnD2pg81i5rw
 QFT+SwGJoX/SaHJI0lxp9r8DdqkYG4EEKKNk+vT4jb9lniMtSwwYbg2ntCO9mjeu/KpE
 R4eG/EXvxckMAKMs1uulBstwETr0tclXbEY/KNB/YPVnie2wBrQBzR0UJa+BTyTHC/6F
 KuMKHS0sowQGnDDAKEQ9522Qgns/mmPOduLk1vv2h3I8kgY6mdMlBo14HlOrhXLSvEld
 2ZlQVr+iVZc2B8d9mD+nw7uOddVuICFiL6sezfzP3/SjgYAbNPUBbLurmc2ux+YlkhXD
 DxDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X6grx8Z3xtyNJKh/BeGlMbsBSu6h1RjhascMDdtzSuM2B6RXrwLR9kIa9OPqwz0HrLyo=@dpdk.org
X-Gm-Message-State: AOJu0YyCh0av6IwQ2qBQhFcc8bBg/cDeuCvaYybVxEvR6naM2eWyvOB3
 vWXTVRe8fDfZonTKl5tOfYVhFJt2lnx+tSs4vjUIJCppe0hoyBq29bLH9SK8RpcW2tc=
X-Gm-Gg: Acq92OFeYMTczcm37RbxKc5NzfLw18w3y7MZf4+sSl4K/FUAGk0wPPUyfWWYAge5j5/
 2U3oEkN/6map5gkFATaiT/kietggfGN26PfLczyKn0/0TSg2kiDzRPTTtIXmGgws+xNXKjvCPL9
 KHMYiVsyZeJ2OIZIiK/TqDxTTumNa/7uUwTyeGRqmVvrS64sqhDuULT2894slecRCGCpAr/iTHZ
 rToh3HL0GQWMjBlE357iTCtockH1VrlbEDpnn3DA5c2SR7yfoHVGcv6/zjyFYs8YSKUzq+dB1kc
 BhcdNrNBzaK3ymViLhJYE/VbsUJ7tCfbr2oaCDhFK133MUPPXU3+qeqST5GLqzw9M65XBixT5OA
 y9VcLUEExD9QIVcWLkq1/jlC2acUY87qFU7J8KzlQYDaekOQZY+HdW03O1e6Zi3r+0F5Y5T0vHj
 5tFj6vIcIpgqSVREibeexXRLeqi6KdcbgeX/Y=
X-Received: by 2002:a05:7300:5b9e:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-2f55054643bmr4284619eec.25.1778180577408; 
 Thu, 07 May 2026 12:02:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f82bb5862csm305969eec.8.2026.05.07.12.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:02:56 -0700 (PDT)
Date: Thu, 7 May 2026 12:02:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Subject: Re: [RFC 0/3] fib: tbl8 reservation drift reproducer and proposed fix
Message-ID: <20260507120253.3eec853a@phoenix.local>
In-Reply-To: <cover.1778146229.git.maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu,  7 May 2026 11:50:40 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> Asymmetric ADD/DEL sequences in FIB6 trie (a covering parent
> removed between the ADD and DEL of a longer prefix) eventually
> make ADD fail with -ENOSPC even when the tbl8 pool is empty.
>=20
> Patch 2/3 is a small reproducer.
>=20
> Root cause: rsvd_tbl8s is updated by depth_diff recomputed from
> the current RIB, so increments at ADD and decrements at DEL do
> not cancel when the RIB state changes in between. The counter
> drifts and wraps to UINT32_MAX.
>=20
> The simplest fix I could find (1/3, 3/3) is to drop rsvd_tbl8s
> and use the pool counters already maintained by alloc/free:
> tbl8_pool_pos in trie, cur_tbl8s in dir24_8. The DQ reclaim
> inside tbl8_alloc() is moved into the pre-check.
>=20
> I am not sure I understood the original intent of keeping
> rsvd_tbl8s separate from the pool counters. In dir24_8 the two
> mirror each other 1:1 and rsvd_tbl8s looks redundant; in trie,
> depth_diff gives it a worst-case-reservation flavor but the
> recomputation from the RIB is exactly what makes it drift. If
> there was a deliberate reason, please point it out.
>=20
> Patch 3/3 is a no-op cleanup that aligns dir24_8 with the trie
> pattern.
>=20
> Maxime Leroy (3):
>   fib6: fix tbl8 reservation drift in trie
>   test/fib6: add reproducer for tbl8 reservation drift
>   fib: drop redundant tbl8 reservation counter
>=20
>  app/test/test_fib6.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/fib/dir24_8.c    | 31 ++++++-----------
>  lib/fib/dir24_8.h    |  1 -
>  lib/fib/trie.c       | 23 ++++++------
>  lib/fib/trie.h       |  3 +-
>  5 files changed, 104 insertions(+), 37 deletions(-)
>=20

Used  this a test case for multiple AI reviewers.
Most reported false positives in various places.
But the winner was Claude web (or desktop) with Opus 4.7 extended.
It saw:

Patch 3 - fib: drop redundant tbl8 reservation counter
Warning: The commit message frames this as removing a "redundant" counter a=
nd claims "Behavior is unchanged for non-DQ modes," but dir24_8 has the sam=
e rsvd_tbl8s drift bug that patch 1/3 fixes for trie6 =E2=80=94 this patch =
silently fixes it as well.
Trace (no RCU, depth-1 mode):
ADD /28 A (no /24 cover):
- tmp =3D=3D NULL, pre-check passes
- install_to_fib allocates 1 tbl8 -> cur_tbl8s =3D 1
- post-add hook: tmp =3D=3D NULL -> rsvd_tbl8s++ =3D 1
ADD /24 B covering A:
- depth =3D=3D 24, no rsvd_tbl8s update
- tbl8 entries rewritten, no alloc/free
- state: rsvd_tbl8s =3D 1, cur_tbl8s =3D 1
DEL /28 A (with /24 cover B):
- modify_fib installs B's nh over A's range
- tbl8 becomes uniform -> tbl8_recycle() -> cur_tbl8s =3D 0
- post-del check: tmp !=3D NULL (B is the cover) -> rsvd_tbl8s NOT decremen=
ted
- state: rsvd_tbl8s =3D 1, cur_tbl8s =3D 0  (diverged)
DEL /24 B:
- depth =3D=3D 24, no rsvd_tbl8s update
- final: rsvd_tbl8s =3D 1, cur_tbl8s =3D 0
Each repetition leaks +1 into rsvd_tbl8s with no actual tbl8 in use. Over e=
nough cycles, rsvd_tbl8s reaches number_tbl8s and the pre-check rejects val=
id /25-/32 ADDs even though the pool is empty. This is the same class of bu=
g as the IPv6 case, just with smaller per-cycle drift.
The patch should carry:
Fixes: <commit that introduced rsvd_tbl8s in dir24_8>
Cc: stable@dpdk.org
