Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C198C5516F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2912C402D0;
	Mon,  3 Aug 2026 08:24:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 44BB940269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 08:24:30 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672MtSP01611764; Sun, 2 Aug 2026 23:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 r6++diV6N1P8m1j3FXPlnj19iriZzP61MQ3/36GvM8=; b=hffEPL9E9yHGtVjIg
 kW6WT8GVDqawrwgOGKJCCLRvNjxRjXYVGJTIzSfEDrNolbjGfpZDdQ14hTwcxgl3
 lr8t2DMQRsVKI/HEWJGeDlAaSl1+TzBINBA23jgLOrPlZpWM4wcNBqy7/hXtN1QY
 tSWy86VOhVEExLmtHRW+5ao1bW/Ry5hXpaD/I0jx2sJB1M7VksdZehjtChMbqmmF
 WvEIlLAfHIryV05GJ7lFgwOLkQ4kYGFO3QQMiei1baHrjED7Oouhsltw7sfcOCkd
 +hSLgAjmcoWmSGEAHQuZ5MSuIiD9rdth1besN4MpFSir3hUqFBMwPnivr83cT7h1
 Lp4CQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fse5pugg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 23:24:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 2 Aug 2026 23:24:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 2 Aug 2026 23:24:28 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 397F83F70A4;
 Sun,  2 Aug 2026 23:24:24 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <ktejasree@marvell.com>, <anoobj@marvell.com>,
 <jerinj@marvell.com>, <stephen@networkplumber.org>, Rupesh Chiluka
 <rchiluka@marvell.com>, Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>
Subject: [PATCH v1 2/3] crypto/nitrox: use timing-safe salt comparison
Date: Mon, 3 Aug 2026 11:54:14 +0530
Message-ID: <ebf11972bee0d90f39191c8c8578a108cce75f43.1785737875.git.rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
References: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfX5Gz7BLhmVGI2
 X5EknHuY1WpD5OL0JvFXRgZEW9EVDEvDswRJzUmSSjCgAyzZ/UNMDU8/GeglOSOfUl+WHq57q3F
 pSpEzjHg37I74+MvV62kmWJ/q6OjGBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfXywgac71M070j
 hoxqg6Mb4tLxgSy5oXXE86Zl0CqqB/+p24SNggzv6IFzWLSFIDaIXHkbQa/G7E+nAMFKGaNIxuy
 Q+z1ZqUikXJtKRWpnG+flFAeO2XUdYsielADAhcwCwFHnL+cBjJFEoF5aoHuPNwaWelHqMLCvMC
 cK61lLXyNwnvp2NddkBeZaX5T6SzG5vlupTSG4M3gxe7vZ+K6WUDcpAWuUhgalT2pUtT62Y2WCa
 90/fRtif1bfORPPQsFz3arAy6HGiPuSmhST3N9yadj5GDHFRbx9cdvs/1TtS/scmV67y4WjjkAD
 r0KUi57MD0uDP9OTahFpPF3cehfWKJSqRLnwi+9HIN2Fmb1TIDHQYKOk/31e2E9vGHVud33jD0E
 t5d5O05ogmcXazz8uG9WZAiZdLMTgKr5Xk5z8MFydGfAr41nvMZmYdZD4bZ5DZXJcYq5gC+s4P6
 K+0rvtRPl8VE8E4KdeA==
X-Authority-Analysis: v=2.4 cv=ca/iaHDM c=1 sm=1 tr=0 ts=6a70341d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ICC8u8P2pTjgs1xOvaIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: CwagGhhwYL0B88zw-PTYEDxh-WGBuon4
X-Proofpoint-GUID: CwagGhhwYL0B88zw-PTYEDxh-WGBuon4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
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

softreq_copy_salt() compared the session salt with the IV salt using
memcmp(), which returns early on the first differing byte and can leak
timing information about the salt value.

Use rte_memeq_timingsafe() for the salt comparison.

Bugzilla ID: 1773

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/nitrox/nitrox_sym_reqmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nitrox/nitrox_sym_reqmgr.c b/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
index 7751c1a9fc..728c80b84f 100644
--- a/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
+++ b/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
@@ -684,7 +684,7 @@ softreq_copy_salt(struct nitrox_softreq *sr)
 	}
 
 	addr = rte_crypto_op_ctod_offset(sr->op, uint8_t *, ctx->iv.offset);
-	if (!memcmp(ctx->salt, addr, AES_GCM_SALT_SIZE))
+	if (rte_memeq_timingsafe(ctx->salt, addr, AES_GCM_SALT_SIZE))
 		return 0;
 
 	memcpy(ctx->salt, addr, AES_GCM_SALT_SIZE);
-- 
2.48.1

