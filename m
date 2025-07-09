Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC83C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 09:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53FC1402AE;
	Wed,  9 Jul 2025 11:34:38 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id 0E7EB4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 11:34:37 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-55622414cf4so4915561e87.3
 for <dev@dpdk.org>; Wed, 09 Jul 2025 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752053676; x=1752658476; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qNxNRU3v+g2NCnfXMXWAZMYcXMZb413wtDPLpjHMoLw=;
 b=SSy0xO1zlBS2NN53Ie5CMFRElf90C53WGQNDs447dEPF7O+R/AI2O2DWJeqHB9Rbdr
 +U5vORlZ0PcMrmwGHgi7N/E+N+yxlQPUpZTUFN11yO8NVj8eWuFJUUGMRExaT10qCb3x
 mKVgBSahOnuK6TnKP8P1iOFNLjYxfyY4PF1qE0PoeXP/BgUw4jJU4XFAmMpuaXcutSI8
 BjcdfmTDMPNkBdS5A8I+C/VlB2wRcDhBk+G+d4/yJDXslKYti/eMHjeTWihcT2w8/rh1
 TJXLkr5V3cFi49NdbCU+ACV+qeb72YAWJVnchIAQ38tiwx6Bv/x4D//foAK/qws3Iixo
 wVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752053676; x=1752658476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNxNRU3v+g2NCnfXMXWAZMYcXMZb413wtDPLpjHMoLw=;
 b=ZAx5i7e/s35qf4nTTPDnKAVCZk9SnhYeOsGWn3ZwiiRxiUskktpz6Dryi+XV5DcLKY
 +IkBaL7S5ZpDHPxInIY8Y+FB68E/ocSGJ+Lz7dlDPy8XMZwhbSqPxfdSj96DPeL0MX2O
 IWZSI0JQA3G31ya7jd0NJu2AztLG0mZ9DPubXMsjYzZCbTFhNGC8uXh94QsRF++nTlpq
 EsYRLQjrSlaQxN8y6c3oAzlOR/T+6uyXGsfXtOJpxMuu4XfaqmZ5h8zS9ydFwAtOqFQm
 eeLvHLc5c9C5hmm9HPyzm2HFGX0X6D1OcDVFqvMy4Xb7qzU0sQAfI+cTgWWDumPQHQxC
 IyZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa4MK+WbpHzR2/IGlmBDu2MIl+zH9FqzrcHaQVM4glnpmkC5jvM/Ylui7opt9zcmdG7bM=@dpdk.org
X-Gm-Message-State: AOJu0Yw/zmRmh94WuiuubHgZQ0yJoRFCP13lFekkdUeeFxdgZHks4BSE
 RzQZrVr2gZrqwxIvh0IThOT8wl6v6rHsyflbGOW0SEAc6N7ZmgIhHSmHlS1IusOBAUih5xIh4VA
 9853cTYU0JV9tecxB/aLDOtCnzlV+sfDik0d7tJBAmw==
X-Gm-Gg: ASbGncszw6ga66LT3HWdX0koruydVs/pbbuaqCPZ8NTzmt1pxWlzJgy9YYO0CVL/gsA
 3ThxqDMGCtY28OXnDlG0GQ7PL+3riJ3QrFiY5IQQZSqCDbEAjAXiWGSMEldzSD1fn3md0oU/gJ4
 dv+eGkk1mTliw/J/DwlneOkQapSoWc5D48gv8FX7vTeMfHKSX7
X-Google-Smtp-Source: AGHT+IH80u+P0gf7pKhAUeFv4G9r7erI6ucEmPEKeJ2M6Ub0hri1cpHzlODILylFUbEwDeXsCKd2S/24Ti9BUyjoRxc=
X-Received: by 2002:a05:6512:400d:b0:552:1c1b:561 with SMTP id
 2adb3069b0e04-558fa8ab16dmr576713e87.23.1752053676339; Wed, 09 Jul 2025
 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250709064701.100676-1-zhangfei.gao@linaro.org>
 <20250709064701.100676-2-zhangfei.gao@linaro.org>
 <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 9 Jul 2025 17:34:25 +0800
X-Gm-Features: Ac12FXzqO6YWP9nhtkMkRyrdmKzMMwA4CJ3zYdcW_oWJ3owKslUM9QmYHR4Hhf0
Message-ID: <CABQgh9H7+WTpMbU_xQXKAzrNV4yucxe=rswdpXEapY4bsnfXLQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
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

On Wed, 9 Jul 2025 at 15:19, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > To get better performance, using async mode to replace sync mode
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  doc/guides/compressdevs/uadk.rst              | 15 +++
> >  drivers/compress/uadk/meson.build             |  4 +-
> >  drivers/compress/uadk/uadk_compress_pmd.c     | 94 ++++++++++++++-----
> >  .../compress/uadk/uadk_compress_pmd_private.h |  2 +-
> >  4 files changed, 86 insertions(+), 29 deletions(-)
> >
> > diff --git a/doc/guides/compressdevs/uadk.rst
> > b/doc/guides/compressdevs/uadk.rst
> > index a29043e0c0..8812fd180a 100644
> > --- a/doc/guides/compressdevs/uadk.rst
> > +++ b/doc/guides/compressdevs/uadk.rst
> > @@ -96,3 +96,18 @@ Test steps
> >       sudo dpdk-test --vdev=compress_uadk
> >       RTE>>compressdev_autotest
> >       RTE>>quit
> > +
> > +
> > +As a reference, the following table shows a mapping between the past DPDK
> > versions
> > +and the UADK library version supported by them:
> > +
> > +.. _table_uadk_compress_pmd_versions:
> > +
> > +.. table:: DPDK and external UADK library version compatibility
> > +
> > +   ==============  ============================
> > +   DPDK version    UADK library version
> > +   ==============  ============================
> > +   24.07 - 25.03   2.4  - 2.8
> > +   25.07+          2.9.1
> > +   ==============  ============================
> > diff --git a/drivers/compress/uadk/meson.build
> > b/drivers/compress/uadk/meson.build
> > index 34113cd08c..32cadd02ea 100644
> > --- a/drivers/compress/uadk/meson.build
> > +++ b/drivers/compress/uadk/meson.build
> > @@ -13,7 +13,7 @@ sources = files(
> >  )
> >
> >  deps += 'bus_vdev'
> > -dep = dependency('libwd_comp', required: false, method: 'pkg-config')
> > +dep = dependency('libwd_comp', version: '>=2.9.1', required: false, method:
> > 'pkg-config')
> >  if not dep.found()
> >      build = false
> >      reason = 'missing dependency, "libwd_comp"'
> > @@ -21,7 +21,7 @@ else
> >      ext_deps += dep
> >  endif
> >
> > -dep = dependency('libwd', required: false, method: 'pkg-config')
> > +dep = dependency('libwd', version: '>=2.9.1', required: false, method: 'pkg-
> > config')
> >  if not dep.found()
> >      build = false
> >      reason = 'missing dependency, "libwd"'
>
> I am seeing this now
> Dependency libwd_comp found: NO. Found 2.9 but need: '>=2.9.1'

Hi, Akhil

The master has merged a release patch 80adefa this afternoon
https://github.com/Linaro/uadk/commits/master/
And the https://github.com/Linaro/uadk/tree/v2.9.1 has updated to the
release 2.9.1

Would you mind re-check.



>
