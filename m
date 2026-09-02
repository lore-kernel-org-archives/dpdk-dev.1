Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6FC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6140740DD2;
	Wed,  2 Sep 2026 17:57:43 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 20CEA40ED2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:42 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d91ff7d9acso12616785ad.3
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364661;
 x=1788969461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zgaFzOqDVx3/+SQU2ElJp/QU5geUPSLPb1Fvjv69f/A=;
 b=dIapdxoLK6kNGukiiv69rUSQzNvXFegbcE7yhLt9t3cJM6EVi6ngLkxKWXNDN+Zum1
 ujztvVfjh1GNw4zCfRT4ET6BmZ/GlTvea9rQV0Fp8dHY2VMKTMNV+bpE2SGM6txJCLUM
 PMJMbjpC708AsQMWR83twNRGhoBR84SIdZbxiKGscYz0euN9deefTK/aJp63OgrVNu4f
 nlLK2sAZTLEMnGi6hy2cS14SKlOA4Wlbzw7QUVv+YoFDcRv02hZ9eSQMECMZ7nXOysvO
 F4mYNtghVc+jyGNxWgmcOcXr4LvvwxdJcDqim05V5fcPV9NIl7jgZYP+6xsV0Iw/UGdj
 vOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364661; x=1788969461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zgaFzOqDVx3/+SQU2ElJp/QU5geUPSLPb1Fvjv69f/A=;
 b=NGIvIfELTV0CJO1GlN0huLHqffhYCGQfRSbJL1IgpBMgLWQSatjjbf1ielCzq+CUTu
 1kV+ypoUjLGKko8HADGMP0ntuR2jEKTLnM/6J07/ezYv26WR6CLGP1Zam8pICneGwHM1
 zrTm/5KPkD58NKchiVYrakrqKK3mTd8ZfdHypUnO2c132q03ootHlYslxlthACb/7t6J
 sUJSbIn3XJDQm8Y2Q0h+pZYsiiHSTUXoQ4Gfg1xwFWWQxZCuJ7eU5KU1DVaxT53TAZrL
 oNwtfqFSwLWR5FIXF9b5ZNDlgDt0Tg7wBmmrdcj13nXT2Z8ENG3VNTA0+y+wDZW+jvKv
 B0aA==
X-Gm-Message-State: AFuF++mMmpmqFnjjSPrXrx4m/rkkhPhJ8Pyh3jM3OXJGPgYQOPVKTjto
 WMTjLQg7MfuEPWpu85wEh0DOtCPMUGXwWoIfYDUZ5L/gIzkSmw0dZZ+rQl6Bto8EYevhvdCbw+r
 L9JyB
X-Gm-Gg: AR+sD11P2/Vhr3NT5W0eXA22XeZZ1ggHG/aBicwmDfEb+bEgAnguGczOtpN7i0vLc2j
 uW9sdx5TfmcwS6v3H2lw6NTfbdzTjtLV5KPofU+7MEoFj1uss8+Xa/wtjQBrhhzBfBcb7dO+V2j
 PeXhgCgDv3wqdhrNQHqkiFe1K4APvlvm9R3WB/FmVEbqhOFCLHHSYXh+WS4D/r1H0u8gsBm/Lt4
 CBEPckW+idwlOk5nDhrdX/dfzJqZ+9NbMJ8EPSckMfDw3eXs0O2NGjMGvHlv0xzdBJfNlBOhXJI
 Lbz790ut3aqUHYY4GRKt4QaCGe+0EJMWcvWdtZ0DIwLBesP6sSCvQL7yeON7RMHkV49VL14AtUQ
 xujLDzGOdQl7kJ8zEklQ0kCWngDfYote8XoegsRT8bJORI+yf4UYbZREzaYtkOCiiB3HPRBMUgP
 yAJ2oNNEtfkYEC2stK3vGu6V1HgrlZ3sCWgg4jP7CixzudirrotX7srwrxAcQMsciqrumXf17Es
 0KJJZ3ZY8Sd1VuNchyovX+EZio=
X-Received: by 2002:a17:903:3d0f:b0:2d8:d4d3:3fbc with SMTP id
 d9443c01a7336-2daec729406mr83877495ad.16.1788364661078; 
 Wed, 02 Sep 2026 08:57:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 3/6] eventdev/crypto: promote adapter runtime params to stable
Date: Wed,  2 Sep 2026 08:53:56 -0700
Message-ID: <20260902155722.577747-4-stephen@networkplumber.org>
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

The crypto adapter runtime parameter functions were added in v23.03 and
have not changed since.  With this rte_event_crypto_adapter.c has no
experimental symbol left.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst  | 3 +++
 lib/eventdev/rte_event_crypto_adapter.c | 6 +++---
 lib/eventdev/rte_event_crypto_adapter.h | 3 ---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 792a5a35d0..18f0641ef2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -104,6 +104,9 @@ API Changes
   * Tx adapter: ``rte_event_eth_tx_adapter_runtime_params_init``,
     ``rte_event_eth_tx_adapter_runtime_params_set`` and
     ``rte_event_eth_tx_adapter_runtime_params_get``
+  * crypto adapter: ``rte_event_crypto_adapter_runtime_params_init``,
+    ``rte_event_crypto_adapter_runtime_params_set`` and
+    ``rte_event_crypto_adapter_runtime_params_get``
 
 
 ABI Changes
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index 3f9cc7379a..6ac64cafb1 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -1430,7 +1430,7 @@ rte_event_crypto_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_init)
 int
 rte_event_crypto_adapter_runtime_params_init(
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1469,7 +1469,7 @@ crypto_adapter_cap_check(struct event_crypto_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_set)
 int
 rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1502,7 +1502,7 @@ rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_get)
 int
 rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
diff --git a/lib/eventdev/rte_event_crypto_adapter.h b/lib/eventdev/rte_event_crypto_adapter.h
index 9a663c6227..463c90b843 100644
--- a/lib/eventdev/rte_event_crypto_adapter.h
+++ b/lib/eventdev/rte_event_crypto_adapter.h
@@ -646,7 +646,6 @@ rte_event_crypto_adapter_event_port_get(uint8_t id, uint8_t *event_port_id);
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_crypto_adapter_runtime_params_init(
 		struct rte_event_crypto_adapter_runtime_params *params);
@@ -669,7 +668,6 @@ rte_event_crypto_adapter_runtime_params_init(
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params);
@@ -688,7 +686,6 @@ rte_event_crypto_adapter_runtime_params_set(uint8_t id,
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params);
-- 
2.53.0

