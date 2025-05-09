Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0890C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80926402E7;
	Fri,  9 May 2025 08:45:06 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8E2224026C
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:03 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492iIDH030900;
 Thu, 8 May 2025 23:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 6BiDaaZgXoKkCnx1j8rFE+k5TarM/avmNwAL/f65EE=; b=Npbl1bnPlJv2Gv9QY
 Y1HeDlc/bla5aLuVv4jmI9dH+OYVpqhwWzaqmRC8CpFJHWyoyQaS3vmPlUwQxHOB
 SgRsYs7QQ91rDjawJP7XnSvVoh+0BL6kAP4kdqNfrs3xE+L21NhNU5gX201AL+SS
 q1dDzHLDmB1SVApeerO1JBm/PVWxd8MwoenfkKZygh00oQkAb+oujz86GGaen1pX
 xV/srC0e+E79X3yGnxvJ0ZLP61sWdr/8qJ0Jh0QwZ5N7kgbZAICrBVmVtyC2Dher
 mFcC142QaEzhUimMbkmIN9jEFzFMBcarsqA3div5s9Ed9xFHshPupw6O/I2cJVZM
 Sg4tg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46h96c0cec-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:02 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 026C43F7066;
 Thu,  8 May 2025 23:44:58 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 01/13] fib: move macro to header file
Date: Fri, 9 May 2025 12:14:36 +0530
Message-ID: <20250509064448.724019-2-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfXxHJUEia0gFOA
 saLhS3l9qkrhhu2VhhyXWtRGMQzzVOKvIRZb4fe1DxV8HtBBH/S6T7T4zrO2ANUBnDJUVf0YS+n
 6pi8ImJxhT55zCSm1x9fjAyFBTD73KsKlfeOXPm/xkAcCIF6JJIc8neWPTjqmx6wwJDF/lC+uNP
 qA88XZG5i8j1YRjmBCWBMS8sGVrDyy+FE/fvutIyc0vvFLkaDXTIBe0JQmTlNwHb4VZ3be7TB7+
 6KY9Qs5C0m4z6Yh7QZ4MwqkxCqRlf10jyYMAOv5ZOPuH0sY7lqM+/Usv/AKG/MRoCFXGe4udZ6M
 sYJfz/G4avPI17gInzJHJsZWj0Ovn5LxpzPKgQ1mzX/ErW8P2RdqVEDHIiApvYw6H3Ed9ewi/1f
 T0kwN5vohf9MqjzH6Pqrq+kdTIOKUH4WgPWjaKQdNj/geaWYd1bLKab4+C5MsKuJF+XmWhvl
X-Proofpoint-GUID: siTFv3xNS08dT8SV2AzHe6t9Q-91onU1
X-Proofpoint-ORIG-GUID: siTFv3xNS08dT8SV2AzHe6t9Q-91onU1
X-Authority-Analysis: v=2.4 cv=dpXbC0g4 c=1 sm=1 tr=0 ts=681da46e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=vxp6wFEekYbuhhetsVcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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

