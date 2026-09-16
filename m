Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E8C982C3
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:36:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA6F242ECD;
	Wed, 16 Sep 2026 16:36:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2783B40264;
 Wed, 16 Sep 2026 16:36:45 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GEZPi8489696; Wed, 16 Sep 2026 07:36:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 P39AkjzfRO7NzLjCbaKPnBmgsex6iwicTb+YA1cTcI=; b=QNgfNLbd+eFeT8LDc
 X+vJqhymhiykO2FN9Up6Tofwr3ZJhNYeBu66eNm19St75EdlOQO/A4psQjHWW1Bq
 rHKlh/+rM8Xg58GJ7cMt+d+A97TJ+fYKkwZDGjvb0bufVM0QjwQS3QuyAGwIEPvJ
 15Vue6ERIboXnbYhCBX4na91/RsS6t/34dqHh5nwfOY1RA8xvxubQl4yfguKNGM8
 +zRK4V7weXIW8xwRQNR1F1QRg06+LZRRQSXTpSIgvx3KKUpPCY+t+qDCIj3AIDcG
 YjOT8OiUnjt1NE8G3XUmPFa0KpSf7KsLHyp739Ei7YR8D6/dZFwvcVSmc22bsZ6H
 7IOuw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gqp2m275x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 07:36:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Sep 2026 07:36:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 16 Sep 2026 07:36:43 -0700
Received: from localhost.localdomain (unknown [10.28.36.142])
 by maili.marvell.com (Postfix) with ESMTP id 5771F5B6937;
 Wed, 16 Sep 2026 07:36:41 -0700 (PDT)
From: Ashwin Sekhar T K <asekhar@marvell.com>
To: <amiyaranjan.mohakud@gmail.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>,
 <stable@dpdk.org>, Ashwin Sekhar T K <asekhar@marvell.com>
Subject: [PATCH] common/cnxk: add NDC sync after NPA aura pool init
Date: Wed, 16 Sep 2026 14:35:55 +0000
Message-ID: <20260916143555.2971656-1-asekhar@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909192323.26886-1-amiyaranjan.mohakud@gmail.com>
References: <20260909192323.26886-1-amiyaranjan.mohakud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE5NyBTYWx0ZWRfXxv6nxEVYraN/
 gVMfBq2UHK60EHSyFJGjdkO7ZUKjLQEbErZs2X9G0Etm/bZAwWR3B6oSNSPDXh4L8x90LNkfD6Q
 MgF+oJgzqo4Cyn4WAVSitOUiKuMAb94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE5NyBTYWx0ZWRfXwTmHSBMCHtHG
 JH+Qa5jfBOc1sMSIFUNrPn44HBCIz40dE+tqcfsnklqy7CPL4h4hxxb1emGxLv84uj+5eUjkJyZ
 /PlloSrA1YysQ3nZ2TWR2HZsrX8GAB21a875KE9gGvT0Ukid5PU6QN8XFFJSLgFcH5anhvu+5Th
 FVvsyR6o09rpE4fiQAGtq9mH4mCtaxt8935uYyclwZkRLMfon4mK9camNaBuaL1WlfKiOzYX6r8
 Ysc7JvigAIMd6GaD/3ekLU+ribMgw39I81R4MtX0m1n2CieCRW6INM7W2k7GWYRho/03vguVxGX
 Tl3WiAx+aAS4LDS8wO9KSvsLt76cAeNvpUN4+y2EZEWSSzWMMDiao+pl//KHtGhf8CBZomHL+a1
 YnvgtW4L8136976cYTlQLffXKt9i73OJqUb9MZD1GTdSrlX3VCCZxyD/jA/lDHHVetcBwN9RHE4
 kU20gCgZ5vh2nwVSryA==
X-Proofpoint-ORIG-GUID: Dh_b8Tk7ixPdtweXncWjIUGaxHWTozIP
X-Proofpoint-GUID: Dh_b8Tk7ixPdtweXncWjIUGaxHWTozIP
X-Authority-Analysis: v=2.4 cv=GuTXaU1C c=1 sm=1 tr=0 ts=6aaaa97c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=DZJTHQoGRCpus15w9t0A:9
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
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

This patch is not required as the issues seen were a side effect
of using IOVA as PA mode which is not supported in CNXK platforms.

Refer ticket: https://bugs.dpdk.org/show_bug.cgi?id=2031

Thanks
Ashwin
