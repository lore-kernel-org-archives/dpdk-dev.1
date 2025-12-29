Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14176E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10AFB40656;
	Mon, 29 Dec 2025 21:48:39 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 5ED46402DD
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:37 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so15850145e9.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041317;
 x=1767646117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=HbfkLXlkj7GhbPCMaNHvToxnrR5DQ+JLLConOP5tWEeahwmSgSKxpMI2iKfLPTd2b3
 6CDkbjvAPOS18RS5ChtImc2niK90TQrSLXO3a1641cAb59mpppGBFdB4uXuyXngsnQtk
 OJJQwFjygmBOEMMh7fh+1JXPUn2K8b3pXD7CV1C2de8U/uXu45nkG4S9Y7Idf/D5dBbE
 n9gHFqVxwkX4f6wSOW+Qn02V/J2AppkH7x3HIx6lu9w/I0YS+TUyzruzYNk0AKGBmMLV
 wOHOEczRzLgWGYkh/kYY+OmN4imFN65O0VW2dIrE0Si5I2A232to1icE1/5apFI9iBcc
 GLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041317; x=1767646117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=s5IMtC9eUXpN20E5nvgmrnfBz2DvRNEycUGdnBp8ZCxDBgY4WTXkaCMdozHTlK9Gt1
 p5Ki/x0eHQhF22B+Uk9zJiWpPXm4KsptVYU7UCdz2CaJ9TQEQSzOgpPjDrVT3YlmBlfH
 KtSojuemDaki+SxyCdM97Olfh5/s/NDnr7FiU47LHbjJ9jpLYMZ73BH9bzGLvCZ7Wad/
 3qB8ywOYizSeXK/wa/fqGgNwOx7ICmtKh3tWBO+EuR/nW9kTmoAltmI/qWULqxaFYDQn
 raS8okbViF7yduDRbjiVM1693oIl+dBfFPlFNKV7oK1OPqzrD3FMf1Ut3yakGz4jPRGG
 NdqQ==
X-Gm-Message-State: AOJu0YxKgZGV+CDH2FOrBizwZVj4htRO5738GsafS2ZQ1ir/k50Syjrk
 51+kIQIPna1ACVENJXLL+PtKpW2cxNIbGLV4Si/OjgKU1DIlgujO5Gt6Y0UStcyAwJXKBOesrX8
 UgjlBeg8=
X-Gm-Gg: AY/fxX6L/s+F7Z1lf2OZplbZf66B6Ej0U2TNRAtJLp2R5R46b3iwO9RqYJcgXOiUB2w
 izxk+PUP8BJvLTRWIJM20juYnl58Wrk9r7YmsGyNrynz8WOA4Emuu5F/J8ZOmlF69eTzY9De/aJ
 DGVmBU5lUsLg/B2NTBCtEyhOJk3wk10+W8qiIzCKNq2YhwhjKuluXb6o3spQTs57HphICyntBQI
 z9RmhsuXQJG78KhN3h9JLQky2u1QvKksgAfx+Js6g078S3MCo4UViaNE/SKUDJg5olOtmKn9E+3
 Wh0STvOZ6Ck3LxZ1Pq7VdoDU3JMTA6zWc9g39yyooZGggbOqSe4qv2qN7Dz4BQZ4jM+huTX3d0W
 A1uh1gLgB85KA2F5zSBlwnIykn1k3MenI0dI9A8qmVwbEqpAx30fpFZF3zSF61MEGCCAvJvzUcp
 SGi1uKaNNUjuOt6eJ3dkL0SJ9qDfm2gFiesIwmD7mkc3pO9ZbQww==
X-Google-Smtp-Source: AGHT+IHwMWcx8QFdbgO6mCpNh6gwUGKCZp1COwIoZli5P23YvohTyVBtqU0h3Woj9QAGn/+NIiZWFw==
X-Received: by 2002:a05:600c:8287:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-47d1959d0cfmr309560365e9.37.1767041316903; 
 Mon, 29 Dec 2025 12:48:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v9 06/18] efd: handle possible name truncation
Date: Mon, 29 Dec 2025 11:38:04 -0800
Message-ID: <20251229204818.61231-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

If the conversion of efd name to ring name gets truncated, then
log it. And if the ring name than causes collision, make sure
that log message includes error reason.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 lib/efd/rte_efd.c                      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b966ce7b49..91b1808455 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -92,7 +92,7 @@ API Changes
 
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
-
+  * efd: name must be less than RTE_EFD_NAMESIZE.
 
 
 ABI Changes
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..bbd565f404 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -517,13 +517,20 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 
 	if (online_cpu_socket_bitmask == 0) {
-		EFD_LOG(ERR, "At least one CPU socket must be enabled "
-				"in the bitmask");
+		EFD_LOG(ERR, "At least one CPU socket must be enabled in the bitmask");
+		rte_errno = EINVAL;
 		return NULL;
 	}
 
 	if (max_num_rules == 0) {
 		EFD_LOG(ERR, "Max num rules must be higher than 0");
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (strlen(name) >= RTE_EFD_NAMESIZE) {
+		EFD_LOG(ERR, "Name is too long");
+		rte_errno = ENAMETOOLONG;
 		return NULL;
 	}
 
@@ -698,12 +705,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name)
+	    >= (int)sizeof(ring_name))
+		EFD_LOG(NOTICE, "EFD ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
 	if (r == NULL) {
-		EFD_LOG(ERR, "memory allocation failed");
+		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
 		return NULL;
 	}
-- 
2.51.0

