Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF2C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D51C940695;
	Fri, 27 Jun 2025 17:41:39 +0200 (CEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by mails.dpdk.org (Postfix) with ESMTP id C4AE940A89
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:36 +0200 (CEST)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-32addf54a01so24820921fa.3
 for <dev@dpdk.org>; Fri, 27 Jun 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751038896; x=1751643696; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LOV7+bMDnDZnMdSS17gtw7TFgDuj755gd0lXTRErBU=;
 b=JlzkBOH2WmpalBSXWhDyegwZh98aP352mcA7J3lXc2jN4xlMS9kBS7/KO0gQq+IlZn
 75ulLjR2+5gCMasmx+PVTqxcugVI5GWNQAFAhdKInHjkrDOF9iNowiaOzUmm08VDXYyL
 /4nba0OM1c320cpcKJ2LzfLjB7RP8SJIyDayHHEFS1P/asCz1gm1LLCA8lq/u1HsHqJa
 wdTtSCVPKkt3E28je/rriSXQLJ/UuC1oBpRIYa14C+IzT8NtoldxeTmJSsiEySDgaKMT
 oApPHtTcv6xwuADb8+712URBkvAsLHMJC+9o0Pqlg95HraCK7l+ouqkyT7L9ZS3DcAES
 FZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751038896; x=1751643696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LOV7+bMDnDZnMdSS17gtw7TFgDuj755gd0lXTRErBU=;
 b=YwL4iHiu2zD+oxvQ1RAsyXCGPP7Sr0weyy6CSF8ELiga410rDhdP+JEfqPSMgd+87h
 NFNPI5waxjD7qmuze9Zs9BdQd6eQxDgypz7B0PCBnYnnXYRaNnYzBphBLxNLkTCM8ZIf
 kA2T8ycEol2hiFoqdioUPGDAWBWf4F+PxHARghb4vRvzkbo82CecjNi6ZQ8NIm5rNc5M
 chFlVYCfY3/LegjwliBvBGb8I7rAbnTe0xi0PycG1ok2tn9fyTMAW74lFmFDX5z588Np
 yqfkZJyR4q4syLyPbLujG50yvVAfFUMQ2Nfl2XuS0aymNuQyQCZUG+lJueQs8S/DlKHC
 F5Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHxvIpxxqO2a/lIBMBovwvq6ClmjU4O3eICZuAaLa6nD6gb3jSZ3j8bHyNVjvj07YiQdc=@dpdk.org
X-Gm-Message-State: AOJu0YwY+1FBTCMiM/RMPxMmz/V92iuzspmEdMgdfIFDdbJKlYKA6DtF
 2NEP+r8pkETnXbfPcVs7pyK7LGyV+xCwc4ts2Mx8YQxAEbU5feU8xWivq/sU+1qFM+mYxjkd4IA
 FNGpDkGZoSOjo4DWz29WwWCozQSFtFiTxmoqNY6k6Lw==
X-Gm-Gg: ASbGncuN4ackj9D/0cn7cGyxSmCCZDJacWRnyVOFtxWXPCxYkLL6FdylReZXgKmXWQG
 MLFitJG+Q6cpaKCT07SZ3hB41LNssQtclVogn7rPJCU7d4gybeEw2Z2BCXmpFyGCgLBw3sOA7h2
 Fc0KSWbNQ+E+ulooxueQtLJ8nKgI2r8H7kd6VjyuA37Y+9z8qMP96QyjSjX5w=
X-Google-Smtp-Source: AGHT+IHwKlTsUnXvKGN4DEixKnhxQnbXfLpp0c4SzjdBZvtDLFQFpkcBJsbj3vuNd83Qe4YHTIZJ9FhHpwp0fHzwwtM=
X-Received: by 2002:a2e:be03:0:b0:32b:5059:d66b with SMTP id
 38308e7fff4ca-32cdc50deaemr10997321fa.27.1751038896017; Fri, 27 Jun 2025
 08:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 27 Jun 2025 23:41:23 +0800
X-Gm-Features: Ac12FXxfKF8yvC60V2-wYPKv3l4ItngYcylvgo44KiLzAugcM5-xHOWM5GUJvbw
Message-ID: <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
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

On Wed, 25 Jun 2025 at 20:14, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > Realize async mode to replace sync mode for better performance
> >
> > v3:
> > uadk 2.9 is released
> > use different label name to fix build warning:
> >       "duplicate label table_uadk_versions"
>
> I am unable to build uadk x86. It seems macros are not defined for x86

Thanks Akril

I can build uadk on x86 with https://github.com/Linaro/uadk/pull/680

./autogen.sh;
./configure
make -j128

But the build issue here is different,
I can not build arm cpu instruction on x86, so only build arm cpu
instruction on aarch64.

Thanks


>
> make[2]: Entering directory '/home/gakhil/up/uadk'
> depbase=3D`echo wd_alg.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
> /bin/bash ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H -I=
.    -Wall -Werror -fno-strict-aliasing -I./include -fPIC -fPIE -pie -fstac=
k-protector-strong -D_FORTIFY_SOURCE=3D2 -O2 -ftrapv -Wl,-z,relro,-z,now -W=
l,-s  -DUADK_VERSION_NUMBER=3D"\"UADK version: 2.9.0\"" -DUADK_RELEASED_TIM=
E=3D"\"Released June 6, 2025\""  -g -O2 -MT wd_alg.lo -MD -MP -MF $depbase.=
Tpo -c -o wd_alg.lo wd_alg.c &&\
> mv -f $depbase.Tpo $depbase.Plo
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -Wall -Werror -fno-strict-alia=
sing -I./include -fPIC -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -O2 -=
ftrapv -Wl,-z,relro,-z,now -Wl,-s "-DUADK_VERSION_NUMBER=3D\"UADK version: =
2.9.0\"" "-DUADK_RELEASED_TIME=3D\"Released June 6, 2025\"" -g -O2 -MT wd_a=
lg.lo -MD -MP -MF .deps/wd_alg.Tpo -c wd_alg.c  -fPIC -DPIC -o .libs/wd_alg=
.o
> wd_alg.c: In function =E2=80=98wd_check_ce_support=E2=80=99:
> wd_alg.c:106:44: error: =E2=80=98HWCAP_CE_SM3=E2=80=99 undeclared (first =
use in this function)
>   106 |  if (!strcmp("sm3", alg_name) && (hwcaps & HWCAP_CE_SM3))
>       |                                            ^~~~~~~~~~~~
> wd_alg.c:106:44: note: each undeclared identifier is reported only once f=
or each function it appears in
> wd_alg.c:115:46: error: =E2=80=98HWCAP_CE_SM4=E2=80=99 undeclared (first =
use in this function)
>   115 |  if (!strcmp("(sm4)", alg_tail) && (hwcaps & HWCAP_CE_SM4))
>       |                                              ^~~~~~~~~~~~
> wd_alg.c: In function =E2=80=98wd_check_sve_support=E2=80=99:
> wd_alg.c:128:15: error: =E2=80=98HWCAP_SVE=E2=80=99 undeclared (first use=
 in this function)
>   128 |  if (hwcaps & HWCAP_SVE)
>       |               ^~~~~~~~~
> make[2]: *** [Makefile:1055: wd_alg.lo] Error 1

this is defined in include/wd_alg.h?
include/wd_alg.h:55:# define HWCAP_CE_SM3           (1 << 18)
include/wd_alg.h:56:# define HWCAP_CE_SM4           (1 << 19)

Thanks
