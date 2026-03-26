Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0720C10A1E63
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:31:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E7640297;
	Thu, 26 Mar 2026 19:31:59 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id C751340274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 19:31:57 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso1269194eec.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549917;
 x=1775154717; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32LUcQCcok6FuASz+GoVQCN+MuWre/qU3kTLIlMXDRc=;
 b=3BZW3aTXZKKDCAc2PowOCFFwPGzSMTW0+lv7tJ7YJoWUvPBFRCJXmitdc4vtF6DIZz
 LAZ9apIi8YcmRv3LdIJG5wP0ihykjYD91lsBkm9slB6dglf0lRa6XCc+KMiL04saKWqX
 z/nGb3fF5Ym4g0lBZ7n58Y80e97vYhwz7VlJ5t5+3nhgWy83gVXUz9RglkcDIhRtPcMG
 LYaX+NcwGgwZQ1zfO7RBFfGJW8UIWy1iko6Vl/e+vIbWsQKTju+B/IQuI8P9NHMBhgiV
 9I01PQSlI9oqFnWRJzUA49HgCpq1fotz64VyQixjLEDPbgo7FStSBVVZyhYL6hZlbLcB
 FY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549917; x=1775154717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=32LUcQCcok6FuASz+GoVQCN+MuWre/qU3kTLIlMXDRc=;
 b=XhVT4DEbb86vFSgL3LlJS/XBW8ETjnzFfwhLGQFg7oodOVwX61bzFAkHaqTAsscHjR
 kmfxGMdZ/f23kkISLMIzlsSqSKWMaVdx86rjoTOPRuHMOL3jzSApZDBX1OSIutIDziQj
 mDkACVbvI60LUhr6Aw9DfysRUP4Ald5NtJRYCkS86IvXwhLlxvqobRuJJ2goX+zCF4GL
 g0kVsM0YuwhPQ+LTnMgcWWWnZhNQngIbppt8hvOW4VQio/1a+09H73oEjR6VMG4zu2tY
 yTYmKy8kJ/CIEYA0Bp1QkLuf/MhfgijRpEihdwWksmjXcs9wGxmi2qcVJ4hv+e0lc9Q7
 Vl8A==
X-Gm-Message-State: AOJu0YyYOsw5/nXMW6hGcMYziPmdcnxnMpWjC9yxd1LmPZNcaSiUURsz
 oCQF2Ku+AiTnjqefnsRU3NI43EIY9XjaRQCF8fVvbNYDSvIFKQhHVovaxT9GMTHCoTc=
X-Gm-Gg: ATEYQzwH3XWSnCwmqSrjyIDeUaWFuHvA9BcpFBU7mkgRSw++/KjRzOsdWKUgYXxBBOs
 1oDkxSvfCd8XRz85xwi0xvnea/GBmUMv65PGpZWY76y/9azoTEVkbbPZ1ps20J+UrVTTL1N84sP
 qfWcKtQIrZM8zzTj392D6li5ve5dEa85XFatCjzJWWDj69ql34oFzxTdSuQjHK1vPS6lnaNGP3l
 +N6MF8PVcdPjCPpAGte9xm8X++INO0ymUAUHd8Z76rbLR+VuFBeUzc84j+jIanarnmAG0iXAZgC
 2ENaBna0MhMsAPp2mHYY9byhMzoDdsvRoKBQKEcrQlDsEyICP+ort5db66O5rseAir5uUtvLoNi
 CpmWhgJLKPMGRQ97Pz2Hf0/xu21XlHgQgAyvamSmdtY7Nbpw3ltXt+p7pL/5lE8W1/q3xFlQz6A
 5MptwP9dE2lVJEiZx2SPfsCv5A8PzMDsCp8pb4RHLTdCol3Q==
X-Received: by 2002:a05:7300:a54b:b0:2be:1cb2:3a6 with SMTP id
 5a478bee46e88-2c15d4ebee2mr3907976eec.33.1774549916756; 
 Thu, 26 Mar 2026 11:31:56 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec7f9c9sm4189550eec.12.2026.03.26.11.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:31:56 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:31:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/tap: fix close for partially configured port
Message-ID: <20260326113153.2bb2ef02@phoenix.local>
In-Reply-To: <20260326124612.2580985-1-david.marchand@redhat.com>
References: <20260326124612.2580985-1-david.marchand@redhat.com>
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

On Thu, 26 Mar 2026 13:46:11 +0100
David Marchand <david.marchand@redhat.com> wrote:

> In case no rxq has been set up (like when starting testpmd with no mempool
> drivers), a crash happens in tap_dev_close:
> 
> Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
> 	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
> 1111			struct rx_queue *rxq = dev->data->rx_queues[i];
> 
> (gdb) p dev->data->rx_queues
> $4 = (void **) 0x0
> 
> Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

It looked ok, but then the AI review spotted some stuff...


Two issues:

The txq variable is declared as struct rx_queue * but should be
struct tx_queue *. Works by accident since it comes from a void *
array and is only NULL-tested and passed to rte_free(), but the
type is wrong.

Pre-existing: the loop runs to RTE_PMD_TAP_MAX_QUEUES but the
rx_queues/tx_queues arrays are allocated with nb_rx_queues /
nb_tx_queues entries by ethdev. If dev_configure() was called
with fewer queues, the arrays are non-NULL but the access is
out-of-bounds. Since these lines are being reworked anyway, worth
adding a bounds check against nb_rx_queues/nb_tx_queues. The
tap_queue_close() call is fine -- process_private fds are sized
to RTE_PMD_TAP_MAX_QUEUES.

Also missing Cc: stable@dpdk.org for a crash fix.
