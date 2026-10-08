Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAEFCA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 623ED40294;
	Thu,  8 Oct 2026 17:27:49 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 29AFC40284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 17:27:48 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso26632795ad.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791473267;
 x=1792078067; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U5L/7SLFKOvJ9Y+Y6fqbrrzB20DS0g+kDigDRHrxNMk=;
 b=lBCeii1GEDTO5WT+bYO4ghWS0ZiOcAGQGHGE5T5BBQuqyob9pQIvIctoWBGdb1FJA4
 jYb8lP+e8WW602yXGpqppzstCe5OnvlLRSLjpPibfEylOKUO3nwVTra0bYW0NAIxk50h
 d8q2oXfYWIOWiDxXow47w+dx1S9jJzNqlEuelEC1NZfyFCaNwRH2oX/mpKe2XC+ai76Q
 P8jwWDoFwXRlNGWZk4djz4u+LfzYXKPIi4rolpvHvE3vXnrDSW1NhN0EsUAEVh0pUCCx
 9K+tBDk+iXFvRtTKbdp0YBmX3f7aK9JqtcffqECzQXjd0DwRVQi8/538jisDVmJPukD6
 9bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791473267; x=1792078067;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U5L/7SLFKOvJ9Y+Y6fqbrrzB20DS0g+kDigDRHrxNMk=;
 b=NnesAF8yuJTJewhyEZDC2MYXQrusL8e7FB6U9wbl/etfCImV4QHgYmh6lhmeRk9wAS
 pKn/n1fwRsW8ivXQOrUJBkSgwH+aS5jFTIzsX6BxWNRNeAieRNZ+ey54qjlOF1FiBRA2
 jq83NeWoj02yaMm+pII/YSp4pe6HS0a/K0S1Nkylya8zq++dPYtWssVNsNGkb+niHahc
 bU3nffX9hYbIpcO82v5cDgGh/H/u71f60BoRN1QYrHXrHD4OQW7n4bNARLHC88XMQTG+
 +zM2k4xpDsNBqoaMFULPYH1jmBpee4d220oK8wX3sEs85L2YgrqH6Bf0tH+Q+wnwFoJx
 VvaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmc/Jx9MoJpAScyF6eQTY9guBh+Wv2/e7b0KQpkTgGPLtKDwJyhhqVExwg8XzepIFCnX4=@dpdk.org
X-Gm-Message-State: AFq9FYI9i3seWtg16jL9tcEjeb7LgkvHxicysiEzu4Ht2/38qA+mBaKC
 KksV/eTsInNduLKuoAHsHmYbItNsg0xpD3f2chOISi5mJ8WEsNFZwlvM5viImObE9tE=
X-Gm-Gg: AYBFou03r+ljsDWlQmIsrX41d4pYlhiDaVcRFJ3I+xdkHKa2R7rsolHC68VN6/91xbR
 jKCXTuoqFCj19x0V40CsUhLw4jOHovjDKCAkfMy08kp8AqVc5rL8YXWX5Gcdw/6I66fwO3oDg7c
 Nl+N9W8ZJStKLJkoSE4yth/F97Iia/x4KmRLkQa9KnVQpFo/rcwVmPPTWkyUrSakki9Ys+lFSN5
 LPQXd7Bi3+SeVeUCOYkKiBVRbGEVlG3EVWHKdKV85AqyB2wKmCktb1bID+LZ0zzAifVyq81sNFk
 hj96TlW8HFGQn3usbBiPy6HaOdj2QWdANM97IvLseu12d7OtjbJ9q/6CS/0Figne+kPkEPFi7uG
 8DYGiSE1r48bGD1zpbwnWmCx6x0ZH0xPHjpg2tx5/hRE9G5Fk8lOFIIvbtcVS0f+qDYmRrYV+Rv
 8AihgL2IfuGA2nw5j2inCzaMveR/S338v9/JIoZaXrgjGNxOKHxohP9/Ogut/+npzzG54t+tM5v
 /Y4IEzp0PqMt3RwEQvoN5mNYit/j7onpjPabsPT
X-Received: by 2002:a17:902:ebc6:b0:2df:9257:8088 with SMTP id
 d9443c01a7336-2e6005ca7dfmr49082825ad.57.1791473266922; 
 Thu, 08 Oct 2026 08:27:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e606da751dsm26927615ad.48.2026.10.08.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 08:27:46 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:27:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v6] ethdev: support inline calculating masked item value
Message-ID: <20261008082741.24799e74@phoenix.local>
In-Reply-To: <20261007165904.126976-1-bingz@nvidia.com>
References: <20260610052729.5637-1-bingz@nvidia.com>
 <20261007165904.126976-1-bingz@nvidia.com>
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

On Wed, 7 Oct 2026 19:57:44 +0300
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

Existing AI review done by CI is useless at this point...

Running a more detailed review does find some things.

Review: [PATCH v6] ethdev: support inline calculating masked item value

Error
-----

1. NULL mask leaves spec/last unmasked.

   rte_flow semantics: a NULL item mask means the default mask
   (rte_flow_item_<name>_mask) applies, not "match all bits". Here
   item_mask_size is 0 when src->mask is NULL, so spec and last are
   copied raw. For ETH the default mask is all ones so nothing shows,
   but for IPV4 (default mask covers only src/dst addr) tos, ttl,
   etc. come back unmasked. A driver relying on the new op to get
   "masked values" gets wrong ones.

   rte_flow.c has no type -> default mask table, so either add one
   to rte_flow_desc_data, or document that a NULL mask is not
   applied and the caller must handle it (see doc text in Warning 3).

Warning
-------

1. PMD private items get their opaque data ANDed.

   rte_flow_conv_item_mask_size() returns sizeof(void *) for
   (int)type < 0, so the first pointer-size bytes of a private spec
   are ANDed with the first bytes of its mask. ethdev has no idea
   what those bytes mean. Leave them alone:

	if ((int)item->type < 0)
		return 0;

2. Variable part of RAW and GENEVE_OPT is not masked.

   item_mask_size stops at offsetof(pattern) / offsetof(data), so
   the copied pattern bytes and option data are never ANDed with
   mask->pattern / mask->data. The same holds for FLEX (desc_fn
   returns 0). Either mask them or document it; the current comment
   says the mask is applied to the spec, which is not true for these.

3. Doxygen for RTE_FLOW_CONV_OP_PATTERN_MASKED is a copy of
   OP_PATTERN and does not describe the limits above. Suggest:

	/**
	 * Convert an entire pattern, applying item masks.
	 *
	 * Same as RTE_FLOW_CONV_OP_PATTERN, except each copied spec
	 * and last is ANDed with the item mask. Not masked:
	 * - items with a NULL mask (default mask is not applied);
	 * - RAW pattern and GENEVE_OPT data contents;
	 * - FLEX and PMD private items.
	 *
	 * - @p src type:
	 *   @code const struct rte_flow_item * @endcode
	 * - @p dst type:
	 *   @code struct rte_flow_item * @endcode
	 */

4. Missing release notes. New rte_flow_conv() op is a new API and
   needs an entry in doc/guides/rel_notes/release_26_11.rst.

5. Commit message is hard to parse ("due to the reason of speed of
   light rule insertion rate", "support usage of the following fix"
   refers to a patch not in this series). Suggested body:

	Add RTE_FLOW_CONV_OP_PATTERN_MASKED to rte_flow_conv(). It
	copies a pattern like RTE_FLOW_CONV_OP_PATTERN and ANDs each
	item spec and last with the item mask.

	Drivers using the async flow API copy patterns on the rule
	insertion path and need masked values. The copied spec and
	last are const, so masking them in the driver needs extra
	memory and per-item length handling. Doing it during the
	conversion avoids both.

Info
----

1. No in-tree user. Please send the mlx5 consumer in the same series
   so the API is exercised and reviewed in context.

2. Spec and last masking loops are duplicated, and item_mask_size is
   computed even when with_mask is false. Factor out:

	static void
	rte_flow_conv_apply_mask(uint8_t *buf, const uint8_t *mask,
				 size_t len)
	{
		size_t i;

		for (i = 0; i < len; i++)
			buf[i] &= mask[i];
	}

   and compute the size only under with_mask && mask.

3. Test does not cover a NULL-mask item or an item with a non-trivial
   default mask (e.g. IPV4). Add one once Error 1 is settled so the
   chosen behaviour is locked in.
