Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D653C021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B735040609;
	Thu, 20 Feb 2025 03:01:58 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id F29FB4014F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:01:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7A4C1204E5B6; Wed, 19 Feb 2025 18:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A4C1204E5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016907;
 bh=rifw1IyScKCgx/ZxTwA9tsFkppB/mtm2BWmVGJk/4Qk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J4COSHJXufdbEgpgx7f9jClH96vKtqSZ79esOixIGQd76JF8a6MjttCCrlGKb9Yxu
 Uona05P0knetcDr4rBNWjRAa0xq/5m1f835Tp2rb/rnp7dlNLSQcIV4v8AQHLouNha
 cFyBTgDbthpqI0OiXiaVnpk2clKrlfyIt9YuN4nY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 06/10] test-pmd: avoid non-constant initializer
Date: Wed, 19 Feb 2025 18:01:35 -0800
Message-Id: <1740016899-2817-7-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in errors like the one below:

app/test-pmd/cmdline_flow.c(8819): error C2099: initializer
    is not a constant

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline_flow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index e1720e54d7..24323d8891 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -8812,8 +8812,6 @@ parse_vc_spec(struct context *ctx, const struct token *token,
 		return -1;
 	/* Parse parameter types. */
 	switch (ctx->curr) {
-		static const enum index prefix[] = NEXT_ENTRY(COMMON_PREFIX);
-
 	case ITEM_PARAM_IS:
 		index = 0;
 		objmask = 1;
@@ -8828,7 +8826,7 @@ parse_vc_spec(struct context *ctx, const struct token *token,
 		/* Modify next token to expect a prefix. */
 		if (ctx->next_num < 2)
 			return -1;
-		ctx->next[ctx->next_num - 2] = prefix;
+		ctx->next[ctx->next_num - 2] = NEXT_ENTRY(COMMON_PREFIX);
 		/* Fall through. */
 	case ITEM_PARAM_MASK:
 		index = 2;
@@ -9270,7 +9268,6 @@ parse_vc_action_rss_type(struct context *ctx, const struct token *token,
 			  const char *str, unsigned int len,
 			  void *buf, unsigned int size)
 {
-	static const enum index next[] = NEXT_ENTRY(ACTION_RSS_TYPE);
 	struct action_rss_data *action_rss_data;
 	unsigned int i;
 
@@ -9296,7 +9293,7 @@ parse_vc_action_rss_type(struct context *ctx, const struct token *token,
 	/* Repeat token. */
 	if (ctx->next_num == RTE_DIM(ctx->next))
 		return -1;
-	ctx->next[ctx->next_num++] = next;
+	ctx->next[ctx->next_num++] = NEXT_ENTRY(ACTION_RSS_TYPE);
 	if (!ctx->object)
 		return len;
 	action_rss_data = ctx->object;
@@ -9314,7 +9311,6 @@ parse_vc_action_rss_queue(struct context *ctx, const struct token *token,
 			  const char *str, unsigned int len,
 			  void *buf, unsigned int size)
 {
-	static const enum index next[] = NEXT_ENTRY(ACTION_RSS_QUEUE);
 	struct action_rss_data *action_rss_data;
 	const struct arg *arg;
 	int ret;
@@ -9347,7 +9343,7 @@ parse_vc_action_rss_queue(struct context *ctx, const struct token *token,
 	/* Repeat token. */
 	if (ctx->next_num == RTE_DIM(ctx->next))
 		return -1;
-	ctx->next[ctx->next_num++] = next;
+	ctx->next[ctx->next_num++] = NEXT_ENTRY(ACTION_RSS_QUEUE);
 end:
 	if (!ctx->object)
 		return len;
-- 
2.48.1.vfs.0.0

