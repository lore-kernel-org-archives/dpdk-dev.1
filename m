Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03858C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 05:31:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55964402CC;
	Mon, 14 Jul 2025 07:31:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF7CC4013F;
 Mon, 14 Jul 2025 07:31:56 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E4doDq027796;
 Sun, 13 Jul 2025 22:31:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rHMaTMg9TfUPpOKyfUGeIZJ
 3zC/JyoN7ETD3mPh+i3k=; b=EtF4sFur8P5DmYe6ZVOnFX9VcY3m7BWqDfJAJLU
 jwwqmYRi4yJR8EV3ctWZ6VDhg61+bBJcfXO3Mz9YLB4jZT0X82VHYbhSVqsNB4DZ
 Zop+NwXRC2bjDIA5aaxIBeGhQZy+aW41zp1tn5tX6UkNIrScG+Dh/QQJQ35q1YyT
 RZjiEsAW8zeGVReKBefAfTmTey6HvHWkHiJIYCr0Sh0J9aQyB/ePSHAdNXYCZ0Ka
 8P5QdqynLv/sLYyyipmo+0Rql8k+iQfvi+bhVzClLLPO9fe8BDqbYfJQF/l16aI/
 FgZZasxSElFy1X+qzLpHuUMHsQ15DtCYNKPnqPBsQg852LQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47vu2f02xk-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jul 2025 22:31:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 22:31:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 22:31:55 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 602ED3F7060;
 Sun, 13 Jul 2025 22:31:53 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Vamsi Attunuru <vattunuru@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v0 1/1] net/octeon_ep: handle interrupt enable failure
Date: Mon, 14 Jul 2025 11:01:50 +0530
Message-ID: <20250714053150.2229683-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SHsiUNbZlBS8QH6I5ql3lsrlz5B7FNwJ
X-Authority-Analysis: v=2.4 cv=MMxgmNZl c=1 sm=1 tr=0 ts=6874964c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=0Jh8URpYAwFg89L9PFMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: SHsiUNbZlBS8QH6I5ql3lsrlz5B7FNwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzMCBTYWx0ZWRfX5i2vbcZHucvN
 asWHWWHkURC2X4s5wl9GSQ3i9K++YSMAJKZzOfPQypuEClf0s15LwwYYGhzAirUNtwoyNPDTrH5
 rDhavd4e1cOvkvau8I9+sA4hs5x+5C7CqLJZapUG+ZtaiW9k/gDclfcroQs+875CJ3nb3vnBwEB
 FiCOXj0C/446GMQ2auJSHI3yQZ1pkrcIaSJ65o2mGzha/rURYrn00nQh9LrxvnNko5+gK2O4wng
 xSG1yiASaWqu4sZpBcSV8qB1lOXJAY8Yr3QGA9Cn+5sgyLJFwGHz+XVt503OQiadHAMRGbUOVPn
 uUOVcsqZrwGYygfJYionSkj5iWibTAmzVr9e/w0C0hEAM63S1eWCCO0MWNIwM/K1O0TCGNzeBJ0
 jbHUHX21caDSIG5PpQNSlPDqABhCflwmQrzzjDRCvxE+sbdICumSnW+H8n4ZLII0cwt8HrtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Patch checks the return value of interrupt enable
and returns gracefully if file handler is not available.

Cc: stable@dpdk.org

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/net/octeon_ep/otx_ep_mbox.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/otx_ep_mbox.c
index 1d7e08d2cc..c83bb81474 100644
--- a/drivers/net/octeon_ep/otx_ep_mbox.c
+++ b/drivers/net/octeon_ep/otx_ep_mbox.c
@@ -355,16 +355,22 @@ otx_ep_mbox_init(struct rte_eth_dev *eth_dev)
 	struct otx_ep_device *otx_ep = (struct otx_ep_device *)eth_dev->data->dev_private;
 	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	uint64_t reg_val;
+	int rc;
 
 	otx_ep_mbox_version_check(otx_ep);
 
 	rte_intr_callback_register(pdev->intr_handle, otx_ep_mbox_intr_handler, (void *)eth_dev);
 
-	if (rte_intr_enable(pdev->intr_handle)) {
+	rc = rte_intr_enable(pdev->intr_handle);
+
+	if (!(rc == -1 || rc == 0)) {
 		otx_ep_err("rte_intr_enable failed");
 		return -1;
 	}
 
+	if (rc == -1)
+		return 0;
+
 	reg_val = otx2_read64(otx_ep->hw_addr + CNXK_EP_R_MBOX_PF_VF_INT(0));
 	if (reg_val == UINT64_MAX)
 		return -ENODEV;
-- 
2.34.1

