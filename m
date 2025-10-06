Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF05CCA472
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 20:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FFE040673;
	Mon,  6 Oct 2025 22:09:15 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 3C349402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 22:09:11 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FmYYl016586
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z1cTxO5F9nr
 CuBqI8aM37GRNMnIcqNsZy0jZeoh7ssQ=; b=VjJSJSeAqMkwuGlozRfRrHz+ey5
 /gLD05KOysrpBFz8J9y/oq3Pb7m4Jc2zt4FI7YKzUeoHdMPvlQo+iQciyPGTUR9h
 7ETgX4V4f9RZjCBKJaeZQaUWGATo7PMcXVAwvIShAM3B/n8uygOOOPGLxRWgFT8b
 m1bQUvN9jvfVGsde+mbC0tv+URy0sr9BnKNmODV+lxyEowcsFThMTNI0lHygA4Oj
 gazGrdWDzVQwhffqHuAsrkCR6WPIAkbvNx/bKIVT/6yYhkjz2oWpga8LoEUIUy0u
 ZUmww2G9tInkuEkv7GpIt6tC0jZqJIvSh6GuBqt+0XnyPhpEeJADINAUFcg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpw5j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 20:09:10 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 596K99kY028228
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 49kdetytx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 20:09:09 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 596K6tRa024999
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:09 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 596K98n4028203
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:09 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id CA2E9400E0; Mon,  6 Oct 2025 14:09:08 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v4 4/4] doc: add doc for dictionary option
Date: Mon,  6 Oct 2025 14:09:04 -0600
Message-Id: <20251006200904.2467957-4-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251006200904.2467957-1-svaze@qti.qualcomm.com>
References: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
 <20251006200904.2467957-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: jVxBAzYDohUzVeBZOTyuL-COGY6EncMC
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e421e6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=4rgIWCAkCNO9Gw_SPxYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfXwSRzN2uTPJqJ
 QMSBGrAMVCIqsUVYyK6JxskVdmIjZUn3blFY2BC1Kmjen0OaLVDSux/rDRmB3DlMB0K9Vhqj4as
 ofhQiyMCK8iDBs7A/H3mn5dzcBUqtoZhWJrKRufu8x4iZff0sJO5VwETZbRuLYEfz4Pv+6wiMGW
 17GeNlaDDn0GNsP61QjMpvarHIdS0YKR2GHewUZhiLoRbB43PpfAbDGtjSYFBdDg10zGHm4Jfmj
 TP/actu0o2GErJcQER/3vvmCEzpXKNlgV2gYC8GRZP7Cj5C+jVTmbYlE79iAX/nSR1SX0xBDJ6E
 9NVTHUrhSvQXWBWEtt9RxRcFpErvQ3DbKIClZ9bRKJF1SpBZZBIbW2+721teGVoblM+yT9U2AG9
 SzX7XqE24Z5CmkildWiCPNQRKxQ6RA==
X-Proofpoint-ORIG-GUID: jVxBAzYDohUzVeBZOTyuL-COGY6EncMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016
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

Adds docs for comp perf dictionary option

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 doc/guides/tools/comp_perf.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/tools/comp_perf.rst b/doc/guides/tools/comp_perf.rst
index 4299ef0b3f..f0c6993a2d 100644
--- a/doc/guides/tools/comp_perf.rst
+++ b/doc/guides/tools/comp_perf.rst
@@ -98,6 +98,8 @@ Application Options
 
  ``--cc-delay-us N``: delay between enqueue and dequeue operations in microseconds, valid only for the cyclecount test (default: 500 us)
 
+ ``--dictionary NAME``: file containing pre-defined dictionary
+
  ``-h``: prints this help
 
 
-- 
2.31.1

