Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CEC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 08:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82B7C42E24;
	Fri, 20 Jun 2025 10:19:34 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0F070400D7;
 Fri, 20 Jun 2025 10:19:31 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4hsus027647;
 Fri, 20 Jun 2025 01:19:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=gs0N/835fmynmAl1dMGmLDi
 96HL6iA6mDhgv87DY790=; b=YdN9TVaNICY/5+8JILQ+lLwbzlj2ggk2xLaGxz2
 TaQ/hgmuse+oqKV6S56o5QyRa4sD++sYhpLmPYDgNbrjn9iMuwy6IdyITK7BXepZ
 tbJUdqcmcN4FeuQRE7IAJzRFNZ0wBEq1AYApkaB/4oAtM0d2G5W+0Ca9NvEqfAzE
 8JmNPi5HxOAaMaIR7Z6bt6pbEHHny1xXOkS90YMRN0ACxyC8zbxesh6aSISqAggd
 HYf+8W4gwOlHsVOiVq3bKTLiY/0C4GpUN3oa9fN5D9GVZd4FuC4+J74ssXbZyVAl
 2D44PFLiLgXIiFosKhYHKic8awf3BU4cRHHAGHhhq5LThFQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47d0vb0bv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 01:19:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 01:19:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 01:19:29 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.22.173])
 by maili.marvell.com (Postfix) with ESMTP id 7673D5B692D;
 Fri, 20 Jun 2025 01:19:26 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>,
	Ashish Gupta <"ashishg@marvell.comashish.gupta"@marvell.com>,
	Shally Verma <shallyv@marvell.com>, Sunila Sahu <ssahu@marvell.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 1/3] crypto/openssl: include private exponent in RSA session
Date: Fri, 20 Jun 2025 13:49:16 +0530
Message-ID: <20250620081921.2145-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WAS84sAe0RSSNDYsuMJ-PcsCVn19121k
X-Authority-Analysis: v=2.4 cv=O+s5vA9W c=1 sm=1 tr=0 ts=68551992 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=BeEbT6A5J505o_f2Zi0A:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WAS84sAe0RSSNDYsuMJ-PcsCVn19121k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MCBTYWx0ZWRfX06tRLBmafY7Z
 7S4em89KHTIqhM4QLMfg4i9DEVeIefl/60A+5bzQ7dqRAFXXx1dGZk/M4PRlUB3xvtbSZlqy6F1
 G+9HrDHp9oQaY2D7R0g7ztCBiByEdandWeGz1dos7swp9t7NrERQUfXYb+EBOtFZAbW3ivCJZzm
 3c/qt06Xd2s3aGU9jI6x6iFliefvUAzv1wvbdchMdImys1sNU6j9ZkAwceItTkIoGNhzF5CYLMo
 n3yy1BgHjLqfml/zkRb4jAcnB0Ohs37akXCJaRRBHziMx29s40hZHxSF2kfLzDoNmURt/y7I4Uu
 FygC/0APe99Bc9MXD0IqY1XhnobhfNsFnZNGw+y9GGXuYWmFHkSRPPSEAsw5Wip5LO5vQRwqUWw
 BFJwZ1nItDrku2ZA9j4kgMmjPo833hYsBDcxBr+IBO40YelSZOYF/oOvEJ/y86b9trrBXCFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
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

If private exponent is available, it should be included within
RSA session as per RFC 8017 (A.1.2). OpenSSL 1.1.1 implementation
rely on this private exponent, to implicitly reject invalid cipher.
Hence, check if it is available for session and include it.

Fixes: 3e9d6bd447fb ("crypto/openssl: add RSA and mod asym operations")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 04e018f3df..d3aa396c76 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -1025,7 +1025,7 @@ static int openssl_set_asym_session_parameters(
 		if (rsa == NULL)
 			goto err_rsa;
 
-		if (xform->rsa.key_type == RTE_RSA_KEY_TYPE_EXP) {
+		if (xform->rsa.d.length > 0) {
 			d = BN_bin2bn(
 			(const unsigned char *)xform->rsa.d.data,
 			xform->rsa.d.length,
@@ -1034,7 +1034,9 @@ static int openssl_set_asym_session_parameters(
 				RSA_free(rsa);
 				goto err_rsa;
 			}
-		} else {
+		}
+
+		if (xform->rsa.key_type == RTE_RSA_KEY_TYPE_QT) {
 			p = BN_bin2bn((const unsigned char *)
 					xform->rsa.qt.p.data,
 					xform->rsa.qt.p.length,
-- 
2.25.1

