Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C729CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A8D406BA;
	Mon, 15 Jun 2026 18:27:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6A54B400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbheI1123874 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 C78UXBK+3+HTsa2JGeUM0Njp6J4xFL2wxq+8kny2io=; b=kP+MdQd19J1GYu5uG
 9EXzAZ4k//XFrsBFMggE/2CYKT+JbcIlapWqI+aq3TrEG/rvz90gak+sTFRM1QWx
 RAfDCp7onUiQrQmeiXwcnsmlBwMTH58+V7XCG3yxjajCRovYgVqJmMcj+TU2GvLV
 FqAjM60XirkKqBKKZRNFJiubeOFJ7qfpWNcX+XmQAcMpG72ksi6+jfKunro53gha
 Gmxsg0Vtfltww8pnfRDyqHKMu5V+tmJSlhPZiSl2zdONOi97fHrO8CwLAaCk5AWt
 feEqklXRiK/93I46mv5Wuul6ck6y3vLyXUrTqYXd0BGFNQXANXcbSoCMyItGAwrb
 gWJig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk067j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:57 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1F7C73F7063;
 Mon, 15 Jun 2026 09:26:54 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v3 13/20] net/cnxk: derive ethdev from SA for inbound CPT CQ
 events
Date: Mon, 15 Jun 2026 21:54:39 +0530
Message-ID: <20260615162446.578336-13-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LE7rPCmCqrpC2HOV3Spsx6KKisEJb__R
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027d2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=tdCZ4XcxNkfdhnRNllIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX425dB8Idl087
 oAuIHt4zHQhhCfmZiGuHHMP0xCQX/RfyFP/ObVnYjh/0CFplgfMszpvrCYkYnwjuwof+teYJjOS
 KX7b3LAegsUg/YCCXggvIHcGVDsdn/4=
X-Proofpoint-GUID: LE7rPCmCqrpC2HOV3Spsx6KKisEJb__R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX69P5qmk7X4BI
 yvGgrpgWgDGdlWRvXOcykSXQbAoDbn9Kir5WtvUbTYnFEv4A/FuMq39M0KWtYUEINyo10fw35+d
 HlU9mz9o+E1Rl9Y3Fr6NduePZdCJMNXmnYv3lUt7CqGOEB56LVKUOFHGS5pVdC//Swcu6y1F1m9
 EKSfiwmV/6CX2pTyUmMa41+Hn5k0eZcQES54DnSghJpVmc7w7uU/drorZzdwPlAlXXBs6PZm9Xa
 vkTSLx1f3TgKTQ4Q/+bPZZEjM3jhk4rjvdVmWzGA6er/4T0GCZ2bpHHG09KbAUkhhL9JrAytdoc
 VSuB7w7HoOzwO/8JgT2RnHsr7Hv7wp8pDV3VGMuUsIMFX+Z5FmJF0Fytfh7oy7QUXs4/F9ATu7r
 IfmbIZOj19iph77IclyeTIPr2umksul9GUXuMIC1r5lQRx2djP86fU27yZhPuTHsM0gF9Ch8Fwj
 iMyfVx6yzY4K2FfQkQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

With inbound CPT CQ events, port_id is unavailable since the inline
device has no roc_nix. Resolve eth_dev for inbound CQ events in the
cn20k PMD callback via the SA private data chain instead of relying
on port_id.

Add an eth_dev back pointer to cnxk_eth_sec_sess, populated at
session creation, to complete the SA-to-ethdev lookup path
(inb_priv->eth_sec->eth_dev).

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/net/cnxk/cn20k_ethdev_sec.c | 22 ++++++++++++++++++++--
 drivers/net/cnxk/cnxk_ethdev.h      |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 31f2518ea3..a5be85901f 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -541,7 +541,6 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 	uintptr_t nixtx;
 	uint8_t port;

-	RTE_SET_USED(args);
 	plt_nix_dbg("Received %s event", get_inl_event_type(type));

 	switch ((gw[0] >> 28) & 0xF) {
@@ -561,8 +560,26 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 		/* Fall through */
 	default:
 		if (type) {
-			eth_dev = &rte_eth_devices[port_id];
 			struct cpt_cq_s *cqs = (struct cpt_cq_s *)cq_s;
+
+			if (type == NIX_INL_INB_CPT_CQ) {
+				struct cn20k_inb_priv_data *inb_priv;
+
+				inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(args);
+				if (inb_priv->eth_sec && inb_priv->eth_sec->eth_dev) {
+					eth_dev = inb_priv->eth_sec->eth_dev;
+				} else {
+					plt_err("Inbound CPT CQ event: no eth_dev in SA priv");
+					return;
+				}
+			} else {
+				if (port_id >= RTE_MAX_ETHPORTS) {
+					plt_err("CPT CQ event: invalid port_id %u", port_id);
+					return;
+				}
+				eth_dev = &rte_eth_devices[port_id];
+			}
+
 			if (type < NIX_INL_SSO) {
 				cn20k_eth_sec_post_event(eth_dev, args, type,
 							 (uint16_t)cqs->w0.s.uc_compcode,
@@ -804,6 +821,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 	inl_dev = !!dev->inb.inl_dev;

 	memset(eth_sec, 0, sizeof(struct cnxk_eth_sec_sess));
+	eth_sec->eth_dev = eth_dev;
 	sess_priv.u64 = 0;

 	lock = inbound ? &dev->inb.lock : &dev->outb.lock;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index ea6a2be30e..6686fdba31 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -225,6 +225,9 @@ struct cnxk_eth_sec_sess {

 	/* Out-Of-Place processing */
 	bool inb_oop;
+
+	/* Back pointer to eth_dev for port_id derivation in CQ callbacks */
+	struct rte_eth_dev *eth_dev;
 };

 TAILQ_HEAD(cnxk_eth_sec_sess_list, cnxk_eth_sec_sess);
--
2.34.1

