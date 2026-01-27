Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E4D2F003
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 11:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94F9440E24;
	Tue, 27 Jan 2026 12:50:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE6A40E20;
 Tue, 27 Jan 2026 12:50:29 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0kGm6pyzzJ46Yf;
 Tue, 27 Jan 2026 19:49:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id CF72D40086;
 Tue, 27 Jan 2026 19:50:28 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 12:50:28 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>, Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Chengwen Feng <fengchengwen@huawei.com>
CC: <jerinjacobk@gmail.com>, <konstantin.ananyev@huawei.com>,
 <mb@smartsharesystems.com>, <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH v4 1/6] eal: variable first arguments of RTE_SHIFT_VALxx
Date: Tue, 27 Jan 2026 11:49:37 +0000
Message-ID: <20260127114944.35993-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127114944.35993-1-marat.khalili@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500005.china.huawei.com (7.182.19.99) To
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

Macros RTE_SHIFT_VAL32 and RTE_SHIFT_VAL64 were implemented by applying
UINT32_C or UINT64_C correspondingly to its first argument. As a
consequence first argument had to be a constant. Replace UINT32_C and
UINT64_C with casts to uint32_t and uint64_t to allow these arguments be
variable. For constants the result should be the same.

(Yes, technically UINT64_C promotes to uint_least64_t, not uint64_t, but
I think most users of RTE_SHIFT_VAL64 expect the result to be uint64_t.)

Fixes: 1d8f2285ed3f ("eal: introduce more macros for bit definition")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index 2d1b9d281c..aa6ac73abb 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -51,7 +51,7 @@ extern "C" {
  * @param nr
  *   The shift number in range of 0 to (32 - width of val).
  */
-#define RTE_SHIFT_VAL32(val, nr) (UINT32_C(val) << (nr))
+#define RTE_SHIFT_VAL32(val, nr) ((uint32_t)(val) << (nr))
 
 /**
  * Get the uint64_t shifted value.
@@ -61,7 +61,7 @@ extern "C" {
  * @param nr
  *   The shift number in range of 0 to (64 - width of val).
  */
-#define RTE_SHIFT_VAL64(val, nr) (UINT64_C(val) << (nr))
+#define RTE_SHIFT_VAL64(val, nr) ((uint64_t)(val) << (nr))
 
 /**
  * Generate a contiguous 32-bit mask
-- 
2.34.1

