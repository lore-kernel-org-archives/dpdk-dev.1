Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F36DC7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 11:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B24942DA1;
	Thu, 19 Jun 2025 13:55:15 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 274704025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 13:55:14 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so450238b3a.2
 for <dev@dpdk.org>; Thu, 19 Jun 2025 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750334113; x=1750938913; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6/zsQYKVZ3izKdo35ReEx3qkwAC6Eyq8zBVoHJWeveQ=;
 b=mXWMYeOm7ZPn4SOIbedyBCz6pNmWU/9TxZ6uT8TGrMP8IedODqwhNS2UN+w1J7nbDx
 KEVGjaCdtzx/sAmehc9/tOBRu2wys9yw91p8I9dl8a8AKFgtDocAyLVAsBa9MLE3pW7c
 Uw5sj6f5GYhXFf3DT/8s2aKJoL9ocTKeYYpiny+ASzS1EPa6ln8mmOAvFyd/7fzNDSDp
 Y8iIzVpxCord4DSTleIsVGLRg9pEL/ya+A4vCJQg5tGOCAlMxjMQjI1n8MOhgGR4ZwP0
 AtfIbPgGA5E4w+cSUZm4CKEQGg9UicRWhgwKs9zbMeXOQRqLfp353YLcumfNgVcIomHN
 Dh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750334113; x=1750938913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/zsQYKVZ3izKdo35ReEx3qkwAC6Eyq8zBVoHJWeveQ=;
 b=vqKYUOrDude9xeMSfi1+Ec0ULG8vejO6fWuV9sJKzmitugPsMFSTETnmmBJndGvH+e
 cHu1fr/W9Ct1fZl2GfJLO6llM5OVc1GEcpiM1AenPLBKW9HdLiQhcSEl4PmYRf4KmIeQ
 LALerxTSv8nSVFhX5eYJ4IGS4YC6lMa7KHqlJKY5CyMUmzc/INupsgo6AUOZvsrwHRF7
 W2ruiIYxXN6kybppxv8wr4fNZhCjJ3quxv2fid5R7tUVMLYlDDzxhiVEiBGuVXRUOuYa
 F47p6C7JoYWkmJ35GMR64FaqrbzH/J4fnR5N5V97Qk2EpPhp3Gk+uCbKzGsGBydTWbtp
 tOpw==
X-Gm-Message-State: AOJu0YyUrEv9A0VQr6Cyn1sL2i4E8sK4H25hsjfnh9LNeRpxR1M5eXlW
 RF1UHTt4k2x5qhduf9G6TOofVmVZuAhUApUKyli1w5xWUE0blERzdmX3f+3INrP/
X-Gm-Gg: ASbGncuKhn2merp0DjqSwCjKkMLAM2TXLf+Ntt7i289yggTRNW376DpW8+6lgDugnvQ
 cMFu4kH8Qyn9lwolF2xlr4YaWYc10jm8QJjO1a5kTfmR1J0fOBAsygFTl8YFsWE4l/+Kidupofr
 nmsKHwOmIo2ZzpeRoq8wj1Wj08MrOdzDe8TtEjR0w/KhN6IvNEWbHbC4Obp7ueERF8K/bYP+zza
 nMyXOmWdhYTJF8QRU0CmkSl45UbheaWYmcMXXlznWUkD//WZUCTWA+SKW7FhFPWidxdOE1GabNh
 U5lAESBX/hapJaifQyWgQyYBOD+OnobQ3SXmoy8LepSQf1z7qmkbg2vY0UMHI07nQqPs0cjINkw
 H+vp95twB+TD5bZYoBk8nmxs=
X-Google-Smtp-Source: AGHT+IHXO64/jr4OlIC9cgM+4Mw+6aW29kYScLFB9Q5grLyzrhc8bfvma43VUv1yTTcReIDb+Pn9bw==
X-Received: by 2002:a05:6a00:1255:b0:748:33f3:8da3 with SMTP id
 d2e1a72fcca58-7489d0335f6mr28290381b3a.19.1750334112836; 
 Thu, 19 Jun 2025 04:55:12 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-748e8c829a4sm3566295b3a.83.2025.06.19.04.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 04:55:12 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: dev@dpdk.org
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] net/virtio: Implement {rxq,txq}_info_get callbacks
Date: Thu, 19 Jun 2025 11:54:44 +0000
Message-ID: <20250619115445.257679-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
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

Currently, there are no ways to retrieve the queue size
set by vhost backend. Implement the {rxq,txq}_info_get
callbacks so that DPDK applications can use the queue
size to setup mempool properly.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 drivers/net/virtio/virtio_ethdev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 2d2635b669..b61d251814 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -616,6 +616,28 @@ virtio_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	return 0;
 }
 
+static void
+virtio_rxq_info_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+		    struct rte_eth_rxq_info *qinfo)
+{
+	uint16_t vq_idx = 2 * rx_queue_id + VTNET_SQ_RQ_QUEUE_IDX;
+	struct virtio_hw *hw = dev->data->dev_private;
+	struct virtqueue *vq = hw->vqs[vq_idx];
+
+	qinfo->nb_desc = vq->vq_nentries;
+}
+
+static void
+virtio_txq_info_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+		    struct rte_eth_txq_info *qinfo)
+{
+	uint16_t vq_idx = 2 * tx_queue_id + VTNET_SQ_TQ_QUEUE_IDX;
+	struct virtio_hw *hw = dev->data->dev_private;
+	struct virtqueue *vq = hw->vqs[vq_idx];
+
+	qinfo->nb_desc = vq->vq_nentries;
+}
+
 /*
  * dev_ops for virtio, bare necessities for basic operation
  */
@@ -630,6 +652,8 @@ static const struct eth_dev_ops virtio_eth_dev_ops = {
 	.allmulticast_disable    = virtio_dev_allmulticast_disable,
 	.mtu_set                 = virtio_mtu_set,
 	.dev_infos_get           = virtio_dev_info_get,
+	.rxq_info_get            = virtio_rxq_info_get,
+	.txq_info_get            = virtio_txq_info_get,
 	.stats_get               = virtio_dev_stats_get,
 	.xstats_get              = virtio_dev_xstats_get,
 	.xstats_get_names        = virtio_dev_xstats_get_names,
-- 
2.43.5

