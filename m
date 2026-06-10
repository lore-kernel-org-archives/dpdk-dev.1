Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277ECD98CF
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:46:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD85540C35;
	Wed, 10 Jun 2026 17:46:27 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 3EE35402BA
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:46:26 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3075ce9c05aso1088374eec.1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781106385;
 x=1781711185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5PbVpzhvPnWI9DLrFjZDyvtPId2bVmEl8X++q6EvIc=;
 b=qWjP4Ky88L13USrZ6izh3sLZfOeCWz3HsXUSgOtpSZfXpTCe0ab8fO4qmODyrWSnbQ
 Ur/2KH2BKp9ycai56KNLP3UVpCP/gJh0JTHJJtBFC5V590MCLOBGQCLPlHZX3tfExXCc
 7NiYP1fYnrBL7j3ge/n2Wc84sFdK/A/mdqOomQnXd1Vc/xiJlBFSuWJ2/8Ys4PT0jnkc
 HZCDyIF5tVMfrEw5TZ7qYbTf7/4k3Ay/gTZiRQ86W+yu30bNDOWQ9duGXjCGvHBqDjvK
 0BN+pinLBe7o0D+HAgzrQA8W/cm5TnbF3oUpyesHLMTJo620dOFrztAL7G23xV67xy6y
 eF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781106385; x=1781711185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+5PbVpzhvPnWI9DLrFjZDyvtPId2bVmEl8X++q6EvIc=;
 b=anE+QSd/61zEAaxqbU/daD1AAN9exP1aQHyY6jmnxxjFPoveAQfNFKAp0FjL9Nh/VA
 /+1bCsO1305wuGgYCDR1VYByux5offUT/5ESN6VPIlVaXJyiKQUSmVLNaTCM2VuXjM2b
 +tcmSnhcxqAxZxNWXbWFIpX/sUcC0pzrvr8F3ihkdwLhHmwwsfPBdPtHPkEX9nOCiiTk
 Kzeyh+m1TL2J/8ogJccNU+cJZFZarhitF+HxeqUJIrQjgsivBo5H4pWml/uexA/rvxtw
 O5WiHxlIjli4pBpTzYkr8O23i4LpWX0bPrF9sBpXG65TREKvCaHhIwynWhRnYNxiANv/
 8Deg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZReE2pOWM3mqVICASX/gY9x54Zv16SVAYHJBk81ucHjVsF0H4VDjoaE8hfhYyEz/uZcE=@dpdk.org
X-Gm-Message-State: AOJu0YxW6E0LoWbsykornebEIKbJHNFOXydObIXZeJjMBkyoKzTcUOaM
 v3xlVH+dBDfOXRe7kl6RSyxJTbT8PBJ/u4UNjXFhfeScI+MYvmB5TvlGSp1Vx+5UOKA=
X-Gm-Gg: Acq92OGnZXGFoM7la8h3qfMGCIvcsyF0kbSiJyLkFmaE7qNhI1th0ybO3YJ5m0Enbg2
 0vqdiWnPtCLbFGehq8JEuMG+cI7t3uwTNeoYwqAtfzlsyYsBVL2h2cpBBV8ngb8gjw5m3S6nWkF
 0rnicUdWOIGhSav9u59JrIVHgm3c1G8c1mo7iqIjSBugSgdftQjo2XBk8QYp0fwMl0XVh2sCLsu
 OmZe4XkSfmGQloIjLT5sDc2bdzmkgGY6eYCzOB5MQIBZy6Vb79yyR95xF/mJls4NtpfO+9D38Rf
 yngtq7TtdRyaztiOWg/bmoxQZ0jDbQVTolv17kGEFziny+5D45fo1G04+NZ8r5S6BJdA8SOgS5z
 aCogJPngndMcryBlyhzxK4vZ/3NzWGnhBT2lpGw2r39Qeby+Py2Vd/LviYQTXdo0ogh5jZbpTNv
 CAxsJd4FaZYACyw0+WG5O0l5fns1hRJ15EcCFsZhyh+JsunRC7e19OMK+cZqb0yMgLU0WhT/uqZ
 H4=
X-Received: by 2002:a05:7300:80c9:b0:2f4:3a9c:818c with SMTP id
 5a478bee46e88-3077b2d826emr16219086eec.29.1781106374315; 
 Wed, 10 Jun 2026 08:46:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea8e8csm25948430eec.16.2026.06.10.08.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:46:14 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:46:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v5] ethdev: support inline calculating masked item value
Message-ID: <20260610084610.102932a1@phoenix.local>
In-Reply-To: <20260610052729.5637-1-bingz@nvidia.com>
References: <20260603092805.9837-1-bingz@nvidia.com>
 <20260610052729.5637-1-bingz@nvidia.com>
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

On Wed, 10 Jun 2026 08:27:29 +0300
Bing Zhao <bingz@nvidia.com> wrote:

> In the asynchronous API definition and some drivers, the
> rte_flow_item spec value may not be calculated by the driver due to the
> reason of speed of light rule insertion rate and sometimes the input
> parameters will be copied and changed internally.
> 
> After copying, the spec and last will be protected by the keyword
> const and cannot be changed in the code itself. And also the driver
> needs some extra memory to do the calculation and extra conditions
> to understand the length of each item spec. This is not efficient.
> 
> To solve the issue and support usage of the following fix, a new OP
> was introduced to calculate the spec and last values after applying
> the mask inline.
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Detailed AI review still sees issues here:

On Wed, 10 Jun 2026 08:27:29 +0300, Bing Zhao wrote:
> Subject: [PATCH v5] ethdev: support inline calculating masked item value
> v5: handle some items separately and add test for them

The v5 lib/ethdev/rte_flow.c and app/test/test_ethdev_api.c hunks are
identical to v4 -- the masking loop is unchanged and the test still only
covers ETH. The changelog says items are handled separately and a test was
added, but no such change is present in the diff. The v4 issue is still open.

Error: byte-wise masking corrupts embedded pointers in deep-copy item
types (RAW, FLEX, GENEVE_OPT).

In rte_flow_conv_pattern(), the mask is applied over the fixed item struct:

	size_t item_mask_size = mask ? rte_flow_conv_item_mask_size(src) : 0;
	...
	size_t mask_size = RTE_MIN(ret, item_mask_size);

	for (j = 0; j < mask_size; j++)
		c_spec[j] &= mask[j];

item_mask_size is rte_flow_desc_item[type].size, the fixed item struct size.
For RTE_FLOW_ITEM_TYPE_RAW, FLEX, and GENEVE_OPT, that fixed struct ends in an
embedded pointer that rte_flow_conv_item_spec() has just populated to point at
the deep-copied trailing data (rte_flow_item_raw.pattern,
rte_flow_item_flex.pattern, rte_flow_item_geneve_opt.data). Because the masked
range covers the whole fixed struct, the loop ANDs the bytes of that pointer
with the mask's corresponding bytes (typically a NULL mask pointer), zeroing
or garbling it.

The converted item's pattern/data pointer is clobbered while the copied
payload it should reference is left unreachable. A consumer that follows
conv->pattern then dereferences NULL or a corrupt address. Plain value items
(eth, ipv4, ...) are unaffected; only the deep-copy item types break.

Suggested fix: do not blind-mask the entire fixed struct for items that carry
an embedded pointer / desc_fn deep copy. Either skip masking when
rte_flow_desc_item[type].desc_fn != NULL, or mask only the leading plain-data
region and leave the pointer field (and trailing copied bytes) intact.

Warning: the new test validates only an ETH pattern, so the RAW/FLEX/GENEVE_OPT
path above is untested. A RAW item case would have surfaced the pointer
corruption -- and is what the v5 changelog claims to have added but did not.

Info: the Doxygen block for RTE_FLOW_CONV_OP_PATTERN_MASKED uses @p mask,
@p spec, @p last, but those are item fields, not parameters of the op; the
neighboring enum entries only document the @p src / @p dst types.
