Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6FC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 12:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C402D4066F;
	Wed, 11 Jun 2025 14:59:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 95473402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 14:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zf4h3aeij+bIWbWMkIe24MDPvlYRyeeIBS5kdDsNe6E=;
 b=ccnSeO2HVEI2Hs182HGYJoIj8hl5RCClTgkkacAOu82bjj9Tifyg41DXGFi8+3VwPZz86f
 1ZdxWl6mZCms2cU5bQpHCobXmqwZbjmLheTPtFjmptKfg9PGx4xRM9OQxl6aH2R4kowgAy
 refmxweczfptREurPUjNaaEM2VpQiHc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-TGKLfX-uNVK0B5ZR2u8JXw-1; Wed, 11 Jun 2025 08:59:54 -0400
X-MC-Unique: TGKLfX-uNVK0B5ZR2u8JXw-1
X-Mimecast-MFC-AGG-ID: TGKLfX-uNVK0B5ZR2u8JXw_1749646793
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-32a6c630b70so36702631fa.2
 for <dev@dpdk.org>; Wed, 11 Jun 2025 05:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749646793; x=1750251593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zf4h3aeij+bIWbWMkIe24MDPvlYRyeeIBS5kdDsNe6E=;
 b=VPghQOGZiMPf4/ZEjB7BnkzHFY47iey9Hyg5N55q6bT2tv249FtWjxFR0uYPZjYEng
 90A9lVkMe12tsrJolqX7BIPiBrTrZVfWec8Dpe7+cEVwAknAd37LZChZecB3yBo0F+vt
 xq1AVQsQA115nroO5FA2w4qRcEG+gKQBuBMaQU9T9cuf8VG90TCwJRhPh+XxwaywVQ1f
 0cEh3dUVeJutxm4Si1oEq+klR0C9Y+qrOeu1VVAhr2tecdmFDQOrL2YKxQB/Erg1apxo
 q6iuYMQHC6+CTcAvKQHLKuWO1IdMdIdROj2UTJ2/iguMFY4EPryNVy51/DL2/X1IjuUT
 drGA==
X-Gm-Message-State: AOJu0Yx2Ee44yXl+mZ2cqQdvXFMpDEP/YYOGt54/vmkzPEm87cK8lDTG
 rUVJg742OdslPgJWfi/eI7zRSMF+oYD3lNm1P3BzdKCkov1KNuUrPnaUIqPIVcIdpkIeRaeEO9h
 /CKzKYoCGlg2hYTWs7v+OT4w4Bibgf/QgHsVYaz1d5IkGjTCUuzgWgpVz9nfctcS4R88vNBNjLO
 HbH1MzJ9TuEsot50P/ml4=
X-Gm-Gg: ASbGncuzj53nVHRoQ5yV3NrMVGeF44anir7DhyyghsvJ82hKBbCPyraqUu2PrxWlK55
 TBexuU30u83WBaYhRSAjpk5225/lhfIUYHWpP3GuV31LvCKbNWrBONnLf/QDMHTI1YPGKv8o4Ss
 lo1oeT/A==
X-Received: by 2002:a05:6512:b9c:b0:549:5b54:2c68 with SMTP id
 2adb3069b0e04-5539c1181aamr1066513e87.22.1749646792693; 
 Wed, 11 Jun 2025 05:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ+U7s5OdGhVuZHqxuHeLNoztIpsl3J199f5dvSdWSJmaDSgjB7mLEhIfdsAYFGMYRkmPr2nN0zEB+hWYtXpA=
X-Received: by 2002:a05:6512:b9c:b0:549:5b54:2c68 with SMTP id
 2adb3069b0e04-5539c1181aamr1066502e87.22.1749646792292; Wed, 11 Jun 2025
 05:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250326133010.168470-1-ian.stokes@intel.com>
 <Z-QC_jX3z3Vva-ut@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-QC_jX3z3Vva-ut@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 11 Jun 2025 14:59:40 +0200
X-Gm-Features: AX0GCFugpSmhfmY1TNWYD3PWiP9v8oZsZfWNxnmuhxCWUEuEuku0j4UhPf8OI9Q
Message-ID: <CAJFAV8zOJGqoqWFPKXvqwOEWfTrkB17tnxH4spwE0aS3ZePZBg@mail.gmail.com>
Subject: Re: [PATCH v1] maintainers: update for iavf and i40e
To: Ian Stokes <ian.stokes@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FtZH_Wh0RUm_rwEuXU2xXTHMgtd8OMNwQRYtZZzSQZo_1749646793
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

Hello,

On Wed, Mar 26, 2025 at 2:37=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 26, 2025 at 01:30:10PM +0000, Ian Stokes wrote:
> > Removing myself as maintainer for iavf and i40e.
> >
> > Signed-off-by: Ian Stokes <ian.stokes@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>

Thanks for all your contributions Ian.
Applied.


--=20
David Marchand

