Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64BCD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AAA240609;
	Wed, 17 Jun 2026 12:31:11 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 0F50A40431
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:31:10 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=E4wyBSKyoSjEd6KGeixUOrwq44dtM7Wl1KXnu3rY7EI=;
 b=U1WGbzFUAquYVNDTxYPVhavZmmFTbXi6pn1RX3lcAbJKuIjP3ofdOyllevqnVUBtlG3doQZOx
 ZKnHss/Bm2cgyNyUo7nuVnTbxD4KUlm1C4u7xyM/h6tCIMypgeRb46wTqrTq/CGv8nE4LHxzpRJ
 SxU0k4pjEeCxBzDLv7OAYoA=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4ggKg66LcbzcZyX;
 Wed, 17 Jun 2026 18:22:42 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=E4wyBSKyoSjEd6KGeixUOrwq44dtM7Wl1KXnu3rY7EI=;
 b=U1WGbzFUAquYVNDTxYPVhavZmmFTbXi6pn1RX3lcAbJKuIjP3ofdOyllevqnVUBtlG3doQZOx
 ZKnHss/Bm2cgyNyUo7nuVnTbxD4KUlm1C4u7xyM/h6tCIMypgeRb46wTqrTq/CGv8nE4LHxzpRJ
 SxU0k4pjEeCxBzDLv7OAYoA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4ggKfz3V5Sz1T4G5;
 Wed, 17 Jun 2026 18:22:35 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 715EA40576;
 Wed, 17 Jun 2026 18:31:06 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 18:31:05 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>
CC: <mb@smartsharesystems.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 1/5] eal: prefix lcore role enum values
Date: Wed, 17 Jun 2026 18:28:30 +0800
Message-ID: <20260617102834.2343356-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260617102834.2343356-1-lihuisong@huawei.com>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Add the RTE_LCORE_ prefix to the lcore role enum values in
rte_lcore_role_t to follow DPDK naming conventions.

- ROLE_RTE      -> RTE_LCORE_ROLE_RTE
- ROLE_OFF      -> RTE_LCORE_ROLE_OFF
- ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
- ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL

Old names are kept as macros aliasing to the new names to preserve
backward compatibility.

Suggested-by: Thomas Monjalon <thomas@monjalon.net>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/eal/include/rte_lcore.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 10f965b4f0..2fc4d0b15b 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -31,12 +31,18 @@ RTE_DECLARE_PER_LCORE(unsigned, _lcore_id);  /**< Per thread "lcore id". */
  * The lcore role (used in RTE or not).
  */
 enum rte_lcore_role_t {
-	ROLE_RTE,
-	ROLE_OFF,
-	ROLE_SERVICE,
-	ROLE_NON_EAL,
+	RTE_LCORE_ROLE_RTE,
+	RTE_LCORE_ROLE_OFF,
+	RTE_LCORE_ROLE_SERVICE,
+	RTE_LCORE_ROLE_NON_EAL,
 };
 
+/* Old lcore role aliases for backward compatibility. */
+#define ROLE_RTE	RTE_LCORE_ROLE_RTE
+#define ROLE_OFF	RTE_LCORE_ROLE_OFF
+#define ROLE_SERVICE	RTE_LCORE_ROLE_SERVICE
+#define ROLE_NON_EAL	RTE_LCORE_ROLE_NON_EAL
+
 /**
  * Get a lcore's role.
  *
@@ -308,7 +314,8 @@ rte_lcore_callback_unregister(void *handle);
 typedef int (*rte_lcore_iterate_cb)(unsigned int lcore_id, void *arg);
 
 /**
- * Iterate on all active lcores (ROLE_RTE, ROLE_SERVICE and ROLE_NON_EAL).
+ * Iterate on all active lcores (RTE_LCORE_ROLE_RTE, RTE_LCORE_ROLE_SERVICE
+ * and RTE_LCORE_ROLE_NON_EAL).
  * No modification on the lcore states is allowed in the callback.
  *
  * Note: as opposed to init/uninit callbacks, iteration callbacks can be
-- 
2.33.0

