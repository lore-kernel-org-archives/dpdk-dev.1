Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07114C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:31:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62A7940BA0;
	Tue,  8 Jul 2025 14:31:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 673C840B99
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nQFPDOF7XUNIbkrkhkyxhmVTQGCmVcqM5eYWyzZa18=;
 b=i0fPJg3AW0PwJKxkHfHej0vbK9rDRUKcOpfnRlL//OBCu3r0YUnCnjZTTGlZX+2rP3aOia
 8lZOh8PzCB27gpfm6P88zENvY+8TS6PqYCSja7oENTpPicq3Fdp/bDaAOHfDd0/AsfHFcL
 fhEVDw0LbiqC1mMQEJ1fz3wr0znML1s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-gBCZPeYnP1WQk7x7R28Lcg-1; Tue,
 08 Jul 2025 08:31:47 -0400
X-MC-Unique: gBCZPeYnP1WQk7x7R28Lcg-1
X-Mimecast-MFC-AGG-ID: gBCZPeYnP1WQk7x7R28Lcg_1751977906
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A744A1801207; Tue,  8 Jul 2025 12:31:46 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7274F19560AB; Tue,  8 Jul 2025 12:31:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 15/18] eventdev: fix listing timer adapters with telemetry
Date: Tue,  8 Jul 2025 14:28:19 +0200
Message-ID: <20250708122823.3406288-16-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jam4YA8G18YFX-LncqoD_eZbxXRzjXChcao1x4kJaUA_1751977906
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

