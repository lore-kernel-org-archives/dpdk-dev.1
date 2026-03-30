Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14021061B1F
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 19:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9FF4402D8;
	Mon, 30 Mar 2026 21:56:30 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id E521B402CE
 for <dev@dpdk.org>; Mon, 30 Mar 2026 21:56:28 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ab232cc803so23419235ad.3
 for <dev@dpdk.org>; Mon, 30 Mar 2026 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774900588;
 x=1775505388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vy3hkNpeeqL0qrHe96K3D6f7oZVAqjNC6dllqF4iM50=;
 b=sLow0+CewmGTNdWBi+zMC4em6VGFS9y84FRvQQP3YDG2ooStLIXF7Ot1KED658JJLj
 6ST98vF8Yhw72hg0JowRqIUAgweOVkYWGP+mG9v55FaW+mxvnY+u07OVJApTz1qaPVLW
 CM9t/ydr1BvAFRc1je/9Bb5Hslj+W6PLEgr6xZYCGrcUD4wVdRGsRwVRYBcs9Yv0Ls6u
 j3BE2pM5o2oIhh0++ZbF5RiOIINFEw76dBg9iMwWjAd6fFkZHz53du4W9ef4nq5p+PUQ
 eGZNlRyry6O1SU2iFLK7wueVetKnwHOxgecpZZ84jBslm632BGhKQbPqD/akJiCyQKYu
 FR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774900588; x=1775505388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vy3hkNpeeqL0qrHe96K3D6f7oZVAqjNC6dllqF4iM50=;
 b=fWWm21MTIQ/Hr+TMkWNXGg8mrtuPUs3MwN2Uv+XFPM2IcPnL9vqLZE5bX/s/x7OBSI
 mp14GO4oClEsDSkyUTf7uJf0VZyyC9FsA2x075ZHcLMiv/aazSDNEzh1r6pNMvxgcwEl
 V2Nn+Lnhn76NK/Tx249ZXYri5wiF7DIuZcgpMavHh+YbnPozTfV5m6xh+/fgHxZJq16O
 n6SNl5nmmjmngv5MsvMXpdISe497Hl5jzb+nCriweit4G12ZQTq5kQaT6TldtBhNuIOT
 RJGaOTG7W0NeirLZ3R/0JaR1POB6hFustjQfuvBfqTGxGDL2jIOVX0x93G1rA9TLRJyp
 3Bwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4lBEPJN1ybRzfddtlJoWsr3+ORtCMe+zDR8lW38z9DeBs8MIGNVGv0cLelHg5QlqzJXk=@dpdk.org
X-Gm-Message-State: AOJu0YxYhXJXc92iHxpTwHiTqAuZZGz0gFWQXZtfcO4m4W6VdIJvRD0I
 wRhs3mQG00luwxGEhke3hShM4ZvfbsvuKteg2Wzm7SjnAeZ/pFCPCvdklY4izz+1tDQ=
X-Gm-Gg: ATEYQzzY6RkII0W0ClJ0z+2GuX8Wco7CJtp9m3ofYy0Sz+uCN+ZoBntRbl0GBIYIq44
 W+4UTxAz7Nh7ftFuauJDHzH/hu+T+3TZ+/pDsfCcvJpOtAztmgaa4ohGItK4hl2CNo1vMgZSRvl
 BoenZ6AemVLyKYQvQhUTjtP/5Y/wpUngnIuZaItWX0ywiXm87hbhf2Xbg4Z3iM6u6981vMID6/y
 fDmRZhdWz+bo32JUCw4+fQVhw0WiwTE8S+y0KXb3vedDQJX7Dvw36awGZCkAxqEN51Hj5O59/hi
 eiJWSSEEOdWbVuIU+uUWePJGqpoD1Tu4enkTBMOpsgMCqOCfes1bIaN7HrpOrA4YfKTrH7W6mi0
 o1PXEUQ4IUKytZMjgUIrgLLg0iCHo4EUqwd4WJOaTDrur4P2Ds8LoIwYRw6zHObAR16Fe2C/Kh9
 GCsMKpHkGkH/yqSE5BGM/Qu1O8cDeByYGA1+XPFDnVWeSh3w==
X-Received: by 2002:a17:902:cf0b:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2b0cdc2c13cmr134360905ad.17.1774900587709; 
 Mon, 30 Mar 2026 12:56:27 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2426896edsm89372425ad.34.2026.03.30.12.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:56:27 -0700 (PDT)
Date: Mon, 30 Mar 2026 12:56:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Caiqiang Liao <18859237562@163.com>
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, dev@dpdk.org
Subject: Re: [PATCH] lib/gso: gso Adds the processing of IPV6 tcp packets
Message-ID: <20260330125621.131f4b63@phoenix.local>
In-Reply-To: <20241204100551.2914-1-18859237562@163.com>
References: <20241204100551.2914-1-18859237562@163.com>
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

On Wed,  4 Dec 2024 18:05:51 +0800
Caiqiang Liao <18859237562@163.com> wrote:

> The rte_gso_segment function increases the processing of IPV6 tcp packets
> 
> Signed-off-by: Caiqiang Liao <18859237562@163.com>

This patch never got any review.

Turned to AI review and it found a lot to fix.

 Summary of Findings
  The most significant issue is a logic error in rte_gso_segment that prevents plain IPv6/TCP packets from being
  segmented and incorrectly handles tunnel flags. There are also widespread indentation issues and inconsistent use of
  DPDK-preferred endianness functions.

  ---

  [ERROR] Correctness Bugs

  1. Logic Error in rte_gso_segment Conditionals
  In lib/gso/rte_gso.c, the new block for IPv6 TCP segmentation has incorrect flag checks and redundant/wrong protocol
  handling:

   1 +    } else if ((IS_IPV6_TCP(pkt->ol_flags) &&
   2 +        (gso_ctx->gso_types & RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO)) ||
   3 +        ((IS_IPV4_GRE_TCP4(pkt->ol_flags) &&
   4 +                     (gso_ctx->gso_types & RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO)))) {
   5 +                pkt->ol_flags &= (~RTE_MBUF_F_TX_TCP_SEG);
   6 +                ret = gso_tcp6_segment(pkt, gso_size,
   7 +                        direct_pool, indirect_pool,
   8 +                        pkts_out, nb_pkts_out);
   - Plain IPv6/TCP packets will not be segmented because the code checks for RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO instead of
     RTE_ETH_TX_OFFLOAD_TCP_TSO.
   - IS_IPV4_GRE_TCP4 is an IPv4 protocol but is incorrectly grouped here to be processed by gso_tcp6_segment.
     Additionally, this protocol is already handled earlier in the function by gso_tunnel_tcp4_segment.

  2. Inconsistent Endianness Conversion
  The patch uses standard libc functions (htons, ntohs, ntohl) instead of the DPDK-preferred rte_cpu_to_be_X and
  rte_be_to_cpu_X macros. This is found in:
   - lib/gso/gso_common.h: update_ipv6_header uses htons.
   - lib/gso/gso_tcp6.c: update_ipv6_tcp_headers uses ntohl.
   - lib/gso/gso_tunnel_tcp6.c: update_tunnel_ipv6_tcp_headers uses ntohs and ntohl.

  ---

  [WARNING] Style and Process Issues

  1. Indentation
  The patch consistently uses 4-space indentation in the new files (gso_tcp6.c, gso_tcp6.h, gso_tunnel_tcp6.c, etc.) and
  some modified blocks. DPDK coding style requires the use of tabs for indentation.


  ---

  [ADVISORY] Improvements

  1. Use of rte_pktmbuf_mtod_offset
  The patch frequently uses rte_pktmbuf_mtod(pkt, char *) + offset. DPDK style prefers the more concise and safer
  rte_pktmbuf_mtod_offset(pkt, type, offset) macro, which is already used elsewhere in the GSO library.

