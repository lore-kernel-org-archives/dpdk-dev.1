Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39299CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C177406B6;
	Fri,  5 Jun 2026 22:53:11 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id E510240687
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:09 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ccef9eabccso32853446d6.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692789;
 x=1781297589; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjyx3Shjguh+eZPlRNFLvyFBdgVEGy1tENy/4e9WSVc=;
 b=VmbR3lYJAvChfeOG8ghfs7QnULVoxA4UwJZpikLYe9HrrrvycHPLqDBidQOHM28TjC
 XkoJSEYi/2oDrJcDrlURpMy3gN/uouL+r6m5QN2QFks07t1k/iKqhMoTekWihp+ywv4A
 QNUVpOlC2LkHUhCfxQpwMlyVfRX0cC2/8Fy7aa0jIcdMKxoR7D46pKD+JT/qyhe3LUnK
 YQACv2axGlSviGvewd+dYYvPngqsVC1vaL4Pqsrblrbe7bX/HzwRZLeSiN/TIEDac9Tr
 9yDbKYVB+Bui4QVv+p0jErvMnairttcoW/suBfE+aEo84IKQ+Z+EkQPfoKDO9WC5BHrb
 JdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692789; x=1781297589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjyx3Shjguh+eZPlRNFLvyFBdgVEGy1tENy/4e9WSVc=;
 b=BERv6pb0JPjffz/vsF706w24828b8QbF5Q/LrqHBsIdPSbSBQytjXBpTx7alixLViK
 JuXZcMZO3bw6MjPt9bOjl6LhGN186kOx44eRkbhRayIGfaOQyv5I6eohIsWW6bO29YHR
 sRCdIa4QoiNZl7atXYAz9eL/QHjlwPOpR7wGARhExboB8yl/uNIht5asAhh/g+h+v0Rj
 7ULN6RNGzVG0LSOdxxaAuHIjRH36F4xWAeHj1xgflz+YXX1Dr6v/5f04QwIz8cdgP9Ft
 hlGphqD1rqmaqHxCnwXm2uG8lUumBQh1L8maDqO6eYv5D0ztSQlcQWEbPEhR16MC8qMN
 sxXQ==
X-Gm-Message-State: AOJu0Yx2A4ijim1IdTEk0e3akaXflKKD+QKdt5yLIcleISPF+n8HtPjW
 FBybS1+LCme3ef4yYpZSRGqYKUkuJJSjmknNKWoeUksghddDGuBjl4/jnwB0LTz25GgmgAz+O/i
 Ap1PT
X-Gm-Gg: Acq92OEqRDGqnP1bqN18a1NVWd2UtubiNLG0rFKKqDEnVajwTlGU/wEn5v/JUGIbm+3
 rGxrxCXahe0DPZ0eAPXjtjqJyed9WOgQMYfeYNCyd9VCmVHxSi69VDyNvonnCUmDNtWleQ8spfg
 x+c3Dy2rh7iKz3Nyc1nd27PgVAwdSn5slJFu5xWHXE97YKp/QeL0pB8dlcWyonjJl+C2T0V6zwZ
 fJfYuhvQgr2mM0NAT0Bb9DkyGYCMQHoGyjiSAREOes5Hj593JPciHYvL/1+iU2Iv/eMH0QzYM8N
 Qc93diXEf1xfQXIT2OvktrCYkGSJUiqJrwk7vrCcZu0LDiNhepnwEhbjZDEiNeLuiR9tYPGWz8T
 7/B6HUSN7s9t1itgAJWA5G3zX30p21TMSepggaYYiIvKQuQNwcRe83vLwxNb0KdPTKWC9LiFkw7
 8JT1Wo/4ilIyNKxVfkUl3k2fDWLDYQp0YbMVj5d+YaCH+HOnCG6Ddw6QdWrVy0q/paUwPeKZHy
X-Received: by 2002:ad4:5be2:0:b0:896:fb99:f692 with SMTP id
 6a1803df08f44-8cee89b0b96mr50013126d6.0.1780692789251; 
 Fri, 05 Jun 2026 13:53:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH 8/8] eventdev/timer: reject out-of-range ID
Date: Fri,  5 Jun 2026 13:51:05 -0700
Message-ID: <20260605205253.520196-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

The eventdev timer adapter code was using atoi() to parse numeric
parameters which does not handle out-of-range or extra garbage
on input. Tighten the code to only accept valid numbers.

Fixes: 791dfec24d00 ("eventdev/timer: add telemetry")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_timer_adapter.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index af98b1d9f6..e3640a3bf8 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -1402,16 +1402,15 @@ handle_ta_info(const char *cmd __rte_unused, const char *params,
 {
 	struct rte_event_timer_adapter_info adapter_info;
 	struct rte_event_timer_adapter *adapter;
-	uint16_t adapter_id;
+	unsigned long adapter_id;
 	int ret;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
-	adapter_id = atoi(params);
-
+	adapter_id = strtoul(params, NULL, 10);
 	if (adapters == NULL || adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
-		EVTIM_LOG_ERR("Invalid timer adapter id %u", adapter_id);
+		EVTIM_LOG_ERR("Invalid timer adapter id %lu", adapter_id);
 		return -EINVAL;
 	}
 
@@ -1419,7 +1418,7 @@ handle_ta_info(const char *cmd __rte_unused, const char *params,
 
 	ret = rte_event_timer_adapter_get_info(adapter, &adapter_info);
 	if (ret < 0) {
-		EVTIM_LOG_ERR("Failed to get info for timer adapter id %u", adapter_id);
+		EVTIM_LOG_ERR("Failed to get info for timer adapter id %lu", adapter_id);
 		return ret;
 	}
 
@@ -1448,16 +1447,15 @@ handle_ta_stats(const char *cmd __rte_unused, const char *params,
 {
 	struct rte_event_timer_adapter_stats stats;
 	struct rte_event_timer_adapter *adapter;
-	uint16_t adapter_id;
+	unsigned long adapter_id;
 	int ret;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
-	adapter_id = atoi(params);
-
+	adapter_id = strtoul(params, NULL, 10);
 	if (adapters == NULL || adapter_id >= RTE_EVENT_TIMER_ADAPTER_NUM_MAX) {
-		EVTIM_LOG_ERR("Invalid timer adapter id %u", adapter_id);
+		EVTIM_LOG_ERR("Invalid timer adapter id %lu", adapter_id);
 		return -EINVAL;
 	}
 
@@ -1465,7 +1463,7 @@ handle_ta_stats(const char *cmd __rte_unused, const char *params,
 
 	ret = rte_event_timer_adapter_stats_get(adapter, &stats);
 	if (ret < 0) {
-		EVTIM_LOG_ERR("Failed to get stats for timer adapter id %u", adapter_id);
+		EVTIM_LOG_ERR("Failed to get stats for timer adapter id %lu", adapter_id);
 		return ret;
 	}
 
-- 
2.53.0

