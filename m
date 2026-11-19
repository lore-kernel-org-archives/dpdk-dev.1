Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C94606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jZ7Nr6vK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96A0940395;
	Thu, 19 Nov 2026 01:00:15 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 0A6CC402DE
 for <dev@dpdk.org>; Thu, 19 Nov 2026 01:00:14 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3b3bf3bef9aso1561163a91.1
 for <dev@dpdk.org>; Wed, 18 Nov 2026 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795046412;
 x=1795651212; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MXn0gtIIVf9OtMPxilh1JETVrBcJacW+lTwDGcJ5JNI=;
 b=jZ7Nr6vK0HT83ZYsjF/6E+j3DZKsFYdZZ1Efg0EMt8t2oEhQ3GADuovbHE3mS+QqYY
 bdcggUbi1b7AFgYrZR9QWp82YvdV/eWkvhK/eV9jQvcdL0YHrCocGBJb++S538gtOzwW
 wg/AuJQ+8jvCW/JShqzVH2A1zr13A5AC36a0dcZGXXN+JmB+knRk/uAYE0EHA4GsBijc
 IkM51Jmsfo5IvnFixXv70KMp4WbF0YpOPaxKuxdceE1uxHFLlxhwqKttWerV0Dhzynih
 q9+XIOVn7x1azFaqldN8p95q6516AvqI2c7Qy+vgQTMG6lb9zdNDpN2aN0DdGonpZpm/
 AMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795046412; x=1795651212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MXn0gtIIVf9OtMPxilh1JETVrBcJacW+lTwDGcJ5JNI=;
 b=E7Lx7dDIo74leIjC1SjDxRJKrLT6mikbsAp0Dc9Zf5pv5n8zAfHyYL9ExbwxRvo1JU
 uxrmNBdTaB7sfam+DVYQ3SCZKVGdAhPO5kLP1P5mEvEzfYS+Hji160XGWBw5CFbNbjMe
 tZLaRi6OMzoZewnDazTi20XRy74zOWIakJ1DfBXGkqNQxggIB1Zsg6kFDlXOCddi1hkR
 mSCpXFKk7znapvwYNHVwhLoUTkS5s/2J3fh/suxSgxFEBh7sBwvlnFmhClZGyWfZpbXM
 T5NJXixcm8dxqyNo8hncFZAYi7v6F+7Yzi5QCZnSPAtOaa+gr06pfEtCL8p2PPBUdNMX
 rSbw==
X-Gm-Message-State: APuU4Z/0Zo8J7j/PXd87l9fEFdCsBzwtgNptGuXKAIu+RAK0D/ygsoQq
 Y1aIwULaSIVbpsF8WMAGkuZJMxEM13E4Z9xLftASVS5fSSkUtJgiUskpg9jkrK1+a8w=
X-Gm-Gg: AZFdTZfU5LiI6Yp2yQKlQ+PsHCHTBF0x4mJpBJxsHZ8pwgEDnQE023DbnKAO1EgPW3F
 xQpUhgyDzNRWipfs+yqo8IDIf4hT4Y3pO0Me91xWfJ+YqgtkX6tlV/vdSs6tVWxllJv4/gfsTcd
 zf4hG2S7y2MjJ4LylLhTpvnrQhGXt+zr5a0PyYIrzZ9afhCimHRzMpwfXDY/3gYJJsfdIB3CHoc
 WouAORIEA91+IOJx9hPzpopesQuDUlgXzhe0MNdiALWr+nfCB62YBR8yS1kuzgHprz+KhuhE7Fw
 lg9yqhBzrrsL78BUIpn60hZ9fVS/7H/f6/u/9E7ANg/Bt1/iCabHg6PZVkxlegsgXOvLgjO3BFw
 Kf91zK4/vkF8EVKqvkCZ2KoUD1BfPaJFGPccJ2XGgSNQ9YkcfUKcNnUHaoQ5WcnAfOBCzZokXLa
 ekMO7Tove9MEsfFBk4EJj+yQb1bROsTQRnC4Jvwd5P30fGSU9/an66w/ZJFevg9mkEtR8288PLs
 9TsGS2uPr+mclb6fPR4QD8bYX5zN6d5/1EC3xrRM/6BUoJAGj014kOf5slHrS+FTD2Rv/PcFvG1
 v82wvqvhW0xTxUjCnAxv5vj/GdCN3Rzqyx3x9uA3K5FTIGs6KZdQRS9oqAdPvAjmqBBRrj8=
X-Received: by 2002:a17:90b:1810:b0:3b1:bdc8:c32b with SMTP id
 98e67ed59e1d1-3b3d07e0cbbmr4528571a91.53.1795046412235; 
 Wed, 18 Nov 2026 16:00:12 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b401f73a4bsm17673a91.0.2026.11.18.16.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 16:00:11 -0800 (PST)
Date: Wed, 18 Nov 2026 16:00:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, Joshua Washington
 <joshwash@google.com>, stable@dpdk.org, Harshitha Ramamurthy
 <hramamurthy@google.com>, Rushil Gupta <rushilg@google.com>
Subject: Re: [PATCH v2 0/3] net/gve: fix GQI Tx cleanup and QPL FIFO reclaim
Message-ID: <20261118160009.0c72d768@phoenix.local>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

AI review looks clean, though it did see some pre-existing issues

Subject: Re: [PATCH v2 0/3] net/gve: GQI Tx fixes

Applied to main, builds with -Dwerror=true. All three fixes are
correct. Remaining notes are pre-existing code next to what the
series touches, worth picking up while in this area.

Patch 2/3: net/gve: fix GQI RDA multi-seg descriptor length and clean

Info (pre-existing): TSO payload length underflows when the headers
are not all in the first segment.

    gve_tx_fill_seg_desc(txd, ol_flags, tx_offload,
                         tx_pkt->data_len - hlen, addr);

If data_len < l2+l3+l4, the uint16_t wraps and the device is given a
near-64K segment. Either reject that case (free and count as error,
as patch 3 does for QPL) or require headers in the first segment via
tx_prepare.

Patch 3/3: net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell

Info (pre-existing): the 32-bit widening stops at is_fifo_avail().
The allocator still takes uint16_t:

    gve_tx_alloc_from_fifo(struct gve_tx_queue *txq, uint16_t tx_id,
                           uint16_t len)

and is called with

    fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id,
                                       tx_pkt->pkt_len - hlen);

GQI advertises RTE_ETH_TX_OFFLOAD_TCP_TSO with no size limit and no
tx_prepare. A TSO mbuf with payload > 65535 now passes the full-width
"need" check, reserves only (len & 0xffff) bytes, then
rte_pktmbuf_read() copies the full payload into the FIFO, overwriting
in-flight frames or running past fifo_size. pkt.len is __be16 so the
device cannot describe such a packet anyway. Simplest fix is to drop
it with the malformed case:

    if (unlikely(tx_pkt->pkt_len <= hlen ||
                 tx_pkt->pkt_len > UINT16_MAX)) {
            rte_pktmbuf_free(tx_pkt);
            txq->stats.errors++;
            continue;
    }

Info (pre-existing): the QPL path has the same descriptor-low abort
that patch 2 fixes for RDA:

    if (txq->nb_free < nb_used)
            goto end_of_tx;

Using gve_tx_reclaim_fifo_qpl() style clean (or at least
gve_tx_clean()) there would be consistent.

