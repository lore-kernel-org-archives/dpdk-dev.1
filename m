Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED1C8302E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 10:08:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC7540264;
	Mon, 30 Jun 2025 12:08:06 +0200 (CEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mails.dpdk.org (Postfix) with ESMTP id DA3694025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:08:04 +0200 (CEST)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-32aabfd3813so19685921fa.3
 for <dev@dpdk.org>; Mon, 30 Jun 2025 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751278084; x=1751882884; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzraLlc0V1WL9wMw8+jej4JIvJsUOVlHeAZkx8c6+iQ=;
 b=PvkHWmpSFnlucmxbCRJNXaDDXPlmisQCrYX5OppgRtVih28SR1w/GbgpyFumkvWHVf
 8m+GSRQFNRcGMmVUQGngWVJvZv3SJSIsZ6asqnH2HhkSVrBhhU1XgqvSg4KGdrrcZJNa
 XvLdYFM3AJ2yKB25u6tdG7l4P6vFrPU9nkfkb3VBGU6EyRbWmVXxUxG3S4etkpNZyj9f
 ZRevvtMwjTSikgJlwQADq2LrMoLXwHShT3baVFiGFrfPHiS9aNgFR5mzZV5au+LDuE6C
 Q2isbHgcFpB0QoHrO6HlTggi/A5tkl1D8gcyFoNhlNHdfFaVpNJdEMgP8q0CLYX4yDUi
 RiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751278084; x=1751882884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzraLlc0V1WL9wMw8+jej4JIvJsUOVlHeAZkx8c6+iQ=;
 b=aq69muyG65eFXxRlw5KjLXnUWQD/Wp8RG+CwV2MBUK58Li9C5NqCkWLC4r+ZXyxaCS
 FeqJFZfMYEiEh9chFTqby9khN5VMJiRYShoKsNTlrcZQ0oMX/39cXSvViwI8Vhd3bLRR
 Svwog9DBsNWQ3LFAp/dlC3eUO3x7wcT5XDCXf2sDkKExvd2i4qS6ncBBOyY4aRQURmNk
 xbmLtPF9xzpLmcrGkCYKVyAeNB+XTv4F4TyDK81jiI9hcZWHsWb/xzg1kAUG2bhz7SHf
 f7ImGFxPb6Gmjwnx7k6sNiLWUbHbDuEeBDBoJfk3OaT/Tdkxp3jRaTQ0g4dG1XR/Ruir
 rEBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn96ZVjzq0jntjlhiNpc65A19wafshFPxfUbaiFv02/bVbqlJWRf76mQXY1VjfoSkrm/Y=@dpdk.org
X-Gm-Message-State: AOJu0YyAc8fN5t203ZeDRy8/Lxza4nWKQeXp3V7tJQuf+/075RkvzorS
 0Ebf9kd65ai1e43hEkksbTMOvznkKh29mk7XyJZsOpjUonMmhm4vgTXUGcFcqTNIJ9MBN/+C+1u
 HArnTvXV+x2KUm01MZFl67d5C+44FldOTNH5QEd6k7Q==
X-Gm-Gg: ASbGnctgbMxlK0fyaJQdnvaX2KRYenJt1IgkN045T3sp7nuuARxtIAu67A9Bs1VudkQ
 /B/I5ELXWABs5P7npkMTy3IwFxwm0tHgTgOd1FhItWPUKdAAIxLe/sq9B3sh4hDz+E+g8emgdG8
 coLnM96Zd/yfCuaLuOaL3QJMh59A335YQVuQdFTLt5cw4enO7+
X-Google-Smtp-Source: AGHT+IFCN2/H7E3Iqq8LBm1matvAIaM2Nfn/43b8E+n1ljt1IVOuDIjH8r2Q77aRkNgnhC2/uxbq9uoNiZ0+pw4UFZE=
X-Received: by 2002:a05:651c:20db:10b0:32b:73a8:9f75 with SMTP id
 38308e7fff4ca-32cdc4516demr23140661fa.9.1751278084060; Mon, 30 Jun 2025
 03:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
 <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
 <CO6PR18MB44841A3176C958FCD75E3AB3D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44841A3176C958FCD75E3AB3D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 30 Jun 2025 18:07:52 +0800
X-Gm-Features: Ac12FXye0r6Ft4K3ZPc1taQ124URw8zPQLudaKgGP99twRTOjDjuEs87218ZXx4
Message-ID: <CABQgh9HRhMK02y8eCNMhmWYq0MqUbZxNgp=bCHzUmwYU8jUjZQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
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

Hi, Akhil

On Mon, 30 Jun 2025 at 17:04, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > > > make[2]: Entering directory '/home/gakhil/up/uadk'
> > > > depbase=3D`echo wd_alg.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
> > > > /bin/bash ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFI=
G_H -I.    -
> > Wall -Werror -fno-strict-aliasing -I./include -fPIC -fPIE -pie -fstack-=
protector-
> > strong -D_FORTIFY_SOURCE=3D2 -O2 -ftrapv -Wl,-z,relro,-z,now -Wl,-s  -
> > DUADK_VERSION_NUMBER=3D"\"UADK version: 2.9.0\"" -
> > DUADK_RELEASED_TIME=3D"\"Released June 6, 2025\""  -g -O2 -MT wd_alg.lo=
 -
> > MD -MP -MF $depbase.Tpo -c -o wd_alg.lo wd_alg.c &&\
> > > > mv -f $depbase.Tpo $depbase.Plo
> > > > libtool: compile:  gcc -DHAVE_CONFIG_H -I. -Wall -Werror -fno-stric=
t-aliasing
> > -I./include -fPIC -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -O2 -f=
trapv -
> > Wl,-z,relro,-z,now -Wl,-s "-DUADK_VERSION_NUMBER=3D\"UADK version: 2.9.=
0\""
> > "-DUADK_RELEASED_TIME=3D\"Released June 6, 2025\"" -g -O2 -MT wd_alg.lo=
 -
> > MD -MP -MF .deps/wd_alg.Tpo -c wd_alg.c  -fPIC -DPIC -o .libs/wd_alg.o
> > > > wd_alg.c: In function =E2=80=98wd_check_ce_support=E2=80=99:
> > > > wd_alg.c:106:44: error: =E2=80=98HWCAP_CE_SM3=E2=80=99 undeclared (=
first use in this
> > function)
> > > >   106 |  if (!strcmp("sm3", alg_name) && (hwcaps & HWCAP_CE_SM3))
> > > >       |                                            ^~~~~~~~~~~~
> > > > wd_alg.c:106:44: note: each undeclared identifier is reported only =
once for
> > each function it appears in
> > > > wd_alg.c:115:46: error: =E2=80=98HWCAP_CE_SM4=E2=80=99 undeclared (=
first use in this
> > function)
> > > >   115 |  if (!strcmp("(sm4)", alg_tail) && (hwcaps & HWCAP_CE_SM4))
> > > >       |                                              ^~~~~~~~~~~~
> > > > wd_alg.c: In function =E2=80=98wd_check_sve_support=E2=80=99:
> > > > wd_alg.c:128:15: error: =E2=80=98HWCAP_SVE=E2=80=99 undeclared (fir=
st use in this function)
> > > >   128 |  if (hwcaps & HWCAP_SVE)
> > > >       |               ^~~~~~~~~
> > > > make[2]: *** [Makefile:1055: wd_alg.lo] Error 1
> >
> > This is solved by https://github.com/Linaro/uadk/pull/679
> > Will be merged next week.
>
> So are you going to update this patchset with newer version of uadk?

How bout just adding bug fix patches on master branch.
or have to ensure the dependent uadk release version build no problem
on both x86 and Arm?

It's our mistake that we ignored x86 platform.

Thanks
