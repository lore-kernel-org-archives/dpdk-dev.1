Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C44C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FB4C4067A;
	Mon, 23 Jun 2025 15:53:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2A29740685
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh8hnDw+4BY2aSE2vMHatij/YhBjrkHVHvuF371dO/A=;
 b=QGL7Hm11eQ2i/HgU/bF0E2d9m1Qre2uhh0RKn5WlOduKwFYYmvIAX/8DcTeGGHZAlcTIJo
 zWpJ5iN2q6NTjuYQwjHOBKRxVnVybjI5xixvn2B6E9K1BstWeTd7dZDGL1OHRzTLQ3N+Qp
 FlXNgp4cail5DzytKCmhi4TgkqaB15c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-aM3NMLQaPO64SuQxoVGX_w-1; Mon,
 23 Jun 2025 09:53:24 -0400
X-MC-Unique: aM3NMLQaPO64SuQxoVGX_w-1
X-Mimecast-MFC-AGG-ID: aM3NMLQaPO64SuQxoVGX_w_1750686803
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01F0819560B0; Mon, 23 Jun 2025 13:53:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD986180045B; Mon, 23 Jun 2025 13:53:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v2 07/10] tailq: fix cast macro for null pointer
Date: Mon, 23 Jun 2025 15:52:37 +0200
Message-ID: <20250623135242.461965-8-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -6TXRngT54r_W6HF7Srk_md6qaPvYOD64C83jK-aZEM_1750686803
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

Doing arithmetics with the NULL pointer is undefined.

Caught by UBSan:

../app/test/test_tailq.c:111:9: runtime error:
	member access within null pointer of type 'struct rte_tailq_head'

Fixes: f6b4f6c9c123 ("tailq: use a single cast macro")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/include/rte_tailq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index 89f7ef2134..c23df77d96 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -54,7 +54,7 @@ struct rte_tailq_elem {
  * Return the first tailq entry cast to the right struct.
  */
 #define RTE_TAILQ_CAST(tailq_entry, struct_name) \
-	(struct struct_name *)&(tailq_entry)->tailq_head
+	(tailq_entry == NULL ? NULL : (struct struct_name *)&(tailq_entry)->tailq_head)
 
 /**
  * Utility macro to make looking up a tailqueue for a particular struct easier.
-- 
2.49.0

