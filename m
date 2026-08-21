Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE2C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5BD40BA6;
	Fri, 21 Aug 2026 21:29:22 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id D251940678
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:21 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1009656b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340561;
 x=1787945361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZZ26sHsFrrQrWLcA4MWbNCbw8+eJnOIrl07RqDwiK0=;
 b=SGA5qvjeAvuMOuiXUYQTnQD4hJzujbztTWUCIy8anzcNXzLkNoL+ls0bZCELtnhRf7
 uDqFbY26lgO8LATNJ8JvD6ynWXTP0IHhldSUOdXYRPlRoa2RglYjhH9C046fTvDfSou6
 AKBEYX0bhbRyUnpi761f+4UKCWAZvC1FbBLI8QmHGVRaBvcytJqyODaxwy9Fcf90fixO
 +zu5vjpgWfFt784/ImOYzuY7FgUtW67DD0Fq+WNFTlcugExOdv9uqkjT3HxisbYjNF8a
 CjnA/kEqmGM25XdyCtTLMtfHLAwSOBUX4qx6dqTQwCIYw+IhYu/uzNdVAplqpk/7BskP
 0uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340561; x=1787945361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fZZ26sHsFrrQrWLcA4MWbNCbw8+eJnOIrl07RqDwiK0=;
 b=Z0QFnijnxQJkXoR95Am0EkVbRChp+3YzRjeptEI76ZmhMCYH6fsPcYlypMl3m3IJtg
 AWqPJPxVgWWfOSPbgtM62vn6/18vcn8niAN1xFBkaQy9kGNv4gm0SzA83jtwXUmnBT/G
 QTdygAWjqj0GVadyrhvpmmXdLjKxIxuEcsjDjoAk++AgZs3fzI+XsYgCNdUGo4jpHCCG
 JFkI2EgzcN6MLaOxhBYHtCTkkIRk+rURASSTTr4f4Aa86m18JSs72V5ERHt9ZlaAcqcX
 Xaryjm7iOy3JTFHUnk4jQIVYgeyS8pk83fH2JrTbDNgBvCT4s2gwIgDeOLXJnbM8lrj5
 ssfA==
X-Gm-Message-State: AFuF++lcsny8kIOYx8BPnV3H44h+s2oMAHYDVcsTAUReC/SqFwBzVqqo
 E1BoygZNwrxj7rlnsn/XIk3ZRhwQKlYwBQeiVP2ddlqaYNGW0ZSJbqm+T6bRln7BiJI15sqqZXC
 BmF9e
X-Gm-Gg: AR+sD12Pivra/0hsFD2OfEoPmIzv19vZmQsg+jxnYp9QXe0mgtQuW2Fsk9ELirTbNTt
 6a09zPWWHBySJJqagIURxee7clUl5v7b2AaU6r8B0zlTQMHhK+S5ZjTWYVbZbGrIKbfGDUHs4RL
 aX2LEwK2fTpjX2N/TOTMOm/f+Ug+eMUD2JOW0ZrZq5MA5LuuR+h5XTp8YLG2dMxzNyMq6IGEcVW
 3wLHEx/RIGZJ9UTVsJlFK0tuep2yehrr2o9NaPKyx7K3HuTqqwD09OUbKe8o+lSgx/NDIpS+paI
 U7fuxycSFKfpOgPg4dk8e8pZtzsN/plWh4mmS8ElK9HL2AugruSWBhrzd3GYrpn0+YAtTednr8v
 EfODX9cqVLNpGLxyHg9tqP2zFBauEKtiCmMFWPeART9ejUItNJ0SFaYWfB6FVsPLUzFymi8Sf+q
 lijeoIlK8h/ZLNb2Myq/5EvQC5ZSAqGSo4e/jlZhsnBHYJby/zFMNTE3A7ySGK8guKW4fndmbJU
 Z24k190TtL8PZ+2MhTqoiGClBQ=
X-Received: by 2002:a05:6a00:4fca:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-851f9f115e5mr11921608b3a.15.1787340561053; 
 Fri, 21 Aug 2026 12:29:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 23/68] test-pipeline: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:18 -0700
Message-ID: <20260821192646.146382-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Using regular memcpy is safer and as fast here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/test_pipeline_common.c | 8 ++++----
 app/test-pipeline/config.c               | 1 -
 app/test-pipeline/init.c                 | 1 -
 app/test-pipeline/main.c                 | 1 -
 app/test-pipeline/runtime.c              | 1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index eaf895869f..dd3021fa79 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -153,22 +153,22 @@ pipeline_tx_first(struct test_pipeline *t, struct evt_options *opt)
 			mbuf->pkt_len = pkt_sz;
 
 			/* Copy Ethernet header */
-			rte_memcpy(rte_pktmbuf_mtod_offset(mbuf, char *, 0),
+			memcpy(rte_pktmbuf_mtod_offset(mbuf, char *, 0),
 				   &eth_hdr, sizeof(struct rte_ether_hdr));
 
 			/* Copy Ipv4 header */
-			rte_memcpy(rte_pktmbuf_mtod_offset(
+			memcpy(rte_pktmbuf_mtod_offset(
 					   mbuf, char *,
 					   sizeof(struct rte_ether_hdr)),
 				   &ip_hdr, sizeof(struct rte_ipv4_hdr));
 
 			/* Copy UDP header */
-			rte_memcpy(
+			memcpy(
 				rte_pktmbuf_mtod_offset(
 					mbuf, char *,
 					sizeof(struct rte_ipv4_hdr) +
 						sizeof(struct rte_ether_hdr)),
-				&udp_hdr, sizeof(struct rte_udp_hdr));
+			       &udp_hdr, sizeof(struct rte_udp_hdr));
 			pkt_udp_hdr = rte_pktmbuf_mtod_offset(
 				mbuf, struct rte_udp_hdr *,
 				sizeof(struct rte_ipv4_hdr) +
diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..f4d5d435ad 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..8028192306 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index e5efafdf28..5782c55032 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -19,7 +19,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..a6457488c0 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
-- 
2.53.0

