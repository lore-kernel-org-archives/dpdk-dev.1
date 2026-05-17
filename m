Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9601CCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3583402EA;
	Mon, 18 May 2026 01:55:37 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 5C86B40264
 for <dev@dpdk.org>; Mon, 18 May 2026 01:55:37 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-135200bc7d2so4515216c88.0
 for <dev@dpdk.org>; Sun, 17 May 2026 16:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062136;
 x=1779666936; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eeuVqMUWCmURiEc5TUaSxB8/Y30fLEvgovALPV07/A=;
 b=paDhzfEs9zGDSEC/nhzmYQLREkzJ9js925bS9oadocsc190tco8iMEef2BvVUq/C7C
 BGtxK10IbTjv92uqY42Ls9PAHxkeUVXs+3H08Cq56UWQgBlmTPrzjVzP9q0NjI7JPyqM
 F9gFp/lphzyltIeizd1cgXpWT3a0LuNwUdHr0GluwgVEVBx3JOGB1K6y7jXaePM8PVGq
 dOq3ZUz1rKkgu8vdrje4NLHtkEdgf9fUJIUUa+keKpLrubWJ2jqz52xcnhuhcgBiia4U
 cF6g9D7xuQ9VJEiHOx5KTUeIQlRL9RfVkOvWaXgmD99xvQPmlTH1QrWdjCoDUZ4hlgV9
 Qwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062136; x=1779666936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3eeuVqMUWCmURiEc5TUaSxB8/Y30fLEvgovALPV07/A=;
 b=bO9Vxzf8yPtmTJIEb6TkR89wJygxFXdn04t46TrvAyBr407gXTq+8UUZdRPTdc4wFb
 JKlPKbOLuaNK7cEYH1us9MMGgo+tpATBSf7DRcTFZ7mWOIKOorVW7I6M1w3m6a7/9IE7
 y80Wwq9Q+NqLX48Gp+a1cNNkzdiHy7upfC5reeyzJcIjphiOHy9h8+6yMVLTgkL9aI6o
 ENZBEiqdX1F+6ZJpMNKkPAsuuSncxTWLUNKRmzVo2HxvCQUXA8ylgd6qAzZ4tiwBv4cg
 BfDpKgTb8iEO7osfx/ZGsUc1PqClwbWWpwhLvsfzXfOGJBctjaBglqT1yfUaqtDv1HGj
 SJWA==
X-Gm-Message-State: AOJu0Yx9BmiDLqGvfJFvmUnhlEUtZtjdDrHjkXIaCZ0PUTTioyBoOBF5
 s7cTdBYJDj4R6mPqcFQUmYkvyv8AYLOEIH8o6vWZDMn0qMwiQZ9dUs7Upg91byYAuyI=
X-Gm-Gg: Acq92OE4jf5woUJkfoUpWh6NfnchIUiKIgWfcNSoQ7m6PUVgeRQOMoefbqRqJ9x7QKs
 ArLXurd8My9xAYwfpV6VKUp79+ALi8ntVpLkfEARxhSTH6gz8UmnJ5q/2XUjpxLDUS4kWFwl3Ut
 EUW66cqqIBkfe/kbdY5/WGZl33rd9gVsoG9t7dRqaYEGyP59ZQeGaDu3bgejiyCzS6d62tlUO3J
 t+/Hs9zCGvXVpLbmLTLCvhOfhcYt9u1EIVFQzUc49TcwT03L9PU1hHs51ke22bQIiL3JojCvn6k
 hfUw9DsVbzLI/AIRVdEaQwF2PLkH5vsq0en55/ucUKbY1NikvHgY1gKXuVAwlrg01OtSbbp+jE3
 EH7Vjed04i4M2v0T70ZTNWZltnFP4brdtYq9qfshW6mBS40+CCF0cZQ+e4wuEHHgBvPFha4y/rA
 GVnq0EiGsepOvuIRd5Bap2aiWM+3YYlobolmY=
X-Received: by 2002:a05:7022:6708:b0:130:68a1:a221 with SMTP id
 a92af1059eb24-13504a4c7a3mr5681391c88.38.1779062136136; 
 Sun, 17 May 2026 16:55:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdce9fasm15454706c88.4.2026.05.17.16.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:55:35 -0700 (PDT)
Date: Sun, 17 May 2026 16:55:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 20/20] net/txgbe: fix to enable Tx desc check
Message-ID: <20260517165533.20cdb300@phoenix.local>
In-Reply-To: <20260511103604.19724-21-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-21-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:36:02 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> Now lib security is enabled by default, and cannot be disabled if the
> driver is intended to be used. So Tdm_desc_chk is always unable to enable.
> Remove this restriction, and just enable the corresponding queue check.
> 
> Fixes: 0eabdfcd4af4 ("net/txgbe: enable Tx descriptor error interrupt")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Minor AI stuff here:


# Review of DPDK Patch: net/txgbe: fix to enable Tx desc check

## Summary
This patch modifies the Tx descriptor check logic in the txgbe driver to work correctly when security features are enabled. The change moves descriptor check setup from a global per-device operation to a per-queue operation.

## ERRORS

None found.

## WARNINGS

### 1. Bit manipulation should use RTE_BIT32() macro
**File:** drivers/net/txgbe/txgbe_rxtx.c  
**Lines:** 4774, 4775

The code uses `BIT()` macro for bitmask generation. DPDK coding standards prefer `RTE_BIT32()` or `RTE_BIT64()` for clarity and portability.

**Current code:**
```c
wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
      BIT(txq->reg_idx % 32), BIT(txq->reg_idx % 32));
```

**Suggested fix:**
```c
wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));
```

Verify that `BIT()` is defined in the driver's headers. If it's a legacy macro, consider using the DPDK standard `RTE_BIT32()` for consistency.

### 2. Conditional compilation without corresponding documentation update
**Context:** The patch changes the logic for when descriptor checks are enabled but there's no indication of release notes or documentation updates.

The original code disabled all descriptor checks when `RTE_LIB_SECURITY` was not defined. The new code enables descriptor checks per-queue unless the queue is using IPsec. This is a functional behavior change that should be documented.

**Suggested action:**
- Update release notes to describe the change in Tx descriptor check behavior
- Document that descriptor checks are now enabled per-queue based on IPsec usage rather than globally based on library compilation

## INFO

### 1. Potential logic optimization
The same bitmask value `BIT(txq->reg_idx % 32)` is used twice in the `wr32m()` call. Consider extracting it to a local variable for clarity:

```c
uint32_t queue_bit = BIT(txq->reg_idx % 32);
wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32), queue_bit, queue_bit);
```

This makes the intent clearer (setting the bit to 1) and slightly improves readability.

### 2. Parentheses around `using_ipsec` unnecessary
**Line:** 4772

```c
if (!(txq->using_ipsec))
```

Could be written as:
```c
if (!txq->using_ipsec)
```

The extra parentheses around `using_ipsec` are unnecessary since `!` has higher precedence than most operators.

---

## OVERALL ASSESSMENT

The patch correctly addresses the issue where descriptor checks could not be enabled when the security library was compiled in. The logic change from global enable/disable to per-queue configuration based on IPsec usage is sound.

**Key improvements made:**
- Moves descriptor check setup into the per-queue loop
- Only disables checks for queues actually using IPsec
- Removes the blanket disable when security library is present

**Correctness:** No bugs detected. The resource management and control flow are correct.

**Style compliance:** Minor issues with macro usage; otherwise compliant.

