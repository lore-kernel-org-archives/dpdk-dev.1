Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0893CC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E0FB40E25;
	Wed, 25 Jun 2025 06:48:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5E76B40E2F
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:59 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONWBZe012688;
 Tue, 24 Jun 2025 21:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 0OKrcg7d1Ljahf089tMgNuat3ruvBtaiRh7alnR/Xs=; b=FJRx3zuvEyacF8+99
 Jb2BIt/0o17zEhfjUL8pY0PCdFxk1+yy3Hkz/KJH23P16vpMAlmjKvMzjlGucLXS
 fAMcoe3ePhD0C86DhkNLpGeUn0VqFc1rE/uSVQJZKrnPKbFYqpyiLD2P0bfaLLfm
 bhQkI6wATah4ByPoFkN+QKxfMIRcnuvuzxP5M75qloT1zmPMr/1HqThFkkQHfLHQ
 EI2yuiCzT9WNdc1Yc22BZjniTgLaDh+cegUGiabtTBNjTJ9nI9S1z4fVa2QxulcV
 Y/9EyEeC8pljrHpDH1/0gYTe7k3Zie7qYPDFWbtrQoUG804WijiRNQjzLKuc/3dB
 /9yKA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g5r90gmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:57 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 411593F7062;
 Tue, 24 Jun 2025 21:47:55 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 8/8] lib/pmu: fix out-of-bound access
Date: Wed, 25 Jun 2025 06:47:30 +0200
Message-ID: <20250625044730.2435526-9-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BcJyWTQk0fXnvzHOU8aJwqr8gOxIalEJ
X-Authority-Analysis: v=2.4 cv=GYMXnRXL c=1 sm=1 tr=0 ts=685b7f7e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BcJyWTQk0fXnvzHOU8aJwqr8gOxIalEJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfXyHvlcnZ3sip/
 QIDy3qnqjFxkLSyDIrWtxVlxukq1WvUbRvA8tanQ+vwN0eAn8wDj2t4wDru23ou5eEjj9gurLzo
 sOuUWkyhEHyeBbzwHmK3/YbCpFB1S3b7CMEk1DMzbi9f3ytY+/k/Uyl5hxXb/GDuG5HhUtSNOSp
 rjYbLUEdehrcwcP3fI1ZpmZUQBdAQF/6oGd3nNXTM6SDXR+tvJWlLavTDCLvF83raWpnfm9SS5I
 lDb3pvZ+Uyf/sexVwH4HLwhY/CQAgh1x4wk4KEHvNyTWXmrCb0+2b3gpmk/VZE2Iglz7XydumOc
 igZIQsxKrF61PXU2vn9J88K/zKJodhSQr+VqU1FNy3sP0mQQjLGStaO6qQiXpBqLx57E4FYTPmL
 ljoyHzNktuYQHKMdFAJ6yz5Tu8deR/xTpaE01tR8RJODpYtAQAJnwnjy7XL56PBqD1WYTg7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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

