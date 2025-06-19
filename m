Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC417C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D0A342E5E;
	Thu, 19 Jun 2025 09:11:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BCCC42DD9
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tgOUZwb17XRaMThT2KI8CAnuJYpaMfR+UADjTiyVaU=;
 b=PZjnNhqTbfcrYrX9kXUvNXA2IbZ7j5fkKbEZ8nul9ULXRMdDBXNyMuq2EYCBmR9dPZ4d55
 FtA/y+kRKghhI/SQTSH7FbzEivRx3J/trz36n9UZq0IYxDQ1pY80taYEFCndLrTMtUHE0M
 4PNaR+V2omoh+Mba+A/KLQYTpmmFhlA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Lq9Kfg91N0KA1Mj3ybU5Hw-1; Thu,
 19 Jun 2025 03:11:37 -0400
X-MC-Unique: Lq9Kfg91N0KA1Mj3ybU5Hw-1
X-Mimecast-MFC-AGG-ID: Lq9Kfg91N0KA1Mj3ybU5Hw_1750317096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29E3C19560AD; Thu, 19 Jun 2025 07:11:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D97618003FC; Thu, 19 Jun 2025 07:11:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH 05/10] cmdline: fix port list parsing
Date: Thu, 19 Jun 2025 09:10:31 +0200
Message-ID: <20250619071037.37325-6-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -8KFiyaFVJTUBmQYq6gFnSiFZTOoAPoCe49wV5qVKt0_1750317096
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

../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
	applying non-zero offset 1 to null pointer
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/cmdline/cmdline_parse_portlist.c:40:19 in

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/cmdline/cmdline_parse_portlist.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index ef6ce223b5..0c07cc02b5 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -37,10 +38,11 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
 	const char *first, *last;
 	char *end;
 
-	for (first = str, last = first;
-	    first != NULL && last != NULL;
-	    first = last + 1) {
+	if (str == NULL)
+		return 0;
 
+	last = first = str;
+	do {
 		last = strchr(first, ',');
 
 		errno = 0;
@@ -65,7 +67,10 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
 			return -1;
 
 		parse_set_list(pl, ps, pe);
-	}
+		if (last == NULL)
+			break;
+		first = last + 1;
+	} while (true);
 
 	return 0;
 }
-- 
2.49.0

