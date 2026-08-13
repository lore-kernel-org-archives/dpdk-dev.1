Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FBFC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 16:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68CF64064C;
	Thu, 13 Aug 2026 18:47:27 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id B3F17402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 18:47:25 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbedc9ec119so145a12.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786639644;
 x=1787244444; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3V3LulVwUS38gMs7aboXyj/o8cMv6JDcDVCahmusHWE=;
 b=t+lP5KKvoH0w1qpVg8kdLBI+ZwA9sD4OXrlI9l0ElpReCjvFVBG8p0mlw0j6RBnu/x
 Al/X0cME+egXplXg+gmfe5L5uOJaE3sqWAL2ebUtZxYYVOBWoVMUxJIdUAo3q2obFYQ6
 ODTKcem2PyGKBYYfS+fJ+edrdbLqp6P/SgtxTdUL3FdmavpnthZwXEv3HHX5/KCkCpXk
 yV9AGGnTYh9+5uYJ0pdSGVe2KKkxt24VHh74kPc+5Ai4ILoygKng9MHXU96w1N5KUHuL
 iAkfwv038yAyy8DjZMKKYhnyFMHI7cWKk7+9g6WrfZdSmPFbuYz2yNf24a1ajfojI29c
 iVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786639644; x=1787244444;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3V3LulVwUS38gMs7aboXyj/o8cMv6JDcDVCahmusHWE=;
 b=EiQqZIkDmK4eduyHsYf/XhG6yE9Ebjz/l86kHo24iHtPbe99zG1QlIZC7W9djR7SSE
 nQxaIu0nvz0VJvR5z9btCR1PrxSc+mbivux4udcijntr2Xww7U+kfRtNs5fmVUuMC+Z1
 g4dXuaxdoq9mNlr9/xNfFd10rSuyz19KJc7LCidszIOGfmxamjU3b4Xr2bM58J3pYHrQ
 PsWk96vUjzmhSy/5S48osuViAGrcoHNtRd47imVoo4d3qoD19qdfWb0sEH0nG7ogWH+f
 RNSJj3SRtgyucU9EMXTIe0aEoOpeYk0NtBOi0lPS+td/frTUwYL4oEmMRelhfo67yD5z
 wTQQ==
X-Gm-Message-State: AOJu0YxCPEDKTuC0iUK4wfYL1pPaAWzZ6m2E3o3o9Q/n8x81t9IFQMcD
 mlwf2wNz67/ci+IgYrgG+mDFuKRPQtO6ShQNF4bFSreB66wFZEkmKlgZ1sv6gRX/qWl5NMecRIv
 y8scX
X-Gm-Gg: AR+sD13/fBcmIOgTtBUlHCtY2WxrexKmT5SUbyw3MoeHaaPGL3ckYQET5eFBdo2NQXC
 AUbitW2pWk99idgebUUxp7NJ7qwGv0YIIiCC0iXIfgy5azFuGL+0E7qMqVV2jaQUm7BTIu/t/CI
 BXQnPyEODq039gWiztReYS7AQPiy7VZvD6DSDIjbpxR8Ni2Tweeoix2YrHkVbAx44LRiDfFRcMD
 rHs4U1LIN/6+FF4d9+Gg9OCSK2bIE23UzY0LcC6wnHgoJfUq/KE3myqmVBGd5MeR4mBUv3VAAJ9
 F8Mui4EH7aXriHZZ/Tga1PzWBgJm8zoysOlJn8zp+Uggq6cWkGalFZNvg5L7FShJj73O48QsH+8
 EuWnnhfZHSZrtxLr4vNq57O4SqCS1x/Ckb/B4R0HBYNVESwpScAObt792itOWEKuzMG0LBd14du
 Q3HorxHCK/Y7IY7y2BZj9QTOW8lgXbRl/bF9Gpg0eCaZkV1RmZGZhU0bt9ic8JlmD1ragVKMAB9
 cybUSnYlT8/HWk2WUQED0Mcw6hDIw==
X-Received: by 2002:a05:6a21:1b84:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3cc552dea6cmr10064174637.20.1786639644275; 
 Thu, 13 Aug 2026 09:47:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebcb6a97asm9953486eec.7.2026.08.13.09.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:47:24 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:47:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>
Subject: Re: [PATCH] net/sxe2: fix build when optional libraries are disabled
Message-ID: <20260813094715.5ce79773@phoenix.local>
In-Reply-To: <20260812175531.375636-1-stephen@networkplumber.org>
References: <20260812175531.375636-1-stephen@networkplumber.org>
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

On Wed, 12 Aug 2026 10:55:31 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This was found by AI sandbox build when doing other fixes
> to EAL. The sxe2 driver was doing handrolled meson to pick
> up AVX which fails if security library not present.
>=20
> Fix build failure when building with
> "meson setup build -Denable_libs=3Deal":
>=20
>   drivers/net/sxe2/meson.build:37:24: ERROR:
>   Unknown variable name "static_rte_security".
>=20
> Use sources_avx2 and sources_avx512 instead of hand-rolled
> static libraries.
>=20
> Fixes: 59d866861188 ("net/sxe2: add AVX2 Rx and Tx")
> Fixes: 0af0bdcdcf83 ("net/sxe2: add AVX512 Rx and Tx")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

AI check of CI AI review says all its complaints are noise.

Not valid. I verified every claim against the upstream tree and empirically=
 built it =E2=80=94 none of the four findings hold up. The review is a text=
book diff-only miss: all of its doubts hinge on infrastructure in drivers/m=
eson.build that it couldn't see.

What I verified:

Warning 2 (sources_avx2/avx512 "potentially unused") =E2=80=94 false. drive=
rs/meson.build initializes sources_avx2 =3D [] / sources_avx512 =3D [] per =
driver (lines 155=E2=80=93156) and processes them after subdir'ing (lines 2=
94=E2=80=93313), building static libs with static_deps and extracting the o=
bjects. Empirically: applied the patch, built with -Denable_drivers=3Dnet/s=
xe2,common/sxe2, and the final librte_net_sxe2.a contains both sxe2_txrx_ve=
c_avx2.c.o and sxe2_txrx_vec_avx512.c.o. This warning is also exactly the "=
should be verified" hedge pattern AGENTS.md tells reviewers to suppress.

Info 1 (CC_AVX512_SUPPORT removed) =E2=80=94 not an issue. The standard inf=
rastructure does cflags +=3D '-DCC_AVX512_SUPPORT' (line 305) when sources_=
avx512 is nonempty and cc_has_avx512, before the main driver lib builds. Co=
nfirmed in the generated build.ninja: sxe2_txrx.c.o (which contains the #if=
def CC_AVX512_SUPPORT burst-function selection) compiles with the define, a=
nd the AVX512 object gets the skylake-avx512 march flags. The standard cc_h=
as_avx512 gate is actually stricter than the old hand-rolled check =E2=80=
=94 it accounts for binutils AVX512 bugs.

Info 2 (dependency list removed) =E2=80=94 not an issue. static_deps is ass=
embled from the driver's own deps (static_deps +=3D get_variable('static_rt=
e_' + d), line 236), and sxe2's meson.build already declares deps +=3D ['co=
mmon_sxe2', 'hash', 'cryptodev', 'security'] =E2=80=94 visible in the patch=
's own context lines. The suggestion to consider dropping security/cryptode=
v is also wrong: sxe2_ipsec.c and sxe2_security.c are in the main sources l=
ist. Critically, routing deps through deps is the mechanism of the fix =E2=
=80=94 missing libs now cleanly disable the driver instead of hitting an un=
defined-variable error at setup time.

Warning 1 (missing release notes) =E2=80=94 false positive. The suggested "=
Fixed Issues"/"Bugs Fixed" section doesn't exist; release_26_11.rst has onl=
y New Features, Removed Items, API Changes, ABI Changes, Known Issues. DPDK=
 doesn't document bug fixes in main-branch release notes =E2=80=94 the Fixe=
s: tags handle stable backport tracking.

End-to-end confirmation: on the pre-patch tree, meson setup -Denable_libs=
=3Deal reproduces the exact reported error (Unknown variable name "static_r=
te_security"); on the patched tree the same setup succeeds with sxe2 cleanl=
y disabled ("missing internal dependency cryptodev"), and the default confi=
g builds the driver with both vector paths linked in. The patch is correct =
and complete as-is =E2=80=94 I'd reply to the CI bot noting the drivers/mes=
on.build infrastructure it missed, since the two Warnings are precisely the=
 vague-verification pattern AGENTS.md is supposed to suppress.
