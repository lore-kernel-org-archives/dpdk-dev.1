Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64237C36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 02:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 561AC4066E;
	Thu,  3 Apr 2025 04:57:42 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id A0F814029A
 for <dev@dpdk.org>; Thu,  3 Apr 2025 04:57:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZSmW42VwYz1f1Np;
 Thu,  3 Apr 2025 10:52:48 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 251F3140144;
 Thu,  3 Apr 2025 10:57:38 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 10:57:37 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <anatoly.burakov@intel.com>, <stephen@networkplumber.org>,
 <mb@smartsharesystems.com>, <dmitry.kozliuk@gmail.com>
Subject: [PATCH v2] mem: fix infinite loop
Date: Thu, 3 Apr 2025 10:57:36 +0800
Message-ID: <20250403025736.135846-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250402124258.2299435-1-huangdengdui@huawei.com>
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

When the process address space is insufficient,
mmap will fail, which will cause an infinite loop.
This patch stops attempting mmap if it fails and
the requested size cannot be reduced.

Fixes: b7cc54187ea4 ("mem: move virtual area function in common directory")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
---
 lib/eal/common/eal_common_memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index a185e0b580..0c997201bd 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -101,8 +101,12 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
 
 		mapped_addr = eal_mem_reserve(
 			requested_addr, (size_t)map_sz, reserve_flags);
-		if ((mapped_addr == NULL) && allow_shrink)
-			*size -= page_sz;
+		if (mapped_addr == NULL) {
+			if (allow_shrink)
+				*size -= page_sz;
+			else
+				break;
+		}
 
 		if ((mapped_addr != NULL) && addr_is_hint &&
 				(mapped_addr != requested_addr)) {
-- 
2.33.0

