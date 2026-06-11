Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A57CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE5E42F9F;
	Thu, 11 Jun 2026 11:46:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C0C0042F9B
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAco458QMH4RiPLQqx8Wqsg1SMAdB5b3zDs2qz6UENY=;
 b=TlAlxo58gKsgd/KAv3iFIGdtmOPhIasZMssFeRd9aw7xvnAiiCBFzWiJXGIsTzaQ5lL/pv
 ouS8FVKhsPfvfJWsjYVAsGoFzzbr8O+Uxb2OIyRkxRbOURKs3MXmBAqscc/dLA50vv2K/g
 e9zzQgwl+yMURFh1Y16a1ogQh3DEh2M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-G0fuhln9O4KLsWd1Vb4MwA-1; Thu,
 11 Jun 2026 05:46:20 -0400
X-MC-Unique: G0fuhln9O4KLsWd1Vb4MwA-1
X-Mimecast-MFC-AGG-ID: G0fuhln9O4KLsWd1Vb4MwA_1781171179
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00E8180ACF3; Thu, 11 Jun 2026 09:46:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7A7236917; Thu, 11 Jun 2026 09:46:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com
Subject: [PATCH 03/13] bus/vdev: remove driver setting in probe
Date: Thu, 11 Jun 2026 11:45:40 +0200
Message-ID: <20260611094551.1514962-4-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MKOBa1LMPlh7zyVkr4g2XxAgvtlOmIGlaMFDlHo1KQE_1781171179
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

Setting the device driver field is now the responsibility of EAL
(see local_dev_probe).
Yet, because of the VDEV API, rte_vdev_init() must be updated to mark
the device as probed.

Fixes: f282771a04ef ("bus: factorize driver reference")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/vdev/vdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 3bddf8938c..673e8a73b2 100644
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
@@ -337,6 +333,8 @@ rte_vdev_init(const char *name, const char *args)
 			free(dev);
 		} else if (ret > 0) {
 			goto next_driver;
+		} else {
+			dev->device.driver = drv;
 		}
 	}
 	rte_spinlock_recursive_unlock(&vdev_device_list_lock);
-- 
2.53.0

