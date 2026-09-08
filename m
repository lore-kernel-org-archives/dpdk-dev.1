Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5462AC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97412410E7;
	Tue,  8 Sep 2026 18:55:08 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7D26A40E31
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:55:06 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso4955556b3a.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788886505;
 x=1789491305; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpIggHH9UTRlivNlTYlKqfp0Ks3LQRsDXQfimluEkLU=;
 b=Eg78YDvL5FoVoaOCY2BSczOD8sIo46itwZRsb48ZHfQ4yhbOcu4s70cH17aWibUGK9
 O4q3UGylapgqIgiosEBuNKH1sJGQZOgM2pqx0Ff5IQ+g2J/lofIgQaCUGc9T7CRYq4Lc
 41hxm2LcsWEIv2QETa94+A9ykK4d20CkH13x9FDKunf1v6XGvXkt2CDP2b0ht9FUP2aB
 t9lrqtDUIwzIH+gEAVDEgXzwnp6++wtIBeosglCLJz0TYc+RE6aDl9Wq9A1roxtoP3Tg
 kjja2Qp9COcr/rKrLdZ2BzZu8zW+kRsMtLRnJg9/vJBqAnfFf4DOcOSwPohP0+4lkEUD
 3zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788886505; x=1789491305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vpIggHH9UTRlivNlTYlKqfp0Ks3LQRsDXQfimluEkLU=;
 b=FSz7TJXhcvmddyoftpEplGed7m7JVa6Nn1ZTZdug+X6vpwMjaAq9jbivsX/MD4LVje
 lV23apj73+MloWYAvoM5jM5zHFsY7OtjArAcCFiffoe17qCFivk/wuN8UgtZk8BonEe2
 D8U8ydNN5h/cBxTLruYVxEhiQNTDOyal7bNhblaE79orSNPIagpl5t7akOA0P/+GcdK1
 DHuDTtBOH5VNj80KnvBA7wZ4Extu66IMVnKSh9whd5SECKu5+jau3SLsFUgaNyh30ZSb
 dUC7NfTq4sNev9ZG0H0xi0RZPNctsgTOxp851/xzndOLy1t9rOp27XlPM24ht4xZ+oaz
 x2pw==
X-Gm-Message-State: AFuF++nPKVcXdIm2WI3t9jqTm6ZlGxqOCkyaSAcCxirVwMib2L8wh8Ed
 snbeb+XhCr6CbML8eygka8FddDYzA0DwvlS7+Bd0cavoma95ZFPYCIYYago8mhgpRC0OoOxaTVW
 IS88I
X-Gm-Gg: AYBFou2DC9y8Cbfdw9ZkILwr+BNM92pwv/9bdEm0ctWOnl03HfLccKnrq6sBRCvrmyn
 Jv9sG7wdg9nI5KQomrAXJnonaXQgrbdoLhsbbYwx8X079tr6+ilH2ZLzldQ/Bj0/NHbHMbcxdOM
 u3o8HedOIXQuniDHv8njv2XYRJVe5hMCQwJvy+3UyVByZknGJtVHV59O53CFKOysD7S1VNA2bUK
 C7xeo8hDHImzEzNdvj0hJSz4q3BKEWznAPwtPhtLIvSz/QNGbdtVvKmSDq4TrjmbCCskJZSysHG
 33c3epglleWk3rElsF+sbft18znY0Qs6NDGNHvntwRoIBfAGiuCKN4Cia982dZVXHL9Nz+Snisa
 +aa6Ghi9y/2ZfwO2G7FHlVYFENyqOVCSR5/7SlD4pXDUBFxefpEsxNna+sfqnneV0JXJ+0RYRgi
 vyIEXJYzFrF1e/savxJTyhA+LwO8HebK5NufBYe03K5bdSeXIKIBdm/LqpsStNwarXKEB08rsD8
 9Z+WKVgkC7prxbaZajKHRs+Fa8=
X-Received: by 2002:a05:6a00:2d11:b0:85f:3dd6:f426 with SMTP id
 d2e1a72fcca58-8616a0691a0mr39389217b3a.17.1788886505311; 
 Tue, 08 Sep 2026 09:55:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86207a4d602sm5096741b3a.22.2026.09.08.09.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:55:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Alan Carew <alan.carew@intel.com>, Richael Zhuang <richael.zhuang@arm.com>,
 David Hunt <david.hunt@intel.com>
Subject: [PATCH v2 2/3] power: check for errors when writing frequency
Date: Tue,  8 Sep 2026 09:52:33 -0700
Message-ID: <20260908165447.450006-3-stephen@networkplumber.org>
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

The sysfs file is buffered, so fprintf() returns success even when the
kernel rejects the value. The error only shows up when the buffer is
flushed, and the fflush() return was never checked. A failed frequency
change was therefore reported as success.

Use write_core_sysfs_s() which already does the fseek, write and a
checked fflush.

Fixes: 445c6528b55f ("power: common interface for guest and host")
Fixes: ef1cc88f1837 ("power: support cppc_cpufreq driver")
Fixes: 1ed04d33cf19 ("power: support amd-pstate cpufreq driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/power/acpi/acpi_cpufreq.c             | 12 +++++-------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 16 +++++++---------
 drivers/power/cppc/cppc_cpufreq.c             | 12 +++++-------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index af85a8cdec..4ee3d5bd26 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -54,6 +54,8 @@ static struct acpi_power_info lcore_power_info[RTE_MAX_LCORE];
 static int
 set_freq_internal(struct acpi_power_info *pi, uint32_t idx)
 {
+	char buf[16];
+
 	if (idx >= RTE_MAX_LCORE_FREQS || idx >= pi->nb_freqs) {
 		POWER_LOG(ERR, "Invalid frequency index %u, which "
 				"should be less than %u", idx, pi->nb_freqs);
@@ -66,17 +68,13 @@ set_freq_internal(struct acpi_power_info *pi, uint32_t idx)
 
 	POWER_DEBUG_LOG("Frequency[%u] %u to be set for lcore %u",
 			idx, pi->freqs[idx], pi->lcore_id);
-	if (fseek(pi->f, 0, SEEK_SET) < 0) {
-		POWER_LOG(ERR, "Fail to set file position indicator to 0 "
-				"for setting frequency for lcore %u", pi->lcore_id);
-		return -1;
-	}
-	if (fprintf(pi->f, "%u", pi->freqs[idx]) < 0) {
+
+	snprintf(buf, sizeof(buf), "%u", pi->freqs[idx]);
+	if (write_core_sysfs_s(pi->f, buf) != 0) {
 		POWER_LOG(ERR, "Fail to write new frequency for "
 				"lcore %u", pi->lcore_id);
 		return -1;
 	}
-	fflush(pi->f);
 	pi->curr_idx = idx;
 
 	return 1;
diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index 13ffcefc84..f7e32fe0ac 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -57,17 +57,15 @@ static struct amd_pstate_power_info lcore_power_info[RTE_MAX_LCORE];
 static int
 write_freq(struct amd_pstate_power_info *pi, uint32_t idx)
 {
-	if (fseek(pi->f, 0, SEEK_SET) < 0) {
-		POWER_LOG(ERR, "Fail to set file position indicator to 0 "
-			"for setting frequency for lcore %u", pi->lcore_id);
-		return -1;
-	}
-	if (fprintf(pi->f, "%u", pi->freqs[idx]) < 0) {
-		POWER_LOG(ERR, "Fail to write new frequency for "
-				"lcore %u", pi->lcore_id);
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%u", pi->freqs[idx]);
+
+	if (write_core_sysfs_s(pi->f, buf) != 0) {
+		POWER_LOG(ERR, "Fail to write new frequency for lcore %u",
+			  pi->lcore_id);
 		return -1;
 	}
-	fflush(pi->f);
 	pi->curr_idx = idx;
 
 	return 1;
diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index aed44c1212..3bcd4dec41 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -63,6 +63,8 @@ static struct cppc_power_info lcore_power_info[RTE_MAX_LCORE];
 static int
 set_freq_internal(struct cppc_power_info *pi, uint32_t idx)
 {
+	char buf[16];
+
 	if (idx >= RTE_MAX_LCORE_FREQS || idx >= pi->nb_freqs) {
 		POWER_LOG(ERR, "Invalid frequency index %u, which "
 				"should be less than %u", idx, pi->nb_freqs);
@@ -75,17 +77,13 @@ set_freq_internal(struct cppc_power_info *pi, uint32_t idx)
 
 	POWER_DEBUG_LOG("Frequency[%u] %u to be set for lcore %u",
 			idx, pi->freqs[idx], pi->lcore_id);
-	if (fseek(pi->f, 0, SEEK_SET) < 0) {
-		POWER_LOG(ERR, "Fail to set file position indicator to 0 "
-			"for setting frequency for lcore %u", pi->lcore_id);
-		return -1;
-	}
-	if (fprintf(pi->f, "%u", pi->freqs[idx]) < 0) {
+
+	snprintf(buf, sizeof(buf), "%u", pi->freqs[idx]);
+	if (write_core_sysfs_s(pi->f, buf) != 0) {
 		POWER_LOG(ERR, "Fail to write new frequency for "
 				"lcore %u", pi->lcore_id);
 		return -1;
 	}
-	fflush(pi->f);
 	pi->curr_idx = idx;
 
 	return 1;
-- 
2.53.0

