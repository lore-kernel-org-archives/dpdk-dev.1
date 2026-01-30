Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF1E6BF3C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 23:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8336A402D9;
	Sat, 31 Jan 2026 00:49:57 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id A158F402B2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 00:49:56 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so32051165e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 15:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769816996;
 x=1770421796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=PNPsLidBkhZYPZlmP9nUB6hVYZs8EANYWMbKmoyGr9U=;
 b=chcd8eyUQT52fEG4VdsXziodZYtlFB+ZDqd13ANSuhbKoiXuh+L7Ox98tU9pfnKkKm
 QIdKsOAg4cFcR1W3VKelo5gl+j2eRA3ZKty5qaQo7RIm2BS2p9jBqxnrYbdItgjYwRvE
 5tZdtkH1oqrbuMjrDq0iFroMb5zYskj5m6hggd2UI3eENF0ihGegRiFEiCwxhDJq+Xs2
 UWE7S1nUa4IqbiZj8ajJvCsdtXnmPDj59qij6A3gqMzCn4rAa0dPvt/b/hneZ5XfInlT
 cnqzskUfM2C8vbaIQnkqABAlR5tNYyf5XGkLx9BS+iFD94BB1vMVq1FdD8DAOV6x2RPt
 imHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769816996; x=1770421796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PNPsLidBkhZYPZlmP9nUB6hVYZs8EANYWMbKmoyGr9U=;
 b=bHsz6jUONSdUPMjMLGC8g/PNitfcv2ym7SbSwSw+7bm5//AVGRtUOJ+tGOuuKmPmPR
 76m9Uz2WXqsb4kEmaEBoGrPs/bpU3RZ7bXFAEW8FDasW2O80ra5gsAbTtf8iuhLLvKUm
 IbMuLtxE8lyrOOR6Gvdhk3w7pTGgs69HhWMp6tVbM5JmjJvhLkjWRIeBtqo1mUMTcwYu
 drTMneiijdeB/D6Rap6h1UfF/OkVuP6wbLPzBRgIUox3qblj8D3qoLjQQl4fC22EUGhQ
 Nuyou05lOUpiycscCtCkZ9Dn2Z4hUL/AM+yb+lK7OaVKxt64zq2brhaoCXQJjrTb1odF
 MPTw==
X-Gm-Message-State: AOJu0YxJGkN1PT8T0CL1GFx0YLY31AIJIoDyTbNONJToNR/eGOlUGHMv
 zMkLYdaCAdyWt4F45rNAWYx+WL+A2Bz8DScmNksV+rbyte4T+2d5BVOKoLb8jcyigw6rJ5i6Lzi
 gVCOt
X-Gm-Gg: AZuq6aKiI0zWqfkltR09KXalRYWWHvmIdPTMM8KCX4E+2bdBrbL2G361cHtjgwgAsR2
 ax02pmTBwD8bIEbIhkOAQ5elh2jqr1hjaSuvyfBiX0k2wx6cASasT9cZlHihnbYw82pDT9nK7Yd
 6hChPnXgdzqVFDs6g00+nx2PMYuEvKufoNP2BQsxb1BOXMDavkaiVQbOI1Gx4WXeGgjsuhjfH/9
 1skuikK7yBTwDLp/p7qew+q22mtF8TAzMEwBdtu6pj1FWYahvf8XW2HQj54BCvHMgolS8HrA/Hl
 JlAYYjRiAR99RHgGX/t6zZw614xpIUpidtVM2A1MrLMG2PIws0pDXj1uTtrxohPd9rBNsZUS63g
 k8HckxskKHubQKEzZICAsUrjKvisOeP4fz3fGA9e+Qy96i0SZEBNWRVD1GvV3eUMmDnxVzf2ltv
 mpJRxXkfI/JxlyAZ4e5TbOlmG4VD3dqstlxXvx0cVX/UbYDBJb4uUv
X-Received: by 2002:a05:600c:8b31:b0:480:1dc6:269c with SMTP id
 5b1f17b1804b1-482db49e6demr52011195e9.37.1769816996167; 
 Fri, 30 Jan 2026 15:49:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm282487735e9.15.2026.01.30.15.49.55
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 15:49:55 -0800 (PST)
Date: Fri, 30 Jan 2026 15:49:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v7 1/4] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <20260130154951.2acb79db@phoenix.local>
In-Reply-To: <20260126184205.104629-2-stephen@networkplumber.org>
References: <0260109014106.398156-1-stephen@networkplumber.org>
 <20260126184205.104629-1-stephen@networkplumber.org>
 <20260126184205.104629-2-stephen@networkplumber.org>
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

On Mon, 26 Jan 2026 10:40:18 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Add a structured reference document that enables AI code review tools
> to validate DPDK contributions against project standards. This document
> consolidates requirements from multiple sources into a machine-readable
> format optimized for automated validation workflows.
> 
> The AGENTS.md file synthesizes guidelines from:
> - DPDK Contributing Code documentation (patches.rst)
> - DPDK Coding Style guidelines (coding_style.rst)
> - DPDK validation scripts (check-git-log.sh, checkpatches.sh)
> - Linux kernel patch submission process
> - SPDX License Identifier specification
> - DPDK Coccinelle scripts (cocci)
> - common items spotted on mailing list review
> 
> Key sections include:
> - SPDX license and copyright header requirements
> - Commit message format with precise limits (60 char subject,
>   75 char body) and tag ordering rules
> - C coding style including explicit comparison requirements
> - Forbidden tokens table derived from checkpatches.sh
> - API tag placement rules for experimental and internal APIs
> - Patch validation checklists with severity levels
> 
> The forbidden tokens section documents restrictions on deprecated
> atomics, logging functions, threading APIs, and compiler built-ins
> that are checked by the existing checkpatches.sh infrastructure.
> 
> Severity levels (error/warning/info) align with the exit codes and
> messaging from check-git-log.sh and checkpatches.sh to help automated
> tools prioritize feedback appropriately.
> 
> References:
> - https://doc.dpdk.org/guides/contributing/patches.html
> - https://doc.dpdk.org/guides/contributing/coding_style.html
> - devtools/check-git-log.sh
> - devtools/checkpatches.sh
> - devtools/cocci/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Rather than one potentially huge file, I am thinking that breaking it
into bits and putting it a directory similar to
 https://github.com/masoncl/review-prompts/blob/main/README.md

Maybe review-tools/ directory at top level.

