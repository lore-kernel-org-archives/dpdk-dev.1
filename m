Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E5C982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:21:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A3024028B;
	Wed, 16 Sep 2026 18:21:58 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id BFCE740264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:21:56 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db18fe459dso6924585ad.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789575716;
 x=1790180516; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=phdWmUz5jmnia6JcvJ0/YpBvpQZDEP5R94HcfSDzUP8=;
 b=Oit+8XcyfPmvA3Bwj+vrSeZ3saLtp0wL4Ehz1xsRKjfboNe47gHcmB11MFroReqpL5
 OZK4DXfaOhnluGTlLZnaKGV87XxAEbBW+iSJIiqsW32FcpCZobYbXSQ5VPZEUlIpiXnV
 mfdhy8WDsatb+j2b+SxtoetuHUSj6Qn2xQCFkNMAMoVcqOWwoW7DCnwA/0nGuxjMnXb0
 +DqAHioDLf3wt/7Bef6DTWyBfs7jdoBN/pjrCJjO+XrHr2ZSU/FNudZb5CgaPcXSjD8v
 kXzbqxJwOv150E4ptnLEOagxQAKLrbY32pYkuKAEcWjkx8H/CJ5eSXEYdfA2uOL2h9wb
 NrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575716; x=1790180516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phdWmUz5jmnia6JcvJ0/YpBvpQZDEP5R94HcfSDzUP8=;
 b=NpvaYgwe0tUSZtqbNmwopt6Ttvttq/4y4EgH7k8f0jPsP7jYv38uw3ofIBOEfaF9Nv
 Y81G+opDbeNrly66dc3N5zrkEHtxnsFKM3vEEm4cAdD2JvYoJcxnngpZvdQP1hlDLcuX
 bhvehetRkug/uT411bLH9k96sgTYQRvaILUC3PQ77xYZHBt5VMyecsdPy4K8atkM61/Y
 A8yDu9owatU+4Ng79DKmukcaVeQzLIRkDuVnqET9HZzqM7g1dwtn73acHuvd+IGiE+4t
 9I31M+aqlLChB+lM2x8zTtkOYsMQ2CtpOR9vSW3AVrOKqKi0x09jRCKrKUyWyGPP1ocU
 WLOQ==
X-Gm-Message-State: AFuF++kHZ1ApA7OBc8JgZ1/QyQE7vh0MHKebp7jJY5LAGsR6rkTJ4ktj
 OBqk9FRX76fvvbdZ2AtzMW36aKjXcUZImdO5kGRkUqZkhuHoMtcZ779QjXnpBhoiDGc=
X-Gm-Gg: AYBFou1G29bDepOIl+F7LftQNKSAMQ7aEDzV0rJiBNRNWZ2lfAQLWnk5SUpxpt3e3ER
 Z0zZPlc4A/mILMy+ENYajkSX+aGL8aPTuTVBV6jak+Jz6iwniD8JbtuB96GeN9OXa1vTAmXjG39
 jn822mW2TkDXelCWuDbTtqnHYiGZe2i4lqiSsdvELjCKPV/PPQFuein9JeeFlMwS/dAdvDC5U7j
 nDBIn31OgK8NpqwXrHKqj8fJvCqRGSYIXU081fbVgKt9kdu7Vw6i9MUK9TugpMH48JWf0eHjSPH
 GZztHXiwdD2M74Wr+svHKAkdbuT2uLUFeesAoSRSi8LGzricp6PuQ80uZe9t2BYIg9zEZGmGrRP
 /GZXM+my0/k662KjIN07gGP7iws83zywCsJqrAZiEP931hBqRIFyiXI+7ZBA3KHb5rrzmtMJ0nB
 mO2QAT9aj90wr6tIhobPuz22zD115hEwzyZ760gaUhVoFmzxu8ZOeOmFyAOZ5TVOM7u3w1Wsm7C
 1Gq7wsg8efBAu8RGE9Ps+WqI1FqWzt+Thl/dzAX
X-Received: by 2002:a17:902:f786:b0:2d8:d4dd:24c0 with SMTP id
 d9443c01a7336-2dd8e76c491mr73729195ad.21.1789575715654; 
 Wed, 16 Sep 2026 09:21:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89eb7496sm14772945ad.38.2026.09.16.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:21:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:21:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] net/txgbe: fix flow create errors
Message-ID: <20260916092148.764a8361@phoenix.local>
In-Reply-To: <20260916131106.105667-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
 <20260916131106.105667-1-zhtfdev@gmail.com>
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

On Wed, 16 Sep 2026 21:11:02 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> v2:
> - split L2 tunnel add-failure goto out into its own patch
> - allocate FDIR object before installing the global mask
> - add Fixes tag for the VF FDIR path
> - set -EINVAL on remaining FDIR goto out paths with bad ret
> - use struct assignment instead of rte_memcpy for filter copies
> 
> 1/3 fix L2 tunnel error on flow create
> 2/3 fix leak of filters on flow create
> 3/3 fix flow create error codes
> 
> Zhang Tengfei (3):
>   net/txgbe: fix L2 tunnel error on flow create
>   net/txgbe: fix leak of filters on flow create
>   net/txgbe: fix flow create error codes
> 
>  drivers/net/txgbe/txgbe_flow.c | 240 +++++++++++++++++----------------
>  1 file changed, 126 insertions(+), 114 deletions(-)
> 

Looks good still some small items found by AI review:

Review: [PATCH v2 0/3] net/txgbe: flow create fixes
Author: Zhang Tengfei <zhtfdev@gmail.com>

Series applies cleanly to main; each commit builds with -Dwerror=true.
Fixes: tags resolve (5c2352b9ece6 in 21.02, 7eef71080e16 in 25.11),
so Cc: stable is correct.

Patch 2/3 checked for early copies: ntuple, ethertype, SYN and L2
tunnel add helpers do not modify their input, so copying filter_info
before programming is safe. FDIR (PF and VF) copies after programming.
Element types match the old rte_memcpy sizes, struct assignment is
equivalent.


Patch 3/3: net/txgbe: fix flow create error codes

Warning: mask-only FDIR rule fails but leaves global mask committed

  With b_mask set and b_spec clear on the first FDIR rule,
  txgbe_flow_create() programs the input mask via
  txgbe_fdir_set_input_mask(), sets fdir_info->mask_added = TRUE,
  then falls to the final path which now returns -EINVAL.

  The application gets a failed create, holds no handle, yet the
  global mask stays in hardware and mask_added stays set. Any later
  rule with a different mask is rejected with "only support one
  global mask" even though no FDIR flow exists. The b_spec failure
  path already clears mask_added when first_mask is set; this path
  does not.

  The parser reaches this state: txgbe_parse_fdir_filter_normal() sets
  b_mask on item->mask and b_spec only on item->spec.

  Since this patch now declares the path an error, reject it before
  touching hardware, e.g. right after the rte_zmalloc():

	if (!fdir_rule.b_spec) {
		rte_free(fdir_rule_ptr);
		ret = -EINVAL;
		goto out;
	}

  and drop the trailing free/-EINVAL block.

Info: commit message says memcmp stores a "positive result". memcmp()
  returns any nonzero value of either sign, so -ret could be a random
  positive or negative number. Reword to say the value is not an
  errno.

Info: flex offset mismatch path returns -EINVAL with no log, unlike
  the mask mismatch path right above it. Add a PMD_DRV_LOG(ERR, ...)
  so the two rejections are distinguishable.
