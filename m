Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDFBCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE2C140673;
	Mon, 18 May 2026 01:56:46 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id DA8AC40673
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:45 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so6668953eec.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062205;
 x=1779667005; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKIV7eoDWdY16Nk7ZR4vVrwUafJ9cMnsuK5bMZiKwbg=;
 b=oU4UJjFdMwP4lReAtOwFx27GJlLd8Hu3Wwd909cjf6JZK3cFdpWFjOk0yR/fD7jyOl
 2Nn4H+Jr8S0FSU+UYoyofnbuNKvL6UeStN++m+dnMPPwHzHjZPNxiOegXwcc6p6kjxlk
 1WERtLDU2afH+Gj10j8geS3LZRCp1sUN3XhGbymG7vGaIAcnzQGsEVq2j7BuwgditDpu
 0AHRxISmnIKzCqPVt/FQ6tWs7ZTZla0Y6DlWy8maM+5CA7u1gM1UGzdFtx0NoHno6Hf2
 blIvPG5l1WWWVc/L74J8+rtbORH7U1lLjn7thC5HgTlQOckM5Ja8ZOi+EyGnuCLZ0Kx9
 v4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062205; x=1779667005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wKIV7eoDWdY16Nk7ZR4vVrwUafJ9cMnsuK5bMZiKwbg=;
 b=W0FiAfKbOY747vQu5OMO2svocgORPdNbL+3Z/G00WjVJVFeGTXoK92VNrUrjE1ydfT
 oEpSDaYgpi+QmH55I0OFXGJUiW3GKCLrQabCfLnFOHW5IDiJl/jy4bn3hxWmP27H9n++
 CM3CfJem0/RPSXUwfD5NhDbhvktOSBjtZ6cHg/GG+e825F8K9PvMTc6GwTXJ9vELILtC
 3mFjevyAs0evRU/xWVptg1w7MZLcnOk1cYkHWoAGQ7zITuEci+Br8Y5djnKT5Z8oa0/x
 n5WvxEMTO/djgPnE17b9dslm/8AsdwM27QuEylaXrFUk2dDBQjAKUo9beZQ7VXHf0zPm
 r7zw==
X-Gm-Message-State: AOJu0Yx+15nVyvPW0f+a7fiAWSEoeSeB6nATcENRub8Pvdj2MULNkv0P
 d0kzpLhliWIrwj6yqJcdI0sg3+blZqkQHnQb4zebsnPYHFgRPWQdCMWCIrteLkUeBGU=
X-Gm-Gg: Acq92OFXJ2Wgka4Dd6flbFahinZTpqLxQH97eAYYhwuIv3bKb0o18xydQuRkvtvuNFe
 2kGa/PidMbqX6vRzqgyhk9VMhDjbP6h75QrxkPECHimTfQWMEoi0gPBa83I/F2xKZyZvqfEXbiS
 laPCn+8eqn56oRHzRGujIuvIUFcw5cp5YLT5SQQCd8NmWZ0sLoDMe+xJwQv2qToVCCfbLruagCO
 atBEunXIoS1hCYmV6YkaVgYuRTegVobvwZboyPRXW4u5yk9ww41OqL0kH//NK2t8CP6IqL12Z9m
 YJrkT8cmbUdH6pMbpFlI7qPf7MQ7wIwCt1HVYgGAMe4H6Ce8PD+Zbxw98xQ6w+hW3tzOiEna7yj
 yCEqHKvSP9vk1bf+T8Wrl7QpLppkK0xxmcsdMTsvr5jo9edeiUt+xaI+cGSx5RQBzD0CDCa+/JN
 +8aW2BLlMLws2sTtqq2/nV6m1MwmCgWiSNSRk=
X-Received: by 2002:a05:7301:4185:b0:2d8:97d6:6ac8 with SMTP id
 5a478bee46e88-30398625a6amr6223514eec.21.1779062204814; 
 Sun, 17 May 2026 16:56:44 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:44 -0700 (PDT)
Date: Sun, 17 May 2026 16:53:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 17/20] net/txgbe: fix get module info operation
Message-ID: <20260517165307.6249117a@phoenix.local>
In-Reply-To: <20260511103604.19724-18-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-18-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:59 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The original I2C access flow in the module information retrieval
> process was flawed. Correct the implementation to properly fetch
> module info.
> 
> Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

More errors spotted in AI review


=== Patch 17/20 ===

# DPDK Patch Review: net/txgbe: fix get module info operation

## Summary
This patch refactors the module information retrieval code for the txgbe driver. The changes add proper identifier detection for different SFP/QSFP module types and improve the I2C access flow.

---

## ERRORS

### 1. Resource leak on error path after lock acquisition
**File:** `drivers/net/txgbe/txgbe_ethdev.c`  
**Location:** Lines 5368-5382

The code acquires a software semaphore (`TXGBE_MNGSEM_SWPHY`) at line 5368 but returns directly with `-EIO` at line 5382 without releasing the lock.

```c
status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
if (status)
	return -EBUSY;

if (hw->mac.type == txgbe_mac_aml40) {
	status = hw->phy.read_i2c_sff8636(hw, 0,
					  TXGBE_SFF_IDENTIFIER,
					  &identifier);
} else {
	status = hw->phy.read_i2c_eeprom(hw,
					 TXGBE_SFF_IDENTIFIER,
					 &identifier);
}

if (status != 0)
	goto ERROR_IO;  /* GOOD - releases lock */
```

However, the early returns at lines 5358-5365 before the lock is acquired would bypass the lock entirely if the pre-checks fail. While these don't leak the lock, they create an inconsistent state-checking flow.

**Suggested fix:** Move the presence checks after the lock acquisition to ensure consistent locking semantics:

```c
status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
if (status)
	return -EBUSY;

/* Check module presence after acquiring lock */
if (hw->mac.type == txgbe_mac_aml40) {
	value = rd32(hw, TXGBE_GPIOEXT);
	if (value & TXGBE_SFP1_MOD_PRST_LS) {
		status = -EIO;
		goto ERROR_IO;
	}
}

if (hw->mac.type == txgbe_mac_aml) {
	value = rd32(hw, TXGBE_GPIOEXT);
	if (value & TXGBE_SFP1_MOD_ABS_LS) {
		status = -EIO;
		goto ERROR_IO;
	}
}
```

---

## WARNINGS

### 1. Implicit comparison with zero
**File:** `drivers/net/txgbe/txgbe_ethdev.c`  
**Location:** Multiple occurrences (lines 5383, 5389, 5399, 5424)

The code uses `if (status != 0)` consistently, which is correct. However, there is one instance that needs verification:

```c
if (status)
	return -EBUSY;
```

**Suggested fix:** For consistency with the rest of the function:
```c
if (status != 0)
	return -EBUSY;
```

### 2. Mixed type usage: `u8` vs `uint8_t`
**File:** `drivers/net/txgbe/txgbe_ethdev.c`  
**Location:** Lines 5350-5351, others use `uint8_t`

```c
u8 identifier = 0;
u8 sff8636_rev = 0;
```

While `u32 value;` appears at line 5353, the rest of the function uses `uint8_t` and `uint32_t`. DPDK coding standards prefer explicit-width types with the `_t` suffix.

**Suggested fix:**
```c
uint8_t identifier = 0;
uint8_t sff8636_rev = 0;
uint32_t value;
```

### 3. Unnecessary variable initialization
**File:** `drivers/net/txgbe/txgbe_ethdev.c`  
**Location:** Lines 5350-5351

```c
u8 identifier = 0;
u8 sff8636_rev = 0;
```

Both variables are assigned before use via the `read_i2c_*` functions. Initializing to 0 defeats uninitialized-variable warnings.

**Suggested fix:**
```c
uint8_t identifier;
uint8_t sff8636_rev;
```

### 4. Release notes required
This patch fixes a bug (I2C access flow) and should be documented in the current release notes under "Fixed Issues" for the txgbe driver, per the contribution guidelines for bug fixes.

---

## INFO

### 1. Code organization improvement
The new code structure with a switch statement based on `identifier` is clearer than the original logic. This is a good refactoring that makes the code easier to maintain.

### 2. Error message clarity
The error messages "I2C IO ERROR" and "SFF Module Type not recognized" are informative. Consider whether these should include additional context (e.g., the identifier value for unrecognized types) to aid debugging.

---

## POSITIVE OBSERVATIONS

1. **Proper lock cleanup:** The `ERROR_IO` label correctly releases the semaphore before returning, which is the right pattern for error handling with acquired resources.

2. **Consistent error propagation:** The function properly returns `-EIO`, `-EINVAL`, and `-EBUSY` based on the failure type.

3. **Cc: stable@dpdk.org included:** Appropriate for a bug fix that should be backported.

---

## SUMMARY OF REQUIRED CHANGES

**Must fix (Errors):**
1. Move module presence checks after lock acquisition to ensure lock is held during all hardware access and properly released on all error paths

**Should fix (Warnings):**
1. Use explicit comparison `status != 0` instead of implicit `if (status)`
2. Use `uint8_t` and `uint32_t` instead of `u8` and `u32`
3. Remove unnecessary initialization of `identifier` and `sff8636_rev`
4. Add release notes entry for this bug fix

============================================================

