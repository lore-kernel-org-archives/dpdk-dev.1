Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30268C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6106740A8A;
	Thu,  6 Mar 2025 18:12:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 324B64064A
 for <dev@dpdk.org>; Thu,  6 Mar 2025 18:12:17 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526AJbGt019834;
 Thu, 6 Mar 2025 09:12:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 KfDt0+R9OjqAFwfgtchm0FWs5QaAgcxf10GvXARdeQ=; b=kng7uXakftPVeCVUj
 b4N4ppzBCGQtg2Dv6VuPZ+gwmECrudr90oO4UsXKA9IMM6YDwDUUJmsQW/h6NqHt
 nPrynPFJ8SYA3FsAuvhTkK42dsNFDCo/6A8S07bJLsDeGTwQpUTQLS4v7HLcYZm7
 RQSw2KTlygfvzKBQwWwg9QAiSTVGQs8Nk6sUrZB2XoLsxFmJHWpGCO6KFum6cSbY
 Bk0/AfyaHXzlc4TYBBn3CNSyujtOZ514aJjw0DJvMwTtOp179QU2SRQsd9VHpfLE
 C+siXHHgKAusVMB79yxWOgVNzG2D8xzl6DWoS3uKVyB0LyyHuDhU186qzvSOI9Mj
 VbwyQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4578y68w42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 09:12:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Mar 2025 09:12:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Mar 2025 09:12:15 -0800
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id C77E662676C;
 Thu,  6 Mar 2025 09:12:13 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v2] devtools: fix regex of skip files
Date: Thu, 6 Mar 2025 22:42:10 +0530
Message-ID: <20250306171210.3707-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306152516.2594-1-pbhagavatula@marvell.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cesormDM c=1 sm=1 tr=0 ts=67c9d770 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=fVPTlCRVZE3kwK5_-uUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QYhGfnEkM51lSA2ajxYCqcy4z-Q992Ra
X-Proofpoint-ORIG-GUID: QYhGfnEkM51lSA2ajxYCqcy4z-Q992Ra
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

SKIP_FILES should include the path of the file along with the name.
Update the regex to match the entire path.

Fixes: dd88f51a5725 ("devtools: forbid DPDK API in cnxk base driver")
Fixes: 2b843cac232e ("drivers: use per line logging in helpers")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
v2 Changes:
- add fix for osdep.h. (Thomas)
- Use the correct regex pattern for matching file name at the end. (Thomas)

 devtools/checkpatches.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 003bb49e04..c9088bb403 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -63,7 +63,7 @@ check_forbidden_additions() { # <patch>

 	# refrain from new calls to RTE_LOG in drivers (but leave some leeway for base drivers)
 	awk -v FOLDERS="drivers" \
-		-v SKIP_FILES='osdep.h$' \
+		-v SKIP_FILES='.*osdep.h$' \
 		-v EXPRESSIONS="RTE_LOG\\\( RTE_LOG_DP\\\( rte_log\\\(" \
 		-v RET_ON_FAIL=1 \
 		-v MESSAGE='Prefer RTE_LOG_LINE/RTE_LOG_DP_LINE' \
@@ -236,7 +236,7 @@ check_forbidden_additions() { # <patch>

 	# forbid rte_ symbols in cnxk base driver
 	awk -v FOLDERS='drivers/common/cnxk/roc_*' \
-		-v SKIP_FILES='roc_platform*' \
+		-v SKIP_FILES='.*roc_platform.*' \
 		-v EXPRESSIONS="rte_ RTE_" \
 		-v RET_ON_FAIL=1 \
 		-v MESSAGE='Use plt_ symbols instead of rte_ API in cnxk base driver' \
--
2.43.0

