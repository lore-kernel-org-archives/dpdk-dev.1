Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90CC02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:08:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8EF40A6D;
	Mon,  3 Feb 2025 05:07:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0502B4068E
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B84DD205491C; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B84DD205491C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555607;
 bh=VBzdCs4Vk7omdaZhx0PODKhULU/9lWDaJ9q39L8JA3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ex17MKLs5CqCsquy2Cm6JQk1NyQAn1YYRfvXUIlTT0mtSiJcVhj8ptHhrxyLv1JmU
 NxdFC9lOaWVYkGZQZlSt4CpK0KqUr86IVGRkE6o9onTHXdhY407emtM8XScJKSUmYg
 WTZmf8pHhVtMfEgXzQEN2mbYyvLASMcK4adRgHrs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v19 15/27] net/i40e: remove use of VLAs for Windows built code
Date: Sun,  2 Feb 2025 20:06:18 -0800
Message-Id: <1738555590-12753-16-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

