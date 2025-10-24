Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36ECCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 19:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62AAD402E4;
	Fri, 24 Oct 2025 21:11:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id AAD6A40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 21:11:29 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9ej9010767
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YM+xBcVUdvvWbJURoBjWlA9YVOF6UICGJ5Q
 NLfz9HQ4=; b=JDgG3tsvj8FaoudTAjEFb/unfsfAANJxueoKZv6Mhtr58yv4J0Z
 uf7BRv1UEmPBtZD4FlAxtz+n3cBHs4EbIjLNJAfKXyjDlAcQPQle1crBy5yWPQvV
 jHmcflPE5LN4l12DhpyqMtj+YalASz26eGg+dWTzB/5oZk1HOFtWGIepTPN0oP+c
 FeOnnrjBCq7YTpl29bctTCpTTW5XKfeUhHFbGwzc2XG622kXKwkKtX/8LseemXKa
 J96fy7bdGmbCd+ulJ8o5NkdcFB80e8oR2XvlYc+YeDVizQbb0F5T6PlLBA6p1Jps
 GRQ1InNYfrwnqF9bLEtm5hDnKfy1gOCRVKA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jcxec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:28 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OJ71jL014914
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 49ym93yxd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:27 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OJBRwx021573
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:27 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 59OJBRBI021570
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 19:11:27 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id E9EFB4006F; Fri, 24 Oct 2025 13:11:26 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: fix coverity issue
Date: Fri, 24 Oct 2025 13:11:25 -0600
Message-Id: <20251024191125.1728953-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXxMY6GpiHQ4P6
 U8HMSieS7o2R+nlx6+xXwtyBM67RpgTPBRS4AmlZ5seHMDuWk21OSUV/FgSI5cn4rxWfmljPo9B
 Nn2kDjewetIqWxv27dbvGyXMeg1CWDiKbQhwmsA5W31dJKXVsfMo89EEsxsRiqTglRcQ6lMd1po
 qtaHUWAdUG9RYe+apB8TSfbWBVf3u922ePXJ5Oz/v3Sbl+ICKGoPQmQ1WtXS+RZtPvtg/byEKMr
 VV7GYrWJDUg0dPru0c36eNLNHSJdSQ6KBi+XKlZ1JoSPAGVGHkGLTLh0be7PdsUW8Eg3yMA1ngo
 Qlhsnny2NAnQE1u0sXJ7pfLIXCto0dOkkCu4VXG0qr05kJ3NvdvSm/IynS4fRn+mcmORcYJAtMh
 zbfQ6C80rJQvz7UnEx6C6FqqdMbfPg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fbcf60 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gff3aSZNGPX9DwQQ_QIA:9
X-Proofpoint-GUID: MFDOhcLhRRMmeheIaVWvrom_3KP0ZArR
X-Proofpoint-ORIG-GUID: MFDOhcLhRRMmeheIaVWvrom_3KP0ZArR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018
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

Coverity issue: 490944
Fixes 568815516e88 (app/compress-perf: support dictionaries and PDCP
checksum)

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

