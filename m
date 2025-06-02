Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18098C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51665402AB;
	Mon,  2 Jun 2025 08:37:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 15A624026B
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:36:59 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jDh0013863;
 Sun, 1 Jun 2025 23:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 6BiDaaZgXoKkCnx1j8rFE+k5TarM/avmNwAL/f65EE=; b=OO+iBc9sON4REpFFg
 x2ydSDGALduIivyhMSucz9CV4+mblI679b6PVqLttnP0fVsANWB0wd7eYjojhnJN
 WynFWErgC70UM58d2+1rLUqZOClA+zILbNPyGjSmr0dFiWGan8/LxAHTnLGf1I5j
 6Tcl7EstZkse9bTdlI6/djcyzUz0GGb0rSgXVXEIjcbMKi7MuxpRvd8LRkrgJDKu
 Pc6gVG8Jzu3zAu8ZR6encSbl/fC6n+uuZ5u8xBr9pvQmnWHnOLcDU7pPu8OwCHq4
 axX8jmBkfDRSU0lZReSZmC5AhkisthwJIaj6hpUgzXG5qVgPy2+M/1aUCAtClx10
 LFdGQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa1t5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:36:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:36:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:36:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id C3FD13F704B;
 Sun,  1 Jun 2025 23:36:54 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 01/14] fib: move macro to header file
Date: Mon, 2 Jun 2025 12:06:26 +0530
Message-ID: <20250602063639.198550-2-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d468b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=vxp6wFEekYbuhhetsVcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jNw83Bbj44q8tIEEQq9fX3fxNcBgStYd
X-Proofpoint-GUID: jNw83Bbj44q8tIEEQq9fX3fxNcBgStYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfXwOLKC5ECEygm
 kQRXcM6+l/ONrN+rW/hTypLGwG0NuTd/jAe2pYcA0mkEB31bI5jt4v1Hx5Opl/Z5TIvACMFFyqC
 oZM80cavEbukxZaN9zz9MJrkiKjASUIygL3DT2Q3EbJ2kId2sbgEDJGvf+wNxJxmFqqkkgcKKLW
 a+SP0YQax+Qy0MWSWjZZ/RuIor0uRAakgq3ULf8Pb2PIDGb9NDO45pv0LDvK7q2Qf8VB7zkSKCb
 hSQoQatXfXIeTSmAwWLDKLzlyutSI3QjyYYJQZ2zviJ+BqN3nHlTgWy+O3BE1r1t9NzHJAv1dG8
 yWaeEs8GSGP4w6OslOPY+IKEJHGsSeM4YTWvE7UdCHsVkKXQU0qOY8v4LZqkq4df3ThAM5rKAyS
 v6s2+JZsencHEB21UMWyxzY4ZrsKjuetbAeLSC7Js4tLwRI2oXNuDKNvyZSNt4zFcFK2qPSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

Moves RTE_FIB_NAMESIZE to header file, in order to use it outside the fib
library.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/fib/rte_fib.c | 3 ---
 lib/fib/rte_fib.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 2c05d46500..184210f380 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -28,9 +28,6 @@ static struct rte_tailq_elem rte_fib_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_fib_tailq)
 
-/* Maximum length of a FIB name. */
-#define RTE_FIB_NAMESIZE	64
-
 #if defined(RTE_LIBRTE_FIB_DEBUG)
 #define FIB_RETURN_IF_TRUE(cond, retval) do {		\
 	if (cond)					\
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index 53f04b8049..874bf1688b 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -27,6 +27,9 @@ extern "C" {
 struct rte_fib;
 struct rte_rib;
 
+/* Maximum length of a FIB name. */
+#define RTE_FIB_NAMESIZE	64
+
 /** Maximum depth value possible for IPv4 FIB. */
 #define RTE_FIB_MAXDEPTH	32
 
-- 
2.25.1

