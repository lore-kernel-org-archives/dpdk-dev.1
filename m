Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7F10F3DF2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 19:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7357402E7;
	Sat, 28 Mar 2026 20:34:34 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1B308400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 20:34:31 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so1694448b3a.1
 for <dev@dpdk.org>; Sat, 28 Mar 2026 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774726470;
 x=1775331270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uz/gw2m+C9lJoozT/l0grK8hnlFBhnAjKY9Ng8BBPhA=;
 b=sTnzwIlzjpJWRfnfxzlakefn/SjZeS7ReGm94+DagPEmZHK8bMdxBh5Wk2CP4V+Axg
 WJGS07NufGOyyq8mREc6YfRLK8yExw5Fy0axQD5CX5bZWj9wKctxZsJF9nlwPC74+7WX
 VBeNwHkJ9VzWxhnUzbuZQ0gz2FmKN/5aGeAnI7rHtpZ8kfrpe+LHAGLHUAv0UFymwR5M
 +lJRIkZUpmHMzljXOmb7b1M66gb7dgInfkb4l9n6VYWqoBhSMOcGMPfH8fxVaxBeQcL/
 Kuh5zx6N+8QRruJv4hfuNz8Nx4zD0FCS7tIRHq1VIVo4pdDZcqhqp7ApV0TrFz91tixE
 /v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774726470; x=1775331270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz/gw2m+C9lJoozT/l0grK8hnlFBhnAjKY9Ng8BBPhA=;
 b=OKVmOGPAMX5P0SMBXLnph3jGNugc9ZMujduQ75Qv+CXR4/Vx4vrV1owop1mnGl/U+2
 uTg1s6xvpsGi1kINPhpCq2ZORli1mnnwCkToAeuosxF+rlfb+/1apUBgEwmnWC0jdINF
 uXOPHL17Bx0os8mHwhxamZSSxnI2uQddhv9XFInvB0l4b88t5YPoErhzUZe9R1Kgci+B
 4zji7/eFgXOoMWW1Ct7Sm/4sCZn57LmFCIqu0soUqU7KWZUzMxkONZx/zkXHbhIR0oKD
 +76Y97he/cysHDrc06bdHhdlMgP3/OTiTXmbqtLcijwRkBdMeUwmUnoGgS3SNCpKRTld
 MkuA==
X-Gm-Message-State: AOJu0Yxt1wf5/4ZgC/TfZ+HPuP3uqVYABdB55ID5JchhoeELmp86Lq/E
 x8e8UMwDO20tV6MaJGBkC5Ld8mMUtLa1vpO5aDMDeNHvhzT3uIQf5o18Zmbp9LpmA2tlaaN+KIe
 iTDXP
X-Gm-Gg: ATEYQzyEBgyYnlbfSGcz6bYGItLS0l0daqob4DlopCMHGm4za2gofrS1azPZoFHBRnS
 3cXYXdKiYjz0ETr9kEbdhzj/y+ycVDC4L9fh818waNvIB9Q2vPyzk1+bjvC6o5NXYQ3WY7go++x
 WVRigGPIIYtDmuw2DyGyonD3T65j6EijsZ8HHkWOG/QJxMlYTmt6syzouQOcTgXP6anHrXkB3wt
 4uG3QmWorXX7Ge0aVVMPz2S4tZ9veJva0yefh/uqDdKpKR2uUelg4GvMpJBIVghc62m5S4/kMyU
 jT0/BrAWEdm4YjBfXgsQQG1UG0ejvFXD2mbvFF2YRMoifpg5QJM0a06hfowsFDa0VZxgUQIgl5d
 ghWjKZU7ijLxVKRZm+vgwOnjgf8IgGpBMUhGOSxbZBlfdaKbc+6k6cDkFqOYDUgkVD2UeYPOCb5
 fuV7pqlMbTkrCR6y0xILqa5HuBQHlkJ+dp
X-Received: by 2002:a05:6a20:938c:b0:389:8f3f:50ce with SMTP id
 adf61e73a8af0-39c87b5fb6fmr7577870637.56.1774726470109; 
 Sat, 28 Mar 2026 12:34:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca85fc756sm2465761b3a.47.2026.03.28.12.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 12:34:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH] power/amd_pstate: fix frequency matching for continuous
 scaling
Date: Sat, 28 Mar 2026 12:34:19 -0700
Message-ID: <20260328193419.106100-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The power_init_for_setting_freq() function fails on systems using the
amd-pstate-epp driver because the current CPU frequency read from
scaling_setspeed does not exactly match any of the synthesized
frequency buckets. Unlike acpi_cpufreq which provides a discrete list
of frequencies, amd-pstate operates with continuously variable
frequencies, so an exact match will rarely succeed.

For example, on a Ryzen 9 7945HX the sysfs file reports 2797172
which rounds to 2797000, but this value does not appear in the
generated frequency table.

Replace the exact match lookup with a nearest-frequency search.

Also fix several issues in the same function:
 - strtoul() was called with NULL endptr, making parse failures
   undetectable
 - errno was not checked, so stale errors could cause false positives
 - freq was declared as uint32_t, truncating the unsigned long
   return value of strtoul() on LP64 platforms
 - no error was logged when frequency matching failed

Bugzilla ID: 1915
Fixes: 1ed04d33cf19 ("power: support amd-pstate cpufreq driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 56 ++++++++++++++-----
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index 95495bff7d..14625ffd73 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -5,6 +5,7 @@
  */
 
 #include <stdlib.h>
+#include <errno.h>
 
 #include <rte_memcpy.h>
 #include <rte_stdatomic.h>
@@ -291,15 +292,21 @@ power_get_available_freqs(struct amd_pstate_power_info *pi)
 	return ret;
 }
 
-/**
- * It is to fopen the sys file for the future setting the lcore frequency.
- */
+static inline unsigned long
+abs_diff(unsigned long a, unsigned long b)
+{
+	return (a > b) ? a - b : b - a;
+}
+
 static int
 power_init_for_setting_freq(struct amd_pstate_power_info *pi)
 {
-	FILE *f = NULL;
+	FILE *f;
 	char buf[BUFSIZ];
-	uint32_t i, freq;
+	char *endptr;
+	unsigned long freq, freq_conv;
+	unsigned long best_diff, diff;
+	uint32_t i, best_idx;
 	int ret;
 
 	open_core_sysfs_file(&f, "rw+", POWER_SYSFILE_SETSPEED, pi->lcore_id);
@@ -308,7 +315,6 @@ power_init_for_setting_freq(struct amd_pstate_power_info *pi)
 				POWER_SYSFILE_SETSPEED);
 		goto err;
 	}
-
 	ret = read_core_sysfs_s(f, buf, sizeof(buf));
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
@@ -316,25 +322,45 @@ power_init_for_setting_freq(struct amd_pstate_power_info *pi)
 		goto err;
 	}
 
-	freq = strtoul(buf, NULL, POWER_CONVERT_TO_DECIMAL);
+	errno = 0;
+	freq = strtoul(buf, &endptr, POWER_CONVERT_TO_DECIMAL);
+	if (errno != 0 || endptr == buf || freq == 0) {
+		POWER_LOG(ERR, "Failed to parse frequency '%s' for lcore %u",
+				buf, pi->lcore_id);
+		goto err;
+	}
 
 	/* convert the frequency to nearest 1000 value
 	 * Ex: if freq=1396789 then freq_conv=1397000
 	 * Ex: if freq=800030 then freq_conv=800000
 	 */
-	unsigned int freq_conv = 0;
-	freq_conv = (freq + FREQ_ROUNDING_DELTA)
-				/ ROUND_FREQ_TO_N_1000;
+	freq_conv = (freq + FREQ_ROUNDING_DELTA) / ROUND_FREQ_TO_N_1000;
 	freq_conv = freq_conv * ROUND_FREQ_TO_N_1000;
 
-	for (i = 0; i < pi->nb_freqs; i++) {
-		if (freq_conv == pi->freqs[i]) {
-			pi->curr_idx = i;
-			pi->f = f;
-			return 0;
+	/* Find the nearest frequency in the table.
+	 * With amd-pstate the CPU runs at continuously variable
+	 * frequencies so the current frequency will not exactly
+	 * match one of the synthesized frequency buckets.
+	 */
+	best_idx = 0;
+	best_diff = abs_diff(freq_conv, pi->freqs[0]);
+
+	for (i = 1; i < pi->nb_freqs; i++) {
+		diff = abs_diff(freq_conv, pi->freqs[i]);
+		if (diff < best_diff) {
+			best_diff = diff;
+			best_idx = i;
 		}
 	}
 
+	POWER_DEBUG_LOG("Freq %lu rounded to %lu matched bucket [%u] = %u "
+			"for lcore %u", freq, freq_conv, best_idx,
+			pi->freqs[best_idx], pi->lcore_id);
+
+	pi->curr_idx = best_idx;
+	pi->f = f;
+	return 0;
+
 err:
 	if (f != NULL)
 		fclose(f);
-- 
2.53.0

