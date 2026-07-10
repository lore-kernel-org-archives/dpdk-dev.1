Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02ABB40611;
	Fri, 10 Jul 2026 23:34:39 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 96E8B4060B
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:34:37 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E9DC51D000F5;
 Fri, 10 Jul 2026 17:34:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 17:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783719276;
 x=1783805676; bh=zdmy00i4W7hcMKTM86Jte7sKZ6w3YeRTQ9zJ1VH7Mlo=; b=
 fy4NRuDUdHxgqIBGsD9nkgMNMLn0l39Mioe5fc7dxLCvKJmZpU71QsmZbkS2nFEa
 hHqiV/kZLKRbOATdI0kZrw4KsTWfDpKvHF1SUXah7weZ84cWu4ms9d3AUR5SZ0uc
 2xfP7BmpoURPYMa/OCmUOVaZqG1qtqfFtq67tQTwJKD3fqdzCmb/lAdaVncpez8n
 0/z3qU2vl34NNZy0Q4RCyEFGB4tZRkLj96F8HziCW/sYoVcjMTxgFXW9CZI4naPb
 Ajsp8F0amvwIWwKspzp7eoAKr2G12aBlkGO3Ai4caNP5Ec0RXAv3ftmYVg+90yBV
 ikve8VamqASz9YKHzagPoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783719276; x=
 1783805676; bh=zdmy00i4W7hcMKTM86Jte7sKZ6w3YeRTQ9zJ1VH7Mlo=; b=b
 9PmxRHClZzUQSjhnmjzBPTODi1ojx9a8BJ6p2p/XvkqMH9wBSg5UYcmjyYs42wdm
 Xf5iM3zT6NpayvOH7F+ryoxKNC5S9/KG+pytgZFkemxppZXkXKtY3S5bc45uA/A2
 OiFs2eKXInNWZAwq1GnO2xPrRgi8wrtm5d6NbK0oX6LqG3uj6WlY3mVtzZQJCS77
 /QHfProEn6C5u3tPkSHn4cSGf4mqreCd2vBlkcZv/Teqq/NxQe5UalPZFJ+w5QSR
 kuGxXFwZhRIEKE83xMO/8xIG0bpNSSVvZ+WxF85GY/W9IjMKZEH0gK2QQGqInL3N
 oeKDR54Mh0Mc0ATFSW0HQ==
X-ME-Sender: <xms:bGVRavYI2awJaymM5sryHnF0tjWk9LePCWLGFpPTcTNYx_Yab7pAAQ>
 <xme:bGVRaqvB6O6H6i5noQd94QN8M47Ao9GEIbR-vry8Zt9KmrXvpf7miJIdhgYBrWU8T
 YWZzzBn0rXgO4t3y9DhrrjP0oWaPhkkPS38bVwSKHGm4gDcYTwxmw>
X-ME-Received: <xmr:bGVRakshvbmA4hrRbr5bBetd4jtSCXswAKELefMKhm2a2gFyGEzg3VEzrfAN56z-Pay6SHhk5BW1PKUtAEUtFcryYA>
X-ME-Proxy-Cause: dmFkZTEfYzG/RyHbzg2w0IAwxPZBbRQQPY34xTCxx6g5n76vFLoeZAG6xHI76VOl/fpyu3
 HIowOkRg0P2wl/lgsGL5Kj+pJeBQPdQXeL2o9HHTpedaZKUwh+zpMwFXbiDjB7wLOVADKk
 ZIHDOv1rkNIJYXmaAF3swgLpSbZoANNVSAx4UwOMY0AyiTXjya56HCK237bQLIVLetg78o
 8m+lQQiWxKU3PA5YftNA0zmfb8LIalFxdtRx0Q1IqtleaAIqG4M75cWUSgO1d3HL0BTTMN
 GT797Qlsn/bCSzkgZqazeNa/+YlifnXXGiyAv8mFSgyCP9K/2gbSaQaV/3OfpuSZ4LA9dW
 DkdruyA/MIvJmRC8pMFmsta6DgndxS64XfR1EXnIfsh9T9RbJV82icxmsvFyqtrk60CG0O
 NLofjnH2IYtQyQPQunuotGlPOz3ht+Dutse+TAMUZAT12nj2UJca7ZmJ6v+iagnoY8qkQo
 19uahVO6Uk3vhwStlOqBuyc0B1hU/RONCsL1hUquwpC630e27kc8sGKo0ND4rmJIdn7VFG
 3vJd6xM8Tb9T+OiofTmbNzvsa6b60s5QCAR5ePbgbf0qhyScb93KR3qLCUBVwmHGEfX5VW
 hD57Cc8m649V8lDgU8MO8v6zBSdG7V5JOy9kkjj/GCLy1fdwNxa8ztZ9fx2A
X-ME-Proxy: <xmx:bGVRancuKJVOTTE6VvGNQESCPY-pZ3KxhTtH2rKaf1yrDpuIYk4YPw>
 <xmx:bGVRatao19dKjBcI786nb2c2fO_NWoVxaKtD5imlZgCIzQKShvBzuA>
 <xmx:bGVRaiVwpQnuvUsR6RXEtP6kMJjzwxhZdBd3G7eBuqU41s9TGutMAg>
 <xmx:bGVRanh7FCDKi2nLCrHchrTL90a6NR5aQ6wevoRBANTMF3rffBoc6g>
 <xmx:bGVRao4_bxtZDlUAE6bN8i8kXw_IUUEEkUlIl6iWg5UPTkDJktCSLkO4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 17:34:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/9] Stability fixes for GVE
Date: Fri, 10 Jul 2026 23:34:34 +0200
Message-ID: <rQxO9MhgTJCHb-xjHMYBgQ@monjalon.net>
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

> Joshua Washington (9):
>   net/gve: clear out shared memory region for stats report
>   net/gve: delay adding mbuf head to software ring
>   net/gve: copy data to QPL buffer when mbuf read does not
>   net/gve: validate buf ID before processing Rx packet
>   net/gve: set mbuf to null in software ring after use
>   net/gve: free ctx mbuf if packet dropped after first segment
>   net/gve: increase range of DMA memzone ids to 64 bits
>   net/gve: don't reset ring size bounds to default on reset
>   net/gve: restrict max ring size in GQ QPL to 2K

Applied, thanks.


