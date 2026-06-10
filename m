Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F1CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB644026D;
	Wed, 10 Jun 2026 13:33:54 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id C250D4026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:33:52 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so2825964b3a.2
 for <dev@dpdk.org>; Wed, 10 Jun 2026 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781091232; x=1781696032; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/l7InQ2L6SEoc5CCyKPbiF7f22BGIqrYw2QW8FjmjSs=;
 b=fK3B2hLG7NHokr2Mamtk77/y90UYyEJIDsWkO+b6Oe6A9QpjUeSxiJQ9dRRkkeFShd
 el+XAnsqWxBkt59buEfNdA5KTVFax8/sQDoCPlu5vL9rBb71gseF5todIRLf9WF5Lh34
 eR0VWT/mH+bi8DEpeH8Gy0kmjXWWyAqhgQ0p7fDsSuHhl4yG4wD6geKvfvw5gKThPYdU
 e5n8iiWaTmKVlQCBY9bB8+N2ojX/w93okMy5WGoE3XoB/LlOkrBUcbc9mKxxfOplA4yB
 cnzCZoR/qjiaRJFXUv9QuNe/GfV6/hNCnCh4MAQ0GFJcVqhjhk0q0BDsNWskVdh5+H/+
 IYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091232; x=1781696032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/l7InQ2L6SEoc5CCyKPbiF7f22BGIqrYw2QW8FjmjSs=;
 b=QrUZiFUa4LZ2Om4oS7iBgDwb9C0fLaKsDSKxSm4yMMyoo5sjdQy2z17K8WT+b4JHD9
 hAQ8RlXIRA7DjK0rBwYSa4IB7/e6KG/ZlG2KyRBc0xEHHQd/3pzlne1U6/hmo3J/6sgJ
 0xgaTOfyWbOHN7h1cqWByCUDAw8ynAnM2N1K7ypG2XWZ6Wt5UG2rblEBQjI4Plvg/dqO
 yY/eCVLgfBDr3zxzOUArrQSW92tWfVqk6M4fwuobQ2jQm72YhJ56YDiM4a+MnLkSxSgX
 6lwMfYRzseRIBRN6yYZJpzhkOEwqrhLqKfyTAOtwtMDDnuF+KfTxqwBEac5Uz10Sr8uv
 r/Aw==
X-Gm-Message-State: AOJu0Yx5P+81DWit4hyAeKCySbDJT0mTcZxHpTBrYjN2cB5++zSuCAow
 YcfCYWTMqN8dzf9va2rBrd6yeD72Xhyt5mH2WKhTF71HO0m5uiwC3sxlF8LMY83IlYw=
X-Gm-Gg: Acq92OFzt4bRVeFwmEnKeULoASzMrTgPFnLbUafywVleyPsVrkTJPoe68Jui9Q4i/SN
 6yfbekiNhrukwb1eAWfR6tfO1W9xy2CoCaTcr/RGeJRGdm3cZbUCuQ2h1exwHb/InyRJJrs/OW5
 FP03Bor2wljCl59GBAPVW41dG3L3fd/ZP7Gv18a395WTQBKwIeqdwiYjKR/LBQfluH3lfF67GP9
 0zw+kKtS3Ket5k3aDI3cfWAZSD0gZ0FUDiMWbKMgp+3Qce83o/HxvjxQrlGcrYMIJOeR0iOyBbZ
 1KCORCDagZ24lA53vUSRWsKYNBr95fyAJyQnj2JYLlsbJe+mp4kGDc5M4GawNsfbisgxfurLp0n
 fjdqcuLLe9uUzsPm1IVOX7X4g5Vzj36fqv962PKKTpwp/XnePD3hY8rG8R9FjdBBHxieJycfthT
 PKrTd1N8SJPCOXXOQ2D6aQhr/+QQhRbovp+j362Pda123gu4WSaT6I57gRVsnLJXxk8CAFFQ==
X-Received: by 2002:a05:6a00:88e:b0:841:dcb5:e6f2 with SMTP id
 d2e1a72fcca58-842b1065829mr25724757b3a.23.1781091231739; 
 Wed, 10 Jun 2026 04:33:51 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e228asm26885547b3a.47.2026.06.10.04.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:33:51 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v2 0/2] ethdev: fix out-of-bounds writes in rte_flow_conv()
Date: Wed, 10 Jun 2026 19:33:32 +0800
Message-ID: <20260610113334.277895-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rte_flow_conv() is documented to truncate output to the caller-supplied
buffer size, but two paths handling variable-length trailing data
ignored that contract and copied the full payload whenever the
destination pointer was non-NULL. A caller passing a buffer just large
enough for the fixed-size header had adjacent memory clobbered:

- GENEVE_OPT: up to option_len * 4 bytes
- FLEX: up to 4 GiB, since src->length is a uint32_t and the API places
  no bounds on it

Patch 1 aligns the GENEVE_OPT guard with the sibling RAW branch, which
already gates its copy on the remaining buffer size.

Patch 2 plumbs the remaining buffer size into the flex-item desc_fn
callback (which previously took no size argument at all) and gates the
inner rte_memcpy() on it.

v2 fixes the merge conflict between patch 1 and the main branch.

James Raphael Tiovalen (2):
  ethdev: fix out-of-bounds write in GENEVE option conversion
  ethdev: fix out-of-bounds write in flex item conversion

 lib/ethdev/rte_flow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0

