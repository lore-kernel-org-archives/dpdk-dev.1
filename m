Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED4C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93FBD410D2;
	Tue,  8 Sep 2026 18:55:01 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 17212410CF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:55:00 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso3969615b3a.1
 for <dev@dpdk.org>; Tue, 08 Sep 2026 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788886499;
 x=1789491299; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8wNNxhf78DFPkHI8dBadYfr8qLCJ7YNn5xf4kGgofo=;
 b=OkgqmTAkqSWpecIuKgmDNFQ5ciCM5WR1BU5ZXf06/p2PXTeCbbO3DtOf62R2piJbuq
 V2qA4MU++GPYEvIhmlPAU1omEvLB3Bm9tcKcaYKYREsihnlTrpnPpx8uG2OrQLcNAHTF
 NAv8LVlB+uO12wG/3BQ4jIU2ybQ2k35WzbUQrbYpSuOY0UD724PCdpYaIoeA4Iju9LyT
 qwY3hnNkPUJu7qd98sH3upcxYyC0U1z5QaZLNwzz77f9nO4y+HSlpLghsiFTSVlXrrOg
 yZi9Oxj3igkwlbkdQ7hS/GQsk5iJzQlNuB2X62QE3FZv+mY5VO/s1xdwIN55zgmkfsVF
 Z+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788886499; x=1789491299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p8wNNxhf78DFPkHI8dBadYfr8qLCJ7YNn5xf4kGgofo=;
 b=MAriSqU38NgzvadbWvkW7LB/DIYi9oZHpX67P+/AxaEZ3kTpcAMIs6s/F1WzwK23D0
 w1pzGkDpXjWIAPwtvABAsYf9y/SDesfqhYeYuOE07ZmOTQuvu/NWQeURE2fbt1kS9lhp
 WdQBrvVthl22Htz48r4k5xudx62t7twqyqlUiqU0bP1W92Rvno3AolxIVX3JHyOxyST2
 n5ZW359O9WKYTUeA1QEIqv9bmLnaV3+CrOT0Lqwdwx185bPxHWBEqE/1sbJC7losUYWm
 iPypzxzCRPgW3XggVUjyDqjatd4epIez6Txw7WQYuCb/wTm6a2Vk9ILzpxdJ1AbAwbWY
 NYAg==
X-Gm-Message-State: AFuF++mQ3tlpyujUFUc+On92wi3JZ2p408N8bHKELz3uKE9br4XH8ZvP
 AVqZcbiDHUQ75jx9P4fisRi807J4IpYMuhxZspQSZ5NLn6udzbHLn+W0LcvrR5SBng/96WokuvT
 hyT3t
X-Gm-Gg: AYBFou1Q7oJa9HAJt44NTRnZaUgm5ZxwCqgvS6jzwCUAsrkpG7H3Whf7s9hoA4Ooje1
 3ROtoOo2HpCyfMG7MXaiYufgKvqrHSFmFBWggwH4OzfEVB43MPjVHLq3SC89PJGO3mCCBPFsKKa
 kB3dRqS8o9D0BnplUiPH322wZZfCmhr4AlePsY8HDBdK6gBzQ/RSeWwQm21fDmHHsUImNfJMItB
 hP8OEEzBjXQLRYcjKo5FUvkDCg7eveqi4FnbpykSaLWa4ZAMlBFOcInSEN3tqQlauxSLr8a2Jre
 VcefvutaSpV/SSTpnL9l9EOAYBzYOvMRFKY03iqgeSvoDfCV/84tDa/evtOWpip2OpRZXRvIXej
 ZggEPgZmfSnfqqNW+f/R1UgOiAFWj4ysjxI1EyRJA27/7zHD6MFfQu1U7l8U5crcyCwFCMvQu+d
 oRaGks0bmsD9nS4vf2m2ZhtZ9G2T4j+OAjuOOTpIJ1h8YCUnYgWB4oQ1XamgkJ7hLvW3SDlx3gc
 Ztn7R6IKdJEdBPD920kkFxyCec=
X-Received: by 2002:a05:6a00:414e:b0:857:7384:b5f7 with SMTP id
 d2e1a72fcca58-861692846b6mr45940261b3a.19.1788886499175; 
 Tue, 08 Sep 2026 09:54:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86207a4d602sm5096741b3a.22.2026.09.08.09.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:54:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/3] power/amd_pstate: fix frequency matching for
 continuous scaling
Date: Tue,  8 Sep 2026 09:52:32 -0700
Message-ID: <20260908165447.450006-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908165447.450006-1-stephen@networkplumber.org>
References: <20260328193419.106100-1-stephen@networkplumber.org>
 <20260908165447.450006-1-stephen@networkplumber.org>
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

power_init_for_setting_freq() fails with the amd-pstate driver because
the frequency read from scaling_setspeed does not exactly match any of
the synthesized frequency buckets. Unlike acpi_cpufreq, which provides a
discrete list, amd-pstate scales continuously, so an exact match rarely
succeeds. On a Ryzen 9 7945HX the sysfs file reports 2492000 while the
buckets are spaced by (scaling_max - scaling_min) / 63.

Use the nearest frequency instead of an exact match.

Since the match is only the nearest bucket, curr_idx would no longer
match what was last written to scaling_setspeed. set_freq_internal()
returns early when the requested index is already current, so setting
that bucket would report success without doing anything. Split the
sysfs write out into write_freq() and program the bucket during init.

Also in the same function:
 - strtoul() was called with NULL endptr, so parse failures went
   undetected
 - errno was not checked
 - freq was uint32_t, truncating the strtoul() result on LP64
 - no error was logged when matching failed

Bugzilla ID: 1915
Fixes: 1ed04d33cf19 ("power: support amd-pstate cpufreq driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 91 +++++++++++++------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index af9c1309f3..13ffcefc84 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -5,6 +5,7 @@
  */
 
 #include <stdlib.h>
+#include <errno.h>
 
 #include <rte_memcpy.h>
 #include <rte_stdatomic.h>
@@ -53,6 +54,25 @@ struct __rte_cache_aligned amd_pstate_power_info {
 
 static struct amd_pstate_power_info lcore_power_info[RTE_MAX_LCORE];
 
+static int
+write_freq(struct amd_pstate_power_info *pi, uint32_t idx)
+{
+	if (fseek(pi->f, 0, SEEK_SET) < 0) {
+		POWER_LOG(ERR, "Fail to set file position indicator to 0 "
+			"for setting frequency for lcore %u", pi->lcore_id);
+		return -1;
+	}
+	if (fprintf(pi->f, "%u", pi->freqs[idx]) < 0) {
+		POWER_LOG(ERR, "Fail to write new frequency for "
+				"lcore %u", pi->lcore_id);
+		return -1;
+	}
+	fflush(pi->f);
+	pi->curr_idx = idx;
+
+	return 1;
+}
+
 /**
  * It is to set specific freq for specific logical core, according to the index
  * of supported frequencies.
@@ -72,20 +92,8 @@ set_freq_internal(struct amd_pstate_power_info *pi, uint32_t idx)
 
 	POWER_DEBUG_LOG("Frequency[%u] %u to be set for lcore %u",
 			idx, pi->freqs[idx], pi->lcore_id);
-	if (fseek(pi->f, 0, SEEK_SET) < 0) {
-		POWER_LOG(ERR, "Fail to set file position indicator to 0 "
-			"for setting frequency for lcore %u", pi->lcore_id);
-		return -1;
-	}
-	if (fprintf(pi->f, "%u", pi->freqs[idx]) < 0) {
-		POWER_LOG(ERR, "Fail to write new frequency for "
-				"lcore %u", pi->lcore_id);
-		return -1;
-	}
-	fflush(pi->f);
-	pi->curr_idx = idx;
 
-	return 1;
+	return write_freq(pi, idx);
 }
 
 /**
@@ -282,15 +290,21 @@ power_get_available_freqs(struct amd_pstate_power_info *pi)
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
@@ -299,7 +313,6 @@ power_init_for_setting_freq(struct amd_pstate_power_info *pi)
 				POWER_SYSFILE_SETSPEED);
 		goto err;
 	}
-
 	ret = read_core_sysfs_s(f, buf, sizeof(buf));
 	if (ret < 0) {
 		POWER_LOG(ERR, "Failed to read %s",
@@ -307,28 +320,50 @@ power_init_for_setting_freq(struct amd_pstate_power_info *pi)
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
+	/* amd-pstate scales continuously, so the current frequency will
+	 * rarely match a bucket exactly. Use the nearest one.
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
+	/* Program the bucket so curr_idx matches the actual frequency. */
+	pi->f = f;
+	if (write_freq(pi, best_idx) < 0)
+		goto err;
+
+	return 0;
+
 err:
 	if (f != NULL)
 		fclose(f);
+	pi->f = NULL;
 
 	return -1;
 }
-- 
2.53.0

