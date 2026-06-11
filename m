Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE7CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D35742D28;
	Thu, 11 Jun 2026 15:08:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D8CE40041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 15:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781183298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V1AqFVniCbUaXNeoX/ET1fn0kNET6Ji8USwBi/mH4k=;
 b=anDLHVKJRByer5K1WUdoiVE2uVY0/bi2btyaHozQCc0Vd/U/yAR04+mLhrhgbAtgPUOAJ6
 e270q0S+YCSxFkq5JU8aCvSaRIEy2Ojio57WJpBw/bkLvVkijvNoQlDGz7fogUrdwy7W6R
 znjbqlIeGRm0uKbJHmhxfSfSoRV5y1s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-VeZvNFEeOqimmu1vtMnTRQ-1; Thu,
 11 Jun 2026 09:08:15 -0400
X-MC-Unique: VeZvNFEeOqimmu1vtMnTRQ-1
X-Mimecast-MFC-AGG-ID: VeZvNFEeOqimmu1vtMnTRQ_1781183293
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5AE01955F1F; Thu, 11 Jun 2026 13:08:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A10C1800351; Thu, 11 Jun 2026 13:08:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 3/3] net/dpaa: remove ethdev pointer from bus device
Date: Thu, 11 Jun 2026 15:07:37 +0200
Message-ID: <20260611130738.1720628-4-david.marchand@redhat.com>
In-Reply-To: <20260611130738.1720628-1-david.marchand@redhat.com>
References: <20260611130738.1720628-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1cbf5iO1RgsqVsLQEpPV525Xs4vLAKrWKQ3WxVvel04_1781183293
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

Calling rte_eth_dev_allocated() is enough to retrieve the
ethdev device object.

This leaves no user of the ethdev field in the dpaa device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/bus_dpaa_driver.h | 3 ---
 drivers/net/dpaa/dpaa_ethdev.c     | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 0642aee14a..4aed83f84d 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -80,9 +80,6 @@ struct dpaa_device_id {
 
 struct rte_dpaa_device {
 	struct rte_device device;
-	union {
-		struct rte_eth_dev *eth_dev;
-	};
 	struct dpaa_device_id id;
 	struct rte_intr_handle *intr_handle;
 	enum rte_dpaa_type device_type; /**< Ethernet or crypto type device */
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 9f976d179b..967e814b5d 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2592,7 +2592,6 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 	}
 
 	eth_dev->device = &dpaa_dev->device;
-	dpaa_dev->eth_dev = eth_dev;
 
 	qman_ern_register_cb(dpaa_free_mbuf);
 
@@ -2678,7 +2677,7 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	eth_dev = dpaa_dev->eth_dev;
+	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
 	dpaa_eth_dev_close(eth_dev);
 	ret = rte_eth_dev_release_port(eth_dev);
 	dpaa_valid_dev--;
-- 
2.53.0

