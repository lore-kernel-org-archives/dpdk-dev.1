Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B67F3D332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FB6341060;
	Thu,  5 Mar 2026 17:46:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B77E840EE7
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JGq/4zLJ1XwaTmXwJRXfx02UTLI+CyZzgD2pE2vNG8=;
 b=VR1W+cEgp76zdtLTv/hJNb2hE1NmVFGRejLIpjnAk+Z5t0s3m0x8Zms2g8aETO1rXmAEp5
 T7uN2qzXf6H7ISPUatbvEeTMmUDv/YhaOQ6lK9ZZ1r/jyKrPsH/nGjsLRi/0cKjGxl1lXs
 OH48oPxK8Iosw7TiUykTxMxZ7UGlioU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-YFCAvBerPgStSgK6pI4VFg-1; Thu,
 05 Mar 2026 11:46:24 -0500
X-MC-Unique: YFCAvBerPgStSgK6pI4VFg-1
X-Mimecast-MFC-AGG-ID: YFCAvBerPgStSgK6pI4VFg_1772729183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E250E18930D3; Thu,  5 Mar 2026 16:46:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.121])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 167BF1958DCF; Thu,  5 Mar 2026 16:46:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
Subject: [RFC v3 2/7] bus/fslmc: fix bus cleanup
Date: Thu,  5 Mar 2026 17:45:44 +0100
Message-ID: <20260305164550.2067453-3-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OC63-RFFI-efhy0SSoS9AgaBKR9G3U9njKVhJVDt9q8_1772729183
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

The close operation was never closing probed devices.

Taking a step back, reevaluating the devargs makes no sense during the
close step, as a probed device must have passed the allow/block list
evaluation initially.

Since the device contains a reference to the driver that probed it,
simply call this driver remove op.

Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 550d4e0e8d..481bad196b 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1393,7 +1393,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 {
 	struct rte_dpaa2_object *object = NULL;
 	struct rte_dpaa2_driver *drv;
-	int ret, probe_all;
+	int ret;
 
 	switch (dev->dev_type) {
 	case DPAA2_IO:
@@ -1411,21 +1411,11 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	case DPAA2_ETH:
 	case DPAA2_CRYPTO:
 	case DPAA2_QDMA:
-		probe_all = rte_fslmc_bus.bus.conf.scan_mode !=
-			    RTE_BUS_SCAN_ALLOWLIST;
-		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
-			if (drv->drv_type != dev->dev_type)
-				continue;
-			if (rte_dev_is_probed(&dev->device))
-				continue;
-			if (probe_all ||
-			    (dev->device.devargs &&
-			     dev->device.devargs->policy ==
-			     RTE_DEV_ALLOWED)) {
-				ret = drv->remove(dev);
-				if (ret)
-					DPAA2_BUS_ERR("Unable to remove");
-			}
+		drv = dev->driver;
+		if (drv && drv->remove) {
+			ret = drv->remove(dev);
+			if (ret)
+				DPAA2_BUS_ERR("Unable to remove");
 		}
 		break;
 	default:
-- 
2.53.0

