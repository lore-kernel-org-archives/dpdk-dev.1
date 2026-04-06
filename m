Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B0E9D831
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 04:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D004026D;
	Mon,  6 Apr 2026 06:26:14 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id D821A40265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 06:26:12 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12a74039dc6so2515856c88.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 21:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775449572;
 x=1776054372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewO7hJ0/Yf4fSTqVJfdpBewFJHa+jOWwxnLona9Fks0=;
 b=zD7jssNhNetnBfEJZ+27Et7Iz/rFL4tk6ljJko66d6aPNYs8D/ztpP9kIA2S1+l2L8
 FxzMTDZG7TSsHDKef1Ub79hq9R57nBkWdMwlqsFvM8ABr3xcJ2b44d6gnMTPMLmFr3n0
 jyf9Xp+ZYdKSfsxpYl6objuYLy9wJ2EQv3XlZdu/xDtCriurLzH0tV9+4EUekovfqBUk
 2sPqtSpybkm0cd4S/krnOliK9VnvTvWKhkHbgiRzn/D0FRXhxPGUujjj10XzwAxEgXPi
 eNpj6YvNEC51dncdZeIkohkkulSynoiT5BSuaooRZCyjImSAvKFw7h8NYjxJ25CIC7nv
 62gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775449572; x=1776054372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ewO7hJ0/Yf4fSTqVJfdpBewFJHa+jOWwxnLona9Fks0=;
 b=EFaY/IjMscA/2EAJHFs80I4UUAcLTBE2l+Nd6FKW20+b8fCmW9NBpgwTQbUX8m5VDe
 btm2y8i5HiwK1KGcTNXr3LXdVPZBlXLELhKI1Gy7AV7PDNACyYJ8megfYrs7BAW23Q54
 XAjmfRTK9SBi+gUpUKASeVPo42nPVNdTeUYIeGfAViUT1B0OZjJ/uYc89hsCqpR9gb80
 v+drnWhS8J2MoQBd5ayhUfmgZWufjlFc6VLb/ZyDlvZ/Te/IQYCDzIVvWzHLGY6pdK5R
 iVjIpHE4JEiz++JgZ3TKsMDhT0VOf5prqXkbW9EnD6X6iQGXsho+xBcFg4yiNX91rYA8
 rBeg==
X-Gm-Message-State: AOJu0Yy3erKbfe59bXfdRZp18uTKWRv8J9v4dX7EyGsKp8VgMnLPD5J5
 ka2ZhKlLw2+wUlccBeRSLF6/eQmZm7rrooY2qw8ndG1kv7heyWOcND11N5O8DPnoHm4=
X-Gm-Gg: AeBDievQ65imJQAIgG7m5xX7BcTucLqkHTp5BDQxV8nx0tVnlQ4ouSr8IXARZhAwP0n
 7ZBAmbOq8wuQlm8BtCdBUM78mMIYA4fPBolrfzaQMjPQiwJx6IwNShMA0nad8JiQN+dZeEuFfsU
 tzfs5wKBvgSrfzCMY3pravYZdIHS3tzq5Hr6U24ETLmDG95SBV4UGi9U/4tuEpugjpvmA03Yj23
 GPCk7Kqqo//Cn/sIxQy6XrGG7Rr8dBXHoryMXptgqpfsdYljNp6xtYAQV7vngMyA9j/yyDaSWHy
 YwBPW7QoKkwNozTifs4iVYHi8NK2a0BD6zClKqF4rJ7/LY7rkVCQtK1nMDKyg7cMUprBv1JvWqg
 ZhYaGz7MKaTd5r0XnPSYhvL5ly9QcJvXKnA11WqwgIP2b12ouoj1o4AXJTc7HhKKI0tHzXKHhGB
 LATl0D601y5UwSDl5GNYi0C81fsALZDZNwVuk=
X-Received: by 2002:a05:7022:418f:b0:128:d7a7:5271 with SMTP id
 a92af1059eb24-12bfb75ea82mr4903449c88.28.1775449571521; 
 Sun, 05 Apr 2026 21:26:11 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c151sm12792235eec.19.2026.04.05.21.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 21:26:11 -0700 (PDT)
Date: Sun, 5 Apr 2026 21:26:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260405212608.7c9f9ca5@phoenix.local>
In-Reply-To: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
References: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
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

On Thu, 26 Mar 2026 10:28:28 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> This patch optimizes the ZXDH PMD's receive and transmit path for better
> performance through several improvements:
> 
> - Add simple TX/RX burst functions (zxdh_xmit_pkts_simple and
>   zxdh_recv_single_pkts) for single-segment packet scenarios.
> - Remove RX software ring (sw_ring) to reduce memory allocation and
>   copy.
> - Optimize descriptor management with prefetching and simplified
>   cleanup.
> - Reorganize structure fields for better cache locality.
> 
> These changes reduce CPU cycles and memory bandwidth consumption,
> resulting in improved packet processing throughput.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>

I saw some things when reviewing but AI found lots more

On Thu, 26 Mar 2026 10:28:28 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> This patch optimizes the ZXDH PMD's receive and transmit path for better
> performance through several improvements:

Several issues found in review.

Errors:

1. zxdh_rxtx.c, pkt_padding(): The return value is never checked by
   the caller submit_to_backend_simple(). If rte_pktmbuf_prepend()
   fails and pkt_padding() returns -1, the descriptor is still
   written with the mbuf's iova and data_len, submitting a corrupt
   packet to the device. Must check the return value and skip the
   packet on failure.

2. zxdh_rxtx.c, zxdh_recv_single_pkts(): When zxdh_init_mbuf() fails
   the loop does "break" instead of continuing or freeing the
   remaining mbufs. The mbufs at rcv_pkts[i+1] through
   rcv_pkts[num-1] were already dequeued from the virtqueue by
   zxdh_dequeue_burst_rx_packed() but are never freed, leaking them.

3. zxdh_rxtx.c, refill_desc_unwrap(): Descriptors are written with a
   plain store "start_dp[idx].flags = flags" instead of using
   zxdh_queue_store_flags_packed(). The original
   zxdh_enqueue_recv_refill_packed() uses the store-barrier version
   to ensure addr/len are visible before the flags. Without the
   barrier, the device could see the available flag before the
   descriptor data is committed. The rte_io_wmb() at the end of
   refill_que_descs() is after all flags are already written, so
   it does not help.

4. zxdh_rxtx.c, zxdh_xmit_pkts_prepare(): The removal of
   rte_net_intel_cksum_prepare() means packets requesting checksum
   offload will not have their pseudo-headers prepared. If the HW
   expects a pseudo-header, transmitted checksums will be incorrect.

5. zxdh_queue.h, zxdh_queue_enable_intr(): This function checks
   "if (event_flags_shadow == DISABLE)" then sets it to DISABLE
   again. It never actually enables interrupts. Pre-existing bug
   but this patch touches the function and should fix it.

6. zxdh_ethdev.c, zxdh_init_queue(): The hdr_mz NULL check logic is
   contradictory. Lines 158-162 check "if (hdr_mz == NULL)" and goto
   fail_q_alloc, but line 169 then checks "if (hdr_mz)" before
   assigning zxdh_net_hdr_mem. If the first check fires, the second
   is unreachable. If it doesn't fire, the second is always true.
   Pick one guard and use it consistently.

Warnings:

1. zxdh_rxtx.c, zxdh_xmit_pkts_simple(): stats.bytes is never
   incremented. The packed path uses zxdh_update_packet_stats() but
   the simple path only counts packets and idle. The good_bytes
   xstat will always read zero on the simple TX path.

2. zxdh_rxtx.c, zxdh_recv_single_pkts(): Same issue -- stats.bytes
   is never incremented, so good_bytes will always be zero on the
   single-packet receive path.

3. zxdh_rxtx.c, zxdh_init_mbuf(): rte_pktmbuf_dump(stdout, rxm, 40)
   should not be in production code. It writes to stdout
   unconditionally on the error path. Use PMD_RX_LOG or remove it.

4. zxdh_ethdev.c, zxdh_dev_free_mbufs(): Changed from
   rte_pktmbuf_free() to rte_pktmbuf_free_seg(). If any mbufs in
   the TX queue are multi-segment (from the packed path which
   handles multi-seg via zxdh_xmit_enqueue_append), only the first
   segment will be freed, leaking the rest.

5. This patch is large (~800 lines, 8 files) and combines multiple
   independent changes: structure reorganization, new fast-path
   functions, sw_ring removal, descriptor management, removal of
   rte_net_intel_cksum_prepare, and MTU validation. Splitting into
   separate patches would make review and bisection easier.

