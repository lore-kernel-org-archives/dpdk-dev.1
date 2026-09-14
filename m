Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B27C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 18:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E27B640DDA;
	Mon, 14 Sep 2026 20:43:13 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 657E640DDA
 for <dev@dpdk.org>; Mon, 14 Sep 2026 20:43:12 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so20299435ad.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789411391;
 x=1790016191; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=dtH6fzcXwwHZwK/aTl/njuQHBT0Qqj3zWypUVJpEzp1R02QpkP8xJX/Fli50L+vFJK
 zN8WdWP9zJHxtDrwj0YzfrK6av93/WbDGDQarumtJ4TwpnxFNwVYtmtRu0rtdb5djO7x
 xWtAvPtyowL/Mf3yOG70rX0N1/kBa67oktSTjw+w7LyAjuifj7XREXREVBWoi/Bxeaf1
 OuEboHvGdFbW8tgX/eh5Ymu+31g5dDVv5bHRR1huznoTN2PwZVBiAEIg3wdtRRrcPf5+
 dPEJC3ww/BqDZ/O2bJ8sAtM/G3MfVw9Fd5QgU0XV2ewtm7vv6BrVqJ9wF9zUPww/Stlw
 T5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789411391; x=1790016191;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=OEvmfT3KnYqAUvcWCOqs4uWU9o1K0+e7yaynPUu3aNtsGvevwRUWl9mIKSu3h4dmBJ
 kSLTGWHu8Q+4KQs7QU0C/6PRfnZwmH/WPCE9Z4BxCZ6e9v7EKT4rEFR/uiTcnLyxJLYX
 pvtHxvI7+IW8giHMOekb7ZupOUez/drnRY7iLTbBczqcqwW0p1UC0XLhw9zUuErSxhMR
 Yloe2E2EZIrCheucUWJSI9iZu2PpQRGgl3yI3udZfnyP4ErugKmrkojwJkM9fyyFU9Zf
 rQ0UMfK4iH4QlhoArndkB/v8N11pFpmKCqi6F92OhAzQB1tvjNmF3sBkvQlzkMkuhp+9
 BVrw==
X-Gm-Message-State: AFuF++npIGg49wr9bBlPH2PRl62wy1DsdkYEDxpZwluQZYByVSfy5vgn
 8EuZ4tK6nL0l+Dj2XJZ6kAREbVnfD6bAU7YsCc+OYBu3CPR91AXntveY95R3tLehumHLu+Bs4Q8
 0R/Cxy8A=
X-Gm-Gg: AYBFou2eaCo9XzDLb4wolXG457cpLCg4f7p9gdyi3RSYbMtIlfgi6Q6dJTp/9cwl5gm
 ZZdTjLSuGA3oOegobb+pW8PXGMS6Re8/Fu+6H+NCF4UiGZu9ZSuaM1v41xrIFN2ySBNNmFL4Qkt
 2B/o5bzbiuZ9eMGlcJHJ/krCzWGpjrSqzQItjFVdkusMik1UEZHZURqpb+Dd7nG39KsX8ONt1QC
 BXChgciYD3mlJLYPVmIInmt5O8FJ5ZcTnFfCMUTyzUFczSlJWJWAiPx8RkD7JR8LZ5/pEGo8EVP
 mKwBMoXZEzIvTdjQGcX0U63vY9NyT/d5z0IwEOIKdxtL2CyQxO3fswJcAUDYNv1Up7YTZGnag6s
 L3JbtwqPiull+EcDbSiyyEu0MgbPRuZi/AHxR9DbJlrOumgfa1uX9DyuFxI/0rCkuDZG2qmnja+
 UAu/y22/whO7DhT71yiooI2z1LYFvxaSy/PIiTM6XMLe8QDz0LdTjM113y+rwmKLK3VxdrCPQ55
 QsbFQwMX6RoINvOOhxX9/JKAxoaUQqKM/5uCdY7
X-Received: by 2002:a17:902:d54b:b0:2d8:d4d0:792c with SMTP id
 d9443c01a7336-2dd6c7128bamr80829525ad.16.1789411391548; 
 Mon, 14 Sep 2026 11:43:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfd8c84sm54059725ad.62.2026.09.14.11.43.09
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:43:11 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:43:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/7] fix XXX_DEBUG warnings
Message-ID: <20260914114301.7c936926@phoenix.local>
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

On Fri,  4 Sep 2026 12:12:35 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> I recently modified my build test to automatically enable all
> DEBUG flags. This is because developers often add debug code,
> forget about it, and it bit rots.
> 
> This patch series fixes all the places where #ifdef XXX_DEBUG
> code was present but would not build without warnings.


Applied to next-net.
Now all of next-net builds clean with this series.
