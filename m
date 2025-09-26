Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69753CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 410CB40696;
	Fri, 26 Sep 2025 14:41:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E766F4066D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sda5HyKhWlx2j8/KlZGsWZxEEBMxEjuNWQqUWJXAaE=;
 b=KXX9XI+0IFnv2Y6g6jSbWtqr1GVCnge8PPhc2tMZs1mqaNebcLkwoh79IrAC+NyJQCSY0r
 SyawwaEgvbIN4qeiL7Btz4IkhM1oZcmQxxiDoGKMZ6Pd3DLZA/2Cj5C53M6s3mUSECPT0R
 wjCAN4/kql+c3tK4AOriUch86d4mRCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-EARlIsHIPsmQQu_lEZOx_Q-1; Fri,
 26 Sep 2025 08:41:31 -0400
X-MC-Unique: EARlIsHIPsmQQu_lEZOx_Q-1
X-Mimecast-MFC-AGG-ID: EARlIsHIPsmQQu_lEZOx_Q_1758890490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 334591800285; Fri, 26 Sep 2025 12:41:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 844BA18003FC; Fri, 26 Sep 2025 12:41:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v5 3/9] eventdev: do not include driver header in DMA adapter
Date: Fri, 26 Sep 2025 14:40:56 +0200
Message-ID: <20250926124103.750844-4-david.marchand@redhat.com>
In-Reply-To: <20250926124103.750844-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 45-vTsnjQMXp3xJuSi8-RusNpATtDLXB-16fwpo2BP8_1758890490
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

