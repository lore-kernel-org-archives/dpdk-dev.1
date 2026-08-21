Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904CC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290C040DF6;
	Fri, 21 Aug 2026 21:30:35 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8BE40DF5
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:34 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1760080a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340633;
 x=1787945433; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v75l1CJ1N/isvvHkXdLcvNlUKMcyRgHKUCBNhlnnEH4=;
 b=eVgPq5N055STAH8671o4+EsVs1+2s8+o5VPAwKIDL8HhlbqltMgSs390mkDE81VPFa
 O8taJG2q/i7eUTieSDyHgnT0sGEmEvG58zGPfpv2yXrQc4o2cwcr6lk4WBLbTiTG5Urv
 HWw+EUUJnRYG+WHqef61bZBOPCyvmJhVDcSqtB9UD7HX8eP64gNSLQozy4oK8WGNi7jz
 ASvTqWrkAAcweHFnrqUPnjIwEvMeMObBBM457JjlPcDwTueE0/8EqfpfKt/FT1CIh+ue
 6f4nmtJc0IiuVg+nJ1KVK5iWTsV9PuPw0WATczeCqIWEAJGXVXn1KG8D1q8CE7QxnClx
 kaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340633; x=1787945433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v75l1CJ1N/isvvHkXdLcvNlUKMcyRgHKUCBNhlnnEH4=;
 b=NKGLqmUhOmLrsu/6bUJV+V2TnUbcWTYQuLPoi0Fk8pUL3de6HwKubsKCL/5uAmpdw/
 JE1+88ZQPXgqzWKeqxPaj/h8iPotTtlOKPpdHJhNw6vqd0voz9CCWvAzM52ASW4uawUa
 d2TRB2jMEFNQ7sdTYMSEuFjYte2KAtR8mcaL/JV1rsmUVPAtXKZknhVfioiO3JBrTHW9
 ti+Afs1OCw3UfOLhPr8b9tPMeq93/21IgbVcTWM4RGlepMBsxNA5q8SARr5CrrPjzSSn
 aYITD7XHFig4tv/hR7Rcs+aV4ddNWQAKQQf2+VKt8hHaK+16Rzrx1PIuJOOVpvKgS3ik
 EkKw==
X-Gm-Message-State: AFuF++kDjeZrNynwAjk1C39UvPnNZ3e5n4nZY9HkqLQaeV9Z7sEOF3+6
 Lzc5IY3wwfPLFi6xuYRzPpmceWg4BTHnci3TEtRYx8O0R310VNkIAL9W8wkez/aaehmAVtBbKEC
 69/2mHIg=
X-Gm-Gg: AR+sD13FxG+RolKCxzpJORR5lxryQ+hntTlkJ7+feY3qMIaeprqeDpat80r5PAfBaKn
 AFCf/X5V+23Er3gQLMNveN5C/9y+hPt7WQ6YOvsmqG0ymtz5YjQzdJg5K40V64cBCsnqTOEhBUR
 8J4JOT2+PQ+QytsDUK6RaDcp06GTIoF3KOjYschHRqXfXGx5JZPwGbBMSm7RS14CbR3AzVF+j04
 A5jQfumi1mHJ0rTT3rGbk/TDYIth8PGIurAcSlKidp5oSXqU67czZMflMHrFQoTZxBnRFdMI0o+
 nj4Qd3j8p+1gsvU6/qrq8iFyJmOu7jadUJ8sOUbvbhwEJe6KMdd2n4gXmI8qM794HQYNY3JaK0X
 Me2OdaBHu3e7EcnPK53tgrtOlyUBNidOm3kDNpzAt6TxSd9up/3UC5XnsZnGHfjUt6oQTieqi0O
 P9LgY6FtPuHTimRDvtvrCZBLbpwWizNRGef5VP4X+EBTbo54e1Vman9D6Ly/+L57MU0hI4VEaTQ
 uTjmXihg440a1ztXwZu/VsVVd0=
X-Received: by 2002:a05:6a20:a110:b0:3c3:bbe6:95c9 with SMTP id
 adf61e73a8af0-3cd301795c8mr15715765637.16.1787340633286; 
 Fri, 21 Aug 2026 12:30:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 44/68] net/null: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:39 -0700
Message-ID: <20260821192646.146382-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The null driver is not used for high speed production traffic, so
any marginal performance difference from using regular memcpy() does
not matter. Regular memcpy() gets more compile time checking of the
arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 7fba3a661b..3e21649f6e 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -4,12 +4,12 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
@@ -121,7 +121,7 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		return 0;
 
 	for (i = 0; i < nb_bufs; i++) {
-		rte_memcpy(rte_pktmbuf_mtod(bufs[i], void *), h->dummy_packet,
+		memcpy(rte_pktmbuf_mtod(bufs[i], void *), h->dummy_packet,
 					packet_size);
 		bufs[i]->data_len = (uint16_t)packet_size;
 		bufs[i]->pkt_len = packet_size;
@@ -169,7 +169,7 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		struct rte_mbuf *m = bufs[i];
 		size_t len = RTE_MIN(h->internals->packet_size, m->data_len);
 
-		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
+		memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		bytes += m->pkt_len;
 	}
 
@@ -465,7 +465,7 @@ eth_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
 				rss_conf->rss_hf & internal->flow_type_rss_offloads;
 
 	if (rss_conf->rss_key)
-		rte_memcpy(internal->rss_key, rss_conf->rss_key, 40);
+		memcpy(internal->rss_key, rss_conf->rss_key, 40);
 
 	rte_spinlock_unlock(&internal->rss_lock);
 
@@ -482,7 +482,7 @@ eth_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 	rss_conf->rss_hf = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
 	if (rss_conf->rss_key)
-		rte_memcpy(rss_conf->rss_key, internal->rss_key, 40);
+		memcpy(rss_conf->rss_key, internal->rss_key, 40);
 
 	rte_spinlock_unlock(&internal->rss_lock);
 
@@ -577,7 +577,7 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	internals->flow_type_rss_offloads =  RTE_ETH_RSS_PROTO_MASK;
 	internals->reta_size = RTE_DIM(internals->reta_conf) * RTE_ETH_RETA_GROUP_SIZE;
 
-	rte_memcpy(internals->rss_key, default_rss_key, 40);
+	memcpy(internals->rss_key, default_rss_key, 40);
 
 	data = eth_dev->data;
 	data->nb_rx_queues = (uint16_t)nb_rx_queues;
-- 
2.53.0

