Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB4EFEEF49
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82EFE4028F;
	Tue,  7 Apr 2026 16:14:37 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 070E640265
 for <dev@dpdk.org>; Tue,  7 Apr 2026 16:14:35 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so12695299eec.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775571275;
 x=1776176075; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hjHlX70BpKinvD4eb50oI+enLsgd95M7bQA04p+VtM=;
 b=NBSQFxFBNiV7ZgoT108VwmjPp2nedAd47jNCU67FBcW39S0365C/mcyuRv1qqCJzNr
 xzBZBVhRV7wr3JW0wp/b1WiDLq0Uybih0gjZBI6zQCljgGp2aXDZ0TI8VvXT/kuKKVCG
 YsDYDrGElKuP18T0aaNN5aLelyFeS6ccph0jDciyuCex6oQ6PXG3Gp3fGeCWUTUZSSrl
 7kNJvuJ+jQrpWIHRmcm1ifxrxTqmrH5YXre65RiFo5P6vWbN9FsOUcKN78nxnn/ctYxh
 iptcNy4t1gr7cZ2+4MLKxMyBbpVkrbI2pxeJ5b9aiHgZlE4vMj0GtCQ7U/s4XQriEkgK
 15GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571275; x=1776176075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3hjHlX70BpKinvD4eb50oI+enLsgd95M7bQA04p+VtM=;
 b=iYhV5m3r8PAJuD31nYcY6GUH51U7u815PuxXq3mQ2eE6ddwBEaluqSgCNLeDcbSrGz
 OTPUPOoE3Z+InlrZGc409DqMpWPebK0BAbZ4iyBn390V2RQVdlLVsftU7OT6RWW+MT15
 BuySZ/5zUWUlTefY2jBc5Wy1cNjgMPxn5fFSjHcpH98fntkdqgoksHDCt+Xsdb2KAX+v
 st2tj/dAfaGa/77kJ2RtuonKrs8/oEL016OFSZRglTPwe//MpAjUemz3vcSyRJ13s1Lk
 mj+6+u1IHuqyzKppf9bI7Xu1M/FSlFD+clqk8XCW4krPER0joKYSWt2FZZIbBXuun+UZ
 q9Xg==
X-Gm-Message-State: AOJu0Yz3K7utwL7EBmuSP9Y1S4Qd06G07M5JuUNLsrsKK0S/QgvnYAsZ
 jaJtrcPIqZdiiQOtRicqQC5nP7a9FInU89L9GIC7ebNzYNlwfH5GQ801FSYAnSjx9Yg=
X-Gm-Gg: AeBDievTS4Y8+bl6bKAh8O/jJkxt1XKnntNkOcehcmeaS6e3jV64hWkKCj95mzCa7by
 aIMTqQB126BI8GRLgVmIb4Skj7ZSE8wU35UTJdBAcReYP22YTmrBiYe3kMZpbrVIq6r+uqcnL1P
 d5hd1RrIH3MQDg3+5g1MRD+i2/UkzAzJiLb4MV4houbAMdiLBdDyIU+f0tuQtuzBVO8GAk7GHR0
 ohnb67kM5WNtNIxbT7wwsbYZb/c1q4Gks952oamG7+zcxh1IsHh91WWxTdTEvCWeIatksEpKDDG
 O9bwgwCjmgnt1/7Yvx6QtVz+2aCGzxDQ/q6mQFVwrQK1CDSDm3teOKbA2FaZaF980t9Z43wv7k0
 LC66GFHZX5Xz8SMGTZTtcA+Auvp59A9EiFkTpSZ26fn+foQzogv5wrU8inVL8vLH8wq5o9yE9Fy
 Cra3KSLgeLdqLl7OJSC/5cLNzuKnhCnmQ2gWg=
X-Received: by 2002:a05:7300:b54b:b0:2c5:347:e628 with SMTP id
 5a478bee46e88-2cbfbf77d5bmr9361406eec.21.1775571274723; 
 Tue, 07 Apr 2026 07:14:34 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20b2b1sm17209801eec.18.2026.04.07.07.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:14:34 -0700 (PDT)
Date: Tue, 7 Apr 2026 07:14:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Ouyang Hao" <ouyanghao@tencent.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com, stable@dpdk.org
Subject: Re: [PATCH] net/af_xdp: fix resource leak in eth_dev_close
Message-ID: <20260407071431.0809fb24@phoenix.local>
In-Reply-To: <FEA1D5B98F367DFC+20260407021428.620-1-ouyanghao@tencent.com>
References: <FEA1D5B98F367DFC+20260407021428.620-1-ouyanghao@tencent.com>
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

On Tue,  7 Apr 2026 10:14:28 +0800
"Ouyang Hao" <ouyanghao@tencent.com> wrote:

> The rx_queues and tx_queues arrays are allocated as contiguous
> blocks via rte_zmalloc_socket() in init_internals(). However,
> eth_dev_close() incorrectly calls rte_free() on individual array
> elements (rxq and rxq->pair) inside the per-queue cleanup loop.
> 
> Since rte_free(&rx_queues[0]) releases the entire contiguous
> block, the memory backing queues[1..N-1] becomes invalid after
> the first iteration. On subsequent iterations, accessing the
> freed memory may read NULL (or garbage), causing the loop to
> break early via the (rxq->umem == NULL) check.
> 
> This results in:
> - XSK sockets for queues 1..N-1 not being deleted
> - UMEM reference counts not being decremented, leaking memory
> - Potential use-after-free if freed memory is reallocated
> 
> Fix by removing the per-element rte_free() calls from inside
> the loop and instead freeing the entire tx_queues and rx_queues
> arrays after the loop completes.
> 
> Fixes: 339b88c6a91f ("net/af_xdp: support multi-queue")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ouyang Hao <ouyanghao@tencent.com>
> ---

Applied to next-net, added your email to the .mailmap
