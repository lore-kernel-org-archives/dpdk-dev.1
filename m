Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A231E94627
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:51:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2507E40616;
	Tue, 10 Feb 2026 01:51:16 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B7307400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:51:14 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso41205045e9.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770684674;
 x=1771289474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZDIISpTTtHNRFZieHFAsokEioPS0ILymI/CJg/y2bY=;
 b=OwyM/Yb5iJaOaYsO583R61hTaA9tnxUYMONnQGCQur6v1rr2wy8Ro36A239VicyMVd
 ECcITe7vg6uAq/5yVzZYYVamk4gXaXC/Uy4augluCG1PHCnZlDMao2oTQBVVEnJX2540
 Co5vv4tfyrFgDY5Mll0OwA14jNQYydDYJwfJilffC9h5dT7iwfmho+JOqMTGHLShzDaW
 zey7elZhHjQsCjcISVZw8WOIrHfg9cyrewhiLG8e9JepPJ1b61sEYc815rFRNs47FGde
 wR8fJ500EEgmq/BViUEBHReZFkA0O793k2Ur3uHxIS1mofaBbZ/pxbML2AYXJAZ6zWnO
 TdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770684674; x=1771289474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZDIISpTTtHNRFZieHFAsokEioPS0ILymI/CJg/y2bY=;
 b=NC+51LCb0aNUcSA4vp/MqGIy/7nlc6BR1IgCNluztdySg4ZwNtH3ps4qzkXh78IOOM
 uq6oH9KmPohnqYBYaYU0Wh52RJoyIbAFr7ElPw28ZYKQmYySU4Qew3cfmuspwN6EB57/
 aaWQMDPVB9MMK78ut1w2NswH727Srd/TrCwgb0dGxKea2mGPRgMshp8K8eAgwVWGwBLj
 ncoOWoqLwsAsmuPohcV1IN8mj/7RWDnZ9xU7l+VtN1vETZftopiUrqdk61B79wR0tfCp
 aFAb+7pQ2rpbnXwpjT/QaBX/4bDOmXLm0JUpRnVUUKTTRNu05rUGeDBcm6tK90FNsvc2
 UQmA==
X-Gm-Message-State: AOJu0Yzo1k/+33Ejya+YqIgFoooncQZMdbOn2nnVHAw+HTLiLIvafzCS
 qAMS4gVVSvjpTk7/aR43lAUUTTmuoN8ivM3x0klSQAG0YYe+Y8DCRUDzp+VyZ3FFtix2JnI0Mh7
 4u6w6
X-Gm-Gg: AZuq6aIZNA0536awLF9bR5y3dm0bYoxibeBtVG1qC8V/QZODXAD5KwOaFmlC9+EQ6Ni
 cX+VuwmwCUOmrtnpGEK92U0qn9GViX92NPtGTupb3zWdLWwF3yZKTCVvc0N2CzmR4pGiEu7itOD
 yzVCMmd+QHKNP63HiciWQaqUtoY1W9GwX8pzdUs2wNphxIgfoQzdfzWUYi+R+6E4zTknOL4FRvF
 in1XSnmZTcSPKRRdQDvO8DNHCK5hYddxBB9mnc7TXyqefbSoHjJh8uDsv9sSLx2Bv5ZX9j34Opo
 MfX4V7Kv7Wi0dbw5kQvu5r8Q5AQekGuiFm6z7gG2FzKutP23hRdr+/xdg5nFzAxwxnAMpR2vu+J
 0JEE2XWvo+9/4Pqgh4VS8lRmeoifGg0ozFRfEjBPTVFE3NQTup2on6dgW0Lz4q9R5Fv3p9AB0lc
 hfGeVgOqLoZbIeC8KMEHwX1av1eTR4MxuaxXqMXZBfqm6BvtVzxzjhBBF2MgHn6tI7
X-Received: by 2002:a05:600c:4745:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483201e4b18mr210529805e9.16.1770684674210; 
 Mon, 09 Feb 2026 16:51:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77b3sm26805935e9.2.2026.02.09.16.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:51:14 -0800 (PST)
Date: Mon, 9 Feb 2026 16:51:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v5 2/6] net/nfb: fix bad pointer access in queue stats
Message-ID: <20260209165109.3d7d17b7@phoenix.local>
In-Reply-To: <20260202193330.3324681-3-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
 <20260202193330.3324681-3-spinler@cesnet.cz>
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

On Mon,  2 Feb 2026 20:33:26 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> The driver code has dereferenced the dev->data->rx_queues pointer
> without checking for its validity.
> Pointer invalidation can occur when the eth_dev_rx_queue_config
> is called with set to 0, for example.
> 
> Moreover, an array of pointers (to a structure) was used like array
> of structures (which worked with early dereference just for one queue).
> 
> Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---

AI found this potential issue:

ERRORS (Must Fix)
Patch 26: net/nfb: fix bad pointer access in queue stats

NULL pointer dereference risk

In nfb_eth_stats_get() and nfb_eth_stats_reset(), the patch correctly fixes the array-of-pointers vs array-of-structures bug, but introduces a new issue: it dereferences dev->data->rx_queues[i] and dev->data->tx_queues[i] without NULL checks.

The queues array can contain NULL pointers if a queue is not configured. The original buggy code had an early dereference that would have caught this, but the fixed version will crash on the first access to rx_queue->rx_pkts if the queue pointer is NULL.


I added a simple check, since fixing it takes less time than another patch cycle...
