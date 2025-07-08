Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2731C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29D354069F;
	Tue,  8 Jul 2025 14:30:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 654964069F
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsyMdGafHIrvRWEJZF5fgKppeEeST9GhMEKhUSBBxQE=;
 b=WfC4JkOajqvADlcTkZrARwJQlGrSwfwAA6kzCt8NORmy6h1j0K65VPPZJ8VKXVOfRBSUGe
 gcb4eOhYKuKaJZ6/RB7oDOC1F9y6lFHJV8zMuALG+sy5J2vhmeH2QJFM+IkkYEaRY2DB5G
 dV3u3/PZAs4SBaYCQli/Qej5nd46jmk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380--nN0NdVuOiymekkwtMBo1w-1; Tue,
 08 Jul 2025 08:30:01 -0400
X-MC-Unique: -nN0NdVuOiymekkwtMBo1w-1
X-Mimecast-MFC-AGG-ID: -nN0NdVuOiymekkwtMBo1w_1751977800
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F57C18011F9; Tue,  8 Jul 2025 12:30:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C345B195608F; Tue,  8 Jul 2025 12:29:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 06/18] cmdline: fix highest bit port list parsing
Date: Tue,  8 Jul 2025 14:28:10 +0200
Message-ID: <20250708122823.3406288-7-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FJOedGyDDiygeZ4BAkfdhC88sSjiROJ7X_TA-nxS21I_1751977800
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

