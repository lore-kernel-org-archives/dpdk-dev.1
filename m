Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8119F531DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 23:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE60A402B3;
	Tue, 14 Apr 2026 01:00:26 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 3F248402A3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 01:00:25 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12c555f886dso710455c88.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776121224;
 x=1776726024; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=vcSKB1Is0+/lqs0fKyqB2Qxf7SAqxalEVT9XgL8+YHYkIxUagiIoRz/IJXHb+YKO52
 cniNiexixrwn1mPgNGCbFOY5+0zrjJASiA2Ndw1SXwrEaTVTDMtFswKcb5Dm1Wf8kpx0
 xiEee6PC8j9pExl1akKy7pzBcSljeBtfD6qUlqUlG/jLvj3vEvs9AYtjUQGW11UAL/LP
 SGsd5MVfp5uVqhwY68dt5nPor8Cn1HOBga/X1YONKt47VkFyOduommneiLv20Qju0rLH
 ZxP1tM56gI7/1wCgxgiywKwWU+1eIr1Hea9MFZLTE/zWReZS9Tl4XBX1iVah0tA3SowS
 80YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121224; x=1776726024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=oOBFq4bNMxbp1mmdokRlrnm1csIyGsYa5gs1ULqga03OYiRmjTXbhsp0Y883cug/6f
 lpKWGMRL10c0VXbVyarzCOcvvtu8exFicRsI81yMZwtnJy1IIhWkGYIPSxUYaSyOnix2
 qUrg2aQGCuvFAN2qW1O/cW5czEb4XMNUuJfyPl5LbPcUCYRjc6ezJYrrs0GcLzvnd7L9
 BLDqGqJJ0CuZaxfFFgoA1agWKJYG0qkrV94mQxtbKdgNOhMhsGWEpXxLmEj5b5eF05z6
 xEFFOYRh1u56AjGbagduTGeTQAFuAR9eeRYAbi0rels/lR/WiCz4VQLxOiQpphe57d2K
 JPXw==
X-Gm-Message-State: AOJu0YyWXI6vsO4+uX3klxnsbAdwKiAKAjRIB5Jz4NEjoDT+xWKp2RyI
 QSgwErLKbwE5wtK82mYG9Xypl9gHlZ5Z74vMp39qxwRBXkRUoPuyAVDrgX8a0L2IGOXD2vMOomx
 l33TZ
X-Gm-Gg: AeBDiesvXRhuvsbeisUIpr6xB9iechWEnLikeMqGFkPopeNj/URAmFMYeXnzB/MbcxN
 kv7oNz/pgsoTCSHdmUg95V+5T8hWqM5VmzEUfl4yC0RJN4uP8rpisrWbcYnKvkdy2JucbQG2uMq
 Zu/xatJ1Q1xPGUSq+itkYlp+p/9Pl+n371jaFih0aBPAASYY1x4Vc6QQFTg8vNBn2JReGRkty2T
 bpbQcWIpkggPGZS8DnE1Xud4XaKS8N2Sq1uuCg2i2PUjCgaepf9ny8nBJJytYhHw/SiqHpM55/J
 cDrfPCwWtqI8b+Ifx+xZ40C4przyZplqJrQTlzqZMe8wM75ynyPRyEbR6lckp3P9iiEx79YTTT/
 cOT5K23UV7fAiIvYJyE7jesPeVwu50N9RofYnKE7SpIHGniZmZt4Lfiazxjmdt+XgDfcdyRAzBG
 lk48OpVmir/390NuPqw/pKVLxJkQ2deqEzAi1qmw5GAww=
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-12c34dbeaddmr9300339c88.0.1776121221547; 
 Mon, 13 Apr 2026 16:00:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c34acb077sm14983741c88.6.2026.04.13.16.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:00:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH 1/2] net/af_packet: fix indentation
Date: Mon, 13 Apr 2026 16:00:16 -0700
Message-ID: <20260413230018.515837-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

