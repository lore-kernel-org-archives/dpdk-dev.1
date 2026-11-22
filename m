Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DF606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JGQ7jDGg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6372240615;
	Sun, 22 Nov 2026 19:04:23 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTPS id BC80240395
 for <dev@dpdk.org>; Sun, 22 Nov 2026 19:04:20 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2f041f88577so13446365ad.1
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795370659;
 x=1795975459; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3tvc4D2ZGbWX/0NJRlVEKvRy1/rCXVZXIoPu8vHLUJo=;
 b=JGQ7jDGgDGcvOkGdriWLQR98iAD3u1x+jrjBI15Y4dhWirDbYzj+9DQFckm6+zjPHt
 DiljXt4FVpoYHGUmTiGpH3Ae+NIKJa7UnG6QtHvfouLG3J/OMdI+I4D+P1Ra/mMIAXsn
 i9JhIcD5hcZ/09+gy9hJlPWZhebTRChxFFbCyGJLXgcWUesT0v/C3Nf0fA7Yavw/krkC
 oMh5SxuK812tpWcNhTaEIZ6ma5QtxhMm4iJDBUhe3e/QoFCJIy2+hmtfISuHY9zDgrVY
 2SghpjuVxmWBufyTIk94VvBiPiEDG0L1XXs3jg9HpDrwqgHu7unXGK/5gH0SMUqG6VsW
 N3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795370659; x=1795975459;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3tvc4D2ZGbWX/0NJRlVEKvRy1/rCXVZXIoPu8vHLUJo=;
 b=ZfeG8xWoO+fDxCDRk3ifPJUAf1UL5kyPS9PtWzp9sfEhTePlkx4roPZ5/42tdXrTi0
 voiWsSEnjUpawSjx6c/ZxQ/DfsLkysRiXxs4vvxvZzwmbnG+i7+xEaNTAG3utasjGPws
 pWnpZafEHJRFW7kabqwYrmoGe/nwRXm64/IOtn+BjXHZBUbxRKWABvEdsgEYqFSjaXwp
 o5Jf4x++txTHc5ZRITbAkJQH14cxfIH7/8kc1NI3tKO0H9vpYdn7kBb+VS6rBbWA5OxR
 sLJcg78dDU55ertqngEV8qm0o6ypqRnhl3wcLKKlEqV9rgKKC//ZgFIBNxgfAaqs6467
 ViQA==
X-Gm-Message-State: APuU4Z/U6WFMxoMHKJWbuJ4BRMs4qv96MTMEsGZXAWZRnKxXSLDbUUnw
 OtJJbRIAKDNFwflDvq8fdAS1AM/LdviBgj/P7teMmXFqNipxEARTHu6MjrQsZSdrz6YsOBSplEx
 GT2+5DEc=
X-Gm-Gg: AZFdTZfji7Pmh9h9ed0eRq5wwQqClPCkhkQHshYOtsTFovcIn8eJo8GGoQ5LRt42/Df
 GNK2nZ0YhPWAAvusuxwfxuGAPrh5K52P4e/uABOm0qSsGV3Gkt+a2afXl2Ce75TtawPphvOF7lz
 yaIXA1xmz118gdCeqhmCClbxNr0Dp4hu0xnnyINQ4azZmI/Bw2ooVnhfzodKF3e9ZojE/9FBvAY
 +1aINxmuNVt/LPeKQK1p0lpEN0G3aGoyeUvO36I2j/1q8DA1up87+n6O95mHcXTppiT6EQIo00B
 /4WHrfEYUHCiat/DNTx8jzG/Fkz1lMfVXddcObFmn5lk8Eq3Rk8tSRzDaz59RPCOaN8rBELinww
 44qNo1F55IvG6GlKuOT5iUhEEgDetHFUmY2iVSjMgUuqUZH7Sheqcx/c+8KafyVcCMAu2U+xTKN
 /UxRMlLXyxqYfDP0maUJRpXxZXdq1mttdTeF6vP4tmJMMWYamISKaLUB61PKenYyMaeRmeXr4ak
 OJNCGw9zzYre7LWaWcE+kA5daZCH/cImCc2lmcbnmgQ2hG4Kr6P3yjn8r0NNSlzKM4AkIl7KDcv
 79pAd5odgvvs3CTB/tA+T344ak1jpEreX1dcxQUnjn/6aHR5Ay/yeXSKmMcJ1bivMQN9QXU=
X-Received: by 2002:a17:902:dacc:b0:2f0:25ea:8fc6 with SMTP id
 d9443c01a7336-2f03f1a47dbmr86202055ad.28.1795370659229; 
 Sun, 22 Nov 2026 10:04:19 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c1a69sm38587815ad.18.2026.11.22.10.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 10:04:19 -0800 (PST)
Date: Sun, 22 Nov 2026 09:47:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, Joshua Washington
 <joshwash@google.com>, stable@dpdk.org, Harshitha Ramamurthy
 <hramamurthy@google.com>, Rushil Gupta <rushilg@google.com>
Subject: Re: [PATCH v2 0/3] net/gve: fix GQI Tx cleanup and QPL FIFO reclaim
Message-ID: <20261122094735.2e406bdf@phoenix.local>
In-Reply-To: <cover.1794908231.git.rnwolfe@google.com>
References: <20261115140016.3830109-1-rnwolfe@google.com>
 <cover.1794908231.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 09:11:41 -0500
Ryan Wolfe <rnwolfe@google.com> wrote:

> This series fixes three independent bugs in the GQI Tx paths of net/gve:
> 
> - 1/3 clears the first freed sw_ring entry in gve_free_bulk_mbuf() so
>   completed or refcounted segments do not leave stale mbuf pointers that
>   are freed a second time on queue stop or release.
> - 2/3 fixes GQI_RDA multi-segment non-TSO packet descriptors to pass
>   data_len instead of pkt_len for the head segment, reclaims completed
>   descriptors when nb_free runs low mid-burst, and stops counting normal
>   ring-full backpressure as stats.errors.
> - 3/3 fixes GQI_QPL jumbo Tx FIFO reclaim, TSO pre-allocation space
>   checks, malformed TSO mbuf handling, and doorbell flushing.
> 
> v2:
> - split v1 into three atomic Fixes patches for stable backporting
> - free and count malformed TSO mbufs (pkt_len <= hlen) in
>   gve_tx_burst_qpl() while tracking nb_sent separately from nb_tx so an
>   invalid TSO request cannot stall the queue at tx_pkts[0]
> - use for (;;) and add the missing blank line after
>   gve_tx_reclaim_fifo_qpl()
> 
> Ryan Wolfe (3):
>   net/gve: clear first freed slot in bulk mbuf free
>   net/gve: fix GQI RDA multi-seg descriptor length and clean
>   net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell
> 
>  drivers/net/gve/gve_tx.c | 78 ++++++++++++++++++++++++++++------------
>  1 file changed, 55 insertions(+), 23 deletions(-)
> 

Applied to next-net for 27.03 merge
