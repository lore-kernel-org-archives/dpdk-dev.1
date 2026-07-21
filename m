Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB71C4452B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 17:42:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A401D40609;
	Tue, 21 Jul 2026 19:42:11 +0200 (CEST)
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by mails.dpdk.org (Postfix) with ESMTP id 1EF11402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 19:42:10 +0200 (CEST)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-51c08df8513so56980351cf.3
 for <dev@dpdk.org>; Tue, 21 Jul 2026 10:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784655729; x=1785260529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=us+mVWZHCHenNqtjc95UXJKadsREqtQfhxk5K+oW8sc=;
 b=ZbGnpexoNyD607X6ONS9fpzuJ+JQX+ZoZGwvNJkYHyYvQKGcLfTsqsjKj4rwwNoWED
 FXU3PU3ioUBU2oDCbuP28CQcvas0saD6olLCuqak6wzUEbsNsK3vjaB6vcjVziUrYZH2
 STo97ojm1JAY+n3OfoigK0L/KlxIJOWw4wx24/TIKyF5vQahTuh9+Uc+PDpCseunkFQV
 i48aGvDt8S5n/sg2SNxUjsseop9ed3xhC4y3ifJ/6kD4m1P/Rp2r5sm/ZDYTK7e5L4PO
 81nwrTKpHjA5/aAtK+blzs5I5a65kEGcozhkCiGNUUyHqt66iCLYqpK18OIXhyg1504+
 ugLA==
X-Gm-Message-State: AOJu0YwXoYwpYxNurgm4SMRMp1Ik+kh5MKsa42hYNxRagzCPWfDVs+mH
 4j42fQoxYwn8IGl4p9wGxJ1bWOqxXocZe5uY4WeserW5ibh2ncSF/bHYo3XpEhwxe+ArJLOycpf
 kiNXUrH+Z+8lI9akxI6z9vbwGLVotDakhAB0feraSmKyT32xpIOWQ4OGlyewJfaHuqiI3VVqQFq
 vc5ydwg8lmsC3/OTwVEGAdCrRPLC8aFEp8nwVpWpR740T2mFe2VAfpxaTHxnAOc4pkmg6u/Fafm
 kr/VOnOFrrG
X-Gm-Gg: AfdE7cmF1xPTKf2sftQ89AD4jWOe/ezwV3g1pZX6UZKU9i5XKRx9oVI8wf0XBoq9uS8
 grb2vIm8SH4Sgm5jeonE8AbVSwMFSODIXe0nJBDgDI9hOQ2wjKvNKBoaDWtyNGprcnRQGTmKV2F
 3LJWvk3QJPRboOVtt9lHETSbThE5lPw8C53jdGGE5tq61oVWljohoRsf8qKk2VD9w/oLagfA3pW
 AhdRkozfbyGymYaYNmc/adOpsnGe/WAWZQOVjQH/bQr+LWeY4LCNSKutxNZJikJFz0gFBOeXapw
 +QU3eM6DIK/anuGPqvEvYjsA5FfyOtb4nSV/ZaETLVHK/1p2v1rj+mbREw9Lr4vfDgWQKUUmtcP
 9btYmxlqU9GKpVV7pV4uOG4CG5fRR284pttBHLvyLBZB0P9sNQAsnNFlobXjXyVjZa2mlo2iA+J
 B/L2vhLqm1dlCqz36G2BT4WLOMg+3Yl6cYxTT9FSnWb+2FWeILmA==
X-Received: by 2002:ac8:59cb:0:b0:51c:12bf:d4a6 with SMTP id
 d75a77b69052e-5213e48ba27mr182641171cf.48.1784655729277; 
 Tue, 21 Jul 2026 10:42:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-521503b627fsm4734111cf.25.2026.07.21.10.42.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Jul 2026 10:42:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec91dc265so806589285a.2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784655728; x=1785260528; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=us+mVWZHCHenNqtjc95UXJKadsREqtQfhxk5K+oW8sc=;
 b=iFy1Ep98sgO+/xIVpHwpkYjnuMCLajLiXPIcAWd65VipAmu4K6yJhXyugJ6Zl4Pe+W
 QjY5rnoMbUL04mS48aw7LiVBVHtxrR02LqW7sWjSAhxjv29BKViSCKUjkNXIzyEeV3g3
 eYA4ZsTwfeqYPpvwUcGWHK5IG8nJyq7fUsWsA=
X-Received: by 2002:a05:620a:43a3:b0:92b:440e:5d53 with SMTP id
 af79cd13be357-930b3e4b798mr1895875485a.3.1784655727973; 
 Tue, 21 Jul 2026 10:42:07 -0700 (PDT)
X-Received: by 2002:a05:620a:43a3:b0:92b:440e:5d53 with SMTP id
 af79cd13be357-930b3e4b798mr1895871485a.3.1784655727294; 
 Tue, 21 Jul 2026 10:42:07 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52dd4c2sm1169980985a.6.2026.07.21.10.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:42:06 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Artin Davari <artin.davari@broadcom.com>
Subject: [PATCH] app/testpmd: fix segfault in flow rule parser
Date: Tue, 21 Jul 2026 11:44:15 -0600
Message-ID: <20260721174415.1317549-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Artin Davari <artin.davari@broadcom.com>

Replace temporary stack arrays in the flow rule parser with static
arrays in three parse functions - prefix spec, RSS type, and RSS
queue handling - to prevent invalid pointer access during parsing
of complex flow rules.

Fixes: c439a84f1a ("app/testpmd: fix build with MSVC on non-constant initializer")
Cc: stable@dpdk.org

Signed-off-by: Artin Davari <artin.davari@broadcom.com>
---
 app/test-pmd/cmdline_flow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index fbbe36233b..661a05f59f 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -8859,6 +8859,7 @@ parse_vc_spec(struct context *ctx, const struct token *token,
 	      const char *str, unsigned int len,
 	      void *buf, unsigned int size)
 {
+	static const enum index next_prefix[] = { COMMON_PREFIX, ZERO };
 	struct buffer *out = buf;
 	struct rte_flow_item *item;
 	uint32_t data_size;
@@ -8885,7 +8886,7 @@ parse_vc_spec(struct context *ctx, const struct token *token,
 		/* Modify next token to expect a prefix. */
 		if (ctx->next_num < 2)
 			return -1;
-		ctx->next[ctx->next_num - 2] = NEXT_ENTRY(COMMON_PREFIX);
+		ctx->next[ctx->next_num - 2] = next_prefix;
 		/* Fall through. */
 	case ITEM_PARAM_MASK:
 		index = 2;
@@ -9327,6 +9328,7 @@ parse_vc_action_rss_type(struct context *ctx, const struct token *token,
 			  const char *str, unsigned int len,
 			  void *buf, unsigned int size)
 {
+	static const enum index next_rss_type[] = { ACTION_RSS_TYPE, ZERO };
 	struct action_rss_data *action_rss_data;
 	unsigned int i;
 
@@ -9352,7 +9354,7 @@ parse_vc_action_rss_type(struct context *ctx, const struct token *token,
 	/* Repeat token. */
 	if (ctx->next_num == RTE_DIM(ctx->next))
 		return -1;
-	ctx->next[ctx->next_num++] = NEXT_ENTRY(ACTION_RSS_TYPE);
+	ctx->next[ctx->next_num++] = next_rss_type;
 	if (!ctx->object)
 		return len;
 	action_rss_data = ctx->object;
@@ -9370,6 +9372,7 @@ parse_vc_action_rss_queue(struct context *ctx, const struct token *token,
 			  const char *str, unsigned int len,
 			  void *buf, unsigned int size)
 {
+	static const enum index next_rss_queue[] = { ACTION_RSS_QUEUE, ZERO };
 	struct action_rss_data *action_rss_data;
 	const struct arg *arg;
 	int ret;
@@ -9402,7 +9405,7 @@ parse_vc_action_rss_queue(struct context *ctx, const struct token *token,
 	/* Repeat token. */
 	if (ctx->next_num == RTE_DIM(ctx->next))
 		return -1;
-	ctx->next[ctx->next_num++] = NEXT_ENTRY(ACTION_RSS_QUEUE);
+	ctx->next[ctx->next_num++] = next_rss_queue;
 end:
 	if (!ctx->object)
 		return len;
-- 
2.47.3

