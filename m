Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3CCA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F4A640279;
	Mon, 12 Oct 2026 23:28:17 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id E560840272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:28:16 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so11635405ad.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791840496;
 x=1792445296; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=73ymaCejbjcOdoig3uyJmqNIC+KD36yLaVooIUheFYo=;
 b=j7QO3Tu2DA01UfVatLpMNPWtHeIeZmmIvItuZC12aZOBDxPX5vJkGay0AydriTV0iF
 l7E5isGfIbCGvWlExNo6nRxS/uY+/ijxgvXCCM0gP2wNwhn3WvJZr9JUKSkm8FjOp6+G
 EaguzEEDzWnQxNLcudJnnzmlP8jkvuAuYWkKvszjIUgKN1EISh2rwFOgwpUnBEQ6JjGc
 OnQwcl0wMbHlbKUalyYZ5JI7hJRlDN+TLyzH98ywSXff9FxsxjHfl5SwOAKfq2JQNtBK
 eZrMxl9PaZrXgwGHlO8Avd3DOu97M9vluyaJDwjYtrF0cWoQx9aTImQ+SjX/1r6sj8KV
 Fysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840496; x=1792445296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=73ymaCejbjcOdoig3uyJmqNIC+KD36yLaVooIUheFYo=;
 b=U7DH98O66PNpmt/3ejlDMTI6guEUP0f7/8+3/x3byVLRK86ogFWSQ6D8SSU1KOXKXD
 5nJD2X4f8Hlj1LlKkIg7Uar0xZURv8EfTzhAt+jxfF+LpXB5+ToFSBdFEdot3kaoxwxO
 cHwlvQgNYdsdmf8XryHmO4GZd4TUSgin+DiPGsFtdQzZAYQ3KEeVWXc/VUlTYK9S4eBD
 w1RFPinY8Cc+LwYZ3tAVf4Fyk3Wv/CLuh3It3+NwlxKD5oLiXFPqSa1Q3GGPmAahDd9n
 voJ2lI4x/N4B/xxXrq8n7wZBnOdXJbveoRW2jHuMdEWSpV1+Ww1zq7I2xQ2pCIkz3sRC
 JEwQ==
X-Gm-Message-State: AFq9FYJVhM0lot4VliAHm5IakMinrrhbhvFwY3dZ6lRBKNxuajmj6XD1
 21+ZLqcp1xQLUHQBuDqA2V2g23KMqmEHsLerLVTleJNaIjQTCLaZLLKyiCrooJwVOpo=
X-Gm-Gg: AYBFou2C/1VIWfnFMrMllvWZLlE6EOe8zn32pvy1+QIzSIWl1nf/SH3GsoX0Kcc5MST
 aA/caM026x0z0+u9k3067dLzsqZWF6zRQat7RH6BpiRmnTiGDO96XvNKLxvA/sa3+9j4n6qDJRm
 Yle2va5xHYPVGo8ld5/6kVBS6zf8gG0TKqr9AgT5zIC+h5dwYPZTZhpPQ1yrM7LGPuWjh9pD2xw
 stBQvtGBVJNyWs/qtm8fD6cuybYJDUExWYgteyDGh7Pu9+XKUcwm371wzFeDr9o5/JDB/9ZoEpK
 ZYFYc2tGHqa7F1wE2v7a0neOA5oJ32UZPXzHlrak754FKTn2C3632n85o9oo0EImh62Q/r5m5Mn
 NvkBJmCbzpVFmz9FjeC9Fx6fhRQR+lS/2QAbavgdnyn8+vbMYsgig8NXmV9fCsgWtWaInpqk4sx
 gm2HtlgKXI/JpswIBbrZyy+nylF1a//3YfWJFN73ScBu4a1n9ud3p8VfZ7SFHZZGAjjjAr6TJql
 4eOysJ6Nq+aZgfG2JWTA1zsfq+0Lb4FQtxQuisb
X-Received: by 2002:a17:902:f54f:b0:2e4:a7ec:2235 with SMTP id
 d9443c01a7336-2e842cd9d35mr89868855ad.39.1791840495915; 
 Mon, 12 Oct 2026 14:28:15 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422da9b1sm46906155ad.66.2026.10.12.14.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:28:15 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:28:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, joshwash@google.com
Subject: Re: [PATCH 0/4] net/gve: fix TX queue stalls and sync DQO RDA with
 Linux driver
Message-ID: <20261012142813.103d9d68@phoenix.local>
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
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

On Mon, 12 Oct 2026 10:50:19 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This patch series aligns the Google Virtual NIC (gve) DQO RDA transmit path
> with the upstream Linux kernel driver (drivers/net/ethernet/google/gve/) to
> resolve transmit queue stalls and hardware validation issues:
> 
> 1. net/gve: fix DQO descriptor cleaning loop bound
>    Fixes the off-by-one error in gve_tx_clean_descs_dqo()
>    ("while (--nb_descs)" -> "while (nb_descs--)") and avoids stalling
>    the completion queue on unrecognized descriptor types.
> 
> 2. net/gve: fix DQO TX queue stall on multi-seg and TSO
>    Tracks descriptor intervals with last_re_idx per packet against
>    GVE_TX_MIN_RE_INTERVAL (32) instead of counting packets at burst end,
>    preventing descriptor ring starvation and queue deadlocks under
>    multi-segment and TSO traffic.
> 
> 3. net/gve: add cacheline overlap margin to DQO TX ring
>    Enforces GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) margin
>    in ring space checks, avoiding CPU and device DMA cacheline collisions.
> 
> 4. net/gve: add packet and TSO hardware constraints for DQO
>    Augments gve_tx_validate_descs() (which enforces the 10-descriptor
>    limit per packet or MTU segment) with the remaining hardware length
>    constraints: [17, 9728] bytes for non-TSO packets, maximum MSS limit
>    (9728 bytes) to avoid 14-bit field wrap-around, and validates header
>    contiguity and payload presence on TSO packets.
> 
> Tathagat Priyadarshi (4):
>   net/gve: fix DQO descriptor cleaning loop bound
>   net/gve: fix DQO TX queue stall on multi-seg and TSO
>   net/gve: add cacheline overlap margin to DQO TX ring
>   net/gve: add packet and TSO hardware constraints for DQO
> 
>  drivers/net/gve/base/gve_desc_dqo.h |  3 ++
>  drivers/net/gve/gve_ethdev.h        |  2 +-
>  drivers/net/gve/gve_tx_dqo.c        | 80 +++++++++++++++++++++--------
>  3 files changed, 62 insertions(+), 23 deletions(-)

The problem with the series is in the last patch.
The way tx_burst works the driver has to consume packets that cause
errors.

Subject: Re: [PATCH 0/4] net/gve: DQO Tx fixes

Applies cleanly to main; every commit builds with -Dwerror=true.
Patches 1-3 match the Linux gve driver (unknown completion types are
skipped, report_event spaced by descriptor index, 4 descriptor
cacheline margin).

Errors

[PATCH 4/4] net/gve: add packet and TSO hardware constraints for DQO

1. An invalid packet stalls the queue instead of being dropped.

       if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
               txq->stats.too_many_descs++;
               break;
       }

   tx_burst returns short, so the application gets the bad mbuf back
   and retries it at the head of the next burst. It is rejected again,
   and nothing behind it is ever sent. The break was already there for
   the descriptor limit; this patch extends it to runts, oversize
   frames, bad MSS, split headers and zero length, all per-packet
   errors. A short return should mean only ring full. Linux frees the
   skb and returns NETDEV_TX_OK for the same checks.

   Validate before the ring space check, then free and continue:

       nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
       nb_descs += tso;

       /* Drop packet if it doesn't adhere to hardware limits. */
       if (unlikely(!gve_tx_validate_descs(tx_pkt, nb_descs, tso))) {
               txq->stats.too_many_descs++;
               rte_pktmbuf_free(tx_pkt);
               nb_drop++;
               continue;
       }

       req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
       ...

   and use nb_tx - nb_drop for stats.packets. too_many_descs now counts
   more than descriptor overruns; renaming it, or adding a drop
   counter, would make the xstat less misleading. The rte_mbuf_check()
   failure just above has the same break and needs the same fix.

Info

[PATCH 4/4] net/gve: add packet and TSO hardware constraints for DQO

2. The non-TSO length check fixes the original DQO Tx path, not TSO
   support. Add:

   Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
