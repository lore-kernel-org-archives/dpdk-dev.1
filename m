Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4FC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C33E840A7F;
	Fri, 27 Jun 2025 17:41:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DA64840695
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:36 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R9xnHO018599;
 Fri, 27 Jun 2025 08:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 0OKrcg7d1Ljahf089tMgNuat3ruvBtaiRh7alnR/Xs=; b=bdBE86u5d60zJEPYP
 JU5PPorl8vREGWeg2f32NQkU4WJk8vXyl7eHg3g72kGjVyv2R/J0Mhf2Jhdcn0V5
 pmfHHI8q/s3IH+wojjmyq9/Rg0nS57cmmpf1RMHy/OUH2YI+epBWCxGntcCApLcG
 v5K6n/VVDNAv6JrDw27Y/S9eXj0a7/oj0Iu+VDLks4lJKm24ztQHdix1ld6gh/xz
 y2tBf+2CJ5HegwEiPP8mtExIOYP46FjVa1uQR3cNKWMrLFrLOoXXDvdbOWXY0MT6
 DniPYvZWtU/+iMLYNOo4JVKiT4Kwr9bBInTgK8nabub1Rkpjos9MMEhEw2SXShXx
 I7Tlg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c8vpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:35 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id E78B13F705C;
 Fri, 27 Jun 2025 08:41:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 8/8] lib/pmu: fix out-of-bound access
Date: Fri, 27 Jun 2025 17:41:07 +0200
Message-ID: <20250627154107.3405768-9-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YsmjsJCVX9QPF28RJewNUqFQDy4qxLUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfX3IAFOEIrZuK7
 t9zrMpKWea0G6OERilNEd4T4BDuaTR5tWhEtH61EuQeNWaVa4iDDUX/ewthOIP535TwZTvwMogx
 QutchUlSK9WefinN5207NOUDtHzBRQjxDYMEqLzWH14W/uQwdWW3WECnAntPJFjwZlMurqz3Ypf
 dtjn1t8rGYXlIuTHYLovKgVHXDBWVOHu15JD8/dQHN0VIjnI6B0xyMSzqMM+OZt1P8Lco5IxBdq
 xE79Fl2lsCeVbj43jYL4UQMti9T9sTXo/mdAS2IEfA82qMhhowdGBaQ3AM1xHdwkbClxntr6FO9
 foR2xBJBSL94MZOykvLlOgrmf0V74DL5LYOiEvj4V+RGiGZTqvhttwC/+Dh7vfyPtu0AXYg++1j
 Ztx6BfTbrMuH08WQhCF/Ga7odZ8n/+WrwnpPSHUCSY3uD6E1FQ2PoqEy3HswAUydceo+PsQi
X-Proofpoint-GUID: YsmjsJCVX9QPF28RJewNUqFQDy4qxLUO
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685ebbaf cx=c_pps
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

