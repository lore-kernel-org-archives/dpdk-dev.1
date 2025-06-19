Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987BC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 746A442E58;
	Thu, 19 Jun 2025 09:11:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 771EC42E5A
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=El6OmV1roko/OO0wvMEz3t6dtClBPmKTCP+mVQexORw=;
 b=ELyWt94jduoqOjnBeeg9oyGX9P8gpcIWnNeQNALY+XhbXW3t/hRbZQGn7BI5iOS1cGCBxV
 pbSlf5pJO3CpS//0UQmS82NcHYgVNryOkWzPuoUP10zLvNmtTVE40eTsgxNJO2vmWVDEiI
 g0z/HVK5WQSWeS/+LoWK/nsgvWCYXkU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-nscg3ePVPD2kH0Op7fH8IA-1; Thu,
 19 Jun 2025 03:11:41 -0400
X-MC-Unique: nscg3ePVPD2kH0Op7fH8IA-1
X-Mimecast-MFC-AGG-ID: nscg3ePVPD2kH0Op7fH8IA_1750317100
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 673501800286; Thu, 19 Jun 2025 07:11:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42DF1195608F; Thu, 19 Jun 2025 07:11:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH 06/10] cmdline: fix highest bit port list parsing
Date: Thu, 19 Jun 2025 09:10:32 +0200
Message-ID: <20250619071037.37325-7-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ByUSZDMbYhK_Nu1BVHAWykW_aNQz-4QHE2na1B2EBcM_1750317100
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

pl->map is a uint32_t.

Caught by UBSan:

../lib/cmdline/cmdline_parse_portlist.c:27:17: runtime error:
	left shift of 1 by 31 places cannot be represented in type 'int'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/cmdline/cmdline_parse_portlist.c:27:17 in

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/cmdline/cmdline_parse_portlist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index 0c07cc02b5..3ef427d32a 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -11,7 +11,9 @@
 #include <errno.h>
 
 #include <eal_export.h>
+#include <rte_bitops.h>
 #include <rte_string_fns.h>
+
 #include "cmdline_parse.h"
 #include "cmdline_parse_portlist.h"
 
@@ -27,7 +29,7 @@ static void
 parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
 {
 	do {
-		pl->map |= (1 << low++);
+		pl->map |= RTE_BIT32(low++);
 	} while (low <= high);
 }
 
-- 
2.49.0

