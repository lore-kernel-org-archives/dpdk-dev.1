Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA9C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 16:06:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169684279C;
	Fri, 18 Sep 2026 18:06:48 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 0368540285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 18:06:45 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469a34908so937391b3a.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789747604;
 x=1790352404; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nqonN+XljdLUVXaGDrWi0qTxqO1ybHh4m2HPS+MBeKI=;
 b=UXc8s+V+mWaX2lbDEqXghL/8YaRH06mypQi7KsUhxmeNGsQbgJGZ+QHv7PcE7/suvW
 +1UUkEewRYcYhZhEygZDJcv/vKeKn5VdZcD98soo4gRuCgfc3GJTVkztfv7m/sZWvW3U
 beJXDJM99I8DPa/GyFFEYwKjA2B3ICk821S41Zvi7yeZPhyIm/9S63xvn0paQb9d2T59
 253lOQsImjGmySvca9eLMh2O7OgGY8TDwJlMJBv43lEAnjNxhJa/cyYZ1BGbnXq5tQqe
 XmVUUmarENsAecIsQMSfBxhIFbk3N+FAWyTQycBvNkQtbfztxO2LpVtER21dFUMzXHKW
 vAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789747604; x=1790352404;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqonN+XljdLUVXaGDrWi0qTxqO1ybHh4m2HPS+MBeKI=;
 b=kcaetYz7MUaEPdNFQnhhOwMdXd6NrOoLEHTzRBnE6jqlMCQKOAWbmHMzXYLzzPavFk
 bOAdR6dAnl7vIF3UXZcb0rlx7owWDW7bKKKhre7ToZqr30+fl+A76w76rZmFzmaYPhFa
 9caJ8LRV/PaRcLsJYsNw4T/N4ZO4qSU3j3T5//dcEsj/lvXiMDBrrpNI5Hea7X02LKLy
 A9g7K9ANOHGUZojbM2rOS5Y4ydBcpeX4m9zwa02C1qtVGNEeBo3W/JAZI1SX7RvUz1+W
 835wIcI1XpQ8nWTh3yFmP2rVGEnMRHPJ+Hgt5gDW831hdE+nvb/xJovQgXoF/hNY6eAE
 Pqvg==
X-Gm-Message-State: AFuF++mJqGNLs+aZapzSlH0QB2ZisE6VxUxWY/DY7oolLG+xGVf5NRiz
 yT7MdyLPyNbXfIYGJ87oZ/mDHBimyA57ZRWs7hSagoy8aLhzAIH9SHKl4l77sAs926Y=
X-Gm-Gg: AYBFou1a7PYBbkkNiNPS2Ds9fF84IQtjmHVmcagKP3kdVgLrY4Qn/quZbM5WqYbwfw+
 3/nTFllixLom9kRv392P/piYds8edNJWgRIZm+SLaiA2iU9dz/eGG51K7zsnpJNM+72ofZDZQTn
 KFi/L0CmY4JI5uqyX/ALA7owTVJNGdfd3BC6ac3btmzoLjq25elskoxWPXJ3pVFZAK6a1g/tcwY
 XjGI+STcrJPXBJOFpu/0y7TCmesNXbnoAAGz6oZeLpSpCPHve6UOJHKg4Xa5SxtHvaT35vKJtD+
 +Ku6eGcY+qNOBVhSqIRHFvxGFwK/ekGxF+DJfDawNanFbFDYQC4keg2H5Uo/pwsJ9BHj4/KjC3J
 +RUEpMIdRB4YkpXsT/xQ+UNz82PCS85Q3luc5UJRjvqE9kzgOzR1yOwr0UUu6zBSJzLBAMxg5AI
 9f03mo4HnuGFcZQgC6dRCftWEzQkkRz6DArWm0QzOJe64fGOKbpFgOuQFDYb80B6E6Uydo9h+VC
 ak9SsosjzM2tNVnjD3iKVTIuvazrvskbS4+Vlu9iVPLLcP+t5E=
X-Received: by 2002:a05:6a00:2451:b0:871:fcff:e904 with SMTP id
 d2e1a72fcca58-874de20b923mr5565859b3a.25.1789747603386; 
 Fri, 18 Sep 2026 09:06:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a6ae7d71sm5460b3a.2.2026.09.18.09.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 09:06:43 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:06:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/3] net/txgbe: fix flow create errors
Message-ID: <20260918090640.5e576e89@phoenix.local>
In-Reply-To: <20260917153242.29315-1-zhtfdev@gmail.com>
References: <20260916131106.105667-1-zhtfdev@gmail.com>
 <20260917153242.29315-1-zhtfdev@gmail.com>
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

On Thu, 17 Sep 2026 23:32:39 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> v3:
> - reject mask-only FDIR before programming the global mask
> - log flex offset mismatch
> - no code change in 1/3 and 2/3
> 
> v2:
> - split L2 tunnel add-failure goto out into its own patch
> - allocate FDIR object before installing the global mask
> - add Fixes tag for the VF FDIR path
> - set -EINVAL on remaining FDIR goto out paths with bad ret
> - use struct assignment instead of rte_memcpy for filter copies
> 
> 1/3 fix L2 tunnel error on flow create
> 2/3 fix leak of filters on flow create
> 3/3 fix FDIR error handling on flow create
> 
> Zhang Tengfei (3):
>   net/txgbe: fix L2 tunnel error on flow create
>   net/txgbe: fix leak of filters on flow create
>   net/txgbe: fix FDIR error handling on flow create
> 
>  drivers/net/txgbe/txgbe_flow.c | 266 +++++++++++++++++----------------
>  1 file changed, 140 insertions(+), 126 deletions(-)
> 

I applied this to next-net.

AI review had some Info level observations, if you want to send
a new version, I will replace the one in next-net.

Review: [PATCH v3 0/3] net/txgbe: flow create fixes
Author: Zhang Tengfei <zhtfdev@gmail.com>

Applies to main, each of the three commits builds with -Dwerror=true.
Fixes tags resolve; both referenced commits are in released versions,
so Cc: stable is right.

Patches 1 and 2 are unchanged from v2 apart from commit message
wording. The v2 warning is addressed: mask-only FDIR rules are now
rejected before the global input mask is programmed, so a failed
create no longer leaves mask_added set. With that check in place the
b_spec block is unconditional, which reads better than the old
nesting. The memcmp and flex offset paths now set -EINVAL, and the
flex mismatch has a log message.


Patch 3/3: net/txgbe: fix FDIR error handling on flow create

Info: the b_spec check sits after the rte_zmalloc(), so it allocates
  and immediately frees on the reject path. Moving it above the
  allocation drops the rte_free() and one level of churn:

	if (!fdir_rule.b_spec) {
		ret = -EINVAL;
		goto out;
	}

	fdir_rule_ptr = rte_zmalloc(...);

Info: the VF path still reaches "out" with a base driver status code.
  txgbevf_fdir_filter_program() propagates TXGBE_ERR_FEATURE_NOT_
  SUPPORTED (-292) and TXGBE_ERR_NOSUPP from txgbevf_set_fdir(), so
  rte_flow_error_set(error, -ret) gets 292, not an errno. The PF
  paths checked out: txgbe_fdir_set_input_mask() and
  txgbe_fdir_filter_program() return -ENOTSUP, -EINVAL, -ENOMEM or
  -ETIMEDOUT. Converting the VF codes is a separate patch.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
