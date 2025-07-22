Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3CC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0C3840615;
	Tue, 22 Jul 2025 14:00:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2A63840615
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:00:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBfMiN004770;
 Tue, 22 Jul 2025 05:00:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=NPMDJD30LxD6QtuLG
 SO7GlwDfU62IiyRppjpmDjTanGobocKRxlyXXuZ8TP03e+vaTq1E91hHhYJK01G6
 FMw5VWXgQDPOIc3MEkcSeYjnHrJnxQP/dGf5ZPHVaMfDNsTwWvXwgIWGL4v/8W8i
 yF/DWnb2JTQzgtOfSc/P7PIXZXfE4VOgFcwkbPbCSkd+qcnrsOCZPOBGy/Yi+a+B
 krgqqjhNxF83PHpN1ozXB0l4aOTu2rKiqL6xlxcT5R4LaVNtQUn98lXdVjQrSEw9
 YgfXBkUIimTOR0UG2dBipMQPYL0HEQZ1JyET1K0yR0X2HM9Qbr/X3V5Z28Xx51zR
 /DMJQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482a0600u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:00:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:00:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:00:52 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D54443F7045;
 Tue, 22 Jul 2025 05:00:49 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 2/8] lib/pmu: export only necessary arch headers
Date: Tue, 22 Jul 2025 14:00:35 +0200
Message-ID: <20250722120041.2718227-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=M6lNKzws c=1 sm=1 tr=0 ts=687f7d75 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 58dON84DO7c6UIzU0fkMqOOjSHXV4EfG
X-Proofpoint-ORIG-GUID: 58dON84DO7c6UIzU0fkMqOOjSHXV4EfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfXyeVOpq1ugSDL
 enJYCr7N6GcamIJxKSOyzY3UqyOj6FyAT/Ctct0BmBc8iem/N159nUF+5KZX+TEBCc5ND9LfF87
 ZwG7kJReu4eXUc20wcFUlv+55+goQEOmZ52odx9vX9RXyBqUQnBR08szfI9mEdxXam5zDIH+p/3
 E5hR1rfkC9h4mEP4U71YPBXJ21Ec2ng591TZ3g1kakDgPkWPCjexl7DkFO+IyOQhU726/l6rMX1
 L6pIrCmfmYepu9SezGcBYqaPc0UQE+IzfyCm/odwdDkdW7vW4Oplw2hLrhoMYBGmRNWYW8ZmubS
 kZriE8uuiEppQzeOisQRyYDU1hddNCIG5rck+Rg2BI7wYlAJXwXhb7vu22N9oF0FRGzlnJvi2+R
 A5r+hP1tyjeU/WiYdaLq2m67f78Gx0zAcaS571fy9vsfvYkRl5gkzBlX+CZrnany1YNyBs26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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

Install only architecture specific headers to avoid header pollution.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/pmu/meson.build b/lib/pmu/meson.build
index bcb6d10f1a..53013d0ed6 100644
--- a/lib/pmu/meson.build
+++ b/lib/pmu/meson.build
@@ -10,13 +10,13 @@ endif
 headers = files('rte_pmu.h')
 sources = files('pmu.c')
 
-indirect_headers += files(
-        'rte_pmu_pmc_arm64.h',
-        'rte_pmu_pmc_x86_64.h',
-)
-
 if dpdk_conf.has('RTE_ARCH_ARM64')
+    indirect_headers += files('rte_pmu_pmc_arm64.h')
     sources += files('pmu_arm64.c')
 endif
 
+if dpdk_conf.has('RTE_ARCH_X86_64')
+    indirect_headers += files('rte_pmu_pmc_x86_64.h')
+endif
+
 deps += ['log']
-- 
2.34.1

