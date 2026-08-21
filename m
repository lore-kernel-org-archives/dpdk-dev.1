Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59878C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B36F741140;
	Fri, 21 Aug 2026 21:31:59 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 4C390410FC
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:54 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so2149122b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340713;
 x=1787945513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=716YxNguV57y/hkx5tSbGmp2oX8jpIN0MR23cUgCHcA=;
 b=Lh93Xh1alZSIijhOdhtNpsGkBBrtiIEXVBbRzke2EV9U29LW4Gae7CdEsoWeFen0h3
 6rm3HhZ236h4V9QwnGOwziShqdY3wHNgAR4xROxyxifKUbb+58Km88svczTfFWW7XO0g
 WxhhhHvRsgtdDI1FGu98XADQPq33h4Cg6RvTU0RKdPGaljvriaHvZi2V+hXMEmD9ZcOA
 g7xLRvBLast5iXZjTz0VCR60RlB3846U3iX/Bi9eswYTnetYk0XHMmryzGVASLQLhV03
 qDU9wYsNL+Ob89bOaQFJ12NM4NsVhr+JhK2MW/JHW/+74t367cQArPTCowssfgMklTu+
 eV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340713; x=1787945513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=716YxNguV57y/hkx5tSbGmp2oX8jpIN0MR23cUgCHcA=;
 b=D3W3YjsV73S6U0N63Ql5plSdUXr4tKEe63gOL0+Aj25b/q4Vfc8j9vAUOrWYaDxE0M
 vV7aTxAmEhAeWIgKO7iAkpNY2t8sGjrHpi4iawiCpUvd80N0/HUoJbLHUPIG8nNzR2QO
 DzbyvgbcYuzr7h/8GvEI/jJl1/T+jYXwbdJfQAHo7FLSeRxe9BTD5K1Q0e0Up217FLKP
 9RWhvsyn5tbBulGE3/J3yLL7oR6Wh0mmFF1bpwaDJ90lLTFGVyN4B6Ock7nNdzhjo3kZ
 JE0+Xezi9WPjDac1IunYmmf1elqokCu2AJSIdb39wOh80XBcn5TxbXKEFBBLaNl749CG
 SA+Q==
X-Gm-Message-State: AFuF++mG+g/Of6julHK0XGcVo8K8u3IePw/sq2Q5qG3pyaSeeTy8W5di
 IEXLRHSrD2UeZPClLESzARBILHNWYQ/my30eOuCRYvOrJRJAMlndbtCYztHcHTbhS4Rdy0wYc1M
 m3mOTKpI=
X-Gm-Gg: AR+sD126skyv3f0QoatD7kgGIfRYKXTgttMHscIN2GOxKyco7uNDde/6VnVMm2LHc/G
 NTQEmjA0gzbFINKjGyiJ2JPc+Ond6Z0adBwUISI1URHqLw8UxRkhMKz6UUNCF4nZbKoY93pSbIj
 lJJZJPx/XYmn7J1flY9i+75mb43TBkPYY01K6703cp9wy5iCqk34UzAEH8nhG5j1ZeosusWb0+x
 PW+WZQl1bVQl0ASHaO7icRstzjnyKh7V0hirle4NbhaDxJ9VCPNoPJvQOjmEHLJG32B+6sxAIup
 fUhIsPXvk32/6q2p6T5vmQ5NdkrQvIIwmUXixwEC4q3TxNQ6i5C7EJl4nCHyj4AIy+LJB5yBlmN
 KfUOdrIUrg4bxUNGRn5bqFgRobXG4KrR0s+PMKNslHv4nogY1stsJhIO7jtxzPMakJlMUekiyrU
 MrydBIGgXyGrV72fGPKsspfxuqEGPaaowBijbRdE4b1//0CmIhV6BaR1UY3YhHmfJ3IJJCQpS3Y
 8K0kdZAto8FV9honK8wVXq7us4=
X-Received: by 2002:a05:6a20:d49b:b0:3b4:661d:8405 with SMTP id
 adf61e73a8af0-3cd3183746fmr8181283637.4.1787340713471; 
 Fri, 21 Aug 2026 12:31:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 67/68] net/pcap: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:25:02 -0700
Message-ID: <20260821192646.146382-68-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The pcap driver is not used for high speed production traffic, so
any marginal performance difference from using regular memcpy() does
not matter. Regular memcpy() gets more compile time checking of the
arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 08d3ab9e91..a22e41200a 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -25,7 +25,6 @@
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
@@ -233,7 +232,7 @@ eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
 	uint16_t len = rte_pktmbuf_tailroom(mbuf);
 	struct rte_mbuf *m = mbuf;
 
-	rte_memcpy(rte_pktmbuf_append(mbuf, len), data, len);
+	memcpy(rte_pktmbuf_append(mbuf, len), data, len);
 	data_len -= len;
 	data += len;
 
@@ -253,7 +252,7 @@ eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
 
 		/* Copy next segment. */
 		len = RTE_MIN(rte_pktmbuf_tailroom(m), data_len);
-		rte_memcpy(rte_pktmbuf_append(m, len), data, len);
+		memcpy(rte_pktmbuf_append(m, len), data, len);
 
 		mbuf->nb_segs++;
 		data_len -= len;
@@ -282,7 +281,7 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (err)
 			return i;
 
-		rte_memcpy(rte_pktmbuf_mtod(bufs[i], void *),
+		memcpy(rte_pktmbuf_mtod(bufs[i], void *),
 				rte_pktmbuf_mtod(pcap_buf, void *),
 				pcap_buf->data_len);
 		bufs[i]->data_len = pcap_buf->data_len;
@@ -389,7 +388,7 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len = header->caplen;
 		if (len <= rte_pktmbuf_tailroom(mbuf)) {
 			/* pcap packet will fit in the mbuf, can copy it */
-			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
+			memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
 			mbuf->data_len = len;
 		} else if (pcap_q->rx_scatter) {
 			/* Scatter into multi-segment mbufs. */
-- 
2.53.0

