Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D4CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2273743366;
	Thu, 11 Jun 2026 19:31:05 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 01F45427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:31:04 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30807ba471bso321251eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781199063;
 x=1781803863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqVjgbvH1PVjpsb1dTSUyHrue+zW45mPe+su/3YKsIw=;
 b=V4wLSSTIoj52WM0spae+u6jXM2P5m0Uns12Ut9tIC9JIyEN9hojIj43I4YAvEgzl3B
 9bmz1NGBycviW8WeQOs9BUPZsk4+eWqw8fPjEMLB1z/zfTCEn911zKxdmS4Mu2pyGIDA
 sKzcc7d5PDHFSN82rGcZjtwrdAxrK82um1/UoJHLdMntzRBPCfaSxpXrj8DQ+j458lZp
 rECNfZLWsq6Uh1C/i11sU3tPhJ90LA7zJAKdwo0dANsYF2Gyf9HY9hwK5ryibxHy9EgJ
 3i8IEdld5WgMzYRwjVSD5yfIRYorvSbu+NKm1nlyaRavJu8CB1GMH8C5K35Ua8Hof01w
 Zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781199063; x=1781803863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oqVjgbvH1PVjpsb1dTSUyHrue+zW45mPe+su/3YKsIw=;
 b=k9ue7euHgETZPjSDiAnz9cbtjymzh1eoHOxyK3dkF5Vwym8Lal2NblbbM+i/54TDmX
 x04wz91vkMeUfy8ybaa4Tu9rE1cGYcacH6Cg/vzwcJld2Z28GU8J+/dRDVXIPQKAg3wh
 hoVP1C1GaQ8f8iVSt8o+sMIIauK57xsTIpZi61oWsZ4JPTbS3tzRQjAkAT7doCMmmrz7
 yKAZ3oVETvvdgJeK+FksC1GXM+xLp+T+E51DbwXDp0jimS17Z3bQJIogKVb8bJXAoztm
 YFmi8QpDQQ04AETBt8EQrDt6cdimegcUFPeiFAttMLp7NZB3Ke3VDL25dVzT5iqYpq3g
 y6JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0ao3ucTOTEn7+Tu2XzhFkMvgjuKuew0q3QfJepoKgmwiuv4Dp4JY1PiyqwwVXiPV00z4=@dpdk.org
X-Gm-Message-State: AOJu0Yxw/fQnjed6UKIyoPqnrssovwJMyoc3TbcypDgbj9JBXu+1NK5D
 iO8R3sQS23r+RYu1kTfW9oqqy/6s8gVloCKtd4yjmCYHVrOTM+SKnXzGFqpsOLWN3XM=
X-Gm-Gg: Acq92OH9NiuVmkDfH1j4NVz4XipkO6h5Ph6VLtOfQBMeu4imuz+T7OhwMNBysei2e/4
 ywj9K/li4u5ep3yQ8XZ+ww6APq0Mg6Kll7qIvd7oUFODI3QPWni48TowwyzNeJ/Bqae8I1Xh+fN
 bzPrw31YgsbPIWmQsoCXimH5aKT0LzAUes4qQQo6r/x8Cf0VpLoCi2qCtnBtjD8/mVjM9JK7yNM
 V+fh+PrPXln3hELucstKGp0wR9d3jfRGJEM+o7KxMicgbuvWe4kA+p7WlkmevsV1Dt/usiOhBsw
 F6/cE7kQmY5wRm0ofcXHm13Uc56lv/L4qYgnSFKA9W0XJcsEJeb5g1/aJ83DuxGs1rwLWw+3R7t
 GjUlo9LLFBj+xOx4g4DvGogE5lzGq969QyzJ9QS2m6ZFiSQZkOTy+/aMHmXkE/7B51lYy37b39L
 1GQvQ5JvkM+OlUiwGidHsKgm5mU56u630MFwp2EgHDpRFHOXCiC9bFm577QalCj06ezEk0rm3/P
 /w=
X-Received: by 2002:a05:693c:2c97:b0:2d9:6373:ad22 with SMTP id
 5a478bee46e88-30804819c1fmr2653857eec.12.1781199062862; 
 Thu, 11 Jun 2026 10:31:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c2f0acsm3691013eec.1.2026.06.11.10.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:31:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:30:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org
Subject: Re: [PATCH 9/9] net/dpaa2: drop the fake software VLAN strip offload
Message-ID: <20260611103058.160842f4@phoenix.local>
In-Reply-To: <20260611154926.392670-10-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-10-maxime@leroys.fr>
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

On Thu, 11 Jun 2026 17:49:24 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

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
> ---

In general I agree, but you overstate the impact. Any real application
is going to look at the mbuf anyway. Relying on testpmd numbers is BS.

The NBL driver does the same thing.
So does PCAP but it has no choice, and is slow anyway.
Virtio/vhost does as well.




