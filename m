Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9EECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:47:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A7B2402D6;
	Fri, 24 Oct 2025 20:47:50 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 66794402D6
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:47:49 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9UoI009796
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iQt0v1gZVRHcIUpSRR99Bu8GvsjOjAx0E+6
 cpJLc5Bs=; b=ENz5mZzrat8aAd44UY9Co0T+zEXNxVQvrxiot+Nw3zy1hXSh/ok
 lK0rvVgbsAOrdj+XxEG4+oLHBGiRfH7inT/ysjk/vRbW7wIP02pA26NxtPLBSetJ
 RKA7A+4LEd3Qq0PpfiN8vZwdK5a2tdmxgt6dkkd3sy+o6JXBXG21K64PTtTH+tRE
 VzOwCo2yn6Q5CwoTxuS6eYNN02OZP7hj3xC5PPJI+DFUAveu3QWYCIQZKSgq4tx6
 D3sRNlBksdQdt5nwQGH5xGrOjxw/R14BG3CbZpPlXvg7T/osccmMB77+G1D/vpFO
 a9HLsN3rtogiADFLerLqcJ7JIdkQBH/OD0g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j4knb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:47:48 +0000 (GMT)
Received: from pps.filterd (nasanppmta01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OIllJA019941
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:47:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0adxcfv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:47:47 +0000
Received: from nasanppmta01.qualcomm.com (nasanppmta01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OIllwI019936
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:47:47 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 59OIllQe019925
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:47:47 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 11A164006F; Fri, 24 Oct 2025 12:47:47 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: fix coverity issue
Date: Fri, 24 Oct 2025 12:47:45 -0600
Message-Id: <20251024184745.1698409-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fbc9d4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gff3aSZNGPX9DwQQ_QIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfXwohYFgtR0OUj
 ++PcN2mFD2OBqLVDPds8bYD6VOTyvvpa1b13VIYia3NbfQV3KpkUqxeP6tchAPzwzyAipVWmHhM
 Z9rrtmMgFnhAWA5syM0kr+D/gikmE/HKpeEDzKkK2sxuz/EDVpLpCvN81+7A0j/lXwkYS6zeThT
 MP98uxQd3LgEZNd6opNKg4iIo/hoKK/KV5InFSJD74AAauEv5DR3ZOnffFs6ecdzW1OIxoOLwN0
 6vRdPD6vQCVtzygpr7Rl8CTEKTdEXIIWleJmY0Ep5QSX3LEGJ5yct+bvEDfwc/PgO7bF4fyEDTP
 iIc+qJjt6bOMUdwxCn+WYSVq1kCDDuHFDcfkfUx7/hDGAAYjLIC2eVK5pKC5zKc5HxzAJRX5uHZ
 IVXXa3JWqZbj8nCd/bd4pkNaVuZwvA==
X-Proofpoint-GUID: wez5vEjFeqrqrweovdWthWaroEyeBbFl
X-Proofpoint-ORIG-GUID: wez5vEjFeqrqrweovdWthWaroEyeBbFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112
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
to an unsigned parameter. Also makes dictionary
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
index 11b016069c..59af073f12 100644
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

