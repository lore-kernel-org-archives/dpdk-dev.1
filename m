Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96CFC0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5771402E8;
	Mon, 10 Feb 2025 22:32:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 78EFF402DA
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCi8gg4MNQ3BZ7agtcJbRKg4oKZQ1ojqw51Dqvw7y9s=;
 b=BTITYa4TDcLPl7QonP/Op2uUhBSiG1SymrEDUSSUMoNABMbj5t54LIPQOyFNo//3ba1N7o
 uizn19lJWRRlW34Yc3nxsnObtWt9KGPcFFpZv2lEVoZtULLszPLBj74oalJiG6E2dOBfOc
 bKw1YEgM/SetpRmyq94f6cgO8dcr2nY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-VOvXhGO9Px-nHwN_4mErtw-1; Mon,
 10 Feb 2025 16:32:11 -0500
X-MC-Unique: VOvXhGO9Px-nHwN_4mErtw-1
X-Mimecast-MFC-AGG-ID: VOvXhGO9Px-nHwN_4mErtw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 959951800991; Mon, 10 Feb 2025 21:32:10 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BC1B19560A3; Mon, 10 Feb 2025 21:32:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 1/5] eal: check lcore variable handle
Date: Mon, 10 Feb 2025 22:31:54 +0100
Message-ID: <20250210213158.4165701-2-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ttAU7ujHr1DS6yPdnOt5LDOkLpe0dFiHUDpsG5vI4Aw_1739223130
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

Add an assert to double check the passed handle is not NULL, as it
points at an initialisation/allocation issue prior to accessing this
lcore variable.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Frode Nordahl <frode.nordahl@canonical.com>
---
 lib/eal/include/rte_lcore_var.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
index 0216a67cab..ca31dff6fd 100644
--- a/lib/eal/include/rte_lcore_var.h
+++ b/lib/eal/include/rte_lcore_var.h
@@ -24,6 +24,7 @@
 
 #include <rte_common.h>
 #include <rte_config.h>
+#include <rte_debug.h>
 #include <rte_lcore.h>
 
 #ifdef __cplusplus
@@ -125,6 +126,7 @@ extern "C" {
 static inline void *
 rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
 {
+	RTE_ASSERT(handle != NULL);
 	return RTE_PTR_ADD(handle, lcore_id * RTE_MAX_LCORE_VAR);
 }
 /* >8 end of access function */
-- 
2.48.1

