Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0626C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C298C40A7F;
	Mon,  7 Sep 2026 19:05:44 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 3B20640A7F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:43 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso3978540a91.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800742;
 x=1789405542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JH+PZEmkZRofYs9wjOY/mTd+wbPu4z0jBUih9ujn5kY=;
 b=XTCf6vKDLdz7Lm/jhRIqeaotAAcXB929O2Dy7oHBOhTzSKFnisiPL8h2ATIdgwiTy+
 i50FlkxzJc5LsbsbIDJh1X2wz4cffO5MGrLJJ4Bn3BfNnsyZbWjNbX1qACQ1jRqGS/hQ
 TnEZsjz6H8FWmUt8yJwRS2KOHSYO2kyaiHq9wPgKIMFYCEJQWqqK31LEeAm+N+bsGRmQ
 DeBrEEGN1qLMVeNvDTzY0txuuzuzdbhkSh/W7SJxNeG0RxZy7DrY/aP0RcY8H0D2eoKN
 RUkvjawoh+W2RxxBjMHGGMB9cVLnQPY+4p1xOw/DpxwCcQJvbGZ2E0XO/Vj3bmlIWn7Z
 EYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800742; x=1789405542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JH+PZEmkZRofYs9wjOY/mTd+wbPu4z0jBUih9ujn5kY=;
 b=tEtb0MEYYCZYlVJnIKg0LHg1opNWQBNXMACngDwbavmB4SoTvp+lz+JRWb6/WKiiUY
 V/hIj0kFnvemqYezbJsOqGBvJLS6fwH5Yi6jjw2vVMYWBvfyAUi33Xo+4INpHVceLenv
 ZuBjGUScNGOitKOLqZ5GIM24M8/uiW1JyIzm1NKHiKUPgyRVQkWl6kfQGwiKg1lDYC0G
 WcPmJE2bkEbkngj6Ub/B7WT4ZIxkoks05ITQ/tjATKjGKnCEysKRZnTSvAFienoSa99D
 x7dl0utwaBhhCdSPetWf+ezWSz9P8k95eyi+QpuC2bByMRKD4kaHwgmN/xCCwx7WgN+3
 jiyg==
X-Gm-Message-State: AFuF++ny2om4d64uhtwWbr/7apxhKFMXwfenuNGYw9zE+zTfCVaDZUp6
 4wj9u2I5Qa+plSQDrWaqaaAU0ERo9VzYWRTV4kP1w6SCcgt1QLoBrD9uTFCy7WfVwQRNp06Lf0B
 wjgzf
X-Gm-Gg: AYBFou0eKajVMWObwHd04q4qu8CvagNmjvTgYvt7S+uY2s96FENi6PQVp23jrTTXamD
 Mt5TSZjyvntUxMIZUo9pz+/uQ0+itlfiifpQnZ4Eyg8L/TD07ZYPjvVFHZwzIZQK+Hd9Y9WRxpd
 dQXeum7S6OeCaziO+aZVnnOsIF3mbSIR+EYsgxYla0a+/ICqpx2rXCPTB4FwD/ffSEywG7+cq5A
 XC8dmK4Pajz5XZwCkqoBTF1uziB8cY++xHi+Y1pmdxwvjpDCGdHjj3rUUB6um2DSGqFRFUjQe4u
 PkHdhAdt4Xf3W5ck9o+Y7riYG6Lq1l7Ks1iPhLmDctHQ7SQztL9OW1W/LmzhwL+8aiXovB6LzLi
 R4tP97VzZZ2LuzsmXdxTjwYvqxerO4BQHzJmnqpSF+WCCz/Tqi/xcFMwRnJU4BsWzU0k9MWO0K8
 es829isiem8XSxUIaRzUq601qatpDonceNv+tbelO2omis+CMgTTXPJnhDJ0EVMZXtIW7Qjtv/R
 J9ottVwzm/zcEemW5k+6fw/dIdFKP61YP3W3A==
X-Received: by 2002:a17:90b:4c41:b0:398:9bd5:490e with SMTP id
 98e67ed59e1d1-39b2623ac0fmr35598981a91.21.1788800742327; 
 Mon, 07 Sep 2026 10:05:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v2 10/13] examples/l2fwd-macsec: remove print in signal handler
Date: Mon,  7 Sep 2026 10:03:28 -0700
Message-ID: <20260907170454.351647-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

Calling printf in signal handler is not async-signal-safe.
The printf was unnecessary anyway so remove it.
Found by GCC -fanalyzer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-macsec/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..33113cb0f5 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -1247,11 +1247,8 @@ check_all_ports_link_status(uint32_t port_mask)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 int
-- 
2.53.0

