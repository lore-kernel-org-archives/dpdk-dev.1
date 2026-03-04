Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72003EB7EB5
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FF1E402E4;
	Wed,  4 Mar 2026 11:12:43 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC4F402A9;
 Wed,  4 Mar 2026 11:12:42 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623NSEfk1742752; Wed, 4 Mar 2026 02:12:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=HmJUtPPiQjY5Dwj0qTvbv+Q
 IhItNBJgMHJH0rVCLUO0=; b=NF6JnE/j+0d+0KvX9mtennK16I7XjQsaRB8hF4A
 AZAoMCF/3EcFkz9Y7tGuZ0qqN0KrAXWfrL69Dps0Dn6UHoq8VG4RxR6sEMh4IrAL
 3S6mruQ+BU2xpJjTBySjvpsrPZAWVzScusYEHUxq3pw1Puth73vaDWnJvh99wvuY
 KVUADwPviEmA+L3rD9tBlm6xzxfwxoUVByBONtwDJkV5SBSePQINAH0nAWRGLr7j
 h81C+TS6SX83F/+08huY4nr2VikcW/HrKIn7FkY2LNKvO1Q/1xTZY6Tey7IP+UG3
 sZLCg85tFG5amec5rY4o/Zm+lkO4OEX7q7Vq3LuFPnX+lKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cp9bg19pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:12:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Mar 2026 02:12:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 4 Mar 2026 02:12:40 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 0F5713F7096;
 Wed,  4 Mar 2026 02:12:37 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH] event/cnxk: fix segfault for null pointer access
Date: Wed, 4 Mar 2026 15:42:31 +0530
Message-ID: <20260304101232.2381567-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NarrFmD4 c=1 sm=1 tr=0 ts=69a80599 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=QCBocPkebLr_tFgDG8MA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3OCBTYWx0ZWRfX3vX7lJcoXtlg
 b+GQ53dX4Ov1tAoKdyc15kRnA60X/gwS+H/hwkaM9B2lByPpJmKWUlRphAFtvTb45ohOlo2P13X
 9BBcRItbL3dFCWEMIcsTm5CBJf97XlEBtJJuSOjZvYPbg1W7Dr8A7YXNungxp+5rUUNv3zDxk/0
 r/PoCd28XupmScrglcwkedogcwYIO7NbErk6js2ptPCvpd502Jk6PzkeGvAumT15aTHRVxOiAN3
 30hy6w1lRFH+VenrnDPCntPl2SXmSBDbqZ7Tf5e/57WEKdpjLbfC+jzY4Nj4UvunUM43JKCqav0
 Eh5647mQ/y/wKLvk1ZrOmU29teQJcIw1YVjK1LoLAj7gt7jY75EPbTuSMD22WPaQRojOj4BF8K9
 KQyxd4iGuc9BU6QMAuJJQxVO9sSWyX7yB14mDRnrF/TkJgrI8+AwUbnqQrNtHZa8IwgeGA6D7DR
 GDhiLb+FmekQCFUSDhg==
X-Proofpoint-GUID: j-pVZ_yj7OMrEJeMQImZgL7PUbDkQP2v
X-Proofpoint-ORIG-GUID: j-pVZ_yj7OMrEJeMQImZgL7PUbDkQP2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
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

The field evdev_priv will have valid event dev pointer only when
eth_rx_adapter_queue_add() is called.
In case of poll mode tests, queue add will not be called so this
will be NULL.
It is fixed by having a NULL check before access.

Fixes: 01a990fe40e8 ("event/cnxk: fix OOP handling in event mode")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/event/cnxk/cn10k_eventdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 0c1431b4e7..2e4b8aab92 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -675,8 +675,12 @@ cn10k_sso_rx_offload_cb(uint16_t port_id, uint64_t flags)
 	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
 	struct cnxk_eth_dev *cnxk_eth_dev = dev->data->dev_private;
 	struct rte_eventdev *event_dev = cnxk_eth_dev->evdev_priv;
-	struct cnxk_sso_evdev *evdev = cnxk_sso_pmd_priv(event_dev);
+	struct cnxk_sso_evdev *evdev;
+
+	if (event_dev == NULL)
+		return;
 
+	evdev = cnxk_sso_pmd_priv(event_dev);
 	evdev->rx_offloads |= flags;
 	cn10k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
 	eventdev_fops_update(event_dev);
-- 
2.34.1

