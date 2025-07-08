Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4FCC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:30:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22A3640A6D;
	Tue,  8 Jul 2025 14:30:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4F7940697
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4m8iX6FvYNmNNYHKvLKlwYU4n58wXarstX4VhgPN8I=;
 b=hfEKaEhBJbfn03jyCBNVX/KGJvvRm3Ue4yYewmvEvF82qIqG+9ID7NzZRqdM3YkHW78Y1c
 +5RuCZdHrfllWGfN158wVA5ytbq16w834GAuWm/Ihd6rbYPA7LzESD8BKQ+FkxIldmCig1
 sTaMUAormdGkBo8Bpib0YHGfReH1GWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-MbavPdw6OGG_K9yFvNS61Q-1; Tue,
 08 Jul 2025 08:30:09 -0400
X-MC-Unique: MbavPdw6OGG_K9yFvNS61Q-1
X-Mimecast-MFC-AGG-ID: MbavPdw6OGG_K9yFvNS61Q_1751977808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B634B180028C; Tue,  8 Jul 2025 12:30:07 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3E6C30001B1; Tue,  8 Jul 2025 12:30:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3 07/18] tailq: fix cast macro for null pointer
Date: Tue,  8 Jul 2025 14:28:11 +0200
Message-ID: <20250708122823.3406288-8-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cGF9vLM2suV8fqm4ULDtEab-DyjuaER3uYpmdi61rdk_1751977808
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
2.50.0

