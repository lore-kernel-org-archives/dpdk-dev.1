Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA35CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 19:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D584067C;
	Fri,  3 Oct 2025 21:49:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id A8BEE402EF
 for <dev@dpdk.org>; Fri,  3 Oct 2025 21:49:05 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593BdQXh010749
 for <dev@dpdk.org>; Fri, 3 Oct 2025 19:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z1cTxO5F9nr
 CuBqI8aM37GRNMnIcqNsZy0jZeoh7ssQ=; b=RVQBzD1DaTlXAIPZAbCAcMbWY1j
 /yfWI7Y9KN507otuTalY09wosruhA+AK6i8e9IayEJ2pCxZLQxIJejXAbwKpPzn/
 k8l/JxxlgXXUnxsmJyk4+IFAe8f94glcHTPSM6whjrJGqfEsc2fnU8WtZmyjM4hS
 0MNKSnR8Ga4FfIr4WMKIMFiJeRd/sDe3C2l9mjxkqUPQ4guZVNwG1hG/f3Z3b4jW
 6zqkmL/ENekPXd5Q6GSKMe1kivBUXvYpOr26qFQDnbmZD2+wGRwpXjhf2Z+MKcsE
 ibBSuyOKHrnecU9rqH/c00bMiatWy++CT84m2uIEH5dZ/8lkaAxyb70XY9g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hufp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 03 Oct 2025 19:49:04 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 593Jn4cR008211
 for <dev@dpdk.org>; Fri, 3 Oct 2025 19:49:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 49g4rkjhq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 03 Oct 2025 19:49:04 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 593JgUc8031009
 for <dev@dpdk.org>; Fri, 3 Oct 2025 19:49:03 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 593Jn39A008180
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 19:49:03 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 3C209400E5; Fri,  3 Oct 2025 13:49:03 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v3 4/4] doc: add doc for dictionary option
Date: Fri,  3 Oct 2025 13:49:01 -0600
Message-Id: <20251003194901.3375364-4-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
References: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
 <20251003194901.3375364-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX5lDInuwcakEf
 IAAl5JVtbQFybqmUtCHHKa7ZecHIgBIWfLFuIwHDcoKS4FPCOtQB4DOy2xX/7mvXv5cFGhenpis
 ws/ugqMKbFU3IqZlBLpKm38tbEKf0ych5xGr0h1xCYBHAP6JnFx2KNLiYi6Podrav7Lu0vdOklR
 05byo/fRh+iErHiyyI6PXFjj4uqP2285AbgdMpyyvqnJUJNFFY7GnIj/dF2Pe/pUmlh3Rhh1tBL
 0jIapRbvQ4UX7o+MPiM8VXP2N73iGKzX+3UAiVrIR4pZYja6ndwJiV6IsHY7g1gb0/FEenDlBhu
 AjEb5ffS/0S6Z1ItQWMGUaCGQqmW8d494JX4+jpD6klu8T4JI3FZDECCt1zk76Pq5aDgEBZS7Ad
 x2PWxghTJA1bBIHyaK46Z0XuNwbzMw==
X-Proofpoint-GUID: tIybfm9Yr0VlqAqA6LtD20twiT1w2yrs
X-Proofpoint-ORIG-GUID: tIybfm9Yr0VlqAqA6LtD20twiT1w2yrs
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68e028b0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=4rgIWCAkCNO9Gw_SPxYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041
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

