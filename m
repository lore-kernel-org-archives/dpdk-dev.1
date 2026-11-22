Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C9606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SzuEtvMf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54D984042C;
	Sun, 22 Nov 2026 19:04:21 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C3FC402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 19:04:19 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2f04b676219so12173155ad.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795370657;
 x=1795975457; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3tvc4D2ZGbWX/0NJRlVEKvRy1/rCXVZXIoPu8vHLUJo=;
 b=SzuEtvMf/5WFoMf6JjPEZufsOrjVsw6vU030yTe6/amx5dALba2Pz+chjhxfcmwzfu
 lAQ4UUOBiJDgbai3NlH3yRvzcRE3VpfrB2hQZgKuarXVvuuni9G7VGVF7/du8olOomdm
 L1UM3LFXVOVYMVQE5ugenaYDwIRcHQ/yqdc0J/ZKS39DJTBHQpXv49K3buQmFSa1ortO
 iW0YGisO0d4JZHnNfA+rWIY9pjRXeTMkyVkbWYhN+fWBLraoIIxBoFgjLgMhiKSJUfjE
 MniSyzyk6p5kktCSSHnJ26W3I92nkts236Pfn5ID3grrVcRoW++85NuXxRXU9autWOdA
 aOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795370657; x=1795975457;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3tvc4D2ZGbWX/0NJRlVEKvRy1/rCXVZXIoPu8vHLUJo=;
 b=kQMKokMQKBK/zzDmdiMfU3RRVj1Ds+Z0DsIV4PhKQc1/pU9Bvj0pWEnvIBVTANYhwJ
 r1V9sheDJoST1BMpy/OlJCBLB763EdVHKC2cSn7YUFUpTTXhhVRR0kpaWJV+hJSE1oLu
 YsnjAEDBKgHviyorbsXucD1Vg7x5aZwWG4juVr5190P+5ZZeePBlVFYtX/lewHAW3Avm
 eXlT2HAZAsfjAPO8Z3CkX/C+ZWkpQNQZ3D2ldynfEGnpWfnN1MDv7s+1xmkLZ59NcUud
 x8F/cddIUq/jcdFhAr2PPy0PKGHVmS+TKE/H0nKl3mnRSuxiiTpkiB254dnFYGnUYnkI
 YTsg==
X-Gm-Message-State: APuU4Z+wMTNU2V87Wua5JrgO7XFpPF68QicwBIF38VlSFPRgKHjqMVna
 mOLML+SuasarRKWBg9rR+5BcF8RCa3D5j9tg7XjBtB5eA4rj73OctPy7Xoz5EABgMvQ=
X-Gm-Gg: AZFdTZdztWRxOQFgY8mfXwPHMRt79KAgrHtlHOxJMyC4QxTp5+f1JaAXAnQjmSCSFsQ
 xT6PQZ+432keZT4qjTKNkDPRDWspi+1ezZOuMtEkGjm859Fgle2Q31+ZutQ7YFfNk9VrDiajqr7
 pc9MP/7oiMTFS7KG2PRHTFNvMGm1v412sDd/r9kypyENk3uNq3g36UZn5gjPS0DR0Jxf2iKVxt4
 aG4T38mGN6mAxcvHSznsuqIxDND8qV9AF9z2TqpNYlQ6068lAsXvvAoSCigSLQ3cSFJjMciQ97G
 u8AKq7zyOte07aYOEq7+og/NvWqFjLJlUV455dAHzx6D1aHdNAcyjVrNTnLy6+wVe/5BlfGF3OY
 35AwNssKgY2YJmySPWG5k3umRAQN/nNloYEIr6aKIbuCW74Z6t+y4V221W7oiy0w8UBnT9zeaiX
 v/A1Jb93abh8a1CuCSftag9ljwI3+XbqBKFeAUcDN+/KdXf5GsmNY+wk9iopecDyuDx61hCC1Fs
 KUHL7yYIG+eSgMMI4Dr8W1nSA5qNdg9G+O1/d76/DbToMSXrNp2cFJhQI+Ax0UYtpqZRXC5YWN0
 Wv5HnmEuBKYU707plNQQ9OUB2EJ+crrP2BVAnhUpYZymJ3HqOrulPnMld/INs2gaRR6YQC4=
X-Received: by 2002:a17:902:cec5:b0:2dd:c100:80ba with SMTP id
 d9443c01a7336-2f03f1bece2mr101884985ad.53.1795370657562; 
 Sun, 22 Nov 2026 10:04:17 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c1a69sm38587815ad.18.2026.11.22.10.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 10:04:17 -0800 (PST)
Date: Sun, 22 Nov 2026 09:46:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, Joshua Washington
 <joshwash@google.com>, stable@dpdk.org, Harshitha Ramamurthy
 <hramamurthy@google.com>, Rushil Gupta <rushilg@google.com>
Subject: Re: [PATCH v2 0/3] net/gve: fix GQI Tx cleanup and QPL FIFO reclaim
Message-ID: <20261122094643.7c312abc@phoenix.local>
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
