Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A0C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4416D4026C;
	Fri,  9 May 2025 08:45:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 326654026C
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIYKQ003775;
 Thu, 8 May 2025 23:45:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 dO1JhTyf0T6H3W8m0XjbrpCL1CWpYjk4ee/N2Ph7ac=; b=doxey1E6MEjg+KkRR
 I8eefz9mW4rV0kaPUw2yDv8qfFo9y5KyipvL0YuCTDMtwdk59C0wqvQv46go79B9
 6LB7TKgf9eyR2dB4hzy/uRUh508b7NXdhO0d516ueEs7xWebqG+PXHoLM2kTtLiW
 PgWi6mA5t+rw6NkxZUymG70EFnnyZAewarSd7797dCj+wksuusMzxoDv5ZnuUUOg
 6BwRzcu2m66qputtmN+KN+D8rtzo9O65fI3wIaQ91hi0ACwnrE5WfHl7jJryjyED
 gXVoHglNGAGNF0zcuk0kQDDJwMr+zHr5OGJ+uxKN0nYKd9wm0efYK997+Xvuz691
 3nC0Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0pa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 313E33F704F;
 Thu,  8 May 2025 23:45:41 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 08/13] fib: move macro to header file
Date: Fri, 9 May 2025 12:14:43 +0530
Message-ID: <20250509064448.724019-9-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681da49a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=iWd_wJcLHtG8fJjlCTcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfXy96I4rsj/1gs
 a5TG/OWWjPN3YUQ9cH5cdAWF4dpOt2k6cYyaV5FQfgNwa8I0S4tl/UAg5nKf2SoE2DsGHhe7L8K
 tc65q8U/GFCbHkd2EIfADKOjpU4xLcG62zHlQKDoE6kvHUWOyY0g6ZS655p7lsTXKP/wSFw9SlE
 bzB4F+e0UheqR/UsTxXtqebwd6EunagmcOXSQC8ih4ioWTg882jGABG5vqM8C6igj9bqyjpVHrz
 lDE7dAebbTFPV6W2uxvboR3WHyPabrLPtEKCS7fBvLaF361tjbwAuHUlykwPpPPjvCp/tdhf7sg
 +CHofTLaE4ALpGPzYUv7WTHqzIzUEw3uz7LijFwmg/FOgMNDQZEYO1Og6RSz6Ip7Wx2rSx7FJQG
 HKYJDc/fVC3gRZWgdMq3dvhQxOUveLXjBsD3hnS7QaPz8Pe9eEZa608e+KdNPEXOBs3J6TUQ
X-Proofpoint-GUID: XFjG9wskhD2I6ea2YN1Kk2GnqUc3M0SV
X-Proofpoint-ORIG-GUID: XFjG9wskhD2I6ea2YN1Kk2GnqUc3M0SV
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

Moves the macro FIB6_NAMESIZE to header file and rename it to
RTE_FIB6_NAMESIZE.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/fib/rte_fib6.c | 11 ++++-------
 lib/fib/rte_fib6.h |  3 +++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 00647bdfa4..93a1c7197b 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -28,9 +28,6 @@ static struct rte_tailq_elem rte_fib6_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_fib6_tailq)
 
-/* Maximum length of a FIB name. */
-#define FIB6_NAMESIZE	64
-
 #if defined(RTE_LIBRTE_FIB_DEBUG)
 #define FIB6_RETURN_IF_TRUE(cond, retval) do {		\
 	if (cond)					\
@@ -41,7 +38,7 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
 #endif
 
 struct rte_fib6 {
-	char			name[FIB6_NAMESIZE];
+	char			name[RTE_FIB6_NAMESIZE];
 	enum rte_fib6_type	type;	/**< Type of FIB struct */
 	struct rte_rib6		*rib;	/**< RIB helper datastructure */
 	void			*dp;	/**< pointer to the dataplane struct*/
@@ -157,7 +154,7 @@ RTE_EXPORT_SYMBOL(rte_fib6_create)
 struct rte_fib6 *
 rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 {
-	char mem_name[FIB6_NAMESIZE];
+	char mem_name[RTE_FIB6_NAMESIZE];
 	int ret;
 	struct rte_fib6 *fib = NULL;
 	struct rte_rib6 *rib = NULL;
@@ -190,7 +187,7 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	/* guarantee there's no existing */
 	TAILQ_FOREACH(te, fib_list, next) {
 		fib = (struct rte_fib6 *)te->data;
-		if (strncmp(name, fib->name, FIB6_NAMESIZE) == 0)
+		if (strncmp(name, fib->name, RTE_FIB6_NAMESIZE) == 0)
 			break;
 	}
 	fib = NULL;
@@ -261,7 +258,7 @@ rte_fib6_find_existing(const char *name)
 	rte_mcfg_tailq_read_lock();
 	TAILQ_FOREACH(te, fib_list, next) {
 		fib = (struct rte_fib6 *) te->data;
-		if (strncmp(name, fib->name, FIB6_NAMESIZE) == 0)
+		if (strncmp(name, fib->name, RTE_FIB6_NAMESIZE) == 0)
 			break;
 	}
 	rte_mcfg_tailq_read_unlock();
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 42e6138708..625df1fa6b 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -28,6 +28,9 @@ extern "C" {
 /** Maximum depth value possible for IPv6 FIB. */
 #define RTE_FIB6_MAXDEPTH (RTE_DEPRECATED(RTE_FIB6_MAXDEPTH) RTE_IPV6_MAX_DEPTH)
 
+/* Maximum length of a FIB name. */
+#define RTE_FIB6_NAMESIZE	64
+
 struct rte_fib6;
 struct rte_rib6;
 
-- 
2.25.1

