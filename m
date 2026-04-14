Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BBF9D0D6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 15:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF44B4064A;
	Tue, 14 Apr 2026 17:56:04 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 562D8402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 17:56:03 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2d64c756111so6431781eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776182162;
 x=1776786962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=zRd1czjibk7d5QV8CBBfT/I9faSHjGKLfhIAv9R5LKoZGv+aB4XL0EAHSsWwUklcRh
 Gv2aMF2whqnwyZOQHbv4yAI54PKBAJDtS3LvSlB0vYxEVCrSvuhy059e+frRKYQO77hV
 8/MfGv3ossgaN9ydy33qXWsIO1Tt2qqhkQzKvYsWVlY/ucYBrLV6ic6frcubW1ouJJfZ
 /d12lYdVwztM79HzwQc3zpMfjvt37GA8FOurk88UelQ502qKR3qfEHmGROhUkriL8xDo
 8Ec7IXdsdMDEdILwWQ58bGon9jFGo6/CX3nuqY//IIK61Rk+Wdp8Yf1e56oYUwkV2m71
 Ki+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776182162; x=1776786962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=hrks8ref2nS+8EkhHXAbHQKf49gT+PbYVcPoKwLJmCTvOhY39oLjvbIZOu9rGdrU2J
 QFNvg7IejXmAyuJytoXxqhyTx46qWb6EHDwy56c/Qqn2bgLODiDad9MuF5P+R40Kx/47
 OUiDY1BPF5qi2AuKmGGZhbCNWU8VR/1DjtReJ8j7e/lmpxWugASwSZw02mUl+itGiAIr
 n2Ci8L3gK2ZP1AMvnIgVEzSv8AqAvVs05lpyER48L3gqqzACAxO2QLnC8F4PFmgJK/No
 AnxrqlewqIfOT2w+tlxwTYeGqDLNM+8t6v78L7ITawhi9AJI3hXikbEl+PY/uAM5Thi8
 PAwA==
X-Gm-Message-State: AOJu0YwGJYARp6wd+rkKr+uBpXlKaGqtM5vv8c30RqassMJ10rEkYf5/
 A1fFMnE9PdSB5d2rm2AqCjO5sClGRExZbzKb4ylAdCo0xGqOHfNZo/mk1TiKSJ8sYf41rZCna1r
 Wd3vi
X-Gm-Gg: AeBDieuENRSKU59hRvH8m/GGugWuS10Y+YxazwEbfwO0hUOHXdIW4mFrKZhNopTA0z0
 fEtSlG1cJvZk1EFhqBnLQDA9wuAEhk5fhQv6XFdsaOVmQlUz7fHKeACiU8MT2GC1g/eqR2SjyZL
 5byu0z0ZijXSL2RWdoKXez8T7G31ZUD+gXcYqs4AhW7L4rIYJY1K3vM6FIUaLq+MVkc8HkwJiQz
 ma4ecnTlXxIQqUIzlH66L+D1Kj1EoOlPMDXqZ21TY/SCxpuTEMEZAGIgpoNgJwIwfYJBuBDAesw
 lVT8PfBUn/yOC1Z239up0lL5puY7sWGUqgVEUmQHeRmq0jp8Cx+hEFgJZl4N57HXgQDm7bkV2de
 wq22yt92yHI21IDsgScVzs8G1BFRhPAo13jEJPGUPUWr7SNv/EOeLyZRcQ9/FuhjHlSzPH2eOsw
 iaA1yGZmOTjgs3Fc8lzHaIHWBO0Sqi+dDjitGKI2eTuws=
X-Received: by 2002:a05:7301:1e91:b0:2c8:7172:3b7b with SMTP id
 5a478bee46e88-2d5881ace9amr11678786eec.18.1776182162352; 
 Tue, 14 Apr 2026 08:56:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d944769298sm9237476eec.5.2026.04.14.08.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 08:56:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH v2 1/2] net/af_packet: whitespace cleanup
Date: Tue, 14 Apr 2026 08:52:58 -0700
Message-ID: <20260414155537.718635-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414155537.718635-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260414155537.718635-1-stephen@networkplumber.org>
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

