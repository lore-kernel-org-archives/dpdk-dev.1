Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA5C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A93840DDD;
	Thu,  6 Feb 2025 02:34:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id ECCF140608
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:38 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2F5FF203F5B3; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F5FF203F5B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805617;
 bh=VBzdCs4Vk7omdaZhx0PODKhULU/9lWDaJ9q39L8JA3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c8jackYNdg8mjr75x/0H+2TyMFJ47kzQ2NEAkySoFCh8vHIQnTwfwAHicS7whGnLK
 WYe4XhrFgNZ5YjJ8Fi6qAd519pV+TBu8Y7yMd9Zf4aniPDEwVwP4+CRKa9IBjMF5qq
 3JRLEuc2YFXQHqpRMvps3mB5aKtKn23cNuL6tucM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v22 15/27] net/i40e: remove use of VLAs for Windows built code
Date: Wed,  5 Feb 2025 17:33:18 -0800
Message-Id: <1738805610-17507-16-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_testpmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_testpmd.c b/drivers/net/intel/i40e/i40e_testpmd.c
index b6ef5d6e42..21f596297b 100644
--- a/drivers/net/intel/i40e/i40e_testpmd.c
+++ b/drivers/net/intel/i40e/i40e_testpmd.c
@@ -2168,8 +2168,7 @@ cmd_ptype_mapping_get_parsed(void *parsed_result,
 {
 	struct cmd_ptype_mapping_get_result *res = parsed_result;
 	int ret = -ENOTSUP;
-	int max_ptype_num = 256;
-	struct rte_pmd_i40e_ptype_mapping mapping[max_ptype_num];
+	struct rte_pmd_i40e_ptype_mapping mapping[256];
 	uint16_t count;
 	int i;
 
@@ -2178,7 +2177,7 @@ cmd_ptype_mapping_get_parsed(void *parsed_result,
 
 	ret = rte_pmd_i40e_ptype_mapping_get(res->port_id,
 					mapping,
-					max_ptype_num,
+					RTE_DIM(mapping),
 					&count,
 					res->valid_only);
 	switch (ret) {
-- 
2.47.2.vfs.0.1

