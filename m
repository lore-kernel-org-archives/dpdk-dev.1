Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9DC54ED1
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 12:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 685D8402A1;
	Sat, 28 Jun 2025 14:49:28 +0200 (CEST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47]) by mails.dpdk.org (Postfix) with ESMTP id 44C4B4026F
 for <dev@dpdk.org>; Sat, 28 Jun 2025 14:49:27 +0200 (CEST)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-553c31542b1so716929e87.2
 for <dev@dpdk.org>; Sat, 28 Jun 2025 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751114966; x=1751719766; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLvj2IvMu16gNZ1VknpunFkl2IslnPRT2Zoom1g8S04=;
 b=JFWrZPBnUmLrplxPFpWUaspyyAs/+H/aXAC3sbmfK5M1NI/4PyDsEsLC+2k7Uly/NG
 pnRjPe+BPSehVkx5MP4iAZz5+37w00XyykYyTnBk3xhz0SfIyo2UXxs+yP/l6Pq4Rw2O
 b3CgQud4rMnvSz4iwUW2Rd8vaZmrlSbHtqJQYnlZlkJ/nLfztXf+awdXtUC7erVN2+WB
 mDkfjIkZIC+fKfEsgdCUQ6l6fAb//tnIGtyOYOzr2IsLb4D76dFNe/qF9M+FyfB0v5s8
 P/DdRxZJAqIdPhYH3uxLt+PC3264KfixT/7j49iPnpYAjNIvCUupGu+yKxEqiznd0VlF
 fTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751114966; x=1751719766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLvj2IvMu16gNZ1VknpunFkl2IslnPRT2Zoom1g8S04=;
 b=PHnh0/Nro1OKjyEZ2NWeYsUfrEwBz3/GBRoF2C/A+dpTiZKvhCGbG+UDyicaeo/5S7
 y5ByfoSaoD/tUIvZeIb9dOTux8eg2nYNGHRQjwDs5rhhTth0En3yzJAb2ActMex6KE69
 MQFxUZKYmh0mixEUlb73plDvRDfgwLt8PW+SLdkXQqllXRUHhNDVwoJWaQCoVc6rpOGN
 W6lL9lZg0d4gQHJWk4BfqSr3a7ngcjCufMwrJYb3NhdMR+CiSvQHaDV+9cqhQvcSG4y2
 4WN1N3w99G9DW/4VQqnAvelk1EpNT/IRegFe168QGZaPQ8sa7rXoA0lKsnxAVLnuEjp+
 VsMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1fCy6eZ0mEZOENH+jXxDl7PsKdxZV1q1tmPcjuVRxiNB4HFtA0+o9FmP8aK8xGk7vvCQ=@dpdk.org
X-Gm-Message-State: AOJu0Yy5yHaNLvWDuxhf+rJpxvcIJo+oXmZBeo5V7E64fz2FsxyuFWMy
 5BpOQ2JD5Abog0kivCC/2rVS0Kpj4DSBmIhB05ABV8P/isO+Adu+zr5OOG0eShSDnRHALhuQ9EO
 qIQL6zsKc1ON73tbySsFvH+vptZpGuM5Yp0hdi5FdMA==
X-Gm-Gg: ASbGncuSaU42nAczFTbulYtp69Xv6DlZpLt/nbWn/QNg/DrhDWc7o6QmjwbsavW5ap6
 2kjymGQr0hQKdCGbcJeGGK2bXIR+AA+2kui6HF3avxX6eGB8V0xS3JZwO52Xwuo0A7zzlriOTMZ
 iqmXysfUZWlVPacG5H9lyUnhH/yeysEznOFJb599oB0lcx6ptn
X-Google-Smtp-Source: AGHT+IH4PQgBI7lh6sh599IlHUMfiNthXNGD6pn58D2SCkAyp2k2Q+cRT04jsdT6hm5hP0Nvc3KIRNrNfxSSmDGtZrQ=
X-Received: by 2002:a05:6512:3b23:b0:553:35ad:2f33 with SMTP id
 2adb3069b0e04-5550b9e5d61mr2647960e87.37.1751114966515; Sat, 28 Jun 2025
 05:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
In-Reply-To: <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 28 Jun 2025 20:49:14 +0800
X-Gm-Features: Ac12FXwlTtngphwwuThopA-qCttpk2TI35nVeSY9qkEsxwGWAL5n6BMloYobLlQ
Message-ID: <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
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

On Fri, 27 Jun 2025 at 23:41, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Wed, 25 Jun 2025 at 20:14, Akhil Goyal <gakhil@marvell.com> wrote:
> >
> > > Realize async mode to replace sync mode for better performance
> > >
> > > v3:
> > > uadk 2.9 is released
> > > use different label name to fix build warning:
> > >       "duplicate label table_uadk_versions"
> >
> > I am unable to build uadk x86. It seems macros are not defined for x86
>
> Thanks Akril
>
> I can build uadk on x86 with https://github.com/Linaro/uadk/pull/680
>
> ./autogen.sh;
> ./configure
> make -j128
>
> But the build issue here is different,
> I can not build arm cpu instruction on x86, so only build arm cpu
> instruction on aarch64.
>
> Thanks
>
>
> >
> > make[2]: Entering directory '/home/gakhil/up/uadk'
> > depbase=3D`echo wd_alg.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
> > /bin/bash ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H =
-I.    -Wall -Werror -fno-strict-aliasing -I./include -fPIC -fPIE -pie -fst=
ack-protector-strong -D_FORTIFY_SOURCE=3D2 -O2 -ftrapv -Wl,-z,relro,-z,now =
-Wl,-s  -DUADK_VERSION_NUMBER=3D"\"UADK version: 2.9.0\"" -DUADK_RELEASED_T=
IME=3D"\"Released June 6, 2025\""  -g -O2 -MT wd_alg.lo -MD -MP -MF $depbas=
e.Tpo -c -o wd_alg.lo wd_alg.c &&\
> > mv -f $depbase.Tpo $depbase.Plo
> > libtool: compile:  gcc -DHAVE_CONFIG_H -I. -Wall -Werror -fno-strict-al=
iasing -I./include -fPIC -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -O2=
 -ftrapv -Wl,-z,relro,-z,now -Wl,-s "-DUADK_VERSION_NUMBER=3D\"UADK version=
: 2.9.0\"" "-DUADK_RELEASED_TIME=3D\"Released June 6, 2025\"" -g -O2 -MT wd=
_alg.lo -MD -MP -MF .deps/wd_alg.Tpo -c wd_alg.c  -fPIC -DPIC -o .libs/wd_a=
lg.o
> > wd_alg.c: In function =E2=80=98wd_check_ce_support=E2=80=99:
> > wd_alg.c:106:44: error: =E2=80=98HWCAP_CE_SM3=E2=80=99 undeclared (firs=
t use in this function)
> >   106 |  if (!strcmp("sm3", alg_name) && (hwcaps & HWCAP_CE_SM3))
> >       |                                            ^~~~~~~~~~~~
> > wd_alg.c:106:44: note: each undeclared identifier is reported only once=
 for each function it appears in
> > wd_alg.c:115:46: error: =E2=80=98HWCAP_CE_SM4=E2=80=99 undeclared (firs=
t use in this function)
> >   115 |  if (!strcmp("(sm4)", alg_tail) && (hwcaps & HWCAP_CE_SM4))
> >       |                                              ^~~~~~~~~~~~
> > wd_alg.c: In function =E2=80=98wd_check_sve_support=E2=80=99:
> > wd_alg.c:128:15: error: =E2=80=98HWCAP_SVE=E2=80=99 undeclared (first u=
se in this function)
> >   128 |  if (hwcaps & HWCAP_SVE)
> >       |               ^~~~~~~~~
> > make[2]: *** [Makefile:1055: wd_alg.lo] Error 1

This is solved by https://github.com/Linaro/uadk/pull/679
Will be merged next week.

Thanks
