Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A1BC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91D4340E32;
	Thu, 13 Mar 2025 00:27:55 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6EB7B40E0C
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:52 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2239c066347so7088495ad.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822071;
 x=1742426871; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nc/L4zHQKe16cXReqf1EpiOYPYnY4cqsrG7ZMOCc7vI=;
 b=iAM+m8XmPs+uIG4u6cDPkpzc5aGS4kxdMFPFtli92jOAveby9joUzwf0nmXfdxQON/
 rtn446nwNewTqT6nWnr+gz9NujBZqyixJxHAKdDiFFajlnd6FXd7BdL/Op12C6buJBOL
 YT/vPaSraHKgGH+p1RKInLp0h6DnlT/dJD/EOs9JIGneJEpMSoHkyDjXcUd8a5J/H2K0
 Q1CyDn3YvEaOwMCRz5Bu5nY/dO4y51h/UHPoUVNkF7Vl6rSI3VIpLl3aDViWJ2Uta1Kp
 p0sA85D9QNtMOLl3dcxn3mwjZr34qk6qEf2p+Rb5lLpSvpVXPFEb2Jkh5cPu4g9PwCYm
 QQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822071; x=1742426871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nc/L4zHQKe16cXReqf1EpiOYPYnY4cqsrG7ZMOCc7vI=;
 b=BO2gEyq14jKClxgSKRIin+i1GXgbTZ5qJVecdWIzjoVpugNRDnlSpkcSBiugKe3x4F
 ZXjdPOi0Uvh9rO+9Spq0aQV44WPh9OR63s5krXGqhnCadqpg9XF3IvdtCDoZwl+6Hv5m
 cqWJ8o6heAUu+r+zjSlyYliyYSlH3a38VEfVMltwMgmH3uIV04qD6QNtCeZD2FIchwok
 gbPeD+79n42QtbjqxBeNxKSJpR4MY4AePAXcOUcsHFmKZoQw4OWgfCI1pc9R+nuaYKfY
 kdthlOlTTlTXsANuQijdctf1vFVpGDHQJNJz8+s3FeMc8ABYS7ddeOtBadMfAGAQp1fg
 rDtQ==
X-Gm-Message-State: AOJu0YzetJRHoQQBKLPsFSUaJS0zdVx9KUv+tY43Fcu4eGi/iFuFNNgz
 nie6Cd/1Aj/YDatHdkVg2HPfpUSIsh7cEmQlhMR2zxfIdP7zvvmmoMwXpgEuv89RML1t0oQ26fG
 D
X-Gm-Gg: ASbGncvYlngaUnkXfKbwTUF7I+VSa9IfrGF3Lw0qlCZ90MBbkOyN9mmjDRceNn9fnFU
 0UYyfM5QuotO8J8EZBI/4536+ltkcW9kfivrZkehqL+8tM3SeXcqPQp6hTdOc0/yuWPENpPG2qZ
 p/muvYcHK7ULcWBNB+ZKd64USexZiAzzy8+qN/8bXSYYTm/Ih4A1sYH19xo0XmqCmr6+0oB9Xpf
 k02hbDAo/tmTgLq6bTG3mWAqWAPD7Rbw9OjRgUjpnpa4WLkrjWZSv+y1G1cKq4mqVvHXTp+m6fE
 Nx0Wz40HCJRApWpbM3ZBD0jPxDKf3WvbQc+9OGf70C0LJ1oJnwqVaP71sbboaHp64KBsNupQ6Pl
 0LzQy3/zu/KbYqFPoJHvV+Q==
X-Google-Smtp-Source: AGHT+IFDsN3ySYuzGMnbRwNiK6QXVqB2acge1gS/t809obay3vh5HX4ZBDLrhgVC6G7RqKZVggmvAg==
X-Received: by 2002:a05:6a21:3998:b0:1f5:9aac:64dc with SMTP id
 adf61e73a8af0-1f59aac6502mr8503379637.20.1741822071659; 
 Wed, 12 Mar 2025 16:27:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [RFC 3/7] graph: replace unnecessary comma operator
Date: Wed, 12 Mar 2025 16:27:00 -0700
Message-ID: <20250312232739.228295-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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
index 0bbbd9fb7c..147d3b9615 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -253,7 +253,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 	*stats_in = NULL;
 
 	/* Clear the new struct cluster_node area */
-	cluster = RTE_PTR_ADD(stats, stats->sz),
+	cluster = RTE_PTR_ADD(stats, stats->sz);
 	memset(cluster, 0, stats->cluster_node_size);
 	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
 	cluster->stat.id = graph_node->node->id;
-- 
2.47.2

