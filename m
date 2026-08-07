Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701AC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E47C4027E;
	Fri,  7 Aug 2026 12:16:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CD1A840264;
 Fri,  7 Aug 2026 12:16:38 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6777bfww755560; Fri, 7 Aug 2026 03:16:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=N58avRFsVIm2IzHvGIiW9v9
 O0RMH8lCv32QI8WcBM8k=; b=e+QYd+1nHclK9wjc031YZGT2gEZyvHv489Zk91l
 773e59JXGpHJuCA0G7VWJBgCedZC+O8iJp3W4KDfoEharrea/rwZ4SVYkIbDypWm
 O9NPwhtZlom4HEJQDf1PQSvHx5VYIhKS1rSqke2pj/43wSVxWhAUnCpyj7Gw2z5t
 pak/6KRhJWVFsMMWYMGv06fB00K4xyadKjurlu9lg96M4uv9rr2+L4idZln4yyqC
 P/o2aHMiRSnSPhy9wXkFcwANkGYZA3SZdZswktqmALulCGLRwC/4SXVheCWqb9Dk
 wC7N20eDmVlhy5wDo9/6io9nY5ksOLkpNZaZjWYScm0cOxQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fvy5vu0vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 03:16:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Aug 2026 03:16:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Aug 2026 03:16:36 -0700
Received: from cavium-SR1-T640.. (unknown [10.28.36.102])
 by maili.marvell.com (Postfix) with ESMTP id 3B51A3F704F;
 Fri,  7 Aug 2026 03:16:33 -0700 (PDT)
From: Akhil Goyal <gakhil@marvell.com>
To: <dev@dpdk.org>
CC: <jpalider@marvell.com>, <tduszynski@marvell.com>, <jerinj@marvell.com>,
 <thomas@monjalon.net>, Akhil Goyal <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] raw/cnxk_gpio: fix out of bound access for negative gpio
Date: Fri, 7 Aug 2026 15:46:30 +0530
Message-ID: <20260807101630.3571199-1-gakhil@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ot5/DS/t c=1 sm=1 tr=0 ts=6a75b085 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=WVCrVrVrQjCZBLGTpbsA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX8vgP3rSeTdXQ
 wrOWKmalEUasmug0rJkMaKiKur2TxbdM7rDIe2eexeHSE/XWQuhTF6Ui2mmjwY9UTeBYhIZWefo
 bQGbDgVvql7qFeb2JrdHmI2QFaWpvCXBd4++GjLNUHAaJNxIPza1A51JhabZSrF++qcBGiBtY5E
 v62YAky75dKaepx3Gd1PU/AfJUI22eLAIUvrzItHTSNSzLFA+ZOiEXVP+nLLmPfedJ2/c6+xkid
 xILVDOIxObS8x7zfa3DcyemJjSswiKqD8vKZCke7+8vLTp1hIua5nx0WkZ6zPLe1v1ztOaBi2LD
 Fq8WLltEufaCcRyRijHFt+kTI9VumtgejJmRFqRu2Z2ZeWs8/YP+oxCnls4dN18ePgNSZWx1HDm
 ZCw9Y258aXwBCT7AjrWo4KwD71fM8c7vlGrI3s7FgM/Ly0YcBIZUYgmfplTAab4xlC9NYP0xWwd
 VgwAExrAzMq2D2en71A==
X-Proofpoint-ORIG-GUID: ruK-PSX__DRSbklea9z5aKJdBKRU_pAw
X-Proofpoint-GUID: ruK-PSX__DRSbklea9z5aKJdBKRU_pAw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX4PT8/UOIMFhp
 lr5nVirawl+dYEYqkZ7T7i77S9GDLDb5OyCrFVNTjGGfVnGj8IGljWFgL2OnxCrIeBE7LlZS3pU
 hev1PGjpFsWW5pzYLAWaXWgCc2YJy9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
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

cnxk_gpio_valid(struct cnxk_gpiochip *gpiochip, int gpio)
validates the GPIO number with only an upper bound while gpio
can be wrongly configured as negative value from application.
Added a check to reject negative values.

Fixes: ecc0dd455e9a ("raw/cnxk_gpio: add option to select subset of GPIOs")
Cc: stable@dpdk.org

Signed-off-by: Akhil Goyal <gakhil@marvell.com>
---
 drivers/raw/cnxk_gpio/cnxk_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index 0549e326f9..e22fb7cf7b 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -795,7 +795,7 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 static bool
 cnxk_gpio_valid(struct cnxk_gpiochip *gpiochip, int gpio)
 {
-	return gpio < gpiochip->num_gpios && gpiochip->gpios[gpio];
+	return (gpio >= 0) && (gpio < gpiochip->num_gpios) && gpiochip->gpios[gpio];
 }
 
 static int
-- 
2.43.0

