Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D8C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 09:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0122D402A0;
	Thu,  3 Jul 2025 11:06:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 68CFB40292
 for <dev@dpdk.org>; Thu,  3 Jul 2025 11:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751533603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viiaa56+ftGae8yCIA0DB3aaAfyeMJO2+a4J9o3EXCI=;
 b=h29puhCnOvx55glTCb+OM9C8vPXOItXEQLcLFOBTaWa82+hoz25tUS7GBzEOPq4pVU8TRR
 xvD+sSzLFTW8zNRw3OX+89HyEnrCoGNavUNz6NRxEtp20cYocshyukiynC4B+NpIzIfiap
 DMP9XV2ToGhVHHVs/okbjjqG9ut5Xaw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-QhnPaCvgMzK2ON1KN9mz6Q-1; Thu, 03 Jul 2025 05:06:42 -0400
X-MC-Unique: QhnPaCvgMzK2ON1KN9mz6Q-1
X-Mimecast-MFC-AGG-ID: QhnPaCvgMzK2ON1KN9mz6Q_1751533601
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-554f7b19481so4532305e87.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 02:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533601; x=1752138401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viiaa56+ftGae8yCIA0DB3aaAfyeMJO2+a4J9o3EXCI=;
 b=BynnymQcSATdYzTzMojr/YGQwwrKqhevTN+yH17JDKhQdezh8Mr0z5nYetFpjPQc4r
 XUXUL17aut3308f2sCTA9qGWvNhyODXGt2/qig1bFP71PRR1UrEDYS/Le44s3HEfq8fM
 4acaKtiCbIjitUT8vtslVtroIEMCLl/eNrHAj0MxtrVqGhdKs3edErut/Xq/iPp5jV5j
 df8BNaViDfQrBrqg3oNPboVxVnSZoWfbrSiGtfj+0YYJn0XcdECof66uXw1LhNoEYT+V
 dQ3UZHYeKtQbj2O0BPMF9+UUzP5YTJ/1XuqaRzdHs3J1YkE0Q5tSAY5C210fwtoaM9K+
 PnAQ==
X-Gm-Message-State: AOJu0Yxv3swfxvzDXvRYqm/SythUcF44TjM5Ro1C/M8Iza330natWtU6
 Zz42Hxrv+m6cb024jA0kRIvVGBuddRMxAu90lyIP3UmsjnDcAwxoBL6KK2FKaNhtXQ+Vw9s1/B8
 fD8Um0TlqB0IhuuKSxt/bhETO9V1X/xnsLmoB47FyHmDIgHZEr1wzjDT89Tcty2uBxhQh7SiEs/
 zDHxeVjbV5w16XsphGuf0=
X-Gm-Gg: ASbGncuuQsYV2WS6Hd56hLFiKPuhL7KiCXc26En6XMdGGAhX3Vx5HoYEESNKl2SOK8l
 0fzcUjilaLb3CjDYOc8ynMDryo0f0kZIfygn0LtETZB189cGWvhWyQso+kAGBAU5OHhuZDJQp8k
 ayeAPQJA==
X-Received: by 2002:a05:6512:3b89:b0:553:252f:adf8 with SMTP id
 2adb3069b0e04-5562ee21626mr788517e87.9.1751533600787; 
 Thu, 03 Jul 2025 02:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNoUW4dWpxgMcp8BlrmEOAGir0HYEjzT9+STaxuq4pySIa3i+IpOaDO/GxcakkB/PeuQ3xKvgunTJxmq36bVs=
X-Received: by 2002:a05:6512:3b89:b0:553:252f:adf8 with SMTP id
 2adb3069b0e04-5562ee21626mr788508e87.9.1751533600324; Thu, 03 Jul 2025
 02:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250624134139.552315-1-bruce.richardson@intel.com>
 <20250630153752.2361112-1-bruce.richardson@intel.com>
In-Reply-To: <20250630153752.2361112-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 11:06:27 +0200
X-Gm-Features: Ac12FXyf2oCKS_Cn1glYEAK4qX8Blpk9ay1BMcNFhyjiJghy8j4qfnQ9n63gOY0
Message-ID: <CAJFAV8zkkmJNqJ_-KBG8NYki54ADZACG_DGE-UF09zV_BkcFZQ@mail.gmail.com>
Subject: Re: [PATCH v2] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, techboard@dpdk.org, 
 Vipin Varghese <vipin.varghese@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kmi8M5z-G2BK7h09Ew1uYrl7e5TY2oulRpmbqEDlUFI_1751533601
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

On Mon, Jun 30, 2025 at 5:38=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


--=20
David Marchand

