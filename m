Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A37C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75BDA42D27;
	Tue, 29 Sep 2026 16:14:28 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 39123411F3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:14:27 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so4400685ad.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790691266;
 x=1791296066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/wSiSjbEUzIuT/rbbKQ1t4J6XZzGmuBDmlrL5L9bjk=;
 b=yPltUYSCOcFLZ8GmfyqEHloVQ0P1swz+3VmBuSi/+Z+C6iD2ab/RcvrykbZLOLITE9
 QXV/72xFPYjUVQ35SR96rIyLLydWWsHE2AGWnGJLDVXGdohux01s75FsJrh/AEXOujUH
 aSPWmwqcG+kP8fIekkyn/E+BlDhwocvlsC1QPnECjCtfsHrT/epbL4qNNvnfpb0gZry4
 Xj5nAlthEUkV6rYqJzMf3ZbMiFmlO1OQpKkUphx2GPjphmD368i8fkcHs/ehVSpwbt6T
 HABx6jf9M+LtDwxnKwOdDGUPRZ51zZPYFGnbMW2ir/yMKhb0RZg+HtP63E4cym3oj1sa
 qbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691266; x=1791296066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/wSiSjbEUzIuT/rbbKQ1t4J6XZzGmuBDmlrL5L9bjk=;
 b=aQGCrqmjacHFR35jI2KVxUwAKuqLEoIgWB7KbI+Ybmb5CykoraIx7eyXT9Aw5/I2Y1
 N0P+1jrTGZc8fN2hAVZOZlVk/bYQhc88LLoXGHHoBKPDJi4WCmIdTU5Ak4feIw8oEYk9
 P9w9lwmNaePhnjh76P3JObnzMnTabs3eUMDXa3hN564zUHkZmFUfwj4Jx39r1pEnjaao
 CYsPG29dLaIlbjfVB+VcfdSoZqG5nckVIPCwlBtM/MS6C01UTzPfwc0utK4sZRd7twbc
 jV1vjeD14UQ9e19yR77dfVlmlW4JPyHAo1z/nfN7I/e2zoP06bic80hH9iwak7L3Ldkk
 ZBNw==
X-Gm-Message-State: AFq9FYJx1MGpu3lK7BxIEGTJKtel+tg9IDutzAObuyHUAkFRuibn+DAs
 TZXulrLkKsup7bdhELgDvMW4CWS2EUieM19rvx3YThyHA3X19lEmDVaITsIHW/rnWhYb9e1QCYn
 28t8f10E=
X-Gm-Gg: AYBFou25Srpj4kiPBwWomtGdFE+f64i0IBJTYUvMq84Ox+tS2R+R2xjrlw2zYdePP+3
 J6gklXIoQ9EoduVuWF7kIUKr+1ZUCtHfykYaEqRimS+es5xY/x78ylF2qOXafPRYI9WWRMxiME7
 6VBxAVLwxQKHb4VfkNySo7YVPXCxMBoxGyQiVkrNxtXrdvdJNAkIWs7VVkJOk9xUMoLWZKJYUrf
 AnQ6XENf4AC2wiUf6cRYFBSJ35gsQCHAj2HWFVDL9HCmSBg1BWk2DETt+C3GbVsz04sQ2fbQ8rk
 DLSErd6btJ0gE8BTD1QCx0uBl2KvEVDvA7HMiA0h2syiiwA7dDnIx0xmmhtNh211W+WGGLmR9xd
 ca1egJgbdLu8pDWRkUHn6p20qpahAd6Kacdi9/ocIMQ0oLNJvEw6mS6nZJada4AT2C3JvzJHqem
 XP1EM6UbdL2mZ5gwcKQQILh4t83luMNeK2AKgMxXgoujo9svVoHQMYuS3JQwRQ4B4Fqqxuswex8
 BK5bd5uMvPpaxP8h3ggotmAAy9GB1Ca0LOGLA==
X-Received: by 2002:a17:902:ffce:b0:2df:95b5:ef0 with SMTP id
 d9443c01a7336-2e2c475bc95mr15733205ad.1.1790691266202; 
 Tue, 29 Sep 2026 07:14:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df91468978sm57565115ad.79.2026.09.29.07.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:14:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Ravi Kerur <rkerur@brocade.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3] eal: fail initialization if TSC frequency is zero
Date: Tue, 29 Sep 2026 07:13:37 -0700
Message-ID: <20260929141423.309936-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928231637.733450-1-stephen@networkplumber.org>
References: <20260928231637.733450-1-stephen@networkplumber.org>
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

Many parts of DPDK will fail with divide by zero and
other errors if the initialization logic ever TSC hz was ever
determined to be zero. This might happen on a broken get_tsc_freq_arch()
or bad emulation in QEMU.

If TSC hz is zero, log the error and propagate back to
fail rte_eal_init().

This fix doesn't need to go to stable since it is a purely
theoretical problem; we aren't getting divide by zero reports
from users.

Also, clarify that DPDK TSC is stable and the same for all lcore's.
The comment in rte_cycles.h implied that it could be different per lcore.

Fixes: 040cf8a41187 ("eal: deduplicate timer functions")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3 - rename set_tsc_freq to init_tsc_freq

 lib/eal/common/eal_common_timer.c    | 19 +++++++++++++++----
 lib/eal/common/eal_private.h         |  2 +-
 lib/eal/freebsd/eal_timer.c          |  3 +--
 lib/eal/include/generic/rte_cycles.h |  2 +-
 lib/eal/linux/eal_timer.c            |  3 +--
 lib/eal/windows/eal_timer.c          |  3 +--
 6 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index bbf8b8b11b..67ede70c62 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -52,8 +52,8 @@ estimate_tsc_freq(void)
 	return RTE_ALIGN_MUL_NEAR(rte_rdtsc() - start, CYC_PER_10MHZ);
 }
 
-void
-set_tsc_freq(void)
+int
+init_tsc_freq(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	uint64_t freq;
@@ -65,18 +65,29 @@ set_tsc_freq(void)
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
 	freq = get_tsc_freq(freq);
-	if (!freq)
+	if (freq == 0) {
 		freq = estimate_tsc_freq();
+		if (freq == 0) {
+			EAL_LOG(ERR, "TSC frequency is too slow");
+			return -1;
+		}
+	}
 
 	EAL_LOG(DEBUG, "TSC frequency is ~%" PRIu64 " KHz", freq / 1000);
 	eal_tsc_resolution_hz = freq;
 	mcfg->tsc_hz = freq;
+	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_delay_us_callback_register)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be..7da3783c9e 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -409,7 +409,7 @@ int eal_cpu_detected(unsigned lcore_id);
  *
  * This function is private to the EAL.
  */
-void set_tsc_freq(void);
+int init_tsc_freq(void);
 
 /**
  * Get precise TSC frequency from system
diff --git a/lib/eal/freebsd/eal_timer.c b/lib/eal/freebsd/eal_timer.c
index d21ffa2694..b966c30258 100644
--- a/lib/eal/freebsd/eal_timer.c
+++ b/lib/eal/freebsd/eal_timer.c
@@ -65,6 +65,5 @@ get_tsc_freq(uint64_t arch_hz)
 int
 rte_eal_timer_init(void)
 {
-	set_tsc_freq();
-	return 0;
+	return init_tsc_freq();
 }
diff --git a/lib/eal/include/generic/rte_cycles.h b/lib/eal/include/generic/rte_cycles.h
index 7cfd51f0eb..f8e1cde332 100644
--- a/lib/eal/include/generic/rte_cycles.h
+++ b/lib/eal/include/generic/rte_cycles.h
@@ -34,7 +34,7 @@ extern enum timer_source eal_timer_source;
  * Get the measured frequency of the RDTSC counter
  *
  * @return
- *   The TSC frequency for this lcore
+ *   The TSC frequency for all lcores, always non-zero
  */
 uint64_t
 rte_get_tsc_hz(void);
diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 39f975b6b9..c425ea4ed8 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -99,6 +99,5 @@ rte_eal_timer_init(void)
 
 	eal_timer_source = EAL_TIMER_TSC;
 
-	set_tsc_freq();
-	return 0;
+	return init_tsc_freq();
 }
diff --git a/lib/eal/windows/eal_timer.c b/lib/eal/windows/eal_timer.c
index 33cbac6a03..1e381ad673 100644
--- a/lib/eal/windows/eal_timer.c
+++ b/lib/eal/windows/eal_timer.c
@@ -94,6 +94,5 @@ get_tsc_freq(uint64_t arch_hz)
 int
 rte_eal_timer_init(void)
 {
-	set_tsc_freq();
-	return 0;
+	return init_tsc_freq();
 }
-- 
2.53.0

