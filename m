Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D8FEEF2A
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 11:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE76B402EE;
	Tue,  7 Apr 2026 13:52:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B55DE402E9
 for <dev@dpdk.org>; Tue,  7 Apr 2026 13:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775562752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSnc3LQOpDb4fInXrZlYJLP4We5FXd8HOrO6/Qy8icc=;
 b=dVwSASWCgBjmxFjGXd8xHp4fgk6dj2IFatJ1rbRmf3cy/B4MrKYZopm+gcPEh/yGWsulK9
 c7KFqaKz6uzf5yNSZ0SU6SX46Pmlxuavhti/pz1pkPPf+9omgCtaRB/rMuKglq9F2J2/zV
 HEUIqD0w79VGCgM/uoLtrk+evQMMAas=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-vQUuNV3LMb2FbQOWPOg_1w-1; Tue,
 07 Apr 2026 07:52:29 -0400
X-MC-Unique: vQUuNV3LMb2FbQOWPOg_1w-1
X-Mimecast-MFC-AGG-ID: vQUuNV3LMb2FbQOWPOg_1w_1775562747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 853FC1956096; Tue,  7 Apr 2026 11:52:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33E9C1955F2B; Tue,  7 Apr 2026 11:52:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
Subject: [PATCH v3 2/7] bus/fslmc: fix bus cleanup
Date: Tue,  7 Apr 2026 13:52:05 +0200
Message-ID: <20260407115211.1903623-3-david.marchand@redhat.com>
In-Reply-To: <20260407115211.1903623-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndIpqkxFs9D6w9-2zKD64h_auiRmWuFmKKV-hNMDSR4_1775562747
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 550d4e0e8d..7daa18d850 100644
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
@@ -1411,22 +1411,9 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
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
-		}
+		drv = dev->driver;
+		if (drv && drv->remove && drv->remove(dev))
+			DPAA2_BUS_ERR("Unable to remove");
 		break;
 	default:
 		break;
-- 
2.53.0

