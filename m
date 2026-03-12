Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6741A106ACD9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4782E402AC;
	Thu, 12 Mar 2026 19:44:15 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44]) by mails.dpdk.org (Postfix) with ESMTP id DF5AD40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:44:13 +0100 (CET)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-67bd4e63606so362451eaf.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773341053;
 x=1773945853; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ols175CBHqLy9IrVhaodD1MrxWdDrrOxh1e0uBuVV7Y=;
 b=hGq9BURoq+nCvAM3YH4DYz+sfu1BUj/7JQbFfT54+tuLJFOtwY4SwXkBQhkkSwPZmu
 6Sbqp9Zv7W7hxT/1VZ/+NUmfz0IzjAcRJLO+BFBmYQchJN3JsuOjIWlYyYO4YKOox3pd
 xL3ZAR3Diap6b6UYaGZlIzUNUqdZiX3J66zDWXfpbd/1TGgop8N4sfg9axeSWjpcczYX
 6HQyR7U85oZgNSldBpJdpnQK4ojju5PThaaw/fVSKnzuu6sZNdKIrUP9ZagmrfGvnU3T
 xqQvPJDqbNXxeem8gAy3MGwLVSk0IDalIoOHiteIob+6rkShX+pCoGDi6gBuDmeeuW6j
 AOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341053; x=1773945853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ols175CBHqLy9IrVhaodD1MrxWdDrrOxh1e0uBuVV7Y=;
 b=REpa/CY6dp1PSOEAHMvYqoOksNoIyqFS3pdPK7cBw+Shl9vtMp1po7PUE6aeg6FoSd
 GPnpzT6IOJ/7U8bdy6wJqiVqW0H0Qmez7HZ8oxDL1/G0wxWl5b/Ont2H/tU1VhNbTfWZ
 r0uBVRPFtxnlrE4z04Zmfjj1iHbnsT3EsV5YL2LJ+YgvkrzfLjB8p04HS8/5f3QC1qRO
 VPZYCJBlV2xSWLVU/0OEAXi5vHZy4BUViT4d2kFFz9MJnaBnwznCVtytgpYuJ5zMdimx
 OPov9C1bKcvkxU4GjpwZw8fhLYgR2dKHd3YWz/ndArpXCAzTHz8XFuth2vDVngZExjJm
 s9kQ==
X-Gm-Message-State: AOJu0YxrWpuTWlT1PlyiockJhIxIfBa+OgPFEO5HGIwA6AKWSHwRbw0O
 /k18c89mj7SIcOXd7T209tYj6SAql/lr3BOidmX8X3pBhXbr//5K3a+ejHL3g0S+QaY=
X-Gm-Gg: ATEYQzw/Hp/Q24D1vhSkRYduNJa0U4vO+2a0PCzjKiFKa0GEieatTopatQZE6vu316K
 Kwn4/iMfJOD7L8twuGJm5b0i106CjzW6yZGKkiADc5ajUcDZRZjWea+lUSttnExe1XKkIbpmgKx
 ZZd+aM2YAzoAkXLl5Bd+7F4lJnqIyoXy2wYeh34L29PUqxQxrHInsMFR6AgIg+cZT3TEKKG8QjD
 eNNbmXLJh488uREDT6HYqYQBDS9KSb9aRKt/n5IhotGJz8/f514LJHQWiEsv5+heFYGjijEGGOi
 zoQbtRjvHR19AICMIbvRCDYwUAhEyYScq7i4dWiUyit2B/SjyNeUm2JhSgv2KygOxsC63RQWnRt
 mTQlXFr3w2/bmskjBONgLloa2IQjpcWE3OdnjF4LRgWjemyCMNfXzijeLt7Jhx4Il9o1B6iM2QV
 HHCisu19hSiVhhagOIU7YElIwvlbSd/bA2B+DSokuOTIO//g==
X-Received: by 2002:a05:6820:60e:b0:67b:b0bd:8bdf with SMTP id
 006d021491bc7-67bdaa586b3mr238596eaf.51.1773341052866; 
 Thu, 12 Mar 2026 11:44:12 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9336db1sm3437039eaf.14.2026.03.12.11.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:44:12 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:44:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue guard
Message-ID: <20260312114409.3b56b378@phoenix.local>
In-Reply-To: <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
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

On Thu, 12 Mar 2026 10:36:15 +0000
Talluri Chaitanyababu <chaitanyababux.talluri@intel.com> wrote:

> Update forwarding TC mask based on configured traffic classes to properly
> handle both 4 TC and 8 TC modes. The bitmask calculation (1u << nb_tcs) - 1
> correctly creates masks for all available traffic classes (0xF for 4 TCs,
> 0xFF for 8 TCs).
> 
> When the mask is not updated after a TC configuration change, it stays at
> the default 0xFF, which causes dcb_fwd_tc_update_dcb_info() to skip the
> compress logic entirely (early return when mask ==
> DEFAULT_DCB_FWD_TC_MASK).
> This can lead to inconsistent queue allocations.
> 
> Additionally, the existing VMDQ pool guard in dcb_fwd_config_setup() only
> checks RX queue counts, missing the case where the TX port has zero queues
> for a given pool/TC combination. When nb_tx_queue is 0, the expression
> "j % nb_tx_queue" triggers a SIGFPE (integer division by zero).
> 
> Fix this by:
> 1. Updating dcb_fwd_tc_mask after port DCB reconfiguration using the
>    user requested num_tcs value, so fwd_config_setup() sees the correct
>    mask.
> 2. Extending the existing pool guard to also check TX queue counts.
> 3. Adding a defensive break after the division by dcb_fwd_tc_cores to
>    catch integer truncation to zero.
> 
> Fixes: 0ecbf93f5001 ("app/testpmd: add command to disable DCB")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Is the same person as this one that is in .mailmap?
Chaitanya Babu Talluri <tallurix.chaitanya.babu@intel.com>


