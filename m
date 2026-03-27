Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214E510BA445
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F05402C5;
	Fri, 27 Mar 2026 09:39:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4468A40280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774600752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDXCys+Z18GfAhmUdflAZpOGs+oF5oy0pyJ3nvL/nRA=;
 b=NVRWx38OgbLE8yocdHiuIrI+I2Yw9ikTAJa1DYds3ZVETAjNuCLzXuHedaViHXbzSXEbYK
 OfRwG1p7yf3krStNWyTtR8u6NBgen5hSRU0JyYSkvldz/Wj3/IKNBSjzFL5kJwpgsH/So6
 pCCZh7CHDmywQz0HtY4m/7EVcR5xALU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-swqS3dOtOGeNx-sBliSZsg-1; Fri,
 27 Mar 2026 04:39:07 -0400
X-MC-Unique: swqS3dOtOGeNx-sBliSZsg-1
X-Mimecast-MFC-AGG-ID: swqS3dOtOGeNx-sBliSZsg_1774600747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB93E1955D50; Fri, 27 Mar 2026 08:39:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C08D819560B1; Fri, 27 Mar 2026 08:39:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net/tap: fix close for partially configured port
Date: Fri, 27 Mar 2026 09:39:02 +0100
Message-ID: <20260327083903.3394778-1-david.marchand@redhat.com>
In-Reply-To: <20260326124612.2580985-1-david.marchand@redhat.com>
References: <20260326124612.2580985-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g5gz7EZi3GR8X0ZkfvViA3jxHiwwd3s2ooXb4Er5inc_1774600747
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In case no rxq has been set up (like when starting testpmd with no mempool
drivers), a crash happens in tap_dev_close:

Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
1111			struct rx_queue *rxq = dev->data->rx_queues[i];

(gdb) p dev->data->rx_queues
$4 = (void **) 0x0

Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- as Stephen AI reported, [rt]x_queues array are sized against
  dev->data->nb_[rt]x_queues, so the loop after the 23e2387b49a1 rework
  can go out of bound. Since nb_rx_queues == nb_tx_queues with this
  driver, simply check the number of configured rxq,

---
 drivers/net/tap/rte_eth_tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 64b359914b..a5d460a0b3 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1107,7 +1107,7 @@ tap_dev_close(struct rte_eth_dev *dev)
 	}
 #endif
 
-	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		struct rx_queue *rxq = dev->data->rx_queues[i];
 
 		tap_queue_close(process_private, i);
-- 
2.53.0

