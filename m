Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48126CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 17:26:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEC24067D;
	Wed, 24 Sep 2025 19:26:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38A6E40B9D
 for <dev@dpdk.org>; Wed, 24 Sep 2025 19:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758734760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sda5HyKhWlx2j8/KlZGsWZxEEBMxEjuNWQqUWJXAaE=;
 b=SfgOcvyYghEu/Uevq/aldcFz3bwZBogDuX+RnaTMzbbDIoLuYDVvu0mvBdEM3r2m6nDah4
 I3jdj9aAeDxFnM4eLuyxoB4QcpJIw/MxywHO1JmzVPRDrkcjAvHHrJ9EQB8pFD1MUfwX2G
 4hDev8pSSRZlFUEQAs6Zw7BoovBvJCU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-j-5Wal76OeO1idbrUNsocw-1; Wed,
 24 Sep 2025 13:25:59 -0400
X-MC-Unique: j-5Wal76OeO1idbrUNsocw-1
X-Mimecast-MFC-AGG-ID: j-5Wal76OeO1idbrUNsocw_1758734758
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A5A3180048E; Wed, 24 Sep 2025 17:25:58 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0977419560BA; Wed, 24 Sep 2025 17:25:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Amit Prakash Shukla <amitprakashs@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 3/7] eventdev: do not include driver header in DMA adapter
Date: Wed, 24 Sep 2025 19:25:31 +0200
Message-ID: <20250924172536.2447183-4-david.marchand@redhat.com>
In-Reply-To: <20250924172536.2447183-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o8suU6JxJoNFsOPzChEA5aoTc42JF5oDjpmqQ15f2l8_1758734758
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

The dma adapter header does not require including rte_dmadev_pmd.h which
is a driver header.

Fixes: 66a30a29387a ("eventdev/dma: introduce DMA adapter")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eventdev/rte_event_dma_adapter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eventdev/rte_event_dma_adapter.h b/lib/eventdev/rte_event_dma_adapter.h
index 5c480b82ff..34142f26db 100644
--- a/lib/eventdev/rte_event_dma_adapter.h
+++ b/lib/eventdev/rte_event_dma_adapter.h
@@ -144,7 +144,7 @@
 #include <stdint.h>
 
 #include <rte_common.h>
-#include <rte_dmadev_pmd.h>
+#include <rte_dmadev.h>
 #include <rte_eventdev.h>
 
 #ifdef __cplusplus
-- 
2.51.0

