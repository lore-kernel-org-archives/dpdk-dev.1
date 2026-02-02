Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1EFE7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D00B4027D;
	Mon,  2 Feb 2026 18:54:57 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 069464026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:54:55 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-482f2599980so19292795e9.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054895;
 x=1770659695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=3y55ME7ZOWB2Phf9mNsD8mFEqhL+r20wxG1VdTJc2Qo=;
 b=cpFHCh+QGWoIT/PjQnZByY5VkOtN9XRuhT+OEVS2HHDHAGppP0BGVyYdlon+odvvRy
 1n6J8G+1JSzehTG+6QaaQ6XncyitOjwqqLmiyj1coeMk2nnVvrddg5BUEu2sCvQhBEpp
 qMOFBTimKi28X+YrDgXvuGUg/sfH3Sv+V2Gto+wtdwGpq6+V952SxNoXajSl4+YG4vbB
 VgeIBTUyX5KhnGn1lWadtwBityQbWK837kN5SPL4OTQfkvkCNNjerzgKZdVzc+Mlulb+
 +NB8JGwvDGhB1SSvJkOs+ugYDVeEF91gW8I1IAeyQhNjznEG4Smn+wZ8x4Gh9y4SCdBK
 qXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054895; x=1770659695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3y55ME7ZOWB2Phf9mNsD8mFEqhL+r20wxG1VdTJc2Qo=;
 b=oEyZZvkMwD+9r4LQ870rP48dYxASkQCGHUe3jFYd0uTUV9fyvkm8bZfvq6nAGIDyKB
 qRDyc0hfqMPqA3xjJSl45KfyPh1Apdl/b6Cb5WqKEvPj1I7n3PRZfTFYpKvvJWgFqKUo
 TQKGbvLBS4TQWUtW0mGHCuEwFr3R3UjMwjCWX3NtxST22YpsY1VGWOF7aVcPbrW6loEd
 UIEGUyRK+rVApASmsHC/nPYigUPboDEF8a3LyRFd8eo8a/+Xcc2m7cYY68SM2a9poFF+
 Myg2HaB9MhQ/YFE5Sohr9T4kphtQZs8d4x+pOXmxWCqPoO2hGHeCgOnehwZ7PuSSmdDo
 G6WA==
X-Gm-Message-State: AOJu0YywQwUPRxiCP++U6XhwXqKFotLZrB/v6Ydr24e/YnVp/LU6TarW
 7yIUtimYPO7u1RqnM4PK5ABfqwBngxmHTXI9Dj8ZuH35zg5V6nw59hIM6bYwL+cOBRDGh5MR25P
 10NeT
X-Gm-Gg: AZuq6aLPEZmodKFpuoebKNa7VDeN9MBFMMXpcxlVsNHWyvNUeslw/kgtisa5no+r5si
 rhoxppC0qpGY70rJ9t1NCPFjEDnPc7WSZPNSEYehdfNadT+0w08F1pbuyjD9aQMwmsUvqV2obhz
 nLgwgToCGtEuU8PfSlewEMskZGrfsxoLHkX7JTyC5Cb2Krp+KCcQG5PAVBATiqtGPaVi8J1QIXU
 9ayT8q8M/QzRUHKckkYIiLC4s+wXBZlg7Qb0Pq9aCm6ejpi7SNrKLYKwe+jChuTvcWLaK5n0b71
 WV1zhkF/1R/Zv7MvfIrjwnConENxrqWyBNd23LqQLudgqfIKj23UmcBYQ70XOE44juhS8DJzqlS
 +vTaFWqS7PIbBnN+DqsELrHWSCcQfd9hyHx1dPb6EsYn/EnvYrxueY6V/d91K4EWhyJI1x6DEXg
 WZex35of3e8ntpaeuEoI9hEgoHM4vihcX0WKrwqRtZu8PZtys5oSKJ
X-Received: by 2002:a05:600c:3b1d:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-482db46014dmr162029055e9.9.1770054894776; 
 Mon, 02 Feb 2026 09:54:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051372cdsm6608415e9.13.2026.02.02.09.54.53
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:54:54 -0800 (PST)
Date: Mon, 2 Feb 2026 09:54:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] doc/nfb: cleanup and update guide
Message-ID: <20260202095450.031d4df6@phoenix.local>
In-Reply-To: <20260202174235.20628-1-stephen@networkplumber.org>
References: <20260202153449.3295979-9-spinler@cesnet.cz>
 <20260202174235.20628-1-stephen@networkplumber.org>
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

On Mon,  2 Feb 2026 09:42:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ## Summary
> 
> ### Errors (Must Fix)
> 1. **Patch 2**: `__rte_internal` function declarations should have return type on separate line per DPDK style.
> 
> ### Warnings (Should Fix)
> 1. **Patch 1**: Line exceeds 100 characters in nfb_ethdev.c.
> 2. **Patch 2**: Extra blank line in nfb.h; line exceeds 100 characters.
> 3. **Patches 3, 4**: Unnecessary `(void *)` cast.
> 4. **Patch 3**: Verify file ends with newline.
> 
> ### General Observations
> - The patch series is well-structured with clear separation of concerns.
> - Commit messages are well-written and follow DPDK conventions.
> - The code changes are logical and the multi-port architecture is cleanly implemented.
> - Documentation is updated appropriately with release notes.


I am fine with patch as is. But getting merge conflicts with next-net and main.
Please rebse.
