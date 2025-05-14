Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F3C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 20:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1200D402DC;
	Wed, 14 May 2025 22:21:53 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id CDC1C402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 22:21:51 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-30c5a5839e3so49181a91.1
 for <dev@dpdk.org>; Wed, 14 May 2025 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747254111; x=1747858911; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfKUqOILj8KxvyDeggmBZSirJPi3tghcFrIOza/4jhk=;
 b=bwcZVVnCPEduIX7IJBwxenh3XFUL5YuJ7TMQ62EpgZ4gqx8WY3WYJ3WrJENs4KZt1z
 jsgyu6McGT00zfUx11XpPwV+qlD3y+ElScBbzzRwC4yFdvuvgmsiLZtwij6bMo6G7C2+
 nyjbbmCmaInm3sEgm881D67pekv9z2hC8W9As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747254111; x=1747858911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfKUqOILj8KxvyDeggmBZSirJPi3tghcFrIOza/4jhk=;
 b=f2YhRl9h3x3XHkPzZVfeT/V3VEJy9dZKNombbBxP7OFF87bpe3pM0s8Yh7ZJZHQxEC
 uHHUXoDsfC/v7fNovEiMIyA+U+NNKy8qQrGD6baJ37eTwP7tKD4kUeUzbm8ly47hJH8d
 Q8/S8lkmJl2UVMD+XbujDzb8+XKVvHNHLFCbH95OROPgsdCbBCacueWC0kTbU5Cp3Vvz
 cDKlY8OpB941BkETJmb9o+D7Usf4xCC0uCsyF50zjIoMcdmEXZvbom5YoJ5iIaoTU0ko
 Jj/TA80avD2GqUJ4cypjkfI1j+iqOnKezp7TOyR86WOT20qh99rUzxWANU/7mPRgG5Xj
 ZqTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfYUtXVlt2yiGsdIfufzCGerVgF3RXPK3xNulJi1enmLty40aSS4nJZ8mYbMBkjmIZzto=@dpdk.org
X-Gm-Message-State: AOJu0YwY4x8cg6NVAu2Ip4f5sRQO1rqWzqFNQ7k/yjx5INy+i23eTl1n
 heSFOXL/57E0MCANuLn+moaUC+21p6pr2Mz55KlHdonAKBhyaVKegSwK0ruB/jUh4PFiC5yg2LR
 joxeqAgHyqk80o65hu0l+Y6avIAlCRbynmlHAUg==
X-Gm-Gg: ASbGncuiEXwwp1lX91HpVolItMYCUjB4szVc10A14wEuCw5/zMllyYuPj+1MMAjS1ks
 FuznLklZz7jaYCzypggSq0sSHtcJ66d9lIEubBLLCVoe6bSXUK2B3/KN86Br+fpvyMdRqML58WC
 Kou5Z57+tBlNHpqcZyKENhzjx+Rhfgy8HSdLLSBlVbKip48RgI
X-Google-Smtp-Source: AGHT+IGX8vw7MepVp5IaCd257JQeInd5mZoVN/tJyR9b/Od2GvpXDTANuDTFyxScMHMKUq7/Wt/BnnR9xDRsC+RcrRs=
X-Received: by 2002:a17:90b:1a89:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-30e2e3ff1e0mr2765070a91.0.1747254111026; Wed, 14 May 2025
 13:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-4-dmarx@iol.unh.edu>
In-Reply-To: <20250306214747.579340-4-dmarx@iol.unh.edu>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 14 May 2025 16:21:39 -0400
X-Gm-Features: AX0GCFvXuXF_9y4g4MWSDTJ7XnDMss7XvlAtB93QTCr3v8F04Hm9qYh8ny8zXzQ
Message-ID: <CAKXZ7ehHYBNmCvHMcRa5ZeDm5VZ1zym0Z7iQtn8Vebu2L6pE5A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dts: remove unnecessary capability requirement
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:
>
> Remove capability requirement from checksum offload test suite
> that was not required to run the test cases.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_checksum_offload.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuit=
e_checksum_offload.py
> index 83879b0512..c9efdcaa1c 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -30,7 +30,6 @@
>
>
>  @requires(topology_type=3DTopologyType.two_links)
> -@requires(NicCapability.RX_OFFLOAD_CHECKSUM)
>  @requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
>  @requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
>  @requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
> --
> 2.48.1
>
