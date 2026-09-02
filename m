Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24AC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CB9F40E4C;
	Wed,  2 Sep 2026 17:57:40 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6CFBB40EA5
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:38 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d9201076b3so15442915ad.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364657;
 x=1788969457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyRy/mgUkOuBFee47zOn+VsfDB9RW/gmy3t82za6Q2A=;
 b=g6YlQg+cvsTLQKpb37pMisV384JgKqG+HJZFFJXy1TSjAIlBLZujqxv6RKlUGcHe0V
 7oN8cvoVSH72fhg5zkvfKquHehWwLkUwNo2Zg6sd1YGaVrqRIT7wcHL5UCDBjVf6QIRZ
 pS3iR245DefCnCmkVMLHuF+3euClavsqBs1ZLaROQeC8pfue2vpmvZF/n/gGKn4whrEd
 DVoeWK1p/EVeq7tl12H2u+JHmoM6o+FLhIzab0BTSWYONWnDd0LKhUNWm2/oYYsR+NmX
 ntdqFZ6RAqmb/eT9lX2Gg6J8hxXCP8MLFzK/T+s2cmVyb3bXj1jxYfeDqkSpd1NDOE3N
 p0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364657; x=1788969457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyRy/mgUkOuBFee47zOn+VsfDB9RW/gmy3t82za6Q2A=;
 b=tGoqc2TZRZAcSTAW4Q/xqBJwqBLWyAArlBDfEimU7ENYiFm6bx8sHBuOh86MUWrfv0
 GoTWPUERJgz6y+9T5KsXHN2r8RfAwAnOqit95qc2ZiQthVT33Gihh0BLo3QQx2SXWPQg
 lBcRsiIdDcPzPsOBZuuW0Tn5+dfVGpv1O1W/zT/epGojaRiDke+8iuJd2kViZpBoIFjW
 YJeSTwsKYcWiVvn7l0F7fdIMW8zp3mpjeen71tAZ7PRFe+1yfzEGubVhldk2kWPt3NRm
 u9BplveDVSTlemxdyYL28f6FmEzCsf+3BVDK8eUx5B40hC1nhCXsDB5fqQ8HP2pQYqbH
 eMiQ==
X-Gm-Message-State: AFuF++mew8wWtBitUeQn/8gFqnfx+FVK4oEozpvy2mV7t/v+kiOdg3Hm
 GiLZezqbOm8+fBQqShNX1MYnp2L/CywXvAajNP9AtuBt19eA8mqOHVXHbIcxisDrmDGzEGzfY7I
 7ssAj
X-Gm-Gg: AYBFou3p1CeDmE9lRunhVDJ6gvrj0fvQsL5qtPFH7aQ3RBePxLr3zAVMgXZBk/vYkYj
 HYvbBsJTjxSfmYKs6HY0oAgp08/S4mmTA+dTbnER/XvXUE4Mat7/TiD6xfzujH/CJvuZLyl3BQX
 2D2B8mow0jwH4xM+vB6UFckxmK4I5AQdd+06k1s+cgWBgBckvpiVzE9Jgrr0sGvTtncKNmEkuYF
 LMp4hNt1kn0zjNa3AU/9N83D/D4H6gVlgSfHCyZ+YkCEi4EmrPVlQMfwWxDPPXe/FsjHueGeMqD
 70Cst1nrpMmPfgNfEBjy/a312s4V3ZAa+FAFPb7GY0uJPINM6Tk8KPv1ALqm6pLBYOWPHN7faMw
 lAQb1uNpRj8dzN9n3A8TaQip1PGtQN3YuFmttUvpevctuKCVTYkaz+uIvQZ7leImckCKOYZ/3Eq
 LJq2llvJK36q7xm6N9z4HsCfAG2aJyUTB2n00eSC8JT2KLgccUTvdsK9izQ23WUufvn/+whE3Rf
 SGFY4IfkA+lZsiuWzYA2lHg1TU=
X-Received: by 2002:a17:902:fac7:b0:2d7:203b:9863 with SMTP id
 d9443c01a7336-2daec5ff49bmr62867025ad.1.1788364657529; 
 Wed, 02 Sep 2026 08:57:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 2/6] eventdev/eth_tx: promote adapter runtime params to stable
Date: Wed,  2 Sep 2026 08:53:55 -0700
Message-ID: <20260902155722.577747-3-stephen@networkplumber.org>
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

The Tx adapter runtime parameter functions were added in v23.03 and
have not changed since.  With this rte_event_eth_tx_adapter.c has no
experimental symbol left.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst  | 3 +++
 lib/eventdev/rte_event_eth_tx_adapter.c | 6 +++---
 lib/eventdev/rte_event_eth_tx_adapter.h | 3 ---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fb7d9d6448..792a5a35d0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -101,6 +101,9 @@ API Changes
     ``rte_event_eth_rx_adapter_runtime_params_init``,
     ``rte_event_eth_rx_adapter_runtime_params_set`` and
     ``rte_event_eth_rx_adapter_runtime_params_get``
+  * Tx adapter: ``rte_event_eth_tx_adapter_runtime_params_init``,
+    ``rte_event_eth_tx_adapter_runtime_params_set`` and
+    ``rte_event_eth_tx_adapter_runtime_params_get``
 
 
 ABI Changes
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 91c7be55c7..03f1871157 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -1306,7 +1306,7 @@ rte_event_eth_tx_adapter_stats_reset(uint8_t id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_init, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_runtime_params_init)
 int
 rte_event_eth_tx_adapter_runtime_params_init(
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1333,7 +1333,7 @@ txa_caps_check(struct txa_service_data *txa)
 	return -ENOTSUP;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_set, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_runtime_params_set)
 int
 rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1365,7 +1365,7 @@ rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_get, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_runtime_params_get)
 int
 rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.h b/lib/eventdev/rte_event_eth_tx_adapter.h
index 58d77650ae..9ef728a315 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.h
+++ b/lib/eventdev/rte_event_eth_tx_adapter.h
@@ -557,7 +557,6 @@ rte_event_eth_tx_adapter_queue_stop(uint16_t eth_dev_id, uint16_t tx_queue_id);
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_tx_adapter_runtime_params_init(
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params);
@@ -579,7 +578,6 @@ rte_event_eth_tx_adapter_runtime_params_init(
  * -  0: Success
  * - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *params);
@@ -597,7 +595,6 @@ rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
  * -  0: Success
  * - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *params);
-- 
2.53.0

