Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C7CC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3861D40652;
	Tue, 22 Apr 2025 17:52:08 +0200 (CEST)
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com
 [209.85.208.225])
 by mails.dpdk.org (Postfix) with ESMTP id A4FFB4042F
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:52:05 +0200 (CEST)
Received: by mail-lj1-f225.google.com with SMTP id
 38308e7fff4ca-30de488cf81so52995961fa.1
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745337125; x=1745941925; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4rzoRudxLndFIatxDkETQ9qZXvjl6fTJLUB7L+rJAc=;
 b=ivAWMTpqbtyqUO2Zm984tzMiQu8u3ncNG1/UTge81OLkCIk8PqadV6aCP9Nlb9lGeH
 0VnkUkjZkNVJdwbcfLKGmMWmkU/XrWHryBfWKX+yKNnsTZSuaMZPoNGrdO6cdWMiltSn
 NZGkh36kHQ6+B4+Kwm1+qSzsVQB84TLNPbQXrQPof9a/xGcR37B6BATy1KlaOL3zXSht
 OGsrWPG19Ly+vSN5q3eKbRQbNyNuASeCczmfa17XwLZFwdLXnLOuD/jFk7dAa8hn1GXo
 3DH6z0UYmDGXT8a6xh7n0xDNJoyt540HM30vbkK2jZP09LsxeyGxmAeVUcnf2kSyNpDS
 EFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337125; x=1745941925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4rzoRudxLndFIatxDkETQ9qZXvjl6fTJLUB7L+rJAc=;
 b=lVyk5MeEkIK2oB5/u1+a9to6bGZXy6jrquU48zpuSOdlZQ/A9ceKTtBPkYAMOAl2+/
 SncEhSWUGR5OZVSmXwdO/45VNAQLOAMvRj6xwRpyUh1pn/gjDBW07RQ2ug16a1FSksx/
 O/jhYcN4lm8G84t/PUHQ9Rizu7u5uAlneTeX4ExkYBopsu+XPov/TtFBgJ0BpKDqKS4+
 a0a5cpATwBvJKLY3quqqFVX41TXZ9D9iBh97CWA9MLI1KR7iqN3PQWlmEQ8oTeGHfqMs
 y3q406yIvHBhYk7SJp+4CRJ9LNgAZFxR1ssSasxQgdkjiiaai+BwIWXyIicKnf+LM4rJ
 4sVQ==
X-Gm-Message-State: AOJu0YzDbf61ByYCKHBZRmEWP/1ySOQzT1ajSut4y8f4mKnHpc6Uk12W
 L6OlxsGTdmw2/2x+QB1EU6Ju9T/EVfTvT/JbpL0zDROtJgCqtOpYj/UHctU95PulcjZ6qyVQyv4
 0voTSwuhaSEFjg0oTPZ3Ek8FM9X1ONcwbDUlMDL9i
X-Gm-Gg: ASbGncty6ad7k1b7yyAZY6TR8HPNjqjo6b1B7EfpKvr0WuCH/CiEdGgOqCCcuJVMh4e
 rN/gzmMc5KWCcAnTM/um6D92kYglzN5zOtci1riTscrYgLejIor/JcBetjSsJaxG6o+s10rT02e
 wnlMTQQLrJ0ZidOkAzhdoJhUa5oOnMTJGJveonFilQqI3KSPtVnmNkEEBrcIVisO2oOYqzAEGR2
 Fja0vHKMzUXgJIAXnv41xYNSO28C0uQRQTqMkv9yNmoACNebUeDr2iGOVqrTLbBuf2XRhpIP9OF
 qbXNfhvKE0CiEg9ASNNvzeOq2F0ouiWWZDqE6DQ3/qU4tIZ+R1EthF/cHifks0GtDnI=
X-Google-Smtp-Source: AGHT+IHpBh87GkmsVdERGJKNzlNGYfe/lSfVfyBk8+CprU2gA4WQoYrbEV7fTvxQLsagexGgXbJEhr/X6ZOm
X-Received: by 2002:a2e:be23:0:b0:30b:b9e4:13cd with SMTP id
 38308e7fff4ca-310904c7f69mr43542721fa.2.1745337124803; 
 Tue, 22 Apr 2025 08:52:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 38308e7fff4ca-31090759fd2sm3054551fa.12.2025.04.22.08.52.04; 
 Tue, 22 Apr 2025 08:52:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
 by smtpservice.6wind.com (Postfix) with ESMTP id 3EA8B360DB;
 Tue, 22 Apr 2025 17:52:04 +0200 (CEST)
From: edwin.brossette@6wind.com
To: dev@dpdk.org
Cc: olivier.matz@6wind.com, didier.pallard@6wind.com, lauren.hardy@6wind.com,
 dsinghrawat@marvell.com, palok@marvell.com,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [PATCH 4/5] net/qede: fix QEDE_ETH_OVERHEAD being counted twice in
 rx_buf_size
Date: Tue, 22 Apr 2025 17:51:42 +0200
Message-Id: <20250422155143.3893525-4-edwin.brossette@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <20250422155143.3893525-1-edwin.brossette@6wind.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
 <20250422155143.3893525-1-edwin.brossette@6wind.com>
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

From: Edwin Brossette <edwin.brossette@6wind.com>

rx_buf_size is computed at 2 different places: in qede_rx_queue_setup()
and in qede_set_mtu().

In qede_rx_queue_setup(), it is initialized with mtu + RTE_ETHER_HDR_LEN
and QEDE_ETH_OVERHEAD is added to it in qede_calc_rx_buf_size().

In qede_set_mtu(), it is initialized with
mtu + RTE_ETHER_HDR_LEN + QEDE_ETH_OVERHEAD and QEDE_ETH_OVERHEAD is
added to it a second time in qede_calc_rx_buf_size().

This is inconsistent and wrong in the case of qede_set_mtu(). Initialize
this variable with mtu + QEDE_MAX_ETHER_HDR_LEN instead and stop adding
+ QEDE_ETH_OVERHEAD over and over again. This will factorize the code.

Fixes: 318d7da3122b ("net/qede: fix Rx buffer size calculation")
CC: stable@dpdk.org

Signed-off-by: Edwin Brossette <edwin.brossette@6wind.com>
Acked-by: Didier Pallard <didier.pallard@6wind.com>
---
 drivers/net/qede/qede_rxtx.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index fe839a6ba844..ea77f09e18be 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -101,19 +101,14 @@ qede_calc_rx_buf_size(struct rte_eth_dev *dev, uint16_t mbufsz,
 		 * buffers can be used for single packet. So need to make sure
 		 * mbuf size is sufficient enough for this.
 		 */
-		if ((mbufsz * ETH_RX_MAX_BUFF_PER_PKT) <
-		     (max_frame_size + QEDE_ETH_OVERHEAD)) {
+		if ((mbufsz * ETH_RX_MAX_BUFF_PER_PKT) < max_frame_size) {
 			DP_ERR(edev, "mbuf %d size is not enough to hold max fragments (%d) for max rx packet length (%d)\n",
 			       mbufsz, ETH_RX_MAX_BUFF_PER_PKT, max_frame_size);
 			return -EINVAL;
 		}
-
-		rx_buf_size = RTE_MAX(mbufsz,
-				      (max_frame_size + QEDE_ETH_OVERHEAD) /
-				       ETH_RX_MAX_BUFF_PER_PKT);
-	} else {
-		rx_buf_size = max_frame_size + QEDE_ETH_OVERHEAD;
-	}
+		rx_buf_size = mbufsz;
+	} else
+		rx_buf_size = max_frame_size;
 
 	/* Align to cache-line size if needed */
 	return QEDE_FLOOR_TO_CACHE_LINE_SIZE(rx_buf_size);
@@ -235,14 +230,14 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 		dev->data->rx_queues[qid] = NULL;
 	}
 
-	max_rx_pktlen = dev->data->mtu + RTE_ETHER_HDR_LEN;
+	max_rx_pktlen = dev->data->mtu + QEDE_MAX_ETHER_HDR_LEN;
 
 	/* Fix up RX buffer size */
 	bufsz = (uint16_t)rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEADROOM;
 	/* cache align the mbuf size to simplify rx_buf_size calculation */
 	bufsz = QEDE_FLOOR_TO_CACHE_LINE_SIZE(bufsz);
 	if ((rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER)	||
-	    (max_rx_pktlen + QEDE_ETH_OVERHEAD) > bufsz) {
+	    max_rx_pktlen > bufsz) {
 		if (!dev->data->scattered_rx) {
 			DP_INFO(edev, "Forcing scatter-gather mode\n");
 			dev->data->scattered_rx = 1;
-- 
2.35.0.4.g44a5d4affccf

