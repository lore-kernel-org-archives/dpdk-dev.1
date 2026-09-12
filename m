Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD5C88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD8240679;
	Sat, 12 Sep 2026 19:04:14 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id E59844067C
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:12 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c4so1002640b3a.2
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232652;
 x=1789837452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oJzuvyFIDuqkiRhRlkh1QAssAqOcSqpT5LMsZ0dsZd8=;
 b=OwUCJx06WFy6OWm3B0En/8uI9ueN9tp8ZoG0grQgym4ql5ZFCxr0pUxS+TGO7/H2dT
 Bby5fDQlLB75p0Wz+HsoAecZAFQ31SYT+CCULc19iivHSMpY10lfnL8oey88G3vNbO4J
 uCC82d6lcv4tRC5NH7FVEA5SysAaNZMMhHWHH2puHc2K5LndhtyMv8Mfk0GU2S59Wt0J
 UP0QPkmBj1Gy+uSk8ESoGTzsJIV3sFQv1EZc5vjXsGB8R8phtWbr00H8R7YbAZHFhXvY
 Kzcr6PfnQOLqfkGxIWxc6kdngdtzX7hsJmlDM9T9sw37eZvBBBsGeSMxW7TR6DFgfpyf
 llrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232652; x=1789837452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oJzuvyFIDuqkiRhRlkh1QAssAqOcSqpT5LMsZ0dsZd8=;
 b=AD5ZU2xXw8T8jJyXB48umUY/FkNU+fevEMx61IJ20ZmPRSwyi2m+pm4tfm2/1/ejJe
 cOWQ75uLA45nEAFy1BvVPGVrI53wrUVFU9sWfw0lch4UQgsij/MylWgIx2wofntDoUDk
 Dxb75afTOQgmOtJAgE9d9gP+VmvHteoNdZbxkUQDWN5jg3nhdxBpaVW0JVFaFcw/HKCH
 blUtV0RfJ31M2Y7FXOp6N+FAbX17ZcP31pk7c37HFKz8X9Z4zGfow47aJsV+eHu3twQV
 +vDyudhxN/KewG8XkTDIorCrg8DIalUsmzbxBI+08O74RsNUAerhQ2TSfjN+pCPQTg2j
 8E8w==
X-Gm-Message-State: AFuF++nOMqBzDZonFcLqyA3H+S7W5mlmqMEYX5ifC+UP1a8YU3INd9GY
 H2NarRbfBJOLEXW5NO4N7zxHc5NSV/OxiEK2a4x+x3dMc/wK90fOrBO0e2xt20IuB3ioCA+uhDy
 DJTMob5Y=
X-Gm-Gg: AYBFou3SmNUNUSBO8pgRspz3z+IXO1kMkpN4mCfjdvEiDlOtHaASwrYJUQKiPs0B3h/
 oO2NDfCuMSvozw6yU0zboSX1jcu70VC4hxBUyU+3vJZiRIQJSNdE1tutbJP+tmhljwfRrPC+A5k
 V7I6S1HCUd5w0j9cNaWmmJ+lKc1hF0QJAZBe75FSBVKxVZE/G4Ylcqr6+XJtjstFXx6OHg6IcDb
 iCSf42sqINse1srttdc8z06fykBQYy6Rbc7sT74kXHXNIIU+RNZHZzQ+GA03RInLj9lmeLo0fdg
 rEatW94OcHWlHOPhxLA/2EghL6cLS0ZsgE9/uhe+GHrRRhTZ16bf4JapmfvyV0sCdkBZkjWKoR4
 bCNORDZICbRjVswIE9p4sCrD/Hiv6WNBscghPXA34Dts4LECtQijybi55gSRzSWI+I6wiY2R1bt
 9Yp5Njo2Z3+Gyqn9Dvr5Q2ctMSlQpzKEKBCfW1g6bVLet8MchMh1tGZh8PLQnuyzbCW53+Nl/YW
 DsLMY0t0WODSN23nAQohXqUjS/x2a65erq5Qg==
X-Received: by 2002:a05:6a21:694:b0:3d7:7b6d:4997 with SMTP id
 adf61e73a8af0-3daed4225efmr18611656637.27.1789232651872; 
 Sat, 12 Sep 2026 10:04:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v2 5/9] power: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:17 -0700
Message-ID: <20260912170338.486978-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

The power library and its backends open a sysfs file, read one value
from it, and close it again in many places. Where the file is only
read once, use the EAL routines instead.

Add power_sysfs_read_u32() as a thin wrapper so the backends keep
reading into a uint32_t. It rejects a value that does not fit rather
than truncating it, which the open coded fscanf("%u") could not.

The files that are held open for the lifetime of the device, the
"rw+" handles used to repeatedly read and write the scaling
frequency, are left alone: they are not a single read, and closing
and reopening them on every frequency change would be a behaviour
change on a hot path.

This also removes a few cases where the FILE pointer was left
uninitialised and then tested against NULL in the cleanup path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/power/acpi/acpi_cpufreq.c             | 21 ++--
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 63 ++----------
 drivers/power/cppc/cppc_cpufreq.c             | 69 ++-----------
 .../power/intel_pstate/intel_pstate_cpufreq.c | 99 +++----------------
 drivers/power/intel_uncore/intel_uncore.c     | 32 ++----
 lib/power/power_common.c                      | 52 +++++-----
 lib/power/power_common.h                      |  6 ++
 lib/power/rte_power_qos.c                     | 29 +-----
 8 files changed, 87 insertions(+), 284 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index af85a8cdec..84e33375d0 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -9,6 +9,7 @@
 #include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 
 #include "acpi_cpufreq.h"
 #include "power_common.h"
@@ -111,21 +112,14 @@ power_set_governor_original(struct acpi_power_info *pi)
 static int
 power_get_available_freqs(struct acpi_power_info *pi)
 {
-	FILE *f;
+	char *freqs[RTE_MAX_LCORE_FREQS];
 	int ret = -1, i, count;
-	char *p;
 	char buf[BUFSIZ];
-	char *freqs[RTE_MAX_LCORE_FREQS];
-
-	open_core_sysfs_file(&f, "r", POWER_SYSFILE_AVAIL_FREQ, pi->lcore_id);
-	if (f == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_AVAIL_FREQ);
-		goto out;
-	}
+	char *p;
 
-	ret = read_core_sysfs_s(f, buf, sizeof(buf));
-	if ((ret) < 0) {
+	ret = rte_sysfs_parse_string(buf, sizeof(buf), POWER_SYSFILE_AVAIL_FREQ,
+			pi->lcore_id);
+	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_AVAIL_FREQ);
 		goto out;
@@ -169,9 +163,6 @@ power_get_available_freqs(struct acpi_power_info *pi)
 	POWER_DEBUG_LOG("%d frequency(s) of lcore %u are available",
 			count, pi->lcore_id);
 out:
-	if (f != NULL)
-		fclose(f);
-
 	return ret;
 }
 
diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index af9c1309f3..1d9d4cb495 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -103,34 +103,19 @@ power_set_governor_userspace(struct amd_pstate_power_info *pi)
 static int
 power_check_turbo(struct amd_pstate_power_info *pi)
 {
-	FILE *f_nom = NULL, *f_max = NULL;
 	int ret = -1;
 	uint32_t nominal_perf = 0, highest_perf = 0;
 
-	open_core_sysfs_file(&f_max, "r", POWER_SYSFILE_HIGHEST_PERF,
+	ret = power_sysfs_read_u32(&highest_perf, POWER_SYSFILE_HIGHEST_PERF,
 			pi->lcore_id);
-	if (f_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_HIGHEST_PERF);
-		goto err;
-	}
-
-	open_core_sysfs_file(&f_nom, "r", POWER_SYSFILE_NOMINAL_PERF,
-			pi->lcore_id);
-	if (f_nom == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_NOMINAL_PERF);
-		goto err;
-	}
-
-	ret = read_core_sysfs_u32(f_max, &highest_perf);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_HIGHEST_PERF);
 		goto err;
 	}
 
-	ret = read_core_sysfs_u32(f_nom, &nominal_perf);
+	ret = power_sysfs_read_u32(&nominal_perf, POWER_SYSFILE_NOMINAL_PERF,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_NOMINAL_PERF);
@@ -156,10 +141,6 @@ power_check_turbo(struct amd_pstate_power_info *pi)
 	}
 
 err:
-	if (f_max != NULL)
-		fclose(f_max);
-	if (f_nom != NULL)
-		fclose(f_nom);
 
 	return ret;
 }
@@ -171,52 +152,30 @@ power_check_turbo(struct amd_pstate_power_info *pi)
 static int
 power_get_available_freqs(struct amd_pstate_power_info *pi)
 {
-	FILE *f_min = NULL, *f_max = NULL, *f_nom = NULL;
 	int ret = -1, nominal_idx = -1;
 	uint32_t scaling_min_freq = 0, scaling_max_freq = 0;
 	uint32_t i, num_freqs = RTE_MAX_LCORE_FREQS;
 	uint32_t nominal_freq = 0, scaling_freq = 0;
 	uint32_t freq_calc = 0;
 
-	open_core_sysfs_file(&f_max, "r", POWER_SYSFILE_SCALING_MAX_FREQ,
+	ret = power_sysfs_read_u32(&scaling_max_freq, POWER_SYSFILE_SCALING_MAX_FREQ,
 			pi->lcore_id);
-	if (f_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_SCALING_MAX_FREQ);
-		goto out;
-	}
-
-	open_core_sysfs_file(&f_min, "r", POWER_SYSFILE_SCALING_MIN_FREQ,
-			pi->lcore_id);
-	if (f_min == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_SCALING_MIN_FREQ);
-		goto out;
-	}
-
-	open_core_sysfs_file(&f_nom, "r", POWER_SYSFILE_NOMINAL_FREQ,
-			pi->lcore_id);
-	if (f_nom == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_NOMINAL_FREQ);
-		goto out;
-	}
-
-	ret = read_core_sysfs_u32(f_max, &scaling_max_freq);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_SCALING_MAX_FREQ);
 		goto out;
 	}
 
-	ret = read_core_sysfs_u32(f_min, &scaling_min_freq);
+	ret = power_sysfs_read_u32(&scaling_min_freq, POWER_SYSFILE_SCALING_MIN_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_SCALING_MIN_FREQ);
 		goto out;
 	}
 
-	ret = read_core_sysfs_u32(f_nom, &nominal_freq);
+	ret = power_sysfs_read_u32(&nominal_freq, POWER_SYSFILE_NOMINAL_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_NOMINAL_FREQ);
@@ -272,12 +231,6 @@ power_get_available_freqs(struct amd_pstate_power_info *pi)
 			num_freqs, pi->lcore_id);
 
 out:
-	if (f_min != NULL)
-		fclose(f_min);
-	if (f_max != NULL)
-		fclose(f_max);
-	if (f_nom != NULL)
-		fclose(f_nom);
 
 	return ret;
 }
diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index aed44c1212..a25dc7eaf1 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -106,49 +106,27 @@ power_set_governor_userspace(struct cppc_power_info *pi)
 static int
 power_check_turbo(struct cppc_power_info *pi)
 {
-	FILE *f_nom = NULL, *f_max = NULL, *f_cmax = NULL;
-	int ret = -1;
 	uint32_t nominal_perf = 0, highest_perf = 0, cpuinfo_max_freq = 0;
+	int ret = -1;
 
-	open_core_sysfs_file(&f_max, "r", POWER_SYSFILE_HIGHEST_PERF,
-			pi->lcore_id);
-	if (f_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_HIGHEST_PERF);
-		goto err;
-	}
-
-	open_core_sysfs_file(&f_nom, "r", POWER_SYSFILE_NOMINAL_PERF,
-			pi->lcore_id);
-	if (f_nom == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_NOMINAL_PERF);
-		goto err;
-	}
-
-	open_core_sysfs_file(&f_cmax, "r", POWER_SYSFILE_SYS_MAX,
+	ret = power_sysfs_read_u32(&highest_perf, POWER_SYSFILE_HIGHEST_PERF,
 			pi->lcore_id);
-	if (f_cmax == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_SYS_MAX);
-		goto err;
-	}
-
-	ret = read_core_sysfs_u32(f_max, &highest_perf);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_HIGHEST_PERF);
 		goto err;
 	}
 
-	ret = read_core_sysfs_u32(f_nom, &nominal_perf);
+	ret = power_sysfs_read_u32(&nominal_perf, POWER_SYSFILE_NOMINAL_PERF,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_NOMINAL_PERF);
 		goto err;
 	}
 
-	ret = read_core_sysfs_u32(f_cmax, &cpuinfo_max_freq);
+	ret = power_sysfs_read_u32(&cpuinfo_max_freq, POWER_SYSFILE_SYS_MAX,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_SYS_MAX);
@@ -175,13 +153,6 @@ power_check_turbo(struct cppc_power_info *pi)
 	}
 
 err:
-	if (f_max != NULL)
-		fclose(f_max);
-	if (f_nom != NULL)
-		fclose(f_nom);
-	if (f_cmax != NULL)
-		fclose(f_cmax);
-
 	return ret;
 }
 
@@ -192,35 +163,20 @@ power_check_turbo(struct cppc_power_info *pi)
 static int
 power_get_available_freqs(struct cppc_power_info *pi)
 {
-	FILE *f_min = NULL, *f_max = NULL;
-	int ret = -1;
 	uint32_t scaling_min_freq = 0, scaling_max_freq = 0, nominal_perf = 0;
 	uint32_t i, num_freqs = 0;
+	int ret = -1;
 
-	open_core_sysfs_file(&f_max, "r", POWER_SYSFILE_SCALING_MAX_FREQ,
-			pi->lcore_id);
-	if (f_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_SCALING_MAX_FREQ);
-		goto out;
-	}
-
-	open_core_sysfs_file(&f_min, "r", POWER_SYSFILE_SCALING_MIN_FREQ,
+	ret = power_sysfs_read_u32(&scaling_max_freq, POWER_SYSFILE_SCALING_MAX_FREQ,
 			pi->lcore_id);
-	if (f_min == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_SCALING_MIN_FREQ);
-		goto out;
-	}
-
-	ret = read_core_sysfs_u32(f_max, &scaling_max_freq);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_SCALING_MAX_FREQ);
 		goto out;
 	}
 
-	ret = read_core_sysfs_u32(f_min, &scaling_min_freq);
+	ret = power_sysfs_read_u32(&scaling_min_freq, POWER_SYSFILE_SCALING_MIN_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_SCALING_MIN_FREQ);
@@ -260,11 +216,6 @@ power_get_available_freqs(struct cppc_power_info *pi)
 			num_freqs, pi->lcore_id);
 
 out:
-	if (f_min != NULL)
-		fclose(f_min);
-	if (f_max != NULL)
-		fclose(f_max);
-
 	return ret;
 }
 
diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index dfbb5635a1..c8d0ed2c21 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -108,29 +108,12 @@ out:	close(fd);
 static int
 power_init_for_setting_freq(struct pstate_power_info *pi)
 {
-	FILE *f_base = NULL, *f_base_min = NULL, *f_base_max = NULL,
-	     *f_min = NULL, *f_max = NULL;
+	FILE *f_min = NULL, *f_max = NULL;
 	uint32_t base_ratio, base_min_ratio, base_max_ratio;
 	uint64_t max_non_turbo = 0;
 	int ret;
 
-	/* open all files we expect to have open */
-	open_core_sysfs_file(&f_base_max, "r", POWER_SYSFILE_BASE_MAX_FREQ,
-			pi->lcore_id);
-	if (f_base_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_BASE_MAX_FREQ);
-		goto err;
-	}
-
-	open_core_sysfs_file(&f_base_min, "r", POWER_SYSFILE_BASE_MIN_FREQ,
-			pi->lcore_id);
-	if (f_base_min == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_BASE_MIN_FREQ);
-		goto err;
-	}
-
+	/* open the files that are kept open for setting the frequency */
 	open_core_sysfs_file(&f_min, "rw+", POWER_SYSFILE_MIN_FREQ,
 			pi->lcore_id);
 	if (f_min == NULL) {
@@ -147,12 +130,9 @@ power_init_for_setting_freq(struct pstate_power_info *pi)
 		goto err;
 	}
 
-	open_core_sysfs_file(&f_base, "r", POWER_SYSFILE_BASE_FREQ,
-			pi->lcore_id);
-	/* base ratio file may not exist in some kernels, so no error check */
-
 	/* read base max ratio */
-	ret = read_core_sysfs_u32(f_base_max, &base_max_ratio);
+	ret = power_sysfs_read_u32(&base_max_ratio, POWER_SYSFILE_BASE_MAX_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_BASE_MAX_FREQ);
@@ -160,24 +140,18 @@ power_init_for_setting_freq(struct pstate_power_info *pi)
 	}
 
 	/* read base min ratio */
-	ret = read_core_sysfs_u32(f_base_min, &base_min_ratio);
+	ret = power_sysfs_read_u32(&base_min_ratio, POWER_SYSFILE_BASE_MIN_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_BASE_MIN_FREQ);
 		goto err;
 	}
 
-	/* base ratio may not exist */
-	if (f_base != NULL) {
-		ret = read_core_sysfs_u32(f_base, &base_ratio);
-		if (ret < 0) {
-			POWER_LOG(ERR, "Failed to read %s",
-					POWER_SYSFILE_BASE_FREQ);
-			goto err;
-		}
-	} else {
+	/* base ratio file may not exist in some kernels, so no error check */
+	if (power_sysfs_read_u32(&base_ratio, POWER_SYSFILE_BASE_FREQ,
+			pi->lcore_id) < 0)
 		base_ratio = 0;
-	}
 
 	/* convert ratios to bins */
 	base_max_ratio /= BUS_FREQ;
@@ -222,20 +196,10 @@ power_init_for_setting_freq(struct pstate_power_info *pi)
 	pi->core_base_freq = base_ratio * BUS_FREQ;
 
 out:
-	if (f_base != NULL)
-		fclose(f_base);
-	fclose(f_base_max);
-	fclose(f_base_min);
 	/* f_min and f_max are stored, no need to close */
 	return 0;
 
 err:
-	if (f_base != NULL)
-		fclose(f_base);
-	if (f_base_min != NULL)
-		fclose(f_base_min);
-	if (f_base_max != NULL)
-		fclose(f_base_max);
 	if (f_min != NULL)
 		fclose(f_min);
 	if (f_max != NULL)
@@ -366,38 +330,22 @@ power_set_governor_original(struct pstate_power_info *pi)
 static int
 power_get_available_freqs(struct pstate_power_info *pi)
 {
-	FILE *f_min = NULL, *f_max = NULL;
-	int ret = -1;
 	uint32_t sys_min_freq = 0, sys_max_freq = 0, base_max_freq = 0;
 	int config_min_freq, config_max_freq;
 	uint32_t i, num_freqs = 0;
-
-	/* open all files */
-	open_core_sysfs_file(&f_max, "r", POWER_SYSFILE_BASE_MAX_FREQ,
-			pi->lcore_id);
-	if (f_max == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_BASE_MAX_FREQ);
-		goto out;
-	}
-
-	open_core_sysfs_file(&f_min, "r", POWER_SYSFILE_BASE_MIN_FREQ,
-			pi->lcore_id);
-	if (f_min == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_BASE_MIN_FREQ);
-		goto out;
-	}
+	int ret = -1;
 
 	/* read base ratios */
-	ret = read_core_sysfs_u32(f_max, &sys_max_freq);
+	ret = power_sysfs_read_u32(&sys_max_freq, POWER_SYSFILE_BASE_MAX_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_BASE_MAX_FREQ);
 		goto out;
 	}
 
-	ret = read_core_sysfs_u32(f_min, &sys_min_freq);
+	ret = power_sysfs_read_u32(&sys_min_freq, POWER_SYSFILE_BASE_MIN_FREQ,
+			pi->lcore_id);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_BASE_MIN_FREQ);
@@ -467,31 +415,18 @@ power_get_available_freqs(struct pstate_power_info *pi)
 			num_freqs, pi->lcore_id);
 
 out:
-	if (f_min != NULL)
-		fclose(f_min);
-	if (f_max != NULL)
-		fclose(f_max);
-
 	return ret;
 }
 
 static int
 power_get_cur_idx(struct pstate_power_info *pi)
 {
-	FILE *f_cur;
-	int ret = -1;
 	uint32_t sys_cur_freq = 0;
 	unsigned int i;
+	int ret = -1;
 
-	open_core_sysfs_file(&f_cur, "r", POWER_SYSFILE_CUR_FREQ,
+	ret = power_sysfs_read_u32(&sys_cur_freq, POWER_SYSFILE_CUR_FREQ,
 			pi->lcore_id);
-	if (f_cur == NULL) {
-		POWER_LOG(ERR, "failed to open %s",
-				POWER_SYSFILE_CUR_FREQ);
-		goto fail;
-	}
-
-	ret = read_core_sysfs_u32(f_cur, &sys_cur_freq);
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
 				POWER_SYSFILE_CUR_FREQ);
@@ -517,8 +452,6 @@ power_get_cur_idx(struct pstate_power_info *pi)
 
 	ret = 0;
 fail:
-	if (f_cur != NULL)
-		fclose(f_cur);
 	return ret;
 }
 
diff --git a/drivers/power/intel_uncore/intel_uncore.c b/drivers/power/intel_uncore/intel_uncore.c
index 6759ea1445..0e758312cf 100644
--- a/drivers/power/intel_uncore/intel_uncore.c
+++ b/drivers/power/intel_uncore/intel_uncore.c
@@ -111,20 +111,14 @@ set_uncore_freq_internal(struct uncore_power_info *ui, uint32_t idx)
 static int
 power_init_for_setting_uncore_freq(struct uncore_power_info *ui)
 {
-	FILE *f_base_min = NULL, *f_base_max = NULL, *f_min = NULL, *f_max = NULL;
+	FILE *f_min = NULL, *f_max = NULL;
 	uint32_t base_min_freq = 0, base_max_freq = 0, min_freq = 0, max_freq = 0;
 	int ret;
 
 	/* open and read all uncore sys files */
 	/* Base max */
-	open_core_sysfs_file(&f_base_max, "r", POWER_INTEL_UNCORE_SYSFILE_BASE_MAX_FREQ,
+	ret = power_sysfs_read_u32(&base_max_freq, POWER_INTEL_UNCORE_SYSFILE_BASE_MAX_FREQ,
 			ui->pkg, ui->die);
-	if (f_base_max == NULL) {
-		POWER_LOG(DEBUG, "failed to open %s",
-				POWER_INTEL_UNCORE_SYSFILE_BASE_MAX_FREQ);
-		goto err;
-	}
-	ret = read_core_sysfs_u32(f_base_max, &base_max_freq);
 	if (ret < 0) {
 		POWER_LOG(DEBUG, "Failed to read %s",
 				POWER_INTEL_UNCORE_SYSFILE_BASE_MAX_FREQ);
@@ -132,21 +126,13 @@ power_init_for_setting_uncore_freq(struct uncore_power_info *ui)
 	}
 
 	/* Base min */
-	open_core_sysfs_file(&f_base_min, "r", POWER_INTEL_UNCORE_SYSFILE_BASE_MIN_FREQ,
-		ui->pkg, ui->die);
-	if (f_base_min == NULL) {
-		POWER_LOG(DEBUG, "failed to open %s",
+	ret = power_sysfs_read_u32(&base_min_freq, POWER_INTEL_UNCORE_SYSFILE_BASE_MIN_FREQ,
+			ui->pkg, ui->die);
+	if (ret < 0) {
+		POWER_LOG(DEBUG, "Failed to read %s",
 				POWER_INTEL_UNCORE_SYSFILE_BASE_MIN_FREQ);
 		goto err;
 	}
-	if (f_base_min != NULL) {
-		ret = read_core_sysfs_u32(f_base_min, &base_min_freq);
-		if (ret < 0) {
-			POWER_LOG(DEBUG, "Failed to read %s",
-					POWER_INTEL_UNCORE_SYSFILE_BASE_MIN_FREQ);
-			goto err;
-		}
-	}
 
 	/* Curr min */
 	open_core_sysfs_file(&f_min, "rw+", POWER_INTEL_UNCORE_SYSFILE_MIN_FREQ,
@@ -191,17 +177,11 @@ power_init_for_setting_uncore_freq(struct uncore_power_info *ui)
 	ui->init_max_freq = base_max_freq;
 	ui->init_min_freq = base_min_freq;
 
-	fclose(f_base_min);
-	fclose(f_base_max);
 	/* f_min and f_max are stored, no need to close */
 
 	return 0;
 
 err:
-	if (f_base_min != NULL)
-		fclose(f_base_min);
-	if (f_base_max != NULL)
-		fclose(f_base_max);
 	if (f_min != NULL)
 		fclose(f_min);
 	if (f_max != NULL)
diff --git a/lib/power/power_common.c b/lib/power/power_common.c
index da22a4d160..f583975152 100644
--- a/lib/power/power_common.c
+++ b/lib/power/power_common.c
@@ -3,14 +3,17 @@
  */
 
 #include <limits.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdarg.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
 #include <rte_lcore.h>
+#include <rte_sysfs.h>
 
 #include "power_common.h"
 
@@ -28,34 +31,16 @@ cpufreq_check_scaling_driver(const char *driver_name)
 {
 	unsigned int lcore_id = 0; /* always check core 0 */
 	char readbuf[PATH_MAX];
-	size_t end_idx;
-	char *s;
-	FILE *f;
 
 	/*
 	 * Check if scaling driver matches what we expect.
+	 * If there is no driver at all, or it can't be read,
+	 * consider the system unsupported.
 	 */
-	open_core_sysfs_file(&f, "r", POWER_SYSFILE_SCALING_DRIVER,
-			lcore_id);
-	/* if there's no driver at all, bail out */
-	if (f == NULL)
-		return 0;
-
-	s = fgets(readbuf, sizeof(readbuf), f);
-	/* don't need it any more */
-	fclose(f);
-
-	/* if we can't read it, consider unsupported */
-	if (s == NULL)
+	if (rte_sysfs_parse_string(readbuf, sizeof(readbuf),
+			POWER_SYSFILE_SCALING_DRIVER, lcore_id) < 0)
 		return 0;
 
-	/* when read from sysfs, driver name has an extra newline at the end */
-	end_idx = strnlen(readbuf, sizeof(readbuf));
-	if (end_idx > 0 && readbuf[end_idx - 1] == '\n') {
-		end_idx--;
-		readbuf[end_idx] = '\0';
-	}
-
 	/* does the driver name match? */
 	if (strncmp(readbuf, driver_name, sizeof(readbuf)) != 0)
 		return 0;
@@ -87,6 +72,29 @@ open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(power_sysfs_read_u32)
+int
+power_sysfs_read_u32(uint32_t *val, const char *format, ...)
+{
+	unsigned long tmp;
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret = rte_sysfs_vparse_uint(&tmp, format, ap);
+	va_end(ap);
+	if (ret < 0)
+		return -1;
+
+	if (tmp > UINT32_MAX) {
+		POWER_LOG(ERR, "sysfs value does not fit in 32 bits");
+		return -1;
+	}
+
+	*val = tmp;
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_u32)
 int
 read_core_sysfs_u32(FILE *f, uint32_t *val)
diff --git a/lib/power/power_common.h b/lib/power/power_common.h
index 370c5246c6..6ca91658cd 100644
--- a/lib/power/power_common.h
+++ b/lib/power/power_common.h
@@ -8,6 +8,7 @@
 #include <rte_common.h>
 #include <rte_compat.h>
 #include <rte_log.h>
+#include <stdint.h>
 
 #define RTE_POWER_INVALID_FREQ_INDEX (~0)
 
@@ -48,6 +49,11 @@ int open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 __rte_internal
 int read_core_sysfs_u32(FILE *f, uint32_t *val);
 
+/* read a 32 bit value from a sysfs file given by a printf style path */
+__rte_internal
+int power_sysfs_read_u32(uint32_t *val, const char *format, ...)
+		__rte_format_printf(2, 3);
+
 __rte_internal
 int read_core_sysfs_s(FILE *f, char *buf, unsigned int len);
 
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index d8d8d36a76..dd1b8f7384 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -9,6 +9,7 @@
 #include <eal_export.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
+#include <rte_sysfs.h>
 
 #include "power_common.h"
 #include "rte_power_qos.h"
@@ -24,7 +25,6 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 {
 	char buf[PM_QOS_CPU_RESUME_LATENCY_BUF_LEN];
 	uint32_t cpu_id;
-	FILE *f;
 	int ret;
 
 	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -EINVAL);
@@ -37,13 +37,6 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 		return -EINVAL;
 	}
 
-	ret = open_core_sysfs_file(&f, "w", PM_QOS_SYSFILE_RESUME_LATENCY_US, cpu_id);
-	if (ret != 0) {
-		POWER_LOG(ERR, "Failed to open "PM_QOS_SYSFILE_RESUME_LATENCY_US" : %s",
-			  cpu_id, strerror(errno));
-		return ret;
-	}
-
 	/*
 	 * Based on the sysfs interface pm_qos_resume_latency_us under
 	 * @PM_QOS_SYSFILE_RESUME_LATENCY_US directory in kernel, their meaning
@@ -59,13 +52,11 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 	else
 		snprintf(buf, sizeof(buf), "%u", latency);
 
-	ret = write_core_sysfs_s(f, buf);
+	ret = rte_sysfs_write_string(buf, PM_QOS_SYSFILE_RESUME_LATENCY_US, cpu_id);
 	if (ret != 0)
 		POWER_LOG(ERR, "Failed to write "PM_QOS_SYSFILE_RESUME_LATENCY_US" : %s",
 			  cpu_id, strerror(errno));
 
-	fclose(f);
-
 	return ret;
 }
 
@@ -76,7 +67,6 @@ rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 	char buf[PM_QOS_CPU_RESUME_LATENCY_BUF_LEN];
 	int latency = -1;
 	uint32_t cpu_id;
-	FILE *f;
 	int ret;
 
 	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -EINVAL);
@@ -84,18 +74,12 @@ rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 	if (ret != 0)
 		return ret;
 
-	ret = open_core_sysfs_file(&f, "r", PM_QOS_SYSFILE_RESUME_LATENCY_US, cpu_id);
-	if (ret != 0) {
-		POWER_LOG(ERR, "Failed to open "PM_QOS_SYSFILE_RESUME_LATENCY_US" : %s",
-			  cpu_id, strerror(errno));
-		return ret;
-	}
-
-	ret = read_core_sysfs_s(f, buf, sizeof(buf));
+	ret = rte_sysfs_parse_string(buf, sizeof(buf), PM_QOS_SYSFILE_RESUME_LATENCY_US,
+			cpu_id);
 	if (ret != 0) {
 		POWER_LOG(ERR, "Failed to read "PM_QOS_SYSFILE_RESUME_LATENCY_US" : %s",
 			  cpu_id, strerror(errno));
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -113,8 +97,5 @@ rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 		latency = latency == 0 ? RTE_POWER_QOS_RESUME_LATENCY_NO_CONSTRAINT : latency;
 	}
 
-out:
-	fclose(f);
-
 	return latency != -1 ? latency : ret;
 }
-- 
2.53.0

