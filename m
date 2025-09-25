Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E891CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 746E740687;
	Thu, 25 Sep 2025 14:32:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 19644406FF
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758803542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sda5HyKhWlx2j8/KlZGsWZxEEBMxEjuNWQqUWJXAaE=;
 b=RgDRUSKfgOW7xVW6pmSil/VOdtVrGuLNWrpemfQ8lDf7t3wUvm4MjQ08u0ypRBDRWqvo90
 zSsnoLPhwNuqr7/lPnMEN/NPnUeD/haphEBAcu3wsEm0CI5V2IcTNy1AetNTx70MjN9/nC
 F5Sq4RlU72FiuIu4fKfjXXW6c21dLWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-nkQ_6Vg8NNW-NKTTUNw9YA-1; Thu,
 25 Sep 2025 08:32:18 -0400
X-MC-Unique: nkQ_6Vg8NNW-NKTTUNw9YA-1
X-Mimecast-MFC-AGG-ID: nkQ_6Vg8NNW-NKTTUNw9YA_1758803537
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F811800366; Thu, 25 Sep 2025 12:32:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2BFE1800446; Thu, 25 Sep 2025 12:32:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 3/7] eventdev: do not include driver header in DMA adapter
Date: Thu, 25 Sep 2025 14:31:45 +0200
Message-ID: <20250925123150.3063298-4-david.marchand@redhat.com>
In-Reply-To: <20250925123150.3063298-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f46ZVCWr4c4qv2a4L78wqOmNNDQPtQKK_-c7hC36xBQ_1758803537
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

