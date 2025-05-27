Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA8C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F204066A;
	Tue, 27 May 2025 13:02:18 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C40594067E
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6XlJD024913
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 NT2PMZaoGjHXal4xNlt+JkO/H2fS+M8nOvxS5d6cIw=; b=jPLL3zoOjrB67yuI5
 GpEj1GyMHzQzHL66hZVf4p4kqlijdZdT1BkGlPGsmrbd3qFrWMroRdR6iM7Shais
 mOZIfMMq/dvoW8VHa5dRhZ7VCp60UAN0vRlKlS1SDNhlY1z+VBwtFY6jq6o8Nz9G
 3QG7M0LyrD7NZVXuUMNZ1mjqT7tNjCdsuVO6pC+wqCsnifnOVaOPda8L/X5I2PfQ
 lpSsaOo/a1VUnuh9XC0SmQ9l16u7MKHamreL6UWg/GJpCK+ebz62NbAhKn5oDJjW
 fXR2NYUxp++iKU1zrTbYTFeSsK47GD4+4RhVRPd98K+8mRi1UnLt6gTlknLZ2YfX
 hqUZg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8800ebs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:15 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A09923F706A;
 Tue, 27 May 2025 04:02:13 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 03/25] crypto/cnxk: add dev info get
Date: Tue, 27 May 2025 16:31:43 +0530
Message-ID: <20250527110205.2300800-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX37Rm+ggDM9Tc
 RUHZmBqhJZgBjulgH09wu7qZY9IWcGgmgSrTkYY+HtKypRrXn2yC5XN2WRaFq+iOFHUu5vohK4D
 5qOWv6UmCIPX/8ImWFpmLPf7u/PJ4MZAXCnal/9IwWi7jbyBl3IcTujqH8k7/d8oC6F83nsm+pm
 /60gpBJDzDqcJCLw+FBRA4zB2VW91YOZxHch42OOkJHFJQBX3dPdqpF9/SdgHb9AUFvzwqroJo7
 0PooQB12Eto22PWed5jxeB7x4NS8k6xcjmUUquVJd2g4eMu+gOFztkU6JcRFZPp4/kLUq+EWAm2
 KOc00c53eVKrVy1IJtUXShbyxQ5hQ69CjtoJqcOWwco0yVSE/anQXwJn+y5/f1xZoKCNr4V9EWs
 ZEt3jelscX+uH+zmA0cpJXodAXNGo45nk4cH3tx8QDInnfbKjoia8IeIzDJ5HRlkVxYKbZq/
X-Authority-Analysis: v=2.4 cv=LZ086ifi c=1 sm=1 tr=0 ts=68359bb8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Pe1cafgnUAMM2Of7aycA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: cMz6R-QYDaFB0QrBpQdTFboKVxr6Gr_a
X-Proofpoint-GUID: cMz6R-QYDaFB0QrBpQdTFboKVxr6Gr_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add dev info get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 64ab285235..ac321a2b91 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -33,8 +33,10 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 static void
 cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
 {
-	(void)dev;
-	(void)info;
+	if (info != NULL) {
+		cnxk_cpt_dev_info_get(dev, info);
+		info->driver_id = cn20k_cryptodev_driver_id;
+	}
 }
 
 static int
-- 
2.25.1

