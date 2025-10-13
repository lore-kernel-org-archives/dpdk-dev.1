Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9846CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC3034067C;
	Mon, 13 Oct 2025 09:00:39 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BB3C440678
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:38 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNgmCH023055
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 eb98/Rvc0nVX6Ay41I2rQyJr/iPWPahsvJqWvi9/vw=; b=Gnkjy/S7UfcrObrtB
 QljossORIA5B5k5fS2xN22SQMzVI3dQ0D2vjB7XNGY792E+onk3e+U2IcJAqF9vV
 +DtTUF14ImDTJ52SqZdil7JnlYIYNxfVsc6HauzSOIPJuRAc9USXqY+fJcGbSBC0
 9BjiYST4izTnN7oUFcqJ9VMohU/j0WSwF0gNSgP9bYjCr/LRrsBJACnjgDyxHco0
 RtyHMNUIRRtWGdw5VNGgoSVbUZ5W675Y2wC+AMsw4+v3GC6wenoYUnO/xWFBJ8w7
 ZCI/OiGqrw6E8y9vp6/ysmn7nkc710ADWbBnKcrgl+ZLX5GiArLbC/M3vGcTSZ7l
 rUW6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1jrmm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:47 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id A64EF3F70CE;
 Mon, 13 Oct 2025 00:00:34 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 14/19] common/cnxk: increase Tx schedular count
Date: Mon, 13 Oct 2025 12:29:44 +0530
Message-ID: <20251013065949.200414-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iu388sYyRLbaRGNK_eQyf6lZRAMhUxWD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfXwm2FsAo0415N
 DS9w0JdrX0V9nvoK38/qzme6G5DGuN3yJJRW18LByjtIjAsDJqw4sC4iS8ok1AfEFHLNXQvqUZG
 AeNLxI78f/czbNty9Xq6/VhfmWB5nyL41Yn+VoZwTz8c3/78cTXnOJioBaSSFFOCdNsTiCwqsx1
 BcpLgivaRPqa/ldQpJvYj+CKaSZrZ9WNsPfvDsrFE7z50/Vxgqh0pjORPed5SorrVvp5O/1QaAr
 leYjRC1PsufXx7wvXbhnWo29clHQF1dTU+ntb1sYtJwxuIRX74M/ORMJnIQwv6ljLlu47MEqBVv
 l9fuG3m0ztoEPLxrm3OrMRSv12kdI9B7k2Jkwux68JoXopGTPoRYwpbY7Dr5ol0VuG9TggH58/g
 yQltvIvfaWRkL6+uE3evFzo+H/FB7A==
X-Authority-Analysis: v=2.4 cv=Utdu9uwB c=1 sm=1 tr=0 ts=68eca395 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=9znxC1Y1qzjyv-Gufa4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: iu388sYyRLbaRGNK_eQyf6lZRAMhUxWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

CN10K platform supports Tx schedulars up to 2K.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index dc61a55d1b..b5553223cd 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -41,7 +41,7 @@ struct nix_qint {
 };
 
 /* Traffic Manager */
-#define NIX_TM_MAX_HW_TXSCHQ 1024
+#define NIX_TM_MAX_HW_TXSCHQ 2048
 #define NIX_TM_HW_ID_INVALID UINT32_MAX
 #define NIX_TM_CHAN_INVALID UINT16_MAX
 
-- 
2.34.1

