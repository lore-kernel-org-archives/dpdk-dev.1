Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6592C624D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 08:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C228640374;
	Wed,  2 Sep 2026 10:25:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 89DBC402F0;
 Wed,  2 Sep 2026 10:25:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6826VCiW1787165; Wed, 2 Sep 2026 01:25:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Mkxsh+TPbFwoMStj5n6u4Z0
 vHo5Ixqyl2sibeSwtrZM=; b=lFmDWIYCsaErLdYi1IpRENhVptKaXtt9qly2nrT
 yYzl5iDxMT4k/haW0P0lVHVv8Nk9DCaIUa/4+iHTSzgDGdr3IrNqPhSa3Ri2xxX9
 RBwRshKlgD6u6T4Kel65yqvbGQvquukSzi6OMN1aLS7cnDp6v3ifh11DYXtXKYon
 wDghVoru0ARhnxcab2YQU2bsN6wSNTADgYkmZosMTovVOW6B926i5g5p4psGl7DH
 mWPO8pXcqdrjOJf1E9Q1H0gYM9ePGPs2dJhaVrDtNG9S5iVeVzI+uLiopjQAWtW6
 /yPgdcS/6StnmV4scHUDP3o6o82ThhRo8O/517Wk2KlEOTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ge4ve1q4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 01:25:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 01:25:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 01:25:36 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id 917713F704D;
 Wed,  2 Sep 2026 01:25:34 -0700 (PDT)
From: <jerinj@marvell.com>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, Jerin Jacob <jerinj@marvell.com>,
 <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH v1] examples/ptp_tap_relay_sw: fix build inclusion
Date: Wed, 2 Sep 2026 13:55:23 +0530
Message-ID: <20260902082523.206083-1-jerinj@marvell.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gQclw3kGuMDqiXqs5btD1NO_OZSkxcsK
X-Authority-Analysis: v=2.4 cv=J9aaKgnS c=1 sm=1 tr=0 ts=6a97dd82 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=7aLAe6btT5AUPeCllDgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: gQclw3kGuMDqiXqs5btD1NO_OZSkxcsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NCBTYWx0ZWRfX4Zx729b2U3Tf
 8DUbymGfdJuofF43e4mNPpUduE50UCiMikhPiG4jb9EqOd/QG1grkEZ+YW3OmHbgcpxXA3o0YPu
 pXEE1GdEM7cpLtaqDXUJKmCbjB/t5tE3IPPVY5l5+eIxtwZIZcgoDhHDGvLJluIO3RfMnKiagb4
 c382ZVE0e16Gt73p+VhmVzfI+FS/x9SOlPewBl7lOemDC0A5qXtLQwZJ9eSCGrPbsFIvxuFwS5N
 UKdUnR5ciDVNxGVjbFvr0bUxT59hEBu0ORnDSBgaiH0DwzO35ldUro5e3P7GB+HbKzfqkaH+UNs
 dBgdqrHSfSy+DxZJT41dFvMrcQp+yJ3Tj/XIdwx8dVMh0ggeeyVnxu4e4ekjUiFHKiKyr2ST1XZ
 zV8+Hymg3y/e1sKp3K1j0zXCQmgp2z4XLCGuFzu5TZ/T/w4xWcZkpoAoi0yaWM8EtR1aVa83beu
 k5g2JeOdCdhIbQmRYVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NCBTYWx0ZWRfXwMXrF8ekkND3
 kCBPRhNGoXV97g0HSq+/XYkS6CjN5g9AWNK9PbzQjaoPRa37By1EY9mWlcjEIeXXvtADSu/cYHy
 i+oCMM/78391fi6JkECi/oVzwl49VXc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
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

From: Jerin Jacob <jerinj@marvell.com>

The ptp_tap_relay_sw example was not building because
examples/meson.build was not updated to wire up this directory.

Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
 examples/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..ab82cf5fbd 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -43,6 +43,7 @@ all_examples = [
         'packet_ordering',
         'pipeline',
         'ptpclient',
+        'ptp_tap_relay_sw',
         'qos_meter',
         'qos_sched',
         'rxtx_callbacks',
-- 
2.54.0

