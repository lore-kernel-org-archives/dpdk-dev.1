Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C67C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB8B40685;
	Tue,  7 Jul 2026 10:51:26 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 27EA940647
 for <dev@dpdk.org>; Tue,  7 Jul 2026 10:51:25 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gvZgQ32HnzJ46C9;
 Tue,  7 Jul 2026 16:50:26 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4AF3940575;
 Tue,  7 Jul 2026 16:51:24 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 10:51:24 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v3 2/8] doc: document rte_os.h
Date: Tue, 7 Jul 2026 09:50:40 +0100
Message-ID: <20260707085048.15295-3-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707085048.15295-1-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
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

File rte_os.h did not previously have a generic version to generate
documentation from, but its OS-specific version was installed. Since it
is now verified that documentation is generated for all public headers,
add a generic stub containing description of this file.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/eal/include/generic/rte_os.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 lib/eal/include/generic/rte_os.h

diff --git a/lib/eal/include/generic/rte_os.h b/lib/eal/include/generic/rte_os.h
new file mode 100644
index 000000000000..aa96321aefc4
--- /dev/null
+++ b/lib/eal/include/generic/rte_os.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2019 Intel Corporation
+ */
+
+#ifndef _RTE_OS_H_
+#define _RTE_OS_H_
+
+/**
+ * This header should contain any definition
+ * which is not supported natively or named differently in the local OS.
+ */
+
+#endif /* _RTE_OS_H_ */
-- 
2.43.0

