Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BAFF886D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 14:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E5A040656;
	Tue, 28 Apr 2026 16:14:57 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 9BCCF40431
 for <dev@dpdk.org>; Tue, 28 Apr 2026 16:14:55 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c8c9c4cd8so4545369c88.0
 for <dev@dpdk.org>; Tue, 28 Apr 2026 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777385695;
 x=1777990495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=UZeZOK9vC7vtnupIzy3vAULDwOYkhYn5ze9n5++58a8ayMp/yWtgw35dIO0c3kKnYF
 xL5OCZjbtNmEVsTNUCShWmoorDoOR5lgcvapuf0UUiuKxlED9By1uE9U3PW4av7SbkBD
 s/iqCNYaFNbWHR/MEc9+feH4pxegSPzsCrQw4HeDG/ONzEP0eRG0ciRJr9L8H4FmpCWJ
 k4gPkaKlmxvQwVr9Mw5BknDFwdQFrk0S++LD/TSWmr7BXPUxELpg/g8f/GoMXK4uv5wb
 YT2WRqYtwJdUV/S+KzokXvA/mFOyKA1H9RoGgZiH77LbsZ0OuNigXppqQqOAQljOXmWA
 rXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385695; x=1777990495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5txkI5GMZ1jDnZfYhzGSNGb2cVVNGxy1SomF30Pjiuo=;
 b=TuMLjDIO4qNG0q9Lb5D2AcIIRuEi/tmfrxVgEYv0mcUKtVZQyI4vFKOW0lELeyfyRF
 wc3G2T/pffzh9bJPF3i2Gu5CR2Rgb/jt6/E9aC3rk5y6hnsMQPdp4rkvRB7Vig2/W4zu
 c1ZOAmYukDV8OtgBBsNYBvXegIHfx4NAVbpEOMuvYC1ggCxD7x3hbtdAJKPt4rNDdNIs
 ocIwf44fUsLKmSNtDTDkMBC6Jv5KyCZgUvR/5T0OpjpfkrKIQMPHUQdKkXV+e2QLZ4yi
 vfmtcAuKN9ulCMx1vTGd3y9C8gBxMxJ6m35wJPXAsy0K8/JoEfxvocS7Di7RZChr5tyQ
 q7fg==
X-Gm-Message-State: AOJu0YwvVzEQ38uOYsjwG/kXIRiJ03aVPJwju9hEukavtE9ibtnO3SAZ
 yNrWQUvEK9FBDmKRbp/CxsF2XrJkFh2tHj72MFCLWqNQtjHwc/HInDWjsEeuL1Shjrm/Fi8uxlT
 dEDeO
X-Gm-Gg: AeBDieuzjAuYFPTA4aTdjOAqeG9hKlP6yJlhWe4Z+a8Hd5lBRhTxvRTgcS1sVtMOK5r
 khGH+S0E5FMZgMiSvZ786waxUzHgH+kluRuc/U7gmc6ODeuJWM5dF+HwHsELaLJEnyaR10+EFWK
 U9btcQL63PhVujskop0cZYTlqVEmNHqN2TtAzLWA5tUbh+jtle4kSWvtsbV1pP2euef+0IKDqQx
 1/Y+p4Urf2BoTEniKEX+9jINMK7xmH6dLN8LWI1rjkTI6+XVkIEEFznF2UHRsSY3QCRWCPylDcI
 52gKCMvFUSTqANftr2yA5RHLWbYj6qMnxNpluXomVcVtly52CI7BxsuWY1jaGhw4YQXMpuzLJey
 CQP9xFVVYtj73Y/aLztU6nZU4vJYwssLphj6uAeKd9NbPTvq31nWCgwPlM6bfrlKnWDIVjDkyfG
 AIvXfbjuNhjE/qYbvEFDzWqdFuWg9oDFSbETKvWZ5ZIKA=
X-Received: by 2002:a05:7022:250f:b0:128:d5bd:3557 with SMTP id
 a92af1059eb24-12dde45cea9mr1089502c88.4.1777385694370; 
 Tue, 28 Apr 2026 07:14:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9a60f3sm2886093c88.10.2026.04.28.07.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:14:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 1/2] net/af_packet: fix indentation
Date: Tue, 28 Apr 2026 07:13:18 -0700
Message-ID: <20260428141450.202091-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428141450.202091-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260428141450.202091-1-stephen@networkplumber.org>
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

