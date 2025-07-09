Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4FC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 08:23:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E8C04021E;
	Wed,  9 Jul 2025 10:23:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 48D774013F;
 Wed,  9 Jul 2025 10:23:36 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568NSt7F028540;
 Wed, 9 Jul 2025 01:23:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=S7tgjMJb7s1YjpIkW8AQiWF
 E43htIJULL31XwBxhnsA=; b=YzbjInSqlgU84m1/kKYUC1rTRIQ0DrCsirUooOf
 P/FGuSDLzR9gvxRA+OMdKNJeTn1CwaegOt+kdaNY/gyFZD0Ug2LPegUchYdagYJM
 Lum8yZcaMmRs7CVYrzReTYPbpGMatQxI0h91uBJJBg/aDWADbtmEOHBA3RwTFos8
 TkuFJf4lVPKWsj1nSeK+KNQ0xw3kggwwmlcndCzOkb00WeD1VQ6b6Bm5ojgi1wd6
 RVIvWo2TCdt5XfTTFPbFWB78hqQGnxV9Biy9Qcb5qdXSLF6KKH/8tY5r5FKbgZIX
 nJt56lNh7LM1zApTNiXC7we+vOIiCeDVQEnCVbODWqMPttw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47sd1p8t6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 01:23:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Jul 2025 01:23:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Jul 2025 01:23:34 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 248305B692D;
 Wed,  9 Jul 2025 01:23:31 -0700 (PDT)
From: Volodymyr Fialko <vfialko@marvell.com>
To: <dev@dpdk.org>, Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>
CC: <jerinj@marvell.com>, <masakazu.asama@gmail.com>, <stable@dpdk.org>
Subject: [PATCH] examples/ipsec-secgw: fix number of queue pairs
Date: Wed, 9 Jul 2025 10:23:25 +0200
Message-ID: <20250709082325.771994-1-vfialko@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SOWDo_oh0MiZum9X8CY2tRsa07HziVy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA3NCBTYWx0ZWRfX9KJOREmnOuZj
 CzNCJ0ZiiKs0BhjGp3MKCyFWDvVTXHrH3QJn8v0bcVvnWIg2AUIy6zLYvIfWDe6eu3wN1h9v0zA
 bjJ9herzUl1LsHnXn9k9vSn8heaoFcdby2CkqkC/g3+jofkfDJWHfv5zKdhGzxE+WvoJe20K5wV
 gzZbKu8jfsqnKKJtyS7PA1a5nNphmvi5x9LA/Ktyh9mtZ2vXoQkgV76LIKefy8/7SNNVNSxCrmN
 EnDUQaCkoUBD+aLWZyj6ojnSOB0wS5srcA8SZDM97oAMRlo5DQeF5imZrGboQ7ry/66byT6136h
 Ok/8ZsDkfSmx1SAdZYet3OOyS6EEHb8BwD/FDP735UJenCVi8Vdu5+pAzcc2UAj15MxZHKEKkWa
 /3Pt7sxtdzZm2/EESuxKm/YjN7qUwdD21+yH5KSpv5pWWJtlZOoUq21hnnyarz3lmBymlfVD
X-Proofpoint-ORIG-GUID: SOWDo_oh0MiZum9X8CY2tRsa07HziVy0
X-Authority-Analysis: v=2.4 cv=GIIIEvNK c=1 sm=1 tr=0 ts=686e2707 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=16kEbQeT43XQvZWu4UUA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
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

Fix a mismatch between the signature of the cryptodevs_init() function
and the arguments passed to it during the call. This caused incorrect
initialization of queue pairs in ipsec-secgw example.

Fixes: 253265f8fb97 ("examples/ipsec-secgw: reduce queues for event lookaside")
Cc: stable@dpdk.org

Signed-off-by: Volodymyr Fialko <vfialko@marvell.com>
---
 examples/ipsec-secgw/ipsec-secgw.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index 063cc8768e..fe489f9a56 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -2994,16 +2994,7 @@ main(int32_t argc, char **argv)
 
 	sess_sz = max_session_size();
 
-	/*
-	 * In event mode request minimum number of crypto queues
-	 * to be reserved equal to number of ports.
-	 */
-	if (eh_conf->mode == EH_PKT_TRANSFER_MODE_EVENT)
-		nb_crypto_qp = rte_eth_dev_count_avail();
-	else
-		nb_crypto_qp = 0;
-
-	nb_crypto_qp = cryptodevs_init(nb_crypto_qp);
+	nb_crypto_qp = cryptodevs_init(eh_conf->mode);
 
 	if (nb_bufs_in_pool == 0) {
 		RTE_ETH_FOREACH_DEV(portid) {
-- 
2.34.1

