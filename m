Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCE1C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 557224065F;
	Thu,  6 Mar 2025 14:50:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BF95740430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741269018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48wgxHFVFXvL/QNhLmZXEVc0uJlkI7GLKeZEBL3IJBY=;
 b=ISXsGu+VtgGUMSqBGpPP8ZsmKRr0MTP2v6UKenI5Aa8/ceC0b1ltrkmMt5+ffH0Qg5J34L
 NVuIZGelJt138b6zrM64nr1Ijt97NxVNQX8OaYnF3Df7eh88BHzojR+FgPrYshBAyVzbl9
 fWTC+YgqDHS9obAYwITntJFpgONqxsw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-F0-Pil_gPHOMgAa5mravVQ-1; Thu, 06 Mar 2025 08:50:17 -0500
X-MC-Unique: F0-Pil_gPHOMgAa5mravVQ-1
X-Mimecast-MFC-AGG-ID: F0-Pil_gPHOMgAa5mravVQ_1741269016
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5495a20e672so428739e87.3
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269015; x=1741873815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48wgxHFVFXvL/QNhLmZXEVc0uJlkI7GLKeZEBL3IJBY=;
 b=YSXiEbpllDFSdld/Slb8ccPIIk/emf7E6SMPVnPcogV6fvBUTDYhoYZedJ2npQsIAb
 evNXIKCeV6xl8FNfaNj8WtWBQbzzdVsJHbb8mVQiXFUDxv3yiVe+KPGoi8Xl1v5797RQ
 VEROpI3g5Rm/NdcVS3TeWoHP4DRf3auj7I9ssW8B0B221Aikoq9ViIfmC8t5/RN9S6Cw
 l3sHlbcO++o5tMGC0bbgUqw3Up9qsZxIceH73LGfiJCtY6VKZNmYtbnbD4dT2S3byJHx
 2QqRyoZKYXhTm/npjq15VrfZZtVSYl+HXVDa0RgwlybymNEfG/mOAclbtuu3LnV0PeYG
 6DeA==
X-Gm-Message-State: AOJu0YzbbAL0TjocUXBvnqXk5XoTskcTO2kpghxC0JXhu4RLsqjxYUDV
 w7lIZrzgxZlJs0tvVJLkkF825zHYn2KPwHif2UOZiPSTlyoNEmFmByrinrXeTZuEn2LqOg/WoTi
 e9Jf+m/XofHCq6AAxc5FlXYGGMpT1eGMjpqpY3WlTKf69Ph5ji/szKWvGYMG1iUqruz+BM+7ZF1
 KFJ/k5LUDM++dq+fw=
X-Gm-Gg: ASbGnctzsunGISj1BZbw1cKcMAhEJKtAylFjJJt4Fsn4Z5Oni3CmerxHuqQiB5MUXIa
 zEI6FGaZs5q6BC/qIihRF3Mbneb/gpp5rSTdI0onjZ/ZwR4zbVa7Xm+Uzg7TYU73OJP0mZRrsMp
 U=
X-Received: by 2002:ac2:46c9:0:b0:549:8b24:9894 with SMTP id
 2adb3069b0e04-5498b249a98mr736379e87.15.1741269015573; 
 Thu, 06 Mar 2025 05:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX1cJTyh3f7U+06BclRpXTgMSm67fLz0x1SdaqI5AIHK2bwUTMiZiGz8CeSdQrp0VJ08/vxhSk6Q3CuPVwXQA=
X-Received: by 2002:ac2:46c9:0:b0:549:8b24:9894 with SMTP id
 2adb3069b0e04-5498b249a98mr736367e87.15.1741269015173; Thu, 06 Mar 2025
 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
 <1741034874-13573-1-git-send-email-andremue@linux.microsoft.com>
 <Z8bayaioc0GyYwgP@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z8bayaioc0GyYwgP@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:50:03 +0100
X-Gm-Features: AQ5f1JrUf4FciP8iEUsZbIpE-HsqH-lyP_BE_9D_4Jrds9t5wx2VVx8_YvfYytQ
Message-ID: <CAJFAV8zfLnRCB+64U3693+me2mMn8jEecrSShF9YBOVJWRA2ig@mail.gmail.com>
Subject: Re: [PATCH v2] member: use common top-level variable for easier
 maintenance
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, sameh.gobriel@intel.com, yipeng1.wang@intel.com, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PD_YCJnYpdC_kbjVY2BIrjSPDT5PlG8h1qtCZcR6G20_1741269016
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

On Tue, Mar 4, 2025 at 11:50=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Mar 03, 2025 at 12:47:54PM -0800, Andre Muezerie wrote:
> > Updated meson.build to use common variable cc_avx512_flags for
> > msvc and avoiding code duplication for other compilers.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

