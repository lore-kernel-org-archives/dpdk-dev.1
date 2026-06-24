Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA8CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CF6F40691;
	Wed, 24 Jun 2026 12:44:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A828406FF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFKMyz5PhX1dNZxHqbIjHt8dz+iW0cczmG9FqtHr74E=;
 b=Yt7jNtp/xMEfEAGZ4tVkw9wM/o+BQCD72n9MDkCRxFBwW4i4AqQC/GpJo6utQim+lE5AO7
 C7SdbM3MZxKS7VxyEUGf8RWTvUenuQt2sPe2zkWUpFs3UkyZUCkxVtWbYwzXCdsVCKUXLB
 bSKz950UcJC8UI4lDUKQUr02yPJI2Cw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-QjdLvkZ9MIKlZQo6xJidmw-1; Wed,
 24 Jun 2026 06:44:07 -0400
X-MC-Unique: QjdLvkZ9MIKlZQo6xJidmw-1
X-Mimecast-MFC-AGG-ID: QjdLvkZ9MIKlZQo6xJidmw_1782297846
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AD981800675; Wed, 24 Jun 2026 10:44:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 987FC36921; Wed, 24 Jun 2026 10:44:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 06/12] bus/vmbus: fix interrupt leak in cleanup
Date: Wed, 24 Jun 2026 12:43:17 +0200
Message-ID: <20260624104324.3576408-7-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pqTqJssmXvJHLV0ezJwRN5lB-KNwxWgUMuIn0zAEbKs_1782297846
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

