Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FBC5DF97
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD77410F2;
	Fri, 21 Aug 2026 21:32:08 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id C21E940E44
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:57 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1011310b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340717;
 x=1787945517; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnwFHf5fm4clMWvuwFZCQa0yWp869I1VWhKQJZS7JRU=;
 b=bYNJyD8Es4AIHHh4m8apYi8gKwxhYB4LR3cIzykyOc7LwH8yEb2GiGtia2zqSX2gWH
 I+GlMa2RQK+wy4E+bvVgobEHbkMCOlY124G6tLDV9+Atd3fHRTROcnuSGXCN/B4BQPYq
 dNaagnRG97UyN7yRHXVUyczqhtp0aHwdrxtLxAthDw9TQBL2nkAa4SrpaPy7plPbmWFG
 w/hHDITSyx50An2MxKAkg0qMc4MVTroX4AH8UbWyNBfsSkWWjKIlLLBEwjmdmBBUAESb
 yoNjxHaS30OwcKLjgTCZmtCQVHr0J+bJNqw0nG45wxDKYUaKL6x7/nN4XqXt/Qhz43qa
 Lryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340717; x=1787945517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnwFHf5fm4clMWvuwFZCQa0yWp869I1VWhKQJZS7JRU=;
 b=Mzz6jtQYqrKhmEi5xgii7dVwGXuNvbIOkuqnts6u/y7hkgh0YrQdOScgQ/o4CoCl1A
 nX2x07AWqSU00GHdRNuhQODysSOzXuzc65yJgG79uTQC9NCLf6WYbu6CLabt91ZllQmE
 yADYqFMog3GjHazDjHAZtGCNQJDiXqjK7uaGk9H588GS62CqvxsZbmTwGeTHpCB8QUv/
 5ODItOKdZq/PRHRZf2qQeVUC+BxMFRUlV1M5+PjtAgAJeoBdaYpYt+271YY2ye7GTVDb
 dNYpibkcpmxPdflIWybTBh+b2YAsBkLee99nwBsu223lKLg35AjfSB566ccWRiyVxBp5
 7BBw==
X-Gm-Message-State: AFuF++k6AtYZX2LAPzIrZGhMY6PivxUv7vIK0yn9ZHRZuba7AtoJS+vf
 yFykr8khasLQfD8um6adMqccXbHaRr/Xrlgl31YNDKJ2EWclD/q/CAb4O9f2aFH31Njm5NgdobL
 kiOWxajg=
X-Gm-Gg: AR+sD10UaB4STae1bCqiIVVPx9jki3Y2EycJw2vm2+dHJtUoxlwYgC0C7sM2SlnZzh2
 i1/foj8Q7x3ywZIl79a5XZLJQFq9qAtuNMIxdK4JGGg7/qSZ2rN4PfSH8mKqcLiS7s4CKzgaj0b
 8mopBOLlml1NwAf1r369Aon9MlIgvf5ae8SCZ2NLQRHB32UkhPjFySPLIR65QPg5ZLg/7gMH0iI
 D/CwGqRIcFhL2TBV09WOXuei67BwLVVztE+6RYDxgAvPKz5QR+Wk26NCipbQSXFEskMoER5X/TX
 4gBYTcCxuD6HVTg5He0/GDOnZDEjNAdC5UZgian2S/UyAT9YiTDGku1lqub3EWyYL/EkZmIOVN5
 BHIkv9kmlnTY57QJZsen+uh0aqEQOEaLB3WU6aZQLQmorJwyr6vjYdhzIRGV0hmW5itXvvzjd7x
 tPHhshjV9oVfxVO5uodP6xjdl1kZ7p9NU/zKFQ/8nqRZjtAuzK3r/uPd78v+zjPN/bCZ3Mgi+y+
 iMDvOXiY+GSr+vbdcsGqJFvN4c=
X-Received: by 2002:a05:6a21:8cc8:b0:3c3:a31b:3949 with SMTP id
 adf61e73a8af0-3cd3003d58emr20332776637.11.1787340716931; 
 Fri, 21 Aug 2026 12:31:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v2 68/68] power: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:25:03 -0700
Message-ID: <20260821192646.146382-69-stephen@networkplumber.org>
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

All the uses of rte_memcpy() in the power drivers are in the
frequency list query API, which is control path only. Regular
memcpy() has no performance disadvantage there and gets more
compile time checking of the arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/power/acpi/acpi_cpufreq.c                 | 4 ++--
 drivers/power/amd_pstate/amd_pstate_cpufreq.c     | 4 ++--
 drivers/power/amd_uncore/amd_uncore.c             | 5 ++---
 drivers/power/cppc/cppc_cpufreq.c                 | 4 ++--
 drivers/power/intel_pstate/intel_pstate_cpufreq.c | 3 +--
 drivers/power/intel_uncore/intel_uncore.c         | 5 ++---
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index af85a8cdec..03769a0276 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -5,8 +5,8 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <string.h>
 
-#include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 #include <rte_string_fns.h>
 
@@ -364,7 +364,7 @@ power_acpi_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
 
 	return pi->nb_freqs;
 }
diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index af9c1309f3..7efaf7b944 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -5,8 +5,8 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 
-#include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 
 #include "amd_pstate_cpufreq.h"
@@ -483,7 +483,7 @@ power_amd_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
 
 	return pi->nb_freqs;
 }
diff --git a/drivers/power/amd_uncore/amd_uncore.c b/drivers/power/amd_uncore/amd_uncore.c
index c3e95cdc08..f9dc0c814f 100644
--- a/drivers/power/amd_uncore/amd_uncore.c
+++ b/drivers/power/amd_uncore/amd_uncore.c
@@ -5,8 +5,7 @@
 #include <errno.h>
 #include <dirent.h>
 #include <fnmatch.h>
-
-#include <rte_memcpy.h>
+#include <string.h>
 
 #include "amd_uncore.h"
 #include "power_common.h"
@@ -269,7 +268,7 @@ power_amd_uncore_freqs(unsigned int pkg, unsigned int die, uint32_t *freqs, uint
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, ui->freqs, ui->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, ui->freqs, ui->nb_freqs * sizeof(uint32_t));
 
 	return ui->nb_freqs;
 }
diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index aed44c1212..b4bfe1865f 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -4,8 +4,8 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 
-#include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 
 #include "cppc_cpufreq.h"
@@ -469,7 +469,7 @@ power_cppc_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
 
 	return pi->nb_freqs;
 }
diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index dfbb5635a1..da0ea562c7 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -11,7 +11,6 @@
 #include <errno.h>
 #include <inttypes.h>
 
-#include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 
 #include "rte_power_pmd_mgmt.h"
@@ -679,7 +678,7 @@ power_pstate_cpufreq_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t num)
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, pi->freqs, pi->nb_freqs * sizeof(uint32_t));
 
 	return pi->nb_freqs;
 }
diff --git a/drivers/power/intel_uncore/intel_uncore.c b/drivers/power/intel_uncore/intel_uncore.c
index 6759ea1445..2cbcf864d5 100644
--- a/drivers/power/intel_uncore/intel_uncore.c
+++ b/drivers/power/intel_uncore/intel_uncore.c
@@ -5,8 +5,7 @@
 #include <errno.h>
 #include <dirent.h>
 #include <fnmatch.h>
-
-#include <rte_memcpy.h>
+#include <string.h>
 
 #include "intel_uncore.h"
 #include "power_common.h"
@@ -394,7 +393,7 @@ power_intel_uncore_freqs(unsigned int pkg, unsigned int die, uint32_t *freqs, ui
 		POWER_LOG(ERR, "Buffer size is not enough");
 		return 0;
 	}
-	rte_memcpy(freqs, ui->freqs, ui->nb_freqs * sizeof(uint32_t));
+	memcpy(freqs, ui->freqs, ui->nb_freqs * sizeof(uint32_t));
 
 	return ui->nb_freqs;
 }
-- 
2.53.0

