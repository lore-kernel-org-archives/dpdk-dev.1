Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60ECC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D3D6402EF;
	Mon, 10 Feb 2025 19:24:11 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id BFE0840611
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:09 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so61313525ad.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211849;
 x=1739816649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rtv++eot4nBWpGgF1TUkRM+VAY+AQWCwSnSDhka0APU=;
 b=eXeXiXHubqkbTmC5sdA19i32o+AEW0hPPbrY/qcNXCWWsobFacHfXbQWdzuZ77KYMI
 Xy0DJPIJ6ASM5I9EoXYyAukegn06EdnUT4uCKHYXfOm0ugPv0nqO74NywGZjeEuZdOdb
 0LH348BlPiQr4LPY4NgHhPZp7VGeomramW90pIdSBXgEkRh1LGAlJrndIZyuxcMUbVCG
 ihWP9xDggbbGUnf1bfQMxgAYS2HPxfFVTdZTJKTCrf1CJtOIaiTZ94WPxUanV4giFepQ
 F8w8qjhudG9k9WbGtNDAlG84ZpdR72mCQUpa88mwkdD+f90CsX/ekyxwd2hct2KhjsH8
 zvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211849; x=1739816649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rtv++eot4nBWpGgF1TUkRM+VAY+AQWCwSnSDhka0APU=;
 b=HTWGXqJLl61jCU0ZbNGZhd6UuZNFzHpZEV78HxPx95np8aS5FIeAqmymj1ug/iVYL7
 5GxYf7VlxCOJCbWqhOJ7+78+EPnHkgBvIX/AA2KukBIuUImqoosqdzVWCSxS2ShDSkVn
 gcTyNKSZH6HebLyWWrxHWa7RD6D5sHf9Bl6x03zlGycsHFCxG0dFpkBW3xezafGUUYX/
 z7dW3WkR1ZOPzOUFz2A9DWdbuTtGZgFjAJaG52g/YPHWv8WUHV0FR2twJumLmeTkVpwm
 tjWEbk2N4cDHIBDPdVouR81DMqQhXALhPZui+vLpRr1MsLKSAAf4QymIsLLnY3mObPOd
 NncQ==
X-Gm-Message-State: AOJu0Yx4KJVIKZNpKimJr3bX/exkvcuk81wMLW1zu0NP1R5pPkl9GAal
 6V7aTRttsUO5BPxnNG9nOoCPcEfFGvx+HLGGNmHzd7fKHGdNnGg1rNcwt6titic=
X-Gm-Gg: ASbGncumIfzQSM4K+Esd/sp7t9zpuyAzEA92wTUdLUpc2rfGQmo+B4DvrOM2SY4QjVf
 hg/TFOFGAMDXWqJZT9ThGEq9bLJNtDTUS8xZ7OjrG0LFZTa7joOB088z+jQ8p1T6AAZsVKUSuGI
 31+rhwH98b6U8g9aHHxFkBEondX2+gnqXF+x5rnE7gzD5UDzvq3qInnrq0UFv12QXwLS8bt4DJY
 ZjQi2AyYaijuDQMdn5fma9VvD1mrOl64ce+gCv5jg26JmVFNV/50haTypd/zcmGYwSs8E5R4Nl9
 YePmYTGT2CZNBR7uOG33hoQu7hWcVEsJv++cXCQGzIU2r54ff1HxKOHcHA08+yKo/HOW
X-Google-Smtp-Source: AGHT+IGt9BHiFFK7DtR4bdxslIKDOf45dFzNlCMktXl5B67kqBfCAlUyya8i9HS6WO0uX2uCw70dzA==
X-Received: by 2002:a17:90b:548b:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-2faa090abccmr561462a91.8.1739211848968; 
 Mon, 10 Feb 2025 10:24:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:08 -0800 (PST)
Date: Mon, 10 Feb 2025 09:45:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 10/14] net/zxdh: support hash tables write and delete
 ops
Message-ID: <20250210094524.73c26217@hermes.local>
In-Reply-To: <20250210015017.4105624-5-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-5-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:13 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static inline uint32_t
> +ZXDH_ZBLK_ADDR_CONV(uint32_t zblk_idx)

Do not name functions with all upper case, that is reserved for macros.

> +{
> +	return ((zblk_idx) / ZXDH_ZBLK_NUM_PER_ZGRP) * (1 << ZXDH_ZBLK_IDX_BT_WIDTH) + (zblk_idx)
> +	% ZXDH_ZBLK_NUM_PER_ZGRP;

Indent the previous line since it is contunation of expression

> +}

> +
> +static inline uint32_t
> +ZXDH_ZCELL_ADDR_CONV(uint32_t zcell_idx)
> +{
> +	uint32_t blk_grp_idx = (zcell_idx >> ZXDH_ZCELL_IDX_BT_WIDTH) &
> +			((1 << (ZXDH_ZBLK_IDX_BT_WIDTH + ZXDH_ZGRP_IDX_BT_WIDTH)) - 1);
> +
> +	uint32_t cell_idx = zcell_idx & ((1 << ZXDH_ZCELL_IDX_BT_WIDTH) - 1);
> +
> +	return (ZXDH_ZBLK_ADDR_CONV(blk_grp_idx) << ZXDH_ZCELL_IDX_BT_WIDTH) | cell_idx;
> +}
