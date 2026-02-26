Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EAFD8FCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E0CB4065B;
	Thu, 26 Feb 2026 17:21:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A70E40659
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:21:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Li9g+2Cn3+S8X/3IBog/bQHgHxyJic0Ys3r/0WFItHE=;
 b=QczD4fnJZi6d+BgxrbBvA8jPtGRfP+boHdeheHQaXDAlnu7WNTx5eg2tAtmJ9bZDGdPRLb
 c4DVnFoIrXNCZXuolOWDlRzlygLUb9qewYthpgC6t1zdDHpuxdDVpEycc28qIkIg0Mjnpf
 UsWxPtNkAsQr7CrWox9jPDNN3q/UtUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-wW6C9UNDNwKC-3kL5z04UQ-1; Thu,
 26 Feb 2026 11:21:14 -0500
X-MC-Unique: wW6C9UNDNwKC-3kL5z04UQ-1
X-Mimecast-MFC-AGG-ID: wW6C9UNDNwKC-3kL5z04UQ_1772122873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4701A1956088; Thu, 26 Feb 2026 16:21:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 755451800666; Thu, 26 Feb 2026 16:21:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
Subject: [RFC v2 2/5] bus/fslmc: fix bus cleanup
Date: Thu, 26 Feb 2026 17:20:53 +0100
Message-ID: <20260226162057.207202-3-david.marchand@redhat.com>
In-Reply-To: <20260226162057.207202-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _0vuumQr8qH4F4Ztut4z3OSZqObLRiSGcg_mTiJ1j6c_1772122873
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
evaluation earlier.

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

