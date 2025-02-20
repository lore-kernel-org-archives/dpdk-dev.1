Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858BC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D3D54026D;
	Thu, 20 Feb 2025 22:31:16 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 24FFB40263
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:31:14 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7AE89205A9C4; Thu, 20 Feb 2025 13:31:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AE89205A9C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740087073;
 bh=jaf8IHbxA1OeStjJ5GJLM5EXMesSgLeWDrGHlc9auNk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kb94G6jyLrrAA8KNar7bbmSucE5dvCgBZD4uEQI9+ccqqmWtC6/X91goAPiPDTvsU
 Pkah9hUac+xelLGBxoVPO7nN1sA4YdFT0QVSRTt/gBo6iwXcpntmeNzPqhJydZRSnP
 qdFvq+q2RYuLO95jFtbZPuXPIWAfYdrlFvmGAGRE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 02/10] test_alarm: avoid warning about different qualifiers
Date: Thu, 20 Feb 2025 13:30:56 -0800
Message-Id: <1740087064-18680-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in the warning below:

app/test/test_alarm.c(54): warning C4090: 'function':
    different '_Atomic' qualifiers

The fix is to use a macro to explicitly drop the qualifier.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_alarm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/test/test_alarm.c b/app/test/test_alarm.c
index 9ed8c6f72c..6445f713fe 100644
--- a/app/test/test_alarm.c
+++ b/app/test/test_alarm.c
@@ -51,12 +51,12 @@ test_alarm(void)
 			 "Expected rte_eal_alarm_cancel to fail with null callback parameter");
 
 	/* check if can set a alarm for one second */
-	TEST_ASSERT_SUCCESS(rte_eal_alarm_set(US_PER_SEC, test_alarm_callback, &triggered),
-			    "Setting one second alarm failed");
+	TEST_ASSERT_SUCCESS(rte_eal_alarm_set(US_PER_SEC, test_alarm_callback,
+			    RTE_PTR_UNQUAL(&triggered)), "Setting one second alarm failed");
 
 	/* set a longer alarm that will be canceled. */
-	TEST_ASSERT_SUCCESS(rte_eal_alarm_set(10 * US_PER_SEC, test_alarm_callback, &later),
-			    "Setting ten second alarm failed");
+	TEST_ASSERT_SUCCESS(rte_eal_alarm_set(10 * US_PER_SEC, test_alarm_callback,
+			    RTE_PTR_UNQUAL(&later)), "Setting ten second alarm failed");
 
 	/* wait for alarm to happen */
 	while (rte_atomic_load_explicit(&triggered, rte_memory_order_acquire) == false)
@@ -65,11 +65,11 @@ test_alarm(void)
 	TEST_ASSERT(!rte_atomic_load_explicit(&later, rte_memory_order_acquire),
 		    "Only one alarm should have fired.");
 
-	ret = rte_eal_alarm_cancel(test_alarm_callback, &triggered);
+	ret = rte_eal_alarm_cancel(test_alarm_callback, RTE_PTR_UNQUAL(&triggered));
 	TEST_ASSERT(ret == 0 && rte_errno == ENOENT,
 		    "Canceling alarm after run ret %d: %s", ret, rte_strerror(rte_errno));
 
-	ret = rte_eal_alarm_cancel(test_alarm_callback, &later);
+	ret = rte_eal_alarm_cancel(test_alarm_callback, RTE_PTR_UNQUAL(&later));
 	TEST_ASSERT(ret == 1, "Canceling ten second alarm failed %d: %s",
 		    ret, rte_strerror(rte_errno));
 
-- 
2.48.1.vfs.0.0

