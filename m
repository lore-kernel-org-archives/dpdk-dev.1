Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A9C840E01;
	Wed, 28 May 2025 13:52:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0291C40E22
 for <dev@dpdk.org>; Wed, 28 May 2025 13:52:09 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qita021221
 for <dev@dpdk.org>; Wed, 28 May 2025 04:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 5OtiRhJrgJnddWgCjGFnKGr1sSapTigtI1Z366DBdw=; b=SGlRhZrJgk5ECzIdq
 huB8ZsvRM9kig7JbD6coVVnfsbst/4oywGufZMZ5nokJwS4BxC/JvWwCCzGTtF26
 nuCVch27EhCCoumCE9Z/w8DP/bBUuKu+NppAhgTEZJ3kc7nZtj+m4T/sVBZZuODw
 m8FVfwU17cCmmP8aCwiGgisYITztFIUKVLZuAlDh5hK9MFeR5OrmQuu1JlbaWxCZ
 3/E8VRSEfzD9sj+mxJa3ztXMGkA9qVQV8skpiJh6EPS/FtwzJeklnYjlcJNr20wq
 S/WX69qN6HRO3WLMnZODM60/FUH6hpHiNshkJptXZ9lD6syi+toXEo/Ig9/mVzFD
 VV7HQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq8217f9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:52:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:52:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:52:07 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id F263E3F7061;
 Wed, 28 May 2025 04:52:04 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 7/7] doc: updates cnxk doc for new devargs
Date: Wed, 28 May 2025 17:21:22 +0530
Message-ID: <20250528115122.24052-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XWszRreZqs28AGzb8MrcANZCYK8LLh-6
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6836f8e9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=KjSWCPD8ZH7PWySdsy8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX+YLwis1haNK6
 r/tptqRvYezxN/HXCtci+ufmQJsNtb/nTVsbNUyEYu9qGIGjoxkn75jJuUKOLtSNKDqcZ2eceMF
 LSc+2MlynIRSaBp5XfrK8FfTefipeYE487v4TTY1N2DS5YznV+mFMPNdeKEc3wxh63bE2ItVcvj
 hgl80b9fvKZHInvFOcbcrZfgrNTMBlQ4uppZlpA0nqZqn1YSIYXS/TBb36EaA6aZZVCEtIgh4Dz
 vLuTiTClbMSSIcPWhdOTv8hQ5a7VxN0aMc/RJVX9vzTVsizuDkbkxNFt+XyAKP3+4EVHqux9602
 gY1h7APZnLaQQO7zWv5c4b5RUu/oVblpt/hqZ9aZ53RqfvTPbcvF12wbZpNXzv0l6o1DYq0K45f
 jS7Gysll1kZ/ZPNXJ4j/m4twqqF9BJEQmcFBbnw6shmVRBKf2dtoQytSSz3rkfMhcT0j8QO5
X-Proofpoint-GUID: XWszRreZqs28AGzb8MrcANZCYK8LLh-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

Adds details of below nix devargs
- force_tail_drop
- disable_xqe_drop

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 doc/guides/nics/cnxk.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 35f95dcc0a..7f4ff7b4fb 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -470,6 +470,29 @@ Runtime Config Options
    With the above configuration, inline inbound IPsec post-processing
    should be done by the application.
 
+- ``Enable force tail drop feature`` (default ``0``)
+
+   Force tail drop can be enabled by specifying ``force_tail_drop`` ``devargs``
+   parameter.
+   This option is for OCTEON CN10K SoC family.
+
+   For example::
+
+      -a 0002:02:00.0,force_tail_drop=1
+
+   With the above configuration, descriptors are internally increased and back
+   pressures are optimized to avoid CQ full situation due to inflight packets.
+
+- ``Disable RQ XQE drop`` (default ``0``)
+
+   Rx XQE drop can be disabled by specifying ``disable_xqe_drop`` ``devargs``
+   parameter.
+   This option is for OCTEON CN10K SoC family.
+
+   For example::
+
+      -a 0002:02:00.0,disable_xqe_drop=1
+
 .. note::
 
    Above devarg parameters are configurable per device, user needs to pass the
-- 
2.25.1

