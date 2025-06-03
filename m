Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54771C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A790A40DD1;
	Tue,  3 Jun 2025 16:19:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5CDC40B9C
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748960351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtp9K7yqbD6SyXJtS2Fw+1DqD1lHexjJupVl0UeJF20=;
 b=VIa/NEdPDlKpyYdYbsSVjy6Hj+BrYdRACJPAfDTEEzB7lULOhSF04l2oS00mRiwC0WVagh
 lHgRjCJ3KXgDPcwDSnyTvZErlDXm29tE/IDm7LaDHAmb+MoWbP7Nf8hLlr77E8UHdrjYWp
 FCZD8zeQiiBtFBfVjPSi51e/kb3mXAc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-CuOaB2iRMziDxxpRuT6bKw-1; Tue, 03 Jun 2025 10:19:01 -0400
X-MC-Unique: CuOaB2iRMziDxxpRuT6bKw-1
X-Mimecast-MFC-AGG-ID: CuOaB2iRMziDxxpRuT6bKw_1748960339
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55212e53d50so2727262e87.1
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960291; x=1749565091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtp9K7yqbD6SyXJtS2Fw+1DqD1lHexjJupVl0UeJF20=;
 b=UpAm+4svHgjnPeGuQWPEWGWFvaEF/Eq4CvOCCPWGeAnRsTg6W8n0WANmH03SIERgZx
 KeExqiIqC8qWn95jRPnf+K8O0iGKcdNMTwY5q8SPDbzPf9CfKPREhAYPMB25neyrMRns
 k0ya3zGGgI7FXGRP8/lC25dY+Aero9cDhhi5AAbjJJ5EEFijsegK/qZCLypkaUi1IQbS
 eqs/LPJSkvQGKTzwGjEa+HuNjPCq8I58+HmmhLYYLdTuMTHISDtiBw/QzFOj7qZRCZ3G
 Z0dQNDsPPHfjxdlz8IGhllEeviCmWcetPH5TeBEs5YFLeHGDjwqDhdFC3yx5NFprhhQ2
 Kifg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeSb49RW/WRMWX0iScXpRq+uqoDarg6IcVb+QSfBecw/MFH5ZQVavEAgbXr99FnOK2h6Q=@dpdk.org
X-Gm-Message-State: AOJu0YxOEKdg9MNISvGeO29Lw/oFa2C/I6SmXKVY0PWFsRSuaNZjR4/m
 8EmEXAW+xQyGVEb3+2c6B23JWMb5v/8Yqyckl0mJT7n2FVMjd91AjRwsjVwmpUGDGR/FVs+rdgg
 k9JMnj9cDbhO49ggVDRO6ZoXzvQRgQMgDYCurnVzbAsbiH/1dMXtC363nzttxJwt6jlPoGy/XBE
 18ri1K0On3lHSHPmbBwvY=
X-Gm-Gg: ASbGnctTRjLK1LSdhUs577xfI1yENp7qSCzHOyrMdm1ErohCXhJjjFRbgvvJYSm2QIZ
 Fd0E9bohhylj1Vib9JJgHTLRUsAtTs3c5eoKpIVzqLdyNULV61NEfSs7d9QsGjfb2mZuLFvE=
X-Received: by 2002:a05:6512:1104:b0:553:2c65:f1ca with SMTP id
 2adb3069b0e04-5533d16bdacmr4262865e87.19.1748960291056; 
 Tue, 03 Jun 2025 07:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKRjliACR/VDXWegrqJ7wkavia5pQf/g/W0j7Z4I8KaAXLK0n8tUrKkLNgigXh56YJn5uHl0M9kof0AoNffts=
X-Received: by 2002:a05:6512:1104:b0:553:2c65:f1ca with SMTP id
 2adb3069b0e04-5533d16bdacmr4262857e87.19.1748960290617; Tue, 03 Jun 2025
 07:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Jun 2025 16:17:58 +0200
X-Gm-Features: AX0GCFsyAbipNgAQDLSXT7-riDochSaw2bb8FfsuKicK4Vf098GCQ5AtFpQqTsg
Message-ID: <CAJFAV8z4Y15we-45WaS=h22PKUD4q_XL3mGN+JBZwR=yYruQBA@mail.gmail.com>
Subject: Re: [PATCH] regexdev: enable to be compiled on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Ori Kam <orika@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x3fp6J0LHek8QKxCddD-17KqA6IILn10Nfaht0lykdk_1748960339
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

On Fri, May 9, 2025 at 11:52=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Now that mbuf is compiling on Windows, this library can be enabled as
> well.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

I enabled app/test-regex at the same time.
Applied, thanks.


--=20
David Marchand

