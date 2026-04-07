Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CD1FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC6140B94;
	Tue,  7 Apr 2026 17:18:33 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 638A640A82
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:32 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c76af7b0f94so3382153a12.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575111;
 x=1776179911; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ins924ZO8CqUNomWTl6/vwHZE4eJ0YbFINlEA8r+yo=;
 b=nlx4C1qbrAkyM4ZkIFj80rTkHQLGAlFgDRqInmHXNt6PZaEMfItfr8nj5uXIBvcDNc
 rLMdnibLOfG5JSrkpWoaBITPua4RTSSjGNK7a4sjZ8PlEhI0L2mmSnYMAzkwfytElID9
 +gNOtHHvuJiZzrsKSGG6avk3n21QH9D8HxvhpGZgqiKmXqOx2Uli0KVMBfcjf+6YOykL
 ho/1qIDle8KYgT+TT0v5mUqJn/+wP8Fux/WT+qRgCvpC957DUGhlYU5G5vvaxncvCU1U
 PtFkTqmz8IoN4l9ydlqbFBJrfUp4wcoknOpkYb/kPrMT3WIKQAI/7pEazF0vA+8ipm9w
 nI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575111; x=1776179911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ins924ZO8CqUNomWTl6/vwHZE4eJ0YbFINlEA8r+yo=;
 b=pR7GPE5y+IVdmbttx/Fooci9LCir+mRESsA8UWPNGouDUl+w4blwPJZVGq37hC/mLG
 0ut9/GTKFeabUNv5BVAkc0mu0H7Ur9B2Z32ZGaxFgl1AG5iI+/iQBXcGirP8aT7YzeBk
 Vexf3GKC+e82z3iCZuWujvlDZICoQ3lIzgclCMWDYq4O5XZBBOLKj5PWTTfZoB1O3a2v
 ax3LZFO9KThYJj5Br70Wsj4MoZeOkAUy6WDVzas/z94+na1mw9oN4V3k9yYpIna5Okl6
 CXb5jfl28sHlZCH0eP5CSCqN+2OSSI+jmrNkyeVSzE0fjwM3KEi6Wo+zqiBWRRCroQ1Q
 3VYQ==
X-Gm-Message-State: AOJu0Yz2maO6nnl1cIy7lVyFZHJoQwuWZf/h/5i4PvtUjTKeTtjphxB6
 Th9r4+dwfH6UUqShHCgHhb3IAx7WLjT82pFe9ZUs5ZbByPu3xx0TAWpWQ8GDd4eKV9ar7ZRFQO1
 167ZD
X-Gm-Gg: AeBDiev0oCfCb5BixjsCZJLOHwtRSaCW3OD1OJqXjRGjrK1poZi5wWD3tDwe0IO3gSu
 8HAvphlNeKGYaLoPObuQk7vApEwK7FisQf6nM4UxeC+OgWaytBaJlYEItvDIMC4gQH6Ecsl71VG
 o3B4EXiZ8/ZT6RAR1HuvlyKWbz9QuAly37UXZJ6WRaP16jTZ5iPH2W0Ak/wdDP9LiPilz6GlJ3l
 ytxUwrqrHfAWwpLLWwHe3SghbDC3knhtFlWfKLrgPfCPi+ln3h4Y2nhnVQYCBx/SVVjKQF1aVI7
 awTi7wWb5JTUReGhgnVV311fj+EkbkVCGRX0KFNGjtMC02e3KFSux6zGkr97dM3RRGz5oVMIRnd
 01sSEoz/n292A2ADRUE2Wl88zFSWz/vOCCbsqPBxokP/wjse7OcHJBXjZZZDggS6r5Ba7afYJgw
 OvaaM0n41CTd1H5i7Vyob3kLFM6pGovbKL
X-Received: by 2002:a05:6a20:958e:b0:39c:2b9d:93ae with SMTP id
 adf61e73a8af0-39f2f1ae00dmr16902243637.60.1775575111543; 
 Tue, 07 Apr 2026 08:18:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 15/23] examples/vhost: resolve shadow warnings
Date: Tue,  7 Apr 2026 08:16:11 -0700
Message-ID: <20260407151732.272195-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

The mbuf_pool was being passed as parameter with same as
global; resolve conflict by making variable local to main
and passing where needed.

The num_devices was global but also passed as arg.
Remove the parameter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vhost/main.c      | 19 ++++++++++---------
 examples/vhost/meson.build |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index ac888348d2..5978a50cfe 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -86,7 +86,6 @@ static uint32_t promiscuous;
 static uint32_t num_queues = 0;
 static uint32_t num_devices;
 
-static struct rte_mempool *mbuf_pool;
 static int mergeable;
 
 /* Enable VM2VM communications. If this is disabled then the MAC address compare is skipped. */
@@ -387,7 +386,7 @@ open_dma(const char *value)
  * according to the pool & queue limits.
  */
 static inline int
-get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_devices)
+get_eth_conf(struct rte_eth_conf *eth_conf)
 {
 	struct rte_eth_vmdq_rx_conf conf;
 	struct rte_eth_vmdq_rx_conf *def_conf =
@@ -415,7 +414,7 @@ get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_devices)
  * coming from the mbuf_pool passed as parameter
  */
 static inline int
-port_init(uint16_t port)
+port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 {
 	struct rte_eth_dev_info dev_info;
 	struct rte_eth_conf port_conf;
@@ -460,7 +459,7 @@ port_init(uint16_t port)
 	}
 
 	/* Get port configuration. */
-	retval = get_eth_conf(&port_conf, num_devices);
+	retval = get_eth_conf(&port_conf);
 	if (retval < 0)
 		return retval;
 	/* NIC queues are divided into pf queues and vmdq queues.  */
@@ -1440,7 +1439,7 @@ uint16_t sync_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 }
 
 static __rte_always_inline void
-drain_virtio_tx(struct vhost_dev *vdev)
+drain_virtio_tx(struct vhost_dev *vdev, struct rte_mempool *mbuf_pool)
 {
 	struct rte_mbuf *pkts[MAX_PKT_BURST];
 	uint16_t count;
@@ -1477,8 +1476,9 @@ drain_virtio_tx(struct vhost_dev *vdev)
  * }
  */
 static int
-switch_worker(void *arg __rte_unused)
+switch_worker(void *arg)
 {
+	struct rte_mempool *mbuf_pool = arg;
 	unsigned i;
 	unsigned lcore_id = rte_lcore_id();
 	struct vhost_dev *vdev;
@@ -1519,7 +1519,7 @@ switch_worker(void *arg __rte_unused)
 				drain_eth_rx(vdev);
 
 			if (likely(!vdev->remove))
-				drain_virtio_tx(vdev);
+				drain_virtio_tx(vdev, mbuf_pool);
 		}
 	}
 
@@ -1906,6 +1906,7 @@ reset_dma(void)
 int
 main(int argc, char *argv[])
 {
+	struct rte_mempool *mbuf_pool = NULL;
 	unsigned lcore_id, core_id = 0;
 	unsigned nb_ports, valid_num_ports;
 	int ret, i;
@@ -1982,7 +1983,7 @@ main(int argc, char *argv[])
 				"Skipping disabled port %d\n", portid);
 			continue;
 		}
-		if (port_init(portid) != 0)
+		if (port_init(portid, mbuf_pool) != 0)
 			rte_exit(EXIT_FAILURE,
 				"Cannot initialize network ports\n");
 	}
@@ -1998,7 +1999,7 @@ main(int argc, char *argv[])
 
 	/* Launch all data cores. */
 	RTE_LCORE_FOREACH_WORKER(lcore_id)
-		rte_eal_remote_launch(switch_worker, NULL, lcore_id);
+		rte_eal_remote_launch(switch_worker, mbuf_pool, lcore_id);
 
 	if (client_mode)
 		flags |= RTE_VHOST_USER_CLIENT;
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index af5049c7ef..e938be8f45 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -19,4 +19,3 @@ sources = files(
         'virtio_net.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

