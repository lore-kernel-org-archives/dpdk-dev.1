Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E051CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 11:28:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD97402BC;
	Thu,  7 May 2026 13:28:01 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 94B9440265
 for <dev@dpdk.org>; Thu,  7 May 2026 13:27:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4No9YkyJMTqB1r5pGtzROZiwv7iXS8xTUltPBeKF5c0=;
 b=Y/WI0/fEvaH+x7/XaZirkKNVwIaMk9hnbiQgnJ7XDr2ZOOUaVQym4jvNkZ6UmBN1/+rRPyG8/
 6V+oCmw3GvNAQYnQQEfOtez80k1T4CtrTZNCami3SqBzMZ3GJAftaCBbtPYci6ypCKRUesEHa0M
 gXx1TysW8+b9asYPeQ34LPQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gB8v13TTszcZyt;
 Thu,  7 May 2026 19:20:45 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id F2EE540561;
 Thu,  7 May 2026 19:27:55 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 19:27:55 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 19:27:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH] power: fix duplicated typedef for setting uncore freq
Date: Thu, 7 May 2026 19:27:54 +0800
Message-ID: <20260507112754.3418377-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Remove a duplicated rte_power_set_uncore_freq_t definition.
And this ops is intended to set any available uncore frequency instead
of minimum and maximum one.

Fixes: ebe99d351a3f ("power: refactor uncore power management")
Cc: stable@dpdk.org

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/power_uncore_ops.h | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/lib/power/power_uncore_ops.h b/lib/power/power_uncore_ops.h
index 783860ee5b..025a55cb97 100644
--- a/lib/power/power_uncore_ops.h
+++ b/lib/power/power_uncore_ops.h
@@ -76,8 +76,7 @@ typedef int (*rte_power_uncore_exit_t)(unsigned int pkg, unsigned int die);
 typedef uint32_t (*rte_power_get_uncore_freq_t)(unsigned int pkg, unsigned int die);
 
 /**
- * Set minimum and maximum uncore frequency for specified die on a package
- * to specified index value.
+ * Set uncore frequency for specified die on a package to specified index value.
  * It should be protected outside of this function for threadsafe.
  *
  * This function should NOT be called in the fast path.
@@ -98,27 +97,6 @@ typedef uint32_t (*rte_power_get_uncore_freq_t)(unsigned int pkg, unsigned int d
  */
 typedef int (*rte_power_set_uncore_freq_t)(unsigned int pkg, unsigned int die, uint32_t index);
 
-/**
- * Return the list length of available frequencies in the index array.
- *
- * This function should NOT be called in the fast path.
- *
- * @param pkg
- *  Package number.
- *  Each physical CPU in a system is referred to as a package.
- * @param die
- *  Die number.
- *  Each package can have several dies connected together via the uncore mesh.
- * @param index
- *  The index of available frequencies.
- *
- * @return
- *  - 1 on success with frequency changed.
- *  - 0 on success without frequency changed.
- *  - Negative on error.
- */
-typedef int (*rte_power_set_uncore_freq_t)(unsigned int pkg, unsigned int die, uint32_t index);
-
 /**
  * Return the list length of available frequencies in the index array.
  *
-- 
2.33.0

