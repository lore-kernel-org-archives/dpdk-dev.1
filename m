Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4582D172CE
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 05:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B424F40285;
	Mon,  2 Feb 2026 06:17:35 +0100 (CET)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) by mails.dpdk.org (Postfix) with ESMTP id 430C840281
 for <dev@dpdk.org>; Mon,  2 Feb 2026 06:17:34 +0100 (CET)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-5f535ff78abso2877919137.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 21:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770009453; cv=none;
 d=google.com; s=arc-20240605;
 b=K5VCjGaRvR+FWp7aFLeWM7z0R6pWvi5nJJo8VAHvgHmbS+IYEQ0zOV1xZ+9qWV2T0m
 T5Ehel2W+ex/5DPB7u0oFSLu2hrZpAtoPT6PO2jAl+GaL2149zw/Wz8+n+vrpbCRkEdQ
 5iaBDxTe6y+2aPJStU0FwvC7LZ8I35wBirLbeCWLkMBLNlZRat3ZCnVoWoQ7HNj34Kiv
 2fDzTBXihOSiaymho0o3BP/gU3zrqcyFbdvirrgCN/E73+atWLiE/gHTVU1iemb1tWYZ
 VPNfemqrP9ri0Tguk8sa+sol0BXMB/ADQL6hqFAz/P7Fc/oF1R4o0KHnMMETeOzR1w53
 fp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bpVWRM/+jlsFUp7gqoBYYSzaLkANoInA3+l0kWUg2ZQ=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=R/PSA4mHP3bQn3MbnGaq0eEvFQ5JdcXRnZWqgG8V6d+VSIcE1JNzG3l7VjCzvAw0sL
 9PYGPsn2JMyMuYnQk56KqpDZ5SXZsZCcDn58wtP1aQ0h8rvc/ZmMZOa5GnCoA67cFOlY
 KUef000J7MN+7tOYhTo4dslYJZNV7yl8NXZQ1VTILzoUKCCu9ftZVU6+j1UaFvs+45KP
 Cd+TjwlWwHhwJqJGGr14M/x7yy/gnHS1sUSnS9h9xDkZ+cW1Qlwa8/36W5MMUGyEZ2IK
 cjfbdzPgTTiiI+YKkpyVTMR42aWv0XGXcwVcHZdZS+nR8qfz+tMWdKnVoQ9HD9r9Asqb
 ptNg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770009453; x=1770614253; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bpVWRM/+jlsFUp7gqoBYYSzaLkANoInA3+l0kWUg2ZQ=;
 b=bWUvUFQAiukWacmW97wx75PYbUsR0UgdYCD2S5yk6H4aA0+2sUPSQnpMPXTQDxn+mF
 6wh/f5368KrbWaqRRQ/82FF7pj9Uh5UPu8YEu02aSb8ykpqmpZOz1cWtktfUuth2bUqU
 oTPQI9OZhWp+bsNXUUxkWvBf2GGQDspvGoPNaKUjGHv8F8zLhSLaxgl2uEF78rb/mtwk
 0AD3p1Nh0wFtk2BfMnh+6dDVAlgBSSjHzNmhSdwP3XJE3zQx5VxqnX6rUNCZmKL5BYtX
 BtJ2/jvxcaH27H1lu5c/OGXm9rZrtiL/R3LXQ+z3zdswb2f9defeq0p/daSxJ9+an7eD
 Tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770009453; x=1770614253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpVWRM/+jlsFUp7gqoBYYSzaLkANoInA3+l0kWUg2ZQ=;
 b=OIxe88Rnt/oE0MqTxG1+hxjWN88jOaXYYIyJXSAzTiOxE53tCGYhMtfneZQXPv+fnh
 gGJTlYyOmx3kToBw4/GXs8Xcuh39xZNsLYQ1qPBfsfqMIGTwnFEmap4eVqjwOIkQokpU
 k2SoDdfqxWTUiqNY2JnOJpebMVzafFARNNJS48YIqQH62VpMhvvPxZ7d1Wk4Dy5SY7V0
 Vfra/yxPEZAWvqqGLmuIJMHmM64VtCd3gNErngBGUMYpDZcqeXBTM6GK2IWFpV/IpOcW
 UD2YpEwHsk2S0f/UgDy3OrCSZJL8rpgaZ/osac16Bu6ySQ9J08Nrxtsz12xjfT2KANHE
 Tvmg==
X-Gm-Message-State: AOJu0YwhApno9R9zeWCElO2gzTCy2hPiw29ZXtEb4ij2Uj9eK+8OQRrY
 TsQxaj1u7GrYVu/Xtn1TpZUF2OHydTRHAq/yMvk47WBBPyKCb6zR8YpQoLVyS/GpZMoWdYpIHl+
 WLhMx0QnQqO9oLaCorNjivp/IssRBIdRhsQ==
X-Gm-Gg: AZuq6aIV/phEI/pprf30ZjuxbtUp8wSdR1piHZB47hHdvC6sfQpZWohrSA8gpLS7cXo
 AwiXoDyrUG7HNqAgOl/1PGNHZRuFvq5MV7fxRA2/ZaRi186wLXKVCFGf8Gtq9FeuqyfQCa5t/Zl
 PyfkYTB4WsnHYQ5pZWRg0/azUnu82KgmChpBu/MJSvk75l2mAjHgbKl8rWgTgrbYn8HyO17ZMC5
 IZ7EAe8AuSq9o5TCdrEFGmv8eVQ1fIx41TEEPyf+hca6nXEJd5bs5prrynAUi/s0tv7Xbs=
X-Received: by 2002:a05:6102:b0f:b0:5f1:b904:d310 with SMTP id
 ada2fe7eead31-5f8e25fc974mr3736181137.33.1770009453242; Sun, 01 Feb 2026
 21:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20260125223015.69190-1-scott.k.mitch1@gmail.com>
 <20260127202843.20273-1-stephen@networkplumber.org>
In-Reply-To: <20260127202843.20273-1-stephen@networkplumber.org>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 21:17:22 -0800
X-Gm-Features: AZwV_Qhv5cR1rXmEwzyR3lMPwaJa4Fa_8bkHe5nxQmQSqkSePjFUxpG9wkvvrn0
Message-ID: <CAFn2buCp0T38QNu4aLJOgMpvNZjXVSpV-yf0zSXxtgvUSJ8W-Q@mail.gmail.com>
Subject: Re: [REVIEW] eal: RTE_PTR_ADD/SUB API improvements
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> 2. **Missing `Cc: stable@dpdk.org`**
>    - This patch changes API behavior (NULL to `RTE_PTR_ADD`/`RTE_PTR_SUB` is now undefined). If this is considered a fix for existing issues, it should include `Cc: stable@dpdk.org`.

Morten opened a discussion on this. It's API breaking so I'm not
proposing backporting. If backporting is desired and API compatibility
is required an option is to deprecate existing macros, and introduce
new implementation with a distinct naming convention (e.g.
RTE_PTR_QUAL_ALL - qualified add), then remove old macros in the main
branch.

> 3. **Missing explicit NULL checks before some `RTE_PTR_ADD` calls**
>    - `lib/eal/common/eal_common_fbarray.c:1062`: Added `RTE_ASSERT(arr->data)` - good, but this is a debug-only check. Consider returning error in release builds.

I'll add a runtime check here. Note there are other cases where APIs
didn't have any null handling and would have crashed, and I added an
assert to at least be explicit about expectations.

> 5. **`volatile` qualifier handling in `idxd_pci.c`**
>    ```c
>    // Line 62
>    static volatile uint32_t *
>    idxd_get_wq_cfg(struct idxd_pci_common *pci, uint8_t wq_idx)
>    ```
>    Good fix, but the FIXME comment at line 398-400 indicates incomplete resolution:
>    ```c
>    /* FIXME: cast drops volatile propagation to idxd_dmadev.portal
>     * See: https://bugs.dpdk.org/show_bug.cgi?id=1871
>     */
>    idxd.portal = RTE_PTR_ADD(RTE_PTR_UNQUAL(idxd.u.pci->portals),
>    ```
>    This should be tracked in the commit message or release notes.

Can you clarify what would be captured in this commit message or
release notes? This commit isn't introducing any issues, and a bug was
filed to follow up.

>
> 6. **`RTE_PTR_UNQUAL` macro is used but not defined in this patch**
>    - The patch uses `RTE_PTR_UNQUAL` in multiple places but the macro definition is not visible in the diff. Ensure it exists or is added.

False positive.

>
> 8. **`drivers/dma/odm/odm_dmadev.c` changes remove `const`**
>    ```c
>    // Before: const uint32_t *base_addr = vq->cring_mz->addr;
>    // After:  uint32_t *base_addr = vq->cring_mz->addr;
>    ```
>    This removes a useful const qualifier. If the intent is to allow writes, document why. If not, preserve const.

The comment would be similar to "this value is used in a non-const
way, so don't use const", and I don't think this adds too much value.

>
> 9. **Release notes format**
>    - The API Changes section uses bullet points correctly but should reference the specific macros more prominently for searchability.

Clarified.

>
> **`lib/eal/common/eal_common_memory.c:1563`:**
> ```c
> struct malloc_elem *volatile elem;
> ```
> The `volatile` on a local pointer variable is unusual. This appears to be preventing optimization, but the rationale should be documented.

Comment added.
