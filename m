Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC2FC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 May 2025 10:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E964025D;
	Sat, 10 May 2025 12:44:26 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A95104025A
 for <dev@dpdk.org>; Sat, 10 May 2025 12:44:24 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AAFYSD014123;
 Sat, 10 May 2025 03:44:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=lAoIGIABwI81FnKRzeUYwWC
 SCAle3/wUo4PEQm/7yHo=; b=YXM9sntYclmBIWzsSFDZmkexX5p07gOUC5ur8EP
 TWsPUB4XsIyeURwoxxIVSVQhBzvtJePx5cG+xi//OZSggyCspwLM4uiapQinJaJi
 ukAARrOvG6Rwsd3gi4HWz2iQ68j4CvSnYiv0QAfXYP7btSs1X2/+DY4+qPjl1dP/
 XweV2EiZD4/X7nfpnXDf34xo2+MbltDKRhwhmqFJA0dfw4W7Y7w7yu4WHpYcLinI
 HiKkQW+gDvfvyB/2DRooZaDVHPm1bWwRZTI0tNuGV5SrNIFrNXy17HlnVnEZhP63
 TzdbUYwrnhyIoU4FDq/wkDnDGa9VTf81/Ipt6SGkeuYOOWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46hudk8ngt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 May 2025 03:44:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 03:44:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 03:44:22 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id DA2D63F70A9;
 Sat, 10 May 2025 03:44:15 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [PATCH] crypto/virtio: fix DER encoding for positive RSA param
Date: Sat, 10 May 2025 16:14:07 +0530
Message-ID: <20250510104412.2154-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dPPVHjWNdr5pw4sGDUdHjfUNHLAPg93u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDEwNyBTYWx0ZWRfXzRFjvvVEudYu
 yvQ7yR/7W+/ClzCo/MxvvUqkWdPHuHVCXJT8hCG+QTn2iMeoj1RGOSRFAUT+ah0Ic7Ty1mpbAjx
 PI1dvSVeWtRvKncvvEWeNPKw7tdlZOY3jBGVHTnCIOc3rStAJ/Ps4ZUgHQkG81uFkztHknaHJAL
 2SDrmaTzTF8RGzStUds3tgeBZKHyT0ToQhTYkosGLVahsgT8TY+EWA+N2pZJLWVSTKWzeICWE7O
 MYqC2QjbovROYuah9kH4SLUeA28PEXg6HaxiJGcxiv11z7FzhTlF3oY8Ge4b5wT1BXSVh9QYkLz
 u8Fl8Ge3YBjKFGGeOWzJMkLbTkGI8ToDoGZxfXzckCdmZdA7FpoqldOAWA5lXQWdadGqFj7Zuw9
 w04u8VosvU5m5xVMUcitvrgCDfLbhfG14SlXe6TbStfWW3lEkqOuqPkkcLebcYG7iYk535rs
X-Proofpoint-GUID: dPPVHjWNdr5pw4sGDUdHjfUNHLAPg93u
X-Authority-Analysis: v=2.4 cv=f7tIBPyM c=1 sm=1 tr=0 ts=681f2e07 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=TB9s_Q-tlOekGMkZKP8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_03,2025-05-09_01,2025-02-21_01
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

As per RFC 8017, RSA parameter needs to be positive integer.
This patch fixes TLV encoding function appropriately.

Fixes: 6fe6a7f7bcf ("crypto/virtio: add asymmetric RSA support")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index b01e97c988..4440e02dc9 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -1459,27 +1459,37 @@ tlv_encode(uint8_t *tlv, uint8_t type, uint8_t *data, size_t len)
 {
 	uint8_t *lenval = tlv;
 	size_t lenval_n = 0;
+	size_t dlen = len;
+	uint8_t off = 0;
+
+	if (data != NULL && data[0] & 0x80) {
+		dlen += 1;
+		off = 1;
+	}
 
 	if (len > 65535) {
 		goto _exit;
 	} else if (len > 255) {
-		lenval_n = 4 + len;
+		lenval_n = 4 + dlen;
 		lenval[0] = type;
 		lenval[1] = 0x82;
-		lenval[2] = (len & 0xFF00) >> 8;
-		lenval[3] = (len & 0xFF);
-		rte_memcpy(&lenval[4], data, len);
+		lenval[2] = (dlen & 0xFF00) >> 8;
+		lenval[3] = (dlen & 0xFF);
+		lenval += (4 + off);
+		rte_memcpy(lenval, data, len);
 	} else if (len > 127) {
-		lenval_n = 3 + len;
+		lenval_n = 3 + dlen;
 		lenval[0] = type;
 		lenval[1] = 0x81;
-		lenval[2] = len;
-		rte_memcpy(&lenval[3], data, len);
+		lenval[2] = dlen;
+		lenval += (3 + off);
+		rte_memcpy(lenval, data, len);
 	} else {
-		lenval_n = 2 + len;
+		lenval_n = 2 + dlen;
 		lenval[0] = type;
-		lenval[1] = len;
-		rte_memcpy(&lenval[2], data, len);
+		lenval[1] = dlen;
+		lenval += (2 + off);
+		rte_memcpy(lenval, data, len);
 	}
 
 _exit:
-- 
2.25.1

