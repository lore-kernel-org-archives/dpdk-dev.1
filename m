Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A06C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87C80432C8;
	Thu, 17 Sep 2026 22:11:48 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id CD5A943270
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:41 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso365665ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675901;
 x=1790280701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SbtSPJKYx3FPMEK7HlUjiUYbrLgucFJ/AWstTJpATeM=;
 b=g1nmCg/1DCQQP23hDoMLVONXgkEluog+QwYdeAcWysIUemrNleFKNppZz7LI9do7QL
 ZzviqBaJiprsk9VO2RD9Sg3oMG0bm32ON6KAaKBZbjfCqZFp6PXKCvuoyP8h7bz03imG
 PpBVeeMd0AkVfHeLkBBRpYodiPFioOOqClX5PrW5BZJnLZf+ITqrhnXwRF/uBibRmCVx
 hzoZhiZnhseFTLCd0Tfg00K4f4Q7aaJakWUFAmXUEkF04PsgnPabpZDUhftolLdCaybS
 OHxKCClvoy29mBDJeM5hx+MU0LZasPlCGIR9Md64Ld7MKEkMPyFnw+sqxZ60QX/V9Df7
 BJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675901; x=1790280701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SbtSPJKYx3FPMEK7HlUjiUYbrLgucFJ/AWstTJpATeM=;
 b=FC7RRSd2MozqyOu6oW0SIuJLSFNYBoUOiE8AltjBO495wQYzCLhbFDGU0OZ9lMFpXO
 MF6RFy3+EIwAW4DiOlRRTkwTM7G7O5pWQKiD2G6znNIXUNuIwTtsGUmmmbBUwBZgcV/r
 ue6aPtm6XFcPqGxqwA5MV4zEYDGCml1RlgYIwNVYcZR+dsTM7Y8oHuRQI1Na+v9UDGL2
 hpSLYpc/iB/dGtFTsuvGL5qFHq2pyJRLOKh5zEw3PgoRnFik6XXSO8TGWYMNLTlZpm0L
 jkNXne/d2XK4JzlHfKgzmqI8MNskJrlYucyGK6gm5y6jAdYGeqgmjkNCIu3dmxJ6nvXt
 gudw==
X-Gm-Message-State: AFuF++mCt3E3myiRvmYJmAiceKRFN1hP9yj/FfQJ+6EAm+8+3azDMS+q
 4RaZlZdAQO0SsA7KrmOU9IBTPlUP+M9foDJIxTV94MKQJ1mlKh0A0taos3wrO5k3mDABV+9s0L8
 ZXrYm
X-Gm-Gg: AYBFou0TZfJZGtaOKXFNUi3ebJfD4rkPgGwA6qvF5BTmKphLEz9xxYnITj/x3qDQlIn
 hD/RKc+NqNcZVc1K20jxGN2/ZFweqlI5QzhT4aeLWkK9Hrv8edqLlTbhAalCVyRS6W6BdY9Wiek
 cq0wy8pWXlfqL15BrtY6fuT9j5Nixi/uem8LY+IFu3AWbDefuo7VLQNlWqMGod++WwjGkgwDZYv
 yNnyLWcdoTprJf+W5vLGYKXFI9B1AGrA4SN5IlFItJld44TD8q3aoW0pXfONKQaWsXx+Z2awrKy
 Ndsn+beIwhH4I//ComhVf/Y3IhlburWUthStGYeUY7guaBVZYgjzIpez4ELahNyAd8jSYQFmhSD
 4aLrxhXHZ93GieHJd3ST+vOgCocIM0EF/tl/G5676UsQY1kXD8lWJ3IZi5QqhaGXv/cIHE0fKZw
 Ng4o+tyTDI82IydDXPyUL1ZCEba+TMF0WrYEW2YUjRSPnNdWF6AB50fHo/ADCVweew2VkETq9kN
 l44Z10hZEPQUigx+oohQIeF6wwJSLWRb/4/9g==
X-Received: by 2002:a17:903:2447:b0:2db:5c0a:f184 with SMTP id
 d9443c01a7336-2ddb1b78d26mr5418525ad.17.1789675901011; 
 Thu, 17 Sep 2026 13:11:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v8 21/25] net/vhost: use stdatomic for state flags
Date: Thu, 17 Sep 2026 13:10:25 -0700
Message-ID: <20260917201119.2168234-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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
index 05940f2461..2e3a007966 100644
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
@@ -1471,8 +1475,10 @@ vhost_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
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

