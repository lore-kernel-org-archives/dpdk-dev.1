Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F1CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87FC542DCA;
	Wed,  7 Oct 2026 23:41:35 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D6924427BB
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:31 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e7006bbf77so3091135ad.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409291;
 x=1792014091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y77Y5ua2+uxkIEiZCTvpt5roUx9lBXx1eVrwTw/myOA=;
 b=XEQm0Q0/oFVBC0WynG3NT5TAvcj6XSeaF3oUf/V1BbfxGXuPYXvF21XeLbyv6tILoi
 Dz/cuWKgZSy92gImlxAZJ62B3xJRJ4wMS4Axsmz+kPX3nxhZODW0snG03H8HwsFCRmP3
 ythNDpNPg8/6/XN66Q0lGgAh+bhqbppUghQjm5vDBdeRXlhp29/VVxIXLJedWi9DpFsC
 ohRphuhWBBVLFkrGycqtURtw63yfQt1mSfY+m2mN/lAvm05aJJu+poO4ia+vKaHLDon2
 40ya3Egtqbro7+pbYas7+DHI90+JPIfAHFv41bMmo/OBHOdLCYEgZ0jeNmInI4KVa7aH
 z9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409291; x=1792014091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y77Y5ua2+uxkIEiZCTvpt5roUx9lBXx1eVrwTw/myOA=;
 b=a2EqmY3Bo8PWbaqiozexGyWOQQO82HWi9IKXE59rCh5tkvhYptPDkA8ecxzYnpdiOZ
 27yi1xYaUI4xXFDnOCjOHdlSJNBTGj8Nioii0nCCN6divfMQl8OsGfHPLomvcRf0AmrV
 fEVfwvWQCKqLrBO+nX6bQznzXMwZcN4LJKoJL9hhr6uKA1EMNgqP7RIQKoGo+sDGGrDi
 k8TlrPvH/K8Gu7abkvxmZUBXPSIwZHdB0H0K+K7hUUd3IPYtA6D/PvmPpc0CB3GwUlid
 FIJqkTKVkWyDmUnGVsVH0SvZP+OLzZneUX2KSiGxakXf/LKydyIpHhpufY5Uck6kZ3zz
 50dA==
X-Gm-Message-State: AFq9FYLNpsb6kRuV0eepuTGjJwTcQj3kuQ+7YwWOYOkHHWkt9c4qyz/+
 uvUmB111GpkW3PfqoSFqlMqnfsTFHSapJcXpkw+ssx941WShzdG2mqxALGgQSURXTDszgZ+9fwu
 Lb1x6ftU=
X-Gm-Gg: AYBFou0OhFeuuzFJGXWFEvkaVNfnKgJobajI/dRIXPehPiATLFW8DZ6atoXoYV4wu6t
 b6fxJ2sj5T4hYdPl5/z9q4A58Iw2ANBeWBKo4ro0AUEdQBT666Yva+oxLpvMdqyrwoLd25nHqRF
 MPv7vZZdwiGKgt6t364cFQs3IAMh93V6iP5T9xeVAJZmHt4uxyYZCWdN7w7wxOO8DW27XKpIR6v
 7+8/cx3JenGks/PDVPkK3Vrf7TCH0eiS8kWjLLYFmZhjm5IEMOwwfcOYtt6HnIaeD4bvW9OoLz6
 bEx4rQr1r8ardK9r9d4MalJ7sGghGpa/XZvZ3ettlDUIfWLBPQR5IOX1xxVuakk/Nfe1rUh2nFN
 +e3ZUTBabrhTMEoim+1/9kWscqVbP37+kioVleMI3hD8ICDyd4pHHJW7BGZYt8xq5/ncSF78CMW
 QY8/nDOj7rHx4LNF98O1B1ii3AQHCD9knz54doWMpMIowxABuVh8XX+Ue7mX9y09nRxD43YwANK
 2zTuBJ9BubDJmJVkgkCasrxQvAcg4g7EEAvcQ==
X-Received: by 2002:a17:902:ce07:b0:2e2:d085:9662 with SMTP id
 d9443c01a7336-2e60054ce9emr31375935ad.52.1791409290978; 
 Wed, 07 Oct 2026 14:41:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 12/20] power: promote PM QoS and uncore API to stable
Date: Wed,  7 Oct 2026 14:39:42 -0700
Message-ID: <20261007214115.3092715-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The PM QoS API (rte_power_qos_{set,get}_cpu_resume_latency) has been
experimental since 24.11, and the uncore environment and frequency list
functions (rte_power_{set,unset,get}_uncore_env, rte_power_uncore_freqs)
since 23.11.

These interfaces have not changed since they were introduced and the
rest of the uncore API is already stable, so promote them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  7 +++++++
 lib/power/rte_power_qos.c              |  4 ++--
 lib/power/rte_power_qos.h              | 10 ----------
 lib/power/rte_power_uncore.c           |  8 ++++----
 lib/power/rte_power_uncore.h           |  5 -----
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fad1a53e04..e9e9b1f6da 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -348,6 +348,13 @@ API Changes
   functions in pipeline, the ``rte_swx_table_*`` symbols in table and
   the ``rte_swx_port_*`` symbols in port.
 
+* power: Promoted the following API from experimental to stable:
+
+  * PM QoS: ``rte_power_qos_set_cpu_resume_latency`` and
+    ``rte_power_qos_get_cpu_resume_latency``
+  * uncore: ``rte_power_set_uncore_env``, ``rte_power_unset_uncore_env``,
+    ``rte_power_get_uncore_env`` and ``rte_power_uncore_freqs``
+
 * reorder: Promoted the following API from experimental to stable:
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index d8d8d36a76..3ecfcc54fa 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -18,7 +18,7 @@
 
 #define PM_QOS_CPU_RESUME_LATENCY_BUF_LEN	32
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_set_cpu_resume_latency, 24.11)
+RTE_EXPORT_SYMBOL(rte_power_qos_set_cpu_resume_latency)
 int
 rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 {
@@ -69,7 +69,7 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_get_cpu_resume_latency, 24.11)
+RTE_EXPORT_SYMBOL(rte_power_qos_get_cpu_resume_latency)
 int
 rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 {
diff --git a/lib/power/rte_power_qos.h b/lib/power/rte_power_qos.h
index 05a3f51ae2..d8c5ab92d5 100644
--- a/lib/power/rte_power_qos.h
+++ b/lib/power/rte_power_qos.h
@@ -7,8 +7,6 @@
 
 #include <stdint.h>
 
-#include <rte_compat.h>
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -36,9 +34,6 @@ extern "C" {
 #define RTE_POWER_QOS_RESUME_LATENCY_NO_CONSTRAINT	INT32_MAX
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * @param lcore_id
  *   target logical core id
  *
@@ -48,13 +43,9 @@ extern "C" {
  * @return
  *   0 on success. Otherwise negative value is returned.
  */
-__rte_experimental
 int rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get the current resume latency of this logical core.
  * The default value in kernel is @see RTE_POWER_QOS_RESUME_LATENCY_NO_CONSTRAINT
  * if don't set it.
@@ -63,7 +54,6 @@ int rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency);
  *   Negative value on failure.
  *   >= 0 means the actual resume latency limit on this core.
  */
-__rte_experimental
 int rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id);
 
 #ifdef __cplusplus
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index b50e09a2ad..90e83d9f2a 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -46,7 +46,7 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
+RTE_EXPORT_SYMBOL(rte_power_set_uncore_env)
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 {
@@ -86,7 +86,7 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_unset_uncore_env, 23.11)
+RTE_EXPORT_SYMBOL(rte_power_unset_uncore_env)
 void
 rte_power_unset_uncore_env(void)
 {
@@ -95,7 +95,7 @@ rte_power_unset_uncore_env(void)
 	rte_spinlock_unlock(&global_env_cfg_lock);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_get_uncore_env, 23.11)
+RTE_EXPORT_SYMBOL(rte_power_get_uncore_env)
 enum rte_uncore_power_mgmt_env
 rte_power_get_uncore_env(void)
 {
@@ -180,7 +180,7 @@ rte_power_uncore_freq_min(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->freq_min(pkg, die);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_freqs, 23.11)
+RTE_EXPORT_SYMBOL(rte_power_uncore_freqs)
 int
 rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 			uint32_t *freqs, uint32_t num)
diff --git a/lib/power/rte_power_uncore.h b/lib/power/rte_power_uncore.h
index 66aea1b37f..9599839d89 100644
--- a/lib/power/rte_power_uncore.h
+++ b/lib/power/rte_power_uncore.h
@@ -11,7 +11,6 @@
  * Uncore Frequency Management
  */
 
-#include <rte_compat.h>
 #include <rte_common.h>
 
 #ifdef __cplusplus
@@ -39,14 +38,12 @@ enum rte_uncore_power_mgmt_env {
  *  - 0 on success.
  *  - Negative on error.
  */
-__rte_experimental
 int rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env);
 
 /**
  * Unset the global uncore environment configuration.
  * This can only be called after all threads have completed.
  */
-__rte_experimental
 void rte_power_unset_uncore_env(void);
 
 /**
@@ -55,7 +52,6 @@ void rte_power_unset_uncore_env(void);
  * @return
  *  power_management_env The configured environment.
  */
-__rte_experimental
 enum rte_uncore_power_mgmt_env rte_power_get_uncore_env(void);
 
 /**
@@ -203,7 +199,6 @@ int rte_power_uncore_freq_min(unsigned int pkg, unsigned int die);
  *  - The number of available index's in frequency array.
  *  - Negative on error.
  */
-__rte_experimental
 int rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 		uint32_t *freqs, uint32_t num);
 
-- 
2.53.0

