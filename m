Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB137CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455A7406B4;
	Wed,  3 Jun 2026 20:45:25 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 41E1B4065E;
 Wed,  3 Jun 2026 20:45:23 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9C4287A00E9;
 Wed,  3 Jun 2026 14:45:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 03 Jun 2026 14:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512322; x=
 1780598722; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=Z
 3nF51IoqiDvVs5JNhcexK3J5df7SRaqmq/aa1S12cLw1HTN6HjzyzcALKHxdpcHJ
 7ixY7WDk7HOtRZsOZHfBlUxdXFRpnykDPv/nk5ER34FWiJA8eZT3pPE0zt7uCTJ3
 cJAGL9rCzTrPiGACpltH4eza+iFVTlaTTzY6Rhrfco8r36dnLkCoDxevhWX+O9ct
 KoAT4KH3bCKuzf6p36EqXiHM1LbO2PVlPWQQrU1+A7fWzbafPuihIqbZbR+B+nT2
 Kuv1KmoKF9hEf9TnCS/nldJ/wmgSS9ehMfUJPoqqrU9R7u3JWeBHslJaGSeAGtgg
 O9w0bB5fA+JS3WmBR+dAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512322; x=1780598722; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=Dx4yaEVtqKqUmzhkh
 QsaFLhkpWtzJd0+xszZE9iUaS5fvwKEnIMdwZQV0DISdzU63LdkGB5Kxe8T0ZIvR
 +pmhXJtqzDK1Xu8vhaF8mT/xBOQ/dJ3/ZC0hHBteaujoKVMs/o8H1kcHA1mE271Q
 00ncZhb8evX1OzO4YuwRQ5gxwHw7Hjar5BuJSISenWlnfBGqnQwcCKapx0NmUQVl
 QBLscLjrLKZ0G8at3gi9gCusExJXgoNGuy8MTiBqs3yvMb9F3UDT9mI+WMjCRJEs
 +ftN1EwtP+30I5XodRUkUw41dPSM9XkXhOolP5SFbh76Nke+p52Fntl5jgC88mlA
 ZzFNA==
X-ME-Sender: <xms:QnYgajjEm6R7I236D5iXGRVzcPUB7jXQCuo6GZS5moQ2cVyJ4OCmfg>
 <xme:QnYgasDZ9FwESq7GH5jFDPcMlrml7R5-7cRCvFUc2ixrbKB967br3AwDoR4yuuGGJ
 4ujJ9zwnnXWYGO_6EBWB5yYPxYmFAo_-PrnztjTmKJjGIS0GmRFUg>
X-ME-Received: <xmr:QnYgalSHpk_C7e0tyx8fAtrhOR2lF2HpnTD6uGOT9U3VmVWxthS7lO5zEhEBFYOjuIeh4Sk-7TkSFq3ObRs2OD87NWkIFu0>
X-ME-Proxy-Cause: dmFkZTGBbTPhExUhhklSjj8OMyPAb5bK9/8L8/RsqfNwEYi4Is8dV2beFdt/7msj8uW18G
 cm5Pzclh76eR+5vKBUIK4C6wYLLkMgOz7tqe3LV8tBnzBHjzHF5mIaCwqbce/iOW6wINaI
 PbZ/+yonW5up4VAQ/2D3HZjNMV4cCyD9qYvqDtKkNPwBUYGm12XPOd4HyOteVxJ25wZ4aY
 +lnr8kAJ3VakoervPUnEUvpePRhud88A9lXNuwef766kd9SEKiDTCMSwh0O/ZIpi1i0q0V
 Gy4r9tC2iHuJRFy6nTPGxVAq8rQEJRM47YPzZ8nAaWykEywub6ye18R4lYaM6vY2c/Mymz
 9bzrCv3g6mQNlPPLneuE9miqolLE6iv8XGyKlkILoktak69/h2WH1zIwQGKSmHNzGZWbmR
 4RJQ7ThCzVdlRD0SDpDhT04BgzSQ/TGhgwDetWwQdNtxtrBaIpv910LMM74ADnzDM3Zkdu
 y4SmLe5/J/O8QaIW3mWbkxzBAiNams/I1J6Oe75fMUys+PeZNJO3ekF/sx5P2Thb1XGWxb
 rTA63HoXDPKfkBtj3dMx9fT8JeV+m0UCp3z9VM/kgLK9Ls9IAm99BUsCLw7AQHnz6hNfK7
 +Jz63UDFZVAo3c9DqHgnlAEJv0L8U6bPnTK1TZFqyugzaS7RwY4vfaWXT9Ow
X-ME-Proxy: <xmx:QnYgahX3oFNSvKyJVC2j8n2B0DMjNKf3ge6omYn3QqA2PbRwEzGINQ>
 <xmx:QnYgaufm_73DFZ8N5BJi_sAol0YkYX48BxXShdzDhs-wvdhk5DVfPw>
 <xmx:QnYgatKP6QsFo4ki56ar6rfL0WpnNdkOScoMaAnZhmNwStY4Qt-P5Q>
 <xmx:QnYgajwYwRwzGUvcARdDPwPyPGGtectU1xKXqrB3bbb5AJzvuyKAEA>
 <xmx:QnYgaqa-cA1eSAewUpo8GOq-lF8sbf4eGO5TKaOWZbTdn9Mm1G9P5Joz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v7 05/10] net/mlx5: fix Rx split segment counter type
Date: Wed,  3 Jun 2026 20:23:28 +0200
Message-ID: <20260603184503.652030-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603184503.652030-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260603184503.652030-1-thomas@monjalon.net>
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

In the API, rx_nseg and max_nseg are uint16_t.
In mlx5, MLX5_MAX_RXQ_NSEG is 32.
So there is no reason to have rxseg_n as uint32_t.
Reduce the fields to uint16_t and move them to avoid struct holes.

Fixes: 9f209b59c8b0 ("net/mlx5: support Rx buffer split description")
Fixes: 572c9d4bda08 ("net/mlx5: fix shared Rx queue segment configuration match")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mlx5/mlx5_rx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index dffab3955b..01b563d981 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -164,9 +164,9 @@ struct __rte_cache_aligned mlx5_rxq_data {
 	uint64_t flow_meta_mask;
 	int32_t flow_meta_offset;
 	uint32_t flow_meta_port_mask;
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct mlx5_eth_rxseg rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Buffer split segment descriptions - sizes, offsets, pools. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t rq_win_cnt; /* Number of packets in the sliding window data. */
 	uint16_t rq_win_idx_mask; /* Sliding window index wrapping mask. */
 	uint16_t rq_win_idx; /* Index of the first element in sliding window. */
@@ -191,9 +191,9 @@ struct mlx5_rxq_ctrl {
 	unsigned int irq:1; /* Whether IRQ is enabled. */
 	uint32_t flow_tunnels_n[MLX5_FLOW_TUNNEL]; /* Tunnels counters. */
 	uint32_t wqn; /* WQ number. */
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct rte_eth_rxseg_split rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Saved original buffer split segment configuration. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t dump_file_n; /* Number of dump files. */
 };
 
-- 
2.54.0

