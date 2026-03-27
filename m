Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B510BA422
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 04:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6D25402E2;
	Fri, 27 Mar 2026 05:15:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D24C74026A;
 Fri, 27 Mar 2026 05:15:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R2T3Cq2680596; Thu, 26 Mar 2026 21:15:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=IDOnxsnujOAPZsagZC9v7In
 +E7jvN6nbk5Xn2ttcEtc=; b=OWiMqKPBdgt5B03xJjEkX0w53UNb9oW87M1gTmH
 aFqScGHjwbZwq+qXspB/QcunyAgUL6Z14PGsEM1/zciiuJGexOq57GMdLfRCoQvh
 6Oe6g3TrDGDu56q76O/PU9/zAHcDpbS9M7fSrtGcoV1IsZd7MZZokjIqZUfeOvGk
 JRchqTyDH7ZhG5IXOghujCBOI4eekGkot6WI++hFsCYSKFpHKXnujIuH42riW8LG
 6Kozn8C5TOuJZ33e5ZrAVfRXqY2gsAm5v7GdbavrJWinuTGNRn099MNpPodmaMUY
 exoYz/hx4QJT8rBfxasW3Ub3vrqY3lzIQR1mSdHBQTkrZ4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d5h56855x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 21:15:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 21:15:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 21:15:48 -0700
Received: from cavium-OptiPlex-9020.. (unknown [10.28.38.192])
 by maili.marvell.com (Postfix) with ESMTP id 50E7B3F705C;
 Thu, 26 Mar 2026 21:15:45 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Volodymyr Fialko <vfialko@marvell.com>, "Sergio Gonzalez
 Monroy" <sergio.gonzalez.monroy@intel.com>, Reshma Pattan
 <reshma.pattan@intel.com>, Declan Doherty <declan.doherty@intel.com>, "Neil
 Horman" <nhorman@tuxdriver.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 1/2] examples/packet_ordering: fix format specifier for port ID
Date: Fri, 27 Mar 2026 09:45:16 +0530
Message-ID: <20260327041517.812223-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAyOSBTYWx0ZWRfXzekSv1QvWZJo
 RM+WIWOpSEj81Dn/pbpKd4Ugdb8JSiufte7ugoY+4qx0LfvaC779rKZYQf+lq+U/ZZM8I8cn5cm
 OMl6YHgK6nHC5dNsN8R6Tk8hc6W8et48SMDp4WkB2TvbgJT+Z8V9F+BTx+74lKdoTVWkYSqNUJr
 7dPKup6YTkgfsc/lFwCX4Sc0SoRlFxH+yjvswPETFfboYVda5l64Q9SMCCI/YRKUan3iI2IzOtJ
 bwgj3Q5OtquJMMuzv3sOCpl+qk4RQ9tpMzNj6c9Iuytm65jnObAsO5qFHGSeAEZLLWT4/RbCp4t
 pb0BH+N4CqmEHtgaGoniDSl9IswT8eem+1iokQ0X6cmr7W93/GhpALFoh6fD0CMPPhk6kkbmn1O
 J+q3jeFUbTOAwOU60wt1RVDSw/s+2fMV4ir0coDnkcQ6g13GCrICoudFvCnAa/zG8XFrC4L2Vpo
 KdQZYOTVAVkw5aBryNg==
X-Authority-Analysis: v=2.4 cv=a4g9NESF c=1 sm=1 tr=0 ts=69c60475 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=aHo0xUTkY7RAYJC55hEA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: JyMqfUxVMniusRvvm15Hw8koCshwnGps
X-Proofpoint-GUID: JyMqfUxVMniusRvvm15Hw8koCshwnGps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
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

port_id is uint16_t, use PRIu16 instead of PRIu8 to fix
format specifier mismatch warning with GCC 15.

../examples/packet_ordering/main.c: In function 'main':
../examples/packet_ordering/main.c:740:46:
warning: format '%hhu' expects argument of type 'unsigned char',
but argument 3 has type 'uint16_t' [-Wformat=]
  740 |   rte_exit(EXIT_FAILURE, "Cannot initialize port %"PRIu8"\n",
      |                                                     ^

Fixes: 850f3733f840 ("examples/packet_ordering: new sample app")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 examples/packet_ordering/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 5ffdf72d71..748fe0826a 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -737,7 +737,7 @@ main(int argc, char **argv)
 		printf("Initializing port %u... done\n", port_id);
 
 		if (configure_eth_port(port_id) != 0)
-			rte_exit(EXIT_FAILURE, "Cannot initialize port %"PRIu8"\n",
+			rte_exit(EXIT_FAILURE, "Cannot initialize port %"PRIu16"\n",
 					port_id);
 	}
 
-- 
2.43.0

