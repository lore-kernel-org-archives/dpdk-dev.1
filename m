Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF29C55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC6040144;
	Wed,  5 Aug 2026 11:05:29 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A14574003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 11:05:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6huUL6/crhZajQ1YpsVIvL+BGIQHFHZzoaOUknX6YbA=;
 b=YlgwX+qzK+yeHTHWjJ6YIqqCnh+CjOjCtlqc5/8jGgjXnWnYNkM6WnjvFlGdiVFYeSfhAZPQb
 j4rcl1vR9h9qTq7COFbZeYo7WTouolhyN42Wofa2z412a1Wb51R77fwb0STTN2apeBfLxIxLfXX
 AbqSFvdGah4plYo0giyIpKE=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFPcH5zbwzHnGjP;
 Wed,  5 Aug 2026 17:04:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id A75B74058E;
 Wed,  5 Aug 2026 17:05:25 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 11:05:25 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: [PATCH 1/1] test/bpf: remove redundant library guard
Date: Wed, 5 Aug 2026 10:03:50 +0100
Message-ID: <20260805090350.37661-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500004.china.huawei.com (7.182.19.21) To
 frapema500003.china.huawei.com (7.182.19.114)
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

The app/test/meson.build already adds 'bpf' as a dependency to test_bpf.c.
If the bpf library is disabled, the test source file is excluded from
the build entirely.

Therefore, the RTE_LIB_BPF guard is dead code and can be removed.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..88ee8ec224 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -15,24 +15,12 @@
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
-
-#include "test.h"
-
-#if !defined(RTE_LIB_BPF)
-
-static int
-test_bpf(void)
-{
-	printf("BPF not supported, skipping test\n");
-	return TEST_SKIPPED;
-}
-
-#else
-
 #include <rte_bpf.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
 
+#include "test.h"
+
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
 
@@ -3744,7 +3732,6 @@ test_bpf(void)
 	return rc;
 }
 
-#endif /* !RTE_LIB_BPF */
 
 REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
 
-- 
2.43.0

