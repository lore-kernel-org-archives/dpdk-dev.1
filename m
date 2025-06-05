Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD73C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 261E640616;
	Thu,  5 Jun 2025 13:42:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1CF844065F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:42:40 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NTNFT027379
 for <dev@dpdk.org>; Thu, 5 Jun 2025 04:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 TPqlOK876A95Z+QFpubSNrtzwsZ0zWq0GmPrKmfFqY=; b=PuL46wACCwGW1fn4S
 rr6FTJE3MxS0DwkkkKzpwDZgqiG1yupp4n4+015PvdpHRcysqeSiP0gN7fBPvzx8
 878jnyVVWD4y+3TcGVjvVoP6qFLvueeYug+4hmFmDmVaz/6npcWkRVC2tn5tlrsJ
 1pywd8vxkLjq2QZL21OshLXLKM8lXQnOPrZtKSjNbXNmxKSEKzEx+mN8bVQaL6xI
 6rTYfpCKWPJA8FuWQRGO/rA4y3Xfr8YgA7IzkYHEjAaE2TPJOvGZKUu1pxhHibLm
 c+Uj56TcxzQUeEzSrkXwl7CFv43Bb6+nECSRh0tW85N2K85yGqK5Ee5uo/vVK3NE
 rgOgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472yursb4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 05 Jun 2025 04:42:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 04:42:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 04:42:38 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 903E43F7051;
 Thu,  5 Jun 2025 04:42:36 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/6] common/cnxk: provide port type from fwdata
Date: Thu, 5 Jun 2025 17:12:16 +0530
Message-ID: <20250605114231.3036050-2-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605114231.3036050-1-skori@marvell.com>
References: <20250605114231.3036050-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YuQPR5YX c=1 sm=1 tr=0 ts=684182b0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=x9mx7A_yV6r5R7-WvSUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: EI0ANzxNQJknd5RRKZC1G6CV3elrnI-W
X-Proofpoint-ORIG-GUID: EI0ANzxNQJknd5RRKZC1G6CV3elrnI-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEwMCBTYWx0ZWRfX60GMGX5VJ3Tl
 HQYxOWjT02rARDXojsmtxH3/ASQ8fnupy4DNkNbylfNvdT+QDphdEraIBRZXtosW8GzTAwdGXtP
 ehTgmjCxrC2Q13Qcy3OCAJCyJLebhYo+7reh+CFT2E+U3MlPGht5iQSpxkyUyQrG9uTidQjQUaT
 EZhiRvksVvulllj5K++MrM+alsfHKlyYFcvNYLvuIUiE2VyKOwOvyCuEBTo2QwI1+5zDE0v/t1x
 +SMSZVOL+MEobfQ2l7zr/U46ibeMTa0Oi92opE5QuF76PIBCJN4pQQF9Lh4XHSa1EKs7WCfijc4
 LF+RfhZkYuTj1Rvayhzo1bSA1Wg7xw2lLo4TPmQ2EcerN/SCx6JBPBjKVWwEkHl3IpPmWK+IT8B
 PH8lFu3B6nxUp2cS+6VnuQ0unxbZcsbGphZcfkNF5JoEcs6o4YlVo7NVY8I2C6D+D3Bz9OeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
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

Retrieves type of port from firmware data.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/common/cnxk/hw/nix.h      | 12 ++++++++++++
 drivers/common/cnxk/roc_mbox.h    | 13 +++++++++++--
 drivers/common/cnxk/roc_nix.h     |  1 +
 drivers/common/cnxk/roc_nix_mac.c |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index f344d4de99..c438f18145 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2751,4 +2751,16 @@ enum cgx_mode {
 	CGX_MODE_MAX /* = 51 */
 };
 
+/* CGX Port types from kernel */
+enum cgx_port_type {
+	CGX_PORT_TP = 0x0,
+	CGX_PORT_AUI,
+	CGX_PORT_MII,
+	CGX_PORT_FIBRE,
+	CGX_PORT_BNC,
+	CGX_PORT_DA,
+	CGX_PORT_NONE = 0xef,
+	CGX_PORT_OTHER = 0xff,
+};
+
 #endif /* __NIX_HW_H__ */
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 59287253fe..c819bd2afe 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -755,8 +755,17 @@ enum fec_type {
 };
 
 struct phy_s {
-	uint64_t __io can_change_mod_type : 1;
-	uint64_t __io mod_type : 1;
+	struct {
+		uint64_t __io can_change_mod_type : 1;
+		uint64_t __io mod_type : 1;
+		uint64_t __io has_fec_stats : 1;
+	} misc;
+	struct fec_stats_s {
+		uint32_t __io rsfec_corr_cws;
+		uint32_t __io rsfec_uncorr_cws;
+		uint32_t __io brfec_corr_blks;
+		uint32_t __io brfec_uncorr_blks;
+	} fec_stats;
 };
 
 struct cgx_lmac_fwdata_s {
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 41334327bb..a62ddf4732 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -507,6 +507,7 @@ struct roc_nix_link_info {
 struct roc_nix_mac_fwdata {
 	uint64_t advertised_link_modes;
 	uint64_t supported_link_modes;
+	uint64_t port_type;
 	uint64_t supported_an;
 };
 
diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 08b4f30810..376ff48522 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -436,6 +436,7 @@ roc_nix_mac_fwdata_get(struct roc_nix *roc_nix, struct roc_nix_mac_fwdata *data)
 	data->supported_link_modes = nix->supported_link_modes;
 	data->advertised_link_modes = nix->advertised_link_modes;
 	data->supported_an = fw_data->fwdata.supported_an;
+	data->port_type = fw_data->fwdata.port;
 exit:
 	mbox_put(mbox);
 	return rc;
-- 
2.43.0

