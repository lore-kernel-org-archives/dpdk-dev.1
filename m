Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE8C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F6E140A7D;
	Fri, 27 Jun 2025 12:58:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1516E40A4B
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:58:08 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QNV7pD019382;
 Fri, 27 Jun 2025 03:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 0OKrcg7d1Ljahf089tMgNuat3ruvBtaiRh7alnR/Xs=; b=Egr7OPxeE8cy+QUHn
 HKp4lxleXO1fOvoWEQ3B8Bc1SJhcgqdFkD3P7sr2lfND72T+rpJebtmli152XSzI
 y7yJTjF7Wx6cW7vJIPPF0VpW0YxKzm6+OtjcxSUYeZzlOLdgsTqSXXJw8qHahw7x
 cBrAGz5smQAy3y60Ru8+FgF24FjFx8L5wTT7m1JVInlqSWjuVD1snCNxwNOeIYCr
 Bsh6uTGgdyfhvuMz9jlMTkZJn2qigg9xl8YIC12gHwNTPi0SaWCPUz7MZrcsweli
 uybEp4dnETKDybNngceBF8r69JkAISuocQLlouNhe8vOY7DY7OJqQVeObiYbpsSG
 fD7/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hfxph72n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:58:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:58:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:58:07 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 250EA5C68E3;
 Fri, 27 Jun 2025 03:58:04 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 8/8] lib/pmu: fix out-of-bound access
Date: Fri, 27 Jun 2025 12:57:40 +0200
Message-ID: <20250627105740.3388237-9-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX88YdAMwvsIQJ
 NWJQpw55MwvFkfqR03TJd3YbPVWR6mOwPteIx6WyaCalVewRhnyVbNP/V8mOkOjBwZajmT8cGeP
 b4KVdjJj+GQV94MdykR2UuouNwMJ5X86P1EYNUYl57pCcvUMsBWbUASglo2cpfTjaexaz6eP+e3
 1c/GYo3umS3xIRuHk5mnex7ryfC0utxzgmzAbJ5mmpvugJct21fXftZX1sVkLjPxpn6ixmTEQMq
 h2qoxGXTvr+47cP930fr62qVbUJ8jR6WjGVzS1J2w5ZEgPyIgzNI2hNU3ilgdvBf5DoYGDqyNfr
 e7GVcmwbG8lXdnCoXxvfUUltvtJGBVaVoY+ZHX2c9lqGAjLzvQxXkfTM6BI+RzcLuaf8fF96btC
 lFGyIk0jszmev9xh/z7h5R0k8SpHzpN87wVe16qxABv0ZdXrrYcukZ74r5ydU6a1odg4jKMF
X-Proofpoint-GUID: 3IVjHoBc_SLTFH06KmV0r8DfQaaYDZhV
X-Proofpoint-ORIG-GUID: 3IVjHoBc_SLTFH06KmV0r8DfQaaYDZhV
X-Authority-Analysis: v=2.4 cv=D/BHKuRj c=1 sm=1 tr=0 ts=685e7940 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

Make sure that out-of-bound access does not happen by saving one byte in
buffer for NUL terminator.

Fixes: a8926a65ad1d ("pmu: support Arm")
Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
Cc: tduszynski@marvell.com

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/pmu.c       | 2 +-
 lib/pmu/pmu_arm64.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 742829cf9d..8960faa7d0 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -126,7 +126,7 @@ get_event_config(const char *name, uint64_t config[3])
 	if (fp == NULL)
 		return -errno;
 
-	ret = fread(buf, 1, sizeof(buf), fp);
+	ret = fread(buf, 1, sizeof(buf) - 1, fp);
 	if (ret == 0) {
 		fclose(fp);
 
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index 2c40b5f702..f3a817b42f 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -24,12 +24,13 @@ read_attr_int(const char *path, int *val)
 	if (fd == -1)
 		return -errno;
 
-	ret = read(fd, buf, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
 	if (ret == -1) {
 		close(fd);
 
 		return -errno;
 	}
+	buf[ret] = '\0';
 
 	*val = strtol(buf, NULL, 10);
 	close(fd);
-- 
2.34.1

