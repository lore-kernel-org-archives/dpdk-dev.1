Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D28606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YyvbXqmD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0579440297;
	Mon, 19 Oct 2026 19:01:23 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6AAB74021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 19:01:22 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cd5e6f0a22bso840916a12.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792429281;
 x=1793034081; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UrGylC1ulskYh4kCWHL8wezW4dylyxx2XpKySnrf/hA=;
 b=YyvbXqmDUtUaNfLOw6msqiw9YHRNyWyBtDRoVBEyTIQETgOMWLcb6L0cCGNus/R5HM
 GpUA8JUEq+pehgOy421yAebQbZ6vlklbBSZFq+GiCkd7Tf8LJni685ExF5i0H40yP4lQ
 ZZKIOJrt+jxcDQL2Eo/ULKwmCnxhDGTMXOSBWt3jRrsUs4kn3UA0e8177KrRMOXu61iB
 dkohm7rkEIfh/d7lzp/XMI9Lvo96+sgSL7JfOD+QsKkAJxwRqRsGJENABDnlPclBiYLT
 wf0X64kgh+SfiZ9dwwA8Tn65wrYNsArv+a5gewhGJuuED1ZyK7js7dNUBwOqQ90sV6ju
 OfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429281; x=1793034081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UrGylC1ulskYh4kCWHL8wezW4dylyxx2XpKySnrf/hA=;
 b=i4JqqyQWJfufIh9TwxhDqMWBpMK2XFARI6bJD+/11EP7FCiAkjWL34ZmRKb78JUsZh
 bQADx5d3gCV+yfeIUGjvwK5OxMO7VLdbR6okwpQKk21fpq6SWPZsirRMmnUZeDyZwm5i
 6bOpZGR11VIlNCHsDdUgRbAC0LoAW91agSvd9nOt+pnKeSC/dMghPjPq7PhVYyG9NhEm
 AX7KkXgRGXbsazeckx0Kck7rsYn6vODPIZPFxGhXLU2EYbGrmxECxkaCKWBlYFZwRr2N
 e8/RthAPlfT2UPUGxwQbXqEP2lYequTRjHGwHgRbiWbHUZ5Nu3K6gvE5BG6ObofqpibK
 95Gw==
X-Gm-Message-State: AFq9FYL7sLmdRzuc9HqE2R7vhslz0QtU+GGDagt5kO1e3bU1T7baz+zl
 FVfKJpqj9Xf6BkvFGmPPmQuxJHQyhXFmuofPplCy33R/LWA0TQRRWYhDH2KLifZzMcY=
X-Gm-Gg: AYBFou2gVc3f5KVo6fZkRDP30vjjZVGmi5ZCCizGOsqb3MgnMYH7O+0Opx0E9bXMhyo
 5aLZpddasaaeHDng1b0pac3xc0k/8s16BZjmeTkLV4KkdZ9Bay9lQP2jNT3/K385Wxw+5R7njul
 xy2eEaRG3/lidhwg/oFNv6YvoVXvdxuzIV/twhDYdlogtRRqiMgkhoBG5o72SUK9oK+KG+tTsGW
 vNJFl8sBbyErSQN8oglpbPttAcyFLcNVQR8sSRDEAQegPmDgc+kQK2t79IpmA2yFEZC0PVgFIxP
 5H3icCRT3mdkWbrlw59+UPWOLvaY/buCVUk9mvWRhDRqinsHpLOLyfVDMxSjKlTE5lsUUMDc9Tb
 29UrXb/4VKSaDfAQVZuCTguCnvJUdlUhu1T17rBtSbyOp+6f08OjmqAvsYHSGg9yAThEhs+9Ad5
 gHCINWBo0DYypwLDy3jd8h/h6XRLy/9Ps5Rx5kv40ymBzttOxkXKK37c19llttRzKvl6g5ySi0n
 J8CB8IJH2BNiX+o6c6gqd0+hc1m3Ec0DHK4rf9zmakXuVxvV69BfojMk5/lOWugb0S5SDf4w5oK
 zg2BMPfxnvPAHQFHFl1ueg==
X-Received: by 2002:a17:90b:5146:b0:3ac:adce:60b2 with SMTP id
 98e67ed59e1d1-3acee293865mr6651839a91.2.1792429280797; 
 Mon, 19 Oct 2026 10:01:20 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad5d400505sm304193a91.4.2026.10.19.10.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:01:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:01:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, joshwash@google.com, stable@dpdk.org
Subject: Re: [PATCH] net/gve: advertise Rx scatter in GQI queue format
Message-ID: <20261019100117.6cbf60f8@phoenix.local>
In-Reply-To: <20261019022824.189319-1-rnwolfe@google.com>
References: <20261019022824.189319-1-rnwolfe@google.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 22:28:24 -0400
Ryan Wolfe <rnwolfe@google.com> wrote:

> Since jumbo frame support for GQI, a frame that does not fit in one Rx
> buffer arrives as several descriptors with GVE_RXF_PKT_CONT set on all
> but the last, and gve_rx_burst() chains them into one multi-segment
> mbuf. The driver never reports RTE_ETH_RX_OFFLOAD_SCATTER, though, so
> an application that enables multi-segment receive only when the port
> claims it treats every packet as one segment. VPP is one: it masks its
> requested Rx offloads with rx_offload_capa, so on a GQI gVNIC it never
> sets its multi-segment flag, reads only the first buffer of a jumbo
> frame and drops it as malformed. With 4 KB buffers that caps the usable
> MTU near 4000 bytes on a VPC whose MTU is 8896.
> 
> Report SCATTER for GQI. DQO posts one buffer per packet and does not
> chain, so it is unchanged.
> 
> Fixes: 496d4d2c8b54 ("net/gve: support jumbo frame for GQI")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
> ---
Subject: Re: [PATCH] net/gve: advertise Rx scatter in GQI queue format

Applies to main and builds with -Dwerror=true. The Fixes hash
resolves.

Warnings

1. GQI chains buffers whether or not the application enabled scatter.

   With this patch an application can request
   RTE_ETH_RX_OFFLOAD_SCATTER, but gve_rx() follows GVE_RXF_PKT_CONT
   regardless, so one that does not still gets multi-segment mbufs
   whenever the MTU exceeds the Rx buffer. Advertising the capability
   is only half the contract; without SCATTER the driver must refuse
   the configuration rather than hand back chains the application
   did not ask for. Check it in gve_rx_queue_setup() before the rxq
   allocation:

       uint64_t offloads = dev->data->dev_conf.rxmode.offloads |
                           conf->offloads;
       uint32_t buf_len = RTE_MIN((uint32_t)GVE_RX_MAX_BUF_SIZE_GQI,
               RTE_ALIGN_FLOOR(rte_pktmbuf_data_room_size(pool) -
                               RTE_PKTMBUF_HEADROOM,
                               GVE_RX_BUF_ALIGN_GQI));

       if (!(offloads & RTE_ETH_RX_OFFLOAD_SCATTER) &&
           dev->data->mtu + RTE_ETHER_HDR_LEN + GVE_RX_PAD > buf_len) {
               PMD_DRV_LOG(ERR, "MTU %u needs Rx scatter",
                           dev->data->mtu);
               return -EINVAL;
       }

   and apply the same test in gve_dev_mtu_set() against the configured
   Rx queues, since the MTU can change after queue setup. A separate
   patch in the same series is fine.

Info

2. The commit message says DQO "does not chain, so it is unchanged".
   DQO Rx ignores end_of_packet, so with buffers smaller than the
   frame (2 KB mbufs, 8896 MTU) each buffer is delivered as its own
   packet. Not introduced here, but DQO should either chain or refuse
   that configuration too.
