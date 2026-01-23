Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951AD6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FED54021F;
	Fri, 23 Jan 2026 06:09:40 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 67E2F400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:09:38 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so13915815e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769144978;
 x=1769749778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gslb3hCrTvwqC6ltudNnbQ55BKMfX2MF7A1kZ/BIrQ=;
 b=Edz72edGCs73pZN8C1lBRm41ISnpHENNrfXOtc/bkwBMMR3/vo9jdxFmPLOjJzVjIp
 yp0Y5Dnm2yInxQDuZL9vQidXvRF0upruip6Fb+gY0o+1vLsKOKPOjqa7x2hveubzBq64
 maRC3r4X3vAuuJm/DspLnUE/s+ttqYoRsG2CFylU/FpBwLaJ3HXutataPrlmaeNJWwWz
 Y3VMyJBhruW0MfrG1Hb7WsIW4135fSRLEITwAmQfmvBIVAbxTVHwBDTu62poCvahYNen
 uS2rKXUxAfsW2QpAIU30htUxjT0wuh67DxoczF9R2IGPaU5iCxuHx+bXAB1cCXDiDwtv
 VxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769144978; x=1769749778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gslb3hCrTvwqC6ltudNnbQ55BKMfX2MF7A1kZ/BIrQ=;
 b=P3Y/xDVC/jKmoJ9s00UXMiHMlYHkL/Y09WreOFF2+NIb6UuYoCBAApkJitrA3tMMHU
 MMpUowIYf/hmCs4MW0Vc8Yc4TY1LQFnW7dqJ7TqrX1C+BA0EEtCQzDLIfLjdMfwtWTdC
 Aho9zT6OADiX3uwQX25BWU34abtPvspntGLacpxsJD6ZDXGez4C28luIzOHYM1p6HtTv
 wPLvt5Zl0Mt/4BSmdjBSUrWxcX1t9H4N6EcMY64NGgC2STFKMa1pocT5p2wZSPZeC3y7
 AJlNg1UkKtNuf9ZVd0KxfF1i4rALjCsQ3veJdswRpGRxHK8rRSlOuPDT0Y3ERTRznwdM
 Y2EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDfREusjAHm7vKwLN5OHRbrzSu48zQlElp0JjqFrvqkMZ/czto9DwmtMk0nYAhyl0+ZTw=@dpdk.org
X-Gm-Message-State: AOJu0YxsXHdGRYTX8l7wxks/gB2dPYYy1iu6FH5QvOXGJSlOy+LtVCvy
 qMKEAOihVXdMrP7++gHQZm6sboQ0T5OZW8obRK82OMxm3wIqJ69FmWdeoEGA0jA69Rc=
X-Gm-Gg: AZuq6aLg8DbrIZRIGJqm470KFW9IQZsOyRHdLLCEeEld2MP/CvGmEC49lEYFnqKs+O0
 4SBBzCiL+q5WS47TnYJUrvpAB1/3S3WfAAJztyBXVaFnDM4SqYAr1T+9wMsm7cKvYeEq7EW+HOJ
 QTrzvqoq1617FSu5XCMXarP1L1iCbnBto84xNOvHEiUfZIZ+2XF0QuVL00ZIo+DZUn9sD5tekh3
 MF9bYfZ8tzrnMrJ6JMTdCDV6lhUDo9gfyLDWjhCwKLVcJ2YtrGkJ44wHqmSmX+5yvnMHxXoLGGr
 lh43LjqP5PD4bheC2mq78KpzO5sn9HMg3McTAAVPWhXrYrmMEL+BD1Tvi0pp0GqFInucVllGlwm
 OYSgXM6OBedDLnYsgyuj8vAcTHQndUkDKJZKxbpL1oAAwStXM+c8XOsxH8LKaljfbTnUi/Fey5u
 fTE1AsZbXQdKufjb0G7il3uV9V+sakpTMCjQ146MgJm3lzkjl9OHCz
X-Received: by 2002:a05:600c:820e:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4804c94fd6amr26406405e9.11.1769144977983; 
 Thu, 22 Jan 2026 21:09:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbc0d84sm10590305e9.6.2026.01.22.21.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:09:37 -0800 (PST)
Date: Thu, 22 Jan 2026 21:09:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jake Freeland <jfree@FreeBSD.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2 0/3] EAL memory fixes
Message-ID: <20260122210931.05d3ed8b@phoenix.local>
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

On Thu, 14 Aug 2025 16:32:42 -0500
Jake Freeland <jfree@FreeBSD.org> wrote:

> Hi there,
> 
> This patchset contains a number of EAL-specific memory fixes that I've
> made over the last year. Two pertain to FreeBSD, one pertains to Linux.
> 
> v2:
> * Log messages are no longer split across multiple lines.
> * The patch titled "Do not index out of bounds in memseg list" has been
>   removed since there was no indexing out of bounds happening.
> * A new patch has been added per Anatoly's recommendation that starts
>   searching for memseg entries after the last used entry.
> 
> Jake Freeland (3):
>   eal/freebsd: Do not use prev_ms_idx for hole detection
>   eal/freebsd: Avoid claiming memseg holes
>   eal/linux: Check hugepage access permissions
> 
>  lib/eal/freebsd/eal_memory.c      | 24 +++++++++++++++++++-----
>  lib/eal/linux/eal_hugepage_info.c |  7 +++++++
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> --
> 2.47.2
> 

AI review of this series is mostly positive

=== Patch Review: bundle-1679-eal-freebsd.mbox (via Claude) ===
# DPDK Patch Review: eal/freebsd Memory Management Fixes

## Summary
This patch series contains 3 commits addressing memory management issues in FreeBSD EAL and adding permission checks for Linux hugepage directories.

---

## Patch 1/3: eal/freebsd: Do not use prev_ms_idx for hole detection

### Errors
None found.

### Warnings

1. **Subject line capitalization issue**
   - Subject: `eal/freebsd: Do not use prev_ms_idx for hole detection`
   - "Do" should be lowercase after the colon per guidelines
   - Should be: `eal/freebsd: do not use prev_ms_idx for hole detection`

### Info
- Commit message is clear and explains the problem well
- `Signed-off-by` and `Acked-by` tags present and in correct order
- Code change is minimal and focused
- Line lengths are within limits

---

## Patch 2/3: eal/freebsd: Avoid claiming memseg holes

### Errors
None found.

### Warnings

1. **Subject line capitalization issue**
   - Subject: `eal/freebsd: Avoid claiming memseg holes`
   - "Avoid" should be lowercase after the colon
   - Should be: `eal/freebsd: avoid claiming memseg holes`

2. **Variable declaration style inconsistency**
   ```c
   for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
   				msl_idx++) {
   	int start_idx, num_elems;
   	bool empty, need_hole;
   ```
   - The new variables `start_idx` and `num_elems` are declared at the start of the block, which is acceptable. However, they could be declared closer to their point of use or initialized when meaningful values exist.

3. **Potential logic issue with start_idx check**
   ```c
   start_idx = rte_fbarray_find_prev_n_used(
   		arr, arr->len - 1, 1) + 1;
   if (start_idx < 0)
   	start_idx = 0;
   ```
   - Since `rte_fbarray_find_prev_n_used()` returns -1 on failure, and then +1 is added, `start_idx` would be 0 when the function fails, making the `if (start_idx < 0)` check unreachable. This appears to be dead code. Consider:
   ```c
   start_idx = rte_fbarray_find_prev_n_used(arr, arr->len - 1, 1);
   if (start_idx < 0)
   	start_idx = 0;
   else
   	start_idx++;
   ```

### Info
- Commit message explains the fix adequately
- Tags are present and in correct order

---

## Patch 3/3: eal/linux: Check hugepage access permissions

### Errors
None found.

### Warnings

1. **Subject line capitalization issue**
   - Subject: `eal/linux: Check hugepage access permissions`
   - "Check" should be lowercase after the colon
   - Should be: `eal/linux: check hugepage access permissions`

2. **Use of lowercase log message**
   - The log message uses lowercase which is inconsistent with some other EAL log messages, though this is a minor style preference.

### Info

1. **Consider using `faccessat()` for race-free checks**
   - The `access()` function has TOCTOU (time-of-check-time-of-use) race conditions. While this is likely acceptable for this use case (startup configuration), it's worth noting.

2. **Good defensive programming**
   - Adding permission checks before attempting to use mountpoints improves error handling and user feedback.

3. **Commit message is clear and concise**

---

## General Observations

### All Patches
- All patches have proper `Signed-off-by` tags with real names and valid email addresses
- All patches have `Acked-by` from the maintainer
- Tag order is correct (Signed-off-by before Acked-by)
- No trailing whitespace detected
- Line lengths appear to be within 100 character limit for code
- Commit body lines are within 75 character limit
- Files have appropriate licenses (existing files being modified)

### Missing Items (Info level)
- No `Fixes:` tag on patches 1 and 2, which appear to be bug fixes. If these fix regressions from specific commits, a `Fixes:` tag should be added.
- No `Cc: stable@dpdk.org` tag if these are candidates for backporting to stable releases.

---

## Summary of Required Changes

| Severity | Count | Items |
|----------|-------|-------|
| Error | 0 | - |
| Warning | 4 | 3x subject line capitalization, 1x potential dead code |
| Info | 4 | Missing Fixes tags, TOCTOU note, style preferences |

### Recommended Actions

1. **Fix subject lines** (all 3 patches): Change to lowercase after colon
   - `eal/freebsd: do not use prev_ms_idx for hole detection`
   - `eal/freebsd: avoid claiming memseg holes`
   - `eal/linux: check hugepage access permissions`

2. **Review the start_idx logic** in patch 2 to ensure the `< 0` check is reachable

3. **Consider adding `Fixes:` tags** if these address specific regressions
