Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEFCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B220B402E8;
	Fri, 24 Oct 2025 20:38:26 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 6D287402D2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:38:23 +0200 (CEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9Ije028820
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=oA/JKB6dXyrh8oikT23bDAJSHGFV2FLeW19
 QGCPwzm0=; b=CqfDlrWmkbyDU7oVDf5uvGRwpT/kqyzm2qQnV4Rkqaxh2cSt3PP
 hLWpBZpbEemm0bq4WDohAEgRx2bPN7O22iIK3Mmhir+KqT4STScNkI8ZvRRU6Oxr
 BjBR5k5kJoO+b98FnN2M+1UF+uw7fyVl8aAcp4zmFVGlSQxDS4xOovBOwI/orjkn
 gmP28dJCzE6xIowvCcYKw33CZFlb0U/oyDhuJn92ILMOAp52t5xW11ob/7rxv34C
 T0T2Eo//AV0Hrf0SJQlRJONAryZARGbyRRu0u4jvoTLQktK1ncDoG5X53Ln7vSVs
 skXi9YgUAaRN2zWGRCWzBA1dpQaR7qBM/7Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8cwqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:38:22 +0000 (GMT)
Received: from pps.filterd (nasanppmta01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OIcLjI004450
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:38:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0adxcccs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:38:21 +0000
Received: from nasanppmta01.qualcomm.com (nasanppmta01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OIbaNv003725
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:38:21 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 59OIcLdJ004433
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:38:21 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id E70AF4006F; Fri, 24 Oct 2025 12:38:20 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH 2/2] app/compress-perf: fix coverity issue
Date: Fri, 24 Oct 2025 12:38:19 -0600
Message-Id: <20251024183819.1686996-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX6YrDRluumkIL
 kWB9aA8Op/PqPHi0VKmHTiwJmK5pEPDynw1PgEr10cbjl7dEJiRgn3PAuqnyQWWORgi+rgjglwc
 hR5jASxLI4LJQNOPMhkfHM22Ob73iVrVsIpXGrUOk7MsLwNoND1UNflsTHuDUDawbTLGb8AdPR9
 WXZ2H9tGQu3UJrImFKSj+StRGduqqUFGBx+lh9lRd5qEp6MpQZhqITVjdsuGAFfrlTgZW501lG8
 XmSrnOnwjIeWdr4LemNGmlvopf1yfe74KcYPl4eqyvyXs4jk0cES20IGrGFF4Z1Hh9UYDOI1FTH
 GFkrnFiFD1RkkDY/Nxw/XPCH7XvQE77kGcSETilIg9KCa63/H5Wz4RNDXBpUBkqveGo/gvc92GC
 m3bCQ2SP1gYvKeNjBa6OltiH7F4evw==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fbc79e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gff3aSZNGPX9DwQQ_QIA:9
X-Proofpoint-GUID: qS7aLO1vw9l6zEe_Q5521AOsShuWpZ_L
X-Proofpoint-ORIG-GUID: qS7aLO1vw9l6zEe_Q5521AOsShuWpZ_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015
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

Removes possible assignment of a signed value
to an unsigned paramter. Also makes dictionary
an optional argument

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 .../comp_perf_options_parse.c                 |  2 +-
 app/test-compress-perf/main.c                 | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-compress-perf/comp_perf_options_parse.c
index 49197dc290..16d31c7e90 100644
--- a/app/test-compress-perf/comp_perf_options_parse.c
+++ b/app/test-compress-perf/comp_perf_options_parse.c
@@ -660,7 +660,7 @@ static struct option lgopts[] = {
 	{ CPERF_LEVEL, required_argument, 0, 0 },
 	{ CPERF_WINDOW_SIZE, required_argument, 0, 0 },
 	{ CPERF_EXTERNAL_MBUFS, 0, 0, 0 },
-	{ CPERF_DICTIONARY, required_argument, 0, 0 },
+	{ CPERF_DICTIONARY, optional_argument, 0, 0 },
 	{ CPERF_CYCLECOUNT_DELAY_US, required_argument, 0, 0 },
 	{ NULL, 0, 0, 0 }
 };
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 11b016069c..8c98131e46 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -355,16 +355,22 @@ comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
 		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
 		goto end;
 	}
-	size_t actual_file_sz = ftell(f);
+	long file_sz = ftell(f);
 	/* If extended input data size has not been set,
 	 * input data size = file size
 	 */
 
+	if (file_sz < 0) {
+		RTE_LOG(ERR, USER1, "Actual file size could not be determined\n");
+		goto end;
+	}
+
+	size_t actual_file_sz = (size_t)file_sz;
+
 	if (test_data->dictionary_data_sz == 0)
 		test_data->dictionary_data_sz = actual_file_sz;
 
-	if (test_data->dictionary_data_sz <= 0 || actual_file_sz <= 0 ||
-			fseek(f, 0, SEEK_SET) != 0) {
+	if (fseek(f, 0, SEEK_SET) != 0) {
 		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
 		goto end;
 	}
@@ -386,11 +392,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
 
 		if (fread(data, data_to_read, 1, f) != 1) {
 			RTE_LOG(ERR, USER1, "Input file could not be read\n");
+			if (test_data->dictionary_data)
+				rte_free(test_data->dictionary_data);
 			goto end;
 		}
 		if (fseek(f, 0, SEEK_SET) != 0) {
 			RTE_LOG(ERR, USER1,
 				"Size of input could not be calculated\n");
+			if (test_data->dictionary_data)
+				rte_free(test_data->dictionary_data);
 			goto end;
 		}
 		remaining_data -= data_to_read;
@@ -414,9 +424,6 @@ comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
 	if (f)
 		fclose(f);
 
-	if (test_data->dictionary_data)
-		rte_free(test_data->dictionary_data);
-
 	return ret;
 }
 
-- 
2.31.1

