Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AABCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D30584065D;
	Fri, 29 May 2026 15:35:42 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 60E3C4065D;
 Fri, 29 May 2026 15:35:41 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id B681D1D00089;
 Fri, 29 May 2026 09:35:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 09:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061740; x=
 1780148140; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=R
 FzXfisB4UsJpoOEgkJZJ8nehCI3db1tkH4db7bNvhPoRTVkY9kZOMalvib+6NBiM
 5O1pbcN/gMoYFi9/LqBUrWLgWjiMnwOmk2Qmm7KIFiwKDbAxWrYdj3MEwSzIhVIl
 OqbXDPB+AAJdmNyNlwTqiEW1+aIGBsPzXOKBFrl1dGPfx/EKq88H+J+6UGMaB82y
 aRfCc7Ki9y8H9UNWeCkMinvov3z3xWJ6pW9eXjmj1CgKg8h4hhzfNTIrn08ZTbjh
 zjCQTJElA51IgbLhoH1lUcmzd9Ei7gs4n99f+fkWkAAAzLVlLOy9IdE5fIn7jegM
 D1EpAUNKDoqTAvFlo0FlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061740; x=1780148140; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=lhzMtD+eKU1+bZy/r
 KaFwOkwMfbJ6cET13FkXZcIvd3GHhS6RL/s7tVDQN44one/innU5MM/AtpRJYhaX
 sKpAQ9eaLwdyoUiSOYwpx8l6DUa4qgzkC37rMH1bB55/rf1A4O12UfMPTrVk8Tz9
 0AJW5YGVqrl9QQYatQKnh/mrgnux46g/2gz9oKIOEDHDJtSCaUcR3HPsdRDVePnb
 6UrSrRUYfj/dm93bbk9bcTnnaT4S2608L7W5PsPZch2CPjoA6xBxlaFjA4KYKM8K
 HvlyyATsEdCUSNX9z4wJqKsLlC3pewJwMg00SbityuceIMNdweMOwsbV6ex8FgHE
 kAyGQ==
X-ME-Sender: <xms:LJYZaumVTUqibwvkLbS_0arZ87AvzMQoD8iHWY3Zb1HWBzjDEvb8YQ>
 <xme:LJYZah0oPHkbpX7qRYGTrcepuGyvLUwYUnmLGDhCe_YRbVyxbb09gTxroJpAEMfwM
 EJbeNGhzvtolDgVBEIsmwCks7v2bufCk-B-8sjWTE3DJISMV1ODzA>
X-ME-Received: <xmr:LJYZau1yJk5heF0ZMnNqMoUUW4UHp7-AHpz87bP0Amb37BQYbWs1Xf-WtR-tQ92nBecXkO97kfGEnInBNIzn0IfeXiybhn8>
X-ME-Proxy-Cause: dmFkZTEJaBYqWAPTW7CUuiXELEtcSTyqNw3TNn3ZA1bv/+gSR58O+Q/XlnfyFwScYHCm3E
 3/v54YirOv9cUjFY4oijMpcpPhXvn4VYsffWyHP8e5YggirQ30Ix0s3iCiI5euwiiABorW
 IU5wh4zLSUfJCgm8/osjqTMPhVH6R1tNbA5odv272r4aACIm12R9sPUGcApLV3oiRhPZdM
 Uf+G6kuR0kfV/YQowl8Clo3EUVBwYZhgm3GbVfnRrT2CRjoz0Mwk6feeuXq5gYcVKCNct6
 yVkuAmy7K1d6+rZmiF+e8xcVejS9n7fmM0WzDGuU8qhKR5muf5c1qzAZFRXMjkP3CzrLDL
 3KNZGbstFEYAFWoywbjAZDLqmJhYyXwIv1BvTGE+qOJ0E9K/OzvifcB3v1/ZgqHMI+Mujl
 rXI02ME6/8bxrg/jyU8ahdVdp1bKzysmjJqbENFOwMps1HF4zyeR95uJ0onSK20O7+eSjq
 ZbY7gEJiDtJGnMP07n4TqM+nWEsl8LOL1W2RELQ8LZVxsosJoD8eUcN4KmWjKHN0dj3MBj
 Xkh/0BEskNKvKf2WyXgQc/KJoHPBsaPHglWEaMMu1doC8nIOMZJRHi/LKR8LklQw7HXXn4
 jD/qanbvGOM0l6y5+ZtsdyGGmEKZb1++sWZUj3BOgTLiMWInXLvP77mn19Ww
X-ME-Proxy: <xmx:LJYZajq9z3wXpB_R-8yOgovjI1EZCtEZe2dvEys0SG0WBG1942incQ>
 <xmx:LJYZaqiCCw2L2QO6-Q_EhaU6fySv3IEPTkGow-vXRAczq3IYtN-mGw>
 <xmx:LJYZav9GthXVtmobwBdcI193NEyXAjO6Uu1f68ymgpp_fGdwBj7CIQ>
 <xmx:LJYZamWE-Rj2kXiUY6PvLN2ZP4kt2wdt27rxvCUy4CR7ZLuMuP3QmQ>
 <xmx:LJYZamsRtio0zCLQYC08JsH6OuNeYbA3hfCgP9sHD1kOeie8jyrd3UUb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 05/10] net/mlx5: fix Rx split segment counter type
Date: Fri, 29 May 2026 15:33:59 +0200
Message-ID: <20260529133522.2646044-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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

