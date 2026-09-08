Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58CC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:27:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9442040F1A;
	Tue,  8 Sep 2026 18:27:46 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id A1AB84028D;
 Tue,  8 Sep 2026 18:27:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023074.outbound.protection.outlook.com
 [52.101.83.74]) by mx-outbound44-93.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 08 Sep 2026 16:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfyZN70LBQKNxWhJ2HLGa3SBqdSEwfG0yW/H275Og8/+0lvCwR5dl3qIhRkS6D2tLspbRixDrc4Y/wpzG+MIdidjweoQV61LYr85ry1VBvPGxpcUyAh3B5Kiq8PyXwzws7mEQsY2Ki7XZfeeCfgDPziOuyB2KTooxzkxfNBoGcRb0klZ4AAUDj9Sik6ylliGVq+qTWlY2+gWrJa9DYos7gxEOJxIbyPgN+N59YqwVSeagtt9B/dE1zsWHW4MV+LcX9cxrnyEQAy+WMoIEtotFIwtvrsYp24w8uW0crIimULfzg2OKI/UkdNqatVuTcsj3QOhJ6IN8pJ6bfoE7YdpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzML5lgqkrEWaTFc0etQUd3/JpIjCwnH7IX6hBKyi90=;
 b=qzvuTG0HMjszYnIZFZXVZN+w8oncFddwn/s1G9r70g1Ozx6KqQBzn+6VL74nqoGchDDrjBouOHIKqNtkvITN6OVJ8DjmW9NdwfIuGdj8h6In/kmyZ4RiODrOXCoLiFq9WZdAp3AHX4Cv3DA0yKVzl8PV4eddDlcYK8qN2r01L+HofVZW58VlI3h+pC48TzxwgumWajg0Dq48jKrAz0gK7LMAWNs2Z7Yrscsf+77lV9Ncy950B3a31QH0qRBEt11fBfZbdLa9JvY90h94AHRbFwxpJ2PMKsIx2WUQnPyw91gAGwnSt2D0djTlWHDUvfX63cWSx2iZfBY6rgHPJQr/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=napatech.com; 
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzML5lgqkrEWaTFc0etQUd3/JpIjCwnH7IX6hBKyi90=;
 b=iqH6ZwnegBT2jRsTdxDZxxbaVcuPKpeDOWu9sPm6PJHOHBZZ0l7XSTuk8Jp8at0fPoyKloHzJqsAydGAaxz2CyJ0jfeVq7LtdP+viqHiTVBQB4Qmb9H3j/OlOcH4ce7IkILBBq2Cq76E3g9NIHwG1m/sjz1i7mKV6DzHlXgHngQ=
Received: from DU6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::7) by
 PA4P190MB1344.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Tue, 8 Sep 2026 16:27:38 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::ae) by DU6P191CA0051.outlook.office365.com
 (2603:10a6:10:53e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 16:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server id 15.21.382.8 via Frontend Transport; Tue, 8 Sep 2026 16:27:38
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: stephen@networkplumber.org,
	mko-plv@napatech.com,
	ckm@napatech.com
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: [PATCH v1 2/3] net/ntnic: check virt queue hardware setup result
Date: Tue,  8 Sep 2026 18:27:23 +0200
Message-ID: <20260908162724.463767-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260908162724.463767-1-sil-plv@napatech.com>
References: <20260908162724.463767-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PA4P190MB1344:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d7e6b43-5fb5-4293-121f-08df0dc618fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: aJcBV2Z4xO3svc9v7DlqdLZp+q0HYtVbCJLYOn+FOKx58h5IdQYsjuO5zrF5LZoRBIf/LBORuBu5Srb1oaTvdRjlQI/bZWYtzzasAZMRLT2TAKPe3neT4YrCf8AcMRba0uPVAQl1OYsnSJXh1XQBw/vU58nZGuXGSI6WIgJ6zaL1u6L1LOAx3ZqbVieZfgE8uggJvS53YXETjmcqwSxY6hvRYcUY/A8zG7iEfpGlNGR8ih0mIpvP32Vwai5F7IrXVVTLuNpW2piWBUgm6+lRxaKuGWk4tWmvCFXALw1g9VzWMIB4wipUQWoTEk9NjMDjARB35vszfueAODjzuY1i+8LuuJdTRab8KhCmiyPVHiDNFjHUK+vJ93+B90i8n54NEc4V5UwtT+F/4Ha1bSg1pnn+VmVMneTUufV4uMrNPDU6YRFanwz4urKawEQSaab14/mTLEeU571UnFSanEPCZmsKHE4euCT/xAW676SD/Mprwk78qyytj/rm6NwjrdxRtCvpZUDxOfVFWRYOd53nGRiUn74QeVskpfLqZn/uuY7DYBKxZQlciAKaAPDRnYCPshVhlek9KvRO/P8ChfIMOVk4buUtpmU7cqwPVFfGI14bJ4OI4zvnX5JxNI5uEOIYxjFgB3QsnLVHI/lgwO9nrQ40pwguyjuvmpwFfq466fbkpxuYrGRaSKaA5v3jNe61qUd/3G8xsh7YssszjGmATQ==
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecDembiQNJo+Tvk/dGOfCgxvyUgOr8DNo4dxI2vXVPUWtNehB/aU9Yiw4sRj3KU6ZH1ViesEyu1jDWCh4ufUaEL4J6eaUTT45wktsg7cc0y4f+EUVZvDTY5FiNTQkgdZ/65ahSseR3MJjPVGH1wvncdXOw2GoVI6vTcB7JIZ02vDmtb1awbCo2QjHejCeZp6BNtXyDE71xw3/RVGQVA+IPDrR6OQxSicEVQHTTQlgYokPg4MyEYUvl4D1irHcX8rNh9MORpo4iGz/KK+z6J+ohluUltzjo+qlQZ4JrNdNuCydsivQVcXmwj+Lv76oIc4uu/Q+vDbjG89kBh6vqm4yTcW8wIOClblj0sHDt5avMaRAb7aPKzlMxlRc4Zf2hyjGMIu6tVOrjEyxdUjcg2P5JdUw7sofk5HuhvpsvxPxwP7x7u0lF2RiXTK3OhPMWOM
X-Exchange-RoutingPolicyChecked: XBPjOP+t6C+Y6CHBU41vjN9VCNzv+ALGMp4V46EnX87c4jiGUBAsyP8TpCUegxZfiiR2QOPIqDvKqbwR7mmLdlxI3xb6zZmoaUtOBJP1nvNKX49acb60tb95btztBZcumDKNTt2SEV3JYO88iIHZM7WQncazfK23WlHdgXIvL3fOnZjs/41uWphFBLqMSnsrJt/u6YGoJyKmJJjG4TzvXg5pf/0EYDuryeWZc1i4C7HIVsTprjnNR8SljGmZAfGAlhIyf2Pp67OtBA9xGL9/JNJvBOd8XgJPiC8iDIgCXOsdmA/QEvG7YkDRQD+aXrDmZj89sRvQIQaRtLEZfUkz2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vsyiz/xGSPWQ6XUwQPP9272PZf8iAHUx/QIVKZ8rTEJjB6I+CV//RWzFuQ16hB2r8R/P8ncpziiZCTHLo5M/uz7pR3nI3ctUsJdU5LbnPWa61vZfJDNKzEQuAnJLhEnKsksLwJ8YWrsK8zhwIQEllhzTf0CIfrDTOl/zMiZiSencok+umVtFxToN1qcXowsWTbQWi33LJ+S3e0E/cXjhAayKlHU4dxkKJy8XJgMSRPL2mZdR8rPZo0O9pzqDR1Eftn23ZeWriEEzttc4x8XKnAWpJDonEkNIOvqCRO5vG5zEazkbU38bg+vy+HpTsfwB4/XTeaOUj+8sxgZSZcVEhoi+vrPD/LnuF56FidDX0Xks5kl+ZuPN3V+b/1zoR0GxF6IbcGA8Y+BFVBuDGVFtLSrGSZVYgqiey2QceEax8n7uOTw1UFXK/3IRH2CNlKqU1jrTCkQLEvjGbtTqKxOIwdLffbPls9BBT48siMlA6cQqPVP/mRhlU60EVHHsEup63nad4TbbffO6lVgfHmK5vrqiKR0AWqLqnKzjKKc3PXKjkxQpv9Thtxv9lzAExowYPluFKYhN2IrWjxq9E7sofxl8Rp40Yit7QlDj88YlWtJVoikj5cUz7WzXVtYl0iVbJOr8LGPk7uU6ulUn8lp8Mg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:27:38.2046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e6b43-5fb5-4293-121f-08df0dc618fd
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1344
X-BESS-ID: 1788884861-311357-15607-2163-1
X-BESS-VER: 2019.1_20260902.2230
X-BESS-Apparent-Source-IP: 52.101.83.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGluYWQGYGUNQkzdDMMMXY0s
 Qi1dQoycDczCDFKCnFMjXVIsk4OTnNQKk2FgCg1UyOQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.275977 [from 
 cloudscan18-201.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

The managed virt queue setup ignored the result of programming the
DBS registers and returned the queue as usable.

Return an error from the hardware setup and, when it fails, fail the
managed split and packed setup paths and free the descriptor copy.

Fixes: e13da07fd9fd ("net/ntnic: add split-queue support")
Fixes: af30088786c2 ("net/ntnic: add virtqueue setup managed packed-ring")
Cc: stable@dpdk.org

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 158 ++++++++++--------
 1 file changed, 88 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 7c10acb4e2..af200432a2 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -357,7 +357,8 @@ static uint8_t dbs_qsize_log2(uint16_t qsize)
 	return qs;
 }
 
-static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
+static int nthw_setup_rx_virt_queue(struct nthw_virt_queue *vq,
+	nthw_dbs_t *p_nthw_dbs,
 	uint32_t index,
 	uint16_t start_idx,
 	uint16_t start_ptr,
@@ -383,7 +384,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (nthw_set_rx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
 		host_id, qs, header, 0) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -402,7 +403,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	if (nthw_set_rx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -416,7 +417,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 		if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				RX_AM_DISABLE, host_id, 0,
 				0) != 0) {
-			return NULL;
+			return -1;
 		}
 	}
 
@@ -433,25 +434,24 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	uint32_t enable = rx_deferred_start ? RX_AM_DISABLE : RX_AM_ENABLE;
 	if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/* Save queue state */
-	rxvq[index].usage = NTHW_VIRTQ_UNMANAGED;
-	rxvq[index].mp_nthw_dbs = p_nthw_dbs;
-	rxvq[index].index = index;
-	rxvq[index].queue_size = queue_size;
-	rxvq[index].am_enable = (irq_vector < 0) ? RX_AM_ENABLE : RX_AM_DISABLE;
-	rxvq[index].host_id = host_id;
-	rxvq[index].avail_struct_phys_addr = avail_struct_phys_addr;
-	rxvq[index].used_struct_phys_addr = used_struct_phys_addr;
-	rxvq[index].desc_struct_phys_addr = desc_struct_phys_addr;
-	rxvq[index].vq_type = vq_type;
-	rxvq[index].in_order = 0;	/* not used */
-	rxvq[index].irq_vector = irq_vector;
-
-	/* Return queue handle */
-	return &rxvq[index];
+	vq->usage = NTHW_VIRTQ_UNMANAGED;
+	vq->mp_nthw_dbs = p_nthw_dbs;
+	vq->index = index;
+	vq->queue_size = queue_size;
+	vq->am_enable = (irq_vector < 0) ? RX_AM_ENABLE : RX_AM_DISABLE;
+	vq->host_id = host_id;
+	vq->avail_struct_phys_addr = avail_struct_phys_addr;
+	vq->used_struct_phys_addr = used_struct_phys_addr;
+	vq->desc_struct_phys_addr = desc_struct_phys_addr;
+	vq->vq_type = vq_type;
+	vq->in_order = 0;	/* not used */
+	vq->irq_vector = irq_vector;
+
+	return 0;
 }
 
 static int dbs_wait_hw_queue_shutdown(struct nthw_virt_queue *vq, int rx);
@@ -685,7 +685,8 @@ static int nthw_release_mngd_tx_virt_queue(struct nthw_virt_queue *txvq)
 	return dbs_internal_release_tx_virt_queue(txvq);
 }
 
-static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
+static int nthw_setup_tx_virt_queue(struct nthw_virt_queue *vq,
+	nthw_dbs_t *p_nthw_dbs,
 	uint32_t index,
 	uint16_t start_idx,
 	uint16_t start_ptr,
@@ -714,7 +715,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (nthw_set_tx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
 			host_id, qs, port, header, 0) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -732,7 +733,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	if (nthw_set_tx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk, in_order) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -741,7 +742,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, TX_AM_DISABLE,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -751,7 +752,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	dbs_init_tx_queue(p_nthw_dbs, index, start_idx, start_ptr);
 
 	if (nthw_dbs_set_tx_qp_data(p_nthw_dbs, index, virtual_port) != 0)
-		return NULL;
+		return -1;
 
 	/*
 	 * 2. Configure the DBS.TX_AM_DATA memory and enable the queues you plan to use;
@@ -765,28 +766,27 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 		uint32_t enable = tx_deferred_start ? TX_AM_DISABLE : TX_AM_ENABLE;
 		if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				enable, host_id, 0, 0) != 0) {
-			return NULL;
+			return -1;
 		}
 	}
 
 	/* Save queue state */
-	txvq[index].usage = NTHW_VIRTQ_UNMANAGED;
-	txvq[index].mp_nthw_dbs = p_nthw_dbs;
-	txvq[index].index = index;
-	txvq[index].queue_size = queue_size;
-	txvq[index].am_enable = (irq_vector < 0) ? TX_AM_ENABLE : TX_AM_DISABLE;
-	txvq[index].host_id = host_id;
-	txvq[index].port = port;
-	txvq[index].virtual_port = virtual_port;
-	txvq[index].avail_struct_phys_addr = avail_struct_phys_addr;
-	txvq[index].used_struct_phys_addr = used_struct_phys_addr;
-	txvq[index].desc_struct_phys_addr = desc_struct_phys_addr;
-	txvq[index].vq_type = vq_type;
-	txvq[index].in_order = in_order;
-	txvq[index].irq_vector = irq_vector;
-
-	/* Return queue handle */
-	return &txvq[index];
+	vq->usage = NTHW_VIRTQ_UNMANAGED;
+	vq->mp_nthw_dbs = p_nthw_dbs;
+	vq->index = index;
+	vq->queue_size = queue_size;
+	vq->am_enable = (irq_vector < 0) ? TX_AM_ENABLE : TX_AM_DISABLE;
+	vq->host_id = host_id;
+	vq->port = port;
+	vq->virtual_port = virtual_port;
+	vq->avail_struct_phys_addr = avail_struct_phys_addr;
+	vq->used_struct_phys_addr = used_struct_phys_addr;
+	vq->desc_struct_phys_addr = desc_struct_phys_addr;
+	vq->vq_type = vq_type;
+	vq->in_order = in_order;
+	vq->irq_vector = irq_vector;
+
+	return 0;
 }
 
 static struct nthw_virt_queue *
@@ -830,12 +830,16 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 				queue_size * sizeof(*p_packet_buffers));
 	}
 
-	nthw_setup_rx_virt_queue(p_nthw_dbs, index, 0, 0, (void *)p_virt_struct_area->phys_addr,
-		(char *)p_virt_struct_area->phys_addr +
-		virtq_struct_layout.used_offset,
-		(char *)p_virt_struct_area->phys_addr +
-		virtq_struct_layout.desc_offset,
-		(uint16_t)queue_size, host_id, header, SPLIT_RING, irq_vector, rx_deferred_start);
+	if (nthw_setup_rx_virt_queue(&rxvq[index], p_nthw_dbs, index, 0, 0,
+			(void *)p_virt_struct_area->phys_addr,
+			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.used_offset,
+			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.desc_offset,
+			(uint16_t)queue_size, host_id, header, SPLIT_RING, irq_vector,
+			rx_deferred_start) != 0) {
+		free(rxvq[index].p_virtual_addr);
+		rxvq[index].p_virtual_addr = NULL;
+		return NULL;
+	}
 
 	rxvq[index].usage = NTHW_VIRTQ_MANAGED;
 
@@ -888,13 +892,16 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 				queue_size * sizeof(*p_packet_buffers));
 	}
 
-	nthw_setup_tx_virt_queue(p_nthw_dbs, index, 0, 0, (void *)p_virt_struct_area->phys_addr,
-		(char *)p_virt_struct_area->phys_addr +
-		virtq_struct_layout.used_offset,
-		(char *)p_virt_struct_area->phys_addr +
-		virtq_struct_layout.desc_offset,
-		(uint16_t)queue_size, host_id, port, virtual_port, header,
-		SPLIT_RING, irq_vector, in_order, tx_deferred_start);
+	if (nthw_setup_tx_virt_queue(&txvq[index], p_nthw_dbs, index, 0, 0,
+			(void *)p_virt_struct_area->phys_addr,
+			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.used_offset,
+			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.desc_offset,
+			(uint16_t)queue_size, host_id, port, virtual_port, header,
+			SPLIT_RING, irq_vector, in_order, tx_deferred_start) != 0) {
+		free(txvq[index].p_virtual_addr);
+		txvq[index].p_virtual_addr = NULL;
+		return NULL;
+	}
 
 	txvq[index].usage = NTHW_VIRTQ_MANAGED;
 
@@ -996,13 +1003,18 @@ nthw_setup_managed_rx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 			VIRTQ_DESC_F_WRITE | VIRTQ_DESC_F_AVAIL, 1) != 0)
 		return NULL;
 
-	nthw_setup_rx_virt_queue(p_nthw_dbs, index, 0x8000, 0,	/* start wrap ring counter as 1 */
-		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
-			pvirtq_layout.driver_event_offset),
-		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
-			pvirtq_layout.device_event_offset),
-		p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
-		header, PACKED_RING, irq_vector, rx_deferred_start);
+	if (nthw_setup_rx_virt_queue(vq, p_nthw_dbs, index,
+			0x8000, 0,	/* start wrap ring counter as 1 */
+			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
+				pvirtq_layout.driver_event_offset),
+			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
+				pvirtq_layout.device_event_offset),
+			p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
+			header, PACKED_RING, irq_vector, rx_deferred_start) != 0) {
+		free(vq->p_virtual_addr);
+		vq->p_virtual_addr = NULL;
+		return NULL;
+	}
 
 	vq->usage = NTHW_VIRTQ_MANAGED;
 	return vq;
@@ -1031,13 +1043,19 @@ nthw_setup_managed_tx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 			p_packet_buffers, 0, 0) != 0)
 		return NULL;
 
-	nthw_setup_tx_virt_queue(p_nthw_dbs, index, 0x8000, 0,	/* start wrap ring counter as 1 */
-		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
-			pvirtq_layout.driver_event_offset),
-		(void *)((uintptr_t)p_virt_struct_area->phys_addr +
-			pvirtq_layout.device_event_offset),
-		p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
-		port, virtual_port, header, PACKED_RING, irq_vector, in_order, tx_deferred_start);
+	if (nthw_setup_tx_virt_queue(vq, p_nthw_dbs, index,
+			0x8000, 0,	/* start wrap ring counter as 1 */
+			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
+				pvirtq_layout.driver_event_offset),
+			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
+				pvirtq_layout.device_event_offset),
+			p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
+			port, virtual_port, header, PACKED_RING, irq_vector, in_order,
+			tx_deferred_start) != 0) {
+		free(vq->p_virtual_addr);
+		vq->p_virtual_addr = NULL;
+		return NULL;
+	}
 
 	vq->usage = NTHW_VIRTQ_MANAGED;
 	return vq;
-- 
2.45.0

