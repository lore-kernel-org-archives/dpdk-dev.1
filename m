Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9FC282EC
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 15:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AD064069F;
	Thu,  6 Mar 2025 16:25:24 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EE82D4065F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 16:25:21 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5269IQjc018216;
 Thu, 6 Mar 2025 07:25:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Sh19I8NRY2oj6wPn0c2B1rF
 ReQr45hwD/PbpVsX5S1M=; b=XYEqZIPlJvBhGulNzX6jdC17219hJOmWM6q3OMP
 gDUz3YoFSJha3iODjliJe3wtLUOGZzZC39EwvD2xOkbX0noVrJtuBjGhWQJCnAxe
 4N5CtbvFcaRA1p4IaOrVaLpHDUOF9JVQiwzwNxGdvl/ePWX+sJzZ19mh5gxIihcZ
 zkeodxJ2MMLieHm9LuCZfyTYP+DGnHZl89NTGHgmyS7aFEduNdzZLbMHw4pYzjbc
 EFoe+WB2ubaIkh6mfsMLXxWWfFtAkSjLY7ZTt8I5JIdRKvOxnKT25YMpGt/ktefW
 D0uMoF9OVmOx4DK1XlypksVD1PdFlNV+67bYLPxnqMUxY1g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4578y68nht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 07:25:21 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Mar 2025 07:25:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Mar 2025 07:25:20 -0800
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 8CCCE5E6879;
 Thu,  6 Mar 2025 07:25:18 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] devtools: fix regex of cnxk skip files
Date: Thu, 6 Mar 2025 20:55:16 +0530
Message-ID: <20250306152516.2594-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cesormDM c=1 sm=1 tr=0 ts=67c9be61 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=Sh4DNex_L8NkXwtVnqoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: z1CYZiWcEFO5IbWyRsYjGFFxQ9ZVJ1tS
X-Proofpoint-ORIG-GUID: z1CYZiWcEFO5IbWyRsYjGFFxQ9ZVJ1tS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

SKIP_FILES should include the path of the file.
Update the regex to match the path.

Fixes: dd88f51a5725 ("devtools: forbid DPDK API in cnxk base driver")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 devtools/checkpatches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 003bb49e04..63638bc7fa 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -236,7 +236,7 @@ check_forbidden_additions() { # <patch>
 
 	# forbid rte_ symbols in cnxk base driver
 	awk -v FOLDERS='drivers/common/cnxk/roc_*' \
-		-v SKIP_FILES='roc_platform*' \
+		-v SKIP_FILES='.*roc_platform*' \
 		-v EXPRESSIONS="rte_ RTE_" \
 		-v RET_ON_FAIL=1 \
 		-v MESSAGE='Use plt_ symbols instead of rte_ API in cnxk base driver' \
-- 
2.43.0

