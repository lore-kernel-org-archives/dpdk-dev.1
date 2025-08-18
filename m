Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBF4CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F10B4042E;
	Mon, 18 Aug 2025 18:18:31 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 5B1CA40616
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:30 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso23572965e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533910;
 x=1756138710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qke+mMyw9DWP1L40fjj1GIf02tRRBhUk/yHh0vjIRDk=;
 b=MSNQwEG9tlA6uzNLCLjH0JFqqRpJJwfoGPm5hKMGjKpWO2jDqpJP1oV4zKRiVZqESy
 76LEObBHhI6VhuXy5XPPUpmEl/ZXD7ey3aNJHcyJvRsxBkygTKDpTxy6tHDgtDzdkP8e
 iM/FgDU3iIKoF4an5nbCw+59nJIHsr7i/zQfLukhKa4Cytb7sKsLR8zsvNFTj1MFTuF7
 sRUz9ThALeSLLBsPTQYSwAnwn3yLzWBlsD2T3qxtXpNG7hRitp82OCLlUfoH3wujYEiD
 +XulMvrJPWKmdN4fmYS9XElC01kFERUryGch0SaJm6fy4eup/z5F5oHW0VhomXjmnhau
 W1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533910; x=1756138710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qke+mMyw9DWP1L40fjj1GIf02tRRBhUk/yHh0vjIRDk=;
 b=rlcMJC5ZyXPFpjpnAT7VFOHec+oSn1Anf2+OcnQApKqU3XquMPPegolD3Af7RFj/4Z
 +oegOnxgMibTaDl9+7bWD9nWuMQYHQv/dnIoGgz8ibk7wnTyfNSTNkMCBrCccA9ISex9
 RzP1J+29pgtyuvvAeiqQeRE6GDFbtNYo/9L4sHFqDysNmNHYdXZUooapGJZIndE+JZ1f
 Z91cidABfoXTH+qEIzISUg4Hg5GcYeqR4OIq2/S1TJvYwoX7VoQ7P6bYcA6QIyw4/0s8
 d7GyqbqNw4ELE+4Yo62UY/SxCa8rM0yLBr9WS2RdahNFmSU8eirC94agIYJGiI/ItZ2E
 CoZw==
X-Gm-Message-State: AOJu0YwCux6farvUezDusi1pGy/1mHSXmwEcj1bJycZBpYMbuw7ibPCw
 zD2Jit873+RGXEH1JKRqmUaB7+2xlLkHTL8eupy6/u+4VqgyXJuUTG3ti8k5asTSH3SqRMGNa1X
 bW/M2
X-Gm-Gg: ASbGncvnwyIfK0jvZBffUYhCVVK4MtKNyX2/eQcmEUZwNXJh6CQtZXghAvAYzrh5Iyv
 OjZV7pMfTlC/JIxZfNbSWhfZCBJlWn8Xe4gLORcQE/5cgK/g6UjxnfrqG/Jcc3nZ8MZ2VVhu9Om
 PLXZXdA/2r+mRb1VrUroTK+YTzHU2yd/nxbLPf5glAEvwpAx2mVQBO2jUHFxb3LBGCiMU/G3Qbn
 uvyNgB2AmeWpugTcXYfR2FfCo0sR8QHQAt8M5TPXOmh4r4EGUtix08ryhs81854v5JsAbv6/Mn4
 Ew38NU6Zm2RoN1VqSZ5uV1jXyusJFAaRqob8t7lqkd+Bd9KdFSPtmgu29Xc0zxBXtRS5uzy6CPx
 j4qsPR3JtCR3Lyc1LbTSFEOYVac7Zx84N+MobBFDUa5JCJRFlz3TvaE2N4WwEHRNIuKmgeRNX
X-Google-Smtp-Source: AGHT+IFasisyNOzvilDVXccwVsHaFWFHtZwL4Qss76tFTIUr7C4zoi/CYyJfilRz8raemilGe0OE8g==
X-Received: by 2002:a05:6000:18ac:b0:3a8:30b8:cb93 with SMTP id
 ffacd0b85a97d-3bb68a17fd7mr9825640f8f.32.1755533909713; 
 Mon, 18 Aug 2025 09:18:29 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v4 3/9] graph: replace unnecessary comma operator
Date: Mon, 18 Aug 2025 09:18:08 -0700
Message-ID: <20250818161815.23611-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/graph/graph_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index eac73cbf71..588508b473 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -254,7 +254,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 	*stats_in = NULL;
 
 	/* Clear the new struct cluster_node area */
-	cluster = RTE_PTR_ADD(stats, stats->sz),
+	cluster = RTE_PTR_ADD(stats, stats->sz);
 	memset(cluster, 0, stats->cluster_node_size);
 	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
 	cluster->stat.id = graph_node->node->id;
-- 
2.47.2

