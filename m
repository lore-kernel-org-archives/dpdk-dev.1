Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B1C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 11:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 899B7402E6;
	Thu, 27 Mar 2025 12:13:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 354B8402C8
 for <dev@dpdk.org>; Thu, 27 Mar 2025 12:13:51 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RAFkkD009964;
 Thu, 27 Mar 2025 04:13:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Xn7ww9HY6Aqot/kFRNuxm9W
 /7WwAeNT9i8iTu+fTXeA=; b=Ljc9tVhyr87suw+UgT2HJkRe4fvkDpYeypp5SA4
 p8qbJ3oXwq7Aq47ZRaEJ102ZNRl6ecgB/6IiFWRNZkxUprTIbS8SmEMRHJtUeFkp
 NEtAXJSH29TfWct5vZFyVHNcVypxgY8DViuCHf1Dza8htXrEQkZpC/EdDRj1n9n3
 SyTj3UDkQE3xZiStuYtiSKwKr80eoiGNqy34xn/+KeRxUx6hTJC0YiUoM3eoqv3B
 MaSvK3aKiFggsuICNAzBQ4wSWpxMBVNctz8Q+mxCyFps3La7rZKGXYUpVislK4e8
 WsdbeynHqJ+pPVyiYkYRCN+HmA+BgtsIqu5inLxENa/qeVQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45n4rx83p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 04:13:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 04:13:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 04:13:49 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 89DA63F7048;
 Thu, 27 Mar 2025 04:13:47 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] devtools: exclude atomic checks for common cnxk
Date: Thu, 27 Mar 2025 16:43:44 +0530
Message-ID: <20250327111344.2205-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N/0pF39B c=1 sm=1 tr=0 ts=67e532ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=suZZMOYg9eVWFssnuagA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: HtMdBCa4drz-OzuU8WxpGJ5VPJ96jvgN
X-Proofpoint-ORIG-GUID: HtMdBCa4drz-OzuU8WxpGJ5VPJ96jvgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
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

Since driver/common/cnxk has common code that is
used across multiple platforms, allow use of
GCC builtin atomic functions.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 Rest of drivers i.e., drivers/*/cnxk have been migrated to use stdatomics in:
 https://patchwork.dpdk.org/project/dpdk/patch/20250327111120.1641-1-pbhagavatula@marvell.com/

 devtools/checkpatches.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index c9088bb403..2470d4fa83 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -139,6 +139,7 @@ check_forbidden_additions() { # <patch>

 	# refrain from using compiler __atomic_xxx builtins
 	awk -v FOLDERS="lib drivers app examples" \
+		-v SKIP_FILES='drivers/common/cnxk/' \
 		-v EXPRESSIONS="__atomic_.*\\\( __ATOMIC_(RELAXED|CONSUME|ACQUIRE|RELEASE|ACQ_REL|SEQ_CST)" \
 		-v RET_ON_FAIL=1 \
 		-v MESSAGE='Using __atomic_xxx/__ATOMIC_XXX built-ins, prefer rte_atomic_xxx/rte_memory_order_xxx' \
--
2.43.0

