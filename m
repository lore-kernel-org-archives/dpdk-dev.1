Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5265340E2D;
	Wed, 23 Jul 2025 15:32:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 77CCC40E11
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsyMdGafHIrvRWEJZF5fgKppeEeST9GhMEKhUSBBxQE=;
 b=cq267xNyx801Ks+XmHylNXkNuzBP7M+nebXIe3SLHnLS1ucElK/KqcZE9XFT1aIB9NFHni
 eUa1UzBBPAGij5CjVPlLCdGqz6J9Y1YEtR1zdTSM7OIn/qj5/fpOtTkqe2SX8OICNsIR+i
 tqGl6gGIQyYLoqJIWn0pSWCwaXTACQI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-u1ZDj21pNcS2FY3hhtBTbg-1; Wed,
 23 Jul 2025 09:32:41 -0400
X-MC-Unique: u1ZDj21pNcS2FY3hhtBTbg-1
X-Mimecast-MFC-AGG-ID: u1ZDj21pNcS2FY3hhtBTbg_1753277560
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E0A21944D23; Wed, 23 Jul 2025 13:32:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D919930002C0; Wed, 23 Jul 2025 13:32:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 06/22] cmdline: fix highest bit port list parsing
Date: Wed, 23 Jul 2025 15:31:39 +0200
Message-ID: <20250723133157.159825-7-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bnLNgltwXO4hujsDUqu5vmO-xZg8dBTmVsLWVmJah00_1753277560
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
Changes since v1:
- moved variable increment out of the macro call,

---
 lib/cmdline/cmdline_parse_portlist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index 549f6d9671..3efe4143e3 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -10,7 +10,9 @@
 #include <errno.h>
 
 #include <eal_export.h>
+#include <rte_bitops.h>
 #include <rte_string_fns.h>
+
 #include "cmdline_parse.h"
 #include "cmdline_parse_portlist.h"
 
@@ -26,7 +28,8 @@ static void
 parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
 {
 	do {
-		pl->map |= (1 << low++);
+		pl->map |= RTE_BIT32(low);
+		low++;
 	} while (low <= high);
 }
 
-- 
2.50.0

