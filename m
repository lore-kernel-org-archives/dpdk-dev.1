Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79340C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 06:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D964340156;
	Tue, 11 Feb 2025 07:23:59 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1D38640150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 07:23:57 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so48563855ad.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739255037;
 x=1739859837; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uDQgI2vzNMB07/1C/JG02Gbc8mNYzR7AGlp9IDXFvI=;
 b=IK+p+Vu1we33h/bVtFZzhZXd0bEy4XA2MQHMfV0eYDmczdQAAMfOKRlGwtkTcydW7G
 MB239rZxkbJ91S08sNjI1UDfQPUiYYXcjyVutkkid0sSMcjqEyjql1+mOA675txTCVKJ
 d1hxr/TAEbu6Eri0Bw+Is8b/VK8KmuieRlh9e9YtYeGnaAyB/tiBMqRlrwSjfBDmMD9i
 6HGhXGLuMY8mLyBg6AgxnoypAbcQf0YyMthNHsyizHp3/fcJjyw1X1ZNopHrs6F/wiuD
 4+znTipqcoWT4oJ7VFkVLSf4AytSopgWQ6GTfktwUaG/U1OrMUpA5Z+xowwRFKOD9av5
 JVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739255037; x=1739859837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uDQgI2vzNMB07/1C/JG02Gbc8mNYzR7AGlp9IDXFvI=;
 b=qIDSwkxYLhHGwV7JXOJ0GEEPyFk3orcmo93A9SSvvwkbv0DLOyN3qE3IhHv8V9PLF7
 BlLvs4hFBQJ/YkwvlgkB8Snsd4mX48wKjknlISI0UjTq6JinHmTyqeqH9NdQzELDihVy
 fp8reO67zOmDfzV6WXk8+ncIRqOkVnZaI6wDdUK/RsQvdRmFRjnB2Ckm8QGBVI/GtYX9
 FewvMj63gyAE4euYdWkOKw0QEPt32jBJTs0r2LeqtP7Zwk+RRyllSz2VPgpnmg2b4cZj
 Cq8RjA+WvLRqoGVn4LsCF2mxj32f3dezOlgoYUsurw/kgvXSrgbQml/1DjLSbdguzsTo
 J2Yg==
X-Gm-Message-State: AOJu0YxvV3++EtiBPry/iZzPyj/BXbek2F9cIP32v516LVn8uJ+XxSZJ
 +MMQOm4iFqjaTDNeI0LgbbY8sAvbrRyCyn/BjtCARldI+48yKMWzU8pajnCeugQgf6k67KNmLy0
 v
X-Gm-Gg: ASbGnctztYi1zEt/Fxf8JnHlZz4h39JoQfvP9kh4xAr1ACXUzZb6bMJrw54F11X74dP
 re3MsrYfXJMarVqFQhhBBWczGywa70veAsdk3A97nteQ9td6UwJaO4sqCR/KTjQpwkv9JDf1vjO
 Xe/9eBiBEzjHiep5OsPgUyVz5AhRNQSvFLNnqzOIrUgHE40/xoX/51mw7TTH0R5cjgDoTXJJ3bS
 9m4inSrcSAFutrYdlwB9Da5snX4GR+0WVT0+0Y0ObFSIe/NblS2jFYMSX8tjU32v2mMiImTyhor
 ZtIcP/uGPyDw0VeWmTSSoiqa2zBrmq2uuSwaTHQaVsxnvZILZ6XR77urPZCG9me6Sydx
X-Google-Smtp-Source: AGHT+IEqkIay/sXalTYKMJpKL1JKUDVDsIs5S/Fp+nlfTibPO+nOKqz6sazyeGVu5S6K/uyBSQw6mQ==
X-Received: by 2002:a05:6a21:6da9:b0:1e0:d5be:bf75 with SMTP id
 adf61e73a8af0-1ee4b769cf6mr3096481637.17.1739255037034; 
 Mon, 10 Feb 2025 22:23:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730962210f3sm2367711b3a.179.2025.02.10.22.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 22:23:56 -0800 (PST)
Date: Mon, 10 Feb 2025 22:23:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, kai.ji@intel.com,
 brian.dooley@intel.com
Subject: Re: [PATCH v6] net: add thread-safe crc api
Message-ID: <20250210222353.2b670260@hermes.local>
In-Reply-To: <20250210212710.708809-1-arkadiuszx.kusztal@intel.com>
References: <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
 <20250210212710.708809-1-arkadiuszx.kusztal@intel.com>
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

On Mon, 10 Feb 2025 21:27:10 +0000
Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:

> The current net CRC API is not thread-safe, this patch
> solves this by adding another, thread-safe API functions.
> This API is also safe to use across multiple processes,
> yet with limitations on max-simd-bitwidth, which will be checked only by
> the process that created the CRC context; all other processes
> (that did not create the context) will use the highest possible
> SIMD extension that was built with the binary, but no higher than the one
> requested by the CRC context.
>=20
> Since the change of the API at this point is an ABI break,
> these API symbols are versioned with the _26 suffix.
>=20
> Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
> ---

Thanks for updating so quick, but the problem is you need to move
the prototype for rte_net_crc_free() to get it to work.

-------------------------------BEGIN LOGS----------------------------
###########################################################################=
#########
#### [Begin job log] "ubuntu-22.04-gcc-mini" at step Build and test
###########################################################################=
#########
      |         ^~~~~~~~~~~~
/home/runner/work/dpdk/dpdk/lib/net/rte_net_crc.h:61:53: error: expected =
=E2=80=98)=E2=80=99 before numeric constant
   61 |         __rte_malloc __rte_dealloc(rte_net_crc_free, 1);
      |                                                     ^~
      |                                                     )
/home/runner/work/dpdk/dpdk/lib/net/rte_net_crc.h:60:1: error: old-style pa=
rameter declarations in prototyped function definition
   60 | rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_crc_type=
 type)
      | ^~~~~~~~~~~~~~~~~~~
buildtools/chkincs/chkincs.p/rte_net_crc.c:3: error: expected =E2=80=98{=E2=
=80=99 at end of input
In file included from buildtools/chkincs/chkincs.p/rte_net_crc.c:1:
/home/runner/work/dpdk/dpdk/lib/net/rte_net_crc.h:60:42: error: unused para=
meter =E2=80=98alg=E2=80=99 [-Werror=3Dunused-parameter]
   60 | rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_crc_type=
 type)
      |                     ~~~~~~~~~~~~~~~~~~~~~^~~
/home/runner/work/dpdk/dpdk/lib/net/rte_net_crc.h:60:69: error: unused para=
meter =E2=80=98type=E2=80=99 [-Werror=3Dunused-parameter]
   60 | rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_crc_type=
 type)
      |                                               ~~~~~~~~~~~~~~~~~~~~~=
~^~~~
buildtools/chkincs/chkincs.p/rte_net_crc.c:3: error: control reaches end of=
 non-void function [-Werror=3Dreturn-type]
cc1: all warnings being treated as errors
[629/2123] Compiling C object buildtools/chkincs/chkincs.p/meson-generated_=
rte_mpls.c.o
[630/2123] Compiling C object buildtools/chkincs/chkincs.p/meson-generated_=
rte_arp.c.o
[631/2123] Compiling C object buildtools/chkincs/chkincs.p/meson-generated_=
rte_ether.c.o
[632/2123] Compiling C object buildtools/chkincs/chkincs.p/meson-generated_=
rte_net.c.o
