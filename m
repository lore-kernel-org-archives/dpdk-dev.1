Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1BCC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 13:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D4740273;
	Wed,  2 Apr 2025 15:05:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 54FB540261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 15:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743599122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEQjEhV5Zg/JoZb6BKXAaRfnX48a2FaQXbEFTEgk2EI=;
 b=DVwOCgtCZ5JAV/mt/2Yldx70aSnizwA3q6xZ59QDrwHMK1qFVR8F0fsHUwvAGe6kQTk2DR
 Vy+4yvpYGd56aiJs+rytD/F0tL6SiKOtQYu8tv1alZJE/E3Y6d0l8xYKYeBrwHGN6h+wrx
 0QfiuWKnYyWw7t/PjBHViaxYK1Knypw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-YcrBoGU1OzWSG1ALkMibig-1; Wed, 02 Apr 2025 09:05:20 -0400
X-MC-Unique: YcrBoGU1OzWSG1ALkMibig-1
X-Mimecast-MFC-AGG-ID: YcrBoGU1OzWSG1ALkMibig_1743599119
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5496d38f725so3238365e87.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743599119; x=1744203919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEQjEhV5Zg/JoZb6BKXAaRfnX48a2FaQXbEFTEgk2EI=;
 b=YdxjPFg3NXv0Ta3VfwDZp0pjmnOC8og6B8mMu6ZYjqPMKnTlxQ+EfLyeg8Gvgs8Q7y
 Y0aUMPa/4jx5semlvKJJ9mAjGs6FwVmmsd74mdLCkI9X3ALrLA/CUrNdDves71XFWZBe
 J3p/72KzIcoyjh2sZGPyuFearyW1bBsbWsl9AUU51GjIBSeLECstn6exoi3gMLoh9jJl
 BHjkI9exNz9pFiT7BXFzNmoY2Oj3CkPoKzB72atrw3syhgzVnuScuy1vYCIlcvqAw8Rz
 UU+pUog7c85GAZ7iOLoVkIBV2wjEB91aPGvyeHSY/mSZp5N4rsRfqUtFTkz9FkJl6d5I
 O/9Q==
X-Gm-Message-State: AOJu0YyvIRJJMBZrLoaIjesCw8bJ+kKeYAdJcB3F040eKrptGywEJCMU
 PKixt11hfB+Y24CzP9tGay1sHnOmE+zh2Tvw8FhoxvDubWwdfJ4wvw6TLw4I9uQgiBnqGwjhM0S
 QDlVA3Ze1gg8/lqgh8PObRUMSM/xymzUtm95L4fhMNkZDDTTwhatp4Lzssyk40QTO09VVUf7UKo
 YHgb8874kZjBHtHaM=
X-Gm-Gg: ASbGnctYffAPMCrvYbL3V/7Nyi35B3+NAYMV6C3/04vm6JB5B8wNBqX0ryAXpUnB9Ak
 nZx4ZPnCm8NdiKI5/SS9Qsn+/o+YRGEL8gl9nMk3VGDY5aI/ONw9LjiJMPHmtWH7kXHivIXCS2P
 8=
X-Received: by 2002:a05:6512:2508:b0:54b:102b:af56 with SMTP id
 2adb3069b0e04-54b10d93684mr6530677e87.4.1743599118896; 
 Wed, 02 Apr 2025 06:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGecPE1VlpedKi5oiwiFc0FW/f05kgHxAn1nk1tRHu7ZfFR11yqbRhx0iqIyr0tN0NzCmxL0XYwKMYoXXlLLdk=
X-Received: by 2002:a05:6512:2508:b0:54b:102b:af56 with SMTP id
 2adb3069b0e04-54b10d93684mr6530624e87.4.1743599118469; Wed, 02 Apr 2025
 06:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250331161000.9886-6-bruce.richardson@intel.com>
In-Reply-To: <20250331161000.9886-6-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 15:05:07 +0200
X-Gm-Features: AQ5f1JobOUJt_wg-NcaXL5rHirVxSb5LmyJ4eXmDJdZGL6-SmenNLbwdfLsYMjI
Message-ID: <CAJFAV8yOLW2SiTDg6QdyDmZJN29aV=Mtu0OBWP=0mRwOuerZiA@mail.gmail.com>
Subject: Re: [PATCH 04/10] net/intel: use common base code build handling
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cPppAjvW8Azw8k24SAA5p3Zy-GryoiLIJOQCOr6gBy4_1743599119
X-Mimecast-Originator: redhat.com
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

On Mon, Mar 31, 2025 at 6:10=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/i=
ce/base/meson.build
> index e7ba9c34bc..f453005a1d 100644
> --- a/drivers/net/intel/ice/base/meson.build
> +++ b/drivers/net/intel/ice/base/meson.build
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2018-2021 Intel Corporation
>
> -sources =3D [
> +base_sources =3D files(
>          'ice_controlq.c',
>          'ice_common.c',
>          'ice_sched.c',
> @@ -29,7 +29,7 @@ sources =3D [
>          'ice_ddp.c',
>          'ice_fwlog.c',
>          'ice_vf_mbx.c',
> -]
> +)
>
>  if is_ms_compiler
>      error_cflags =3D [
> @@ -41,22 +41,14 @@ else
>              '-Wno-unused-but-set-variable',
>              '-Wno-unused-parameter',
>      ]
> +    # Bugzilla ID: 678
> +    #if (toolchain =3D=3D 'gcc' and cc.version().version_compare('>=3D11=
.0.0'))
> +    #    error_cflags +=3D ['-Wno-array-bounds']
> +    #endif

Why keep it commented?


>  endif
>
> -# Bugzilla ID: 678
> -if (toolchain =3D=3D 'gcc' and cc.version().version_compare('>=3D11.0.0'=
))
> -    error_cflags +=3D ['-Wno-array-bounds']
> -endif
> -
> -c_args =3D cflags
> -


--=20
David Marchand

