Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81294CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A7740DCF;
	Mon,  5 Oct 2026 18:55:19 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id E525840DF8
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:55:17 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc4aa02a269so815599a12.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791219317;
 x=1791824117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lia0HfshUad93JbomqMsQrCLIPRMOMpCBna6maavrUs=;
 b=ciIOeBWsPreEe8Y8BBPHMdwILNM1ZbqqjH8nf1RcZffR+bcPo8BJlSo0Zlw7xPJ/MS
 GSQ8wg3MntPYwd9TWfiNzsSCabLi0Zygprf5IHb9U1Pxa5hEp/qpI+pKVYNGa5MxtJbS
 Q90PlSFuYwmAa1SCV8EAZiA1ekCjbs7xwilJkdfVK2Bm6JCTgtNVcBznQG38aFbZqdl3
 j+7evhJSX/WIPufZrbVerwgzzkXBNy3k++oOGKTjEo/2ondF8FlinsN3gGdRJvtO/yB3
 5ydHCyg9WSr3Tmx60Elm+c2HSY8LwRNaheeedSilzUinnqQOhjU5IDOv4xJqrkgjbN0h
 OqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219317; x=1791824117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lia0HfshUad93JbomqMsQrCLIPRMOMpCBna6maavrUs=;
 b=sLtT5LGk6JfI6L8F+pV3mqF5XHY8EJxuZKj/JJV1KanACgoYLOB+nbP3xojwmim+7F
 eEoDk1+vnDW2vATOGF3lcpwobqpGacotUM1lpdBLlnUBojvt1WYuaJjWpXboUOlejdG8
 5fEnG0HmTVyXY3M7sIWewJhOf1PrhgIPAAvR5NItD5DzyzQiesuvgI2XyZFZ4wUQ326v
 FK+5fLTKtcFK9a0jicoCZBr8TohBJdYZeUZAUatmn7doDfbgk4YLUPl8WK4eLhLFakhz
 QWlGOygpfLAhEmyDscvOx7GIt8VsfgAU444ZWwI7Ar/Pe3WDWtc3YYnqdRORmaXWLWb+
 RKzw==
X-Gm-Message-State: AFq9FYK/GpqTYA/lLu80n4kTEABb70FuW8owxIAOHIjrGeKbwSwBTlhC
 aNrlCo6J6skL9eA8Mdlygc/n3WyEsdhnCeInDCUJsO7vwhbRlGjL1QIZpfmOnO0k7azwUojTnDD
 7PzrhnHU=
X-Gm-Gg: AYBFou2fcLt4JzeGBVXaSUTAcw7dfLEsFfDdwVXWonxv5YTkJLCG2eWmuGkupO4Qsvs
 Q5CqU4d5zlrezeafNT0AS5CC9xSzv/modUAAXlHjzu91jYnYtHBIrezVAgYkRTxl8zaLwE9jRVY
 s/NBu/LvETorzG5Fv0yCY/KaTLn/qwOUmGMvE6tkfDB72XCKXP01psTACTMAPfW28MLF5T0P4N+
 pys35UrT+hDUMjlJqOyXtjKmR6wOo1QtUz59s5ISW6bSQ0HQ50OktT2iZzjOm1VlvvznA+jEkCn
 vRXVcvJt78d2ltX0n60TqAL9+FGQ42+GKCCFH6227LLlXYgqyLUgmD8HZvL+gqnENvt4uxu+kFS
 7xT4BYxDG4CdDCEZmjdLCrvNSfR03KH8jLHGl4NVgtWZ16TloLt6o9bj4BioZqIBeseSjAYBKvP
 zTPf8QkfALaYOvjugjkw5MQHpz/Xyp/31UmnL3/xnqxzU1UK+//rX6E/c2M8736QtPd53EZ/sHn
 IuyQ6sFY1GgbvK0AVQv+1BHvPpfUNw0/tpGDw==
X-Received: by 2002:a17:90b:390b:b0:3a7:db88:3491 with SMTP id
 98e67ed59e1d1-3a7db883ccemr3810352a91.33.1791219317031; 
 Mon, 05 Oct 2026 09:55:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533aba95sm289414a91.2.2026.10.05.09.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:55:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 3/4] test/devargs: use unit test suite runner
Date: Mon,  5 Oct 2026 09:53:49 -0700
Message-ID: <20261005165512.334085-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005165512.334085-1-stephen@networkplumber.org>
References: <20261005165512.334085-1-stephen@networkplumber.org>
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

The devargs test ran its four subtests from a single function, so a
failure reported only one overall result and later subtests were
skipped once an earlier one failed.

Convert to unit_test_suite_runner() so each subtest is a named case
that runs and reports independently.

Two subtests also recorded failure by assigning the parse return
value to the result, which hid a failure when that value was 0.
Use TEST_FAILED instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_devargs.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 571f57500c..de0dd2364d 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -179,14 +179,14 @@ test_invalid_devargs(void)
 	struct rte_devargs da;
 	uint32_t i;
 	int ret;
-	int fail = 0;
+	int fail = TEST_SUCCESS;
 
 	for (i = 0; i < RTE_DIM(list); i++) {
 		ret = rte_devargs_parse(&da, list[i]);
 		if (ret >= 0) {
 			printf("rte_devargs_parse(%s) returned %d (but should not)\n",
 			       list[i], ret);
-			fail = ret;
+			fail = TEST_FAILED;
 		}
 		rte_devargs_reset(&da);
 	}
@@ -233,7 +233,7 @@ test_valid_devargs_parsing(void)
 	struct rte_eth_devargs eth_da[RTE_MAX_ETHPORTS];
 	uint32_t i;
 	int ret;
-	int fail = 0;
+	int fail = TEST_SUCCESS;
 
 	for (i = 0; i < RTE_DIM(list); i++) {
 		memset(eth_da, 0, RTE_MAX_ETHPORTS * sizeof(*eth_da));
@@ -241,7 +241,7 @@ test_valid_devargs_parsing(void)
 		if (ret <= 0) {
 			printf("rte_devargs_parse(%s) returned %d (but should not)\n",
 			       list[i].devargs, ret);
-			fail = ret;
+			fail = TEST_FAILED;
 			break;
 		}
 
@@ -249,7 +249,7 @@ test_valid_devargs_parsing(void)
 		if (ret != list[i].devargs_count) {
 			printf("Devargs returned count %d != expected count %d\n", ret,
 			       list[i].devargs_count);
-			fail = -1;
+			fail = TEST_FAILED;
 			break;
 		}
 	}
@@ -278,7 +278,7 @@ test_invalid_devargs_parsing(void)
 	struct rte_eth_devargs eth_da[RTE_MAX_ETHPORTS];
 	uint32_t i;
 	int ret;
-	int fail = 0;
+	int fail = TEST_SUCCESS;
 
 	for (i = 0; i < RTE_DIM(list); i++) {
 		memset(eth_da, 0, RTE_MAX_ETHPORTS * sizeof(*eth_da));
@@ -286,29 +286,30 @@ test_invalid_devargs_parsing(void)
 		if (ret > 0) {
 			printf("rte_devargs_parse(%s) returned %d (but should not)\n",
 			       list[i], ret);
-			fail = ret;
+			fail = TEST_FAILED;
 			break;
 		}
 	}
 	return fail;
 }
 
+static struct unit_test_suite devargs_test_suite = {
+	.suite_name = "Devargs Unit Test Suite",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_valid_devargs),
+		TEST_CASE(test_invalid_devargs),
+		TEST_CASE(test_valid_devargs_parsing),
+		TEST_CASE(test_invalid_devargs_parsing),
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
 static int
 test_devargs(void)
 {
-	printf("== test valid case ==\n");
-	if (test_valid_devargs() < 0)
-		return -1;
-	printf("== test invalid case ==\n");
-	if (test_invalid_devargs() < 0)
-		return -1;
-	printf("== test devargs parsing valid case ==\n");
-	if (test_valid_devargs_parsing() < 0)
-		return -1;
-	printf("== test devargs parsing invalid case ==\n");
-	if (test_invalid_devargs_parsing() < 0)
-		return -1;
-	return 0;
+	return unit_test_suite_runner(&devargs_test_suite);
 }
 
 REGISTER_FAST_TEST(devargs_autotest, NOHUGE_OK, ASAN_OK, test_devargs);
-- 
2.53.0

