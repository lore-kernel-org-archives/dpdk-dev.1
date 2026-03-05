Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA2F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B9E44278D;
	Thu,  5 Mar 2026 18:53:38 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id C2EF1411F3
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:36 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-899f27df3d1so49952656d6.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733216;
 x=1773338016; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8jT3Q9nZStSTUClrk8nBUjdLW0vrarjG4jUS7cYM+I=;
 b=PFnz7/U0nGVCYvvy+mQBh0/IqzHpD5w5kR96O+Gw01mxMud8t95A8t2BsmOFKWZlpS
 xM6QI/FKnFfZ6zPg/kfdQvPYAJ75qtWRGGa6PimVFqXwsWuTO+ObCzVwklu/SSzAXOUJ
 iPWwl3DtAXzyjHOXigI1SMKe6LpPPvN5f3QdnJqIL2WnplTdLiptPDmo0W1bTa/1KArr
 dMejQq1kNdvLpx6qfxS/SjkCzmtLrGdvRvlw9vo/Z8FouX9QpNbvfXiWOYncOR2tphnW
 5goCiM2uDd2lg+/s+ZDg0hOTTo3sJZV6KPOdu74vSsLyjAQXMUg5GtbmHOSZlUsMLSen
 mT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733216; x=1773338016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F8jT3Q9nZStSTUClrk8nBUjdLW0vrarjG4jUS7cYM+I=;
 b=xPL4lxrc5eJ/G8sgA6ohwgvJYgDVMgVBmZkfBY96LvTMx98fonrVfJ97BoyxOB0bgG
 3s5aA6X1/O+buPbuKT4hB2ZWqA7eAoiZk2oE1DsriKjxww/zEJIYwBXPVQjqgpJ/bzmZ
 Jd74pNDDPJbAailICVN5CEOOx7aqW/Cv/WxBPPnhaVvs1mzYPNsxt4j3gAPwesIRgyYt
 Dib1G/ZG8z8ltDGll+72KJwWm2gLr/+antf8Qw4n8VRW2Vx5Ps7LQADnnjZ7A4386drW
 7EhFApIwQO8WZzZvxpZk7QYYTMJmVWesdMGHbCttq15W/MfgQlI6CW8MO+nYlFt5d0Ny
 mFgQ==
X-Gm-Message-State: AOJu0YwOHJhkht8NAD3YWk9udvH1fdUfzfTRhzJTrxU/SUIVL5rIG0nW
 1W4ACNVBrixHpC7nsB9dJncuMwVSM4T4CawIu1dkMawxHR/eepud6Vkm82Aj2KI+cqnFHuVcS5Y
 dBKQ/
X-Gm-Gg: ATEYQzy3czh9jF6zrVlOfneP6bpsAyj+saZ6R/0BR4dC0+UVxs0hsRXMN/2SJBTaELg
 aMtrn8Yd6c8e99x/CraA8tI5sFcPqrpL84dmkf0oDpS3bbRt17YLKfw9m8BECu5r/voGwjkg/YF
 Qh3gH+YsSigEdYCptBTZ1CT4rsneAic8DALsq0Tn/VNEuC0MdVaAPdihppELnVKAxijPhGnlma2
 LlI7xOxVYX8+wcyt/PtTZZzJ8+hZdseqkLt1T1i7/YCGuLrLK2TfhbobFJKK5lPN3oWF1uRv2Ss
 3CXXm5yRHcgJNZChF1d1N8nFMZvBGg7KK7+Ede/c6DqzAR0cRxrDZCURltOwojbtob150aYMVgp
 iGnrk2Xnad8NPqBKucBF69uWCP1iufXnz2O5OyBa3E58jz1ZYxACHUJOpt0oC0oGc9VLKWGJf3r
 eqOdh/k1YHbHh6lBJ1bbDRaU5AGMAAzv8WVQaZsj5R6yg9bgOM0e5ON0UpOOEgLg==
X-Received: by 2002:ad4:574f:0:b0:899:f24d:1244 with SMTP id
 6a1803df08f44-89a199ac00amr88313346d6.25.1772733214827; 
 Thu, 05 Mar 2026 09:53:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 04/11] test/stack: scale test based on number of cores
Date: Thu,  5 Mar 2026 09:50:58 -0800
Message-ID: <20260305175326.279891-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

This test uses loops to synchronize but has problems on systems
with high number of cores. Scale iterations to the number of
cores.

Fixes: 5e2e61b99e91 ("test/stack: check stack API")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_stack.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index abc3114729..5517982774 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -268,10 +268,12 @@ test_free_null(void)
 	return 0;
 }
 
-#define NUM_ITERS_PER_THREAD 100000
+#define NUM_ITERS_BASE  100000u
+#define NUM_ITERS_MIN   1000u
 
 struct test_args {
 	struct rte_stack *s;
+	unsigned int num_iters;
 };
 
 static struct test_args thread_test_args;
@@ -280,9 +282,9 @@ static int
 stack_thread_push_pop(__rte_unused void *args)
 {
 	void *obj_table[MAX_BULK];
-	int i;
+	unsigned int i;
 
-	for (i = 0; i < NUM_ITERS_PER_THREAD; i++) {
+	for (i = 0; i < thread_test_args.num_iters; i++) {
 		unsigned int num;
 
 		num = rte_rand() % MAX_BULK;
@@ -308,12 +310,14 @@ test_stack_multithreaded(uint32_t flags)
 {
 	unsigned int lcore_id;
 	struct rte_stack *s;
+	unsigned int iterations;
 	int result = 0;
 
 	if (rte_lcore_count() < 2) {
 		printf("Not enough cores for test_stack_multithreaded, expecting at least 2\n");
 		return TEST_SKIPPED;
 	}
+	iterations = test_scale_iterations(NUM_ITERS_BASE, NUM_ITERS_MIN);
 
 	printf("[%s():%u] Running with %u lcores\n",
 	       __func__, __LINE__, rte_lcore_count());
@@ -325,6 +329,7 @@ test_stack_multithreaded(uint32_t flags)
 		return -1;
 	}
 
+	thread_test_args.num_iters = iterations;
 	thread_test_args.s = s;
 
 	if (rte_eal_mp_remote_launch(stack_thread_push_pop, NULL, CALL_MAIN))
-- 
2.51.0

