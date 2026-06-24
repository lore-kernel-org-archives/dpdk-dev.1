Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14585CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B84540691;
	Wed, 24 Jun 2026 12:43:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 151FA40659
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8opLl9btn4LvJRSimp060Z/Albezp6/ONJVIMiLs6E=;
 b=ATp/O0KRjaRcf/MN77DmJuONbKx+l7XfJPbNr5lAzqMzKt6QeYKNgBVTogWpOfB+eSB8ru
 unvxLnDEdjBgifxPqgtxQggaFubmMdbNJq+2vSFAYBhYy3wCO+Iv2qWUM5f/S6Gq+QM0Ji
 09x+y4f1A2HI/9VbpAfn+RvntsM3dYw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-Rop37eLaMZ2Pxkuwt6yEKA-1; Wed,
 24 Jun 2026 06:43:49 -0400
X-MC-Unique: Rop37eLaMZ2Pxkuwt6yEKA-1
X-Mimecast-MFC-AGG-ID: Rop37eLaMZ2Pxkuwt6yEKA_1782297827
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4CE1956077; Wed, 24 Jun 2026 10:43:47 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7C2C30001A7; Wed, 24 Jun 2026 10:43:44 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com
Subject: [PATCH v4 03/12] bus/vdev: remove driver setting in probe
Date: Wed, 24 Jun 2026 12:43:14 +0200
Message-ID: <20260624104324.3576408-4-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sLSXN8Jw3F6_0jWANegl6NQow166kqpgl24t2WDFPbI_1782297827
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
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
2.54.0

