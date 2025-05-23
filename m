Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DBC54ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:55:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7674540E1E;
	Fri, 23 May 2025 17:54:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E816440DF8
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:49 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9k4I030039
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 3DZZS/wxwdxBfag16FvbJhtzrukb831e/YjJraQky4=; b=Hm8bFTlAlYwJzaOZD
 Fm4O7q+Df4sFPqpiFnDEzQ45fmnB/aVKj5afky4Lisj1V+yj9xThfIuwreHdP4iQ
 iR/YMe+62DVFP/PDHKFj0wQqztNpkMoUfcCjDCT2s+jv9EihQY62YuMFXSR6QHC/
 yRIJ/NQ6289HoxK+SSd4/7JlHI/b89SX4NAsetuCl37XqaAYEDNQSfFc+h1WBPJF
 k6U8L4WVJSiHe5nEfoLGA8hjo0ns9nGrP++lS8jhbfz60SsNHcKJ3qS9cpDDnqLu
 jnOrInXydFc1yYnDQ6e782HRyLZuLuFBIYjuMP0B6w4fsqmafPfTDixB7GtWOv9T
 Tdy5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw58hkw-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id E800B3F7078;
 Fri, 23 May 2025 08:54:42 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v2 6/6] net/cnxk: fix bufsize in lookup memory
Date: Fri, 23 May 2025 21:23:47 +0530
Message-ID: <20250523155347.1156891-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523155347.1156891-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68309a48 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=1fU4HGiP39tO4nczV9gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NCBTYWx0ZWRfXyWK+P08Mi2sc
 LNDNtKG+srvVW5vZL18nbchr4bbe0OM6AsdXct6ATIrVwS6perrQV4DFt6IiVAN0t9M6GgTd8+2
 pxcF702vwqRe9IydJ+yYVw/60tIywUy41UWnWbcnewQw6NTttQzDACXZpE4blMSKKo6eEi8vfk0
 7JbBfzamC4NxwXoOsKTbFOwxYzskmWelMdA9OjnxWTuewxmHQtI/1OG2IxP6z+FQnEiLctm9oEU
 8FxYmssoM5K61OfBKWnjwBsHSfVOBiquYeZfx6sXalAjh+NBoX7vJ7icoqxxI9emCeFTzCjNgSJ
 P4I8ZEmK733mLU1DxZ9hTZpsH62lq8Q+Xo1V3J6j9XuPUBVSuZOyE/ZFkzNILAULDFidBErFwNz
 Zd+PcJtthRz9Qi8wm2YdbZ+Q624DTWKyg4YIraFnVazilVod/QbOvzDuyikw2LLXlRh5T1Zt
X-Proofpoint-GUID: fJpcuyCMqfvEuSbzJwW4ak1KiuRYlt3z
X-Proofpoint-ORIG-GUID: fJpcuyCMqfvEuSbzJwW4ak1KiuRYlt3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
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

Update bufsize in lookup-mem by default to maintain
data order.

Fixes: b826d043c01f ("net/cnxk: store pool buffer size in lookup memory")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: updated the commit message.

 drivers/net/cnxk/cn20k_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 740fdb7f76..159ce39e97 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -604,8 +604,7 @@ cn20k_nix_dev_start(struct rte_eth_dev *eth_dev)
 	if (roc_idev_nix_rx_inject_get(nix->port_id))
 		dev->rx_offload_flags |= NIX_RX_SEC_REASSEMBLY_F;

-	if (dev->rx_offload_flags & NIX_RX_REAS_F)
-		cn20k_nix_rx_queue_bufsize_update(eth_dev);
+	cn20k_nix_rx_queue_bufsize_update(eth_dev);

 	cn20k_eth_set_tx_function(eth_dev);
 	cn20k_eth_set_rx_function(eth_dev);
--
2.25.1

