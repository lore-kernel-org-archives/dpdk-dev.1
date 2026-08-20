Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441DC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD2B340F16;
	Thu, 20 Aug 2026 07:26:46 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 5E06A4026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:45 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2236962a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203604;
 x=1787808404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnwFHf5fm4clMWvuwFZCQa0yWp869I1VWhKQJZS7JRU=;
 b=cqqERn62sRCXXCb4QG7nVlBvwwiOw9UYr/srkbdkYNtfODtb8WZfFe4Gwo+gu0CfLl
 Jw6V2Y71UHcpEyebw/btG49CmS6xvUG4R3g+pxJ/4lJsbqt7IQ8NM8u3ulazGuvU6gRF
 SmTzKxKpz9v7FGXbVFynFQqy5pFsjZj1jZcI+HlT0N16USuAdGfrtwEqyT5sJdy44J89
 qZ9j/+k4onJz0UA8HXhLobbwIPQB4Q5pVgjQ9tX+oeGLwrswPJ7oxhWhWZsDGfXBHHYp
 z4MgCr7hkHevzBAwhit7cZA5LBx1Ulgn/Due3ffdNO/lNoZU2PfZG2fKp4ZUTQ1NCbsw
 zIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203604; x=1787808404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnwFHf5fm4clMWvuwFZCQa0yWp869I1VWhKQJZS7JRU=;
 b=VJ4AXLkw3Ocnrifb3yvxGKf5U08mItk92rkr1A+WByeWTgM6tVkX6weqWgiWg9tXs2
 88tW7HEv3sQ9ZsNkle5gSkGxhLF5p+mbb82MVmPkIJXik8XD1W6kIjTncU7DJWdt56V4
 NnwJDUA4wOUf8vNFrXUGdIE5dJwcnUJBbTRcBQxfZm9p3EcpLG1LDtN12x6YxyP3RwWb
 9PeW+RKYCE49wh1Sa7Vx4i2w0CMEvARNRgnuH1HQQc38PrrkLKHU/aTnUKm05kEeb184
 mihV6f+Hsxi6qXe2zDGrDvS7rdPo2JbuEYIRYOTZTcWlH1LbX9W56VOCbNShMk7wemte
 fa6w==
X-Gm-Message-State: AFuF++kfBJBPyYCPhTrIjr/x5zo0J+el0yDjhHKFuXV+IJ6suef1s1Hf
 I8OcsPIzRuZPBcCCqAaNZwn/qdntb7feB6Jwvk/rHVfXQjIXazQ7gzDDR4XuKiJC/1L+ZTLl5/K
 k4BJT
X-Gm-Gg: AR+sD12d80GGRzLL8H57DXfA3/I5hB+ViejA13bvSSFTTN4dsyHO6CdvT5xUcIQPVgf
 /M+hWxr7djMOb1Fpbh66tTl83h0Sxqp6BzskfVFjWqQ3e+uLWeMrSW9UXXMLlITV1MYtczQcU9F
 D2bDmCxVtwG6R9YdqOvdneNHZegJ9U/lT5QBkMUx3NSh6Z0OIdj/yOSWACTK5PDjkE4CF5bcZSj
 MORc3rbi94Jj4kOIxAOhCX+dITUcUsABpRp0SJq4uQqtfrGY9JcX6p+pi0U9bEnLZEDCdtJemQi
 COJv0EdkmKfTF4yx/60iIhNzaO44/4NMyiHPq4ZecCL6i0HW/+y8K1ElXw0f0zOeW1ckn1/4k5Y
 v5W3B6/3Uei1/kyydCEUYdiRlahnYty2zrBFp+BoGNrRU7pZBbdL285SePhOhQL3IMGNx+RRs56
 xOnmngZY/+V7pTtYMFZQNjn5ynF1aouTfCIXJN+T1C+fpnxFvKRLWcM6vsAtzLpT1D61Xlkuf1o
 iZQAmPoxgxwU7l//Q7J0ZTATks=
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3958127a5aamr19362500a91.13.1787203604466; 
 Wed, 19 Aug 2026 22:26:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 61/61] power: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:51 -0700
Message-ID: <20260820052251.1453273-62-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

