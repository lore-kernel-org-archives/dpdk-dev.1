Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFDCC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E21F740274;
	Tue, 13 Oct 2026 17:45:55 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id DEF6C40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:45:53 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so2554329a91.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791906353;
 x=1792511153; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJrqlHUROtA9TtfUbnlEfDc9aMH0R7Vh9V7aMYXmqm8=;
 b=okA1ALSYpomGCCBVdBdKHrLUAhhrmr1aM21hgEbB0Cm8wac/RWT5O0l21hZnOJbJJu
 IzY0ZHRH4QHgSTOkgUBQd2Pxth2BBKCKr3hpt0yUHvH2Mc3NYj7oiXsNedvyIfDXZyb0
 /Vdt+GGXUieSksYkzzCl3CHvLgCNYslsVLEmWRj17/6nO5lqIQEJJMk6EcQCoMteJnCK
 kMw8mmclg5vFWBrNkFc8jvF8z7TYEy3StnPmLbuLtecco/TPbpN9oerWPHw3daO4Ru76
 pdP8DEV0AQBJdGoOUVKNQd+PYlBYMG4drW6SEvNwkdJiVgTPyJI55834vGXPsQzG0BJb
 Rj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906353; x=1792511153;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJrqlHUROtA9TtfUbnlEfDc9aMH0R7Vh9V7aMYXmqm8=;
 b=jx5tLvqnkxruUIPaxG5heARm38FHTLoqRFR9tNPdmmtAGG/QUsTw5VwH+Kg2qMwfow
 F6tzra+hXZq/fSB2XACK6ZRaO95vNPVNy+ycPJcP1zRRWkdID1h+7iY/b0Ssa66flqtn
 aKL+BnGWY5nNPQrucODxlvyAZERkpApbYB562E+CI7+NxV8Etz/OpNCdY1BBlsVNV0BV
 uiAxJoLKqXYHMTkDnvZfx/gLRFw8aZv/sKCnOoYL+4tpgJA5lEa/gMjgftBh2GENfICt
 Ne9u+BUyVaxfupr58Y7s8rdg3m3t1wFi6fehcCCG6sM43FiECNevo7wNQHIf7e8y6dZq
 3zLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWH2vSrbf2mm1pRMm7/Bj1Z5EC/7ue17VJAV2dwdqLy77SfRlJpIhT0AH7oNzctAHLhuM=@dpdk.org
X-Gm-Message-State: AFq9FYKIeTSWKz3MEgWctS7Ha73u/9zcx6zfQpG8ZxG45vys42C0jSO4
 zAeO9TANB8WhwjW3audEZjcM+p7TLbteL83XiSzYi5HnMHrjUQSqWnLGTtM3uvT9dGk=
X-Gm-Gg: AYBFou3IGbY9s7iLduiApSnTvkcFQMNvVkbCfQm5pe15PHmaBW1op/NzqQejNBJ92NN
 upM7Dooi5f7W+Pnp6Hkry527GCN4uYrFe4pkCVbNTcsUXuEq0mrNO2jL/y6TyS+kf75rQO2iGzz
 sNf+4DbbW8ik3sTyN8S74AZsIzPBX/iurjjYeoPGKO1WwZE2yzEhUAd7Zgy36t6D1LNXTJSC4tE
 1mvNUiVA0cihnQ+amX53w4H4jP+h7iOFrvCkhcIqNyaB+cC7aATa+UpYgVXPkUVbeBQZ1WtkR0S
 v24LlI//+2WV6Xni2AzxO9PdsV/CNg/sQumxjVIATMetD5Ms9gSYXHvqCu0wj3+9R/NSZMxczuR
 D+lrNuK/zo47xGfszk4gzUEItMGxjk26Jeqf7LFWT2WhRT1mLyHrfNTljxSG5gwMTlh6w9ZZpqA
 IrG/FfMG2PqQdkBAgbMlbeVlT1EcdCq8xJwMTpioEmVxzSMtZvMdjqU9BTzUcBVlwSvommpD1wZ
 Aa1Hs/3GFNHmsDSwIY3d4zRQMXZWTKZlch+6NJX
X-Received: by 2002:a17:90b:134b:b0:3ac:12e6:a5bc with SMTP id
 98e67ed59e1d1-3ac12e6c028mr4203584a91.61.1791906352947; 
 Tue, 13 Oct 2026 08:45:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f2a88b4sm147936a91.14.2026.10.13.08.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:45:52 -0700 (PDT)
Date: Tue, 13 Oct 2026 08:45:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v7] ethdev: support inline calculating masked item value
Message-ID: <20261013084547.642a11ab@phoenix.local>
In-Reply-To: <20261013134950.310252-1-bingz@nvidia.com>
References: <20261007165904.126976-1-bingz@nvidia.com>
 <20261013134950.310252-1-bingz@nvidia.com>
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

On Tue, 13 Oct 2026 16:49:50 +0300
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
> Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Semi-automated AI review had some feedback.
I assume mlx5 will come as followon so complaints about just this patch
are not really valid. And not concerned about its complaints
about going over flow twice when copying.

[PATCH v7] ethdev: support inline calculating masked item value

Applies to main, builds with -Dwerror=true.

Warning

1. GENEVE_OPT option_len is masked, data length is not.

rte_flow_conv_item_mask_size() returns offsetof(..., data), so
option_len is ANDed with the mask. The default
rte_flow_item_geneve_opt_mask has option_len = 0, while the deep
copy of data is sized from the unmasked spec->option_len. The output
is a spec with option_len == 0 pointing at option_len * 4 bytes of
data; the new test asserts exactly that. mlx5 sizes the option data
from spec->option_len (mlx5_flow.c, data_len = spec->option_len * 4),
so a driver switched to this op loses the option length.

option_len is a length, not a match value. Leave it unmasked:

	case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
		return offsetof(struct rte_flow_item_geneve_opt,
				option_len);

and change the test to assert option_len is preserved.

2. TAG index is a selector, same reasoning as COMPARE.

rte_flow_item_tag.index picks the register, it is not matched
against packet data. mlx5 takes it from the unmasked spec on purpose
(mlx5_flow_dv.c: "When set mask, the index should be from spec").
With a template mask that has index == 0, this op returns index 0,
i.e. a different tag. Exclude it:

	case RTE_FLOW_ITEM_TYPE_TAG:
		return offsetof(struct rte_flow_item_tag, index);

Update the "Not masked" list in rte_flow.h, the comment above
rte_flow_conv_item_mask_size() and the rte_flow_conv_pattern()
doxygen to match, and add a TAG case to the test.

3. No user of the new op.

The commit message refers to "the following fix", but nothing in
this submission or in tree uses RTE_FLOW_CONV_OP_PATTERN_MASKED.
Send it as a series with the driver change that consumes it, so the
semantics above can be checked against a real caller.

4. Commit message needs rewriting. Suggested body:

  Drivers translating async flow rules get const spec/last and must
  copy each item to apply the mask, which needs per-item knowledge
  of the spec size.

  Add RTE_FLOW_CONV_OP_PATTERN_MASKED to rte_flow_conv(). It copies
  the pattern like RTE_FLOW_CONV_OP_PATTERN and ANDs each copied
  spec and last with the item mask. Pointed-to data (RAW pattern,
  GENEVE_OPT data), selector fields, FLEX, COMPARE and PMD private
  items are not masked.

Info

5. RAW pattern bytes are deep-copied into the writable output buffer
and spec.length is already masked, so masking the copied pattern
with mask->pattern for that length is straightforward. If it is left
out on purpose, say why in the commit message.

6. The insertion-rate argument needs numbers. rte_flow_conv() walks
the pattern twice (validate, copy) and masks byte by byte; show it
is not slower than the driver-local copy it replaces, or drop the
claim.
