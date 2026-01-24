Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97954D715E3
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 19:19:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF4B0402B0;
	Sat, 24 Jan 2026 20:19:37 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 03A7E40278
 for <dev@dpdk.org>; Sat, 24 Jan 2026 20:19:37 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48058548779so2741565e9.0
 for <dev@dpdk.org>; Sat, 24 Jan 2026 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769282376;
 x=1769887176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz+/vXJLsJZtPPj3hqRkAZhYqJ3r9pPP/Eq0zif1Ecs=;
 b=OdWhnbiJsIk+6XtWNaiK8QXlWiedGya1S+sN2LYGhP062xqlklUntngXUrgGEq3u1/
 13B/T6pfKfSwjNesea7Mj3XYobEeQ72R/CffglsgB/M/kBC9H1VRkXa1tMoBYeWaQhNy
 lKJGZlaicfMPxXiR4+A7kPCayx7AsJHWN5mSa8fsxuPAXR4d46Z0HjeksX5Yz42PK7WG
 v2y1MOPWpM2NsrQkJegLEezC/NE0R3KHIb1j3gnuCgqC+fKsXj4ATb42Ess7ZZKoGtCC
 NOmYfZrHsOpJ2AQcsJA9aBRYJbpYZOsxccMo8irWXcaJqFoLltnfMnpUdnyHoimUkQin
 8qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769282376; x=1769887176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jz+/vXJLsJZtPPj3hqRkAZhYqJ3r9pPP/Eq0zif1Ecs=;
 b=fWPYnfN9LXQnjtYabriJCSEr3HCgcPO4FWGpi2KMK0eOHJ77F1Nn37wgIkSzMw2A3U
 a+OOzlbL4MNWeazOpbmZK3O+uPhBAjfhqRqvAiY6AoFel/v4Xa7BvkGr+CJCKYg2dALy
 ntEuU3ws8PvCBOMRWIIsnkBp4eClLyHM5QLT1/1mgBoqHR0ZQW0W5MCmdfHaxKACGJR9
 fbyt2HRYQ1T3Nm12mKPy2UdLpOC1X/axIYDjJlvOp+wysgzc2EVnhX88h2hjwcVV9Rxe
 S60eWnhanxe1+zwYBdCKNMf7Qegiywjwl/4KdhfJ72uHwYZ4QqN0ya9tBjLx6gTozi7R
 CI/A==
X-Gm-Message-State: AOJu0Yzju2i3oi8zSZUzh2uXlNSUA6QUemDSH1Lv46yy+iUWS9O8DDa8
 TpQM+hwFbfCVZe6QVHjVsCNjpIPW44RGVk/4CizfdpDxxJ71SLMl5HR0DiAq4kdTBuabvIu73mv
 3O9ho
X-Gm-Gg: AZuq6aI4cjPuzZyD3bhjplBsF8SkEH1bZ0m7bxPsw5DkgV7hwoY/EilRn1NtaBv7zpN
 KjySb+eDrOtbgvSDwroVZWA4XIuXMVptlcBW+KuXImVijgGYR9JEXkzNDy/1q+lMe2Wp29zCwVo
 XqW4bq7DqWd5AyZtXwhlwsQCJdN32dNuB4E3tp6BihiMsPGajZx/rHdBdQHq0ysSdqcDjZ1ZLV1
 8tPN1N2aPP47qnvIoZYwp1L/pkbYXjPAJTonhMLEDz1hx1sL24vl34Mkie/ZpX4YbFF/i8jzBeg
 tQxUKvnfCg2jTBoMO9qeJ+EZ8PjgQQCFWi9+ZVxBIBu/uSUI5hlmLbSx0+oks0ji5WJPiulzQnL
 pCGo2FrEGQliYWd/4sWsLdS5/OlXNC1ZkjJr++xcqZgp46aiUr2NP7tRO8wrcBWYlomf8KadX/n
 puh4T4UMLHG+RAAuoo24VcqYokyBxZXErjxcsKwcti5X/C3SkRrF7p
X-Received: by 2002:a05:600c:450c:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4804c954f1cmr105526715e9.13.1769282376447; 
 Sat, 24 Jan 2026 11:19:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d845fc3sm135455345e9.1.2026.01.24.11.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 11:19:36 -0800 (PST)
Date: Sat, 24 Jan 2026 11:19:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/8] net/nfb: rework to real multiport
Message-ID: <20260124111931.56e640f3@phoenix.local>
In-Reply-To: <20260123172224.1567362-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260123172224.1567362-1-spinler@cesnet.cz>
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

On Fri, 23 Jan 2026 18:22:16 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---
> v5:
> * Fixed memory leak on error path.
> * Separated nfb_eth_dev_create_for_ifc() from nfb_eth_common_probe().
> * Reworked port matching to eliminate the port mask / 64b width and potential integer overflow.
>   The nfb_eth_dev_create_for_ifc() is now called directly from rte_kvargs_process().
> * Renamed nfb_init_params to nfb_probe_params and updated the nfb_eth_common_probe() header.
> * Unified Rx+Tx MAC init and deinit functions to avoid code duplication.
> * calloc/free is now used instead of rte_calloc in Rx+Tx MAC init/deinit.
> * The return values of snprintf are now handled properly.
> * The return value of Rx+Tx MAC init is now handled properly.
> * The name of the struct type is now prefixed with nfb_.
> * Used a consistent error handling pattern (-EINVAL instead of -1).
> * Added descriptions to new struct members.
> * Some commit messages have been updated with better descriptions.
> 
> Depends-on: series-37064 ("net/nfb: code cleanup")
> 
> Martin Spinler (8):
>   net/nfb: prepare for indirect queue mapping scheme
>   net/nfb: create one ethdev per ethernet port
>   net/nfb: add vdev as alternative device probe method
>   net/nfb: add device argument "port" to limit used ports
>   net/nfb: init only MACs associated with device
>   net/nfb: add compatible cards to driver PCI ID table
>   net/nfb: report firmware version
>   doc/nfb: cleanup and update guide
> 
>  doc/guides/nics/features/nfb.ini       |   4 +
>  doc/guides/nics/nfb.rst                | 187 +++++------
>  doc/guides/rel_notes/release_26_03.rst |   9 +
>  drivers/net/nfb/meson.build            |   1 +
>  drivers/net/nfb/nfb.h                  |  56 +++-
>  drivers/net/nfb/nfb_ethdev.c           | 444 ++++++++++++++++++-------
>  drivers/net/nfb/nfb_rx.c               |  30 +-
>  drivers/net/nfb/nfb_rx.h               |   9 +-
>  drivers/net/nfb/nfb_tx.c               |  27 +-
>  drivers/net/nfb/nfb_tx.h               |   7 +-
>  drivers/net/nfb/nfb_vdev.c             | 107 ++++++
>  11 files changed, 624 insertions(+), 257 deletions(-)
>  create mode 100644 drivers/net/nfb/nfb_vdev.c
> 

The AI review warnings are mostly false positive.

### Errors (Must Fix)
1. **Patch 2**: `__rte_internal` functions in header file must have return type on separate line

This is just the tool not understanding syntax and having two functions back to back
is confusing it.


### Warnings (Should Fix)
1. **Patch 2**: Empty line inconsistency in struct definition
meh, dont care

2. **Patch 3**: Consider documenting use of standard `strdup`/`free`
seems fine to me

3. **Patch 4**: Missing `#include <ctype.h>` for `isdigit()`
OK, should change but not a big deal. Do it if you want.

4. **Patch 5**: Consider using `rte_calloc()`/`rte_free()` instead of standard library functions
As long as not shared, standard heap is file.

5. **Patch 8**: Release notes mention timestamp changes not present in this series
Good to address.

