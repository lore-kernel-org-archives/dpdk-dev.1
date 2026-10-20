Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F8606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oveSAy4B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07BEE40283;
	Tue, 20 Oct 2026 16:34:35 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 447BB4025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:34:34 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so1806837a91.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792506873;
 x=1793111673; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3D8eD1eJpvEbhlgc/nVS5aWYdgjXJA4XtnkpSrJ6dZo=;
 b=oveSAy4BT6hHzJjbeGqfsoRIh3H1xXFMQRGvEWxbUVSj84t+A38SOXsKHDLK7L99gG
 Zghaq1fGrndqml/o3Y0IbnHI+MKsQDI3ONKb+bHLRCSIxxzRVMJQMnuTHV67Pmi6JvLI
 qUS2wjkZQ8rW5i8de6IxmVQ8a7KVcozMurGzwDcOt8nRuF8F5KGEwzvWmgE3j8AaOFMP
 4ZkFYOxeOrMA2NJ6aDbMFqRiSpcGkKtBZbB1Y25yZrfPFCq5ExzHm7ucl96zo5SfyKJL
 APVUAi2vquK7r0I8NuRcpQtknb6OPWAdObq8VeG8XE0tm7//I9ImiEev8fqS9nhXeSIy
 sZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792506873; x=1793111673;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3D8eD1eJpvEbhlgc/nVS5aWYdgjXJA4XtnkpSrJ6dZo=;
 b=i0+y92DdE7s1o+BXcTVxA1vbqfFEGoEKIyvfmJ4z3w/4kDdW2RygASqXX5FZNbn2Wg
 C2/8ePjFSQU1R6X3Z1U+9jmIEjukgcFTdPIU4LCzg1qixRDuxTPiCFAyMJJRavzvO/G0
 7WELbCamL9cn9PgHwYVtsfT3KeK4dL/DFwlSZZ/MsgbtnRwqpo38u/OwN+mjvJ+m37RB
 FghLHdh4hwJgiFnqIZOjPPJ5z363ZdAlBxoMqnZOi6IlAVLuZaL+u5lDE5o9gEELTvpw
 hAaH5Aq+sG7k+wsCV5b++REWtg7ZB2HVvev2WEXL8JibJwtafBvxV2HKld3DLDH/7mX0
 lfGw==
X-Gm-Message-State: AFq9FYJR6VCvdhc0JRaZ4N0RItErPv1PkDXqJCM2YglGjjysV6e/5xFW
 JkC+cSC38i4SX+XpSePeTtECKwZTUSBT/pa7y5BxtzlK/nZuccUVVkLExAQFcsLsiYY=
X-Gm-Gg: AYBFou0Z8Y54GFmZJcukvcyRjL18HBE1xGjUXtBFfGdAV7n2l4Cb2W1KNJuccLAln6X
 K89ki37zIdgH17yL4h+5mON6iFhwtKUScE2NphhFEhem23VaGGHDC3lRoxLWUj4bU9qrG/2Je5I
 GsLvlG38djan+qY37LDTbnikDbQ3LQDT+WLUfoewbJYMckNPpcQP2ABUf/Yr8gW/Kz7zs4/gxsS
 2DikbmHnvX6kJDAmckEdL7o4T8CEA1NPHCtTAa76s3wh3Z4zCKzljolZnq8as8VQaRQUW5WBEvO
 Pga5IY+tqLo+cO7NddALeRWdZhbEnh8KeMXMVLLXs2xALpf+vOXtSkqGn2+SR5e3MzExh72Omf4
 4uUx6QgGffgPltHBo8Q3/CDgttfABXgNMHINnIBN3UgIs2sBji+I/wlHolIIKWwpZ1R9lMWzDfU
 c+6NycexAIerL/dQ7FBnbI7JCTEpjBWkIjLmRQeyHYYzFS+MuRmAYFX5mmuJhajlhEvpwHqaNLx
 D3JDaI4FStCNJ1ZwEg1UniY0oYJepyp8Xg0SS/4
X-Received: by 2002:a17:90b:2889:b0:3ac:c90a:10d2 with SMTP id
 98e67ed59e1d1-3acef10e086mr10008175a91.30.1792506873181; 
 Tue, 20 Oct 2026 07:34:33 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec450asm3564793a91.3.2026.10.20.07.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:34:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 07:34:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Bruce Richardson
 <bruce.richardson@intel.com>, Ali Alnubani <alialnu@nvidia.com>
Subject: Re: [PATCH] stack: fix pile GCC memcpy warnings
Message-ID: <20261020073430.04ce3bb4@phoenix.local>
In-Reply-To: <20261020084944.3188987-1-mb@smartsharesystems.com>
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 08:49:44 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> On architectures where rte_memcpy() is defined as memcpy(),
> GCC warns about source/destination overflow when copying more than the
> source/destination size, even for code paths that are not taken in cases
> where the sizes are smaller.
>=20
> The relevant compiler warnings were disabled for GCC at the two
> occurrences, and comments describing the reason were added.
>=20
> NB:
> It has not been investigated which GCC versions are affected.
> GCC version 10 and up was chosen because that was what the previous
> versions of x86 rte_memcpy() disabled sligthly similar warnings for.
>=20
> PS:
> The alternative was to obfuscate the code, but that would make the code
> less readable, and might have unintended effects on architectures and
> compilers not suffering by this issue.
>=20
> Bugzilla ID: 2061
> Fixes: ee0822a0ef41 ("stack: introduce pile")
>=20
> The pile was introduce with this DPDK release, so no need to backport.

Rather than playing "what a bug with pragmas" a better solution is to disab=
le
the warning globally if optimization is disabled.

=46rom d79d5a1c4d7b7d43e31b26f5d5e218155f699ac0 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 20 Oct 2026 07:26:42 -0700
Subject: [PATCH] build: disable GCC string op warnings when unoptimized

Without optimization GCC's -Wstringop-overflow and -Wstringop-overread
are flow-insensitive: they check a memcpy() against the object size
even on paths that are dead for the inlined arguments. This breaks
debug builds of app/test with -Werror on lib/stack/rte_stack_pile.h,
and has required local pragma workarounds elsewhere.

Disable both warnings when optimization is 0. They stay enabled for
optimized builds, where the analysis is flow-sensitive.

Bugzilla ID: 2061

Reported-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 745097e8aa..ac90b9d4fa 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -378,6 +378,12 @@ if cc.has_argument('-Wno-comma')
     no_comma_cflag =3D '-Wno-comma'
 endif
=20
+# GCC's string/memory access warnings are flow-insensitive without
+# optimization and produce false positives on dead paths of inlined code.
+if get_option('optimization') =3D=3D '0' and cc.get_id() =3D=3D 'gcc'
+    global_cflags +=3D ['-Wno-stringop-overflow', '-Wno-stringop-overread']
++endif
+
 foreach arg: global_cflags
     if cc.has_argument(arg)
         add_project_arguments(arg, language: 'c')
--=20
2.53.0

