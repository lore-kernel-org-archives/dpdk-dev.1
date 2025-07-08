Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C3C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A110340677;
	Tue,  8 Jul 2025 14:52:04 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id DC478402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:52:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bc1Cx4qByz2Bcn0;
 Tue,  8 Jul 2025 20:50:05 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 826851400D4;
 Tue,  8 Jul 2025 20:52:00 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 20:51:59 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] app/testpmd: fix set cores list string size
Date: Tue, 8 Jul 2025 20:51:59 +0800
Message-ID: <20250708125159.2457578-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

The cmdline_fixed_string_t has a length of only 128, which will
become insufficient when there are many cores, so it should be
replaced with a cmdline_multi_string_t of larger capacity.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-pmd/cmdline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..801dee4456 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -4063,7 +4063,7 @@ parse_item_list(const char *str, const char *item_name, unsigned int max_items,
 	value = 0;
 	nb_item = 0;
 	value_ok = 0;
-	for (i = 0; i < strnlen(str, STR_TOKEN_SIZE); i++) {
+	for (i = 0; i < strnlen(str, STR_MULTI_TOKEN_SIZE); i++) {
 		c = str[i];
 		if ((c >= '0') && (c <= '9')) {
 			value = (unsigned int) (value * 10 + (c - '0'));
@@ -4114,7 +4114,7 @@ parse_item_list(const char *str, const char *item_name, unsigned int max_items,
 struct cmd_set_list_result {
 	cmdline_fixed_string_t cmd_keyword;
 	cmdline_fixed_string_t list_name;
-	cmdline_fixed_string_t list_of_items;
+	cmdline_multi_string_t list_of_items;
 };
 
 static void cmd_set_list_parsed(void *parsed_result,
@@ -4163,7 +4163,7 @@ static cmdline_parse_token_string_t cmd_set_list_name =
 				 "corelist#portlist");
 static cmdline_parse_token_string_t cmd_set_list_of_items =
 	TOKEN_STRING_INITIALIZER(struct cmd_set_list_result, list_of_items,
-				 NULL);
+				 TOKEN_STRING_MULTI);
 
 static cmdline_parse_inst_t cmd_set_fwd_list = {
 	.f = cmd_set_list_parsed,
-- 
2.33.0

