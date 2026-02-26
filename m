Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC8FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 924D140B8D;
	Thu, 26 Feb 2026 15:34:17 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 98A874066C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:09 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so776140f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116449; x=1772721249; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5y2SZzFIAuEPMK6wgy0msC/dZZnH9eWRkPVhWq2z5g=;
 b=bD/1UPwufWIodbbnqQASPsEcXENBHfrzUOWnfJHPD0LcqDwwWgrleHYGnZWX9kI1Jo
 joi46mo2tdA+Zgg4EKPnujxz7qmFe9cAVhCkpxOJaSAoL1CvROORmJ9mVy3+ZHFMnSLZ
 7u8MIohJL81TkVarSvSHWiLqSkKFvMvc8mprfMbz/DixmLdt7M/ubyaMEWkar95m+jYf
 K9DmG4hKRZz6vZVpAOiebrZ+RMEbi4x812rTtTfcRKWZkwnYz/YwnpPPAJqAVsN5CkYW
 LzpFbG3QUnz5vLFXi+adz7N4KLnCBNV7+Qrb4EQpRuiCFECLhRUmPLVNIz+ZKeLiwSqp
 I/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116449; x=1772721249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5y2SZzFIAuEPMK6wgy0msC/dZZnH9eWRkPVhWq2z5g=;
 b=YhjcA6bNC2NJ6Oy9Q9YzGPvgrJn6R/Nsqi7wPwXsAnTdA3TiSk6mG5sWnNTNNb6fFC
 Gq+Kd/ReowETLB7Z/d6mGmqlYKRZmXSY1R0d9l6w5x4hjs/MWr5R66CQnSP4mFfclFMg
 5PkNu9okaGhbCI/2ZWeJ00jKOxY36wPm2mdVitf4hCJLmOxX8omqlqg08OLlBsueMFU6
 XdTNlTIDRrX7h3CdFHc4lEYJVNQ8vRabFZ3VHbh7N6paCrHtADeqqUgzFccuF/uj/AQO
 7Nx7i5FMI25M++wN8/72jq4NrqpEGVLLjBY41CdXxVt7iveN3eqfC50BEFEaIg2r+F7b
 5Gyw==
X-Gm-Message-State: AOJu0YwZMT98wM9D6RZWRgYOTyV6bAVAt2eV2ULQg8uxxnu/nzeuXIIt
 epVAoEKu69D+uJVgD/HGVwavH1JtkVk5VmNekOqRqtN1N4b2aAR8L/NaXMG3Cw==
X-Gm-Gg: ATEYQzz5/T88QYwf646W8WeGC+Mryw1ErcpyRMwefIn73hkftuabwbb2RoFoW6ySmfp
 TLiAZGWmx2Jgl25Id0LZEhC8+S2CdwWum0N1+l45lWsmgFbDhb19QjXtvJrJX1KZtDBtiM9Xg2a
 y+cddc75unjMlGRsOSx6+71rEwllaNDXTziDpuPRtZ72e0aEXG8JkYlDE3wr8mdZQrtlXJSgIDo
 X5GwfNVdZ/gG9YF6dc7o+xGHSL4leHO0EFRiqwkDgf0xHU9lxexIUiI+81BQjdnXYgAZ+pmp3+3
 YB4PvPL4mGI1sBPmIYzd93X53/UXmIPYKWf9k+nTN59gjbpTvbAEqsQ48/zCbDxQWS6l1paNw0A
 uOBRqM1TuoTsP3qPJWkFAJLDKuPy3sy5Qq8abiz6gYc1iU3SUNJSCJdMAXt9ic5zMQKvioYxSuZ
 NRMDMJyND8UkkH/CF9iBESYwfTFw==
X-Received: by 2002:a05:6000:2382:b0:437:69ee:71f4 with SMTP id
 ffacd0b85a97d-439942ed2camr8360789f8f.28.1772116449063; 
 Thu, 26 Feb 2026 06:34:09 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:08 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 07/17] net/dpaa2: fix spurious VLAN insertion on non-VLAN
 packets
Date: Thu, 26 Feb 2026 15:33:31 +0100
Message-ID: <20260226143341.282188-8-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Fixes: 9e5c3d3c7778 ("net/dpaa2: support VLAN insert offload")
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

