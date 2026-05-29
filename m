Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE0CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 497CF40280;
	Fri, 29 May 2026 17:27:36 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 8B5B9400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:27:35 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ee990e8597so32261800eec.1
 for <dev@dpdk.org>; Fri, 29 May 2026 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780068455;
 x=1780673255; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6Brgp04DLejwVPQZPaqcizzzC7UKNV7hCRq+nbwrk4=;
 b=bp2t0+ct2rQgPx5fVNGNm2KfbPYwDpG4IXox4gkgsVddPXycZ+HXtad/WJ1nMUvRnj
 2BhSxu/mH6lpOq1Bv6WGNtJe+IYKkKUSKXNjjgjzYHhKaS/jGCx+HoJDVBgFcxwTdqiU
 /8K4AFh9e1t0cC3EqwjeYzlPu2Of5NLHkeAbr09jhX6IFE92K36NnS/VenYtyTYpB3dH
 d8Cdmz1z79+4JlwnMpoNO9d7rtuOzpmm3phmBiLtau5u6E1N4/yUjzUVsw2SGEFKDVZc
 IrzEE99CPtkoph0AT8yq7A5juhvIWP8gjsnjUo7T3zTiSvbpDcPYZiQ37A45Lfz3n4DB
 ftWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068455; x=1780673255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z6Brgp04DLejwVPQZPaqcizzzC7UKNV7hCRq+nbwrk4=;
 b=QbF4gxrorgvSZlDnAbt5YQvZ3iEesV+jeacLXBA4nKeiHIeEQdV5lDrngnQ9TAbM5A
 LC5VuUEC1NP5LpHbVl/F+kTIDn0RyC5N/nYecWPeOYSy/Dt7F2260Bm3tLAn4HCLk33U
 U/reE1MK5Au/wqYS7aXeOmn/T25cUYKYprc3qhHxDNPrLod3oN4djeWophcGgBj4m9xV
 Ji3I14xIBiyHIZDAUTVqpZoYAQiasIhGOhp2ojKQPgsqjD9qwXfAyF4K/4XO9ODf6lcH
 70GuEylmunwCRT/jPSgIbkN+3nrO38t6fh6Inkf9mlPoaVHPNFbPB388PiVLf9cSusUQ
 eA/g==
X-Gm-Message-State: AOJu0YwhaUn/KSBUsZ9Jmpkk1vKW/khia8YbWZ+UwDDKVnq6lA17eBAQ
 cURgPaEmlTSLKoH+NopVJVf0LeDiII+nYnIhZDcOXeKo643pxRAGcSLp0bQfD5Ytyj8=
X-Gm-Gg: Acq92OHSQKHjFhIqvXrpHlPC6HqV6S2x5Cb4Ku2y2R5COnFOao6jDCGYavml4+VkShy
 TDXfPhg7Zm/R22zQm/w1acWWSB78hAf1++m2wF1Gxy74R3njiS39IXHjjz6TAw9gYJux63Crdx9
 m/AFFHQt7zbB2FDrN4ksPLc9S3uY0c5+9yj7bgvaqKyCO4IwFnwh9FaQSt8mr1tt4p/HhtnE4zA
 3GX3hwpGDtbSK6uTSaI1Zzdx42HjiSXcMqD2h6NBdtYzZMBxy30zrl4fYUavHsyg+4rGgDPTeBn
 L9qKLHkefdP9KA13cCraFysIcep1CL3JSGL3POfXqM+2LtyYMpWKPQziKQTpRoLJnK9sYzhhEwb
 jgh1QLhPf/5kNVqkvMWjD0TawuVWJxRxXh9XsOrrxcW+SHm9R06TjsPHWRoskaot7EnMZWa/l28
 VZeHgfLDGlUNd7KCtXiNezP9J6pOb3j67OeIfiaMwwH00cRTD4mfe6x43pirnAaXfCJ7LVXxC6T
 oY=
X-Received: by 2002:a05:7300:730f:b0:2ed:e15:c927 with SMTP id
 5a478bee46e88-304fa69ad83mr162253eec.35.1780068454518; 
 Fri, 29 May 2026 08:27:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c154fsm1507003eec.3.2026.05.29.08.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:27:34 -0700 (PDT)
Date: Fri, 29 May 2026 08:27:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 "Anoob Joseph" <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>
Subject: Re: [v1] crypto/cnxk: add ML crypto support
Message-ID: <20260529082729.79c51aee@phoenix.local>
In-Reply-To: <20260529091330.6308-1-gmuthukrishn@marvell.com>
References: <20260529091330.6308-1-gmuthukrishn@marvell.com>
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

On Fri, 29 May 2026 14:43:26 +0530
Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com> wrote:

> +
> +int
> +roc_re_ml_zeta_get(uint64_t *tbl)
> +{
> +	int len = (RE_MLKEM_ZETA_LEN + RE_MLDSA_ZETA_LEN);
Unneeded paraens.

> +	const char name[] = RE_ML_TBL_NAME;
> +	const struct plt_memzone *mz;
> +	struct re_ml_tbl *ml;
> +	uint8_t *data;
> +
> +	if (tbl == NULL)
> +		return -EINVAL;
> +
> +	mz = plt_memzone_lookup(name);
> +	if (mz == NULL) {
> +		/* Create memzone first time */
> +		mz = plt_memzone_reserve_cache_align(name, sizeof(struct re_ml_tbl) + len);
> +		if (mz == NULL)
> +			return -ENOMEM;
> +	}
> +
> +	ml = (struct re_ml_tbl *)mz->addr;
mz->addr is void * so cast here is unnecessary.

> +	if (plt_atomic_fetch_add_explicit(&ml->refcount, 1, plt_memory_order_seq_cst) != 0)
> +		return 0;


> +
> +	data = PLT_PTR_ADD(mz->addr, sizeof(uint64_t));
> +	memcpy(data, re_ml_zeta_tbl[0].data, re_ml_zeta_tbl[0].len);
> +	tbl[0] = plt_cpu_to_be_64((uintptr_t)data);
> +
> +	data = PLT_PTR_ADD(data, re_ml_zeta_tbl[0].len);
> +	memcpy(data, re_ml_zeta_tbl[1].data, re_ml_zeta_tbl[1].len);
> +	tbl[1] = plt_cpu_to_be_64((uintptr_t)data);
> +
> +	return 0;
> +}
