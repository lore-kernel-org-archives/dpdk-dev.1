Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A33CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 05:57:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7038402D8;
	Wed, 24 Sep 2025 07:57:14 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 73F654027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 07:57:12 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O3IMOG021682;
 Tue, 23 Sep 2025 22:57:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ed6EI7smN67/ZbzP2q6VCLF
 gkd8pBuqdQXiVN8A2Z30=; b=SIrSeBM24gR7k0EQLGGjhQCGG8F1cTnJZJv0192
 UJibhIdjQ4VYDdEYYsmrPMQGSuvSyuR9bgzhQKfRDZOupqzYPQ1XizHCK9eCt6sR
 dN+M4TgHWRx8B2L+yLVz9SnDGE1f7E7DSUg45CEOTjgipSu15JVVONHKgOWaZfSF
 dEZaFQcN8PRinMtwDP4LVa5g/swZ1ceBJ42lbctdLwa4ClX/0Yfos7B1vJvp9VSm
 Rc8IPDnhp4U46OBUdm8oarhtoTx9MrCZJn3jPeJVArn9tl/2N+yCs1CeS2kr602L
 J1L2to8PqpLtRS5YQvOqGyizDkN8it8/jqs5nahZVEl3nfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49c8m088g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 22:57:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 22:57:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 22:57:19 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 5E2195B6923;
 Tue, 23 Sep 2025 22:57:08 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Shreyansh Jain <shreyansh.jain@nxp.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH] rawdev: fix device ID retrieval function prototype
Date: Wed, 24 Sep 2025 11:26:43 +0530
Message-ID: <20250924055654.1986682-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=OYiYDgTY c=1 sm=1 tr=0 ts=68d38837 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=9ehpt9xCkGsgDhCOLD4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5TB9ggTVyqPezVn9EzAGiqxKUZBeB4Sv
X-Proofpoint-ORIG-GUID: 5TB9ggTVyqPezVn9EzAGiqxKUZBeB4Sv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDAyNSBTYWx0ZWRfX4btzN94vqiAb
 gqIIlRy1B6CbWSqC9bbVJMyyOrybZgxnb/ySpjSxwp3GflWW5KXqnaHoN0rZBnSmzF4vKiVNcef
 yiBBRnVOuY6TGqtjFTpKKrD3hZEwPzGcOUaxagejd3G4+Sp2V/CaE2kUYnlAwNh8h1EGPhS8ZcC
 kjwo1GAoGwISS27ciD43rfMY+6VsmTSx+7aC+D76QEdryEOPAcf7lwLAmHb9foteUnoB+6EPaM1
 RzL/DzSQKWLb+g77ta6oL8Brp/fYQEWEQh3bmJEEL4xfOiIEmKCZOzNv+7ecibAo+sn6DBM8FuN
 XGK6ZCwcP829VKKoi5UgSrE+264gJS+23xoWzFV/XddXxrGFm3PpinOVbwxpfiCKZdbG2AMCVkQ
 EKh+RiGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_01,2025-09-22_05,2025-03-28_01
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

Fixed rte_rawdev_get_dev_id() function prototype and its usage.

Fixes: c88b3f2558ed ("rawdev: introduce raw device library")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
This patch fixes the return type of rte_rawdev_get_dev_id(). It would be good
to have it merged before the 25.11 release, as it corrects a user-visible API
bug and is a safe change.

 app/test/test_rawdev.c  | 11 +++++++++--
 lib/rawdev/rte_rawdev.c |  2 +-
 lib/rawdev/rte_rawdev.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/app/test/test_rawdev.c b/app/test/test_rawdev.c
index d34691dacf..d1d250c9ac 100644
--- a/app/test/test_rawdev.c
+++ b/app/test/test_rawdev.c
@@ -25,11 +25,18 @@ test_rawdev_selftests(void)
 static int
 test_rawdev_selftest_impl(const char *pmd, const char *opts)
 {
-	int ret;
+	int dev_id, ret;
 
 	printf("\n### Test rawdev infrastructure using skeleton driver\n");
 	rte_vdev_init(pmd, opts);
-	ret = rte_rawdev_selftest(rte_rawdev_get_dev_id(pmd));
+	dev_id = rte_rawdev_get_dev_id(pmd);
+	if (dev_id < 0) {
+		printf("Failed to get dev_id for %s\n", pmd);
+		ret = dev_id;
+		goto exit;
+	}
+	ret = rte_rawdev_selftest(dev_id);
+exit:
 	rte_vdev_uninit(pmd);
 	return ret;
 }
diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index 4da7956d5a..f21d29114c 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -39,7 +39,7 @@ rte_rawdev_count(void)
 }
 
 RTE_EXPORT_SYMBOL(rte_rawdev_get_dev_id)
-uint16_t
+int
 rte_rawdev_get_dev_id(const char *name)
 {
 	uint16_t i;
diff --git a/lib/rawdev/rte_rawdev.h b/lib/rawdev/rte_rawdev.h
index 3fc471526e..ad849e5bea 100644
--- a/lib/rawdev/rte_rawdev.h
+++ b/lib/rawdev/rte_rawdev.h
@@ -44,7 +44,7 @@ rte_rawdev_count(void);
  *   Returns raw device identifier on success.
  *   - <0: Failure to find named raw device.
  */
-uint16_t
+int
 rte_rawdev_get_dev_id(const char *name);
 
 /**
-- 
2.48.1

