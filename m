Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B5C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E83754066D;
	Wed, 12 Mar 2025 00:54:50 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 03F114065D
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:46 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-225477548e1so67465155ad.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737285;
 x=1742342085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWpgPKh6n90LsAodUT9B1BNCeLRVSfNECmkUZMQIW4g=;
 b=Q10kb8jWv6mpeeXIXQ/Yc2o0qOyhG9Jy2ZcHP4X/8xPRB/RpPg0+hNeohST3nHYnQz
 JFrySfxSKSShFWEo+QBsLOQooJH+CSJTe4S0hKojJkkYk0p9pey6pfgwphmjNG6gVeQ9
 enCmoVK4MJIrMPAnhWwgFuLHMkXmo1jNfAqf8vhfWwuwbvJ5FFKkdACusCdMADDKvKhs
 zKKAApvr8eD/a/NthHRfO1Kfq7ZW3QJuNnkuMzxo5CXRmAlI/Tier9Lt8KpkeMwxVFEj
 dwOo6u8nUoOnkvK/GAkuHnBVtZ8tFeGN+U68K/7GFIMZfJYQdMmrB3h4RYcS1pYnc5Py
 E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737285; x=1742342085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWpgPKh6n90LsAodUT9B1BNCeLRVSfNECmkUZMQIW4g=;
 b=vlWXI1T647RhkLgL+0O4AVy8t+0KTQEJuCWzJ6GEnNR1X1dTNjtHavheWhvMoJ2l5I
 Myota04SHeoMyRVH7m+KvG7TbMTvNs4l1wPDpbJrDzr9E48xHln3rUpvMTUikf57uO01
 uMEFmBmGSA8B84D067BDcPxx0KQrR5Vp6thK5RHE28Tt4jiBHB0atRLiNkn58qTbZ+a2
 VzNyo2qjMbBk/8LsLYKHnRP/h6YAYVnAq7aI+UJ04G7xHhK6nHZ1XaOGcbJw/OrYYWyw
 RDYo5obCnjWqG3XxYsRcR6/gxv1s2luaI3Rb7KYTZNnVK0D7ChJZKCQuKBISR8MbHnjF
 SaQg==
X-Gm-Message-State: AOJu0YyzVv4yXz5fI6LC1xdq3nguawmHpV/dKD0ZBuk9jlP7Zw1eY2dI
 9RPPkseDLX0fDQ3fk4IpSrPbqCE5nff3eNtv3V0yB3RcU5kGRBQjkSJE+BZV8xRnxNzDUUrxHUS
 S
X-Gm-Gg: ASbGncsPacHrJ25siJx7MK2lhm8YsCdrH6w0v/vJu1fuTUkJriMr6Feo+XG8m/0ItLz
 LG3eC4uQbb2qKrMFQkh+Bos9e+KequXyQ6gh4eGWJcfPXzfhT7OBCOIZbvDnpa9jSDXrzwSw92M
 fBd07M5bud0Kzg8SBzfhkC/RIAHrW6Vc9eAXU8xo5Z65/CURy02Izx+cOW5L9EEsV7/PaO1lXuL
 6Gn2cPRl+tJ6zzqLk8t/K5bOKEUIXtcgb4q1OZ3ZlA5AIM+IlYEvTEZYDkucIZENj+4oVZ5DFG4
 B5Usgu6SqEsFRUJtBGxcpIKp5d2j4KEY9xyD/tQ5vqbnnFaATEFivoZH5HilxsnPO+gCKCN7f4J
 M+UesQEF6U7NPbtohlq3qAw==
X-Google-Smtp-Source: AGHT+IFT2lxrJaMw/RWA/nn9saAwzpZLvreGGC4iXb4kWOSxc6il6yaunH20cxRDZPW/4CNbPSEHMQ==
X-Received: by 2002:a17:903:2405:b0:220:f140:f7be with SMTP id
 d9443c01a7336-22428c075b5mr354606805ad.41.1741737285180; 
 Tue, 11 Mar 2025 16:54:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 7/9] net/ioring: add VLAN support
Date: Tue, 11 Mar 2025 16:51:25 -0700
Message-ID: <20250311235424.172440-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add support for VLAN insert and stripping.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ioring/rte_eth_ioring.c | 47 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 4d064c2c22..d473c3fcbb 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -33,9 +33,11 @@
 #define IORING_DEFAULT_BURST	64
 #define IORING_NUM_BUFFERS	1024
 #define IORING_MAX_QUEUES	128
-
 static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
 
+#define IORING_TX_OFFLOAD	RTE_ETH_TX_OFFLOAD_VLAN_INSERT
+#define IORING_RX_OFFLOAD	RTE_ETH_RX_OFFLOAD_VLAN_STRIP
+
 #define IORING_DEFAULT_IFNAME	"itap%d"
 #define IORING_MP_KEY		"ioring_mp_send_fds"
 
@@ -69,6 +71,7 @@ static const char * const valid_arguments[] = {
 struct rx_queue {
 	struct rte_mempool *mb_pool;	/* rx buffer pool */
 	struct io_uring io_ring;	/* queue of posted read's */
+	uint64_t offloads;
 	uint16_t port_id;
 	uint16_t queue_id;
 
@@ -80,6 +83,7 @@ struct rx_queue {
 
 struct tx_queue {
 	struct io_uring io_ring;
+	uint64_t offloads;
 
 	uint16_t port_id;
 	uint16_t queue_id;
@@ -471,6 +475,9 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			goto resubmit;
 		}
 
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rte_vlan_strip(mb);
+
 		mb->pkt_len = len;
 		mb->data_len = len;
 		mb->port = rxq->port_id;
@@ -495,8 +502,7 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_desc,
-		   unsigned int socket_id,
-		   const struct rte_eth_rxconf *rx_conf __rte_unused,
+		   unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
@@ -515,6 +521,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_de
 		return -1;
 	}
 
+	rxq->offloads = rx_conf->offloads;
 	rxq->mb_pool = mb_pool;
 	rxq->port_id = dev->data->port_id;
 	rxq->queue_id = queue_id;
@@ -580,6 +587,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	txq->port_id = dev->data->port_id;
 	txq->queue_id = queue_id;
+	txq->offloads = tx_conf->offloads;
 	txq->free_thresh = tx_conf->tx_free_thresh;
 	dev->data->tx_queues[queue_id] = txq;
 
@@ -634,6 +642,38 @@ eth_ioring_tx_cleanup(struct tx_queue *txq)
 	txq->tx_bytes += tx_bytes;
 }
 
+static uint16_t
+eth_ioring_tx_prepare(void *tx_queue __rte_unused, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	uint16_t nb_tx;
+	int error;
+
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		struct rte_mbuf *m = tx_pkts[nb_tx];
+
+#ifdef RTE_LIBRTE_ETHDEV_DEBUG
+		error = rte_validate_tx_offload(m);
+		if (unlikely(error)) {
+			rte_errno = -error;
+			break;
+		}
+#endif
+		/* Do VLAN tag insertion */
+		if (unlikely(m->ol_flags & RTE_MBUF_F_TX_VLAN)) {
+			error = rte_vlan_insert(&m);
+			/* rte_vlan_insert() may change pointer */
+			tx_pkts[nb_tx] = m;
+
+			if (unlikely(error)) {
+				rte_errno = -error;
+				break;
+			}
+		}
+	}
+
+	return nb_tx;
+}
+
 static uint16_t
 eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -737,6 +777,7 @@ ioring_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 	PMD_LOG(DEBUG, "%s setup", ifr.ifr_name);
 
 	dev->rx_pkt_burst = eth_ioring_rx;
+	dev->tx_pkt_prepare = eth_ioring_tx_prepare;
 	dev->tx_pkt_burst = eth_ioring_tx;
 
 	return 0;
-- 
2.47.2

