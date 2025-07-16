Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D2C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 023AE40676;
	Wed, 16 Jul 2025 15:03:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1FB4540657
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NtH7zAp8kr5gPoekaxBXlqbZ6k2Vv51hga0EcxxYfY=;
 b=Ju0aaC4Fgp7u9g7nmn6VNHxiR+61PuZTGxzinh9X+Sma2iuD1rBlYaSk8ea6agjRVKhjid
 mdyIamw5MSc6RO3ZkJoPIa6rc11GzV/K2tgiKX0kKPlN+2Y16P7DuJKDdfKP2WcAZj7gH7
 kNoaQ5bL02tS/UXyplBy1vUdY2U50lI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-ozjXZYDuOie7D6mzZ8KnJA-1; Wed,
 16 Jul 2025 09:02:57 -0400
X-MC-Unique: ozjXZYDuOie7D6mzZ8KnJA-1
X-Mimecast-MFC-AGG-ID: ozjXZYDuOie7D6mzZ8KnJA_1752670976
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D35E1180028E; Wed, 16 Jul 2025 13:02:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CB43195E772; Wed, 16 Jul 2025 13:02:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v4 07/22] tailq: fix lookup macro
Date: Wed, 16 Jul 2025 15:01:54 +0200
Message-ID: <20250716130212.1736407-8-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qidBnqT6vgaWdji69ls8_0GI6kx0XLKvkUt_FGH-BzI_1752670976
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

