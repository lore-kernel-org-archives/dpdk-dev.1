Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13726CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A3B42F7E;
	Thu, 11 Jun 2026 11:46:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7FB7042F9F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L/OBew5GR2kGiBXXWwcRUZLwrMqll6Fp1ud6R81Xgk=;
 b=XF5BquDr2V0qVVi65wwlJayUCI+Ly2+syQMmEioHjk2Y9yIOTFi6AKS9l6PgSXCVxdqDxk
 IHEdV81ijkCu1jW2NZrayIn/kG3CLie7wXH8BELOKZxR0bFofJbzsTI/LynHjjdS0JlkzC
 wC1TsgWPKBF8+erR4VJaqZFW4I+LF94=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-SIx5jBQnP3Gy1JyF90GoUA-1; Thu,
 11 Jun 2026 05:46:42 -0400
X-MC-Unique: SIx5jBQnP3Gy1JyF90GoUA-1
X-Mimecast-MFC-AGG-ID: SIx5jBQnP3Gy1JyF90GoUA_1781171200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77BDF18E68D5; Thu, 11 Jun 2026 09:46:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F01A73008B34; Thu, 11 Jun 2026 09:46:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 07/13] bus/vmbus: fix interrupt leak in cleanup
Date: Thu, 11 Jun 2026 11:45:44 +0200
Message-ID: <20260611094551.1514962-8-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HWNVrUYW2Y_HcGaNC80_e2qQdYqhSu5Bux2to6MLhPE_1781171200
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

