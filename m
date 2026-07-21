Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1DEC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 19:07:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 082C74042F;
	Tue, 21 Jul 2026 21:07:23 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id E866240294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 21:07:21 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so5350092a91.1
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784660841; x=1785265641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bw4PcKviKaNdOkloyDNJxr5ubIQXOPa6NtI3XsXtgzk=;
 b=BIljX+jzHQ1CckjfCbMIXu5CWnvMbP9RzYW2humPxX+RgADk8J8erERrAE9rMHmigH
 zPporTN7RiNZO/q2wdBwnEclJXC1Gt9vaBITI/ZM4toTW2VvZUE/hxD1scMDrhyz2K3x
 Bl6pvYdv0BWLPXj3xdHWLqEqID8I6vjAuFyFhRo+rYJa3B4SNct/OQRtG01p2Mm9g/59
 zlKPnf5GHijgTB3cIRi9ArcSBp+fD04oXJkBcB048BquEFCvM5lKY9Ff/qJtKwsux1of
 rXEH5n9Lhv24qhMVHT7569d+SttSKs93NcRVneDDpypvKWLnBMFRZZPoO4N2M8D5Cykx
 JB5g==
X-Gm-Message-State: AOJu0YxLWjdf3aYPGiGqoYh5erSYbtJ/2HRSVwIPVjeRkv3oc8cbO2KJ
 Om7HsIOJe1e/1/z/4m/J6n+FbME6zooN9DzDvOfcl3jGJ1qf2t7QGtKzia0yJeB81aDfNSM5ZSF
 DWD0YbJzhyCJiAQpzTq8ztX0HbO/azn3flfF4b5ez2V6LraxPGbbLOJXr/dLCyZpb1a2LlfqII0
 ZjjemMt8IsSWTxOuvnmxzz5m5xoO+tP385pkYyhXEpaNOlwqaB9TzHgRiq7NuItS1b2tsLMTMCA
 RWHAU8vZPSr
X-Gm-Gg: AR+sD11I8TlF9JHYlrLVol+M/3W9zoMAT7QmS0NtOtAYP+pEqNNal0KMrTZjiaR1D6i
 nm7QgjvLvOyRUeExgpacEJoCQf7KD0fF673lSZwMBmQuCZtWfbb3SPzcPbgoxYrV1TxSocCrYnn
 qqlOp/LxA0ixjQmyDsRWpGfW+My2mBf4KmeO4btWG/KSJytZBvhiaoXXeRqZR+XzaXEvWnCCuwf
 WRj26eY2eaprqG6QEUSmQBwXLrVxAKjbchg4NDECutWCn9lfEqEo78F0RyHmipt/dpA3X18X2iv
 AOwbwV9nb4ZftirQnvGxfuOrSomYt8NNPQG66r9wV/mVhfEEo/ooTojBiMf4CIUUIYKa+rOT1g6
 0t8lrTRN3Uxv/Rz4zyR7DxSt7oQc1qxfTmzpnSBqUHy0t4onB1iKQ1cQirOxxZZ9qIKdcLjY3gf
 opt83mN3y87ytp/BSSQ+jJ5oNdG9SrIpoEpT/nBd7TUyTdmiV2pA==
X-Received: by 2002:a17:90b:2151:b0:38e:59c2:cbc5 with SMTP id
 98e67ed59e1d1-38e59c2dc76mr11392629a91.18.1784660840603; 
 Tue, 21 Jul 2026 12:07:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-38e92151a4bsm331692a91.5.2026.07.21.12.07.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:07:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso1840179685a.1
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784660839; x=1785265639; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bw4PcKviKaNdOkloyDNJxr5ubIQXOPa6NtI3XsXtgzk=;
 b=QRCMn8dMT5fngZtR17RhBV3ePzIgghrVaztRsEQE8POza9WYrR6t8CkGEwEdGIUieA
 kVcbL5An4W1O2lP5ODBjLl0EUA6daadwbLW1at0BkCeiwCeLYm/MQnF0WONvYHi6hKWC
 ACjHGovoE1E9WIa5fpKqcgvdE7J2LorZTWIFc=
X-Received: by 2002:a05:620a:bd6:b0:92e:7383:4a93 with SMTP id
 af79cd13be357-930b3ec9d31mr2172598585a.35.1784660839388; 
 Tue, 21 Jul 2026 12:07:19 -0700 (PDT)
X-Received: by 2002:a05:620a:bd6:b0:92e:7383:4a93 with SMTP id
 af79cd13be357-930b3ec9d31mr2172592085a.35.1784660838793; 
 Tue, 21 Jul 2026 12:07:18 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b542bcefsm1226059085a.28.2026.07.21.12.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 12:07:18 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Artin Davari <artin.davari@broadcom.com>
Subject: [PATCH v2] app/testpmd: fix segfault in flow rule parser
Date: Tue, 21 Jul 2026 13:09:31 -0600
Message-ID: <20260721190931.1321010-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721174415.1317549-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260721174415.1317549-1-Mohammad-Shuab.Siddique@broadcom.com>
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

NEXT_ENTRY() expands to a compound literal, which has automatic
storage duration when used inside a function body. The parser stores
the resulting pointer in ctx->next[], which is dereferenced after the
function returns, so the stack storage backing it is no longer valid
by the time it is accessed. Declaring the arrays 'static const' gives
them a lifetime that outlives the call, fixing the dangling pointer.

Fixes: c439a84f1a78 ("app/testpmd: fix build with MSVC on non-constant initializer")
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

