Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02DF43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C390D4066A;
	Wed, 15 Apr 2026 16:52:32 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 50EC5402D5
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:52:31 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-126ea4b77adso16403093c88.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264750;
 x=1776869550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=Hvrqk4eZ3NQPro/FsBhx0PrAF8YX2w5AklFNhgA39rG4tawCyuvD9rujCDmuwLnaQl
 g6X4cH4LINZ4pOM3eRp9wrEzoeWBw7GqbwyXlNk2hLTvIDkxgFbLzRR0pFX1SsPpIh/n
 foTYNiUwQum1YC9yJboSAyzH1gbn3pvE2RuuMzOyOIHgcsdb+zTSYl61i+TMUCNRPnMN
 DvmcUlOEW2aI8FJiHW+vOK7pdU6ZbMJPTUhPiCLwGngOSSVY5VB+GQh/u6G+CZupyyz6
 kxUuqATuW4L6bjPSHAu5KXrEY4d5xtNmNQnAxPe+uGJCCm6dDIAyjkMEn4IkjapWHRvf
 8jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264750; x=1776869550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=KqB8MmMPQc4uI+KPnRXeZFOr6utU8vmuvWEZCq1wj6I5c3SI36kyiLrN5XvVGp5zMG
 gJ+eaj40cpG61Zm8ZLdLiUZ54r4h6bbZD9TPdXkbL+6YxcHIh/t+lF7xN82Xu+I0fWQ8
 FgxvxonS5uDF/3fFnHz7PKX0/0t1UmU2FTShW/rhhVS1EwL4B/hplUzIFEJHnF8FsG4M
 8LSadEOh/lkvQGGO4et1snQjJUWZ8ikzC2owWj6igd1yri2K2CuiGCiuzlUcjaeVIozU
 e0tCIyEEvTRhbLh1k7yqZ/F1XVP1vsRzrvp/TeO12xAssRnRmEeO+FeW/Fjwcj/Vq0Cg
 QEUA==
X-Gm-Message-State: AOJu0YxpK33WpYaVEVA/QPaRwL9iOR9AxLhCV6HY8LT7lErvN3Ye52Kv
 DXT9FPiJM40+cQDALQOPxYxyYbHjFoPS9kdIg4skeiPVTov+u6G4drSSrMVVOaTY7O8BKTcAi8l
 awFBT
X-Gm-Gg: AeBDietJ6GoE+PIbQkFN81aJzuRjBZVpYxvtEzDT6pobzVm4qkeSEnfy/mfbAF3FN+O
 eBEhxmob5IlboyCuq8f1DHuP6n/SIB/moCYDZHbn2THom/1tUi2rttBbCehLhyY/OQhXKnW6MlV
 3io6XuM0XVWJqZCWJBltEh/2wUWQU7P3ni1zOPsC0I++nif6dOooFB31DleN9gTkm2doEVlmKtk
 HYKAFkv+dWPYEAssCMuOfEoEVHc8O5CvL2Tmx21Ud5YpJ6ePDreFY6Wj2v8TIS/dIqbSuTusYOZ
 Mcj3wLR04uk51peZS8a/Wp629F2aWM9O4nGWPOc/cAyo7tOgUgtDUdx3s/SBEYZmhqmQcsLZoCM
 eKBLAm6tVqIXHj3beXiyY0SOGiVGnv6Sr4TYXO7k/dnLo8ELH5SPD4QotS3yo5gUUmc4zxRtdFO
 zylAAx08Q8gKDEAApew5Ek/VYhzriy0FNEj30uJfrtQDU=
X-Received: by 2002:a05:7022:23a2:b0:128:cc34:35fc with SMTP id
 a92af1059eb24-12c34ea5acfmr13150952c88.16.1776264750123; 
 Wed, 15 Apr 2026 07:52:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e6a8778sm2055529c88.9.2026.04.15.07.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:52:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH v3 1/2] net/af_packet: fix indentation
Date: Wed, 15 Apr 2026 07:51:39 -0700
Message-ID: <20260415145226.259277-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415145226.259277-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260415145226.259277-1-stephen@networkplumber.org>
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

DPDK code is supposed to be indented with TABS not spaces.
Also, used "unsigned int" to keep checkpatch happy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 64 +++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 0ee94e71ea..8303ff5ca9 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -79,7 +79,7 @@ struct __rte_cache_aligned pkt_tx_queue {
 };
 
 struct pmd_internals {
-	unsigned nb_queues;
+	unsigned int nb_queues;
 
 	int if_index;
 	char *if_name;
@@ -602,7 +602,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 
 static int
 eth_link_update(struct rte_eth_dev *dev,
-                int wait_to_complete __rte_unused)
+		int wait_to_complete __rte_unused)
 {
 	const struct pmd_internals *internals = dev->data->dev_private;
 	struct rte_eth_link *dev_link = &dev->data->dev_link;
@@ -622,11 +622,11 @@ eth_link_update(struct rte_eth_dev *dev,
 
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev,
-                   uint16_t rx_queue_id,
-                   uint16_t nb_rx_desc __rte_unused,
-                   unsigned int socket_id __rte_unused,
-                   const struct rte_eth_rxconf *rx_conf __rte_unused,
-                   struct rte_mempool *mb_pool)
+		   uint16_t rx_queue_id,
+		   uint16_t nb_rx_desc __rte_unused,
+		   unsigned int socket_id __rte_unused,
+		   const struct rte_eth_rxconf *rx_conf __rte_unused,
+		   struct rte_mempool *mb_pool)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pkt_rx_queue *pkt_q = &internals->rx_queue[rx_queue_id];
@@ -660,10 +660,10 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 
 static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
-                   uint16_t tx_queue_id,
-                   uint16_t nb_tx_desc __rte_unused,
-                   unsigned int socket_id __rte_unused,
-                   const struct rte_eth_txconf *tx_conf __rte_unused)
+		   uint16_t tx_queue_id,
+		   uint16_t nb_tx_desc __rte_unused,
+		   unsigned int socket_id __rte_unused,
+		   const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -790,8 +790,8 @@ static const struct eth_dev_ops ops = {
  */
 static int
 open_packet_iface(const char *key __rte_unused,
-                  const char *value __rte_unused,
-                  void *extra_args)
+		  const char *value __rte_unused,
+		  void *extra_args)
 {
 	int *sockfd = extra_args;
 
@@ -854,17 +854,17 @@ get_fanout(const char *fanout_mode, int if_index)
 
 static int
 rte_pmd_init_internals(struct rte_vdev_device *dev,
-                       const int sockfd,
-                       const unsigned nb_queues,
-                       unsigned int blocksize,
-                       unsigned int blockcnt,
-                       unsigned int framesize,
-                       unsigned int framecnt,
+		       const int sockfd,
+		       const unsigned int nb_queues,
+		       unsigned int blocksize,
+		       unsigned int blockcnt,
+		       unsigned int framesize,
+		       unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
-                       struct pmd_internals **internals,
-                       struct rte_eth_dev **eth_dev,
-                       struct rte_kvargs *kvlist)
+		       struct pmd_internals **internals,
+		       struct rte_eth_dev **eth_dev,
+		       struct rte_kvargs *kvlist)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
@@ -890,7 +890,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	if (pair == NULL) {
 		PMD_LOG(ERR,
 			"%s: no interface specified for AF_PACKET ethdev",
-		        name);
+			name);
 		return -1;
 	}
 
@@ -899,7 +899,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		name, numa_node);
 
 	*internals = rte_zmalloc_socket(name, sizeof(**internals),
-	                                0, numa_node);
+					0, numa_node);
 	if (*internals == NULL)
 		return -1;
 
@@ -1140,8 +1140,8 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 static int
 rte_eth_from_packet(struct rte_vdev_device *dev,
-                    int const *sockfd,
-                    struct rte_kvargs *kvlist)
+		    int const *sockfd,
+		    struct rte_kvargs *kvlist)
 {
 	const char *name = rte_vdev_device_name(dev);
 	struct pmd_internals *internals = NULL;
@@ -1172,7 +1172,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (qpairs < 1) {
 				PMD_LOG(ERR,
 					"%s: invalid qpairs value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1182,7 +1182,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!blocksize) {
 				PMD_LOG(ERR,
 					"%s: invalid blocksize value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1192,7 +1192,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!framesize) {
 				PMD_LOG(ERR,
 					"%s: invalid framesize value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1202,7 +1202,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!framecount) {
 				PMD_LOG(ERR,
 					"%s: invalid framecount value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1226,7 +1226,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	if (framesize > blocksize) {
 		PMD_LOG(ERR,
 			"%s: AF_PACKET MMAP frame size exceeds block size!",
-		        name);
+			name);
 		return -1;
 	}
 
@@ -1301,7 +1301,7 @@ rte_pmd_af_packet_probe(struct rte_vdev_device *dev)
 	if (rte_kvargs_count(kvlist, ETH_AF_PACKET_IFACE_ARG) == 1) {
 
 		ret = rte_kvargs_process(kvlist, ETH_AF_PACKET_IFACE_ARG,
-		                         &open_packet_iface, &sockfd);
+					 &open_packet_iface, &sockfd);
 		if (ret < 0)
 			goto exit;
 	}
-- 
2.53.0

