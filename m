Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE51C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCAEC40E1C;
	Fri, 17 Jul 2026 11:30:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B1CEF40E27
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlHtxIMo1hfPP2p0cfCOm0j7V9a8V0lAMMTV/KPg8LE=;
 b=Yxcl5INZmXUxBsfnWEHJNly/Hpx0TnYVh6LyvUPGEYmfKqw6Hnd6j/EqhZWc6PVtZiGj/Y
 yZ/ytMRrtsABZGId+QORREIq0qb4byoHqUssgq2lfGQvgsotgQ5e3SK9tfa5Mj6qcDzuAK
 OIQ3pgQh4zJYg9vrvnJGL3tz1lXYIaA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-X6HeHoUoNSm5vbLNc98PpA-1; Fri,
 17 Jul 2026 05:30:38 -0400
X-MC-Unique: X6HeHoUoNSm5vbLNc98PpA-1
X-Mimecast-MFC-AGG-ID: X6HeHoUoNSm5vbLNc98PpA_1784280637
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A738F195D008
 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:30:37 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D813CD72 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:30:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 06/10] test/devargs: check driver presence with public API
Date: Fri, 17 Jul 2026 11:30:01 +0200
Message-ID: <20260717093006.229370-7-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hS6V_2MufM0W8Fg1x1W2QDSDfFik7iWCyuFNCCAteJU_1784280637
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

Let's avoid calling internal drivers API.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_devargs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 0bd14c24ec..6c194ecfc6 100644
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
@@ -167,14 +167,18 @@ test_valid_devargs(void)
 		{ "net_ring0,iface=test,path=/class/bus/,queues=1",
 		  0, 0, 3, "vdev", "net_ring0", NULL },
 	};
-	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
+	struct rte_devargs da;
 	int ret;
 
 	ret = test_valid_devargs_cases(list, RTE_DIM(list));
-	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
+
+	memset(&da, 0, sizeof(da));
+	if (rte_devargs_parse(&da, "net_ring0") == 0)
 		/* Ring vdev driver enabled. */
 		ret |= test_valid_devargs_cases(legacy_ring_list,
 						RTE_DIM(legacy_ring_list));
+	rte_devargs_reset(&da);
+
 	return ret;
 }
 
-- 
2.54.0

