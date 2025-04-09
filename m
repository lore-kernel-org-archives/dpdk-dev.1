Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18CC36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 06:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4AF2402D3;
	Wed,  9 Apr 2025 08:12:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2BF45402B7;
 Wed,  9 Apr 2025 08:12:11 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5392ZWLw024334;
 Tue, 8 Apr 2025 23:12:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=6YMT0MdOrv8s6yxlYb7/eDX
 s4qGRSuFwI9yj5AUNaNM=; b=bR+S1ghOCGAcBQULbRpz+BsNeBu/z1eOREzMYyG
 uOlApo7T2oqsXd14my68fu1Pi5earEz9TUFhCeBfNTZDZWzp8Dp5+xx1cLeHbLgu
 OUdrGZo3P7l7tIKTxNOhNrjUCHId1kQ4K+2fbTfvQgRH18RyJFyZjhlz6JMir14j
 86Q9o2N7N2GfOjjBkZ4b4/VuLDCOiFtYN4ZMlv1kVWQ9kKlNgyGozTOODlDfSQP3
 roRAe8qfLZvXASJvhBLIMpW04+ntrAv2GTJJ+fE3kZ6cykUDLGgch+e2PkOzuQbZ
 OsBd2ImGYeKcZIcR1JI8jbiMwL5oZlKrNmpVVgYPiN2eRQQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un99y404-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 23:12:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 8 Apr 2025 23:11:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 8 Apr 2025 23:11:58 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 274633F7098;
 Tue,  8 Apr 2025 23:11:55 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/cnxk: restore MAC address table during port reset
Date: Wed, 9 Apr 2025 11:41:49 +0530
Message-ID: <20250409061152.1096849-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f60fb9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=-cz9rU5AX-NHyWX2MfkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 55G-uNQHsZU3EYVslVCZaanbDFppGzj5
X-Proofpoint-ORIG-GUID: 55G-uNQHsZU3EYVslVCZaanbDFppGzj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
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

From: Sunil Kumar Kori <skori@marvell.com>

When user requests to configure a device which is already in
configured state then first device gets resets to default and
then reconfigured with latest parameters.

While resetting the device, MAC address table is left stale which
causes entry update in later state.

Hence same is restoring during reset operation to avoid any error
due to further operation on MAC table.

Fixes: b75e0aca84b0 ("net/cnxk: add device configuration operation")
Cc: stable@dpdk.org

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 289ae96afa..7e77fcba45 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1209,6 +1209,26 @@ nix_lso_fmt_setup(struct cnxk_eth_dev *dev)
 	return nix_lso_tun_fmt_update(dev);
 }
 
+static int
+nix_restore_mac_table(struct rte_eth_dev *eth_dev)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct rte_ether_addr *macs = NULL;
+	struct roc_nix *nix = &dev->nix;
+	int i, rc;
+
+	macs = eth_dev->data->mac_addrs;
+	for (i = 1; i < dev->dmac_filter_count; i++) {
+		rc = roc_nix_mac_addr_add(nix, macs[i].addr_bytes);
+		if (rc < 0) {
+			plt_err("Failed to restore mac addr table, rc=%d", rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
 int
 cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 {
@@ -1507,6 +1527,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		rc = nix_restore_queue_cfg(eth_dev);
 		if (rc)
 			goto sec_release;
+
+		rc = nix_restore_mac_table(eth_dev);
+		if (rc)
+			goto sec_release;
 	}
 
 	/* Update the mac address */
-- 
2.43.0

