Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8ECD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB7B6402A9;
	Mon,  8 Jun 2026 17:46:03 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 2081940265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:46:02 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1382533d428so396458c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780933561;
 x=1781538361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roqpD+sIMxmAJzgCCYpsiGgdLHZi21FL0e/o0B/VVCI=;
 b=Gho0sTCFEFX3iNVgQvSQ8PHkicwwGNsV1eNIE1MXDuL/MbKDwzns2nLDQh+5LPyP25
 U+XZD5nglBG16304YdASFtioB4GKJMBmXH8yBmsSc/x2GNEs/xaUZReSq17oNTmw0fmo
 5Hh8JLjQQ4N9KMvR2JKxsPz8QJC4mnM0fKYWSgkiaIx7lRu50QWkahNUUA81cuwnC8yL
 jaO6hRY+WBzmo2Tq9hoxVO6hQXfJjBIgUhrrSNZkjfXern048N3BsJbg356GAMLVxHlQ
 DWtTR/9+8iRM1O9h2NCp52eUYMkYNzVoR0/ROzRiOYCcnZeQtiegQffMeauN8eYhON2q
 sS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933561; x=1781538361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=roqpD+sIMxmAJzgCCYpsiGgdLHZi21FL0e/o0B/VVCI=;
 b=D5DvFxXy7f10hXqpNAeInjleC+3PlGj1p8U7yXUtvSCV4WvFLT/cUrJHysK8Gpfsog
 qVVt1vL9LGIouYOmbBiIe50ieJFy9OSYdpD91PDYRVAyc3M3UG8PWpDaO3hXzE6lQMvQ
 MFnYupAblqqpFPTU5Cq79Fg4TThx4f7FtXj62xFPdIm5F6YUqaYWFlS1kJD5e2XwcOQY
 badbdvqUfi5pS6G7NKSnO+mBmQlVJc9Ki6sX76Wlsg8Jz7CttnE/9GT4GYFLWmsmZ5Ls
 1wH3VsTIUipLvTDvCXb45DxCUW5X8kyl6XIiSPoUAZAsHtxXRxd9zQJW8aEIjtRiOTZq
 lYQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZkWKzmzBSBDkHOI+IcddzXWtvKolpQEQ4sBIHJ9h5byk0wdzhodj2htFl+VviTePO1GE=@dpdk.org
X-Gm-Message-State: AOJu0YxzVwLDFEuUeJpKbdoeusovz5YNIrLCD9VxP/g/Sb/2ivC/l5Bo
 4gfczfQG55rKOQ2LuOKWztIZWs4lMUhlg5Fxf68bbtM7fbHdWpFszHAvwTWKtoH4o74=
X-Gm-Gg: Acq92OFU1kTp9hshqBS754Zdmv/nxY6BIiepHKDbTk34dUgh6eKnxy+y3iHHIHM3suR
 uDUdVzh1mjlGCAEqoeg4NQBCkerBXq3B01nSIe6j+CUzXbXVDzE8a8+K72vvRhEVm0IzmX901CL
 t3A6UpktQZYcE8dOofQTbtzX+VAbS72QrrLO3sasMAhHE4MPxe7yE6JvRS7IDe8KpuPUbXTAtRr
 gL//BHE+IrqSy3sGHNGb5uwZVBOWjuzCG8yn7aqqf8Avpb97Vu/6qqxHGmKDnhm9XBYndHPJmip
 rkb4nOLuK+u8gg1ESg5NwnzSO86nC6TXsUuCeTRruVEQmQK2kb4ynHoc/80p5T0SalUaqWJ0qHU
 QoyvpUQBM4pAHDCcS14W19sUKzhPbqzaFkeHXm9RvDS4TXq7MpbrmG4bdr3NmO0hksxViiyME4n
 dP74yjrUJTE7O9k11g5H38nf/3CtBA2okuYy0IuLkiA0vjaodoWqqIebl0GjSNnbhP7tWFJy+7G
 cc=
X-Received: by 2002:a05:701b:2812:b0:137:f390:3688 with SMTP id
 a92af1059eb24-138066874c3mr4032444c88.3.1780933561010; 
 Mon, 08 Jun 2026 08:46:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f53f06c4sm12214236c88.0.2026.06.08.08.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:46:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:45:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v4] ethdev: support inline calculating masked item value
Message-ID: <20260608084558.4dd4c07c@phoenix.local>
In-Reply-To: <20260603092805.9837-1-bingz@nvidia.com>
References: <20260603081941.9049-1-bingz@nvidia.com>
 <20260603092805.9837-1-bingz@nvidia.com>
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

On Wed, 3 Jun 2026 12:28:05 +0300
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
> ---

More detailed AI review found some things that still need addressing.

On Wed,  3 Jun 2026 12:28:05 +0300, Bing Zhao wrote:
> Subject: [PATCH v4] ethdev: support inline calculating masked item value

Error: byte-wise masking corrupts embedded pointers in deep-copy item
types (RAW, FLEX, GENEVE_OPT).

In rte_flow_conv_pattern(), the new mask application runs over the fixed
item struct:

	size_t item_mask_size = mask ? rte_flow_conv_item_mask_size(src) : 0;
	...
	size_t mask_size = RTE_MIN(ret, item_mask_size);

	for (j = 0; j < mask_size; j++)
		c_spec[j] &= mask[j];

item_mask_size is rte_flow_desc_item[type].size, the size of the fixed
item struct. For RTE_FLOW_ITEM_TYPE_RAW, FLEX, and GENEVE_OPT, that fixed
struct ends in an embedded pointer that rte_flow_conv_item_spec() has just
populated to point at the deep-copied trailing data (rte_flow_item_raw.pattern,
rte_flow_item_flex.pattern, rte_flow_item_geneve_opt.data). Because the masked
range covers the whole fixed struct, the loop ANDs the bytes of that pointer
with the mask's corresponding bytes (typically a NULL mask pointer), zeroing
or garbling it.

The converted item's pattern/data pointer is clobbered while the copied
payload it should reference is left unreachable. A consumer that follows
conv->pattern then dereferences NULL or a corrupt address. Plain value items
(eth, ipv4, ...) are unaffected; only the deep-copy item types break, which
is exactly what the test does not exercise.

Suggested fix: do not blind-mask the entire fixed struct for items that carry
an embedded pointer / desc_fn deep copy. Either skip masking when
rte_flow_desc_item[type].desc_fn != NULL, or mask only the leading plain-data
region and leave the pointer field (and trailing copied bytes) intact.

Warning: the new test validates only an ETH pattern, so the RAW/FLEX/GENEVE_OPT
path above is untested. A RAW item case would have surfaced the pointer
corruption.

Info: the Doxygen block for RTE_FLOW_CONV_OP_PATTERN_MASKED uses @p mask,
@p spec, @p last, but those are item fields, not parameters of the op; the
neighboring enum entries only document the @p src / @p dst types.
