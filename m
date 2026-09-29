Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE7CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD67F42E9E;
	Tue, 29 Sep 2026 16:04:45 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 3BB0E42E50
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:35 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86e6d007703so1937609b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690674;
 x=1791295474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PafnO8yitkD97P3tBWViSF7bQqlmStd0Wtmi7Lexpqc=;
 b=R1qPda6mUb/LqA+MKAO/lV7CuJjnbsKcwJGd7dTOBqxsVOHE9M1ni9yy03OALZm81A
 Q38Nellbr8dGexfvP4CISnd/llTPOW6W3sYg+SjZaWsaP1I/yPAdffQJYjo/Kx12wiNV
 otEdJpk7j50MMAx0DEh+6/p0+gd4sPTe2tuza54Lwx2JLCQ7zeBE776PocAvv9iv6YR9
 KfNhraWlHPrNeuA863ucoqIqs1dFKQOkqOgNFm7Vr4Pfc0ZvHRyJm93iITArKvwfqZzf
 d5/SU0ITVxoW8j+54rh7iSLFh25KVePEtc4aCWlhloDg4cUmPwQz8cu4I7E052YSqrQn
 Ob/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690674; x=1791295474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PafnO8yitkD97P3tBWViSF7bQqlmStd0Wtmi7Lexpqc=;
 b=h3ygV4L/FtinTYWHc8kLJMk4in5Zhv5PqAOfaUwx3jOGJCwh7tP8WzqitXtG3WUt5S
 86TG7JXv1Qfti0qYQNl6NcR9a6WH5eAoCkDaDTKp6DU5fZbQ0viUVUEMRQd3q47DrBxW
 XY8yzhg0h+33dnnyOITjy2KTuBw2yGhGkFgaNt7vum0TaA9ZfF+jhGRj9iq2kjj8L0g9
 3houA+89BygfqXjruUg5Mn9sYOJSKEp51A6/SdqnVkx9gbsckvqADja5CxSlY/KsNhgS
 KX5MKndqmhve5tCJxr6uWVv1NvaLsEwVi/nmSZTYhjraGARs9HTnqYkllPI+jSngaTB/
 NLGw==
X-Gm-Message-State: AFuF++myYnDWufZiEX3SxF3oCKvUUzwobfaXLPebt74L2Zq69bQ4Hkc+
 12u4R/CEVzmUlBIxorWPbIT/QEx19uphKGveoXr7xADiv3FkO3sRVryDsbNS6cK3YcoiLYzzjuh
 Jzew2YYU=
X-Gm-Gg: AYBFou2Oa+7/vkDLJrbGVNfnnr852Ip1gYtxg792JoWTv3sYxRp6QCl2uWfHkutCwqf
 z6ImhKkOSFquuLQqTkecws+sQwJjKex6aj0Oj1fjLA0W3/eNZHFmK3DCc2mquwWjbusCtqQFq0W
 f4ZIM3BOqcsHjjTawLuyDqu4H/zV+FDJk8hnsL95CBJ/qg74UZi3+3bj8oKha6H2nxL9WSIFJyn
 mMIOhnbc1OAdC1Px0fljqY+NWssfRBZNphb8FcNjGzWJvi+MzK2eweuyhIOPasl2UPYTKQVl6vU
 2LkFpr+MzPboKw7BT+Y0iTbkx4mxS2xZqTnpDjpefTSfl7efPcaQ18KwcRSeGM4Iudmdw40XXlk
 SLXMsi9u27oCXI0rxTg0V3BmItglvejAnWJ9TDzD55JRuu9ADSFMdGTKyUkmtn6qNmNcc0HZiWx
 sfjtGj9h2XtWje0SOytKnb27SODsQ/VwqXX6Oft7DKCBKYekR4FywSOIR0v6O/6mcIkII++vAtC
 TwCIRFbbwR/egsg4eAkNpl6jShSigxWbVRyAQ==
X-Received: by 2002:a05:6a00:c242:10b0:880:5a44:9367 with SMTP id
 d2e1a72fcca58-8805a449a95mr5909517b3a.30.1790690674368; 
 Tue, 29 Sep 2026 07:04:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v9 21/25] net/vhost: use stdatomic for state flags
Date: Tue, 29 Sep 2026 07:02:07 -0700
Message-ID: <20260929140409.234453-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

The flags started and dev_attached are consulted only inside
update_queuing_status, where the per-queue handshake provides the
real synchronization; their loads and stores are relaxed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 56c7a973e9..07d3d15781 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -86,14 +86,14 @@ struct vhost_queue {
 };
 
 struct pmd_internal {
-	rte_atomic32_t dev_attached;
+	RTE_ATOMIC(uint32_t) dev_attached;
 	char *iface_name;
 	uint64_t flags;
 	uint64_t disable_flags;
 	uint64_t features;
 	uint16_t max_queues;
 	int vid;
-	rte_atomic32_t started;
+	RTE_ATOMIC(uint32_t) started;
 	bool vlan_strip;
 	bool rx_sw_csum;
 	bool tx_sw_csum;
@@ -756,8 +756,12 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 	if (!dev->data->rx_queues || !dev->data->tx_queues)
 		return;
 
-	if (rte_atomic32_read(&internal->started) == 0 ||
-	    rte_atomic32_read(&internal->dev_attached) == 0)
+	/* These are control-plane flags consulted only here;
+	 * the real data-path handshake is on vq->allow_queuing below.
+	 * Relaxed is sufficient.
+	 */
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 0 ||
+	    rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed) == 0)
 		allow_queuing = 0;
 
 	state = vring_states[dev->data->port_id];
@@ -848,7 +852,7 @@ new_device(int vid)
 	}
 
 	internal->vid = vid;
-	if (rte_atomic32_read(&internal->started) == 1) {
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 1) {
 		queue_setup(eth_dev, internal);
 		if (dev_conf->intr_conf.rxq)
 			eth_vhost_configure_intr(eth_dev);
@@ -863,7 +867,7 @@ new_device(int vid)
 
 	vhost_dev_csum_configure(eth_dev);
 
-	rte_atomic32_set(&internal->dev_attached, 1);
+	rte_atomic_store_explicit(&internal->dev_attached, 1, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, false);
 
 	VHOST_LOG_LINE(INFO, "Vhost device %d created", vid);
@@ -893,7 +897,7 @@ destroy_device(int vid)
 	eth_dev = list->eth_dev;
 	internal = eth_dev->data->dev_private;
 
-	rte_atomic32_set(&internal->dev_attached, 0);
+	rte_atomic_store_explicit(&internal->dev_attached, 0, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, true);
 	eth_vhost_unconfigure_intr(eth_dev);
 
@@ -1148,11 +1152,11 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
 	}
 
 	queue_setup(eth_dev, internal);
-	if (rte_atomic32_read(&internal->dev_attached) == 1 &&
+	if (rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed) == 1 &&
 			dev_conf->intr_conf.rxq)
 		eth_vhost_configure_intr(eth_dev);
 
-	rte_atomic32_set(&internal->started, 1);
+	rte_atomic_store_explicit(&internal->started, 1, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, false);
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
@@ -1170,7 +1174,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	uint16_t i;
 
 	dev->data->dev_started = 0;
-	rte_atomic32_set(&internal->started, 0);
+	rte_atomic_store_explicit(&internal->started, 0, rte_memory_order_relaxed);
 	update_queuing_status(dev, true);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -1469,8 +1473,10 @@ vhost_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	fprintf(f, "features: 0x%" PRIx64 "\n", internal->features);
 	fprintf(f, "max_queues: %u\n", internal->max_queues);
 	fprintf(f, "vid: %d\n", internal->vid);
-	fprintf(f, "started: %d\n", rte_atomic32_read(&internal->started));
-	fprintf(f, "dev_attached: %d\n", rte_atomic32_read(&internal->dev_attached));
+	fprintf(f, "started: %u\n",
+		rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed));
+	fprintf(f, "dev_attached: %u\n",
+		rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed));
 	fprintf(f, "vlan_strip: %d\n", internal->vlan_strip);
 	fprintf(f, "rx_sw_csum: %d\n", internal->rx_sw_csum);
 	fprintf(f, "tx_sw_csum: %d\n", internal->tx_sw_csum);
-- 
2.53.0

