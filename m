Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6376C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 00:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95CCE40262;
	Thu, 24 Jul 2025 02:06:08 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id D9BF440151
 for <dev@dpdk.org>; Thu, 24 Jul 2025 02:06:06 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NG7WEO016152;
 Thu, 24 Jul 2025 00:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=rPvY8WV8qGveF6oGHwvz1DIzJUAqsjANZCNlCruSR
 zE=; b=PRG6JRatog3OCyPTcT23YU3f2tm90gc/xKbfAiFa7PeHhah7uzZAYaBib
 SHVKO143vUXFFn3HAWrCKmCGXCdV0L7AqN74sA/HD+bCN8l0xrANH7YvwqaO9nK3
 JOfU3y/Lb5qSjAGIUgDqabTdfXnbAdPEqYNbjn5RBf+rZpbIqpvdGGLYyLEGocJE
 tpd9vlI4bQKUpS3Uyza3E737/FmzuHF45RJ8tGCR/xEfdsB5lu7JZ0DzVqFRTTXz
 MSzTGWzTiit811fLD8TZZYNpJIurGaFswWt9Few/uNx8Jdn4drc/q69iY5YqaiDE
 kZxmVJk5WyuJjzBBz3sn/SZFVPWSA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff67m1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 00:06:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NLwtOH014296;
 Thu, 24 Jul 2025 00:06:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480pppa25x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 00:06:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O064Ae28377774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 00:06:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C22C58059;
 Thu, 24 Jul 2025 00:06:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E39DE58043;
 Thu, 24 Jul 2025 00:06:03 +0000 (GMT)
Received: from ltcwspoon18.bm.com (unknown [9.40.194.38])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 00:06:03 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: dev@dpdk.org
Cc: David Christensen <drc@linux.ibm.com>, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] trace: force 8 byte alignment when --no-huge is used
Date: Wed, 23 Jul 2025 20:05:53 -0400
Message-ID: <20250724000554.114087-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDIwMyBTYWx0ZWRfX9uynzgpJhfDO
 L1ECIzFFi2/ZqPRhrybAy3So3jOoJDLR/RlJ1mSJVTgNlQTISsicaq2MxkCVauNd5LJElH5A/dj
 afon8QD1ChAW0N2nh/MuQwzLLrRSwCfFViHAqRlFaOtQk1rEVdpNzF3Xs2ef9Jh7q/RQ1JfS1q5
 +OKloXLHnMiyJHAP2o8kJ6aaYQ8pI3cm46YYdkgnPrEkRVgT6SNV7a0mlDtUqdgl/datGhjMbc8
 jwGvkFV0dnWudtKHJG6QL3HT0G5wtUnCJdDAz+UpiHvWXQ0gja7YH0KNCeJH7KDUUdK/eGyjoFy
 OBcGozdDMySaPtPzAWX5MR/Qs5qoPZNfVNPw8LpakQbbu0LQgVuAx8ZMMNwHn7eUXaN9WNH4Oka
 +ETQUZF8DZ4CNZJb56DTAH3mmU4v0C2OzuPI/CAbXP06ilNOoQq1OIx5xm2o88XMuP4Jz5QX
X-Proofpoint-ORIG-GUID: 00T_qbJdvrZtbujz7XwH_GRrSYB9DTSR
X-Proofpoint-GUID: 00T_qbJdvrZtbujz7XwH_GRrSYB9DTSR
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=688178ee cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=69GrNgvgEYDbMSjgdHYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=732 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230203
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

Current code in eal_trace_init() specifies 8 byte alignment for CTF
generation, but fallback code in __rte_trace_mem_per_thread() does
not enforce similar requirements when calling malloc(). Modify fallback
heap requests to use posix_memalign() with proper alignment.

Signed-off-by: David Christensen <drc@linux.ibm.com>
Bugzilla-ID: 1715
---
 lib/eal/common/eal_common_trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be1f78a68d..3dadd58e3e 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -363,8 +363,11 @@ __rte_trace_mem_per_thread_alloc(void)
 		goto found;
 	}

-	/* Second attempt from heap */
-	header = malloc(trace_mem_sz(trace->buff_len));
+	/* Second attempt from heap with proper alignment*/
+        size_t mem_size = trace_mem_sz(trace->buff_len);
+        void *aligned_ptr = NULL;
+        int ret = posix_memalign(&aligned_ptr, 8, mem_size);
+        header = (ret == 0) ? aligned_ptr : NULL;
 	if (header == NULL) {
 		trace_crit("trace mem malloc attempt failed");
 		header = NULL;
--
2.43.5

