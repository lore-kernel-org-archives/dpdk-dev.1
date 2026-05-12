Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C8CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 14:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7FFA4042E;
	Tue, 12 May 2026 16:36:30 +0200 (CEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id 41FFB402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 16:36:29 +0200 (CEST)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-393c93a01abso47428381fa.1
 for <dev@dpdk.org>; Tue, 12 May 2026 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778596588;
 x=1779201388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zo9bKO828+lRkajg3Yi80ujjg+oPiPX1H8M8IxRsYR8=;
 b=OpnI9OtTcgoecKEvfCfjQsiOn5pGSbdhFOjc4sTJ9NtRqnCU9lfxPuq7ylZTWK3fxv
 il6RU0rmJmqSiPepbvGmmfxrN4DO57Ny3FM5YLTdmz4odro4tlSKfqQIsP98paej4H0e
 GD7C5jZ/235ep7qtyVcm2TZIp7vklGQCyJe2+MMNOqNFbP4Z8lro7DP9Zm55aHjxQ2AQ
 cJYiX1plbkyHwzL5D0Werhh9OGQnwZf2XHZJIZz3LYHI3TIjhHFpNpCQtHt93cnnmYZp
 qKbkJPuxvj60AIO6pC0AbOPV1vcFju5oPPm8KkAWnShklFZqJ39ydjaXFHOxd39ELHDk
 GI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596588; x=1779201388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zo9bKO828+lRkajg3Yi80ujjg+oPiPX1H8M8IxRsYR8=;
 b=VjyrU3JrhtT1ImyA3xjIcIx9HJFyRRZQXvnBGufRCTRMYRLmABPMfJhdX1NBzHGth+
 SD4vTgM9IXgXMh4tDoJztm2pLYHlSIH7LngHu0dDkAXM42K1H9o/C5Vtq/7aH6ACPzBX
 0CdmUvCMCQKWiSAfgKqu01ABwkZug5z6LDLRmOY34ocS+UhPCEypbzF32cO4NqgrYq3b
 ne/IUFCTVtr1kOXmsarAaSIdVADXimh1wnB3M5D4xVXsrmB1Jx5mlXlskytY0TMwyixH
 tre9ZVK3qHtKyYnJhJzuRpBONkevaSrxjpO51wvMLOP75xYl0ygamvoI6k5UW1z48WqG
 KXbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ihn8zvgp0JZQoMo64QiFpZvhxFJwDIwkjMsg74WXP5vfHzKo9hZ80RycdesFBQgVhE+Y=@dpdk.org
X-Gm-Message-State: AOJu0YyQwFs4R25rPDQboU/EMy1iHLZ2kfnZG2X0qUqg5BQEcNRLu8Vx
 7nADrb0+2kZ0CM9+CuTAe8ej6V6XxhQ29WbnOLovn7qRKDSaUtobI0ctppezy5ToOxg=
X-Gm-Gg: Acq92OGSO9pOM+BNtsaItCAkmgkZ5ohL93Y6dWBi8RrNfRS66ZB9+bvn84/fTrHj0xa
 /mJ9qle87fJhjPRQQlpgQl1JQuY1XDYUU3yWuNsatvyrF3mmGVyT8yWcc+XzdmVkOokRtOo8r6A
 0ApQF4Wf0/Hl0mVxda4IO1vbyeZQxj2DTz1Q9WmNPEOi+jF1KEULZnGKgcHf1wFY0GiB6Yyc1fZ
 wKEL2waH3Ebyty6hyfT9lq6HF2phZXBq5wsm3Apu++ytcAaSCM5YO5Gyle5pdO2K1dcCF8AQlaT
 LAXWtDQFy/vUBrHzEs3iYIGsUuKqQqhABEhCpvj46tVu754mXTo10pcsFLXCwF5FfOf0ERcP/lC
 B9A5Z49SUOCUGUjcnH2KDtaRZJdM05JefJQxgpDkk+B+6etTWW0q05euxC/y4tyUP6LkwSIu2Es
 ZoQQly83R6I4zoj/pCbyrmpZC6/qLDmcbfVwOSpiO3L+QEhYrg1NY=
X-Received: by 2002:a05:6512:1192:b0:5a8:7bdb:92c0 with SMTP id
 2adb3069b0e04-5a8a94c1eb7mr6943207e87.29.1778596588306; 
 Tue, 12 May 2026 07:36:28 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8aa5sm2396232e87.56.2026.05.12.07.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:36:27 -0700 (PDT)
Date: Tue, 12 May 2026 16:36:24 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v1 0/4] Introduce generic cache stash API and PCIe TPH
 implementation
Message-ID: <20260512163624.5de45dee@stephen-xps.local>
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
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

On Fri, 8 May 2026 17:28:51 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Note:
> 1. This implementation references the Linux kernel VFIO TPH uapi
>    series (v8 version), which is not yet merged upstream:
>    https://lore.kernel.org/all/20260508064053.37529-1-fengchengwen@huawei.com/

DPDK changes will not be accepted until it is merged upstream.
No speculative patches.

Also, the first patch should be a single patch that updates the sanitized
kernel headers in DPDK.

