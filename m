Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D1C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:15:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C21427BB;
	Wed, 21 May 2025 13:15:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7E17B427C4
 for <dev@dpdk.org>; Wed, 21 May 2025 13:15:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TMm1t05z6L54t;
 Wed, 21 May 2025 19:14:28 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 298841402FC;
 Wed, 21 May 2025 19:15:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:15:20 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: [PATCH v1 4/4] config/x86: enable RTE_USE_C11_MEM_MODEL by default
Date: Wed, 21 May 2025 12:14:32 +0100
Message-ID: <20250521111432.207936-5-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
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

As an attempt to reduce legacy code usage within rte_ring -
enable RTE_USE_C11_MEM_MODEL by default on all x86 platforms.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 config/x86/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index c3564b0011..5528eb4960 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -21,6 +21,7 @@ endif
 
 dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
 dpdk_conf.set('RTE_MAX_LCORE', 128)
+dpdk_conf.set('RTE_USE_C11_MEM_MODEL', true)
 
 epyc_zen_cores = {
     '__znver5__':768,
-- 
2.43.0

