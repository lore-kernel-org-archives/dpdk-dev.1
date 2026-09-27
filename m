Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5826C98338
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 19:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E8F14026D;
	Sun, 27 Sep 2026 21:54:46 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B4FF5400D6
 for <dev@dpdk.org>; Sun, 27 Sep 2026 21:54:44 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1239970a91.2
 for <dev@dpdk.org>; Sun, 27 Sep 2026 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790538884;
 x=1791143684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWTWQP1hXgmESOkok64+Jglf9q2r60mOyQiPpnJuP6I=;
 b=FNpzGv3kEuJII6sWiJNoxqWwIS8yDVdJiRrlNSGj1FFmXghA2RQmbd50w8Kgxzxe8u
 2tC1pZkrGiABwyPKbKczowsUVbNqaYbQiRsGVLxsoqJOXihseu4R+syDq3SDXrtXF6d6
 CSHbSE0mroblfEyoxxyIRo7YefzcPSShOo0Wwghdc6Y77HxY/ziSZS7OUQKZwzKDq3lv
 ewRG/f5WCcKVu/eEUNY7TvnUWWw6PwdEMSXel45+n2yksexrimBQo+9PZnk3UGIduPuz
 +oFmbAnGKuKRPUY2YRdAaPThu8jPEcVF+0pOjBjiZd5heGQjCvprdVoFuv4dx5S55lrF
 I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790538884; x=1791143684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWTWQP1hXgmESOkok64+Jglf9q2r60mOyQiPpnJuP6I=;
 b=11gz2IixJccGsr5AKGHNw4AJMjTqIln9UESU4xAcVkCJNEyVvtdQ0tF9tN5qNDzAo7
 7nh267f/W5S8ec71dV73U5cvQqK9bq5Xh0gDu8xWbicUFyJt9qiMxOH2kJ6sHZERHZ0T
 EAcoyEKTVGis2a5YhU7FJEKkgDT6CpxVY39bu+K9xLgGBZttEVcc79YL9MytepPtcFzx
 +PX4lHXIJ8u6/MgkYd1ppX9iwOdYrq+GY/ZU95uW3zckEa+lqBrP04ZNFXxnOpaPABJQ
 1KBTzCe4Q8hNzjZldNWYHx1BKrpj1Ma98f8f/VjX1nYZptA/Q3zN+1R2zi+vGneo41Js
 Smug==
X-Gm-Message-State: AFq9FYKTzvDnxQmT8LWH0Yt95Z4r0QOQMVzx+RpdJSI8wzG6o5FFgicf
 Fd46PNOdeGzCUZUaTo6NvVxyVizY/PnATJ4YonAiPcBX3oHY60anLf9FMHZX0/ZTYGy1ATnvQXV
 +aXWbq4U=
X-Gm-Gg: AYBFou04FszoJObrKWTN+3hWs2JN+MIx0hRck++JMTiNQ7bGXEu+jvn9xTSMKG9R0iA
 wDQduj1ytSvCkERmPNularj3m5w+arTvjB6UOpQ2E71nyxsewYu0qty0LmKbV2po6xpZ9lyWu5x
 9xAQ/dgYHY+FxRYG7OBbn3gYdhGAsbmjDxGWU6LTTPG9PPlUbEe96SNSnScaioR80nGP2i8uKCS
 7jEH3Aq3BK3jBXTmZDB2k3uTNL5EHj8bdSsgAvdoNE6BCv6reY2INf/AM5jiGI+yUpKMLW4ORGv
 vJx5qJ+HP9fqRI8aY+ZhwF54GzrS8a3H2UZGMGprp/GYh+ubo0+t4A4aWHN9A/4w+V3F0cJg4Gp
 3Sv7edtTcU3lNkwBNOrUIMKAx+niWS6P+POyzBSfPJGXh9R9kp2ijMFuHU7TXhwnT1rqB8CH4SJ
 z2qHCbxKCPZprJ5dCMw9MPTx2elzRrqV9RAPTvgERPzYeEDl9syYVZnFH9o9b6QDsARRDNSN1F8
 p7HZQijQHYxjBLVM7iYY6aao6SVlo5YV+8Z9g==
X-Received: by 2002:a17:90b:28c3:b0:3a0:d18f:4be4 with SMTP id
 98e67ed59e1d1-3a0d18f8399mr4479014a91.33.1790538883642; 
 Sun, 27 Sep 2026 12:54:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9355e49sm16451736a91.4.2026.09.27.12.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:54:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Ravi Kerur <rkerur@brocade.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] eal: fail initialization if TSC frequency is zero
Date: Sun, 27 Sep 2026 12:54:40 -0700
Message-ID: <20260927195440.89193-1-stephen@networkplumber.org>
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

Lots of parts of DPDK will fail with divide by zero and
other errors if the initialization logic ever TSC hz was ever
determined to be zero. This might happen on a broken get_tsc_freq_arch()
or bad emulation in QEMU.

If TSC hz is zero, log the error and propagate back to
fail rte_eal_init().

This fix doesn't need to go to stable since it is a purely
theoretical problem; we aren't getting divide by zero reports
from users.

Fixes: 040cf8a41187 ("eal: deduplicate timer functions")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_timer.c    | 22 ++++++++++++++++++++--
 lib/eal/common/eal_private.h         |  2 +-
 lib/eal/freebsd/eal_timer.c          |  3 +--
 lib/eal/include/generic/rte_cycles.h |  7 ++++++-
 lib/eal/linux/eal_timer.c            |  3 +--
 lib/eal/windows/eal_timer.c          |  3 +--
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index bbf8b8b11b..d502468053 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -52,7 +52,7 @@ estimate_tsc_freq(void)
 	return RTE_ALIGN_MUL_NEAR(rte_rdtsc() - start, CYC_PER_10MHZ);
 }
 
-void
+int
 set_tsc_freq(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
@@ -65,8 +65,13 @@ set_tsc_freq(void)
 		 * systems where arch-specific frequency detection is not
 		 * available.
 		 */
+		if (mcfg->tsc_hz == 0) {
+			EAL_LOG(ERR, "Primary process TSC frequency is zero");
+			return -1;
+		}
+
 		eal_tsc_resolution_hz = mcfg->tsc_hz;
-		return;
+		return 0;
 	}
 
 	freq = get_tsc_freq_arch();
@@ -74,9 +79,22 @@ set_tsc_freq(void)
 	if (!freq)
 		freq = estimate_tsc_freq();
 
+	/*
+	 * Several get_tsc_freq_arch() implementations return zero when the
+	 * frequency cannot be read, and a TSC that does not advance at least
+	 * once per second measures as zero.  Such a counter cannot be scaled
+	 * to a time at all, so fail rather than let callers of
+	 * rte_get_tsc_hz() divide by zero.
+	 */
+	if (freq == 0) {
+		EAL_LOG(ERR, "TSC frequency could not be determined");
+		return -1;
+	}
+
 	EAL_LOG(DEBUG, "TSC frequency is ~%" PRIu64 " KHz", freq / 1000);
 	eal_tsc_resolution_hz = freq;
 	mcfg->tsc_hz = freq;
+	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_delay_us_callback_register)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be..952cb5a03e 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -409,7 +409,7 @@ int eal_cpu_detected(unsigned lcore_id);
  *
  * This function is private to the EAL.
  */
-void set_tsc_freq(void);
+int set_tsc_freq(void);
 
 /**
  * Get precise TSC frequency from system
diff --git a/lib/eal/freebsd/eal_timer.c b/lib/eal/freebsd/eal_timer.c
index d21ffa2694..84127d876b 100644
--- a/lib/eal/freebsd/eal_timer.c
+++ b/lib/eal/freebsd/eal_timer.c
@@ -65,6 +65,5 @@ get_tsc_freq(uint64_t arch_hz)
 int
 rte_eal_timer_init(void)
 {
-	set_tsc_freq();
-	return 0;
+	return set_tsc_freq();
 }
diff --git a/lib/eal/include/generic/rte_cycles.h b/lib/eal/include/generic/rte_cycles.h
index 7cfd51f0eb..8e3d8aad91 100644
--- a/lib/eal/include/generic/rte_cycles.h
+++ b/lib/eal/include/generic/rte_cycles.h
@@ -33,8 +33,13 @@ extern enum timer_source eal_timer_source;
 /**
  * Get the measured frequency of the RDTSC counter
  *
+ * The frequency is determined once during rte_eal_init(), which fails if
+ * it cannot be established, so this never returns zero once the EAL is
+ * initialized and the value does not change afterwards.  It is therefore
+ * safe to divide by without checking.
+ *
  * @return
- *   The TSC frequency for this lcore
+ *   The TSC frequency for this lcore, always non-zero.
  */
 uint64_t
 rte_get_tsc_hz(void);
diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 39f975b6b9..bccff60ff8 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -99,6 +99,5 @@ rte_eal_timer_init(void)
 
 	eal_timer_source = EAL_TIMER_TSC;
 
-	set_tsc_freq();
-	return 0;
+	return set_tsc_freq();
 }
diff --git a/lib/eal/windows/eal_timer.c b/lib/eal/windows/eal_timer.c
index 33cbac6a03..aec8ea854d 100644
--- a/lib/eal/windows/eal_timer.c
+++ b/lib/eal/windows/eal_timer.c
@@ -94,6 +94,5 @@ get_tsc_freq(uint64_t arch_hz)
 int
 rte_eal_timer_init(void)
 {
-	set_tsc_freq();
-	return 0;
+	return set_tsc_freq();
 }
-- 
2.53.0

