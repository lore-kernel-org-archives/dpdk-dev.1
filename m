Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810DAC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E85740E50;
	Wed,  2 Sep 2026 17:57:36 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 31B5540E49
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:35 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d944747d41so14550055ad.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364654;
 x=1788969454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lGTAiDeEfmNhnlnKd+66tMp7iItnqK6iKnW5nLSz6o8=;
 b=kqbZsOHKX2VKRUpLEoo56VNAn70JhGrWuWSMhem9BQvgFv1np42lIUDwsqumEg9Ogb
 50YcFX1MiIoNvS2+gPfO8DIuaxOVbSXzmym8D8EPXca0nui/l2y2tB6MKbb7dZlnOupJ
 XqxOkpQIv+KyZwvJ6LlgRgX4ra1ydOPR3E0+w39lTLOzKwK2q0YKJ00fE3lwuVa31zOF
 vguo4LOK9DXCbjDQ2VfQ+fbS8Ly5CPfCniVVIkF59iEhagvonBQGjq9qsbU9UXwwYvyV
 GsI5yb8ebuGAMQ06KyEwkzLXnHAGJWXkWyHUHjFFFaQ4doHmHTidY6eAvd6D2w3rtrO2
 oH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364654; x=1788969454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lGTAiDeEfmNhnlnKd+66tMp7iItnqK6iKnW5nLSz6o8=;
 b=H32vpDggzFUEGzNN+b1kTQwKodJMfJm0THh/LiszFpHhZxsaZKo5TKEfhF6MqKDsbw
 lRTu7BRjYUNFHT4wRhr6vSOy2xWRmrgM2YOrgItMbWc1ryuYwPX8WWURXkxGWKGyUb9X
 ibjUgKHm8R1oJ1muR9CBohe0CNxIlmoDfaMRcg/qQil2ur03U0HPrRzvlB6boSq7mEgN
 qzfqjSbUlM8yTVqEzVXeUgWW/OeX4DFQp4ktsSqAKpTOXztn3624H+sBv5alay/tN/jn
 I8rqdBmHgizmgzSXK0SdYIYyBQauMOE3eygMeaOMTiAH9Tt0ywnBXU87eigv1AKOMh2T
 f4Ig==
X-Gm-Message-State: AFuF++k0CPFA8AsB0jSopddpFrWSU6U56gJMP+GDxTgDZBMnEED8C/KS
 hzapbZu9yAAecZLUnramZdueEODpUPXLfwbllGottEc89lq/hGnRr0xLNJCU267x5+QC3w6IWgs
 Ys6vU
X-Gm-Gg: AYBFou2G+JV8lUC6rO/9FBN1NTWDnE6PadlsaFFGZFP/l4qeGNbgfla0gwH+j5hd+5v
 fzqabhpe9esLPQIuPW9GyLV6QTM4R3JwfXzyRP0YqPDxGJ+nJB65fT1ddtBjZ8kIu025EGgLu4E
 U713EYOmY1b9pyzEKU/dA+ksyV8RWlzjUQXYNyAdoSPVu0k3K57Ug421UflUtDJsvdmWxd1NDhh
 pNFX0e7HkfHSY+LQHTB6/bFyWph0hBRmGmn6YLhTHwHmkdkxOS3DBy7B5grxsI2q2t7ylrRFtuE
 /Z5Poi4CTOgCWIpWp/VeZCySGEq3izswQiGQuzws6wPqlIt4LzIBDV6J1wBJk2LseKnuSktc33y
 K4yg5PJ98cISxcsxlp9QEUXx574z76s8mSQ5qpPY+KOnGS5NpAsDWndSECNmTd4f0z/wbna1yoy
 VR7fao8zWVUvDx+sXrgabFxO020Jo1ppkg1jauzJf/K3yas7/okC1697xZXKgZbz1KXvEAV20cM
 m5t5RYO5pGosDBhkd7rfQwgoTA=
X-Received: by 2002:a17:903:19ec:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2daec5ad6e3mr85891705ad.3.1788364653993; 
 Wed, 02 Sep 2026 08:57:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 1/6] eventdev/eth_rx: promote adapter API to stable
Date: Wed,  2 Sep 2026 08:53:54 -0700
Message-ID: <20260902155722.577747-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902155722.577747-1-stephen@networkplumber.org>
References: <20260902155722.577747-1-stephen@networkplumber.org>
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

The Rx adapter runtime parameter functions were added in v23.03 and
rte_event_eth_rx_adapter_create_ext_with_params() in v23.11.  None of
them have changed since, so remove the experimental tag.

The rte_event_eth_rx_adapter_queues_add() function is left experimental
because it was only added in v25.03.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst  | 7 +++++++
 lib/eventdev/rte_event_eth_rx_adapter.c | 8 ++++----
 lib/eventdev/rte_event_eth_rx_adapter.h | 4 ----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..fb7d9d6448 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,13 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* eventdev: Promoted the following API from experimental to stable:
+
+  * Rx adapter: ``rte_event_eth_rx_adapter_create_ext_with_params``,
+    ``rte_event_eth_rx_adapter_runtime_params_init``,
+    ``rte_event_eth_rx_adapter_runtime_params_set`` and
+    ``rte_event_eth_rx_adapter_runtime_params_get``
+
 
 ABI Changes
 -----------
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 635bd6014b..26c0a26db1 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2566,7 +2566,7 @@ rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_create_ext_with_params, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_ext_with_params)
 int
 rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 			rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -3683,7 +3683,7 @@ rxa_caps_check(struct event_eth_rx_adapter *rxa)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_runtime_params_init)
 int
 rte_event_eth_rx_adapter_runtime_params_init(
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3697,7 +3697,7 @@ rte_event_eth_rx_adapter_runtime_params_init(
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_runtime_params_set)
 int
 rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3726,7 +3726,7 @@ rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_runtime_params_get)
 int
 rte_event_eth_rx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h b/lib/eventdev/rte_event_eth_rx_adapter.h
index 41e436ec3d..f1f0d093c2 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.h
+++ b/lib/eventdev/rte_event_eth_rx_adapter.h
@@ -496,7 +496,6 @@ int rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
  *   - 0: Success
  *   - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 			rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -844,7 +843,6 @@ rte_event_eth_rx_adapter_instance_get(uint16_t eth_dev_id,
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_rx_adapter_runtime_params_init(
 		struct rte_event_eth_rx_adapter_runtime_params *params);
@@ -867,7 +865,6 @@ rte_event_eth_rx_adapter_runtime_params_init(
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params);
@@ -886,7 +883,6 @@ rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_rx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params);
-- 
2.53.0

