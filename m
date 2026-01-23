Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F75D77899
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 17:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB0A4042F;
	Fri, 23 Jan 2026 18:43:13 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1BCAB4042F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 18:43:13 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4dyQJH3mYFz4RSt;
 Fri, 23 Jan 2026 17:43:11 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4dyQJH2lHVz3H2h;
 Fri, 23 Jan 2026 17:43:11 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1769190191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrH4SApDiNajYJzOcHF0DfgQ1Znc7naPVdGl3mG6Au0=;
 b=NOhSJEZ/OFCUwNogj8vMY3PooWW5kxjbdOp0bzvWsh1kcEU1mN52Ad3UNsFp/1p7o7m4h/
 LDhfVWQIU9uT3yEXUtADROj4Q2H+/D1/rkIeQtXkJ6qnLn0aGlVrp/e+Qmw6rCGhZoRJ2h
 QhnRepwMdumvtK4GJOtzs1xoT0XK7mNHb8UjzRpRJMEIThdXNKrjBu/EfAGICSn1guBR6y
 JSRKXbCveN4OPeksj27AfcxOvch/hb4mmIeKVMFBthOETNjmq6VHuntO2xJtwkY+ToDhBY
 z4yB/mbBs/CipkKGd2UIN/mEZglSHPv98+tHo/kvII1AAHTqx0p0WHkjcQhS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1769190191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrH4SApDiNajYJzOcHF0DfgQ1Znc7naPVdGl3mG6Au0=;
 b=Tmo9tHlpOBhFQk9L0zdjN7r0lwRAVB4weta+Xid1mAzjdffpFGqJ77yKMogqz4TOhnx6Ft
 ATTeNf7iuGjvct6kunJUzK6Zs0ecJQTz1Qp7b5AiKEN8ks2kOp20jtQU/ZzzQAGBMtAr3x
 IcuyJBIxJnXea4rRJZrn8D3NFXs57yITI4MalFhkp1DMCqmut9uzEytnuAd8ItjWXjUBX7
 RCcmUW3q/23hGHZGVRM8G8VosIV/RyS9kXuDOVuLOXae6sRYa8VRLlAvqQr95Am0ZMS8pB
 Yp8n965a83QwZAm9+Va62PwgokJvlX2IwWCcuRjTb7PCV8qwqBP+IM1o9Tbtlg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1769190191; a=rsa-sha256; cv=none;
 b=v/nfOlRE/sKDDYJbTzEdi3xm0Es6ZIzchpsdvcEYJs60XKu2NmQ3jF14PwcKmojt+d1V1A
 cvP6MnMpCr0RsTVWY/Mtk/Ai4TA1pwY6h7LRIezrjsyc9j4b7k4z3C5cZYOwqwSjWWYTV/
 hQrOWhPjgEekAuhkXnrD1R/yG6cXbmX9e3xfrKP11lzpbIAY5rVA4YtPbpVRJQnKesOVBO
 dvAU/KrgDaOCGejrofIOw41T/qTaoSlQJZplwVlmlzoQdNLlpB279w4TPChnKKxzhJnSHG
 azapNjwx/WhHs+liY0btbV8ELoLyP/pWENYrma5nN2yCabamLfexBkDu6D9dyw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from localhost (65-128-253-73.mpls.qwest.net [65.128.253.73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4dyQJH0XCQzNJW;
 Fri, 23 Jan 2026 17:43:11 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 11:43:10 -0600
Message-Id: <DFW5KXADDGW7.1JF1OUGRXJ8WH@freebsd.org>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] EAL memory fixes
From: "Jake Freeland" <jfree@freebsd.org>
To: "Stephen Hemminger" <stephen@networkplumber.org>, "Jake Freeland"
 <jfree@FreeBSD.org>
X-Mailer: aerc 0.20.1
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260122210931.05d3ed8b@phoenix.local>
In-Reply-To: <20260122210931.05d3ed8b@phoenix.local>
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

On Thu Jan 22, 2026 at 11:09 PM CST, Stephen Hemminger wrote:
> On Thu, 14 Aug 2025 16:32:42 -0500
> Jake Freeland <jfree@FreeBSD.org> wrote:
>
>> Hi there,
>>=20
>> This patchset contains a number of EAL-specific memory fixes that I've
>> made over the last year. Two pertain to FreeBSD, one pertains to Linux.
>>=20
>> v2:
>> * Log messages are no longer split across multiple lines.
>> * The patch titled "Do not index out of bounds in memseg list" has been
>>   removed since there was no indexing out of bounds happening.
>> * A new patch has been added per Anatoly's recommendation that starts
>>   searching for memseg entries after the last used entry.
>>=20
>> Jake Freeland (3):
>>   eal/freebsd: Do not use prev_ms_idx for hole detection
>>   eal/freebsd: Avoid claiming memseg holes
>>   eal/linux: Check hugepage access permissions
>>=20
>>  lib/eal/freebsd/eal_memory.c      | 24 +++++++++++++++++++-----
>>  lib/eal/linux/eal_hugepage_info.c |  7 +++++++
>>  2 files changed, 26 insertions(+), 5 deletions(-)
>>=20
>> --
>> 2.47.2
>>=20
>
> AI review of this series is mostly positive
>
> =3D=3D=3D Patch Review: bundle-1679-eal-freebsd.mbox (via Claude) =3D=3D=
=3D
> # DPDK Patch Review: eal/freebsd Memory Management Fixes
>
> ## Summary
> This patch series contains 3 commits addressing memory management issues =
in FreeBSD EAL and adding permission checks for Linux hugepage directories.
>
> ---
>
> ## Patch 1/3: eal/freebsd: Do not use prev_ms_idx for hole detection
>
> ### Errors
> None found.
>
> ### Warnings
>
> 1. **Subject line capitalization issue**
>    - Subject: `eal/freebsd: Do not use prev_ms_idx for hole detection`
>    - "Do" should be lowercase after the colon per guidelines
>    - Should be: `eal/freebsd: do not use prev_ms_idx for hole detection`
>
> ### Info
> - Commit message is clear and explains the problem well
> - `Signed-off-by` and `Acked-by` tags present and in correct order
> - Code change is minimal and focused
> - Line lengths are within limits
>
> ---
>
> ## Patch 2/3: eal/freebsd: Avoid claiming memseg holes
>
> ### Errors
> None found.
>
> ### Warnings
>
> 1. **Subject line capitalization issue**
>    - Subject: `eal/freebsd: Avoid claiming memseg holes`
>    - "Avoid" should be lowercase after the colon
>    - Should be: `eal/freebsd: avoid claiming memseg holes`
>
> 2. **Variable declaration style inconsistency**
>    ```c
>    for (msl_idx =3D 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
>    				msl_idx++) {
>    	int start_idx, num_elems;
>    	bool empty, need_hole;
>    ```
>    - The new variables `start_idx` and `num_elems` are declared at the st=
art of the block, which is acceptable. However, they could be declared clos=
er to their point of use or initialized when meaningful values exist.
>
> 3. **Potential logic issue with start_idx check**
>    ```c
>    start_idx =3D rte_fbarray_find_prev_n_used(
>    		arr, arr->len - 1, 1) + 1;
>    if (start_idx < 0)
>    	start_idx =3D 0;
>    ```
>    - Since `rte_fbarray_find_prev_n_used()` returns -1 on failure, and th=
en +1 is added, `start_idx` would be 0 when the function fails, making the =
`if (start_idx < 0)` check unreachable. This appears to be dead code. Consi=
der:
>    ```c
>    start_idx =3D rte_fbarray_find_prev_n_used(arr, arr->len - 1, 1);
>    if (start_idx < 0)
>    	start_idx =3D 0;
>    else
>    	start_idx++;
>    ```
>
> ### Info
> - Commit message explains the fix adequately
> - Tags are present and in correct order
>
> ---
>
> ## Patch 3/3: eal/linux: Check hugepage access permissions
>
> ### Errors
> None found.
>
> ### Warnings
>
> 1. **Subject line capitalization issue**
>    - Subject: `eal/linux: Check hugepage access permissions`
>    - "Check" should be lowercase after the colon
>    - Should be: `eal/linux: check hugepage access permissions`
>
> 2. **Use of lowercase log message**
>    - The log message uses lowercase which is inconsistent with some other=
 EAL log messages, though this is a minor style preference.
>
> ### Info
>
> 1. **Consider using `faccessat()` for race-free checks**
>    - The `access()` function has TOCTOU (time-of-check-time-of-use) race =
conditions. While this is likely acceptable for this use case (startup conf=
iguration), it's worth noting.
>
> 2. **Good defensive programming**
>    - Adding permission checks before attempting to use mountpoints improv=
es error handling and user feedback.
>
> 3. **Commit message is clear and concise**
>
> ---
>
> ## General Observations
>
> ### All Patches
> - All patches have proper `Signed-off-by` tags with real names and valid =
email addresses
> - All patches have `Acked-by` from the maintainer
> - Tag order is correct (Signed-off-by before Acked-by)
> - No trailing whitespace detected
> - Line lengths appear to be within 100 character limit for code
> - Commit body lines are within 75 character limit
> - Files have appropriate licenses (existing files being modified)
>
> ### Missing Items (Info level)
> - No `Fixes:` tag on patches 1 and 2, which appear to be bug fixes. If th=
ese fix regressions from specific commits, a `Fixes:` tag should be added.
> - No `Cc: stable@dpdk.org` tag if these are candidates for backporting to=
 stable releases.
>
> ---
>
> ## Summary of Required Changes
>
> | Severity | Count | Items |
> |----------|-------|-------|
> | Error | 0 | - |
> | Warning | 4 | 3x subject line capitalization, 1x potential dead code |
> | Info | 4 | Missing Fixes tags, TOCTOU note, style preferences |
>
> ### Recommended Actions
>
> 1. **Fix subject lines** (all 3 patches): Change to lowercase after colon
>    - `eal/freebsd: do not use prev_ms_idx for hole detection`
>    - `eal/freebsd: avoid claiming memseg holes`
>    - `eal/linux: check hugepage access permissions`
>
> 2. **Review the start_idx logic** in patch 2 to ensure the `< 0` check is=
 reachable
>
> 3. **Consider adding `Fixes:` tags** if these address specific regression=
s

Hi Stephen,

This AI analysis seems to have been run on the previous revision on the
patchset.

Jake Freeland
