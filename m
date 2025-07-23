Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6552BC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D8B840ED9;
	Wed, 23 Jul 2025 15:33:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6A340ED3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nQFPDOF7XUNIbkrkhkyxhmVTQGCmVcqM5eYWyzZa18=;
 b=LoctYvv9ZpWR/uAFtgZYnnALZkfsr0Hq4FvJJdmDu5VkAzaubgMTkArZFLuKKviQshEb18
 /WmpEa+RhsteXbxRqfRH19SE8lEzdm4oL6Hem+U3e9tU3aJ/gOj04qtZNI72RjaNJ8CZXt
 uNybFiGee/38DpwNkimA3m7gFtuuHhk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-7zJ99ikoN8WIoqrKkU_IeQ-1; Wed,
 23 Jul 2025 09:33:35 -0400
X-MC-Unique: 7zJ99ikoN8WIoqrKkU_IeQ-1
X-Mimecast-MFC-AGG-ID: 7zJ99ikoN8WIoqrKkU_IeQ_1753277607
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 862341800878; Wed, 23 Jul 2025 13:33:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DB94195608D; Wed, 23 Jul 2025 13:33:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v5 15/22] eventdev: fix listing timer adapters with telemetry
Date: Wed, 23 Jul 2025 15:31:48 +0200
Message-ID: <20250723133157.159825-16-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EfRQfHOxyNYZBhEuMiR1sXhavQWsAKOgqAJ1ZT8uoVE_1753277607
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

If no timer adapter is created, listing with telemetry can lead to crash
and is reported by UBSan as an undefined behavior:

../lib/eventdev/rte_event_timer_adapter.c:1418:13:
	runtime error: applying zero offset to null pointer

../lib/eventdev/rte_event_timer_adapter.c:1464:13:
	runtime error: applying zero offset to null pointer

Fixes: 791dfec24d00 ("eventdev/timer: add telemetry")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eventdev/rte_event_timer_adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index 06ce478d90..af98b1d9f6 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -1410,7 +1410,7 @@ handle_ta_info(const char *cmd __rte_unused, const char *params,
 
 	adapter_id = atoi(params);
 
-	if (adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
+	if (adapters == NULL || adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
 		EVTIM_LOG_ERR("Invalid timer adapter id %u", adapter_id);
 		return -EINVAL;
 	}
@@ -1456,7 +1456,7 @@ handle_ta_stats(const char *cmd __rte_unused, const char *params,
 
 	adapter_id = atoi(params);
 
-	if (adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
+	if (adapters == NULL || adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
 		EVTIM_LOG_ERR("Invalid timer adapter id %u", adapter_id);
 		return -EINVAL;
 	}
-- 
2.50.0

