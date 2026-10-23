Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CB606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lz/281r7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8449340A6C;
	Fri, 23 Oct 2026 18:04:22 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6DA90406BA
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:04:21 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2ea0efd636dso7367025ad.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792771460;
 x=1793376260; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SkjyIQ28BbFNzHK7LEefqsCOx0prhcCT2+mL+ZBUelE=;
 b=lz/281r7sv1BsaYq7aRoJ4k02lDYmYNc5577kN+ZdNSfo+r/jZ2zaJLmx/yUjxm0z2
 vBbwqfbY5dykyPmt+nwhz8M9934sefxLXhncwf9UV/DntL3GTsFDTjMR389KpKSLqLei
 M4+4yn14kYKmEjFLXkn46HB5Co1qOtYSzj++Qkwo12UkXYiJT/5IYs48U4D0ymuoHZLT
 yD9/KeK5bywZznHvRlV7qeeARBNjc0X6X22QqgpiXXO4wM1t2ptCYWFNbD6c0hYS7zsV
 3yIemT//xH1doIyLHBcv7tt9tzegGWSw5zE22lx/jp5XeBjqj3J0IOOt5vZe/4uQ6WnX
 oDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771460; x=1793376260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SkjyIQ28BbFNzHK7LEefqsCOx0prhcCT2+mL+ZBUelE=;
 b=IcCOyeNKa0v51sIyawMDAdF5I930DEKtQUObmo/OCz/p2Sb8Fs+pIOob2bggMTDnAP
 qmjqru8XoAoR4vWifE6PcilmDzReQNrGlBbsafDTyTlV8KXPxZ3tej4s4bwHCsf9J9BX
 K0gQ51r+FP9x6Bth03mR7EYx4Ji0DSKXuhHgjjzwcwiiDLVAIjn6gz0/clnrYVWKpF2o
 gi9bdiWxlmobJt4t26VfHLfJY7gfaEA2ojd7FIjfoZt8CN/pUkGSOfvBdb6vvN3YtCov
 RC5cRBypB1Oh5HzoGeUd3f1fPz94hUzPtBJkmT9R2uC9R40UUqTJF2619eEIlZ6tUOun
 GP3A==
X-Gm-Message-State: AFq9FYJMZe5eGLZwR2mCbge+Tb72UsjHp6R2ywb/9CRdJLdIhD6lCcwq
 5D+lyuwZ/boljEBzEM7Azl/1pgtja5R182DMYtgNiCqaL8A3Eh+F+I7zQncqY5z7b9w=
X-Gm-Gg: AYBFou13Yammt9RWSKMNXE7ZLukkHT5gSVfG83gnKy+07Yq01nDX2t+Q4RmDwIUECUn
 C98iaixRpgKQOtE3XlkrTFK6L9ac1qAMNMd6oBLZKgUQRqVfJug3yBe6jWHt8hAfJkaz6PlhNz9
 n/sD0FBsOG8E5qfhDVdLdHCQqRed88QZUnHVis9rIrc5PK4sHL1TkEqJfycf6K/Rk/gU5LTCXMC
 mrXRlceDwwnEgyDxITtKAnMiTLoCm+9ghdGXQiWWqtL++/VgVoTZQG+03bw8w+/mWJ0Qy9tRufg
 NwS0+Ei7O+phu4OugfIXGDCV9FdnkY5JDvgB2XKKYDBUHMzIztjm0QM4Q7o1kLTuXugC7ZpRF3r
 fgZxSY3bwLq3Q2cEHeqASRiykQ4nZlQbwV6ehr+mWneZGuxly8gal75inicyKy0xCjlU6oVNpuU
 /ZEn2J/ON+QF7QpdWDf+WYT4SdrK9o5cjOHDKJrU4ltXeRh1FRFaM2M1FsfRSnxa2EvaA9Ryzp8
 EJz7Mr04tVVAotFIe2dtGZQLq0Ia0/2NhB06md7aEQ81l5SgxFUEtzg+ftQkZZjc0z5L2YGTfkq
 4Oh2r57atbhnRwfpXihjUg==
X-Received: by 2002:a17:902:d582:b0:2e2:da4f:b2bf with SMTP id
 d9443c01a7336-2ea7d12c2d5mr26305255ad.44.1792771460330; 
 Fri, 23 Oct 2026 09:04:20 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea94751b9esm2221925ad.35.2026.10.23.09.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:04:19 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:04:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/1] ethdev: add flow item structure size query
Message-ID: <20261023090417.219e1e91@phoenix.local>
In-Reply-To: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
References: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 13:15:46 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Add RTE_FLOW_CONV_OP_ITEM_SIZE to retrieve the fixed specification
> structure size for a flow item type using the existing descriptor table.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

I am not sure about the details AI is complaining about here,
but it does look like it has a point. Also it should be possible
to get some code coverage for this in a standalone test.

[PATCH v1 1/1] ethdev: add flow item structure size query

Warning

RTE_FLOW_ITEM_TYPE_MACSEC has no entry in rte_flow_desc_item[]. The
table uses designated initializers, so the MACSEC slot is zero filled.
With this patch a size query for MACSEC fails with EINVAL "unknown
item type", although it is a public item with a spec structure
(struct rte_flow_item_macsec). The doc comment says only unknown and
PMD-private types fail.

The hole predates this patch and hurts existing ops too:
 - RTE_FLOW_CONV_OP_ITEM_NAME on MACSEC calls strlcpy(dst, NULL, size);
   rte_flow_conv_name() has no NULL name check.
 - rte_flow_conv_copy() sees desc[type].size == 0, so rte_flow_copy()
   and RTE_FLOW_CONV_OP_PATTERN silently drop MACSEC spec/last/mask.

Please send a separate fix ahead of this patch, in rte_flow_desc_item[]:

	MK_FLOW_ITEM(MACSEC, sizeof(struct rte_flow_item_macsec)),

	Fixes: 0aaf097585a6 ("ethdev: add MACsec flow item")
	Cc: stable@dpdk.org

Missing release note. RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, also new
in 26.11, has one. Extend that entry in release_26_11.rst:

	* **Added flow item default mask and size lookup.**

	  Added ``RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR`` and
	  ``RTE_FLOW_CONV_OP_ITEM_SIZE`` conversion operations
	  to ``rte_flow_conv()`` to retrieve the default mask
	  and the spec structure size of a flow item type.

No user and no test. The commit message does not say what needs this.
If the consumer is flow_graph or a driver parser, send it as part of
that series. app/test has no rte_flow_conv() coverage at all; a short
test checking END -> 0, ETH -> sizeof(struct rte_flow_item_eth),
MACSEC -> sizeof(struct rte_flow_item_macsec), a negative type ->
EINVAL, and size < sizeof(size_t) -> dst untouched would have caught
the MACSEC hole.

Info

The doc text "Writes the size of rte_flow_item_{name}" is wrong for
GRE_KEY (rte_be32_t), GTPC/GTPU (struct rte_flow_item_gtp) and
ICMP6_ECHO_REQUEST/REPLY (struct rte_flow_item_icmp6_echo). Suggest:

	 * Writes the size of the item specification structure to
	 * @p dst, or zero for known item types without one.

Every other op dispatches to a static helper. Move the braced case
block next to rte_flow_conv_item_default_mask():

	/** Retrieve the spec structure size of a flow item type. */
	static int
	rte_flow_conv_item_size(void *dst, const size_t size,
				const void *src,
				struct rte_flow_error *error)
	{
		unsigned int type = (uintptr_t)src;

		if (type >= RTE_DIM(rte_flow_desc_item) ||
		    rte_flow_desc_item[type].name == NULL)
			return rte_flow_error_set(error, EINVAL,
				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
				"unknown item type to retrieve the size of");
		if (size >= sizeof(size_t))
			*(size_t *)dst = rte_flow_desc_item[type].size;
		return sizeof(size_t);
	}

	case RTE_FLOW_CONV_OP_ITEM_SIZE:
		ret = rte_flow_conv_item_size(dst, size, src, error);
		break;

The name == NULL check here is good; the same check belongs in
rte_flow_conv_name() and rte_flow_conv_item_default_mask().
