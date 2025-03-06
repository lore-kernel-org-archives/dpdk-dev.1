Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E5C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B3B54065F;
	Thu,  6 Mar 2025 14:57:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C8D51402DE
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741269455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b75fHFfj1hlPKBh2NMIfPrBbmE3Lhv0ldyxiJ4rTdAM=;
 b=eifDVhgjno7qfQiyA45Z9v68X+fOSzpFDgdFY/bJMhK9KivOYb1sRRFKTBGimpK/5A+934
 Rrw/3BHracsshW/ug6RU/T88XwVK+rze8MB6aaqqiB91x9jDL/LTsotyFCsbh8WBYMvMZG
 2cc9AJ6q01yOKrKXnAOamRYRdkGKcso=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Diq3aub8PQK6qa0xvHGLYg-1; Thu, 06 Mar 2025 08:57:18 -0500
X-MC-Unique: Diq3aub8PQK6qa0xvHGLYg-1
X-Mimecast-MFC-AGG-ID: Diq3aub8PQK6qa0xvHGLYg_1741269437
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30bb9d4619eso3435741fa.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269437; x=1741874237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b75fHFfj1hlPKBh2NMIfPrBbmE3Lhv0ldyxiJ4rTdAM=;
 b=vLmNbzRaHQ5s1hNja/7XgwCptyHqED+Z+DFqdnTaL9U365lbRfakH98R+NFQ6CAbgq
 DYQ2IF4G3OTjVazoNgsMm0Y4OnTZr6Dt8/SNX+g2sv0YaArWA8jz45xT8eW+oxFFnTxE
 NsZV9/PJ9uRpdu/szYoev3d3Dl2Hqx0ZdZNr7ups/vFeyrr+lnPkEtcblR/gmgu7ZK6P
 8bVp/o+MGeYKDRvi1UTcMetRrfCJF66jFR6ZYoLb1DlLBU+E9T3rZ/hFyAQWY6e+ipmi
 HSeStney4GKuG6pQ1cvXLFf/RIPYE/WvCYYf8u+gGRe03pJExju+9qrzOlfmT2DOuw0I
 9u3g==
X-Gm-Message-State: AOJu0YysKOj3011imu/awyGOL9fx6U4Gw68O1aojq+nl976Z6kpoz3OR
 bKkaZRGy1gtrkrJjXnoX4+JFg+synL1SXkw03Yh9AWiQbpIiZW2YJ1QekQb2n+lEVeAEiH9GXxb
 iBh8LGcXZNG2hdLRxhJAPzbCR+c74Wcf6sBPStiNjb/f+tDg97VXz1Dbdfoc3ySc625iUvDsRUR
 SB1rZR0A13n5bxDJw=
X-Gm-Gg: ASbGncssXiyPz91LV5fakra0JMaElom+ugVhHRkZ/7L8pfZTp0pR71YJ9ip1c56lFW2
 4QIIQndPP+XRUYCEQ4Dr3JPS8SeTJbreoXdxfY1/9dkYy/qRugoRs5ul0kFY7Rb19czdnim8nZe
 U=
X-Received: by 2002:a05:651c:1509:b0:308:eabd:2996 with SMTP id
 38308e7fff4ca-30bd7a1a757mr31287601fa.5.1741269437123; 
 Thu, 06 Mar 2025 05:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFlLzu9UD22qSZoh1NFAEivMusVnD1SIF50OAR1H261EKru8o8oJMy7/q6DV+byZEAxlOIWElXq5oS2GJAADQ=
X-Received: by 2002:a05:651c:1509:b0:308:eabd:2996 with SMTP id
 38308e7fff4ca-30bd7a1a757mr31287411fa.5.1741269436704; Thu, 06 Mar 2025
 05:57:16 -0800 (PST)
MIME-Version: 1.0
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:57:04 +0100
X-Gm-Features: AQ5f1Jqn01vqKp7eHSlQmRFa4P-3ap1Y3cmdRlt4vXfunCtyKboAKlBdEa13Jwk
Message-ID: <CAJFAV8wrOkCs9OKg2f87p_qU6qFJQYTS5i-7T8zPvEN5N2XXGA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] allow faster instruction sets to be used with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3KTdRWSHUisBeDHCJTVpzt7Pf_qaAN6uZbj24qSdl4w_1741269437
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

On Wed, Feb 26, 2025 at 10:21=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Meson.build files were refactored to add MSVC support for the AVX2
> instruction set with MSVC: Top level variable cc_avx2_flags was created
> and set according to the compiler used. It is used in lower level
> directories.
>
> Andre Muezerie (3):
>   eal: make compatible with instruction set updates for MSVC
>   eal: only use numbers as align parameters for MSVC
>   config: create top level variable cc_avx2_flags
>
>  config/x86/meson.build             |  6 ++++++
>  drivers/net/bnxt/meson.build       |  2 +-
>  drivers/net/enic/meson.build       |  2 +-
>  drivers/net/intel/i40e/meson.build |  2 +-
>  drivers/net/intel/iavf/meson.build |  2 +-
>  drivers/net/intel/ice/meson.build  |  2 +-
>  drivers/net/intel/idpf/meson.build |  2 +-
>  drivers/net/nfp/meson.build        |  2 +-
>  drivers/net/octeon_ep/meson.build  |  4 ++--
>  lib/acl/meson.build                |  2 +-
>  lib/eal/common/rte_random.c        |  2 ++
>  lib/eal/x86/include/rte_vect.h     | 11 ++++++++++-
>  12 files changed, 28 insertions(+), 11 deletions(-)

Series applied, thanks Andr=C3=A9.


--=20
David Marchand

