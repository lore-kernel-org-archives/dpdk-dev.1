Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F41C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A4642E62;
	Thu, 19 Jun 2025 09:11:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD36942E69
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdafeB+rAu96J/oAy7xHoa9QDY84Xd1OZqgPQGA366Q=;
 b=gfk+NfgLaJP4Y797WdAOx4wLInlaP8T+2ufLEinLc6kQ0tENksgdSn+oAPwNQtG4DJX+3Q
 t4kTH1oH5pmPLvvd85iq0i9YF07+AYcZStWUCeuEHnebByUXpqwRP3RjvzFktbj5NvpapO
 peCtNQ5NadfUQ7z1J7tU7nvkjZclLos=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-zXs3ggBGNp23DW2uRqL86w-1; Thu,
 19 Jun 2025 03:11:46 -0400
X-MC-Unique: zXs3ggBGNp23DW2uRqL86w-1
X-Mimecast-MFC-AGG-ID: zXs3ggBGNp23DW2uRqL86w_1750317105
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EE3319560A2; Thu, 19 Jun 2025 07:11:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5A791956094; Thu, 19 Jun 2025 07:11:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 07/10] tailq: fix cast macro for null pointer
Date: Thu, 19 Jun 2025 09:10:33 +0200
Message-ID: <20250619071037.37325-8-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yaW3xOMRmWHbywqQHOq_AY5qABO0Ykeu0mSZ4ijY6Rw_1750317105
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

