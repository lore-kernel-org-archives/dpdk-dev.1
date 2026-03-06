Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE6F0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC31402D3;
	Fri,  6 Mar 2026 14:31:00 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id AAA0142707
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:59 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so79095355e9.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803859; x=1773408659; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJvo4UROYkY43JQUwfgm9ZG+E2Dn8XsTNgz3Ol6aP0Q=;
 b=WaFxEjAZVR4P/8ztQBJI8M8ggPoYmHL7r8XqgxVhFkd0ePGjYo2NVcIaVDjPTFtwzz
 aWpE6qt2TuxTqTc+Ey6cgqYJLvCKLRxyUzx98zmECVqcyMjyWQyj8z1/0y8t38hfGzIu
 ite3l3rX7JQHcoAvI3+223ICedeWoSYA84+La5Qly6tc5DHgZrUlEzYelOEA1pcpMRed
 B/dW2G/lPJnG6wGthkOJGteGrgpqcw9xKibyx6tBZ+P/a4NmQzPQNIb2SCBMrY2HhuW/
 H4YIGL8tlOtsHNGwNYRlupzZw81ltCwaVnRSNd6B+99+O8yHpXmXlSNqffHl00oKk90y
 U+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803859; x=1773408659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJvo4UROYkY43JQUwfgm9ZG+E2Dn8XsTNgz3Ol6aP0Q=;
 b=kBQVA8TOXCjklxpneMobBeCIMdQfpf738hEl7Wukw/95qyHe/RU051NFkawbN1zmOJ
 A8al7ezQbDc0eMbim59f2ptDta1/iye2zRnPyUXpK4MhcpyPRaWTcLl2LGb6FISApNbO
 GxgcgKC4ee03Wtdj2APAI8gZQH/ZH5+9lDgY//9SZNFUlG/jzxG2okckTUvtktOh+DoY
 em2NQxLs8MsniTLAzmDWIpRM2N/ggDqG+fNeXOrEaCgtHLlnZPuouu6B+J7/ZP4LuS5K
 jtKmKWl1vaj1Zo1KP7XoTd8Vp4Jh2D8jJrSVe82bDQUcCL5HagV+Hga6zY68ksqnkO70
 02gw==
X-Gm-Message-State: AOJu0YxXbB43HDd4dGeUKhuZOnb6Eyl6urOwo/Z29pNGQkGsImAo49Q3
 IvyrPtDcwOj1630P8FU2gSe2Jc3FFZZ2cpkho17fcoGCV4lqDHq2xKZI9jelYS1j
X-Gm-Gg: ATEYQzzJnpxUZ6I7hXHwSWqlvWRlcKelgnmg99WPg0epUTAW+kKGdq7k/1qDFEr+mV2
 FjIKQ7D56D7qm3iUY+RtSczlXKVcDtJ0xDDxkv1rd2zXESr65JXgmnGuS1GvXYLGygcH9hjnTRI
 IuTNtMaG7AjxZtZwsup3BABOTpJkBNIwvrrbF16odlHGlj2EAPMriOZYwasXcOkZPRd15nn/8jq
 7MXishxBzUdYH//ifM4IN2rSAwYN80eP8m0zOEppws3bSI0ex62MtaRr/4RnQffER530U9EWd+q
 iRIJ/Fx9hkqY7Glx3DxzPXpAlsbwJyUkTtj4K9mb4aBRbAVP6hAk5KrNWAfMgCj2r2FAPuZ7cZa
 aGoHZU2TTnBBrp8iZt4AgpFl3nYleE1BbjBtz0FX3h+a3/pme8DkPc6/M904I2vX4NnOMb1t2Ng
 XlQoCYCOO/kTxBPwIqLl48oWX1i5k=
X-Received: by 2002:a05:600c:1991:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-48526977239mr32707805e9.32.1772803858820; 
 Fri, 06 Mar 2026 05:30:58 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm38145235e9.5.2026.03.06.05.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:58 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 07/17] net/dpaa2: fix spurious VLAN insertion on non-VLAN
 packets
Date: Fri,  6 Mar 2026 14:30:25 +0100
Message-ID: <20260306133035.179709-8-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

The VLAN insert check in dpaa2_dev_tx() tested the per-packet flag
OR the port-level txmode offload:

  if (ol_flags & RTE_MBUF_F_TX_VLAN ||
      txmode.offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT)

When VLAN_INSERT is enabled in txmode, this causes rte_vlan_insert()
to be called on every packet regardless of the per-packet flag, inserting
a VLAN header with whatever stale value is in vlan_tci (typically 0).

The port-level offload only advertises the capability. The actual trigger
must be the per-packet RTE_MBUF_F_TX_VLAN flag, as done by every other
DPDK driver (Intel, mlx5, virtio, vhost, af_packet, etc.).

Fixes: 0ebce6129bc6 ("net/dpaa2: support new ethdev offload APIs")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 7cbd3f33ae..5a98f295a7 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1346,10 +1346,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				    priv->bp_list->dpaa2_ops_index &&
 				    (*bufs)->nb_segs == 1 &&
 				    rte_mbuf_refcnt_read((*bufs)) == 1)) {
-					if (unlikely(((*bufs)->ol_flags
-						& RTE_MBUF_F_TX_VLAN) ||
-						(eth_data->dev_conf.txmode.offloads
-						& RTE_ETH_TX_OFFLOAD_VLAN_INSERT))) {
+					if (unlikely((*bufs)->ol_flags
+						& RTE_MBUF_F_TX_VLAN)) {
 						ret = rte_vlan_insert(bufs);
 						if (ret)
 							goto send_n_return;
@@ -1402,9 +1400,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto send_n_return;
 			}
 
-			if (unlikely(((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN) ||
-				(eth_data->dev_conf.txmode.offloads
-				& RTE_ETH_TX_OFFLOAD_VLAN_INSERT))) {
+			if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN)) {
 				int ret = rte_vlan_insert(bufs);
 				if (ret)
 					goto send_n_return;
-- 
2.43.0

