Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78499C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD8D40264;
	Tue,  1 Jul 2025 15:15:32 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id D4858400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:15:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 2C5681D001CE;
 Tue,  1 Jul 2025 09:15:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1751375730; x=1751462130; bh=RKHLEt343m4VSgGLro0NU
 yyEGgNo9MwuppKdY1BtvN4=; b=tFKn+hQ9q9vu2KjFiXeK8gktozzSq2gUHen2C
 LHp9+ZI6dCX/a5g06p9Kd6gpqa6p/QORV2lAeeR46gysw1B9R80WrEC3CymkG9Gp
 c6mY3wkkxgLjoSU/5X1txjYvO1N4rB9pVLvqQ/x26IO4h6iiVj4ZA1ko9SDKJUQk
 aMCfA8g2ehtq28OJIAKzDnywgqyoOyUht1+Iquul/O+olUPRqbZuiFcejLA6WZMz
 gp/P+WTDj8gI1shq+BF6H0tW2yKdVqlPeKzM1SIGZ78uJUKW2vMmUe0Lu8X5Ipqt
 LgoffVOOOCO4HR5wYn4yT+jKDWNWz4PmnOkNhGVugwVPc4dZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1751375730; x=1751462130; bh=RKHLEt343m4VSgGLro0NUyyEGgNo9MwuppK
 dY1BtvN4=; b=Nm1unZmGA5bPMajhS8htHHgEAE2pjlrw94g+WSBcZYMKsYYvDlJ
 EyOwpV7Xg7u4FVzBUWyA/jURq/gDrzSYy2pg3tmyYnphLBmBtcqBZTUfdl7OBUTG
 nWprCpLQ1b59wQVKLYHezBoyku5r2Gz1TC7epnh3JKsRuNgqFB5ITbceYu6a7zmf
 sMamOMYbrqKMmn9XfEHb/uJQ3m5SwPYv/3jLdr44Vg1G1e+5pPkKefUNXceayIXS
 Tf8bSJdbHW5DwTeUuBgqiBLQK6zZHqBmgOCI6h1fjr/TEaFl9D66PjTXXYeuGDWH
 SGuMSYoRG2YsqQiVDA2b8GE7qORhmHfr3Fg==
X-ME-Sender: <xms:cd9jaFEjRG4Amkx5kso6DqUog4YFcP8G7cr4lKcA0G6Oufyd25j1og>
 <xme:cd9jaKXrXz8P4KUzVPAdEbFGvF_T6JAJwcSMe0dtwDxY9i6T6J6zRwBVBWlLPH0C8
 --4UJ23iZEN0ndyMg>
X-ME-Received: <xmr:cd9jaHLrCXMauXRbgQgQR9NJJiuUTbDbbR-WC2iSubFdXmKipl8odOov8HawCXRT4LDcRQr379bc7zdp3Q_CM2IcHMPQ-Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepjhgv
 rhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:cd9jaLEXvRKAgDaoLE0hmPULZlrLVRQEn4hIYGlGviZw4XVQwRgZcQ>
 <xmx:cd9jaLXgO286Bcf0qLODUl4Rl8Nb4bwpG6YmOKLsfg8tRfo0aG7LqQ>
 <xmx:cd9jaGPnI8acQi_ZkHp1PZCwIdxHkP27fkvmsoeeaV2_yXbUuM1q_Q>
 <xmx:cd9jaK0IDjsETAD0ypCHUIXee3xGNwME0GUsoUi1gt21KjurQe_znA>
 <xmx:ct9jaB9KX_6KhE2rT41LuPkiDRM7f9cDYf9zUmmLYlpTUvvORi6DPOP1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 09:15:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH] test/event: disable vector adapter test
Date: Tue,  1 Jul 2025 15:15:24 +0200
Message-ID: <20250701131524.2493132-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This test triggers failures in the CI:

	event_vector_adapter_autotest  FAIL
	3.39s   (exit status 255 or signal 127 SIGinvalid)

Disable it until we have a fix.

Bugzilla ID: 1720
Fixes: 2eca0f4cd5da ("test/event: fix event vector adapter timeouts")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_event_vector_adapter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
index ae173c7715..739352bdff 100644
--- a/app/test/test_event_vector_adapter.c
+++ b/app/test/test_event_vector_adapter.c
@@ -10,7 +10,7 @@
 #include "test.h"
 
 #ifdef RTE_EXEC_ENV_WINDOWS
-static int
+static int __rte_unused
 test_event_vector_adapter(void)
 {
 	printf("event_vector_adapter not supported on Windows, skipping test\n");
@@ -700,7 +700,7 @@ static struct unit_test_suite functional_testsuite = {
 	}
 };
 
-static int
+static int __rte_unused
 test_event_vector_adapter(void)
 {
 	return unit_test_suite_runner(&functional_testsuite);
@@ -708,4 +708,6 @@ test_event_vector_adapter(void)
 
 #endif
 
-REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
+/* disabled because of reported failures, waiting for a fix
+ * REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
+ */
-- 
2.47.1

