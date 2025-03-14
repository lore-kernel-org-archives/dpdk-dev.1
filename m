Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC3C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:31:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85C0D40263;
	Fri, 14 Mar 2025 18:31:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69D6D400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741973485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21tm/GqGK03usOJOtc/t3EQv0Okadhs7AD/jXmh38x0=;
 b=G2Ur5dP0zNcrF1nbIIvJRvglLjMl0VCKHVWVq8d1Jl6MNNdusVP94dwQ+l/XMfxvaSZh3r
 YfP4o4mnIvz0PIMd8htG0CUks8JX4zjCxpaqD2BN6Kh+jiM0h90jojEEp2I+TL7CVONaKN
 fyxkeqF7Lt7NizRCp0eX+FojybmKouo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-iOqi9od4NKyrIhixWGWZHA-1; Fri, 14 Mar 2025 13:31:23 -0400
X-MC-Unique: iOqi9od4NKyrIhixWGWZHA-1
X-Mimecast-MFC-AGG-ID: iOqi9od4NKyrIhixWGWZHA_1741973482
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5495a1c0be4so1465885e87.2
 for <dev@dpdk.org>; Fri, 14 Mar 2025 10:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973482; x=1742578282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21tm/GqGK03usOJOtc/t3EQv0Okadhs7AD/jXmh38x0=;
 b=lUsYrSxx2zUUQ3d/zU5tbYhjBZG/1pTpSUtJHYO4dC9pJjfVcEfzcH5NM2iuxhikcb
 +685Php6v/kjL61W5ZDoVqDfgBIIo+z79nsTDfgeyNSmFaSVKlyvQkdyRe3okQnW1fuB
 lF/l5QNABVT8ahdU4PcX9qrP0QxW3VRedHuIc/f9BeHGbQ/pTK30H4cMnz4p8CnfQPjV
 8+58U2AJIjH+Y7ZeTbYO/nhuZ1YORo/elkVR8q9eWs08bQjF5D/NLMqz1cKYyhhxUnkB
 Rj7rzEVO4r0PYx8VoFuqboCXqtCPwhxkSo2qo8CmDGfYDxG9nkSs3NwWkmkxexAfqqOk
 o9vg==
X-Gm-Message-State: AOJu0Yz2PCOBotW4+hN39nNMXMyr+SUT/nG4mvDyoRmlViAzuxfSuKe1
 WCnv32NunryzaTbl6tp1VhHT0yc6uDq9DiDqpStDp72hkXw2Mwwj86nyKk7j60DQ0Addj5z+4hB
 EtV+I0kG0oqjt9r2oaR5IGUyciXtTMu0EsnaVve5ApYfKrmuHv4Xd7/yIBnZKgxjiKJUYX6r1Hz
 AH+Yr+OFMnmhn+rY8=
X-Gm-Gg: ASbGnct87rH/fieX470pfrOqtUGoQSgbHb7MQwbJXOkF/xU7MMEoVmaxbXgK7jt7PsU
 VGpB6eJaputCTnwdqG+2ZBJlocueAlBdQ/fhpjC80OAgtU6cfFoi6H9YeDPfIDDUepFgYVJTWg4
 g=
X-Received: by 2002:a05:6512:3f11:b0:545:1082:918d with SMTP id
 2adb3069b0e04-549c3924a30mr1312494e87.41.1741973482177; 
 Fri, 14 Mar 2025 10:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCF8MV8Wcgx7Kaw1ESgR2RvVFA5paz/9oUgN4ipjGLDNB33g/49r8xm80hALMY0HVNogK+C+Me71tEGnmz1wc=
X-Received: by 2002:a05:6512:3f11:b0:545:1082:918d with SMTP id
 2adb3069b0e04-549c3924a30mr1312482e87.41.1741973481776; Fri, 14 Mar 2025
 10:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314172339.12777-4-bruce.richardson@intel.com>
In-Reply-To: <20250314172339.12777-4-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 18:31:08 +0100
X-Gm-Features: AQ5f1JrblupnQynFBa0w4ji95KneBqwecG3-jgBlNn8h8YIxknjTpgttDkkSLkk
Message-ID: <CAJFAV8y7WZN59PpAjCqLnM_=KXMi8U22xvp_K5tDwYCC3+-qyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers/net: build use common AVX handling
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, John Daley <johndale@cisco.com>, 
 Hyong Youb Kim <hyonkim@cisco.com>, Chaoyong He <chaoyong.he@corigine.com>, 
 Vamsi Attunuru <vattunuru@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uPWWLCgX5f8lN-Y3oYQONI4u704iNh1nFk7rg888PEE_1741973482
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

On Fri, Mar 14, 2025 at 6:24=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/me=
son.build
> index 1b34db3edc..9bf4627894 100644
> --- a/drivers/net/octeon_ep/meson.build
> +++ b/drivers/net/octeon_ep/meson.build
> @@ -15,18 +15,8 @@ sources =3D files(
>
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('cnxk_ep_rx_sse.c')
> -    if cc.get_define('__AVX2__', args: machine_args) !=3D ''
> -        cflags +=3D ['-DCC_AVX2_SUPPORT']
> -        sources +=3D files('cnxk_ep_rx_avx.c')
> -    elif cc.has_multi_arguments(cc_avx2_flags)
> -        cflags +=3D ['-DCC_AVX2_SUPPORT']
> -        otx_ep_avx2_lib =3D static_library('otx_ep_avx2_lib',
> -                        'cnxk_ep_rx_avx.c',
> -                        dependencies: [static_rte_ethdev, static_rte_pci=
, static_rte_bus_pci],
> -                        include_directories: includes,
> -                        c_args: [cflags, cc_avx2_flags])
> -        objs +=3D otx_ep_avx2_lib.extract_objects('cnxk_ep_rx_avx.c')
> -    endif
> +    cflags +=3D ['-DCC_AVX2_SUPPORT']

Could it be set by drivers/meson.build?
Similarly to AVX512.


> +    sources_avx2 =3D files('cnxk_ep_rx_avx.c')
>  endif
>
>  if arch_subdir =3D=3D 'arm'

--=20
David Marchand

