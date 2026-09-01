Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7BC61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 528BA40DC9;
	Tue,  1 Sep 2026 22:32:32 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id B3AFD40BA4
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:30 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-853c401326eso173779b3a.2
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294750;
 x=1788899550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JXtty8RnL55zh8F0fHPpfxU8g9aht3q2BtX8u554LU=;
 b=HWzdImKl0QtJc00jKnk7e/XCbGB905SdtUvUoD3YaYbVorIT6Q5yoqiv9bhMq3BBCX
 a4sGcvQO45rk6IWCail8Ehjum51U2/rolgp3hRD8E1wqINaTKaKq5ATf2HszHScsu0fI
 XmXFcWyBKF15IbwJX3KahiklpaUsl3gjag2D8QJdCX9GxQcNFe5R+qX0aSDkQob3vwr1
 7XwIAhUnQJDeRr05w0M0V/50WFripNzo4Zm3gNcaXqErppU7NfS39kfE++0JcFtVQVFX
 HEER4GsmVU2R+6WrnnFAQlkaXNiLePP1uN0H+7nykjxZZGUNbtJPsf67/dVf/X063D4R
 ydYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294750; x=1788899550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+JXtty8RnL55zh8F0fHPpfxU8g9aht3q2BtX8u554LU=;
 b=imN+TQAsSgnaGqzouA/Wrc7/HxDarNjUV/jM0J0tl4CEZqh7GgKrmyO5aC2q2AM+96
 cgDqd7ZpCOZxhgDjZe1Nw1zr9B0hsCVW3e/aRDcHSrsClsv71MKx889q1h3lTTMiwJa7
 PPHrNxRnu5dbGBB+xMZxdTAN5QGTPxYcmYG8XC0c/LLaM315fa3Yx08tzqkL0xo22Wyp
 tGMSoJWjg+KyQgA2hdW8Y4Td6BBDg3g+EATDztlinJ1JQKpG/nVSR5kWhUFKhf/wC5e7
 oTaVNq+1kslV8moibhelGVLXizVa6Q8aLrG/z/CLv/U4+993TvffVnWbksltfBzeGsG9
 ddpg==
X-Gm-Message-State: AFuF++kH+py7SQs2iLo1eTaqRblVzgk6bHToDPfL/WQEMt2IAJw6wZ/7
 xzj3VJ4S0Xk8pw2rWRvHsRjjV7PKVFyUAq7Ro+JddUyWtINP6qIlcEnq6oDhRmeIvV4gix+FpMP
 hwP6R
X-Gm-Gg: AR+sD10rWvM7K7FZ4mqTtOW/MijPjuNdJv3R7CgFKDHwpQ5nnhs8atb4G6qphb2qMKJ
 na+bb1pDU/of3DWGkNeVJPOf+c+YoaiyYtKqK/W0OWyM6P3tgvjDWQsGiU1r7vH6byygXrCKefh
 qhfGgTjqWQbsLamaJNJR12fH3RgPIyvngJ1rXsegbSZw0ywzQzuyXa6LlgBgON2kADsYH8iSee4
 Rmmn8SmbBBjRyQC8EfmmskrZyf7WOZc8aIpOdwnZUPfL/qLlhMK3AZDuhl6qtOzHog2j/jfKGsa
 Gxun2AnztMpdzwQHcBod1nIRwXezg53Pn/8+Iy3PqsKScGbWuSpgmXvmboSgnthocjfDK6HqJL1
 lmT/kIjcjGA31CFlC/R000beW1flAU7wpHsWlTjPzcA9YowrA19hHrBdiTnWiBKREJl+6GcAkNx
 LupTPGaCAmRG8pbUeoJ1VDf+TId9TnnsnqZhmt/E2t5d1LFZjyOTNIv4J8f+zcW2wF9VO7fgRjs
 m8ukgrixnye7cdPfV+29wpFAkw=
X-Received: by 2002:a05:6a00:f88:b0:858:b809:6ec0 with SMTP id
 d2e1a72fcca58-85ed4d13780mr636338b3a.23.1788294749741; 
 Tue, 01 Sep 2026 13:32:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 01/22] ethdev: promote meter API to stable
Date: Tue,  1 Sep 2026 13:23:00 -0700
Message-ID: <20260901203217.1485915-2-stephen@networkplumber.org>
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

The traffic metering and policing (MTR) API was introduced in v17.11
and has carried the experimental tag ever since. The core of the
interface - profile and object management, statistics and the meter
enable/disable controls - has not changed since it was added.

Later additions to the same API are promoted together with it, since
they are all long past the two-release probation:

  17.11  profile add/delete/update, create, destroy, meter
         enable/disable, dscp table update, capabilities get,
         stats read/update
  21.05  meter policy validate/add/delete/update
  22.07  meter vlan table update, color in protocol set/get,
         color in protocol priority get
  22.11  meter profile get, meter policy get

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 +++
 lib/ethdev/rte_mtr.c                   | 42 +++++++++++++-------------
 lib/ethdev/rte_mtr.h                   | 24 ---------------
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..03d4eaba40 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: Promoted the following API from experimental to stable:
+
+  * meter (MTR) and policing: ``rte_mtr_*``
+
 
 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_mtr.c b/lib/ethdev/rte_mtr.c
index c6f0698ed3..4654ed83e9 100644
--- a/lib/ethdev/rte_mtr.c
+++ b/lib/ethdev/rte_mtr.c
@@ -78,7 +78,7 @@ __extension__ ({					\
 })
 
 /* MTR capabilities get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_capabilities_get, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_capabilities_get)
 int
 rte_mtr_capabilities_get(uint16_t port_id,
 	struct rte_mtr_capabilities *cap,
@@ -95,7 +95,7 @@ rte_mtr_capabilities_get(uint16_t port_id,
 }
 
 /* MTR meter profile add */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_add, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_profile_add)
 int
 rte_mtr_meter_profile_add(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -114,7 +114,7 @@ rte_mtr_meter_profile_add(uint16_t port_id,
 }
 
 /** MTR meter profile delete */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_delete, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_profile_delete)
 int
 rte_mtr_meter_profile_delete(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -131,7 +131,7 @@ rte_mtr_meter_profile_delete(uint16_t port_id,
 }
 
 /** MTR meter profile get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_profile_get)
 struct rte_flow_meter_profile *
 rte_mtr_meter_profile_get(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -148,7 +148,7 @@ rte_mtr_meter_profile_get(uint16_t port_id,
 }
 
 /* MTR meter policy validate */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_validate, 21.05)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_policy_validate)
 int
 rte_mtr_meter_policy_validate(uint16_t port_id,
 	struct rte_mtr_meter_policy_params *policy,
@@ -165,7 +165,7 @@ rte_mtr_meter_policy_validate(uint16_t port_id,
 }
 
 /* MTR meter policy add */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_add, 21.05)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_policy_add)
 int
 rte_mtr_meter_policy_add(uint16_t port_id,
 	uint32_t policy_id,
@@ -183,7 +183,7 @@ rte_mtr_meter_policy_add(uint16_t port_id,
 }
 
 /** MTR meter policy delete */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_delete, 21.05)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_policy_delete)
 int
 rte_mtr_meter_policy_delete(uint16_t port_id,
 	uint32_t policy_id,
@@ -200,7 +200,7 @@ rte_mtr_meter_policy_delete(uint16_t port_id,
 }
 
 /** MTR meter policy get */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_policy_get)
 struct rte_flow_meter_policy *
 rte_mtr_meter_policy_get(uint16_t port_id,
 	uint32_t policy_id,
@@ -217,7 +217,7 @@ rte_mtr_meter_policy_get(uint16_t port_id,
 }
 
 /** MTR object create */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_create, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_create)
 int
 rte_mtr_create(uint16_t port_id,
 	uint32_t mtr_id,
@@ -236,7 +236,7 @@ rte_mtr_create(uint16_t port_id,
 }
 
 /** MTR object destroy */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_destroy, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_destroy)
 int
 rte_mtr_destroy(uint16_t port_id,
 	uint32_t mtr_id,
@@ -253,7 +253,7 @@ rte_mtr_destroy(uint16_t port_id,
 }
 
 /** MTR object meter enable */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_enable, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_enable)
 int
 rte_mtr_meter_enable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -270,7 +270,7 @@ rte_mtr_meter_enable(uint16_t port_id,
 }
 
 /** MTR object meter disable */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_disable, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_disable)
 int
 rte_mtr_meter_disable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -287,7 +287,7 @@ rte_mtr_meter_disable(uint16_t port_id,
 }
 
 /** MTR object meter profile update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_update, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_profile_update)
 int
 rte_mtr_meter_profile_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -305,7 +305,7 @@ rte_mtr_meter_profile_update(uint16_t port_id,
 }
 
 /** MTR object meter policy update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_update, 21.05)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_policy_update)
 int
 rte_mtr_meter_policy_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -323,7 +323,7 @@ rte_mtr_meter_policy_update(uint16_t port_id,
 }
 
 /** MTR object meter DSCP table update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_dscp_table_update, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_dscp_table_update)
 int
 rte_mtr_meter_dscp_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -341,7 +341,7 @@ rte_mtr_meter_dscp_table_update(uint16_t port_id,
 }
 
 /** MTR object meter VLAN table update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_vlan_table_update, 22.07)
+RTE_EXPORT_SYMBOL(rte_mtr_meter_vlan_table_update)
 int
 rte_mtr_meter_vlan_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -359,7 +359,7 @@ rte_mtr_meter_vlan_table_update(uint16_t port_id,
 }
 
 /** Set the input color protocol on MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_set, 22.07)
+RTE_EXPORT_SYMBOL(rte_mtr_color_in_protocol_set)
 int
 rte_mtr_color_in_protocol_set(uint16_t port_id,
 	uint32_t mtr_id,
@@ -378,7 +378,7 @@ rte_mtr_color_in_protocol_set(uint16_t port_id,
 }
 
 /** Get input color protocols of MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_get, 22.07)
+RTE_EXPORT_SYMBOL(rte_mtr_color_in_protocol_get)
 int
 rte_mtr_color_in_protocol_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -396,7 +396,7 @@ rte_mtr_color_in_protocol_get(uint16_t port_id,
 }
 
 /** Get input color protocol priority of MTR object */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_priority_get, 22.07)
+RTE_EXPORT_SYMBOL(rte_mtr_color_in_protocol_priority_get)
 int
 rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -415,7 +415,7 @@ rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 }
 
 /** MTR object enabled stats update */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_update, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_stats_update)
 int
 rte_mtr_stats_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -433,7 +433,7 @@ rte_mtr_stats_update(uint16_t port_id,
 }
 
 /** MTR object stats read */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_read, 17.11)
+RTE_EXPORT_SYMBOL(rte_mtr_stats_read)
 int
 rte_mtr_stats_read(uint16_t port_id,
 	uint32_t mtr_id,
diff --git a/lib/ethdev/rte_mtr.h b/lib/ethdev/rte_mtr.h
index 30e6c6b12e..0a7782d4a3 100644
--- a/lib/ethdev/rte_mtr.h
+++ b/lib/ethdev/rte_mtr.h
@@ -41,9 +41,6 @@
  *    A) Whether an MTR object is private to a flow or potentially shared by
  *       several flows has to be specified at creation time.
  *    B) Several meter actions can be potentially registered for the same flow.
- *
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
  */
 #include <stdint.h>
 #include <rte_compat.h>
@@ -569,7 +566,6 @@ struct rte_mtr_error {
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_capabilities_get(uint16_t port_id,
 	struct rte_mtr_capabilities *cap,
@@ -593,7 +589,6 @@ rte_mtr_capabilities_get(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_profile_add(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -615,7 +610,6 @@ rte_mtr_meter_profile_add(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_profile_delete(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -635,7 +629,6 @@ rte_mtr_meter_profile_delete(uint16_t port_id,
  * @return
  *   A valid handle in case of success, NULL otherwise.
  */
-__rte_experimental
 struct rte_flow_meter_profile *
 rte_mtr_meter_profile_get(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -663,7 +656,6 @@ rte_mtr_meter_profile_get(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_policy_validate(uint16_t port_id,
 	struct rte_mtr_meter_policy_params *policy,
@@ -690,7 +682,6 @@ rte_mtr_meter_policy_validate(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_policy_add(uint16_t port_id,
 	uint32_t policy_id,
@@ -711,7 +702,6 @@ rte_mtr_meter_policy_add(uint16_t port_id,
  * @return
  *   A valid handle in case of success, NULL otherwise.
  */
-__rte_experimental
 struct rte_flow_meter_policy *
 rte_mtr_meter_policy_get(uint16_t port_id,
 	uint32_t policy_id,
@@ -793,7 +783,6 @@ struct rte_mtr_meter_policy_params policy = \
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_policy_delete(uint16_t port_id,
 	uint32_t policy_id,
@@ -822,7 +811,6 @@ rte_mtr_meter_policy_delete(uint16_t port_id,
  *
  * @see enum rte_flow_action_type::RTE_FLOW_ACTION_TYPE_METER
  */
-__rte_experimental
 int
 rte_mtr_create(uint16_t port_id,
 	uint32_t mtr_id,
@@ -846,7 +834,6 @@ rte_mtr_create(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_destroy(uint16_t port_id,
 	uint32_t mtr_id,
@@ -874,7 +861,6 @@ rte_mtr_destroy(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_disable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -896,7 +882,6 @@ rte_mtr_meter_disable(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_enable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -916,7 +901,6 @@ rte_mtr_meter_enable(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_profile_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -937,7 +921,6 @@ rte_mtr_meter_profile_update(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_policy_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -964,7 +947,6 @@ rte_mtr_meter_policy_update(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_dscp_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -991,7 +973,6 @@ rte_mtr_meter_dscp_table_update(uint16_t port_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_meter_vlan_table_update(uint16_t port_id, uint32_t mtr_id,
 				enum rte_mtr_color_in_protocol proto,
@@ -1022,7 +1003,6 @@ rte_mtr_meter_vlan_table_update(uint16_t port_id, uint32_t mtr_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_color_in_protocol_set(uint16_t port_id, uint32_t mtr_id,
 	enum rte_mtr_color_in_protocol proto, uint32_t priority,
@@ -1042,7 +1022,6 @@ rte_mtr_color_in_protocol_set(uint16_t port_id, uint32_t mtr_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_color_in_protocol_get(uint16_t port_id, uint32_t mtr_id,
 	uint64_t *proto_mask,
@@ -1064,7 +1043,6 @@ rte_mtr_color_in_protocol_get(uint16_t port_id, uint32_t mtr_id,
  * @return
  *   0 on success, non-zero error code otherwise.
  */
-__rte_experimental
 int
 rte_mtr_color_in_protocol_priority_get(uint16_t port_id, uint32_t mtr_id,
 	enum rte_mtr_color_in_protocol proto, uint32_t *priority,
@@ -1088,7 +1066,6 @@ rte_mtr_color_in_protocol_priority_get(uint16_t port_id, uint32_t mtr_id,
  *
  * @see enum rte_mtr_stats_type
  */
-__rte_experimental
 int
 rte_mtr_stats_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -1120,7 +1097,6 @@ rte_mtr_stats_update(uint16_t port_id,
  *
  * @see enum rte_mtr_stats_type
  */
-__rte_experimental
 int
 rte_mtr_stats_read(uint16_t port_id,
 	uint32_t mtr_id,
-- 
2.53.0

