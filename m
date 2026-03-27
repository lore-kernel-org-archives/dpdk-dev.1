Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA610BA422
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 04:16:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F10402E2;
	Fri, 27 Mar 2026 05:16:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 694F34026A;
 Fri, 27 Mar 2026 05:16:16 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R47kcp4045141; Thu, 26 Mar 2026 21:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 t3uOn2hFLac/nIazLQpSlFdL1Gm1xmTSOKargGtZCc=; b=h900lvu/MBwubqnyB
 UgQbrYTIBxk061SgeeP5A9UeQLMrLSYnX5GsYSuH1IxrLSNCnmePtBpuOZ8fqp5N
 4tK93Z0HQriGf4zSRCc1hhS1joF6fQtZ8QFvRe8uTymtUYNjhjlqrXB9kU6m2M4Y
 aBVzgvDaTYc9v/XTFLiHhBVM4mSv2TZDecuUrHKDuCwsw2RV0pAytawfO6dREjMh
 urzC3LoODxNouzDHZL6VWWSWCAS9o5YDNkuyX3DgCevW4iYPrCQ3fS4jydXTgKob
 S5+enOcz8sxjd+RgKB33WJmvh5KP40S6xYTxjRdDe6RAEOOfCsSGpiS9U+Wgqq9I
 7as0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d4u87bj6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 21:16:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 21:16:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 21:16:14 -0700
Received: from cavium-OptiPlex-9020.. (unknown [10.28.38.192])
 by maili.marvell.com (Postfix) with ESMTP id 5923B3F705C;
 Thu, 26 Mar 2026 21:16:11 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Kirill Rybalchenko <kirill.rybalchenko@intel.com>, "Pablo
 de Lara" <pablo.de.lara.guarch@intel.com>, John McNamara
 <john.mcnamara@intel.com>, Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 2/2] examples/ptpclient: fix format specifier for port ID
Date: Fri, 27 Mar 2026 09:45:17 +0530
Message-ID: <20260327041517.812223-2-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327041517.812223-1-ajp@marvell.com>
References: <20260327041517.812223-1-ajp@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qD2dgjE05jD0cPCO_M4qt5nO6lNhT6P5
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=69c6048f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=AXJSY_UFb3AZRPmDtrsA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAyOSBTYWx0ZWRfX+9CDwbKowRNU
 mc1UWo4lwNKnTK9Bh0Pi5gBvqSphUOJ0K4lJ8oJMuUcrbfHDwJdI+zGXuR1OhuW8aiaUGujSQrS
 zrZW2eZkZ4jHnJnI30KRzEidYONuLcdKcv7dWiqsXTqo1ilQrCAlAPFyPilsarsXVXaKuLNrY+A
 fCkqL6O5MmbC12+JGbcxEaJAq86Q2kmDjQEsE+2YNKZwRaEbOZbPqv3+SMHP0PQqAQLH31Jbu/k
 XQh9Ul7hVJt6kuGoBttwXNT3fpE+Sa0PRjgXb4grPdsulDzIwxIsDySU4ltG1X2QzX7a043a8/R
 Bl12v87/2nvtXFz0sgzqWp5KKTzAUvpjnG1EbGTW+NCySyqCNc7W3Lb1F/8HbKCHEl01btb73aG
 c6LY5IHFYBPEflxZ7sQhjH2uJ7zgLOI6VE6fjKoYkGNPD89wuA4VAXErC26nCPaiWs4lKe0Sw2X
 9flo0lseUWeaW4ApzSQ==
X-Proofpoint-GUID: qD2dgjE05jD0cPCO_M4qt5nO6lNhT6P5
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

portid is uint16_t, use PRIu16 instead of PRIu8 to fix
format specifier mismatch warning with GCC 15.

../examples/ptpclient/ptpclient.c: In function 'main':
../examples/ptpclient/ptpclient.c:797:30:
warning: format '%hhu' expects argument of type 'unsigned char',
but argument 3 has type 'uint16_t' [-Wformat=]
  797 |    "Cannot init port %"PRIu8 "\n",
      |                         ^

Fixes: ab129e9065a5 ("examples/ptpclient: add minimal PTP client")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 examples/ptpclient/ptpclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index c344e7db1e..1fec4af767 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -794,7 +794,7 @@ main(int argc, char *argv[])
 				ptp_enabled_port_nb++;
 			} else {
 				rte_exit(EXIT_FAILURE,
-					 "Cannot init port %"PRIu8 "\n",
+					 "Cannot init port %"PRIu16 "\n",
 					 portid);
 			}
 		} else
-- 
2.43.0

