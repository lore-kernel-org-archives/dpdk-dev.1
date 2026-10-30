Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DA606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=XSQ4v6QI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC55C4025A;
	Fri, 30 Oct 2026 06:17:34 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 38DCD40151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:17:34 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5DXp9636899 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:17:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ZEY4OAXsRRuXASkHRPnBnlY
 xS8I3F/mV0WFUYVLdO+U=; b=XSQ4v6QIUDB8SN/+T4S7y0M+Iv+30ogMTzZ18EM
 9QuuJIY1izxg/5lKoTH/LPWXBkf9cR7XF3t7PR3kOXYSGq3KHKceatItWU0WAisb
 NZAxTaQW3avbAa/oiSGkYkIJSUGenjfFFDzQsvl9t2mb+fu0NuDaersQ7P7mo6LB
 +2VfkUusAatAiwufSYa+2quoQY+eBqJxAwqLiaVFyQfoJ/N5z7qB1IHjZntedT8U
 p9ZoaLlV47DjUhyqMOTyTOEejdnyp40w5Vizvbh4vTJjYnCEEGAiAMypSbo2UBV4
 Dj48QaY8v0zEpgeP4mwHtAWgAmtOt3brMZmIiSAlZTLcd/A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5t9a9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:17:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Oct 2026 22:17:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Oct 2026 22:17:31 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id E0B1C5E686D;
 Thu, 29 Oct 2026 22:17:29 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Ashwin Sekhar T K <asekhar@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Nawal Kishor <nkishor@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH] mempool/cnxk: fix halo enable devarg parsing
Date: Fri, 30 Oct 2026 10:47:24 +0530
Message-ID: <20261030051726.898902-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RtZQvymK c=1 sm=1 tr=0 ts=6ae4286c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=biYMYZ1uH1dr10EJx7gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMCBTYWx0ZWRfX/7aWObsXwM3E
 2tSI1jcHQ6mufAjM/apVSE3mOu1serFZzDcIXnkLPnhr23dcaQF/jmiGyrXsbeVFkqOiA7VpyeL
 8aVjpqaPPtAdo09u6jfbto8pTdtuFcI=
X-Proofpoint-ORIG-GUID: XXooL2qAN_oQWvR4nh4jGxvrZdwkOesd
X-Proofpoint-GUID: XXooL2qAN_oQWvR4nh4jGxvrZdwkOesd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMCBTYWx0ZWRfX6v9RLsU1ruBi
 CxkjgVTFgS9Pkk4xiMF5fvxhF7sdRjharP0WQSLeTjQZW56mjymJNG5IQ22hz5qdCG5Cpihp+1l
 XvqjIeXhKJYK0unydRXDfZir5LdJb0UmyecwjHkZxwrXJzdy1jxbJ6tmS06jxdmIwJ7SL+UNDp6
 /DaOsYaohZLohZ8W3/yEGnpQdjvo8Mk3IemVLSwcYyaGmONSBIzYEv+d/IrJLv64rfc3j1/HN8d
 OZT4yh2vshqDggcSKaybDoSiD91MjG985ABS8kR2Nj3l0UYevF9c/AExC8rBhK56T7+4X1T8IdA
 zMJ6E8bwF1t+rq/hDLi8aRd6DUP3iVPIx5g1PmoyIBgQG5IEPI7unmAJK6vSUEe0/GoYASPbdWo
 iuZoxs9JxFvm47sAnNnIFeTmDeEWMQ2KzoYjXDq5rlQd7ebvsBnyXMR3i9EZU+MIPw1QARAMklI
 6veSdqqPe4016RdWJag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

parse_halo_ena_handler() kept the parsed value in a uint8_t and stored
it through a uint8_t pointer, while the caller passes a uint32_t. The
narrowing happened before the 0/1 check, so 256 was accepted as 0 and
257 as 1. The one-byte store also updated only the first byte of that
uint32_t, which is correct only on a little-endian host when the local
is already zero.

Parse and store a uint32_t so the check sees the full value and the
caller's object is written completely.

Fixes: 45abbfc836b1 ("mempool/cnxk: support HALO in mempool")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/mempool/cnxk/cnxk_mempool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnxk_mempool.c
index 6939fccff4..f1cdf9cbb5 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.c
+++ b/drivers/mempool/cnxk/cnxk_mempool.c
@@ -51,13 +51,13 @@ static int
 parse_halo_ena_handler(const char *key, const char *value, void *extra_args)
 {
 	RTE_SET_USED(key);
-	uint8_t val;
+	uint32_t val;
 
 	val = atoi(value);
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	*(uint8_t *)extra_args = val;
+	*(uint32_t *)extra_args = val;
 	return 0;
 }
 
-- 
2.48.1

