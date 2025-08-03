Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E593AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 20:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE39A4026C;
	Sun,  3 Aug 2025 22:29:40 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 85866400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 22:29:39 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-615c29fc31eso5667067a12.0
 for <dev@dpdk.org>; Sun, 03 Aug 2025 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754252979;
 x=1754857779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcLcERljjP5/ZCNtmhjZOU7dSVd8szKjLTp7iPXdv4g=;
 b=IQqG0nhQ2FLT92yvH7+ZutWz/L/f6qOPk5S7wKS2KN2HImLY9S7Q+sYjCnaBZw/Byh
 WnmbN8QvWPlxSY82StLCA/LyrtOtoSRyGLO/yhWGKC2V94UvOeBX1g6n+k0BeeI6svnu
 3QPlxuB/VkEn9B020hDfbW51yTgtrXpMOGjCS4sf6qsAYivtQNQV5RbzfJgfVj5C7nF5
 18UsHNyuQCNqYOmexAp5y35sJtdMcwb0nPz/z6ReZIh6kKMxcR8WM45755bXGJU+uq0U
 D6KFGpj3hDPtOtXQZnFPGIQMBMdhPHoJy2dtxfDuomjuoc0sfwSHQWyu+jLuB7jMUSua
 3/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754252979; x=1754857779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcLcERljjP5/ZCNtmhjZOU7dSVd8szKjLTp7iPXdv4g=;
 b=lkpxNBKj+86Y9O7zLN6AyuGuV8PT4NpbW4XI29yfBIbbsStDpsEuXItgc4eUb5ue3g
 yYulS6ZgAXMVO8Kcraj4mo6fr9dsNOCr9xNiUraYg6G80oUMXsY3BDauzm0gRvpNWXnc
 YAPE5lyA632pk9eBcWM0Y4+rxfegtihLGCuRjyBV0598jEwVP+W5+v2SH+8M3lRh8waC
 ey4Evf3VYlU6488DWSX2a9ywihF1w7WwlfMzDDqIEzD+aWeb0A+d+LtCKvoH3tADrw9E
 f0544t06IlHxtWB1BbM3KxR/60/O2V1kZsau0SKhbqWArK1hxb7zpYwf7vsdWu1z8jmH
 mCDQ==
X-Gm-Message-State: AOJu0YxE3PhgS+MPKtskGG03Ilkz47WRhe6XZCdLuadHVQFooBhc4oBU
 hqaV0TlHn0B5+d/hqGJNdYBl+94i+/l1TiX18UWlu0GyFwO6MYzpeaTRweE2snlCs4c=
X-Gm-Gg: ASbGncvhtS4zImwDW95jNAhHlGnsolIOq0TcTv9+Hcmp0pQGWnRuNHc1zjepbfErb5D
 oOPJmZFzJU0gdaKidb2RpYfHobTHkBSn5Nr5+IPRVdDc7lEFvlFDu6yNmYO1LVsd3hEFgLxOROY
 BgjH/R8vZkjYQ7U+6iQjcKVEtN4xRuc+b/dVZhvW2TXCF7QWFS2Q2FIDvlkUSjZtj74mBl4ZVNT
 4ujIZJf/vFInZkKcgV2FxY/MoS705V55vEQnlLpNIfoCYD98mjWT7w2BM/CYrFIYl5M/OhD26pI
 ffAcMs7Um/SK/BoMnpI/SztiFPUbbTjPOEETtFpCK3j0Igu6Oqi6R7PM+V6Aup4nKFOpDr4X2pJ
 BcHLj1Et2rxjCNRN5Ye7vUr4sH1Vw89h/JbERbGhI47jhKi/4DgAOedCta8W+S2sF6fcYcEhzT1
 4=
X-Google-Smtp-Source: AGHT+IHN7MjmmusfphkIgDKYYkOdCnBONDHFkpH2tlRRm42l8M7Ix6HN9EKqP5rvt+h0J8/QG74r+g==
X-Received: by 2002:a05:6402:5210:b0:615:b9cf:ef65 with SMTP id
 4fb4d7f45d1cf-615e6eb6c15mr5910904a12.1.1754252978845; 
 Sun, 03 Aug 2025 13:29:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15a66sm5843205a12.16.2025.08.03.13.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 13:29:38 -0700 (PDT)
Date: Sun, 3 Aug 2025 13:29:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] net/zxdh: fix meson.build issues in compilation
Message-ID: <20250803132933.59fb89d6@hermes.local>
In-Reply-To: <20250710105643.516329-1-wang.junlong1@zte.com.cn>
References: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
 <20250710105643.516329-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 10 Jul 2025 18:56:37 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v2:
>   - using structure assignment operation instead of memcpy.
>     mac_filter->mac = eth_dev->data->mac_addrs;
> 
> Junlong Wang (6):
>   net/zxdh: fix meson.build issues in compilation
>   net/zxdh: fix issues related to MAC configuration
>   net/zxdh: fix some VLAN related issues
>   net/zxdh: fix RSS related issues
>   net/zxdh: add support VLAN TPID set ops
>   net/zxdh: add support I510/511 PF device ID
> 
>  drivers/net/zxdh/meson.build       |   2 +-
>  drivers/net/zxdh/zxdh_common.c     |   2 +-
>  drivers/net/zxdh/zxdh_ethdev.c     | 109 ++++++++++++++++++++--
>  drivers/net/zxdh/zxdh_ethdev.h     |   7 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c | 144 ++++++++++++++++++++++-------
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   1 +
>  drivers/net/zxdh/zxdh_msg.c        | 123 +++++++++++++++++++++---
>  drivers/net/zxdh/zxdh_msg.h        |  30 ++++++
>  drivers/net/zxdh/zxdh_pci.c        |   2 +
>  drivers/net/zxdh/zxdh_tables.c     |  70 ++++++++------
>  drivers/net/zxdh/zxdh_tables.h     |   7 +-
>  11 files changed, 416 insertions(+), 81 deletions(-)
> 

Queued to next-net for 25.11
