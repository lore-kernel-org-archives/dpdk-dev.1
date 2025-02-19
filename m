Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956AFC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A0E40E6E;
	Wed, 19 Feb 2025 14:27:51 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B1A9B40E39
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:27:49 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yycbm6x4Zz6GD8J;
 Wed, 19 Feb 2025 21:26:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id A790314050C;
 Wed, 19 Feb 2025 21:27:48 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 14:27:48 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>
Subject: [PATCH] test/ring: fix return uninitialized variable
Date: Wed, 19 Feb 2025 09:23:14 -0500
Message-ID: <20250219142314.82235-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml500005.china.huawei.com (7.182.85.13) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

This change addresses the CID 455328: Uninitialized variables  (UNINIT).
Strictly speaking right now it should never happen, as role_mask is not
zero. But that might change in future, as more test-cases will be
introduced. Anyway the fix is trivial.

Coverity issue: 455328
Fixes: 70581c355d69 ("test/ring: add unit tests for soring API")

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_soring_stress_impl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test/test_soring_stress_impl.h b/app/test/test_soring_stress_impl.h
index 9e22de98d2..015825223d 100644
--- a/app/test/test_soring_stress_impl.h
+++ b/app/test/test_soring_stress_impl.h
@@ -405,6 +405,8 @@ test_worker(void *arg, const char *fname, int32_t prcs)
 	cl = rte_rdtsc_precise();
 
 	do {
+		rc = 0;
+
 		if ((la->stats.role_mask & ~ROLE_DEQENQ) != 0) {
 			rc = test_worker_stages(la, lc, fname, obj,
 				&def_elm, &loc_elm, stg_elm, prcs);
-- 
2.35.3

