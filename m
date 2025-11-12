Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2BCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E47F40695;
	Wed, 12 Nov 2025 10:11:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 73FE74068E
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiWSlXvxPv+Gu/LpQ6pPnDMr4QNYxCENZdfXz4Q9bPw=;
 b=d3NHdrWE7w/9lw0ewa8yVC40AoI1vPZuei2VWAUASNdvOuzSx1LdFW0P/nXgJJTM1PSRBc
 9p1vyGIufWWChZPSYr9xvzLDzZVsjKP00woxpXLofIco85XDP1Yzb3U/OB085+M3JwFLTa
 n9Y2jyQ8HNTJ28YkhISV6Nwr4HQkCv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-_9E29vkGOQWdblXackbM_w-1; Wed,
 12 Nov 2025 04:11:24 -0500
X-MC-Unique: _9E29vkGOQWdblXackbM_w-1
X-Mimecast-MFC-AGG-ID: _9E29vkGOQWdblXackbM_w_1762938683
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731C01800370; Wed, 12 Nov 2025 09:11:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF57C30044E0; Wed, 12 Nov 2025 09:11:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 4/5] net/dpaa2: remove ethdev device in bus device
Date: Wed, 12 Nov 2025 10:10:47 +0100
Message-ID: <20251112091049.2669481-5-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OXFc5Kt3xbdF-5TEPf0LMqMue-vg8r5BHOWHtyqBNQc_1762938683
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

This leaves no user of the ethdev field in the fslmc device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- dropped return on !eth_dev (this should be fixed in a separate patch),

---
 drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
 drivers/net/dpaa2/dpaa2_ethdev.c     | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index efa88754a7..094f885f59 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -98,7 +98,6 @@ struct rte_dpaa2_device {
 	TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device. */
 	struct rte_device device;           /**< Inherit core device */
 	union {
-		struct rte_eth_dev *eth_dev;        /**< ethernet device */
 		struct rte_rawdev *rawdev;          /**< Raw Device */
 	};
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..c545177999 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3320,7 +3320,6 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
 
 	eth_dev->device = &dpaa2_dev->device;
 
-	dpaa2_dev->eth_dev = eth_dev;
 	eth_dev->data->rx_mbuf_alloc_failed = 0;
 
 	if (dpaa2_drv->drv_flags & RTE_DPAA2_DRV_INTR_LSC)
@@ -3349,7 +3348,7 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 	struct rte_eth_dev *eth_dev;
 	int ret;
 
-	eth_dev = dpaa2_dev->eth_dev;
+	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
 	dpaa2_dev_close(eth_dev);
 	dpaa2_valid_dev--;
 	if (!dpaa2_valid_dev)
-- 
2.51.0

