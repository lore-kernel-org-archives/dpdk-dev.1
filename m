Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FCE9A053
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62FDB402CA;
	Thu, 19 Feb 2026 18:33:47 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 84E9B402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:33:46 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-89505dd3e24so16208666d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771522425;
 x=1772127225; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aJIR4ZNxnx8JrRrVIs3QATXLwqlfWEsdF99kRgzGYo=;
 b=P5cmGuV6VQT+T25CnxGRVcdBCpyow5EnTge16yPS8TsJwwwsjUXlxfeqsqbV/IkjmX
 IBfyhZmPyyNyTtbTn/DD7APSZHogfCBSPT4mwz1d60Rck3iXss1Tz6nJjca7DhN5R70c
 SEzSC3jrbvYNeTUqESVdCdl9bRHJxx0EKv4D+/HQ+JZYoBOfzq1FVg4EvNRq2auxK64e
 UnuU+coglPQroG0mShQqgIqHTzCajKhVm7yZznFPPhpFDQyG9WZslM9RTXCfMOx6Ycvk
 DrSYMXsraokNdC5kPc5XW0iqMQUzfbD7WIaG5TkGfiIEPM7Ww9SDjIWrMrqMy3eFY5SV
 sOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522425; x=1772127225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9aJIR4ZNxnx8JrRrVIs3QATXLwqlfWEsdF99kRgzGYo=;
 b=pXLGTm0k7S2kuHQXQmCcL/1t9O3rgBcsmnr/VJFCGF6MTUv8tHOyA9ZF/FrL3Ic+Mr
 27oHCaZXpGCcC8l7LM2tTbYds6MsTvVfMbALoWqBi6jT4vnm177kqdxfmim9EX4OgFMM
 wre0yj26d7xOVxiJo9qXooK9Elq/jn/w+4vkCd9YIw65ySENm0ZnC1+JdFkpV9+mjdpa
 4lFoxu0y7rdQ7YkHI7VTR/NrF6hZ03YFz0MuSIMpr9KcGq29Z8xMXUguNJcwYHEjK4Wy
 K3wtvhy+i6384mZoEEarO5TyTPkoJg14alakJPf7CI+Tu2lKA90mfJuQPRwp7aAryrbP
 mZTA==
X-Gm-Message-State: AOJu0Yy2BRaBo2yjEddwjLTL/G8mxTLHm9ZXwy30zVS6Qra0YETlekZA
 Z7z3jJ+2uHZQ1WAl0YbrrjxYbS7Gbtzv5p9D5Q89JeLDpLjoeR8z5BqDjxlkPWsN0ww=
X-Gm-Gg: AZuq6aLG3noBg3AOPnZ7ATTpTsXWfPXIrqOVLBg1v2ZkreW/UKd22PvswB5CphEq790
 WnjHobkWaotNgBNPleewQcFMnoZtDRHFKTG2kG4Mb/VIlTjcrVvo3YC0IXjYRULbFQCcOZyfiaM
 AiKmRslOGDxuSXYA/YOw9PQC8cdms99y02pNb/e1Xs2ifXUroop5r8X6CPguJnsV0ZGGriHhoLH
 CM1FZ8QVeMeMK1OxjZt5QGWeIUd8rAZwzcr02dXn9Bi8v+D8COQaWKPHLF6BCKY4EMZxvEBxLeo
 oaaLB9ub877BuKzx/sojy1hkTx2uA30otz2nZuTzoLmq1is4mFxYQyiAh2A4l38eNeWGH1RmmHZ
 AoORyd/c1qLxVB8f/X5A0oUz8EwuBpfKtmZtSR5ZuK1X0qtz14IR3JU8TK6Y/e2KnvIeWtx571O
 h6hjy6Wmk9eXpMtsqAbnbMJgWmc1by7B4ZDX68x4fLhfD0Nw5z6ACjQ2PbyiM8KMjd
X-Received: by 2002:a05:6214:acb:b0:88a:57db:8e04 with SMTP id
 6a1803df08f44-89957f4765dmr81455976d6.8.1771522425641; 
 Thu, 19 Feb 2026 09:33:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cc7f559sm222262836d6.1.2026.02.19.09.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:33:45 -0800 (PST)
Date: Thu, 19 Feb 2026 09:33:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nawal Kishor <nkishor@marvell.com>
Cc: <dev@dpdk.org>, Ashwin Sekhar T K <asekhar@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, <jerinj@marvell.com>
Subject: Re: [PATCH v4 2/2] mempool/cnxk: add halo support in mempool
Message-ID: <20260219093341.3f6bb261@phoenix.local>
In-Reply-To: <20260217103932.679806-3-nkishor@marvell.com>
References: <20251205055140.2395369-3-nkishor@marvell.com>
 <20260217103932.679806-1-nkishor@marvell.com>
 <20260217103932.679806-3-nkishor@marvell.com>
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

On Tue, 17 Feb 2026 16:09:22 +0530
Nawal Kishor <nkishor@marvell.com> wrote:

> +static struct rte_mempool_ops cn20k_mempool_ops = {
> +	.name = "cn20k_mempool_ops",
> +	.alloc = cn20k_mempool_alloc,
> +	.free = cn10k_mempool_free,
> +	.enqueue = cn10k_mempool_enq,
> +	.dequeue = cn10k_mempool_deq,
> +	.get_count = cn10k_mempool_get_count,
> +	.calc_mem_size = cnxk_mempool_calc_mem_size,
> +	.populate = cnxk_mempool_populate,
> +};
> +

If possible ops structures should be const to protect from modification.

> +static int
> +parse_halo_ena_handler(const char *key, const char *value, void *extra_args)
> +{
> +	RTE_SET_USED(key);

Prefer __rte_unused attribute

> +	uint8_t val;
> +
> +	val = atoi(value);
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	*(uint8_t *)extra_args = val;
> +	return 0;
> +}


Using atoi() allows non-string values. You should be using a more robust handler.

Actually kvargs should have handlers for common types, but that is an enhancement.
