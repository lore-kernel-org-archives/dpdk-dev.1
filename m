Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB60DCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 23:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EFDD402DD;
	Tue, 29 Sep 2026 01:16:41 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id DA9CA40285
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:16:40 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a4805e15cfso656770a91.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790637400;
 x=1791242200; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nrbhDMqdSjgysU+ep9wbjZAS5mU0SvYguuTYi6ppQeM=;
 b=DPGH1VU96pJfy5Jw1P2lxdvbtSyvWhFsp4x2/lYvVql0H0wJFRMeT68/D3JWjjrex4
 jX5uo50WWY5NLVfmiN4UaaldGj+qSL2SfRBKBwQ2A7ockPrhW+0zqSKRK1LsW5OY6yYB
 JE3JaIQArOz2QaaDx8dunD+MLNxPgqLWyfWvZh4OG3cvvXVRIN+sboh7UnoYYx9asylR
 R4fSWZYt+++BXIrQv1lyTOBjXzfUST/jOYtoLq5wJ7yGFqvnaXQjNNOwel3T+Mmk7NLu
 4jgnYA4L7WxCjqcBvhnPN9Gsv09smM0AEExq5vhbp9axAxRRT+02cR9aJK0QELctpOp3
 VHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790637400; x=1791242200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nrbhDMqdSjgysU+ep9wbjZAS5mU0SvYguuTYi6ppQeM=;
 b=fiLdi/+E00ZE4S/1ybrRGXifa7WGI2byCI/FkJd+mWXo5OwcZQfmSesWLfTH1/Amcu
 VKdoVBzI0B3OdS0xYLwYmE+aedEDw9NneiKwajZQaTVAILJ+PyhTd02DhGRSOwHxYjo0
 P7smTUoA/M+rOHg4CJpBbC4C9bTQOPDGeDpK04pmfUMOIZ4ZywggdC3sVCGny9XpGBZH
 81rH99lkdw+B7XjueaW5I1KJ8au87/WbS8IXgDUVCajVb6cXFwkHG1FgtovQRmK9i9u4
 OV5sOBD/GJIjZuvYHbkM3cdgK3VD5dNZ3pUjO/Z9+G91aZ0IT+Vklct1A1RtANb6FkhV
 qoRQ==
X-Gm-Message-State: AFq9FYIww8pMjr7Y5BNz5/lldYr3xuh0m1mmMLDkg1vNS/DHjf+PeC9c
 D6UikBSrtnZCzAGOOylbxsbAEJY7HEmGimMPBHWLDL9HhWrQWBvM6fm7c1peZEanEuOYe6mgQwP
 oFc85jS8=
X-Gm-Gg: AYBFou0ZeOTOZPk0d2+YpDSABmBlktJqCwAhgJwSiHlhVr43h0DDCKjWw2GRaaMmZRI
 rLvk6AX/YWlNDNLEJn2e4hJno3zJVxleFhiSRM5IecvMzSFh/iEQcKx7RQwYb7qc0IGa+IOmTjn
 IttbXiD8kE3/a/iNb4js+L8oJ1qwv6S3eNWEtbVj868byMiluAtt5GoYvaYBpXJ/okLdiit6AEe
 JLFAYNddvAUMw89rh9+P3/J71rBMdZpsQYnxE3QPzwEpj0zLp9xxivJ31KpRhz9goHOpUGPXzrQ
 vQy0YzWg3nHqLt+hH1V1dUBisX5p/Ane8ba3K8XBKlGlTL6hyIgoYQBMkZVAF7bYI0fHAZZBKbz
 FhR93+k9d7pwmKhi8XnNvt6UnUrnPX4oaGqRGO63h+yTg7eHf+9dQCid/vm/H/tV9k/NZa79CSh
 GGlaDKZ+R1k+x36cD1paD3TmcFTdohoRjEsNf/opud8nXiO5Jf8zfI5P3IfDJwsqFyLHYrIpFYv
 QNQ3FmOUSYafmqKGHBjYUT4ciKAi8hTWsYirB9mv/qlyGT1jw==
X-Received: by 2002:a17:90b:3bc8:b0:3a4:7c19:6a02 with SMTP id
 98e67ed59e1d1-3a47c196d6cmr2392088a91.0.1790637399867; 
 Mon, 28 Sep 2026 16:16:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df90fb675bsm47741895ad.10.2026.09.28.16.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 16:16:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ravi Kerur <rkerur@brocade.com>
Subject: [PATCH v2] eal: fail initialization if TSC frequency is zero
Date: Mon, 28 Sep 2026 16:15:58 -0700
Message-ID: <20260928231637.733450-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927195440.89193-1-stephen@networkplumber.org>
References: <20260927195440.89193-1-stephen@networkplumber.org>
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

Fixes: 040cf8a41187 ("eal: deduplicate timer functions")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - cleanups: mostly squash useless comments

 lib/eal/common/eal_common_timer.c    | 19 ++++++++++++++++---
 lib/eal/common/eal_private.h         |  2 +-
 lib/eal/freebsd/eal_timer.c          |  3 +--
 lib/eal/include/generic/rte_cycles.h |  2 +-
 lib/eal/linux/eal_timer.c            |  3 +--
 lib/eal/windows/eal_timer.c          |  3 +--
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index bbf8b8b11b..e9f8b56b59 100644
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
@@ -65,18 +65,31 @@ set_tsc_freq(void)
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
 
+		/* Check if TSC is not moving */
+		if (freq == 0) {
+			EAL_LOG(ERR, "TSC frequency is not changing");
+			return -1;
+		}
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

