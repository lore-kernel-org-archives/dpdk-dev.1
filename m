Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829DC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AAB7406B4;
	Tue, 15 Sep 2026 08:44:27 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id 33FD040290
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:44:25 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4aa8e6bdso1435759d50.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 23:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789454664; cv=none;
 d=google.com; s=arc-20260327;
 b=jY1o9Ut6yeDJyU+zKwJdPbClTwvAZOQhkQEh4glMARWOPa386iMtE5g71ld5Ohc9jr
 PJinn6g2I/t3GFJxsgaQdX+8BTG6vBlbss5IGzipZsXStyUDEZFVr0lAFxiHGu9E929R
 nns7jXPMuzFmDCKU+UMV302J6Reyrp2Il5GlcmwfsF3R4C6gHPVK6BMk4VzK4sU09ekh
 2mu9Z0CVPVhsueSmQUE4BYeQP3mV51EiG4yRABhHAnMy03WX/6XAeV1ezxraLmIQz7k3
 3spL592q+/+Ugx4TleGtbhIMksd/OmfBFOjKgRukpMf+zVuDDBCPOjP4oyVd5iWtF5Cr
 M6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N/zB5UTjjgBtx4p5TZlmxihhCAgDspKLab9mu3gDff8=;
 fh=NiQU0xMfAPuSNQisWZgSIGj+Cte984mejIYKEHQfdhs=;
 b=Aj2y7YIQz6W+wEznRgvR/O5uGTmJacUyX231GMm5dTWN7Gj5ElNwd87MPj2yeBVO6+
 KCLc2XZLk/TVCLJhhfElJvOleIbvWmWREcjsKyGOpi++CZD7AR756Hg7x5QRWw+RHnF9
 OtPo7K7UHkHcUpLhwqzD+oPgZqk3oFFHjm2YJjSe5mXfmuEi2dp5UkWoA/8SoewIVwgg
 XCfx9UgXnQA0gD71ZK4aXseSuwt2qnEsGZfZHvoWBMCuCaPpPK+/3DKHzm1DKuaOpOud
 qRCfp4QM1yhImXp53SgCag9QAvyh+I8tENkbDm4xWlxOLdrfuFRv9gEr1AEH8eKdDKWa
 sKWA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789454664; x=1790059464; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N/zB5UTjjgBtx4p5TZlmxihhCAgDspKLab9mu3gDff8=;
 b=W62z0SbbRyUBXdwc8umcnfvXEyPkijJT5uFAa7PFfhbREmWUfJmJlm7E8bBAbV2jUC
 CMedYbjWF0Z4no/dJFp5GklKn2tP5yIR8gIiS2VxMds8xvAaOQ8ELMrW4VEYHfHotJFM
 c8wrtq3jPdh2FI3sZ9EzxfrrC7/c0CTuu/QYfaZTMH2s+o6M30+aNtbL6AwwLwEBftcb
 lZlBlmKhGHu079EZe8gErE/V0mJ49KhVOyQC8oxZT+r3YsgIs6izUSTafDjvV7qO5IUG
 zmri8/g+QL+bUg8q9BGAnMZNkTZMgWK13f5YeUSCOGAzU7DWQawPUJA9lJ9YZUuwC/Es
 /MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789454664; x=1790059464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N/zB5UTjjgBtx4p5TZlmxihhCAgDspKLab9mu3gDff8=;
 b=ASxav2CQlzaUtCO7RhmEBcuUAZnYBld1uEX2BAbafs4aSzs/w0z3xhZvm2Hpy/2Z35
 Z/wnUGQW0h+KGRGloKi0Ob6OgxMt0bZBIKTvDZYdoGcqWZjbGYnraj+cZ4WK3tNONKIu
 oMRZEnpuSY0E1sN9bqt73OmR4z+goYbvruLv6Ly/8+Syi/nIhhkKDZcrqaJi0e65fVc0
 Ru4nKOqd0n9GoRW5mrGq6bkURJ3SCoK10d6NI4p8AR/WALENbdzs/1sq4BoXIBE6c3kF
 x4k/xiMsWmG+vNz2nu0qBp0ouTrftjbagjxhHy3xNBGRV8PDEP6u5fWo4TBmRws7BT0T
 7iqQ==
X-Gm-Message-State: AFuF++ncod0LtdilNQ/v6cJrJVbeOgo889UlH0Uh7SCoVk/pfIgTiwi9
 pDYYWSEzb/DxCRr9WxUVCCBTKq2IzsTzdXxd1TFAIbGMZ43vXJUY2FUpD2A8wErLu9D8LH60/bf
 xMqSETAT1DsJR91xPzDOMthWxlZGX7t8=
X-Gm-Gg: AYBFou1EaHDFT06oMqTx4rSge8ai2kGR5JJy3RS73WJ61t94D+zmkv6IBOzv7TeOFZw
 hUiNOaXOw0DRkb5eC47zej/CyifELjMDBU7uIcTg1QJM1UdG45tHCG+qoC/FZ+qSLdD9szn07od
 ORhVB3neT9Me6wkS8zk3vwuBgdcHeLwWO02iw3V70UH2Ypfoy5GvAG0Co52rsW4EfqG5Wid/9zx
 KyojI4gSobVnJjLhjFKjWaEoFhknR1nl9TCpSfRyKS27TWR56I2q1ZPpN9IM3QrzH6Y1QjKY1dZ
 QxE0o9NGU0fEifRJlPd9qZ/BGUV4nc+ylocjrMlb7wnNZm7vbWDrzo2Fi14d7mFxZQXscrDL/xQ
 cedZxKw8rnJVce24W6PzShuTNP8AlD5A35ieYleRRDeVrqvvbYBGwRuKbwvkbgRDJbjJ+yJlFw5
 fYg2otbU5eR5oSoABU
X-Received: by 2002:a05:690e:4419:b0:66f:c1bc:403e with SMTP id
 956f58d0204a3-67154fe8756mr460076d50.31.1789454664532; Mon, 14 Sep 2026
 23:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260829105409.1160766-1-vattunuru@marvell.com>
 <20260829105409.1160766-4-vattunuru@marvell.com>
In-Reply-To: <20260829105409.1160766-4-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 12:13:58 +0530
X-Gm-Features: AcwNN1V_-JC80-yJkybGB83NnzrJ_TnCKawMuwMBmQiMcfr-ji_P4uSv4vH8TTo
Message-ID: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
Subject: Re: [PATCH v0 3/3] dma/cnxk: enable inter process domain DMA support
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, fengchengwen@huawei.com, 
 ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Aug 29, 2026 at 4:24=E2=80=AFPM Vamsi Krishna <vattunuru@marvell.co=
m> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Adds support for inter domain DMA operations.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  drivers/dma/cnxk/cnxk_dmadev.c | 148 ++++++++++++++++++++++++++++++++-
>  drivers/dma/cnxk/cnxk_dmadev.h |   1 +
>  2 files changed, 148 insertions(+), 1 deletion(-)



1) Fix
 ./devtools/checkpatches.sh -n 3

### [PATCH] common/cnxk: add O20 DPI DMA support

Warning in drivers/common/cnxk/roc_dpi.c:
Warning in drivers/common/cnxk/roc_dpi.h:
Use plt_ symbols instead of rte_ API in cnxk base driver

2) Change rte_wmb() etc to rte_io_* in fastpath

3) Update doc/guides/dmadevs/cnxk.rst for CN20k support  and  inter
process domain DMA  line item

4) Update doc/guides/dmadevs/cnxk.rst for CN20k support if anything
needs to be updated for starting dma application like devbind etc.

5)  Update doc/guides/rel_notes/release_26_11.rst as it is major
feature(CN20k support and inter process domain DMA). (Make sure follow
the order for release update)
