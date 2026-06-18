Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDDFCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55197402EA;
	Thu, 18 Jun 2026 17:29:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55FB340696
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L/OBew5GR2kGiBXXWwcRUZLwrMqll6Fp1ud6R81Xgk=;
 b=cfEZ6LI369cArLG/6jhyxfBGJILSuyx6bPq0zK3zwCSb537LxQUmo8zEBWxIKStierzIZ4
 2teuLl1zwfoaaLsxVsV9FdgcOjtUjyo9xYL4irdn2k1vcZhwvdMP9YyroYALp4F/asxhHx
 b6Wavdn2xHnlS4lQ+8LHorgug8msgQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-A9l2RfuSOIOvZwehJP-lbw-1; Thu,
 18 Jun 2026 11:29:02 -0400
X-MC-Unique: A9l2RfuSOIOvZwehJP-lbw-1
X-Mimecast-MFC-AGG-ID: A9l2RfuSOIOvZwehJP-lbw_1781796541
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AC631802664; Thu, 18 Jun 2026 15:29:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46B1D1956089; Thu, 18 Jun 2026 15:28:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 05/10] bus/vmbus: fix interrupt leak in cleanup
Date: Thu, 18 Jun 2026 17:28:20 +0200
Message-ID: <20260618152826.490569-6-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2pZcGvuUI9AGomhZjj-V9DZqI8bnP9vlZDtuUJ6DB2Q_1781796541
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

When calling this bus cleanup, interrupt handle was not released.

Fixes: 65780eada9d9 ("bus/vmbus: support cleanup")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/vmbus/vmbus_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 01573927ce..74c1ddff69 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -150,6 +150,7 @@ rte_vmbus_cleanup(void)
 			error = -1;
 
 		rte_vmbus_unmap_device(dev);
+		rte_intr_instance_free(dev->intr_handle);
 
 		dev->device.driver = NULL;
 		rte_bus_remove_device(&rte_vmbus_bus, &dev->device);
-- 
2.53.0

