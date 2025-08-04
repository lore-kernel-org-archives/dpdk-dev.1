Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECECC87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAF8A40A80;
	Mon,  4 Aug 2025 18:30:59 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 89A9140A79
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:30:58 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so18011385e9.1
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325058;
 x=1754929858; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=Gi+ePMzPk6gb1zdvq0AZo3ntwFWQ7PEcRzfosoc5lqgIaZA/pUwbgYpuPtUhNVZxvd
 KEWXigJTffYDsRtzMibK6U2KuJyDCvKE/7r7ULO3FusvOVnKC5OeS2OC2rfJJ0lSBWkF
 FUOIMSnAAA6TksZQloH4tyIZj4u2FLYf7Fh7nuQ34DcQorLAXJ5pcTpvKcr0r5Ayteel
 QGV91yUF0gJl1/OTz2aLKENx4yNDu5wWY8T4cs2ncpD9pJ32omFofolSvQw43sGrja+6
 r5tvyYs+bVj8OIvFysbaZA7PaJR0eLTghaCPK9d7/Zvn7A7RzZPkB5M4zIUAXlRInipb
 ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325058; x=1754929858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=l2ePkVzvm3faAeDzpxVX9zjvdDd6VYIaWUdFgO/sAiEwaBNGBLopfUQzEHvTUjz95r
 v564gRWkM+uAx2Zhw0nqXa1YhM3wH2MQ5LAdDejmhgSkomJ0JkkH49CqFqbXr5yQ+h3r
 n+iVmNwgDQ0unxgMhIhzTbbRnCwXeqSBYU7H5aAF05DKBk7O1ZNqI0r8qcNclZnN2qDO
 eTsplYPHIJu5slKGQVzW+V4OpB3k4w6ckadqi4QaRvy7buAGVm9A2uDvrb8vwFz8CIkF
 zSoZvNB2Zy4ZJ0jiETLGWejkqdFTSGq8xPc2JaehDEch0/6e48LkdQvAKe1QCSzRrdU6
 RjMQ==
X-Gm-Message-State: AOJu0YwXaIAjFVSRlrx7g5WDv37ld9FhgKgWylHkylhAgYIFw8CvUpWK
 HuRpue0IBWPDq9sjHiP8imMy7nWQbRZiC4esFGl4o0Zsi9kcrMNQBJ+DNYNwxMz3Fx8hrcS0CkU
 IaqDq
X-Gm-Gg: ASbGncseEyQnmCUhrYTCeXeqDGqB+ZyuQHs92sxMXUECmMY7riO+cNdDxSZnrP2had0
 jSi7sgtmMfWtks5DEhh4DE/0wwWudTHHRCO/WHe6DFllB6HksMKzUPOxLW4fpmJTSdvF1Ayy2qj
 b6QdUmHsy5iwZAj5WqUyVBukJEQf6dPyaSjmc9D86Z2/fC1ROsLC0ltQwCmpMgoBIP6xTxiJYLc
 KIL579TGZb/91KaH6kt4RDrDRv4MENEqPyO9lxGQuWzICxSv/g1OWhhczkPMZq9eqK4wWN/8OLG
 7gv4nQoGzcDr0wdZVId2Gj64JYqjraurc+17/A9Sm+lsQD9cDquFqKUHc5Bo1/Kbjkpv2XpPTeF
 BLZ+59l5xbwBkyfqWAdDm7rHRbP6vlkYuVLncWCnRxCR2UYfqEYjeXaycP4+VZHr39RScPauH
X-Google-Smtp-Source: AGHT+IFbJkE4ZPXDpV/QF68Szr0QdtDv0ttcb77kg8rUA/rKIZHTuxkZbHMq1yIFo3SAYOi1mrF88A==
X-Received: by 2002:a05:600c:4ed1:b0:459:dc99:51bf with SMTP id
 5b1f17b1804b1-459dc9953dcmr21806495e9.25.1754325058033; 
 Mon, 04 Aug 2025 09:30:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 06/13] net/ring: allow lockfree transmit if ring supports it
Date: Mon,  4 Aug 2025 09:27:37 -0700
Message-ID: <20250804163039.138959-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

Need to be able have multiple threads all using same
transmit queue when using SPAN.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..966c64d9a5 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -177,6 +177,19 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	return 0;
 }
 
+static bool
+eth_tx_queue_lockfree(const struct pmd_internals *internals)
+{
+	unsigned int i;
+
+	for (i = 0; i < internals->max_tx_queues; i++) {
+		const struct ring_queue *r = &internals->tx_ring_queues[i];
+
+		if (r->rng->flags & RING_F_SP_ENQ)
+			return false;
+	}
+	return true;
+}
 
 static int
 eth_dev_info(struct rte_eth_dev *dev,
@@ -189,6 +202,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = (uint16_t)internals->max_rx_queues;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	if (eth_tx_queue_lockfree(internals))
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+
 	dev_info->max_tx_queues = (uint16_t)internals->max_tx_queues;
 	dev_info->min_rx_bufsize = 0;
 
-- 
2.47.2

