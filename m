Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCACC5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A38E402D5;
	Mon,  2 Jun 2025 08:37:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AA685402D5
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:40 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5524KnsG020800;
 Sun, 1 Jun 2025 23:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 dO1JhTyf0T6H3W8m0XjbrpCL1CWpYjk4ee/N2Ph7ac=; b=dWIvcXOr8ZJxpPe7a
 JUuciNsK8LbRdc0Hp13hRPMuJ8xVD++PewbgxGjw2YEPorxcmdOes2NZhTwN46r+
 iAvZBdRuMWkqxC2JSgvsnsBtuQwYhbsh18eEYUGelspbIZLxJr1HS5stIfmNk+99
 GFGTgbDWLzMuXC5or8fhjw+4JEa3ZJdqdPQtvCq8d/0ARZpFCljUiLN39MEQota7
 EukOE8Kg2zVVheb6LWFpa9dS1sCVF/zNwGpwA9hqvk23iBPCtYcTraB7SHI7OyGH
 5vrG22oaaN++2g7RWG4kTJZS5FF1rbfLc5J1rAD0EK//x7S+lRdttmsre2Y5kL2a
 oPIGw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye00n63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:38 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 8F5F63F704B;
 Sun,  1 Jun 2025 23:37:35 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 08/14] fib: move macro to header file
Date: Mon, 2 Jun 2025 12:06:33 +0530
Message-ID: <20250602063639.198550-9-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX/6HM9MNq0DpK
 3KweAwWtrggaC039fcKuP2OlogaDZneuZg0MN9T8egZ/glLscE6ZEZl/m/kVRVCM6jTBMlFHQhI
 665HHjL6CdvsIgQYKhQPMx0F4h70pv6dDlRk+XpGrNMys85MPvE/V08kGbbbf1tyekBvEmz5LYP
 oprm7TrbSAc+I/AK+opcJugq/45y3SOyXjYOPpVzPJ2tBh3cEExhtYWLPexMzCblRVq4OUsq1Hu
 1XJyeCfqW6D7hzLd5l5769NvE32myNzeX9n49XSMsWLAfCNJSQCLoi0xFGxGgTvi6h/SG8zDkvd
 5WkcAAS6OxZfaQ9UvlUuyinX26JaEveT88i7aCJx9hNyAAG6grEYu5ZtVE/qkYPJEhqUy3hG7jv
 sPAxdWTXg+K3GYBSZucq4R8iR4mTB5eUY92qsHDCZM1xdoKMXLeahv2mB1l/LUDWJDAUb3wR
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d46b3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=iWd_wJcLHtG8fJjlCTcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8Orm820ZeZFO4AUGtP4Xr_s7NRP-8JzC
X-Proofpoint-GUID: 8Orm820ZeZFO4AUGtP4Xr_s7NRP-8JzC
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

