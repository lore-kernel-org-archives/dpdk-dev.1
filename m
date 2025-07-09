Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A81AC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 06:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98EC402D7;
	Wed,  9 Jul 2025 08:51:57 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48]) by mails.dpdk.org (Postfix) with ESMTP id 4BDA54021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 08:51:56 +0200 (CEST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-558fc8f0750so187580e87.2
 for <dev@dpdk.org>; Tue, 08 Jul 2025 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752043915; x=1752648715; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JCt47747eLuvQRdZ7iwt+OyQqWrmlFmx58GuiYkEuC8=;
 b=W+71GfguPhC3rMYT5hSIJhpLKRu5HICnS+XuDuPS43TIAWAJ281M/PSGnHPymAxEdY
 CQT88f/bqkVardnnohpvtANSmptTmuzuJXrKxUn8knhhA/DkKDO3NDfN3CB8OeJdmtzs
 7u+0IzAEImHD+k2pP4vDywYZ2vrSRAXJ7QY21LjjMfe1fKhRjWGbidYWyBeN/gCSuW+6
 f6ozfAoE5+2F8rFjVx2iCEL7pWthXaE4WCDbFE3bkqjXijKMsliYGBW9nRGuAYdfvDsX
 xlAGaY8TXfmRXYiDrWpILJihCvKHQlVdW5qC4z+kGPLYYh6LuHkEEzB4ghm4APpFMoVj
 T5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752043915; x=1752648715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCt47747eLuvQRdZ7iwt+OyQqWrmlFmx58GuiYkEuC8=;
 b=N3BLsQK4qHDNokTFUAXt/wAlmPaYMEVAjeajMz2lKBdDvZYoyl+LuOcAP7xgjalLol
 tsnqwGKtu7QpX0EPZCyFgoY7VeykbvPmtPt4sW9mMCCvdJKlH17ed07wPoEFQXyRskf5
 wkYJkZm3Cual8Tlpv9U1ueyPoqEJeJ5lUBUqn5Ll/PiOfgeWU8vavNAp29edBKsuNsgC
 kr8+2eknLFChG8VOcatGVNh7SEZlCLB3HJrs+VUcbitqv02A9JH4zJl/9zal1Vprwmkv
 SAk+Ku9MR+KCcx+0/B3ZMsW3RFp1cfTpkbdICZ7+8ig3w/mg0A+nWjfwkox8ahKKubud
 jj4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmoqLfy/4bqyYK4aL9K5eApTCfUqeBFfTA+SYYVx7xl7CpQZZeZcWCjcmFG+yqfszNY98=@dpdk.org
X-Gm-Message-State: AOJu0YzVYfnXmAzowxb2iWDqEDeIPURo5QEJJI7VVqdDUoqJlOtHhhQS
 HdBlkspgNq6vnD7FxUY06TiIw+zoT5IERhksRzOZwWB8/fY4PRQ3VH1aFufNj14c7oV3n+T2e/U
 U7siT7+iurTZVGwuW04g/dUBET3QxyFGiryk888BihA==
X-Gm-Gg: ASbGncu/+ff+MseMoI4+M/p/hA32PZoBgGJ/a0YmhNPXRSYr5qT+HB7X24XrxPuxxkE
 Gb2FdoSdKg25q3RRnmJq15i2Ldooh9m/uUZukpIyVk2tLxeWO0S4FSZPBaukBNK4C7sE/j+U6J5
 jldnWh+FP3PW8oCHNh+3owRvCvKQTPPIJZoE8oWrx9IYwKQKYb
X-Google-Smtp-Source: AGHT+IFErHpMVJacBo7BKP2KnBeXFGXcBOPZYVN6ijzTewgVgiavSOpn2tUEX+poPrAJjRSo3E+fL0Q3Zz4446z4448=
X-Received: by 2002:ac2:4e04:0:b0:54e:81ec:2c83 with SMTP id
 2adb3069b0e04-558fa8b2024mr564072e87.18.1752043915455; Tue, 08 Jul 2025
 23:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250702024216.49587-1-zhangfei.gao@linaro.org>
 <20250702024216.49587-3-zhangfei.gao@linaro.org>
 <CO6PR18MB44842C3119B81D8486565BDED84EA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44842C3119B81D8486565BDED84EA@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 9 Jul 2025 14:51:44 +0800
X-Gm-Features: Ac12FXxKeyqgYUaRCFvpOb643Yt22bSBrJ_rt7RuucjNioEXFcG30JO69EqBrLg
Message-ID: <CABQgh9Gu5qXky6b+UPihHY5RMMGdUbL=fPv8XLvyU0t39TLgMw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v4 2/2] crypto/uadk: use async mode to replace
 sync mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 9 Jul 2025 at 03:33, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > To get better performance, using async mode to replace sync mode
> >
> > However, case UADK_CHAIN_CIPHER_AUTH and UADK_CHAIN_AUTH_CIPHER
> > still use sync mode for the first operation and async mode for
> > the second operation since the dependence.
> >
> > Also RTE_CRYPTO_AUTH_OP_VERIFY will hold the generated auth in
> > qp->temp_digest[idx % BURST_MAX] to verify later.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  doc/guides/cryptodevs/uadk.rst                |  15 +
> >  doc/guides/rel_notes/release_25_07.rst        |   5 +
> >  drivers/crypto/uadk/meson.build               |   4 +-
> >  drivers/crypto/uadk/uadk_crypto_pmd.c         | 297 ++++++++++++------
> >  drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
> >  5 files changed, 234 insertions(+), 95 deletions(-)
> >
> > diff --git a/doc/guides/cryptodevs/uadk.rst b/doc/guides/cryptodevs/uadk.rst
> > index d38dffbcd9..7591c0e94b 100644
> > --- a/doc/guides/cryptodevs/uadk.rst
> > +++ b/doc/guides/cryptodevs/uadk.rst
> > @@ -112,6 +112,21 @@ Test steps
> >        RTE>>quit
> >
> >
> > +As a reference, the following table shows a mapping between the past DPDK
> > versions
> > +and the UADK library version supported by them:
> > +
> > +.. _table_uadk_crypto_pmd_versions:
> > +
> > +.. table:: DPDK and external UADK library version compatibility
> > +
> > +   ==============  ============================
> > +   DPDK version    UADK library version
> > +   ==============  ============================
> > +   22.11 - 25.03   2.4  - 2.8
> > +   25.07+          2.9.1
> > +   ==============  ============================
> > +
> > +
> >  Initialization
> >  --------------
> >
> > diff --git a/doc/guides/rel_notes/release_25_07.rst
> > b/doc/guides/rel_notes/release_25_07.rst
> > index e57cf546c2..5e8cb0e512 100644
> > --- a/doc/guides/rel_notes/release_25_07.rst
> > +++ b/doc/guides/rel_notes/release_25_07.rst
> > @@ -98,6 +98,11 @@ New Features
> >
> >    * Added support for AMD Solarflare X45xx adapters.
> >
> > +* **Updated UADK crypto & compress driver.**
> > +
> > +  * Update to init2 interface which requires v2.9 of the UADK library.
> > +  * Update to asynchronous mode for better performance.
>
>
> This shall be v2.9.1. Right?
>
> > +
> >  * **Updated virtio driver.**
> >
> >    * Added support for Rx and Tx burst mode query.
> > diff --git a/drivers/crypto/uadk/meson.build b/drivers/crypto/uadk/meson.build
> > index e46abd21e5..00cd7d1c44 100644
> > --- a/drivers/crypto/uadk/meson.build
> > +++ b/drivers/crypto/uadk/meson.build
> > @@ -13,7 +13,7 @@ sources = files(
> >  )
> >
> >  deps += 'bus_vdev'
> > -dep = dependency('libwd_crypto', required: false, method: 'pkg-config')
> > +dep = dependency('libwd_crypto', version: '>=2.9', required: false, method: 'pkg-
> > config')
> >  if not dep.found()
> >      build = false
> >      reason = 'missing dependency, "libwd_crypto"'
> > @@ -21,7 +21,7 @@ else
> >      ext_deps += dep
> >  endif
> >
> > -dep = dependency('libwd', required: false, method: 'pkg-config')
> > +dep = dependency('libwd', version: '>=2.9', required: false, method: 'pkg-config')
>
> Here and in your compress patch also, the dependency version should be >=2.9.1. Right?
> Please fix these mismatches as soon as possible. We are closing RC3 tomorrow.
> If it is not merged in RC3, will be deferred to next release.

Have updated.

Made a uadk 2.9.1 release as well for this.

Thanks for your patience.

Thanks
