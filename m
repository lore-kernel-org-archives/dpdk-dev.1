Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94662CD98E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 14:11:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74CB540289;
	Tue, 16 Jun 2026 16:11:17 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 42E564026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:11:16 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30b6dad2382so4540421eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781619075;
 x=1782223875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Se/oUxAt2eWW56TN02rrS7qvLjeMgJ9/Q4TDg1/jOnQ=;
 b=pmuBaFBzzQhovF/ZeJFgIiRxCcoETQPDVtTYeXmDYXFpTrxhgNh7zQaleS6DTNoJMH
 r3gIlRFujLh+37QugPeOG0UXr8F0Ll/oXI6MQm4HEu1cjJZIAoQQ8s1pBIv8myiAEYlf
 YlHnmvP0+7EJWm/PpJyWas/dC+zrPsRTez42bRg6GlmaALjofulQ0zjJiRv+bTjBe9+g
 tbr5MKS6xHgA91o9vOT4PnA0evj03OZkh2MlhBeEe/IUg9JzONRG+U/0aTpYbfUCDnUi
 BO7EDZIYTFuQVhY4cqe8BFgz2x3ILRjzOsk5fhQX+hpmLk1l1L56BMzkPPCryfIkUlYV
 lCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619075; x=1782223875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Se/oUxAt2eWW56TN02rrS7qvLjeMgJ9/Q4TDg1/jOnQ=;
 b=c1zwVBMTlVR4Ck1Dc43lOwSah8aqz/buBs+GOHQbo/Rl/UF1Kqid3haNkvapk30UGU
 WxARWzEgQ0ImL1QIWSPG8+VAhj6n3UsIw5shHOPepDGm6iN9Kabu7J3OOlHwesGpesHI
 RWHwNwOqQs51eNc5f/PmBUY35Cc2PI0aGKH8FX8rxrzuBKAnnYEUrW05igkW7luYwrgf
 ZKpbAMJ5MwUZcl6NsVgszVY3PB3P1wvoQGd2KqT9OHCzbzosoIDo7h4HfCC4q3OA3DX7
 D7gk58cv+Gw8ZRZG/nUU+KMFnH/sJqQFSPO102xKrISSrZw89yVzqqQ7HfEsOOGeYFfa
 andg==
X-Gm-Message-State: AOJu0YzoHHuPEVn+shOoHdZqyVa57dBgem1jyOop46C45n0tn3oTyXr9
 IFIep47DQkWFX/iMBMj3fTepnZ86M+CxbmPeMTvdv0fIYLBX+gXfSZVI5r+6BYq4+bQ=
X-Gm-Gg: Acq92OGgKuG9VMHrFnxXwMki0rYuIMZmpRdvZsd1VGfBbZAvo3f12eMJnXvE+NUHHc+
 geLqh1ASKGunlgLSq0ywqYCv+fCZZqIIJtP47N2+FmXRHX5KHlb7vSZus4pyMkmWjc3SHET3leJ
 h2Hs9AVU4dpzkcFoBxr1oA84hlrapDAF8OhxVUEfCzSy/Ixx4VZYSocIKK91d9AhqSSmviEvmRE
 dZaY3fCfxPnyWqcU8mpGra3MnH/Eb+L0ht7QtdYRkMzrqsz6Lq4HEd7qIKWgZ+l/ukKHiYUCcO5
 U0K6HFzmkwMmvq8fqix2hSF3B4q1FPkiWyE8Uq3qhgAREjiIpRDg7KHoOcrXI+ueqbl9DXp+ubn
 8tQJ9YjXOu4MIT1QEkAtkbsdKtybE4hvUIMVKNo1Lpr7y0qwYzXxHtwnk1/l6cVzcqOJ2UhsnYI
 DShPRTkPUstjH/97YjFMr/nOae6p3UgkSUqDc1grYxiiuHzytb+W4In4xBU3xYxbOsF7dNrVDii
 5A=
X-Received: by 2002:a05:7300:a509:b0:2ed:e12:376b with SMTP id
 5a478bee46e88-308200db1c9mr10234876eec.33.1781619075097; 
 Tue, 16 Jun 2026 07:11:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0849sm21206233eec.7.2026.06.16.07.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:11:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:11:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [PATCH v2 6/6] net/dpaa2: drop the fake software VLAN strip
 offload
Message-ID: <20260616071110.1baf1beb@phoenix.local>
In-Reply-To: <20260616102727.708948-7-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
 <20260616102727.708948-7-maxime@leroys.fr>
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

On Tue, 16 Jun 2026 12:27:26 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> RTE_ETH_RX_OFFLOAD_VLAN_STRIP is advertised, but no hardware VLAN strip
> backs it: when enabled, the Rx burst calls rte_vlan_strip() on every
> frame, a software op masquerading as a hardware offload.
> 
> It saves a forwarding application nothing: the datapath reads the L2
> header anyway to classify or strip. The offload does not remove that
> read, it relocates it into the driver Rx burst, where it is far more
> expensive.
> 
> The cost is a matter of timing. rte_vlan_strip() reaches the L2 header
> through rte_pktmbuf_mtod(), which dereferences mbuf->buf_addr. On a
> freshly recycled buffer that mbuf cacheline is cold. eth_fd_to_mbuf()
> has just written other fields of it (data_off, ol_flags), but buf_addr
> is a persistent field it does not rewrite. A write does not stall: it
> posts to the store buffer while the line fills in the background, and
> the rewritten fields are forwarded straight from there. buf_addr has
> nothing to forward, so it must be read from the line, whose fill is
> still in flight, and the read stalls. The ethertype read that follows,
> on the cold payload line, stalls again. Read later by the application,
> when the fill has completed, the same read hits. The offload just
> performs it at the worst possible moment.
> 
> Measured on a single-core port-to-port forwarding test over two 10G
> ports (one core at 2 GHz, 64-byte untagged frames):
> 
>   - throughput 4.22 -> 5.00 Mpps (+18 percent)
>   - IPC 0.93 -> 1.25: the cost was memory stall, not compute
>   - L3/DRAM-bound L2 refills 319M -> 200M over 10s (-37 percent)
> 
> perf confirms it: with the offload, the buf_addr load (the cold mbuf
> field) and the payload load account for about 84 percent of the Rx
> burst's L2 refills; removing it, those vanish and only the inherent DQRR
> dequeue misses remain.
> 
> Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from
> every Rx path. This is a behavioural change: the tag is left in the
> frame, so an application must strip it itself, on the L2 header it
> already reads.
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
