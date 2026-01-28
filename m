Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D2D46BE2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5A440664;
	Wed, 28 Jan 2026 18:31:50 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 37E0B40665
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:31:48 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48069a48629so1109485e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621508;
 x=1770226308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y45VhQnUXsvLiIxs1yi2SGWkJcPB6sTYGBIiiH5SKM=;
 b=Klk2WUZoCVHTFahCGd1E1Is4A8KBAwOj+vwqhaeRFDDukCkZUsW1V9IhY9P+LVm/QF
 dofQbJaZZFAw6386gjCslPeYh51xENWBmT2y8PU+QK2Qv6bW+j3icpFQ5kX9x6UA0Nr8
 pH4n/vO9shVFVhnWFcmGkhw+uiXOPh5QfBsdK1sge2g61A3fedkV+HaZN8wnn4yFk2dE
 SDgWHMspwevMQmVcEO6QaodytwHdrM73Yif5ie6teCTcqW4T0exB8nAJyneTKwRvaSdI
 6Mm3Jf0xiQA6pyWGdViFDnSNvaMaQgk96MwN+evnrZxFswCct9HC86qcWotC9kPKbazM
 8elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621508; x=1770226308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+y45VhQnUXsvLiIxs1yi2SGWkJcPB6sTYGBIiiH5SKM=;
 b=ICs/zHPR+n+5xP/p5E1lo8GTyXj3pedKvPSa0VQGjrB6Dwc7dp2b/DDGnwaPRkeb5g
 /mhBgAEb+f20kT3gJWg2vlPy7DnXM3Z4Ee/50UwusWg6+aN2qTup7cZOGXeGLr8DGLKY
 i8k9BnQopY1Oq+4/DVdPNBcPlMjrK2juRa+8zTD/vJXJasnLoo0jH6bmMtI1v0TYmmFP
 VbbzpVMQcn03/TrUJkRy/zpqjP6Mxg/PzkA9xEVmDz7Du3btIGmgZchVYsLCCobWWJ2n
 s6U/IwrpZpP8zjZ/ba6s4cJ/vqcC7p9D2O3IJF2BUddmN4Cg/dEJl8aB9fAdt5UUP2uz
 gL0A==
X-Gm-Message-State: AOJu0YygsQCkuXu3BIckuYgcBr9ZCMhkaCOqxGyQ541CwFOao5W/HU34
 XtUe3wlW7txWiLfXXLrRiTEvE6QhpAdRmnD20W0UPXOqrUGFfPcTwWHv++D0lruUS6PotLFZ1EZ
 Uju0S
X-Gm-Gg: AZuq6aLLwu2vHLRdIsTCIFZS46q0d3o0aztWiivUtzk8pxrSylbqRYkUjq7v3o3MuAx
 aHsQtWVveA8vSLUkbIvRnT5+uWeoolHB5AINaPewijrdVjhigPt9ImQ9Mt2Y8oxqsOzEwxMH2+o
 w1l5aNqY/7nvMAsiFAGAEphFFBAyIHtMy00SKicAa9MitpDroG4puKoonqMgcjukp83SN1AR1UT
 7DIVJzIex8BBGWpPFOH/08KgICZz7WONQuels/KKH2F36tXxWXLpi1xY1JUECzmRIhnGB5mvWYU
 TT+otEfuD6Z13xJ+MF9winj6UaTbj4gZGMkDOu7xTKUGiIllzUeo961JTtynfQYvwmQkt5/F1av
 c37yBctABAoMIjs0wWXoMYeYlHfA3yngmCWg74kX6/I5WNNQzCwCzYehU3aDhIu0AvK1w22siWW
 FhNuxBqR5dKnpBunT+DMVDANUPhRp06lWxus6vpCb4gZl9T4mxpQ==
X-Received: by 2002:a05:600c:8211:b0:480:4c45:aff5 with SMTP id
 5b1f17b1804b1-48069c755e6mr67446005e9.34.1769621507720; 
 Wed, 28 Jan 2026 09:31:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133732875e9.7.2026.01.28.09.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:31:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [RFC 3/4] net/af_packet: fix indentation
Date: Wed, 28 Jan 2026 09:30:19 -0800
Message-ID: <20260128173138.151837-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128173138.151837-1-stephen@networkplumber.org>
References: <20260128173138.151837-1-stephen@networkplumber.org>
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
index 158393dd70..5847e14d80 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -78,7 +78,7 @@ struct __rte_cache_aligned pkt_tx_queue {
 };
 
 struct pmd_internals {
-	unsigned nb_queues;
+	unsigned int nb_queues;
 
 	int if_index;
 	char *if_name;
@@ -537,7 +537,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 
 static int
 eth_link_update(struct rte_eth_dev *dev,
-                int wait_to_complete __rte_unused)
+		int wait_to_complete __rte_unused)
 {
 	const struct pmd_internals *internals = dev->data->dev_private;
 	struct rte_eth_link *dev_link = &dev->data->dev_link;
@@ -557,11 +557,11 @@ eth_link_update(struct rte_eth_dev *dev,
 
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
@@ -592,10 +592,10 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 
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
@@ -722,8 +722,8 @@ static const struct eth_dev_ops ops = {
  */
 static int
 open_packet_iface(const char *key __rte_unused,
-                  const char *value __rte_unused,
-                  void *extra_args)
+		  const char *value __rte_unused,
+		  void *extra_args)
 {
 	int *sockfd = extra_args;
 
@@ -786,17 +786,17 @@ get_fanout(const char *fanout_mode, int if_index)
 
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
@@ -822,7 +822,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	if (pair == NULL) {
 		PMD_LOG(ERR,
 			"%s: no interface specified for AF_PACKET ethdev",
-		        name);
+			name);
 		return -1;
 	}
 
@@ -831,7 +831,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		name, numa_node);
 
 	*internals = rte_zmalloc_socket(name, sizeof(**internals),
-	                                0, numa_node);
+					0, numa_node);
 	if (*internals == NULL)
 		return -1;
 
@@ -1072,8 +1072,8 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 static int
 rte_eth_from_packet(struct rte_vdev_device *dev,
-                    int const *sockfd,
-                    struct rte_kvargs *kvlist)
+		    int const *sockfd,
+		    struct rte_kvargs *kvlist)
 {
 	const char *name = rte_vdev_device_name(dev);
 	struct pmd_internals *internals = NULL;
@@ -1104,7 +1104,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (qpairs < 1) {
 				PMD_LOG(ERR,
 					"%s: invalid qpairs value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1114,7 +1114,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!blocksize) {
 				PMD_LOG(ERR,
 					"%s: invalid blocksize value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1124,7 +1124,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!framesize) {
 				PMD_LOG(ERR,
 					"%s: invalid framesize value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1134,7 +1134,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			if (!framecount) {
 				PMD_LOG(ERR,
 					"%s: invalid framecount value",
-				        name);
+					name);
 				return -1;
 			}
 			continue;
@@ -1158,7 +1158,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	if (framesize > blocksize) {
 		PMD_LOG(ERR,
 			"%s: AF_PACKET MMAP frame size exceeds block size!",
-		        name);
+			name);
 		return -1;
 	}
 
@@ -1233,7 +1233,7 @@ rte_pmd_af_packet_probe(struct rte_vdev_device *dev)
 	if (rte_kvargs_count(kvlist, ETH_AF_PACKET_IFACE_ARG) == 1) {
 
 		ret = rte_kvargs_process(kvlist, ETH_AF_PACKET_IFACE_ARG,
-		                         &open_packet_iface, &sockfd);
+					 &open_packet_iface, &sockfd);
 		if (ret < 0)
 			goto exit;
 	}
-- 
2.51.0

