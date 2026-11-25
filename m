Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB06606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=eEXPvb+v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1A5340616;
	Wed, 25 Nov 2026 15:06:30 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 0EA0140284
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EMzCQQB2Y5Jcul2Adh4LQbwiNiBeWheYigMal+GnhjY=;
 b=eEXPvb+vd3QqLsdzcUMM/x0rPNnOWHFkA6yl01+1DZa6kre/MCBV6mmy7o9mG/OckfjefhusH
 22+CUaz5UcSz5tyrlnhXAEGPb8mi8yhQTfkrEh2G7nygEUbtzsbPKcYPiwn+CIBS4BdPzW0F2C9
 3BDRU8l44WRinIrsZ9sjaxA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jZLzy4KB6z1T4H4;
 Wed, 25 Nov 2026 22:05:34 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D9CD40538;
 Wed, 25 Nov 2026 22:06:24 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:23 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 4/9] examples/l3fwd-power: add rollback in uncore init
Date: Wed, 25 Nov 2026 22:06:10 +0800
Message-ID: <20261125140616.3965843-5-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huisong Li <lihuisong@huawei.com>

Make power_uncore_init() roll back the packages and dies that were
already initialized when a later step fails, instead of leaving
them configured after an error return.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 examples/l3fwd-power/main.c | 44 ++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 03d8b3f5e1..857b885f43 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2193,6 +2193,8 @@ static int
 power_uncore_init(void)
 {
 	unsigned int die, pkg, max_pkg, max_die;
+	unsigned int init_pkg = 0, init_die = 0;
+	bool init_done = false;
 	int ret;
 
 	if (enabled_uncore == -1)
@@ -2210,22 +2212,28 @@ power_uncore_init(void)
 
 	for (pkg = 0; pkg < max_pkg; pkg++) {
 		max_die = rte_power_uncore_get_num_dies(pkg);
-		if (max_die == 0)
-			return -1;
+		if (max_die == 0) {
+			ret = -1;
+			goto uninit_uncore;
+		}
 		for (die = 0; die < max_die; die++) {
 			ret = rte_power_uncore_init(pkg, die);
 			if (ret == -1) {
 				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %02u die %02u\n"
 				, pkg, die);
-				return ret;
+				goto uninit_uncore;
 			}
+			init_pkg = pkg;
+			init_die = die;
+			init_done = true;
+
 			if (uncore_cfg.uncore_choice == UNCORE_MIN) {
 				ret = rte_power_uncore_freq_min(pkg, die);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
 					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
 					, pkg, die);
-					return ret;
+					goto uninit_uncore;
 				}
 			} else if (uncore_cfg.uncore_choice == UNCORE_MAX) {
 				ret = rte_power_uncore_freq_max(pkg, die);
@@ -2233,32 +2241,52 @@ power_uncore_init(void)
 					RTE_LOG(INFO, L3FWD_POWER,
 					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
 					, pkg, die);
-					return ret;
+					goto uninit_uncore;
 				}
 			} else if (uncore_cfg.uncore_choice == UNCORE_IDX) {
 				int freq_array_len = rte_power_uncore_get_num_freqs(pkg, die);
 				if (freq_array_len <= 0) {
 					RTE_LOG(INFO, L3FWD_POWER, "Get uncore frequency number failed.\n");
-					return -1;
+					ret = -1;
+					goto uninit_uncore;
 				}
 				if (uncore_cfg.freq_idx > (uint32_t)(freq_array_len - 1)) {
 					RTE_LOG(INFO, L3FWD_POWER,
 					"Frequency index given out of range, please choose a value from 0 to %d.\n",
 					freq_array_len - 1);
-					return -1;
+					ret = -1;
+					goto uninit_uncore;
 				}
 				ret = rte_power_set_uncore_freq(pkg, die, uncore_cfg.freq_idx);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
 					"Unable to set specified frequency index for pkg %02u die %02u\n",
 					pkg, die);
-					return ret;
+					goto uninit_uncore;
 				}
 			}
 		}
 	}
 
 	return 0;
+
+uninit_uncore:
+	/* Roll back the pkg/die that were initialized before the failure. */
+	if (init_done) {
+		for (pkg = 0; pkg <= init_pkg; pkg++) {
+			if (pkg == init_pkg)
+				max_die = init_die + 1;
+			else {
+				max_die = rte_power_uncore_get_num_dies(pkg);
+				if (max_die == 0)
+					break;
+			}
+			for (die = 0; die < max_die; die++)
+				rte_power_uncore_exit(pkg, die);
+		}
+	}
+
+	return ret;
 }
 
 static int
-- 
2.33.0

