Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F3FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2207740689;
	Wed, 29 Apr 2026 20:21:06 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id AB60D4066D
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:21:03 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso206277eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777486863;
 x=1778091663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNcAC5m21zKhj5MDbqIxNvPeVwbJxFnOmyTkphm02jw=;
 b=kvF38HjXx0wjnKO/ZeBMb8Y5BmJqPzdqkwyEZfM2mijwDKqxhMAQkhWVlnajCGAWAj
 9vGPOcgkm6TnEoTlmUcNRatKMv9qRL/e8QB/m6os9gml1Nbgo3ZMWsIwEygZgCrR11QZ
 W3GHCqEU815B1upI+mSUeASEuxKAnA181xq4FpdcrNpOGScLMUraAdsI0FCb5t1WENUY
 3NB2jMyQQSywEP89ZtQsb5BzNYKhWTiGgxXHgVJI8LT/OhBwr4rgyPms0goAuaFUB+BH
 3S2kcGFpdsBNbPufaaN7OdFGJIQ5vNhP5JAFxMcEodqWJhvaQndWfLwFYnog7AA8XFGG
 fR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777486863; x=1778091663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xNcAC5m21zKhj5MDbqIxNvPeVwbJxFnOmyTkphm02jw=;
 b=Lzwew9c7CkNHU/c3SFd+/LW/VZt38x70RN31uo5iOFTfOXiBXD/DBSkiaBCYuDblI6
 Nq+H0uNrPXkgb/FdMmDN3FciBK3PqFDram982AZ+NQZOIVODZrHKGwe7IEIb+3mJC6ZU
 sAyMnRvASDy0e6M1n0CXGH2vo1g63s77gKuE1G7Vkl1xIuNGbLnO+hkbctHgiG7Za4Hm
 4b07jIQ9sPS7w4TZSjCpU9h6V5Np5WuFUpka3RqZ2k8TBYZdZc4sgZH7A9iDoaOjzFPa
 UTCyuw0JBYGpDbhp78IbpKqIc8pf1up8lIP61Kk8R+ydejI42NBuenphxejMSPwWEZiU
 +BLQ==
X-Gm-Message-State: AOJu0Yzr0fflhrCbWbpM4wmsXNZDpWBt2YyV3iVRcGbIL4cPuRy1biFh
 Sc4u8Nd04lq7KAisc8ue02Gkyd7C4NhfKPKvtXG5zGCrqlKwNJnkxXsEtOcusgweaVQKL6dERAh
 7Grgl
X-Gm-Gg: AeBDievfIx/9YLW20RCravESMQl0Fc2eq+iRNZc44WwLmWzIaEt10RGZ5oebpY4M/+M
 +LMtw6jMU+aA7DILDcaC3hMjdGLJpA6730yncHiarLjhpVBmDD5DvamiB0JvcB+1eOAdZy9GEhk
 W87CHTWMz/g42IZkoiSveO5uIkORc4c0DKqWg6n1QhSkVIG4MtiDsgUf4MpaU9G4TkEk2DCfs3b
 Ps2HTq1vK6XH1XwEpoAelQlh1a3bbB926HkXGJHQViuR7OVtkbb0lbTmli57ByYKuVfjRn7GJ/O
 47DUYoFvONl51kr9keU8Lxg0r/vlJRKaBI0IoQg/AjQjwGgp47GBZXQPdxwcsap2v8xGWm/a40A
 E9ZNSW04oLR75ipsNN3G0HGXuKvsXxO43+tRfiiAwCmBNRqm2tzcU47yZJAjtoL6WFpz6L2bDAv
 jsb4WNLlrhsApTT5ZOCNhOKK6AA1P0k8nsZJq4YDGu2ldgRQ5conQsfw==
X-Received: by 2002:a05:7300:8c88:b0:2d9:77e1:57d4 with SMTP id
 5a478bee46e88-2ed1990a82bmr2619774eec.29.1777486862520; 
 Wed, 29 Apr 2026 11:21:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e7absm3230152eec.10.2026.04.29.11.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:21:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH v6 2/3] net/af_packet: fix indentation
Date: Wed, 29 Apr 2026 11:19:00 -0700
Message-ID: <20260429182055.398105-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429182055.398105-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260429182055.398105-1-stephen@networkplumber.org>
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

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: stable@dpdk.org

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

