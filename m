Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC486C282EC
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Mar 2025 09:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6FA040150;
	Sat,  8 Mar 2025 10:01:43 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C9C5240144
 for <dev@dpdk.org>; Sat,  8 Mar 2025 10:01:42 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5287qlYS020626;
 Sat, 8 Mar 2025 01:01:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=mdPwGJFFHXw2+RfHCLRvtFG
 2R6hMapVZGP8ophFDFcs=; b=JjL6+RQfOsL7+C3VPZ4eAv5Nv3OYKk6WdGJ+N7C
 CK9+Bj8DdHIVUYx2cDYaFoRmKwdyrmA8zDL0I4APSNzjbfl4KYU1pkZbY01nzmQn
 ntXWpneEX7PvlLLSwJoL7P5MDnaZhZrFzhUPZaK7a3KsUjt1iK3BBBhm0ew6k/9H
 MWLL0f6Mrekj7rQ5dXdynoItS+9ELmBYPQoKNh3BizJYkLAZht+aaHE1xt74teVi
 aXgXB49832J8yPO7dOrLViQMWRNL1n5Oaj1qKSkoYuYVVtxLHSP2BQnIdToh9IhM
 /2svtzm4m0+IB8wjDGLLpuERUrFxE0LZgOOgq+mks37kEDg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 458ewb0999-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 01:01:37 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 8 Mar 2025 01:01:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 8 Mar 2025 01:01:35 -0800
Received: from MININT-80QBFE8.corp.innovium.com (unknown [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 0585D3F70B4;
 Sat,  8 Mar 2025 01:01:32 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] config/arm: add crypto to cn9k soc
Date: Sat, 8 Mar 2025 14:31:30 +0530
Message-ID: <20250308090130.4696-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6yaZuKR9h3EWgQhKAQwHo-gpMUYC5ewj
X-Proofpoint-GUID: 6yaZuKR9h3EWgQhKAQwHo-gpMUYC5ewj
X-Authority-Analysis: v=2.4 cv=V8uH0fni c=1 sm=1 tr=0 ts=67cc0771 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=yYf38RPKQCM_zjj2upkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_03,2025-03-07_03,2024-11-22_01
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

Add crypto as extra march feature to cn9k soc.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 config/arm/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 7f85b088c9..a97a28ebb7 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -446,6 +446,7 @@ soc_cn9k = {
     'description': 'Marvell OCTEON 9',
     'implementer': '0x43',
     'part_number': '0xb2',
+    'extra_march_features': ['crypto'],
     'numa': false,
 }
 
-- 
2.43.0

