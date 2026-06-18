Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D406440696;
	Thu, 18 Jun 2026 17:28:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5D32340268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/fawvWPQgghL0/pJF8bE2iSucwthXeQAQ/QsR2lKag=;
 b=f5PQ+eIYggDiFW3ro/UxoqR9iHTELcGQI1bELT0YvdUM+WL+wn+FxoBGGUKHvkv9z+utw1
 zI1YXd3FPweOKBD4Sgyiu3Y11QgMxpMZO0POqvxxhv4aS/TMuHunZkAu4DYMSKQhPX3yng
 euheL/oi9+PGzxWELMjOkQXf4mULXPs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-bWan2joYMwKotkwnqEtUCQ-1; Thu,
 18 Jun 2026 11:28:50 -0400
X-MC-Unique: bWan2joYMwKotkwnqEtUCQ-1
X-Mimecast-MFC-AGG-ID: bWan2joYMwKotkwnqEtUCQ_1781796529
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E7811954121; Thu, 18 Jun 2026 15:28:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EC731956044; Thu, 18 Jun 2026 15:28:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com
Subject: [PATCH v2 03/10] bus/vdev: remove driver setting in probe
Date: Thu, 18 Jun 2026 17:28:18 +0200
Message-ID: <20260618152826.490569-4-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8s_VT8RwLGxShCUyaxVc0w1U3MwZk_D_J4Y-Y5klk14_1781796529
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

Setting the device driver field is not the responsibility of the
probe_device callback anymore, but that of EAL (see local_dev_probe).
Yet, because of the VDEV API, rte_vdev_init() must be updated to mark
the device as probed.

Fixes: f282771a04ef ("bus: factorize driver reference")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- implement the same way as EAL,

---
 drivers/bus/vdev/vdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 3bddf8938c..09221ccdea 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -188,7 +188,6 @@ vdev_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_vdev_driver *vdev_drv = RTE_BUS_DRIVER(drv, *vdev_drv);
 	const char *name;
 	enum rte_iova_mode iova_mode;
-	int ret;
 
 	name = rte_vdev_device_name(vdev_dev);
 	VDEV_LOG(DEBUG, "Search driver to probe device %s", name);
@@ -200,10 +199,7 @@ vdev_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		return -1;
 	}
 
-	ret = vdev_drv->probe(vdev_dev);
-	if (ret == 0)
-		vdev_dev->device.driver = &vdev_drv->driver;
-	return ret;
+	return vdev_drv->probe(vdev_dev);
 }
 
 /* The caller shall be responsible for thread-safe */
@@ -328,7 +324,10 @@ rte_vdev_init(const char *name, const char *args)
 		} else if (rte_dev_is_probed(&dev->device)) {
 			ret = -EEXIST;
 		} else {
+			dev->device.driver = drv;
 			ret = rte_vdev_bus.probe_device(drv, &dev->device);
+			if (ret != 0)
+				dev->device.driver = NULL;
 		}
 		if (ret < 0) {
 			/* If fails, remove it from vdev list */
-- 
2.53.0

