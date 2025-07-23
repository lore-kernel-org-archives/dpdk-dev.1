Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD9DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F92C40E2C;
	Wed, 23 Jul 2025 15:32:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC3840E21
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NtH7zAp8kr5gPoekaxBXlqbZ6k2Vv51hga0EcxxYfY=;
 b=VX5zTwUVHvKsDSCJaKFD9qlx15JXEwpUzZ4evxvi1oOX49syJ4GU/ne8dbZy46lJIV+rmY
 ONYLlvTfJQUh6/mC3XNZutVmAL06yKBk/A7bq/7JbEtXHneBEeh/UgrGFptpXF2SiRe0b9
 bOTT3Ikp04fUUcZqcQhQpmXF/t/Uumk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-nea0rTgaN7-vHzR6-bnn_Q-1; Wed,
 23 Jul 2025 09:32:46 -0400
X-MC-Unique: nea0rTgaN7-vHzR6-bnn_Q-1
X-Mimecast-MFC-AGG-ID: nea0rTgaN7-vHzR6-bnn_Q_1753277565
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 641C9195FD02; Wed, 23 Jul 2025 13:32:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 903DF19560A3; Wed, 23 Jul 2025 13:32:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v5 07/22] tailq: fix lookup macro
Date: Wed, 23 Jul 2025 15:31:40 +0200
Message-ID: <20250723133157.159825-8-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RlEPtzmYyOiy6hsgHtrfG1My_JOMa0TsqGcB78YoUB0_1753277565
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

Doing arithmetic with the NULL pointer is undefined.

Caught by UBSan:

../app/test/test_tailq.c:111:9: runtime error:
	member access within null pointer of type 'struct rte_tailq_head'

Fixes: f6b4f6c9c123 ("tailq: use a single cast macro")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- left the cast macro untouched and fixed the lookup macro instead,

---
 lib/eal/include/rte_tailq.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index 89f7ef2134..e7caed6812 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -69,11 +69,12 @@ struct rte_tailq_elem {
  * @return
  *   The return value from rte_eal_tailq_lookup, typecast to the appropriate
  *   structure pointer type.
- *   NULL on error, since the tailq_head is the first
- *   element in the rte_tailq_head structure.
+ *   NULL on error.
  */
-#define RTE_TAILQ_LOOKUP(name, struct_name) \
-	RTE_TAILQ_CAST(rte_eal_tailq_lookup(name), struct_name)
+#define RTE_TAILQ_LOOKUP(name, struct_name) __extension__ ({ \
+	struct rte_tailq_head *head = rte_eal_tailq_lookup(name); \
+	head == NULL ? NULL : RTE_TAILQ_CAST(head, struct_name); \
+})
 
 /**
  * Dump tail queues to a file.
-- 
2.50.0

