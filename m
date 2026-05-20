Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05861CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 587C0402E4;
	Wed, 20 May 2026 04:20:35 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id C342B4065B
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:33 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JLKEHS160544 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=5
 jv4gqCGaVtX0wVtY5Ya4xJi+c3W1SZhVEIx3UwR/ZA=; b=pfEFRGiklFLMiYWiN
 NUA5a2u0mlJMWi233duIR4tb3qHjKvnzQxdJJOhBRHQQ37samoowQKYb1fu7z1qY
 4J8iA6zfwAF1WgbWM96PJGBHLTf+pG5QHAyypxtKHfUrTuoORZ+dAPSwPyPJCPyb
 aTD5pn6Scmt5FrW8Xtl2D9klknCWIfGN2yqCnK6jUTdPAtRwjnVkcXeVu7jK2kub
 cR1tFUlQNK6g1IuFTHb52yC6ZzZXx6LmrwQyICQdY+T1R0pvEcdUvWS21JNawBxl
 /luXpPJv3oGHBnSyhB5LvsYBoKNqWUtMREnpufZa7dDeRi0W64SIN3zRMMnNPcD0
 mkfkQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e6kr6ef7t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:32 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JNbbG52927618 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:31 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8x4dvbh9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243632; x=1810779632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5jv4gqCGaVtX0wVtY5Ya4xJi+c3W1SZhVEIx3UwR/ZA=;
 b=dDQesKYKOaLqA3P3OpZWhH2nW7r4M05w36byCycKPYghlDXpfL8u28Fs
 z2yyrqc63KSKZd34zq8MSI9misBfBMulo8FGhjhSo7XVRZeuZaDamsRX6
 onth47ScPijkSMzMiT3LqwMBk0TduX4IHM0pDMeaxBhxDCd6WJJs1lflq
 +vpt1ls+28rpjJIJgmKadii6PJGZrEbfiLpIqIjPkBUgvSjKKeHlyTr0S
 QQm9nDJin0no9SWeXmMgXYwILZYLgKiRbv96bccP/zhcE4NFl4AuzOCke
 OsL2PhOEW7dyqPKwQgoWG4ViWS/PItT7UDboPqFYKGy9t4UOp/7qkD1bc w==;
X-CSE-ConnectionGUID: htcPz+zFT52Ens3g8chMMQ==
X-CSE-MsgGUID: XKqfhHD6TPCv6eh0Ho4LTA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:31 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:21 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:29 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:29 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v14 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Wed, 20 May 2026 02:20:08 +0000
Message-ID: <20260520022012.243619-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520022012.243619-1-pravin.bathija@dell.com>
References: <20260520022012.243619-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Proofpoint-ORIG-GUID: PwDEPXeqnZDdMg6cLEQjwgDKmpnGGNoJ
X-Proofpoint-GUID: PwDEPXeqnZDdMg6cLEQjwgDKmpnGGNoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOSBTYWx0ZWRfX+EFXj1wO3sbF
 eKll6wglJ5PqTAe8wp0DZgHdGUn9Jzxdvs7IKIkkKx1fXMZQg1mOqaeCHhvdJg//YgEgXakpu9n
 FIysmpd+IaMLonaHLY4S8FpYkwJWZ0NMwnMsSnOyPcrq+K+yWgW38gXZk9QGTsTtR1Q8j/6vDQ+
 oOVDkqwFdRnzy/JPszhXfWcrsIr7kINH3brqUyl0+4laHbBavLtrNN25gK9jIh9Zh8GIoVC0Hao
 C4JUidURVI+n8tkBZqci8W+mOq6bfGXeMnfPZz6/9WSTGzTSPZygYej9SkogxiGzngnCBma7LmM
 WOqsS5nm+Bd3gmHjvbQAldCLOZ9AfNmNGh2TpaA6Bnziq/qnQC+Zk6CMTk1ZXX7/ApY2Xaya4Le
 oaJPwHcYjayCdgZZ+iqTU/g3zbvdj7k0lALKdZg4z1Jm88rBmTJr9u2Z+xGZl5IdVhEf4EL2tqk
 8BrRMMvo+wO3xOC+PnA==
X-Authority-Analysis: v=2.4 cv=f6N4wuyM c=1 sm=1 tr=0 ts=6a0d1a70 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
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

From: Pravin M Bathija <pravin.bathija@dell.com>

- add user to mailmap file.
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  that depicts if the feature/capability to add/remove memory regions
  is supported. This is a part of the overall support for add/remove
  memory region feature in this patchset.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 .mailmap              | 1 +
 lib/vhost/rte_vhost.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..cc44e27036 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1295,6 +1295,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 2f7c4c0080..a7f9700538 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -109,6 +109,10 @@ extern "C" {
 #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 #endif
 
+#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
+#endif
+
 #ifndef VHOST_USER_PROTOCOL_F_STATUS
 #define VHOST_USER_PROTOCOL_F_STATUS 16
 #endif
-- 
2.43.0

