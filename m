Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA340C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C7F7402DE;
	Wed,  2 Sep 2026 17:33:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2618340262;
 Wed,  2 Sep 2026 17:33:41 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CTPxC2477493; Wed, 2 Sep 2026 08:33:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 NRAx6B7eGYhAOZuil9fUx9JAcsLuHZi8PV/K6c2Eak=; b=EZcAl5M/SW4wXkWU3
 HGZctyoSHTIxsgrlQenHDH3/2jGkSwveNUxEmwpR5C2dbnbAG3F02IYaEViffY4P
 wX48pGbYNIYdtrnJrjBlro/Mty9hCB3Q7lSv0WIEDQcQcfs0pcwuef9pvMp9BmlI
 9q+OStml/uCQADu4sk5drRyhYvJFmIpH1c2JBlYPWdS2Yw+CBHYCSIlbED5lgxHQ
 9EUMFXKDvwAemYvn1ZQSlbRJpsk11IyE5LEFVIdLIYeqvSE9IZBvhnqQbYdtHw0G
 hrxdC3FDfeIEB7IjuofNt7HbyOmhY/x4S3Hp+q7S7Z5FVyI5L4D8lMVBXU1KDFKl
 NZHMA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ge8mja8hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 08:33:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 08:33:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 08:33:39 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id A868C5B6942;
 Wed,  2 Sep 2026 08:33:37 -0700 (PDT)
From: <jerinj@marvell.com>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, Jerin Jacob <jerinj@marvell.com>,
 <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH v2] examples/ptp_tap_relay_sw: fix build inclusion
Date: Wed, 2 Sep 2026 21:03:30 +0530
Message-ID: <20260902153331.691687-1-jerinj@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902082523.206083-1-jerinj@marvell.com>
References: <20260902082523.206083-1-jerinj@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2Q3SvVBwsVb1Nj6xwmPfGJmaIc2cEkyM
X-Proofpoint-ORIG-GUID: 2Q3SvVBwsVb1Nj6xwmPfGJmaIc2cEkyM
X-Authority-Analysis: v=2.4 cv=FKorAeos c=1 sm=1 tr=0 ts=6a9841d4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=7aLAe6btT5AUPeCllDgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNyBTYWx0ZWRfX2dkwsF1ORm4X
 vw8cNpAmJoYi6OEGspgGzWpIoNHnpXvm306QgwQGiOslBQahV6dVOlpLjmwizjwxZdmEAvdEr6s
 B+N2sxfh2oKfjOJzn2JpErVIZeSXniY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNyBTYWx0ZWRfX6omPHf4qEuKV
 EOhu1QC2ocYHJ2ioQ4kQ22Hx1Vp6lobYCh5Il1H9ouOjdAxpedJ8SjluORRxFl6zBi+Z5TBMRBI
 UxzJ94mD4TWf0jSegQaUm98cO+UbWMgTcASMIqPFBbIY2sKEmJIrFTVJaopgIiNqF7gS0NVIH9m
 mGwShT+i4mRzmOH1wbvRtb40lp7s3y0uxScVb3m24qZ1hwsxHjwDlffPmUcW9xyDR53uQi7L1xc
 +l9bwBYHAtzJ19KCO4yW4fjbol7jdYqUZmpvTYranB4a08Rrv7B8/pcgSA9CPqhdUvC7cSyZjx+
 +1cEEz2LBMCMZ8kiOMSweR78nKr8L1KPWVEucsX2fiB3fz6Pw15XJ/xYmR6On5Z9Igb0Gt1gvAC
 Bmfq909c8epw6Qp32QAjKJu39cxA5PitOcui2GGbXsT4y/6M/TuYB5RfXZDH2tJ5TIdzFhH11Uw
 3vJIzr7WD43VgkqzFeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
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

From: Jerin Jacob <jerinj@marvell.com>

The ptp_tap_relay_sw example was not building because
examples/meson.build was not updated to wire up this directory.

Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
- fix the order in meson file(Bruce)

 examples/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..7d2b7716c1 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -42,6 +42,7 @@ all_examples = [
         'ntb',
         'packet_ordering',
         'pipeline',
+        'ptp_tap_relay_sw',
         'ptpclient',
         'qos_meter',
         'qos_sched',
-- 
2.54.0

