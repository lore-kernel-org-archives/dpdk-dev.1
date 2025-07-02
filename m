Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27250C8303D
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 02:09:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5389D40298;
	Wed,  2 Jul 2025 04:09:17 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id 60A6640264
 for <dev@dpdk.org>; Wed,  2 Jul 2025 04:09:16 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-553b5165cf5so8453152e87.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 19:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751422156; x=1752026956; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kR/Iq0YfKH1/89nAk7aLGvPFItwQmd3X2iO5gvcnSi8=;
 b=jA1MWFSLIPmyYIUvO+jw/LHdtZVWVmw8cbr6ERt54Jp8g9g846bIRQEv+m01Dhz+sI
 HU+qLwvDQPPYQll64dGgdDfvkEHoaxSzViEOBjWA8rBzKQXgZe+uNfrLOnGj3nSrzh3T
 g2AJ/qkutpgDV4LlBqmnkRlmN53975705eJzilRz/yHFe1asoqjSKy4Ta8W8UqGvK5rq
 SCa6OHpSeZOZ0NnhcipDnDjWARE1jCBEkyNVjExtuT+Xlp370u6ERWfNidd7MW+hhz/c
 wrAah6d+3XZnmv4gAYCyhVBNdn0Mw/Fy6XByyfj/6pGhdBHtz7hQn4FQ6h6tZy4OD9/c
 CYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751422156; x=1752026956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kR/Iq0YfKH1/89nAk7aLGvPFItwQmd3X2iO5gvcnSi8=;
 b=frW50b7SzwRwOpmOkRdMk/SmcxlJlSDBX2IAYUn664ANKX3sg6YPVkd7R9sTzNNdqg
 n7k7N96Wdok2Hqz1IyGBrXiSklbkUBaTnZFszSgPUcwhn7/qHfJtzcZ36Epxfseou75t
 3WOBsFfmFqlL5ghCGrvPFpjqwPWJXZr4/4Z0oTjK/kPE2SUrjnWTtHPej1etBjr6FBTj
 um3R39gxvdbTuEVXzr1YeIJr2znrGCzZO62EofHxrS8uWhTwYk3fMNCOLGEErkQKjqqi
 7Oou8SfHc5fClzuvEodLWrNMT+3Cr51Jrmcyu7lYfqhTMRD9KT/n8tyeDA5EEJq3OipR
 gdsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDSYtSwFp5ivsAV5qVdjpjatURv/XfqkC5Rnmh0OFVyrKsAXh7HSdb1UDt/zT9Ybykvhw=@dpdk.org
X-Gm-Message-State: AOJu0Yx2/Ne3F++tYoMWcmwky9uoSUfbjzZ7bHtYXsixTwffxMfhuioV
 bQLzlNSdt4ISDsz1Mq/BSKsG6gHNC5qlnVfaDjXbUzuNc7utF1Lsp0DgUZVYZ8hdFVrun3Ji2gd
 08a2dEwvJI8QgPugmQgeR5gpssXfPCnEJ4AQcOCyszA==
X-Gm-Gg: ASbGncuPfegBKnVggA6KvvUsKIVNelIqdKp8jEmCpu6HcuFqJkz1Zlnr7yyeU7BWBxH
 EOA+NPml1eicqpDaawgc3xECaXexHAnhfLT5K3jA4RuNMacEOmy/p8atN7LQPTp2CSH+rNbeXuL
 FHGdI18IfWAXz9B4y5y/FnpV7xTAczPe42Is5kHACc0ehpgvsKoKXqhw==
X-Google-Smtp-Source: AGHT+IFXGGpgbm+H1XPxAXkJfpBxh2UAbsp5Kr9siu8nSNBFsUgYq9KGIYswoP+ozYY8kbLJW79CEgOfJSYbO1n2J0g=
X-Received: by 2002:a05:6512:b97:b0:553:cfa8:dd38 with SMTP id
 2adb3069b0e04-5562831ba82mr356583e87.36.1751422155601; Tue, 01 Jul 2025
 19:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
 <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
 <CO6PR18MB44841A3176C958FCD75E3AB3D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HRhMK02y8eCNMhmWYq0MqUbZxNgp=bCHzUmwYU8jUjZQ@mail.gmail.com>
 <CO6PR18MB448406CE61F820DE93117452D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB448406CE61F820DE93117452D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 2 Jul 2025 10:09:04 +0800
X-Gm-Features: Ac12FXyw7NCmV6n7qp3S-0lQ4unvpbfyCwPFbPOK0InQ2sSSjistMk9Uq1lEqnE
Message-ID: <CABQgh9FewcOCRkxOSLCK+in2G_XhFHY9EoR=_sGbpc==_ARqzQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 30 Jun 2025 at 18:15, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > Hi, Akhil
> >
> > On Mon, 30 Jun 2025 at 17:04, Akhil Goyal <gakhil@marvell.com> wrote:
> > >
> > > > > > make[2]: Entering directory '/home/gakhil/up/uadk'
> > > > > > depbase=3D`echo wd_alg.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;=
\
> > > > > > /bin/bash ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_C=
ONFIG_H -I.
> > -
> > > > Wall -Werror -fno-strict-aliasing -I./include -fPIC -fPIE -pie -fst=
ack-protector-
> > > > strong -D_FORTIFY_SOURCE=3D2 -O2 -ftrapv -Wl,-z,relro,-z,now -Wl,-s=
  -
> > > > DUADK_VERSION_NUMBER=3D"\"UADK version: 2.9.0\"" -
> > > > DUADK_RELEASED_TIME=3D"\"Released June 6, 2025\""  -g -O2 -MT wd_al=
g.lo
> > -
> > > > MD -MP -MF $depbase.Tpo -c -o wd_alg.lo wd_alg.c &&\
> > > > > > mv -f $depbase.Tpo $depbase.Plo
> > > > > > libtool: compile:  gcc -DHAVE_CONFIG_H -I. -Wall -Werror -fno-s=
trict-
> > aliasing
> > > > -I./include -fPIC -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -O=
2 -ftrapv
> > -
> > > > Wl,-z,relro,-z,now -Wl,-s "-DUADK_VERSION_NUMBER=3D\"UADK version:
> > 2.9.0\""
> > > > "-DUADK_RELEASED_TIME=3D\"Released June 6, 2025\"" -g -O2 -MT wd_al=
g.lo
> > -
> > > > MD -MP -MF .deps/wd_alg.Tpo -c wd_alg.c  -fPIC -DPIC -o .libs/wd_al=
g.o
> > > > > > wd_alg.c: In function =E2=80=98wd_check_ce_support=E2=80=99:
> > > > > > wd_alg.c:106:44: error: =E2=80=98HWCAP_CE_SM3=E2=80=99 undeclar=
ed (first use in this
> > > > function)
> > > > > >   106 |  if (!strcmp("sm3", alg_name) && (hwcaps & HWCAP_CE_SM3=
))
> > > > > >       |                                            ^~~~~~~~~~~~
> > > > > > wd_alg.c:106:44: note: each undeclared identifier is reported o=
nly once
> > for
> > > > each function it appears in
> > > > > > wd_alg.c:115:46: error: =E2=80=98HWCAP_CE_SM4=E2=80=99 undeclar=
ed (first use in this
> > > > function)
> > > > > >   115 |  if (!strcmp("(sm4)", alg_tail) && (hwcaps & HWCAP_CE_S=
M4))
> > > > > >       |                                              ^~~~~~~~~~=
~~
> > > > > > wd_alg.c: In function =E2=80=98wd_check_sve_support=E2=80=99:
> > > > > > wd_alg.c:128:15: error: =E2=80=98HWCAP_SVE=E2=80=99 undeclared =
(first use in this
> > function)
> > > > > >   128 |  if (hwcaps & HWCAP_SVE)
> > > > > >       |               ^~~~~~~~~
> > > > > > make[2]: *** [Makefile:1055: wd_alg.lo] Error 1
> > > >
> > > > This is solved by https://github.com/Linaro/uadk/pull/679
> > > > Will be merged next week.
> > >
> > > So are you going to update this patchset with newer version of uadk?
> >
> > How bout just adding bug fix patches on master branch.
> > or have to ensure the dependent uadk release version build no problem
> > on both x86 and Arm?
>
> How is the DPDK user supposed to build your driver without proper tag of =
uadk?
> May be apply a hot fix tag(2.9.1 or something) on UADK and mention that i=
n your driver doc.
> You need to ensure when someone picks a particular DPDK release,
> your driver can be built with the version mentioned in your PMD doc.

Thanks Akril for the guidance.
Have applied a fix tag v2.9.1 to solve the x86 build issue.
https://github.com/Linaro/uadk/releases/tag/v2.9.1

Will update the patches.

Thanks
