Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04698C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FAF940E15;
	Tue,  1 Sep 2026 22:33:05 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2D76F40B99
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:04 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so336128b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294783;
 x=1788899583; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpntgpqM3MqqhUSJykkitNxMmWfXqx84zYc34QoOXnE=;
 b=e+rbLhMKGVZpzAO5QmF7MN5lmeKsRODGo/zinuZoHo/GHQV3ATYr2MLMM6vc4ki2pM
 Qh1Z9Uplih3qqFtT7+WN3zv7mQlnQBJ+BsLDz1sLz3yC39DU33h2c+X52H/KT2bClFHH
 LrvkT66XPHMKrQJfpdZV4bl7PmhSBB8KYKnddejdnT5boYkkmqyHe7RMcJY9dafURgNW
 kNbJWMiOz3LZsZLPb01jBVkNnsA81fe8lTnU67VEiNuGjyxfXOrpNddQzkedsYgOil8G
 ltiTgeCgv9hNdsnOVDFXREnQ7YuaZoDiy1fqSMz/6PbYSZIb/xVnRRsV2gpc7CjpXI0D
 VsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294783; x=1788899583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VpntgpqM3MqqhUSJykkitNxMmWfXqx84zYc34QoOXnE=;
 b=LlNRNt819Ks36YSdlAtVILFQ2/EW/SuPcrjZn5Pm4j8GNIn4Sku7r5xws/RfwJYUhF
 E8KjsTihAL8J7KOtY7gN45cLhekhpgxigcT/d979In+w4vxzYB8HnItInWkb2RRFCh2t
 t0lHLrYGgWboZB+V2I1xgdXVjasV469m5ak6yVnXy84mdaCGNljMzQXgmSDJJJaHqD5S
 eiYoD1WGL6ss+JHqPExeXrICHqFG361KQGRtAxpqcVI3kpkQG5e8pTEHfcX1DPfWP1fY
 ohKEbtdfq6LmPdDzBbGz+ltIsp5SY0B40oDG8jQ//Sbqt8+FgbG/ql53Ik3dyGGKpVGm
 nmQw==
X-Gm-Message-State: AFuF++mgnMo8ON/MikbdWGgypi0IRZj4lTXXhdRPtSxO7UcrruthExli
 RpPrZsZ1xxr1yc9d8fdsk0M+VG1Hv4/2t2yB9wlT9Zp1serWXNcPhlgy5mPoBsT+RIH1Q1QaX5O
 CKDIj
X-Gm-Gg: AR+sD10O0XfsLlZpTTfX6qzjAuV7oxG8Vea96zBmk2ETcBMcyjfXSFNrwipdv68JFz4
 ALyeL1QIK6/mLcjS5BlD+zf49lzegdGaotPcrHsfn4BNPwlCSj64R23RQudvfEBl35xdfLGV2bF
 +0nk9E6cswEzBtnRjM0Wxk5rR+vKC1Ed/B/imDzDLD1YsIfFDHxQyaLxJJArdYSMk9djtG9m+nP
 rBFH3V3+Q5QmMtEpIf942QPMh1sOzczEXpni6LP06OsECG8+MlRO8WrYN0Y9PmPmjuDvYxF/P/9
 +U7mZQIX7IBm8dwZc61G6bgcVrzCt81Tk1GoB7P/Q6d+Uiy9/+8eWXzU+zsPnWlRzzAN5LtkszZ
 vxYhG8N7cGbAT6PwL9EQw6JAJIaYQpi9jaiUry8ycq2M9lPqzPPCKNj6Fps/JVL65+LDWQ44A/D
 VQW/tbhcZ3RPnXKaurvvPo8W0SOTLi5x0PqSDFc5W5MMuevzUvxWvsafZtKasJdQsXOJim4P/XC
 fjBVznb0efHCAaJE4OaZ8ierFI=
X-Received: by 2002:a05:6a00:ab8a:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-85ed20ee9f1mr758168b3a.7.1788294783316; 
 Tue, 01 Sep 2026 13:33:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 09/22] ethdev: promote aged flow query to stable
Date: Tue,  1 Sep 2026 13:23:08 -0700
Message-ID: <20260901203217.1485915-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

rte_flow_get_aged_flows() was added in v20.05 to retrieve the flows
that hit their age action timeout, and rte_flow_get_q_aged_flows()
in v22.11 for the same purpose on a template table queue.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/ethdev/rte_flow.c                  | 4 ++--
 lib/ethdev/rte_flow.h                  | 5 -----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fe76ffa7ad..6956417ad9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -114,6 +114,7 @@ API Changes
     ``rte_flow_tunnel_item_release``,
     ``rte_flow_tunnel_action_decap_release`` and
     ``rte_flow_get_restore_info``
+  * flow age: ``rte_flow_get_aged_flows`` and ``rte_flow_get_q_aged_flows``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 6223096278..e90f93ebcd 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1268,7 +1268,7 @@ rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 				  NULL, rte_strerror(ENOSYS));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_aged_flows, 20.05)
+RTE_EXPORT_SYMBOL(rte_flow_get_aged_flows)
 int
 rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 		    uint32_t nb_contexts, struct rte_flow_error *error)
@@ -1294,7 +1294,7 @@ rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_q_aged_flows, 22.11)
+RTE_EXPORT_SYMBOL(rte_flow_get_q_aged_flows)
 int
 rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 			  uint32_t nb_contexts, struct rte_flow_error *error)
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 2fe9d6ca12..c8194199d6 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4980,15 +4980,11 @@ rte_flow_conv(enum rte_flow_conv_op op,
  * @see rte_flow_action_age
  * @see RTE_ETH_EVENT_FLOW_AGED
  */
-__rte_experimental
 int
 rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 			uint32_t nb_contexts, struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get aged-out flows of a given port on the given flow queue.
  *
  * If application configure port attribute with RTE_FLOW_PORT_FLAG_STRICT_QUEUE,
@@ -5024,7 +5020,6 @@ rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
  * @see RTE_ETH_EVENT_FLOW_AGED
  * @see rte_flow_port_flag
  */
-__rte_experimental
 int
 rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 			  uint32_t nb_contexts, struct rte_flow_error *error);
-- 
2.53.0

