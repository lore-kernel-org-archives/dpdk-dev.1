Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE34F8A167
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 12:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62EAC4042F;
	Thu, 16 Apr 2026 14:00:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8FB1A40658
 for <dev@dpdk.org>; Thu, 16 Apr 2026 14:00:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G7YjGv143734 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:00:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=72wWaPvtTFcci6OgLrUkQDB
 iWV13qzNOMSxOMXLeVb4=; b=ZWb/UI1fd4KVjRhff33s2uluoTJbxO0eHJdACk+
 kSTvDUU4Gmb8gtDEWSKGJlTOU05LvUzrv1Uw54il2OYEpZ8+kYHNmya1eFguC3GH
 7f7RW+kjYPs1FJU+IIc3vS9eJShUH2IeE4uo/4mMAW6l+HHyvvrDlNUzaKCmaMaH
 Jzwpaazq1bQqbPpiLFtguL2/IiRpQmhmjeVn5B1PHvbvIyRcfmO26FdT6R7EJvHq
 lkP/rPGqDN96BIfpXxwCEC5yGJdlMLNcQZThbdV1kiGQMesNSh2xLfZO24XNyTDJ
 6Bnc+1sbdDw5o0zAY8cszuBeTendZQGjJIVBfVzWqIHLLCA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4djugbrhwf-16
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:00:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Apr 2026 05:00:43 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Apr 2026 05:00:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Apr 2026 05:00:37 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 0F2343F7067;
 Thu, 16 Apr 2026 05:00:33 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 1/2] common/cnxk: add FEC configuration support
Date: Thu, 16 Apr 2026 17:30:30 +0530
Message-ID: <20260416120031.3553798-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tkUHxjSloxk-hx9z2auzMp0CRNZOQW-M
X-Authority-Analysis: v=2.4 cv=Y5rIdBeN c=1 sm=1 tr=0 ts=69e0cf72 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=xu7QeC3gvlaRLQ3BY4cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMyBTYWx0ZWRfX1l4G3hSOwelY
 QieD5v8vVAOZxZXhNnYt/RoiXdNHZ7B86LsHRj+aGC1nG3SVS+e4q+y+l+jotXIEPT1wuHcvHFn
 eYoZwvAi3aAwdD32tNyvsCvHefezTHnVV6oPQee4tvylgJ2vvemhtZMxhvzZSG6uCtxkFaLqqE5
 TBKEmvTalOzZLCe2HQDAMnKXehbw7Gvl3LQI5OVuLfDVsG4sJQdZ2ok5GrzUJSetBKcqKFx+Pj4
 Gr/pSTAw5krKlmRwWj4/bC4IygggYUtt+8gZpu+ma9tSeM+f+wfUGl6i5lGrOi5c+ZhiWe9PV1E
 GvazRQKZ5PW4kZH0fP2E4cYktB6WL2ndJ0QENniJkdDeMozEjp1667G5Q6PVS35XKH7sahDmj38
 I5cDSHYyCT68l5ynyID+EyqIPN9sweUvfnHnep02JMvBkVwjISUDk3bGis8re+KRrrvHjSxj7pw
 KSkAdx6COfZmFO+oRWg==
X-Proofpoint-GUID: tkUHxjSloxk-hx9z2auzMp0CRNZOQW-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Add ROC APIs for Forward Error Correction (FEC) configuration:
- roc_nix_mac_fec_set: Set FEC mode on the link
- roc_nix_mac_fec_supported_get: Query supported FEC modes
  from firmware

These APIs use CGX mailbox messages to configure and query
FEC parameters on PF interfaces.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix.h                 |  2 +
 drivers/common/cnxk/roc_nix_mac.c             | 51 +++++++++++++++++++
 .../common/cnxk/roc_platform_base_symbols.c   |  2 +
 3 files changed, 55 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 8ba8b3e0b6..6130e4c42b 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -975,6 +975,8 @@ int __roc_api roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 					struct roc_nix_link_info *link_info);
 int __roc_api roc_nix_mac_link_info_get(struct roc_nix *roc_nix,
 					struct roc_nix_link_info *link_info);
+int __roc_api roc_nix_mac_fec_set(struct roc_nix *roc_nix, int fec);
+int __roc_api roc_nix_mac_fec_supported_get(struct roc_nix *roc_nix, uint64_t *supported_fec);
 int __roc_api roc_nix_mac_mtu_set(struct roc_nix *roc_nix, uint16_t mtu);
 int __roc_api roc_nix_mac_max_rx_len_set(struct roc_nix *roc_nix,
 					 uint16_t maxlen);
diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 376ff48522..4f856677e0 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -257,6 +257,57 @@ roc_nix_mac_link_state_set(struct roc_nix *roc_nix, uint8_t up)
 	return rc;
 }
 
+int
+roc_nix_mac_fec_set(struct roc_nix *roc_nix, int fec)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct fec_mode *req;
+	int rc = -ENOSPC;
+
+	if (roc_nix_is_vf_or_sdp(roc_nix)) {
+		rc = NIX_ERR_OP_NOTSUP;
+		goto exit;
+	}
+
+	req = mbox_alloc_msg_cgx_set_fec_param(mbox);
+	if (req == NULL)
+		goto exit;
+	req->fec = fec;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_nix_mac_fec_supported_get(struct roc_nix *roc_nix, uint64_t *supported_fec)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct cgx_fw_data *rsp = NULL;
+	int rc;
+
+	if (roc_nix_is_vf_or_sdp(roc_nix)) {
+		rc = NIX_ERR_OP_NOTSUP;
+		goto exit;
+	}
+
+	mbox_alloc_msg_cgx_get_aux_link_info(mbox);
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+
+	*supported_fec = rsp->fwdata.supported_fec;
+	rc = 0;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 			  struct roc_nix_link_info *link_info)
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index cf080b1bdc..9584c1d259 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -304,6 +304,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_rxtx_start_stop)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_event_start_stop)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_loopback_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_supported_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_entries_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_add)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_del)
-- 
2.25.1

