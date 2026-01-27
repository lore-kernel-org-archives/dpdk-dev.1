Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F87D25932
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 04:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4202240B9F;
	Tue, 27 Jan 2026 05:35:07 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8D240A77
 for <dev@dpdk.org>; Tue, 27 Jan 2026 05:35:05 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QN67YY1446239 for <dev@dpdk.org>; Mon, 26 Jan 2026 20:35:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Jb9DgxHSNkbyVCG5TJqE6fb
 AQuGHSY9/PCNyHkuBfaE=; b=Z7lZgSWbRPA1oXn6N3/+i3NW5ScNeo5J1MFHr+u
 3fnxt9IzobsYHrCuMy2Fl6u0DjB9UPKjfEWd/7KXpdCL97+YnJUcnRu2vbrOxJ4q
 Syb0RH03fM7lVsT0v5e8TzAmZ/vIaH9ET9i2K4K7Zk++B8nO7sS+VhXqnr/x80Z6
 8eW3cuJ1f4HpioZorU5bmrb1GlUKk2+i53ejxwp56+JFjvXvSMOS3LksP412Z+u1
 Kuk2oV3sQKb033kAswaIza8qHXQ9xWAUzjuuaavCrfssBGoAPvGv0pLdZjN50GAd
 Dg9uCHvCgQLm8iOpjRU8PSIUSsLJa0YS34LEGVm9cw0Mgyg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qstk3f-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 Jan 2026 20:35:04 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 20:35:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 20:35:04 -0800
Received: from localhost.localdomain (unknown [10.28.37.2])
 by maili.marvell.com (Postfix) with ESMTP id 6E91F3F709D;
 Mon, 26 Jan 2026 20:35:02 -0800 (PST)
From: Garvit Varshney <gvarshney@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, Garvit Varshney <gvarshney@marvell.com>
Subject: [PATCH] crypto/cnxk: return decrypted data for RSA verify
Date: Tue, 27 Jan 2026 10:04:59 +0530
Message-ID: <20260127043459.178859-1-gvarshney@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAzNSBTYWx0ZWRfX+lnxFSnXIz8t
 sccBB2sYr67coru4nITwZF32p1ERgtlm0FXcTxsXE4aGcAa0v+aIsUOSJS0nMtGBrkJ0DTuPZV+
 mklaMyuvpqKgux74/Qo282syUlj1tNS1gTnZvm80YuuPqds7vW1pTbCzDRn2EMhb7ZeOG730fdH
 HNSiO7f3dOd6ab+Fn9zQaJb8nBrJZzRz6lFMix2QpQFv7+IXYsxNkfDZloiczbZAv3jty9vDnZL
 HDp0hQy7exBIxw5dICrfKlp5DbPXzQ/Y4JLELltCZBhnEWmiaNdBJnStJD3316ajnHyGwDPLaej
 SkruhF+5HJi9Gyzu4YJf/GnDsxUGQeb8rjvyYSuDXay52ikMZDDcK5UMuAQhobGCm/rjqfdZHWy
 AV+k2Yyb4pz04N2ULWLQtOLbf+5IShaKkG1K9VH9fan1TnOcs3rOkq4F/+hc8tz57uKI7m/1eWn
 ntfv1u4y9ApTyve9gZA==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=69784078 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8
 a=GvQkQWPkAAAA:8 a=QyXUC8HyAAAA:8 a=FmoMKUsJAAAA:8 a=pGLkceISAAAA:8
 a=zRKbQ67AAAAA:8 a=IY3uQdUVTWlrAyVruA8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=PA03WX8tBzeizutn5_OT:22
X-Proofpoint-ORIG-GUID: tsRM_XLZWhnFNArhKN6YcnOWqvcjejHX
X-Proofpoint-GUID: tsRM_XLZWhnFNArhKN6YcnOWqvcjejHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
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

For RSA verify operations with RTE_CRYPTO_RSA_PADDING_NONE, the driver
cannot determine which padding algorithm the application is using.
As per the API specification in rte_crypto_asym.h, when
RTE_CRYPTO_RSA_PADDING_NONE and RTE_CRYPTO_ASYM_OP_VERIFY are selected,
the decrypted signature should be returned to the application in the
cipher output buffer.

Fixes: dfd038b97ec3 ("crypto/cnxk: refactor RSA verification")

Signed-off-by: Garvit Varshney <gvarshney@marvell.com>
---
 .mailmap                      | 1 +
 drivers/crypto/cnxk/cnxk_ae.h | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..730f02707a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -496,6 +496,7 @@ Ganghui Zeng <zengganghui@huawei.com>
 Gao Feng <davidfgao@tencent.com>
 Gaoxiang Liu <liugaoxiang@huawei.com>
 Gargi Sau <gargi.sau@intel.com>
+Garvit Varshney <gvarshney@marvell.com>
 Gary Mussar <gmussar@ciena.com>
 Gaurav Singh <gaurav1086@gmail.com>
 Gautam Dawar <gdawar@solarflare.com>
diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index 912a2a9496..21a0c8068a 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -1591,9 +1591,10 @@ cnxk_ae_dequeue_rsa_op(struct rte_crypto_op *cop, uint8_t *rptr,
 		break;
 	case RTE_CRYPTO_ASYM_OP_VERIFY:
 		if (rsa_ctx->padding.type == RTE_CRYPTO_RSA_PADDING_NONE) {
-			rsa->sign.length = rsa_ctx->n.length;
-			if (memcmp(rptr, rsa->message.data, rsa->message.length))
-				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			/* Application compares decrypted data with message for SW padding schemes
+			 */
+			rsa->cipher.length = rsa_ctx->n.length;
+			memcpy(rsa->cipher.data, rptr, rsa->cipher.length);
 		} else {
 			/* Get length of signed output */
 			rsa->sign.length = rte_cpu_to_be_16(*((uint16_t *)rptr));
-- 
2.25.1

