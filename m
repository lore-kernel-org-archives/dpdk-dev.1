Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EEC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 14:06:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0863640278;
	Sun, 28 Jun 2026 16:06:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 21AC1400D7
 for <dev@dpdk.org>; Sun, 28 Jun 2026 16:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782655564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2hk8JlzRy5iJb6ymf/OM6C95kciOWWZdHIvTiGvIRU=;
 b=XhV50k5D5cqkzqOWk3ImeSavcpLlXmuLOnuh+fDL1FbBIps/MpUmifPgPz/mS0LZ9tfgKu
 b++V0tZWryA9WQRTRrUjFSRVeKSutDwQKx844RV7t5Yb0kLETz+8YqH8gS0C0ouawYenk4
 ge9KwgF+AzTXWMO9CdXqCcNT4MSO2/w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-ogsIBmz-MeyVxn3aWpPL8w-1; Sun,
 28 Jun 2026 10:06:02 -0400
X-MC-Unique: ogsIBmz-MeyVxn3aWpPL8w-1
X-Mimecast-MFC-AGG-ID: ogsIBmz-MeyVxn3aWpPL8w_1782655561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0EF818002C3; Sun, 28 Jun 2026 14:06:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E4D6195608A; Sun, 28 Jun 2026 14:06:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: longli@microsoft.com
Subject: [PATCH v2] dev: skip multi-process in hotplug
Date: Sun, 28 Jun 2026 16:05:57 +0200
Message-ID: <20260628140557.1718861-1-david.marchand@redhat.com>
In-Reply-To: <20260625072254.4190227-1-david.marchand@redhat.com>
References: <20260625072254.4190227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KsKScgw8EciZQ3DHb7hrK1XPxkwIJFx7IfGUTIVtZK0_1782655561
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

If multi-process is disabled (--no-shconf/--in-memory),
there is no need to build a multi-process message.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_common_dev.c | 46 ++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 762ed09e21..47fc45aa3e 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -267,10 +267,16 @@ RTE_EXPORT_SYMBOL(rte_dev_probe)
 int
 rte_dev_probe(const char *devargs)
 {
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	struct rte_device *dev;
 	int ret;
 
+	if (!do_mp)
+		goto skip_mp_req;
+
 	memset(&req, 0, sizeof(req));
 	req.t = EAL_DEV_REQ_TYPE_ATTACH;
 	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
@@ -294,6 +300,7 @@ rte_dev_probe(const char *devargs)
 
 	/* attach a shared device from primary start from here: */
 
+skip_mp_req:
 	/* primary attach the new device itself. */
 	ret = local_dev_probe(devargs, &dev);
 
@@ -311,6 +318,9 @@ rte_dev_probe(const char *devargs)
 			return ret;
 	}
 
+	if (!do_mp)
+		goto skip_mp_notify;
+
 	/* primary send attach sync request to secondary. */
 	ret = eal_dev_hotplug_request_to_secondary(&req);
 
@@ -337,16 +347,19 @@ rte_dev_probe(const char *devargs)
 		goto rollback;
 	}
 
+skip_mp_notify:
 	return 0;
 
 rollback:
-	req.t = EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
+	if (do_mp) {
+		req.t = EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
 
-	/* primary send rollback request to secondary. */
-	if (eal_dev_hotplug_request_to_secondary(&req) != 0)
-		EAL_LOG(WARNING,
-			"Failed to rollback device attach on secondary."
-			"Devices in secondary may not sync with primary");
+		/* primary send rollback request to secondary. */
+		if (eal_dev_hotplug_request_to_secondary(&req) != 0)
+			EAL_LOG(WARNING,
+				"Failed to rollback device attach on secondary."
+				"Devices in secondary may not sync with primary");
+	}
 
 	/* primary rollback itself. */
 	if (local_dev_remove(dev) != 0)
@@ -407,6 +420,9 @@ RTE_EXPORT_SYMBOL(rte_dev_remove)
 int
 rte_dev_remove(struct rte_device *dev)
 {
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	char *devargs;
 	int ret;
@@ -416,6 +432,9 @@ rte_dev_remove(struct rte_device *dev)
 		return -ENOENT;
 	}
 
+	if (!do_mp)
+		goto skip_mp_req;
+
 	ret = build_devargs(dev->bus->name, dev->name, "", &devargs);
 	if (ret != 0)
 		return ret;
@@ -474,6 +493,7 @@ rte_dev_remove(struct rte_device *dev)
 			goto rollback;
 	}
 
+skip_mp_req:
 	/* primary detach the device itself. */
 	ret = local_dev_remove(dev);
 
@@ -490,13 +510,15 @@ rte_dev_remove(struct rte_device *dev)
 	return 0;
 
 rollback:
-	req.t = EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
+	if (do_mp) {
+		req.t = EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
 
-	/* primary send rollback request to secondary. */
-	if (eal_dev_hotplug_request_to_secondary(&req) != 0)
-		EAL_LOG(WARNING,
-			"Failed to rollback device detach on secondary."
-			"Devices in secondary may not sync with primary");
+		/* primary send rollback request to secondary. */
+		if (eal_dev_hotplug_request_to_secondary(&req) != 0)
+			EAL_LOG(WARNING,
+				"Failed to rollback device detach on secondary."
+				"Devices in secondary may not sync with primary");
+	}
 
 	return ret;
 }
-- 
2.54.0

