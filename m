Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098ECD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:57:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203ED4067B;
	Mon, 18 May 2026 01:56:51 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id BE0BE40667
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:49 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso1380203eec.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062209;
 x=1779667009; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUInw7kW8DhcvNiefsijvsypGIrcb0T04l2P+sFoFbU=;
 b=gP/IiXdU3xuyRHU+Bq/A/xUuxpCsb5oFYKdb9IR6yHRuTKJ/HkbFyznaxi4wudzE/d
 iSxLB/rJz1XbB4w+uHOaMLzouIWKUfbTkxX/TDMwor7yGtDOKZ9JQLAKjSatzrBu+zAm
 yMYlo1P2xm3iRJ2k6K2s/gfx3DbJhszyijW1QgZlwnB8NQ+ZjbE7ahHb7zshmmqtJ+3L
 MvcK6vHSggsoo1L6kangGtPXxANmzvQuDubRdrgEVTbXaGW+uW3YQVa3P231T5Gex14F
 EPERi7FaQB92MOiUgEMjBPv3NJ45k7jxkfcPfKXVdm+ywInplwVWAMljpCTLZK6m51xs
 +E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062209; x=1779667009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUInw7kW8DhcvNiefsijvsypGIrcb0T04l2P+sFoFbU=;
 b=hYsJg0oMb4lkGf6I66xc7qZJqHVnhjl6Y95ItAw1PqZGuhyiHV5A9+2cGPj0Rea4Hd
 H0fyDW5Gvo2ch/EUe2RirOgb4y0ylytBGY910n2ILAvkozSbZkDcawhNpdUamvHgtuD3
 dsr5fQVPqjFuKOHBPC7yAgUxZbU5PNkLMyZyhTzvlCcFlwtmn5moGodF7BZ7DEOvFOjR
 /rxcV43xva5ii1FxR1Uff+nwSOcQWSD1trkuT50QO+XJErEeaovXYdhHYpZujWD7+pKm
 +nYP41ZKpopNSsnu3QQllER4mwlcE5zeS0NhcnK+UT3sfVrQP8OqQdmzevkY6cfu5vsL
 ahAQ==
X-Gm-Message-State: AOJu0Ywnf27kvWwB5hpbAJTfvh4+I8lYDj8emdgYyo6ZdU/8tv0z83Ox
 qE4fItRf3rNqOckZbfzhh2IAAI4vqaQs58h5VByxhAvTzQUKBqdiiU3pwe8JST9FNAU=
X-Gm-Gg: Acq92OF0cQT8vrMTaqJhm2jxoM8ucslLiuBK7gmo54NMahmx7Gq2VY+pJNYhULCoJdL
 Dh0yhhaLFlASiLz5ZL5hhp0GLu3zbfbLqayGk+lQCB6AwJ4BZHc8GT76Z8DpkL43YY02vbMFra3
 MDeleuCQKD4dB0s75njig2fUuDZJrfMcWnfYeY6OAdupgXlwdvHdvWu6PFWqQ+kjJ5A9kN+c+I7
 XdJV2U17p18vzLOtdOuN2i8KQt4HQD2vVGJO4TkxvgW6YVY1YQ8RY153UQOhWoGl/0dzwO+y90E
 Gl4NOOz7mv899rae0UHEJZYo/7BwkBNBxTCWD2SiOK5xB8kGsXAePRwVZlC0pBURWpgW211RQMD
 yRUaLj1JijIG335l+GG/P3fvniozOSX/PfuUwuiS4fFfIE8/4DJV6i9GHvpoKVZ0EMVtHT2WpjA
 IsoRfhsBzuHt0uTEzTwFIdbvinxjrGBhf/eA16YeQWVwu7HA==
X-Received: by 2002:a05:693c:300a:b0:2f8:42b0:e63d with SMTP id
 5a478bee46e88-3039828764emr5435824eec.2.1779062208799; 
 Sun, 17 May 2026 16:56:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:48 -0700 (PDT)
Date: Sun, 17 May 2026 16:40:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 05/20] net/txgbe: fix inaccuracy in Tx rate limiting
Message-ID: <20260517164018.7a58c68c@phoenix.local>
In-Reply-To: <20260511103604.19724-6-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-6-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:47 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> Amber-lite NIC's TX rate limiting has large deviations for small
> packets. To address this, the following changes are made:
> 
> 1. Set TDM_RL_ADJ (0x1820c) to 21B (includes 7B Ethernet preamble,
>    1B SFD, 1B EFD, and 12B IPG).
> 2) Remove the rate offset in the driver (e.g., 105 / 100, a rough
>    compensation value from Linux kernel driver tests).
> 
> After these changes, accuracy deviation for 64B packets is within
> ~5%, while large packets show lower deviation.
> 
> Fixes: a309ab43acf3 ("net/txgbe: support Tx queue rate limiting for Amber-Lite")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

AI feedback on this one. Looks ok as is but worth looking at.


# DPDK Patch Review: net/txgbe: fix inaccuracy in Tx rate limiting

## Summary

This patch improves TX rate limiting accuracy for Amber-lite NIC by:
1. Setting TDM_RL_ADJ register to 21B (Ethernet framing overhead)
2. Removing the 105/100 compensation factor

## Review Findings

### **Errors**

None found.

### **Warnings**

**1. TDM_RL_ADJ write placement causes per-queue reconfiguration**

The `TXGBE_TDM_RL_ADJ` register write is inside the per-queue rate limit configuration loop, causing the same global register to be written every time any queue's rate limit is set. This register appears to be a global hardware adjustment parameter (affects all queues), not a per-queue setting.

**Suggested fix:** Move the register write outside the queue configuration context, ideally to device initialization or as a one-time setup when rate limiting is first enabled:

```c
/* Set once during device init or first rate limit config */
static bool rl_adj_initialized = false;
if (!rl_adj_initialized) {
    wr32(hw, TXGBE_TDM_RL_ADJ, 21);
    rl_adj_initialized = true;
}
wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
```

Or better yet, move it to a device initialization function if this is a hardware parameter that should be set once at device start.

**2. Magic number 21 lacks explanation**

The value 21 is documented in the commit message but not in the code. Future maintainers will not see the breakdown (7B preamble + 1B SFD + 1B EFD + 12B IPG).

**Suggested fix:** Add a comment or define:

```c
/* Ethernet framing overhead: 7B preamble + 1B SFD + 1B EFD + 12B IPG */
#define TXGBE_TDM_RL_ADJ_OVERHEAD  21
wr32(hw, TXGBE_TDM_RL_ADJ, TXGBE_TDM_RL_ADJ_OVERHEAD);
```

**3. Missing release notes update**

This is a fix that changes hardware behavior and improves accuracy. Users may observe different TX rates after upgrading. The change should be documented in release notes to inform users of the accuracy improvement.

**Suggested fix:** Add an entry to `doc/guides/rel_notes/release_26_11.rst` (or current release):

```rst
* **net/txgbe: Improved TX rate limiting accuracy for Amber-lite NIC.**

  Fixed TX rate limiting accuracy for 64-byte packets from ~20% deviation
  to within ~5% by correcting hardware framing overhead configuration.
```

### **Info**

**1. Consider validating tx_rate is non-zero**

The code computes `factor_int = link_speed / tx_rate`. If `tx_rate` is somehow zero (due to caller error or invalid input), this would cause division by zero. The existing code may have validation elsewhere, but defensive programming would check this.

```c
if (tx_rate == 0) {
    PMD_DRV_LOG(ERR, "TX rate cannot be zero");
    return -EINVAL;
}
```

**2. Variable scope: factor_fra could be declared at initialization**

The variable `factor_fra` is declared but not initialized, then assigned in both branches of the conditional. C99 style would allow:

```c
u32 factor_fra = (frac * 16384) / 10000;
if (factor_fra >= 8192)
    factor_fra = 0;
```

This is stylistic only; the existing code is correct.
