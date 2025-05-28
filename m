Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC58DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 14:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B4F40E48;
	Wed, 28 May 2025 16:32:25 +0200 (CEST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 85EDB40E48
 for <dev@dpdk.org>; Wed, 28 May 2025 16:32:25 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-ad88105874aso357120966b.1
 for <dev@dpdk.org>; Wed, 28 May 2025 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748442745;
 x=1749047545; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGbDxnrZBf8C6IlYA4+KRkJGWod3HXk6WA4T8ci/fKM=;
 b=o0caLTd34qpyd7Ho5YJcJxcMtv85V42U3DmA34m6+O2l1R/iqy8lxPk3Ve15akL/tc
 junt2EhRQIGvTOK+OT7CUrdNDUDd4YyXPpUINB+uuaV9fdJvJlmEEs9EBG5fbFEjXrzZ
 BQ0GWupAcz3RiPeRvcizV/y4Dsp0AmED3UUhOGajcib3SLY+Kgo8uQM3M/DmXU0oWMIU
 +PAyrh7U8ap0k+P+9uAJt/PLl4a5x3BLQfbFn+CozndbJ0P7JH2RCma31dYjGotd6Dm3
 v3n4K85Xcs38uj2Cbxw4no+VuTlM3+9taTHmYukbJkKHmuCsIA3gU14tmGxCd/Np2F3J
 B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442745; x=1749047545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGbDxnrZBf8C6IlYA4+KRkJGWod3HXk6WA4T8ci/fKM=;
 b=CAedyO0iOZt0rAEvYkWmfthAfJ5vsFiHhyaAtFu9zs0whjImQMjFt5Jq3A7WISg2lG
 A5fqayCa0h6k66imUnagwXY6DnKDCzNnwweb5WpSPK12+51SOY74WLrvSntbLj5ZTGax
 sAR+8XoICNAOQY3Mzt9RlIomsvsXX8EL/eFfxJqctgivbzMOpPF7igyXF330JZYF/PAL
 pKlaLioY53NYqn2zl86dnfK605YRevVc6wcmSEYFA1xaxeXvN061P9+2c0S55EyiowYw
 6TxS3vKn8gZRYhcuiOkpAxjsdHms9NcmI+wE1kljDflpvfO7o9RNMUfM8uEXR+ozs2Oa
 s8xA==
X-Gm-Message-State: AOJu0Yz2Acsdu7xSbSOyPF2z9E5WVdYjXJipYC/XTuUR6vh81eblWfZZ
 YDa5ksaDu845QGECj1x1YQPwg8hr78fLjjIfPeJTWJQ6zxM/H8tRLlbGR3tAc46WgI4=
X-Gm-Gg: ASbGncuNFTrt5w9edNXurS/JsM2OZr9reKcdXAfjrfv3hWR/1QHfy54BIRUKwq3susU
 QaY/Oz9pTycth4NxC3bXGtFjhFzf4a7FDSZfM43KcyAQwNSMjPqihityCBd98HD92ThKcjQn/iz
 SKjGU0a0gu04K+Tuc4zVT4IbL0sjCUGNCsWpX4dd2N9b9rTLpLMl00+BQc0pgtvUHSkycrhYXTv
 gRD3ehxpIU7Z8GOr6nCy1M7octCw2BwJlZDHhAj96ZmZ3FrTe/q0tA8/d+6Hb9mBXSyAhIJTViX
 O8wng92elyJr7JgRIMUhxvO/yY9cdxWr1EASQHeQYGX1K3h65VrkvUbTLuLwqJks4I+9DOwuB4Z
 wqnlUooUZBgn55g6sEhaTpAvbylQy
X-Google-Smtp-Source: AGHT+IG10lmtDMhqpMP2gXaJzjXvfIove1qYWCtLUc6hTb1hO9RzrF3eiB3lc9vkL77qmW9eGDxTPA==
X-Received: by 2002:a17:907:7fa9:b0:ad8:a684:a1f7 with SMTP id
 a640c23a62f3a-ad8a684a4e0mr145763866b.30.1748442744925; 
 Wed, 28 May 2025 07:32:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19c8a45sm115804566b.39.2025.05.28.07.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:32:24 -0700 (PDT)
Date: Wed, 28 May 2025 07:30:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v1 04/10] bus/dpaa: optimize bman acquire/release
Message-ID: <20250528073041.242f48ab@hermes.local>
In-Reply-To: <20250528103934.1001747-5-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250528103934.1001747-5-vanshika.shukla@nxp.com>
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

On Wed, 28 May 2025 16:09:28 +0530
vanshika.shukla@nxp.com wrote:

> +RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire_fast)
> +int
> +bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
> +{
> +	struct bman_portal *p = get_affine_portal();
> +	struct bm_mc_command *mcc;
> +	struct bm_mc_result *mcr;
> +	uint8_t i, rst;
> +	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
> +
> +#ifdef RTE_LIBRTE_DPAA_HWDEBUG
> +	if (!num || (num > FSL_BM_BURST_MAX))
> +		return -EINVAL;
> +	if (pool->params.flags & BMAN_POOL_FLAG_ONLY_RELEASE)
> +		return -EINVAL;
> +#endif
> +
> +	mcc = bm_mc_start(&p->p);
> +	mcc->acquire.bpid = pool->params.bpid;
> +	bm_mc_commit(&p->p, BM_MCC_VERB_CMD_ACQUIRE |
> +			(num & BM_MCC_VERB_ACQUIRE_BUFCOUNT));
> +	while (!(mcr = bm_mc_result(&p->p)))
> +		;
> +	rst = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
> +	if (unlikely(!rst))
> +		return 0;
> +
> +	rte_memcpy(bm_bufs, mcr->acquire.bufs,
> +		sizeof(struct bm_buffer) * rst);
> +
> +	for (i = 0; i < rst; i++)
> +		bufs[i] = bman_hw_extract_addr(&bm_bufs[i]);
> +

Why do you need multiple the local copy?
Does hw_extract_addr modify the buffers?
