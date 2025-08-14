Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D70CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90690402AC;
	Thu, 14 Aug 2025 23:29:19 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 92BD2402B7
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:18 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b0cd668so7030925e9.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206958;
 x=1755811758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olFhDnf3maroWa5hR7EmmoE2AwTMUcjVr09HHMN+6p0=;
 b=m6yw7Mu5fsza52Yy/EFyLmPkKz/nCzWsODFSelPCXOMu37Zt/F0bKqy2XcPnLSKUGt
 2s02mr8uycKqwhzD96W/1kea3EzkRFXkuSaYLzFG0jodjgeMe/oypBXd9lRl/NHow/3U
 tTl0OjbhCq9qjKEYJ2bQZEjDgIDxmwkJlYu3LSSUCAw3wrSgOcvtATm9OwWVtHsMIB1t
 4KfwA80sZJcMWQwgVuA/NL2WjxFdPH038U/yVIZKGzcHiXdIE2vdR4GxgxxKSvxBuzzk
 QJh2QcYFGBXXjdShsyVvcj3ZM1m0WbhA2Oyttamne6knVYLA9jQnQlOIuLZR01fwRuLD
 Zy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206958; x=1755811758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olFhDnf3maroWa5hR7EmmoE2AwTMUcjVr09HHMN+6p0=;
 b=De3M/6OQa19o8gFs50Q5EtF8tCKCIexyBgbP9M6uryJwRWd0VpRUtOOBF5V/B8ELcS
 SNOcEsvb5AANKOmDHZ5LudKRBNI9+9hmEbhyd+makYpdzYQ6Tb4pqMPaRuN8cUoB5jaD
 gz2BNhACwj6uhu0H260L668hkfCVGLIa1NwaD+gu1XNJnaQ7RoZbTCbXdB5+WGh+2o7n
 TMu6eBYOu0BkX2CahJpQjZyRPc22OwJvkGg9UzGLk1MJJzHwmYbnxSi1qeuB2DGBSsmM
 BGukn5ZVtYPU1N21593yPHlVn9CIOxoLXwvzu1Uc54qtqFgevVt1ze4XmwkEjBgL5zkd
 IITA==
X-Gm-Message-State: AOJu0YwBDM1SBUVRS7R0RyP1nkU5GtfubqamUZ1JvlqlLzs5Q1WIVW91
 TH8j9eVYIvoC6aYB4z4Iut7r+k6KJUccYl51YgOW20D00a6jejrwQZ98obSJalIPdFXhVM/JihB
 0XLDM
X-Gm-Gg: ASbGncvZUirs27yc4FKnhhnGQDGPcHRSfSojFQyVjHqcQLZuYo1DHQtdZ3FAeMuh/UT
 GYa5sZUZKEbme5OmuWx+qDVls8uzjm9DUDrwTZQf1rOpDmPmQHLfioVKR774bpCPvpgshL5BeU2
 aCR67DyfEJDOi0UjA6CugB9T/0o+dVwwMPb9MpskAfDGfVKK8gKIHZsffbFVuBqyePW8C55nsLf
 KAfb0kwZexLvuauLb3/j+yJsHGquIfZiDzL40Io3wAmb/mmT2aPiHO4JioAaSfZUTdT8qyjfjIn
 7i0R58UwgRHdmtwea85xqRlJLLSaxpnfjhjXll2N8Pjv7hm874YsIF3d1DgcEwQR5JnZFcW8GrM
 hCNYHAtxiFtuZcWSUjOOQ+MRSIUzfmPL1GlhLJsN96+R0/1nmwYNNVP8hD9rVoReRubWNphIH4c
 l8jGILcH4=
X-Google-Smtp-Source: AGHT+IFONu+c4QNj5q+JWhYaNNFmLFvJRSKXhFC2Lp6OuXftxooz5kcPI3457XnkVhlRdnj+OitxXw==
X-Received: by 2002:a05:600c:4f8c:b0:456:3b21:ad1e with SMTP id
 5b1f17b1804b1-45a21528b32mr447065e9.17.1755206958149; 
 Thu, 14 Aug 2025 14:29:18 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v2 3/6] graph: replace unnecessary comma operator
Date: Thu, 14 Aug 2025 14:28:49 -0700
Message-ID: <20250814212901.88863-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
MIME-Version: 1.0
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

