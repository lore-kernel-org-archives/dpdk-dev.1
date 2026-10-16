Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A84CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A628402E7;
	Fri, 16 Oct 2026 18:03:25 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9FE654026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:03:24 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso31468b3a.3
 for <dev@dpdk.org>; Fri, 16 Oct 2026 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792166603;
 x=1792771403; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BCv6FNF61SmG77cVflOjKJw2blvB5dVvd/5jeKJyOfg=;
 b=FSu4ba+zCjujahk1mJzMVDBa/xP2oxpWJexJ9q4LBcmvRIrzqf4AgucnlqZQGETM2K
 N/yY0z8JKUPZFFrUxE6LFvIg4dhqUp+6dnbW9JZvjhF9jIbEn4XbaHzr2VKE05PlHt9k
 BMqhDouvpw6WQnBILsapQGw+wJ8C3XXtAHYlUNtP0LwpcyFjLbhedj3KnhGZhFhpHcRu
 y7UZiJisMdyYH9ANQQnInQUwJASF9P0Z6wAzosQjdECnLyezF8dKySvHaY1DzJsmJ6Q3
 2GznMqv+fVS3WEYr7wYqijEUpJxO102Mu51xzKitflQLRzMWrspLG4AWSExGhPpTtuxF
 gDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166603; x=1792771403;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BCv6FNF61SmG77cVflOjKJw2blvB5dVvd/5jeKJyOfg=;
 b=10lYbloZnivMgIW2r5crw5r9sOEx6bwKcHa1vJ4rdlgDs825CdoTpasMALciJmFnJG
 DmBwGZSlalZQMlpX/CX4533HMltlQ8QHCDC8CauRpuRzQOKIlUZHWzbVlY8h6j25Mq5w
 v2qe9/Yqm9qw+UR4KCO107d7V+kKb0EqIDnPcXy+/6Xd6T0h64avNaenxF4xqKrNUsII
 xmGgMTZVN6jDaZ/dZCIInD/N2QjjWzt1E1BF79hJxOQsXN/8xXPC0VFsxs0JPSaxVWpj
 jgN2/K8H9yA1G6/u7UM7FCzGQQkFl9sguUR1Em9CdY3KE+PSvtuT39Fxfg1KHTsubCE3
 Zoow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRbu8+U0EMFY7da7aeo23K4mwgxwl9FzPR79Dtdxxmo42uQo/xMYSCSrc+yteURb0Ikic=@dpdk.org
X-Gm-Message-State: AFq9FYISk/fYJ/rsC3bwvrViKGQmd3Q8CgKsfWFkm7Lmq/oyIg2Q6nkC
 RGXNsavQR8kS7GEQ59e7aNMf4zXnJMyY1U32MSz+TWvRRUTK89E5+R8GIw4IHHwCW4U=
X-Gm-Gg: AYBFou3Y/CNC8QnxhrYjDWeAnB5x3xgMd7RQ9MCzk/tDUhVO67/Bg1gc4WH4sXS19bz
 qaNUaQjhyRCerR0wSm/YXIFZZgvxm+7HPPs2Vn4VMr/w9pUvzG5XzNeBM5lEZ2eBbWZv6lYGo82
 PWnkgrkmZ65EUTvzLE7KHck/opwvrsnLYFRSCCJeGncLIURWdZM5zlp8dR/4w8VmfBdgv1t+Smc
 GvnY/DrPn38LmFCto45h4YXx5rWxGxwYWQPIZoG5vsGcqToRokVQmZNVFHfPYQO5C6g7wGI9C7t
 OVeS6ZaqZmClF3IKyWLuVxAOJjj6hpr8r0loWatAd5MzPFcalq7DpWi6UE143LLzHTT/NpxM8vG
 V3mqKzsxEylorw2uGbcLF6W7ZHr27SaMCyCFjY9r54yDE5c8ZmzYbTZRVo1xXSHAGSAvRjBKy8P
 MeCKB8splI8ERjXTL0tHq1KMxWFYXjB4H12s6FAbTI/24Urh4LoSXieiat0fle9yniIY+uvPhLU
 /n9fiu1GiLbyQmd+jllcMJ+zjkCWYc8SqPiePs7
X-Received: by 2002:a05:6a00:918a:b0:899:465d:c8ff with SMTP id
 d2e1a72fcca58-8a04ba30b6emr19634b3a.13.1792166603570; 
 Fri, 16 Oct 2026 09:03:23 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f51f26324sm1329144b3a.0.2026.10.16.09.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:03:23 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:03:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v8] ethdev: support inline calculating masked item value
Message-ID: <20261016090320.31d42667@phoenix.local>
In-Reply-To: <20261016052645.288851-1-bingz@nvidia.com>
References: <20261013134950.310252-1-bingz@nvidia.com>
 <20261016052645.288851-1-bingz@nvidia.com>
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

On Fri, 16 Oct 2026 08:26:45 +0300
Bing Zhao <bingz@nvidia.com> wrote:

> Drivers implementing synchronous flow rules through the asynchronous
> template API need to apply item masks before creating a rule. The spec
> and last pointers are const, so this requires writable copies and
> per-item knowledge of their sizes.
> 
> Add RTE_FLOW_CONV_OP_PATTERN_MASKED to rte_flow_conv(). It copies the
> pattern like RTE_FLOW_CONV_OP_PATTERN and ANDs the inline fields of each
> copied spec and last with an explicit item mask. A NULL mask leaves the
> values unchanged; default masks are not substituted.
> 
> Preserve GENEVE_OPT.option_len and TAG.index because they describe the
> pointed-to data length and select the tag register, respectively.
> RAW pattern and GENEVE_OPT data are copied without applying their
> payload masks. Limit this operation to inline fields, leaving
> variable-length payload masking to the caller. FLEX, COMPARE and PMD
> private items are not masked.
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Before merging:
  1. Need this warning fixed.
  2. Need a driver to support.
     It doesn't make sense to have things in ethdev until a driver uses it. (YAGNI)

Make a patch series for mlx5 with this as the first patch.


[PATCH v8] ethdev: support inline calculating masked item value

v7 comments on GENEVE_OPT option_len, TAG index and the commit
message are addressed. Applies to main (26.11-rc1), builds with
-Dwerror=true.

Warning

1. INTEGRITY level is a selector and is still masked.

rte_flow_item_integrity.level picks the encapsulation level, same
class as TAG index. rte_flow_item_integrity_mask has level = 0, so a
rule passing the default mask explicitly gets level zeroed, turning
an inner integrity match into an outer one. mlx5 SWS reads the
unmasked spec->level (flow_dv_translate_item_integrity(),
"if (spec->level > 1)").

level is the first member, so an offsetof() end limit does not work.
Return a range instead:

	static inline size_t
	rte_flow_conv_item_mask_range(const struct rte_flow_item *item,
				      size_t *start)
	{
		*start = 0;
		...
		case RTE_FLOW_ITEM_TYPE_INTEGRITY:
			*start = offsetof(struct rte_flow_item_integrity,
					  value);
			return sizeof(struct rte_flow_item_integrity);
		...
	}

and in rte_flow_conv_pattern():

	end = RTE_MIN(ret, item_mask_end);
	if (c_spec && mask && end > start)
		rte_flow_conv_apply_mask(c_spec + start, mask + start,
					 end - start);

Add INTEGRITY to the exception lists (rte_flow.h, helper comment,
release notes) and a test case.

2. Still no user of the new op.

Nothing in tree calls RTE_FLOW_CONV_OP_PATTERN_MASKED. Send it in a
series with the mlx5 change that uses it.

Info

3. NULL mask is not replaced by the default mask.

flow_offload.rst says spec without mask means the default mask. The
default masks are now in rte_flow_desc_item[].default_mask, so the
op could do it:

	mask = src->mask;
	if (mask == NULL && (int)src->type >= 0)
		mask = rte_flow_desc_item[src->type].default_mask;

As written, every caller has to handle the NULL case itself. If
leaving it out is intended, say why in the commit message.
