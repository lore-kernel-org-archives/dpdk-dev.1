Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C06CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3B040659;
	Mon, 18 May 2026 01:56:42 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 7193B40669
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:41 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-303dbfbec77so487376eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062200;
 x=1779667000; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8VYCdD54VmhE5fBGCZEQFjoFIkUNO82urZ/Io4MVu4=;
 b=HIlzDXPF7Sco1+ceYI7iRBC7aQpHMDVyOIkkhXa25MUKgsdUm8RikJIqc8bScy8zXg
 65P202RzmWwfWoNkfSYFzr+BLPjduvsy6tKmNv/YrYS0UKcC7QdP5sVzDPOrKTaVYEGj
 pENZHAU17+WGmzfNpevpGs7QEmcXIlMwjPskJG/8+sWZ0ckougJNmUpOuJrBRc7jLOie
 cUa6Ex8gekaFvl9EwIFpiW33cPRwxzki/ziDeVJ3+5Y+GOTNog3XYEdZlX7vg5wxzLea
 RLmhpKeEKQjVOq+Jr0zxyuPbBEsCeIPcP5KENfjdR/h6laRTrLMym2zuI52aFz6uPLUb
 VfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062200; x=1779667000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c8VYCdD54VmhE5fBGCZEQFjoFIkUNO82urZ/Io4MVu4=;
 b=mn29gVzbJUO40pZNUIjtUzcOqdBI3vjzhuLQ4n4SP4RyHacXi9RpS3VEFPTQmSlSWK
 tzelUWQSfjrOKYy+BExbP2NPWvtRzR/60lBQ2miy5n9MkP754N/bX2M5lYXKd0pt1jXU
 Z4bUXBBvNOgs86mrwrSL6BfrEvRkBdTxB5kpFzAGz3CmkTLDpQWVIL1+hX1THzSbpsnT
 fc7Yozyo6u9BYR4m5TlBQnIDGq2/cJo2OgtH7gd9ZmLhyg09u3xnTIsJ9OV25T+VcAtO
 q6yG6k9rV5q8/JqBpQD0GPm8fMGfceNjWzWy65BAN72K4I6kAe/83Qn+9u1cDzwJLINv
 MaEQ==
X-Gm-Message-State: AOJu0YxurZ6Rb7zUg+yL0zgaJ4iVXTrXX8FW0JCdozRsjra6YCosZGsH
 G1sjM+rogmDGvFkbFHn6JXeFTjYDB/EfYnX7I304tcxNzwnfFeF4iYb6capN1yQKgvehkvlnefv
 dOjGQyu4=
X-Gm-Gg: Acq92OFOtlfbum2a6MMIYaxHV02bUqHMMnqMgirE10KmGm6XGFRWjGOAoylGtsEiNwu
 o4JT949Y2mioe1ReuxhAnEGgoN/rZc7gFo4MQoshflYYVMcTgSFZd5KdaCTTQcqddVVP7kUd49P
 sWlwMJVi6hxsGN4y+P3jcyP7lcvjGDPyROu3THGNJJ/118F12whXSjrNMBR3qmB/FjrO07J/Fqo
 y0cL1JPaAIQHARO9ArFU95F/UFeYfsKrfgUK7LreILoPNrRDbrJ8yuXKRw30BOQIRfrFDNHw1FG
 dCM22NAPY3fmvew8K0f3/5DpuFb0jNXX1hkg1+OFn0C9EbI5ZRNsCs1cHayQmZdmYC1R16ZrQh0
 brHvYiH9PbvtOXvKIsOEWiRfZomnhIyITHIjM6VciQepOGruzCiOXXg0CwH4RGqiVDr8Rt+H4hS
 O1T80KoJFMo7R1BS+gO2Vkm+cFNg257J3x4eJDpKeD/trsfB0EGw/+1JOe
X-Received: by 2002:a05:7300:ec18:b0:2da:1874:f3bd with SMTP id
 5a478bee46e88-30398618bccmr5456268eec.16.1779062200477; 
 Sun, 17 May 2026 16:56:40 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:40 -0700 (PDT)
Date: Sun, 17 May 2026 16:54:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 18/20] net/txgbe: fix get EEPROM operation
Message-ID: <20260517165434.5a4e3a72@phoenix.local>
In-Reply-To: <20260511103604.19724-19-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-19-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:36:00 +0800
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

I agree with AI that u8, u16 should not be used except in base/ code.

# Review of Patch 18/20: net/txgbe: fix get EEPROM operation

## Errors

### 1. Wrong integer types used for kernel/hardware types
The code uses kernel-style type names (`u32`, `u8`, `u16`) instead of standard C types or DPDK types. This is inconsistent with DPDK coding standards which require standard C types.

**Location:**
```c
u32 value;
u8 identifier = 0;
u16 offset;
u8 page = 0;
```

**Fix:** Use standard C types:
```c
uint32_t value;
uint8_t identifier = 0;
uint16_t offset;
uint8_t page = 0;
```

### 2. Resource leak on error path
The function acquires a semaphore with `hw->mac.acquire_swfw_sync()` but fails to release it if `info->length == 0` check fails.

**Location:**
```c
if (info->length == 0)
    return -EINVAL;

status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
```

**Fix:** The `info->length == 0` check should be moved before the semaphore acquisition, OR the error path should release the semaphore:
```c
if (info->length == 0)
    return -EINVAL;

status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
if (status)
    return -EBUSY;
```
This is actually correct as-is since the check happens before acquisition. **NOT AN ERROR.**

### 3. Implicit comparison for boolean
```c
if (identifier == TXGBE_SFF_IDENTIFIER_SFP)
    is_sfp = true;
```
This uses an integer comparison to set a boolean, which is fine. However, the boolean `is_sfp` is used directly in conditionals later, which is acceptable for `bool` types. **NOT AN ERROR.**

## Warnings

### 1. Missing bounds check on page calculation
The `page` variable is incremented in a loop without any upper bound check. While the loop is bounded by `info->length`, there's no verification that `page` doesn't exceed valid page numbers.

**Location:**
```c
while (offset >= RTE_ETH_MODULE_SFF_8436_LEN) {
    offset -= RTE_ETH_MODULE_SFF_8436_LEN / 2;
    page++;
}
```

**Suggestion:** Add bounds check on page number before use, or verify that `info->length` cannot cause page overflow:
```c
while (offset >= RTE_ETH_MODULE_SFF_8436_LEN) {
    offset -= RTE_ETH_MODULE_SFF_8436_LEN / 2;
    page++;
}
if (page > MAX_VALID_PAGE) {
    status = -EINVAL;
    goto ERROR_IO;
}
```

### 2. Buffer initialization redundancy
`memset(data, 0, info->length)` clears the buffer, but then every byte is written in the loop. The memset may be needed for partial reads on error, but the error path returns without partial data, making this initialization unnecessary overhead.

**Location:**
```c
memset(data, 0, info->length);

for (i = info->offset; i < info->offset + info->length; i++) {
    ...
    data[i - info->offset] = databyte;
}
```

**Consideration:** If partial reads are acceptable (keeping what was read before error), the memset is appropriate. Otherwise, it's unnecessary.

### 3. Inconsistent coding style with bool keyword
The patch uses C99 `bool` type (`bool is_sfp = false`), which is good practice per guidelines. However, verify this is consistently available (requires `<stdbool.h>` which should be included).

### 4. Error path could leak partial data
On error, the function returns without clearing the potentially partially-filled buffer. If the caller expects zeroed data on error, this could be an information leak (though likely harmless in this context).

## Info

### 1. Magic number in condition
```c
if (page == 0 || !(data[0x2] & 0x4))
```
The `0x2` offset and `0x4` bitmask are magic numbers that should be defined as named constants for clarity.

**Suggestion:**
```c
#define SFF8636_STATUS_OFFSET 0x2
#define SFF8636_FLAT_MEM_BIT  0x4

if (page == 0 || !(data[SFF8636_STATUS_OFFSET] & SFF8636_FLAT_MEM_BIT))
```

### 2. Potential integer overflow in loop bound
```c
for (i = info->offset; i < info->offset + info->length; i++)
```
If `info->offset + info->length` overflows (though unlikely with typical EEPROM sizes), the loop condition becomes incorrect. Consider bounds validation before the loop.

---

## Summary

**Critical issues:** 1 (wrong type names - must use C standard types)

**Important warnings:** 2 (missing page bounds check, potential partial data exposure)

**Style/clarity issues:** 2 (magic numbers, redundant memset)

The most important fix is changing the type declarations from `u8`/`u16`/`u32` to `uint8_t`/`uint16_t`/`uint32_t`.

