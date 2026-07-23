Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFAC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:56:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4233D40693;
	Thu, 23 Jul 2026 14:56:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6674840A81
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUJoxEDRN3P9pBfrYWKbv45uSabeHmb5TzirLj9qObs=;
 b=OnCdoZdGK9Ov5k9VhXprz2bVRpDBlLctDNGRQ44GNbetO9fz/+9Ve7/4sPwnh27eQ2GNa8
 tHjDwXhQpFxcs/ivJ2eySxKyezxYtVqSGo9Kt/SL4pd0lgYgftI9afn8h8XVDwvjxlcFJS
 5HcVr4ImmBxXqUxdB5ZuF+nrznAR3lQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-Uq-WxLaFNEKICV0BhKPnoQ-1; Thu,
 23 Jul 2026 08:56:31 -0400
X-MC-Unique: Uq-WxLaFNEKICV0BhKPnoQ-1
X-Mimecast-MFC-AGG-ID: Uq-WxLaFNEKICV0BhKPnoQ_1784811391
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE6B1180A23C; Thu, 23 Jul 2026 12:56:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE24A196B0A8; Thu, 23 Jul 2026 12:56:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 5/9] test/devargs: rely on net null driver
Date: Thu, 23 Jul 2026 14:55:54 +0200
Message-ID: <20260723125559.3087579-6-david.marchand@redhat.com>
In-Reply-To: <20260723125559.3087579-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kDibb0XJNQ3lqbWmZsJIpmibR7zPCquN05lFq-WWx-c_1784811391
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

The net/null driver is enabled in all our tests builds in the CI.
Standardize on using net/null instead of net/ring.

This also removes use of an internal API.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- dropped dependency on net/ring, used net/null instead,

---
 app/test/test_devargs.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 0bd14c24ec..0300a2c753 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -10,7 +10,7 @@
 #include <rte_common.h>
 #include <rte_devargs.h>
 #include <rte_kvargs.h>
-#include <bus_driver.h>
+#include <rte_bus.h>
 #include <rte_class.h>
 
 #include "test.h"
@@ -160,22 +160,11 @@ test_valid_devargs(void)
 		  "pci", "1:2.3", NULL },
 		{ "pci:1:2.3,k0=v0",
 		  0, 0, 1, "pci", "1:2.3", NULL },
+		{ "net_null0",
+		  0, 0, 0, "vdev", "net_null0", NULL },
 	};
-	static const struct devargs_case legacy_ring_list[] = {
-		{ "net_ring0",
-		  0, 0, 0, "vdev", "net_ring0", NULL },
-		{ "net_ring0,iface=test,path=/class/bus/,queues=1",
-		  0, 0, 3, "vdev", "net_ring0", NULL },
-	};
-	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
-	int ret;
 
-	ret = test_valid_devargs_cases(list, RTE_DIM(list));
-	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
-		/* Ring vdev driver enabled. */
-		ret |= test_valid_devargs_cases(legacy_ring_list,
-						RTE_DIM(legacy_ring_list));
-	return ret;
+	return test_valid_devargs_cases(list, RTE_DIM(list));
 }
 
 /* Test several invalid cases */
-- 
2.54.0

