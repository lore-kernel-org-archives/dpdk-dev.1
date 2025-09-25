Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865D8CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66DB440A7F;
	Thu, 25 Sep 2025 14:32:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E618B40A6F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758803567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/EV/pbtbJWM84FR5E+c4Gpy+iybyXEvn4C3R+q4kV8=;
 b=bv6BKZtKHEnUosbK0KNe0yNv9Xq5XGTbo8jhErmc4WY5l6zrIRmcV7RzhTJT49CxhKpU6W
 7bwtuZCbNPsCfDntTjMt5by4C3W57gRrk9XnqSqOzpc34b5rcITECGR7uI34PmAaO7kg7Y
 mb3ENrPiNLG/OypQrX7H+Xwl8VWF7Aw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-dcPAsd0IPOGcl_hVb3Gjrg-1; Thu,
 25 Sep 2025 08:32:44 -0400
X-MC-Unique: dcPAsd0IPOGcl_hVb3Gjrg-1
X-Mimecast-MFC-AGG-ID: dcPAsd0IPOGcl_hVb3Gjrg_1758803563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 280C9195608B; Thu, 25 Sep 2025 12:32:43 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38DCA19560A2; Thu, 25 Sep 2025 12:32:40 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v4 7/7] power: separate public and driver headers
Date: Thu, 25 Sep 2025 14:31:49 +0200
Message-ID: <20250925123150.3063298-8-david.marchand@redhat.com>
In-Reply-To: <20250925123150.3063298-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rirs3wwE4izOs8vd3XJTH2UoaXdc-E99ok6_fMUENbk_1758803563
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

power_cpufreq.h, power_common.h and power_uncore_ops.h look like driver
only headers, but were included from public headers.
Move them to the driver_sdk_headers list.

There is one complication though for power_cpufreq.h as it was included
from a public header rte_power_cpufreq.h.
Move the rte_power_core_capabilities struct definition to the public
header, since a (stable) public symbol relies on it.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/power/meson.build         |  7 +++++--
 lib/power/power_cpufreq.h     | 14 +-------------
 lib/power/power_uncore_ops.h  |  1 +
 lib/power/rte_power_cpufreq.c |  2 +-
 lib/power/rte_power_cpufreq.h | 15 +++++++++++++--
 lib/power/rte_power_uncore.c  |  2 +-
 lib/power/rte_power_uncore.h  |  3 ++-
 7 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/lib/power/meson.build b/lib/power/meson.build
index 56b59071ea..d89fb55514 100644
--- a/lib/power/meson.build
+++ b/lib/power/meson.build
@@ -22,12 +22,15 @@ sources = files(
         'rte_power_uncore.c',
 )
 headers = files(
-        'power_cpufreq.h',
-        'power_uncore_ops.h',
         'rte_power_cpufreq.h',
         'rte_power_pmd_mgmt.h',
         'rte_power_qos.h',
         'rte_power_uncore.h',
 )
+driver_sdk_headers = files(
+        'power_common.h',
+        'power_cpufreq.h',
+        'power_uncore_ops.h',
+)
 
 deps += ['timer', 'ethdev']
diff --git a/lib/power/power_cpufreq.h b/lib/power/power_cpufreq.h
index 92f1ab8f37..fb0b7feb82 100644
--- a/lib/power/power_cpufreq.h
+++ b/lib/power/power_cpufreq.h
@@ -14,6 +14,7 @@
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_compat.h>
+#include <rte_power_cpufreq.h>
 
 #define RTE_POWER_DRIVER_NAMESZ 24
 
@@ -131,19 +132,6 @@ typedef int (*rte_power_freq_change_t)(unsigned int lcore_id);
  *  - Negative on error.
  */
 
-/**
- * Power capabilities summary.
- */
-struct rte_power_core_capabilities {
-	union {
-		uint64_t capabilities;
-		struct {
-			uint64_t turbo:1;       /**< Turbo can be enabled. */
-			uint64_t priority:1;    /**< SST-BF high freq core */
-		};
-	};
-};
-
 typedef int (*rte_power_get_capabilities_t)(unsigned int lcore_id,
 			struct rte_power_core_capabilities *caps);
 
diff --git a/lib/power/power_uncore_ops.h b/lib/power/power_uncore_ops.h
index b92af28df9..783860ee5b 100644
--- a/lib/power/power_uncore_ops.h
+++ b/lib/power/power_uncore_ops.h
@@ -13,6 +13,7 @@
 
 #include <rte_compat.h>
 #include <rte_common.h>
+#include <rte_power_uncore.h>
 
 #define RTE_POWER_UNCORE_DRIVER_NAMESZ 24
 
diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index d4db03a4e5..f63e976dc2 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -6,8 +6,8 @@
 #include <rte_spinlock.h>
 #include <rte_debug.h>
 
-#include "rte_power_cpufreq.h"
 #include "power_common.h"
+#include "power_cpufreq.h"
 
 static enum power_management_env global_default_env = PM_ENV_NOT_SET;
 static struct rte_power_cpufreq_ops *global_cpufreq_ops;
diff --git a/lib/power/rte_power_cpufreq.h b/lib/power/rte_power_cpufreq.h
index 82d274214b..1605ba866a 100644
--- a/lib/power/rte_power_cpufreq.h
+++ b/lib/power/rte_power_cpufreq.h
@@ -14,8 +14,6 @@
 #include <rte_common.h>
 #include <rte_log.h>
 
-#include "power_cpufreq.h"
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -248,6 +246,19 @@ int rte_power_freq_enable_turbo(unsigned int lcore_id);
  */
 int rte_power_freq_disable_turbo(unsigned int lcore_id);
 
+/**
+ * Power capabilities summary.
+ */
+struct rte_power_core_capabilities {
+	union {
+		uint64_t capabilities;
+		struct {
+			uint64_t turbo:1;       /**< Turbo can be enabled. */
+			uint64_t priority:1;    /**< SST-BF high freq core */
+		};
+	};
+};
+
 /**
  * Returns power capabilities for a specific lcore.
  * Function pointer definition. Review each environments
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 30cd374127..25bdb113c5 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -7,8 +7,8 @@
 #include <rte_spinlock.h>
 #include <rte_debug.h>
 
-#include "rte_power_uncore.h"
 #include "power_common.h"
+#include "power_uncore_ops.h"
 
 static enum rte_uncore_power_mgmt_env global_uncore_env = RTE_UNCORE_PM_ENV_NOT_SET;
 static struct rte_power_uncore_ops *global_uncore_ops;
diff --git a/lib/power/rte_power_uncore.h b/lib/power/rte_power_uncore.h
index dfeade77e9..66aea1b37f 100644
--- a/lib/power/rte_power_uncore.h
+++ b/lib/power/rte_power_uncore.h
@@ -11,7 +11,8 @@
  * Uncore Frequency Management
  */
 
-#include "power_uncore_ops.h"
+#include <rte_compat.h>
+#include <rte_common.h>
 
 #ifdef __cplusplus
 extern "C" {
-- 
2.51.0

