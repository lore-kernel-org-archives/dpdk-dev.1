Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A2D46BED
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFFCA402BA;
	Thu, 29 Jan 2026 02:06:20 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 2CC3340297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:06:19 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so380376f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769648778;
 x=1770253578; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fwlt3pu3CXRdW7LkKVa/jTk5zSr8rXscZdecpD12E6M=;
 b=ZSMKge77gmAZe3FBPOuoANk33ZOk+SyRAbw92DmDeRYMaHIRWTZ4Ka8DFRt+tmNlpW
 nmHyKtQ2XSxbV3nIrDYrJ/oNFFMowdyMDLTmMPnWea+glwtDSn3jp281vuhoyzAVvUuv
 bEd16cC6qsVvRUoa72EJ6jo9sjzflYl+FvXZ+NsHHQhzPzW/dtnkLnZqjpZY49sbOkQF
 0fzeWn69Ta8STidMXlo+IyxxL/W7AixJkYMQKHCu5s+wppdmOVIGVQWKunOaN7l4E3KR
 AC3HISX5cy4k36dVrx5Di0FtfYsxtY57Rrhk2N1m6jcR6h+QZKBkU/nyk4M4iAZHaLYa
 63Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769648778; x=1770253578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fwlt3pu3CXRdW7LkKVa/jTk5zSr8rXscZdecpD12E6M=;
 b=YcF2pAjGC4Lga1UD2FPPFBBYpABvvsk6w1JJ/o4iH7+ZXZLPfOTDyhLt4AyMvAgNuH
 yV2FTWKkXx/AJ0rVupnpofgT18H+F3ncIf6NMK0m7QCIriMMRcmY0H9r8b1NbyQPbz5E
 19e5ZWL+XhsBZQRjBNM/WzoMSwBYaqL/TegNL50bhjNVqJjoSoVhKZ8o+bUpV89GR/+J
 /btb3/RSqScwl1OTF7wsYTSwo6JwwJcTVIoz2STEEAFPpJdFXgJBolssVd/i0Aw4G2vf
 lr6cqbHBzm70UumIAAV1A8IgKMs1nCNhO8nym0uSs9kUSU7HJIPCvDH2plJFlu8wGJBF
 zYag==
X-Gm-Message-State: AOJu0YxysNqykZaqhZLw4yOkOhA0hqGiMuUQNBx5aRYh5N0EvzfoGDqK
 FaRtBAgHMcTA2sEgfu6eizZqn+fuUdZqvNsMtC2Pp4P7kacO45dbRV+B4n7/HPDmXkL2Ml2p8db
 hSDML
X-Gm-Gg: AZuq6aIfPT2IT+cMS5LEFD0RXuqud/anUBlvAFYP5DIlRxl66/HXEHIE21w1/owPIzx
 NWYUzH1peEfMvZq2q4acp5Syo0Wfnug5EJYL2Q0hoLuzZfhNFqMweK8QFO0Q4O3aNcT+Dd1Z4rW
 nh7uExAFSMGIo0nfcWUR2LA3ftvwM5xdk292ZjkOc5SO69Ifz5dsdhE+hnijqxZ6tkPUUBhchcT
 MUBRMAD/ctF3mfSUa05ocrr3alIRYuRrQCJUucpwEmUHaQ+BhRYqU+OcX+NUuHDGKzuAwkZh0/E
 JI9J/fNWiR166Jwv7UAWOyosXAXrK2gD8vqW9rC52k69hVz6dLllZFkmCHzlE9MdH6EymkeW5UB
 oPAPsUDMDzrVBWtEj9InQb4MEiDJ5/CMycg42Wms3n/4RqLnH0fg+qdADI46AAIFIMwWUY0VTyR
 v0+6ZIsbwQvz29TLR0xgrrEFT0we5sBfY7l8HBoxrb8zj/MMeKDRCAnouZ3JMC7Ic=
X-Received: by 2002:a05:6000:2582:b0:435:dbb8:c5a6 with SMTP id
 ffacd0b85a97d-435dd05be14mr11489386f8f.12.1769648778076; 
 Wed, 28 Jan 2026 17:06:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm10210146f8f.25.2026.01.28.17.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:06:17 -0800 (PST)
Date: Wed, 28 Jan 2026 17:06:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
Message-ID: <20260128170612.648cd657@phoenix.local>
In-Reply-To: <20260128173138.151837-5-stephen@networkplumber.org>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-5-stephen@networkplumber.org>
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

On Wed, 28 Jan 2026 09:30:20 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Implement the single/dual/quad loop design pattern from FD.IO VPP to
> improve cache efficiency in the af_packet PMD receive path.
> 
> The original implementation processes packets one at a time in a simple
> loop, which can result in cache misses when accessing frame headers and
> packet data. The new implementation:
> 
> - Processes packets in batches of 4 (quad), 2 (dual), and 1 (single)
> - Prefetches next batch of frame headers while processing current batch
> - Prefetches packet data before memcpy to hide memory latency
> - Reduces loop overhead through partial unrolling
> 
> Two helper functions are introduced:
> - af_packet_get_frame(): Returns frame pointer at index with wraparound
> - af_packet_rx_one(): Common per-packet processing (mbuf alloc, memcpy,
>   VLAN handling, timestamp offload)
> 
> The quad loop checks availability of all 4 frames before processing,
> falling through to dual/single loops when fewer frames are ready. Early
> exit paths (out_advance1/2/3) ensure correct frame index tracking when
> mbuf allocation fails mid-batch.
> 
> Prefetch strategy:
> - Frame headers: prefetch N+4..N+7 while processing N..N+3
> - Packet data: prefetch at tp_mac offset before memcpy
> 
> This pattern is well-established in high-performance packet processing
> and should improve throughput by better utilizing CPU cache hierarchy,
> particularly beneficial when processing bursts of packets.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


This and previous proposal to prefetch have no impact on performance.
Rolled a simple perf test and all three versions come out the same.
The bottleneck is not here, probably at system call and copies now.

	Original	Prefetch	Quad/Dual
TX	1.427 Mpps	1.426 Mpps	1.426 Mpps

RX	0.529 Mpps	0.530 Mpps	0.533 Mpps
 loss	87.93%		87.98%		88.0%


	Original	Prefetch	Quad/Dual
TX	1.427 Mpps	1.426 Mpps	1.426 Mpps

RX	0.529 Mpps	0.530 Mpps	0.533 Mpps
 loss	87.93%		87.98%		88.0%


Will put the test in the next version of this series, and
drop this patch.
