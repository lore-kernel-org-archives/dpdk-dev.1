Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4748C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F2240E24;
	Thu, 20 Aug 2026 07:25:20 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 0350A40693
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:18 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1581937a91.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203517;
 x=1787808317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v75l1CJ1N/isvvHkXdLcvNlUKMcyRgHKUCBNhlnnEH4=;
 b=S47JKMuBmmvN3VlfPj8B+2w8ryFScxrMVkoJIAz/4nxpqGxHpEfslJFWB6ZvyaO6pt
 OzX7MOwnBMJ0G8FIZ/tWlwW6OkQwyq23QJ0uHohsCw9GK1NqrLC8n1V3aaPS7DB3UL61
 uHMEaQ4sEJ8aSDNEdQVTeFx5v9DxoI4uhJZaUUoLvVzoGmdvI76FChd1jotE73M0Qgx7
 drrdrxRUhwjZYw1674jtTGlYJ9brY/fVdgzfrFghoaxGoSHQO6gNznuFi++4A3QPu9on
 MjGbjYYPi6wOwb151g3sLd241/YgwK6H3JjAM4nQq4oxVdVB+cs5zC8dLYHipcBACNPk
 VGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203517; x=1787808317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v75l1CJ1N/isvvHkXdLcvNlUKMcyRgHKUCBNhlnnEH4=;
 b=UDDhrKTzj1vsSJAEnIoBwgBLPkcsLslLNuj3ApBE64cG+LfK6YSv6xwD3zaQiutKIF
 uzf5XGAFPl3UhmRRb7XB1kObks6lt9asrwTcc9el3TroSDexmk/77tRFEDkdpr4fWyVj
 92hWPBNCx8Vg+0cW3afLEuON5++qJYkpkfCsfOlv6Oyh6JjISae787PfDpdTd6kNu6QA
 eJNxuY+fIMIWHRr2TEFy6lUhrMl6Wh0bdts1nEO1BArvwKgBTSbsCdQs6g5RiANv0YyE
 Obc44Op22uiJz9WpKpYYogv1uKFN0BV0HLGAgWJk2QD1bCGa2NNwNG3cHG9DB288OPVd
 tpqg==
X-Gm-Message-State: AFuF++m8qvqDxoulj48j9L8Jyz+i1PvqA2JgD514oX2PO+GvKkSv5OOp
 d1PkYj5pqG41KJ+0gO1HitrPx9BC0SBSRPeWf45lE1ZeqrxYQuaCVvX4Su53MCa5/+7OnXurflZ
 xtJ9V
X-Gm-Gg: AR+sD122AcpQBTrgUConomyxIp2ZgIsSuu2kKf7s1SnWG5ou4uoO97vkzH8ntMRhDjJ
 8hRO7TOXkJDZ6J3orKWHjjWZ1kVRhm6cByOVaoEIreKyG5Lb15zcqyc0VWhOu2DHPys+igNHPGB
 o2MPWsaSB7j6De2KX5VcnlrlH4+kEQyblfwpmQ+qj727q+pV5zwT2NNe/2Qhy9aFiNNTfzZegSt
 82HZq5rHoGoalFkPhcnDYaHaBxvbQGASTTqBRGW15PzFvK3O9iIu9QSFRc5oiXDeoJyMjs24CoG
 IliBqUIjocJyTcIOkNJ2SKVqH0txeVMe7tPDbbOVLoBK9tG+f4WGZIilX/kDgXpoYj2/t2dqHs1
 G4gxqNVn4xL3A2NqPFKMEYQztacYI02LXD22ZRPkLXk4V8MPN7IGz3tBlAwqGDzibbyODYt82yM
 HIa2cBDP2hG28GRswBkuM/CzqytoJCly4+JAVSGQBW+rl35iqlkB+nPQxNR69CGXY6wSw+m+tib
 ul4eNDSFlzR8V6ahm/5g8/3x+g=
X-Received: by 2002:a17:90b:28cd:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-395812a8b7emr19407478a91.6.1787203517061; 
 Wed, 19 Aug 2026 22:25:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH 37/61] net/null: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:27 -0700
Message-ID: <20260820052251.1453273-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The null driver is not used for high speed production traffic, so
any marginal performance difference from using regular memcpy() does
not matter. Regular memcpy() gets more compile time checking of the
arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 7fba3a661b..3e21649f6e 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -4,12 +4,12 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
@@ -121,7 +121,7 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		return 0;
 
 	for (i = 0; i < nb_bufs; i++) {
-		rte_memcpy(rte_pktmbuf_mtod(bufs[i], void *), h->dummy_packet,
+		memcpy(rte_pktmbuf_mtod(bufs[i], void *), h->dummy_packet,
 					packet_size);
 		bufs[i]->data_len = (uint16_t)packet_size;
 		bufs[i]->pkt_len = packet_size;
@@ -169,7 +169,7 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		struct rte_mbuf *m = bufs[i];
 		size_t len = RTE_MIN(h->internals->packet_size, m->data_len);
 
-		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
+		memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		bytes += m->pkt_len;
 	}
 
@@ -465,7 +465,7 @@ eth_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
 				rss_conf->rss_hf & internal->flow_type_rss_offloads;
 
 	if (rss_conf->rss_key)
-		rte_memcpy(internal->rss_key, rss_conf->rss_key, 40);
+		memcpy(internal->rss_key, rss_conf->rss_key, 40);
 
 	rte_spinlock_unlock(&internal->rss_lock);
 
@@ -482,7 +482,7 @@ eth_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 	rss_conf->rss_hf = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
 	if (rss_conf->rss_key)
-		rte_memcpy(rss_conf->rss_key, internal->rss_key, 40);
+		memcpy(rss_conf->rss_key, internal->rss_key, 40);
 
 	rte_spinlock_unlock(&internal->rss_lock);
 
@@ -577,7 +577,7 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	internals->flow_type_rss_offloads =  RTE_ETH_RSS_PROTO_MASK;
 	internals->reta_size = RTE_DIM(internals->reta_conf) * RTE_ETH_RETA_GROUP_SIZE;
 
-	rte_memcpy(internals->rss_key, default_rss_key, 40);
+	memcpy(internals->rss_key, default_rss_key, 40);
 
 	data = eth_dev->data;
 	data->nb_rx_queues = (uint16_t)nb_rx_queues;
-- 
2.53.0

