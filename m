Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB7DC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C4EC402E8;
	Mon, 10 Feb 2025 19:24:07 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 61748402E5
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:06 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso7273080a91.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211845;
 x=1739816645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNUsqIqt7Uo6WGWMoMt/X/mG8b2IRP0ZwascG6bpI40=;
 b=aR3HgWe1KqD5Rd71Bkv4c2WKzLXZKcmcvQzMNe8pKpf3f6z0Inz0GI8oVs1VfN/oH0
 E79+XDOtZ0QzYq3T2QSKk7f3vBpKVSPjKbgbMI8odHt++MO+lJ/mXpGCESGtaY9pCZOw
 hixOjQBiY/3M1b1KLFCMtYgeKt8NFbXjg6PG/Lx5UrGqHZ6wFAYP2qOUtjhShFiBR6L0
 KPkRQ+02DkYhaaB8DQCOTOSMSEbkFT+9i5M15DNfLMSbE5+LUFpJ0PWtT25PZAmuTbWV
 g2H5Tj8B3R3eDcNa8aBmJ3bTcxnlL/9mOHaelXp/tbDtOv/xDkpnr3LrzGh0fdsudgtn
 dshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211845; x=1739816645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNUsqIqt7Uo6WGWMoMt/X/mG8b2IRP0ZwascG6bpI40=;
 b=K905qmg45kA1IJWZs1eq6Gf0K/+cnONd/TCqHLk3CCagbrGP5CEAhxxHgCLilpDBUv
 elv5NQokfDN3nzHbhuche0dWIaYQfC6XJ2a2ZlsSP5+iGLoFr+fsouFms9kGEC0aoFqm
 H/c1BHVLmT+ZOhzN3LCm346V/V6EsghDV0flWXKyASuRbwuKv9CxVVVaZPBsgoNpkjOm
 yQ5L02W/NZnFjpxLassZ2E0HcG+xoHPcOX/759Jh+TDwR6JnJEHBcOcNOE85Wo2wJH97
 eZoMBYm43Qx66uJtTAt/3M8CrAMqD5Cy0t/zURHVzrITaN2c1vfhOZ/b1r+Y+zSZ+BM/
 2qVw==
X-Gm-Message-State: AOJu0YyrHpDEtU8BuxlkbJQfTH2cSf7cR4MlxMbcgmmaXP4Y9fk1StwD
 xEVonCHhivVZm7dOwOJ4cYrFBgpyyYFwl/ymizSsZqhspPaKk93fKCrpZlgk4V8=
X-Gm-Gg: ASbGnctJMhCWs8BltWFXaOlEYx1CJyeAfUOUKh6BCgVFiwVKojZfKBoLJDgor6hnQKA
 VsylDdPlBwS9RdVGD3UV7ZP3c12vnknvS0U3xWwu+55RSdVOar7Nnb/0JYfmcj+g3OxZOwS4Ar7
 lljMAL3an+A4PYPX4rWNsZ/tveOxDFAO172d5X2gy6nuK+7+/iXhX4VDxsvA5hUjt2puV+S4/qK
 1kaxPFeR/LquYTPYlFPRSnrLd8NQ81RiVrPJo1gCOtEE28goHCItcBVqRTYH4jXMjiobxSX8M/N
 DWstbZvSZraXALESaa32ey+bqqkh9Uz3y8G2DjBVH1WG+nh1X8Ibs5XfmMcL1gpLRc1K
X-Google-Smtp-Source: AGHT+IEv9Xg/9Dxnu9LaZzXNOIUy7CZj25IlJaYVE3yC3jh8SvfUmtxVWcO8tneAqYVfjjPJq7Nijw==
X-Received: by 2002:a17:90b:3143:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2fa241776f8mr22197542a91.20.1739211845599; 
 Mon, 10 Feb 2025 10:24:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:05 -0800 (PST)
Date: Mon, 10 Feb 2025 09:36:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 08/14] net/zxdh: support hash resources configuration
Message-ID: <20250210093626.57c76e6e@hermes.local>
In-Reply-To: <20250210015017.4105624-3-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-3-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:11 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint16_t g_lpm_crc[ZXDH_SE_ZBLK_NUM] = {
> +	0x1021, 0x8005, 0x3D65, 0xab47, 0x3453, 0x0357, 0x0589, 0xa02b,
> +	0x1021, 0x8005, 0x3D65, 0xab47, 0x3453, 0x0357, 0x0589, 0xa02b,
> +	0x1021, 0x8005, 0x3D65, 0xab47, 0x3453, 0x0357, 0x0589, 0xa02b,
> +	0x1021, 0x8005, 0x3D65, 0xab47, 0x3453, 0x0357, 0x0589, 0xa02b
> +};
> +uint32_t g_hash_zblk_idx[ZXDH_DEV_CHANNEL_MAX]
> +				[ZXDH_HASH_FUNC_ID_NUM]
> +				[ZXDH_HASH_TBL_ID_NUM] = {0};
> +static uint32_t g_ddr_hash_arg[ZXDH_HASH_DDR_CRC_NUM] = {
> +	0x04C11DB7,
> +	0xF4ACFB13,
> +	0x20044009,
> +	0x00210801
> +};

CRC tables should be const?
