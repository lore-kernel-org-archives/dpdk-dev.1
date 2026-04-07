Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC6FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 057424066E;
	Tue,  7 Apr 2026 05:52:32 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 4D42F40670
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:27 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso2659052c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533946;
 x=1776138746; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9M+LDXJ7teHLhPPyfd7UhPzENc7FaqBQ68bF++YkgU=;
 b=Oawu/55cPZN1vacKyPFDZCyoMPanTN6tX6Mf/PY7Ci0u7h9TRGjWALr7cflIrRWEQe
 l5C9Ixk0lTHjvFZGF0EMqtIPSpDJ5GuFexOpAEKtgCK+pw9elBtzRUv9+uWoOn0/XPfu
 DMqIYaPJuB8xJwdlkW0K8DtOyyzDmQBsBkOv3hvq61YeTSpgt5FvNICW/PToeIvn7y4+
 VLiHm69ui3fhQrVKOC8n69xA8hTAmwdOMSVbY+n9eNmsUplGdfPA2H/NruJ0aBEWGQ3z
 IMzbieIdT72iUDaL9viTKPx2tdOkEztujdbFLBGr4ArWAz6Fv1D9QkQVRBjzVZxoyAF6
 nEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533946; x=1776138746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/9M+LDXJ7teHLhPPyfd7UhPzENc7FaqBQ68bF++YkgU=;
 b=G78nW0BrZW9FSsw7Ujk9vTQW074R6ZhoisHdv2JS4hGLofCY5ui7rYr5jMcngDCy6i
 mJs5HuQnO1w6QtszQL1ms4UG14R2VtRXDf+FBfp75aVktTMDEMwtlnUC03h1tTuYLqTd
 Uq8DRNsBIWiedwgbf8V1DT/YzG4wmickKeTAz6xlsMernI1SRDhKn/rQSVjW/gmVxxPT
 Yf0gAiWpUq6MUcbnUqI2poe4vhYaOkpzDgaC1pU+fZ5OY/5kqQWpw3xZb/1LF+77Lsc7
 oe/L0jLpojs0miYTSoD6wmRkWJ0JtzzJV0tNEbqu1ik83p/ysv8RH5VZLaoa7z+6/ryQ
 qsyw==
X-Gm-Message-State: AOJu0YwLX2WMW0fAngiuqQgYjmwGj/fAdcxo0nnmHaKkCJU9OfwwQWel
 NjKvWBzB5EG3ebPGZ7zGfIRBhhRlJa6RqlmxTSLX8LJfxh7SHsreoSN1Kkah3QNmisKm55kojZ3
 C3ytv
X-Gm-Gg: AeBDieu+DF/qfd2qJJCHDD22svmdHS10z0iVQfs/TodUTLw3ZG+0zQVeIQ7fwOlk7aP
 afsLfiy+ZqX9gFH1MQ/FlN4aSwNWeIFKrZdO351T+4juhBLokBSlDEA5FYv8OUxfDngSTSsWGzR
 aw5YC+nCYOLwasGMZlQcHUp8JrvFQ1rdQfPLhK8/pzrSOP3gxaBMwKMHkHKdJQN4wETA4knqdJs
 rel+gIdUPnjz4Q3jX+zAS0l5ilflgHtaTvJG+VwulqoFcht92bHtJTrD8PvAyOhhxWVz42h/XrE
 YvArDG6Z+EJHh1hLjLCBSmEN+xraMC/339v+gNP574DXt31B7Ma2yuY/0i7d8j7JOJC+gdLssWM
 OSxpXFYFti+w7qdBAtLveToBJVYCqOZXRWBckDGx0nh9HpQyADA24vPJPncE2Tk3r7AwckWzux8
 V92XrGc2zdzkJkI+X/4UzRxK3PeFF95OOB
X-Received: by 2002:a05:7022:41a3:b0:12b:f881:d8fb with SMTP id
 a92af1059eb24-12bfb6ec86fmr8259641c88.3.1775533946359; 
 Mon, 06 Apr 2026 20:52:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 15/23] examples/vhost: fix shadow warnings
Date: Mon,  6 Apr 2026 20:49:41 -0700
Message-ID: <20260407035209.650419-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

