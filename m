Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F8C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 10:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C84C140656;
	Wed,  9 Jul 2025 12:25:12 +0200 (CEST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43]) by mails.dpdk.org (Postfix) with ESMTP id 6A64B4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 12:25:11 +0200 (CEST)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-553b5165cf5so6540383e87.0
 for <dev@dpdk.org>; Wed, 09 Jul 2025 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752056711; x=1752661511; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7nwm8Kz+VU+q8pEtIgxUY4JF3wjRiwZPlIpD7IW7nMM=;
 b=cUXMybUa54qhC37qO9nNKWdw2fcBXOcRa67CWdkQYJzX4upfwtHsW8Vzt7jwqKLIf/
 O8msMINLmWYyTqbHzThm2uj/TAlEhoWyHm3jns6dBeLXelJZEHuptlT1Pa0bUdynPVBk
 UuPFQdnsFR1sB1ygW+0dIbFckA6gdYloObOorPA4IE1sheRxmBg/a9DaGccic0q3EsQO
 l4Dyl31UyViVrYwWOdXaV2bZEPUhuzUpEv3B2jll8gH0z5Km8wgySumqerMYXjqXRnB8
 gBF2MJgal/yKKD+6jwiXGqUppsitnlGjgd0bFkkHrujIf6x69dWKA15vmMOEsYyuDJPy
 fR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752056711; x=1752661511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nwm8Kz+VU+q8pEtIgxUY4JF3wjRiwZPlIpD7IW7nMM=;
 b=O2HXqPcKXdMFwEH2X6Zv4XR9n2obOK2o/GLCWVbJh3sVOGZWvSQTDwYyqFpYZpWJLR
 b/zWi0uNjA60OWkS4da44himwzQ2zp6laKkgxWW8pN0Odjer6GL/rfO2z70YzrcRGz4Y
 wpohLi0p8tGB4dDMMwZjrZ6P0N3p2IpQevNEw26vunFykdv3YhuOQi1hu8EEPcu20mL9
 xZ4f9ywJZqi3HPjTOQYapv/qQtoJF6Vp0c4cTm7IEyCnGlTK901rDlARvKs3dRmaKF5h
 IHtIceSu+CrLa0zA5u5B3wE3KGyl03At/9n1j72j4Pk4AbD0/O3zgjDbf2arik3HF4Vu
 WIlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdybMrBwU1a3qxJlq/IjPrLmjgxJebreWr2n/e9oc9jxGk0BJ5ijcegI0UMxqiStUiClE=@dpdk.org
X-Gm-Message-State: AOJu0YxUZ9WbsDovgibEmY3ZEPQbTQyuRduRRoLmOb8y6G6qzGJAs6JE
 Rfc5SvnZMLW4bmrc90iRm/AaPFsm0OpSb7M+YM3uEMw8pETND6T9ggWIWLGqdoWxq4MlQ6hwbgE
 YQCSxgZFdC7nRf870CmeuZwssPf0nAmoiEeaMLWmvJw==
X-Gm-Gg: ASbGncuKkgYS1Mg+Ej+iYImcNWcbXnnrm6ZMFhg9fYWDTt0pjxoXq5AImKqZB+Kx2tl
 Kb4ZQFGMYx5tkBwOtKRwHJP3miBI80SSJrLc2fV6NOq18mGIO4+sQEVNF+SNrpd6ft9FehQ/WoR
 yZ1+hvtl8m96D+D+0OrW69ZXFn74WvA0I11X8PlMGD/CX72aDW
X-Google-Smtp-Source: AGHT+IHfHxJG0Fwv/p30VjJg9RfLv5S6vg0MbM9e+jHJMhDR0Ape/O1NgYezNTQiD7OEsIXUeOKGfOFe7GMQqEi1Yy0=
X-Received: by 2002:a05:6512:3195:b0:553:25b2:357d with SMTP id
 2adb3069b0e04-558fa913e20mr659576e87.52.1752056710618; Wed, 09 Jul 2025
 03:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250709064701.100676-1-zhangfei.gao@linaro.org>
 <20250709064701.100676-2-zhangfei.gao@linaro.org>
 <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9H7+WTpMbU_xQXKAzrNV4yucxe=rswdpXEapY4bsnfXLQ@mail.gmail.com>
 <CO6PR18MB44843776C190BA6E914BF5C8D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44843776C190BA6E914BF5C8D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 9 Jul 2025 18:24:58 +0800
X-Gm-Features: Ac12FXx7o9vqc6WYba_freprdefrsU9bGfuPkNWgYzTawSz5n5ogOY_YN66LPvA
Message-ID: <CABQgh9E3aGaFCtUGvLH0R1qf3yuM6VWvxQ7KDG+n+D=H+iPrBA@mail.gmail.com>
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

On Wed, 9 Jul 2025 at 18:03, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > On Wed, 9 Jul 2025 at 15:19, Akhil Goyal <gakhil@marvell.com> wrote:
> > >
> > > > To get better performance, using async mode to replace sync mode
> > > >
> > > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > > ---
> > > >  doc/guides/compressdevs/uadk.rst              | 15 +++
> > > >  drivers/compress/uadk/meson.build             |  4 +-
> > > >  drivers/compress/uadk/uadk_compress_pmd.c     | 94 ++++++++++++++-----
> > > >  .../compress/uadk/uadk_compress_pmd_private.h |  2 +-
> > > >  4 files changed, 86 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/doc/guides/compressdevs/uadk.rst
> > > > b/doc/guides/compressdevs/uadk.rst
> > > > index a29043e0c0..8812fd180a 100644
> > > > --- a/doc/guides/compressdevs/uadk.rst
> > > > +++ b/doc/guides/compressdevs/uadk.rst
> > > > @@ -96,3 +96,18 @@ Test steps
> > > >       sudo dpdk-test --vdev=compress_uadk
> > > >       RTE>>compressdev_autotest
> > > >       RTE>>quit
> > > > +
> > > > +
> > > > +As a reference, the following table shows a mapping between the past DPDK
> > > > versions
> > > > +and the UADK library version supported by them:
> > > > +
> > > > +.. _table_uadk_compress_pmd_versions:
> > > > +
> > > > +.. table:: DPDK and external UADK library version compatibility
> > > > +
> > > > +   ==============  ============================
> > > > +   DPDK version    UADK library version
> > > > +   ==============  ============================
> > > > +   24.07 - 25.03   2.4  - 2.8
> > > > +   25.07+          2.9.1
> > > > +   ==============  ============================
> > > > diff --git a/drivers/compress/uadk/meson.build
> > > > b/drivers/compress/uadk/meson.build
> > > > index 34113cd08c..32cadd02ea 100644
> > > > --- a/drivers/compress/uadk/meson.build
> > > > +++ b/drivers/compress/uadk/meson.build
> > > > @@ -13,7 +13,7 @@ sources = files(
> > > >  )
> > > >
> > > >  deps += 'bus_vdev'
> > > > -dep = dependency('libwd_comp', required: false, method: 'pkg-config')
> > > > +dep = dependency('libwd_comp', version: '>=2.9.1', required: false, method:
> > > > 'pkg-config')
> > > >  if not dep.found()
> > > >      build = false
> > > >      reason = 'missing dependency, "libwd_comp"'
> > > > @@ -21,7 +21,7 @@ else
> > > >      ext_deps += dep
> > > >  endif
> > > >
> > > > -dep = dependency('libwd', required: false, method: 'pkg-config')
> > > > +dep = dependency('libwd', version: '>=2.9.1', required: false, method: 'pkg-
> > > > config')
> > > >  if not dep.found()
> > > >      build = false
> > > >      reason = 'missing dependency, "libwd"'
> > >
> > > I am seeing this now
> > > Dependency libwd_comp found: NO. Found 2.9 but need: '>=2.9.1'
> >
> > Hi, Akhil
> >
> > The master has merged a release patch 80adefa this afternoon
> > https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__github.com_Linaro_uadk_commits_master_&d=DwIBaQ&c=nKjWec2b6R0m
> > OyPaz7xtfQ&r=DnL7Si2wl_PRwpZ9TWey3eu68gBzn7DkPwuqhd6WNyo&m=zu_lC
> > 2WIV6KqBhSa15SOw4sYvI6W3SromCy_Z_A19mliFmfbx6fQsi8SVmdY7OVv&s=oYs
> > SVDbopcr5aRNW6_Z36Jup6ccbKTve3V1Gp6jUtPo&e=
> > And the https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__github.com_Linaro_uadk_tree_v2.9.1&d=DwIBaQ&c=nKjWec2b6R0mOyPaz
> > 7xtfQ&r=DnL7Si2wl_PRwpZ9TWey3eu68gBzn7DkPwuqhd6WNyo&m=zu_lC2WIV
> > 6KqBhSa15SOw4sYvI6W3SromCy_Z_A19mliFmfbx6fQsi8SVmdY7OVv&s=Yt0A8F8
> > o96plEAsy4VfmELvDkjGPwh3YkcpcXzWtbaY&e= has updated to the
> > release 2.9.1
> >
> > Would you mind re-check.
> >
> Still getting this
>
> Dependency libwd_comp found: YES 2.9.1 (cached)
> Dependency libwd found: NO found 2.9 but need: '>=2.9.1' (cached)

it may be because we ret-tag v2.9.1 to the 80adefa, removing the old
tag may be required.

git tag -d v2.9.1
Deleted tag 'v2.9.1' (was 999f79b)

git fetch origin
From https://github.com/Linaro/uadk
 * [new tag]         v2.9.1     -> v2.9.1


git fetch origin
git checkout -b 2.9.1 v2.9.1
git log --oneline
80adefa Merge pull request #681 from gaozhangfei/rel-2.9.1
0f75d0f uadk: release 2.9.1
51915ff Merge pull request #680 from gaozhangfei/check_x86
34df8cf uadk: check whether host cpu is aarch64
d593554 uadk: fix the compilation error on x86

sudo rm /usr/local/lib/libwd*

./cleanup.sh;
./autogen.sh;
./configure
make -j128
sudo make install

 ls .libs/
