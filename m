Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD4BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A16184065E;
	Tue, 23 Jun 2026 12:55:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 60B944065E
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFKMyz5PhX1dNZxHqbIjHt8dz+iW0cczmG9FqtHr74E=;
 b=YsMRu8Nvo2NZvXFI8kbXpvWLNF7UnqQNIBXTuRdl/ORHHxxiLEopdPryISIV0iJ+KSpEsV
 grBdOyZ//dgH4ALYtaGYYvM2S5LQ4tzDaIbZSurlR/fUC7lLJGz179IOiPlBF3UGbacs9W
 vc4aLKcj3lvvrEajsxgOrhraEI83+cc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-HUJzBm5ZO0ONhJAWROJPgg-1; Tue,
 23 Jun 2026 06:55:16 -0400
X-MC-Unique: HUJzBm5ZO0ONhJAWROJPgg-1
X-Mimecast-MFC-AGG-ID: HUJzBm5ZO0ONhJAWROJPgg_1782212115
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6FF018052FC; Tue, 23 Jun 2026 10:55:14 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BE3D1956043; Tue, 23 Jun 2026 10:55:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 05/11] bus/vmbus: fix interrupt leak in cleanup
Date: Tue, 23 Jun 2026 12:54:32 +0200
Message-ID: <20260623105439.2144694-6-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -1X4JjkY0VXjKaeLhwh93vGPXOtEe8dSwTB2KoOfqbw_1782212115
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
Reviewed-by: Long Li <longli@microsoft.com>
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
2.54.0

