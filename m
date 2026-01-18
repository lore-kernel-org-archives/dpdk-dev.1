Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE546C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0C940DCE;
	Sun, 18 Jan 2026 21:12:32 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id EF608406BA
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:30 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo27877595e9.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767150;
 x=1769371950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXKRZkBM634en/6uXBS8cAJdAajPPm2iaWDUyD449dU=;
 b=aY1Cdbi4e6aw8GFdeQpsicQ+WffygUmkRgqMQ9vZnDi3Qt1MskhXVQkE5SVE7gXNMN
 b/0Xv7PYStpDeF+sRaAet9bSzzZwmjR39F1WFo9jqPZ0kGIqySPMNw3jecofQab0MRJ1
 qfQklmNOylHrMwT+QjDRxuIzky1zqlVdFbZ4sgYI/4RLWVkm7PbmzO5Wc63CKH2cPDX9
 BfhiEL5UT6+K/PI+bDcLgNkNl9inMVzAccgJPhQpX/N6eS7wgQEi+Cou9xS9L3SzEKJr
 rYX1I+abXXQ2hx2scCys7dHx0S0IY5Qn1HrL4gOY4JmY1x03YGLV7xSiEAshkuASdiwg
 f/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767150; x=1769371950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXKRZkBM634en/6uXBS8cAJdAajPPm2iaWDUyD449dU=;
 b=ruiizWRWx9OiyxjGn/1Ic9/jcFTyyqeDTERQVDUjP/KYqrwbHPT8nZG4ey0qHFp3Le
 RPHjN2x4v41zUBhD6Y2T9ZGbIr1NDP/UPVamsuF7jyKk99s1rLGVmjmCU2QG5xFKqGv7
 zmhoggAEHbfLX86/Ih6FdxCvM4/s1eit9Yqli123oIhiOrl2z7AMrCx4Hh2Y3x0TKwIO
 u65zQvBuq4VG/IvWhjup+bLNZgwARXPMOXeo3PtIxDRVOCWiCDyOzZg0OsCHK4iVPtP+
 uC6F78cVp86wPyoiXoOETXFNEnQLqMMEplF/ddr7ZjW+xcixQZhz5FMMm4US1py6nNFy
 g7PQ==
X-Gm-Message-State: AOJu0YzvbWH/R3C29fhYsiiYYFsDqTt18Gd29ovzmNZf21+md9GaIdyr
 1Qj+dLgEa4wE4ZgII4EWwqe5vAzwiHgFylEnfzGLflvzJzC5JDW6zf2sqQJNEAqr3o4CI0E/TG+
 pFQFg
X-Gm-Gg: AY/fxX7oxbBeYtlRrNA2oIJk6C0owKM6+NFdFeohFc/mgb79slHh0/NdbAju05RS36y
 0gVB8C8gPTlpNwh1gP6RkKhc/YgGTkr9g9g3pFiC4sROnx0qUcX9N9QIofrVH1vNfvSZdJaK1c5
 0Zy6MoD3P8aBBXM61byx3CGzG9u9pkcq+cjmNjA4y56QmxDzXmJUqvc7wxeh/lezOTpFSOxyA7C
 C8vIXFgu0fuvf/1Gyt7ESlMrfWl4Up2MgrQo/wDdqBSGxIXjzkae2jL13UhDvyFsbcFcxDXttsH
 wzJ62IhpJ5ZpDscxJH0RQXC3DoXkNiws8D0JU/JrLeftJQaa38bmZ/Ny3Dr8NnXvT56rtG0Wa29
 ydNzsZQ34C1ArVpPqxsoqhvrt5B8b8BHJYt/vtqeWsq2OV/bkwT3Tmw6mBeE6EwhiO6er/4+Krs
 x5nWMSIMLnXDYfqisGYIrFIKrS33oWXt9vsI7i3nMIKsuF7q4fFQ==
X-Received: by 2002:a05:600c:4e4e:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-4801eb03400mr114554505e9.24.1768767150452; 
 Sun, 18 Jan 2026 12:12:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH 1/6] test: add pause to synchronization spinloops
Date: Sun, 18 Jan 2026 12:09:08 -0800
Message-ID: <20260118201223.323024-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

The atomic test uses tight spinloops to synchronize worker threads
before starting each test phase. These spinloops lack rte_pause()
which causes problems on high core count systems, particularly AMD Zen
architectures where:

- Tight spinloops without pause can starve SMT sibling threads
- Memory ordering and store-buffer forwarding behave differently
- Higher core counts amplify timing windows for race conditions

This manifests as sporadic test failures on systems with 32+ cores
that don't reproduce on smaller core count systems.

Add rte_pause() to all seven synchronization spinloops to allow
proper CPU resource sharing and improve memory ordering behavior.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_atomic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 8160a33e0e..b1a0d40ece 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -15,6 +15,7 @@
 #include <rte_atomic.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
+#include <rte_pause.h>
 #include <rte_random.h>
 #include <rte_hash_crc.h>
 
@@ -114,7 +115,7 @@ test_atomic_usual(__rte_unused void *arg)
 	unsigned i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	for (i = 0; i < N; i++)
 		rte_atomic16_inc(&a16);
@@ -150,7 +151,7 @@ static int
 test_atomic_tas(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_test_and_set(&a16))
 		rte_atomic64_inc(&count);
@@ -171,7 +172,7 @@ test_atomic_addsub_and_return(__rte_unused void *arg)
 	unsigned i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	for (i = 0; i < N; i++) {
 		tmp16 = rte_atomic16_add_return(&a16, 1);
@@ -210,7 +211,7 @@ static int
 test_atomic_inc_and_test(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_inc_and_test(&a16)) {
 		rte_atomic64_inc(&count);
@@ -237,7 +238,7 @@ static int
 test_atomic_dec_and_test(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_dec_and_test(&a16))
 		rte_atomic64_inc(&count);
@@ -269,7 +270,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 	unsigned int i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	expected = count128;
 
@@ -407,7 +408,7 @@ test_atomic_exchange(__rte_unused void *arg)
 
 	/* Wait until all of the other threads have been dispatched */
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	/*
 	 * Let the battle begin! Every thread attempts to steal the current
-- 
2.51.0

