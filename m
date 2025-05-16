Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338BC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 12:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B554402B1;
	Fri, 16 May 2025 14:10:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7394A40144
 for <dev@dpdk.org>; Fri, 16 May 2025 14:10:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G7vAjf008755;
 Fri, 16 May 2025 05:10:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=6iUm6e00fCHQyypfvEoPEz9
 Zpd//m8pmGDYvBl34gt8=; b=To+kiYJS6BylccY2EKD7dU2wODEQKop7P4VYIoK
 vmnBplKTwF0sOZb+9CDk9wpdfVABhna6921vJkng333AFCCGwZ+Gm6odyhqXE3RC
 OQSQDVJjxwS2sKqgrNCEdxaD+vSTA/HbR/8Qwr1+cax9PKCvGzQVQAnMx5yTQ23u
 aZEbpgV0/oDxH2mKws/koD6zZFgcgvv5IILr2r0+GWWV9F07aObh34UBe0OrVYey
 ny3CQi0fUldJPjUg55ZgJ3ebtiXxMq56zIwD/Us1Db8VwuPZ4fTV/XVfezQHo1gP
 v1NFN95KJNW1Of0NcPiSEw0HvZuYnIPNTnuNlAGkIiD5FeQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46p1du0dgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 05:10:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 16 May 2025 05:10:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 16 May 2025 05:10:51 -0700
Received: from cavium-SR1-T640.marvell.com (unknown [10.28.36.102])
 by maili.marvell.com (Postfix) with ESMTP id DA9D03F7051;
 Fri, 16 May 2025 05:10:48 -0700 (PDT)
From: Akhil Goyal <gakhil@marvell.com>
To: <dev@dpdk.org>
CC: <suanmingm@nvidia.com>, <anoobj@marvell.com>, <kai.ji@intel.com>,
 <hemant.agrawal@nxp.com>, <brian.dooley@intel.com>, Akhil Goyal
 <gakhil@marvell.com>
Subject: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Date: Fri, 16 May 2025 17:40:43 +0530
Message-ID: <20250516121043.145572-1-gakhil@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: d50PU7sV3I-6j2VheDeKHdSAZIaMISzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExNiBTYWx0ZWRfX2Y0/o6jSLAso
 OhYwAHKYeb+rOorCC4k4FEm1+19y1tCnxNsGDNBNuyAFcgxMTi3JwtM/YVMIA4gyzaOXmnRVN5J
 +5BE4EfTWjt7vWkEGOqIsf5idItMKfYMcq/8bQbcg4Nnwg5r4cYkr855OiF5gMaqKHTIz8OtmRH
 uucsu2tf/xIoijMISVb1tFxN6I6ZXz4w2Q3cBt2bvpJq3GC5tYOX8ILvC57yhd6v3NhGdBPL1gD
 CI21ahEotPcg0U+uomW+R33MILiszqJGD7IVYYkWNjx/ubTE6z5pCuCTfQH/TINqe9h6rikB2kF
 WIfqqB417ZIB6+JhRxlWQpf7wlfS6+bHmVfiveQZHzgsD2ZOT1DMMe0z8htNYbtKQmsZZaxtsmU
 a7w9xAGOa1s+qtFLQxMx4qARjvC4uoZQAosdg+m4l/LJk8BQC2ZOHwYN7QrHKO3wClI7793m
X-Proofpoint-GUID: d50PU7sV3I-6j2VheDeKHdSAZIaMISzv
X-Authority-Analysis: v=2.4 cv=fvPcZE4f c=1 sm=1 tr=0 ts=68272b4c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=vdPL91twqqmzCy3sNZoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
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

When segment-sz is given as parameter,
use buffer-sz in descending order.
The reason is, same scatter gather buffer list is being used
for all packet sizes which is initialized once in the beginning.
Now if a small packet case is run first,
mbuf SG list will be trimmed to a smaller number of SG and
rest of the SGs are lost resulting in segfault.
Buffers cannot be re-initialized as that will come in datapath and
will be costly.
So to workaround this, if segment-sz is passed as argument,
use values in buffer-sz in descending order.

Signed-off-by: Akhil Goyal <gakhil@marvell.com>
---
 doc/guides/tools/cryptoperf.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index e53e2d0ebf..a3d35f6a50 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -139,6 +139,7 @@ The following are the application command-line options:
 * ``--segment-sz <n>``
 
         Set the size of the segment to use, for Scatter Gather List testing.
+        Use list of values in buffer-sz in descending order if segment-sz is used.
         By default, it is set to the size of the maximum buffer size, including the digest size,
         so a single segment is created.
 
-- 
2.25.1

