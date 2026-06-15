Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6861FCD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C97F40A80;
	Mon, 15 Jun 2026 20:06:01 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 2D71E400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:05:59 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30b9e755555so944538eec.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781546758;
 x=1782151558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vv8iuQ1I8u1JW1ypeVdVrH7k+4iJD2etLLnxZbZM+8c=;
 b=yDdgyaYeDDTYC3k1gJF0d0qXvNUrE9TjE3cgrwPf2D1sUlaSpKYjs7S0RZZON64wxS
 QcaROK+373SJcOTYdBbC6dIc3TGPlnuqCt7Wu9ypD4yECkT1QLJIihIblVebAxMvd1UT
 FqrANU/k0+AXBqJzpMxx/7ce5YSE4MNxCs7fmnqfPDESnPixmIAixxQn/fl28k9m0fYo
 ZR3ek9hUuD+fiRp98vkvSYvy7ry8rKqqegxwwVbal06GePsNAecjdziZ5jUmcNgIFgVz
 rY2kDsbphQ1HtAhsNeQLo8lu75QQ/1KEG1OmqkXlQiK4HnslMSIyz4DggXyScoxH2ppk
 fxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546758; x=1782151558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vv8iuQ1I8u1JW1ypeVdVrH7k+4iJD2etLLnxZbZM+8c=;
 b=NbPMhWHMMje9qjLgwE9EFMwFfgXPx1wAfh0H7LOmk/wYKPKkTTMZFiXuetGRRyNSMv
 WYIIfs0JdsN32rz6FCybuE94qqlj6bdUzCtqXdRxIxFRGfnUNBYUyL9pxwx+DHH1+9jX
 Jjff98UVvemG7PBJ52r7S7rNjQEMsv3mgajzDcaumrFMnHwQVO7fCHqo56kNzsToPG5V
 uprq9n9jV0k2/prEIWJSvamBkTlbFSnQ1X2UBxHHbOilgDhR5AyEbuvgwmo6wmJqYtNN
 S91JX0/9NEz6uWfECcdDXBp5y9eylaSpLi5IHrf3/gqut6b1UBZtY28HbsgYQ3FmTB96
 u1eQ==
X-Gm-Message-State: AOJu0YwzvPzy0uUcUQJOVr8LBqPIywD8Rvo9mRqnEc/1YA+WM1p7jqC0
 lX6uNs0mDBA/RdERDkkXgsxlVqM+pExTJ7fXzcNxK6Q/xrz8My8uqYezEe0aHGH7LK0WFZoguKL
 wusNZ
X-Gm-Gg: Acq92OE0Rv/wY3xC5nFLulqIuMQac0HlfdSTWGYFlnxtmr/cQF5UcksM7vJ1pFgYxK/
 aafHwhh76B8qqAc3za8Xyz/dlIYMnpgcmsyKaBY6N7i5CuHQij1ruJsMwpibB3b0zIDwMlPCBaw
 tFhp7km1Ot8TI4qAZU1qi1atirvvbfMcojxYZNGqI3VL91188RL7MTOKm2PC160TliR3KGeDqm7
 dATkTBk+O78XcOPSvskkvQS8GwBw8E/iNlO6UcIz73zTq/+QaZZBqipNEiF82nASTv4aNFfhuLr
 Tjg2rjuMLseO/ZWsX9zA+Sqm/51gZRtZJ+/XkveJQ2YFJu6/IwpM0tM+7eC64Hj91hMSYBgz+cX
 ydbquBTbEZ+IK+WVdV0tJhNAs/Gn9OcXAJGGCKYnKPD6Z5+MVVIFwYlHuNAkLiqdbnaajbkF4IQ
 btM1sSvSvpMve2o6hauqWFhBe0dcXUCz/8MDp17eWbE0RDwnqkqHDG389wnmeBjAR+
X-Received: by 2002:a05:7300:1481:b0:304:df0e:9db0 with SMTP id
 5a478bee46e88-3093a8ebbe2mr7214088eec.15.1781546757555; 
 Mon, 15 Jun 2026 11:05:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm19159002eec.28.2026.06.15.11.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:05:57 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:05:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 08/20] net/sxe2: support statistics and multi-process
Message-ID: <20260615110553.67333ae4@phoenix.local>
In-Reply-To: <20260614092328.201826-11-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
 <20260614092328.201826-1-liujie5@linkdatatechnology.com>
 <20260614092328.201826-11-liujie5@linkdatatechnology.com>
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

On Sun, 14 Jun 2026 17:23:12 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> - The statistics support includes:
> - Basic statistics (ipackets, opackets, ibytes, obytes, etc.)
> - Extended statistics (xstats) for detailed hardware counters.
> - Per-queue statistics for both RX and TX.
> 
> The multi-process support allows secondary processes to retrieve
> statistics. Since secondary processes cannot access hardware registers
> directly, an IPC mechanism is implemented using the DPDK MP API.
> 
> Atomic operations are used when reading 64-bit counters to ensure
> data consistency between processes.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

The software stats do not need to be optional. You mentioned that they
have a performance cost, but that is because of the choice to use atomic counters.

Atomic operations are slow and not required for per-queue software statistics.
Even with memory order relaxed, the atomic operations cause a locked instruction
on x86. Thats what you are observing.
The DPDK follows the pattern of BSD and Linux kernel and does not use atomic
for software stats. When using per-queue statistics in some case, the point
in time measurement (summation) will be inaccurate but that is ok.

If you take off the atomic, I bet the cost of doing the conditional branch
outweighs the cost of simple basic arithmetic operation.

Please have them always on, drivers should only have options when
there is no other choice.
