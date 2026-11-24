Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E7606A680
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWK5VIbt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 346A440615;
	Tue, 24 Nov 2026 19:05:53 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 7AA4D40611
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:05:52 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so20114325e9.3
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543552; x=1796148352; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2HDrjglrOBs+MFTCVasoYjJOqFkNO8Un2gN9LKtteY=;
 b=zWK5VIbtu6Vm9CMvZo/JXIY+JxofLxFXznM5jOpH2gjRMbZUCdncg09ugoO4epLLW5
 DGa2glF+Mjs2o3I8vzUhNpVPCjkCzDF1mf3mbrSuUuYH+m7T1zoLs79nSu5dA2wTMEgG
 x991sHNQ6CiIwPJoGGCvYh06fFMm2YAh0E2zceFdKpO+yHY0OyypaQSrTh5t0YaHqgIq
 HSvY2tOM+MLXCwjrqvl6o620BkrE2bjFyw+RjnlFC7dktvUDiGdtq6P9l0vkaXY7ldD+
 yWljNMU6dd2vcjz6TjVfA4DtTxc71FKG3lNzNKwye3piE93BcqDiTysXn100w10Y5zNL
 h9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543552; x=1796148352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w2HDrjglrOBs+MFTCVasoYjJOqFkNO8Un2gN9LKtteY=;
 b=jcLR4o47xXDQgiA3abwoix5DuQX356bjfVttz/qQ/ebay4ssILernlwFbRV/Q9ZCjG
 oczkXRMdtymaWDiXHr2Zb+l+5qk5WF7viQBkjTl9lI0fJPWqyR01Bczb2mKDgDOThBlw
 6MxKWsi2fvtmlHsrvDt/w6dHksWkQ22IZPP6cZ8rgWSUdUVPjvTD0p6kkjNNx/J6tttb
 HBJDlerxkQGn/dbpSF8MhrvFV5bGSg22fEgM68r4kYzctds8u+EIQkRfby3IgTJ9nUJ8
 ZJU4XgaS+MHeIHl9/Bb4KLsxPCrUaUL9TGBOf+DP0joJUtfxJlD8xHQmERQ3sIT2OWHy
 wc2Q==
X-Gm-Message-State: APuU4Z8dE9sMXaKFcCPtqT7hXXlQHTeXTbaVc9p42/FxKMrvocCzyw44
 1ruqBovWOagHI6d/4pOfnPoEzJKjbO4MCdY1gzvtg5BZOIS4QgE6pQeYtmW2Vw==
X-Gm-Gg: AZFdTZf88Lv3lcPQ9HulJitevV5HGIgPkT2xjvqqH5zZXwM4KhctkCptS3HJNtv6DTs
 3DHZtwJ1imdcvmrJFQq1sGRXWiUeisDwxdnCJVBMdAC1ArxARE6IDie2UUCEUT4OKLQct+Et6VT
 KGflEHmUdAX1HtQBKh5GgfHfOwG5OpR5XkHSWWXgIJI+YgKl+RQaR4xamgPgF7a6PYU/PXzmVyw
 3R2zTJe42XEX6jLEa3Jp0gvnLg0MhPe5GPG1DU266aGd68KYRLhkMsH/vFQ9wGe7b/raYHFrXDW
 fsVUg+rI5UAbu0f7VF79DYRkQ+liF+oa9dAEh5suT+jUTC51DNNb9yfyT+4r0yPZM2yz+H+Cvtb
 dTzEjYF4pIVxqfSX+H8um0PatB+aOB721pToXcY4eX21+dHIpOShB3IC00p538EWiE0k0clXerX
 iN0B3ho8f0iJgKtYT1JuqA8TOJx7aTVELFKmjpKsq4CUd0MOc9sH5KsaGljP0RLdF972D8TT6Ef
 /bceXx9QfxAHHKRgTJmRuFSHt4rrGnqKfi8NU1g2skQoZZCchZxvf7YVwqCKh3eACtRTapheKU2
 njIGvyTCO3xcVCvCGqOApqB3LqieyfF3Oh0/dUVuM4wIJlDjp/8tn0YlhNbCXQ==
X-Received: by 2002:a05:600c:1c0f:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4bb8881d4a3mr344292805e9.33.1795543551947; 
 Tue, 24 Nov 2026 10:05:51 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm462334035e9.3.2026.11.24.10.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:05:51 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 1/5] app/graph: zero-initialize FIB config structs
Date: Tue, 24 Nov 2026 19:04:11 +0100
Message-ID: <20261124180415.1099828-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180415.1099828-1-maxime@leroys.fr>
References: <20261124180415.1099828-1-maxime@leroys.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIB and FIB6 configurations are filled field by field, which
leaves any field added to struct rte_fib_conf or struct rte_fib6_conf
uninitialized. Zero-initialize them.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/graph/l3fwd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/graph/l3fwd.c b/app/graph/l3fwd.c
index fe25e43da8..f077cfea7b 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -24,7 +24,7 @@
 static int
 setup_fib(int socket)
 {
-	struct rte_fib_conf conf;
+	struct rte_fib_conf conf = { 0 };
 
 #define FIB_MAX_ROUTES (UINT16_MAX)
 #define FIB_NUM_TBL8   (UINT16_MAX / 2)
@@ -41,7 +41,7 @@ setup_fib(int socket)
 static int
 setup_fib6(int socket)
 {
-	struct rte_fib6_conf conf;
+	struct rte_fib6_conf conf = { 0 };
 
 #define FIB6_MAX_ROUTES (UINT16_MAX)
 #define FIB6_NUM_TBL8   (UINT16_MAX / 2)
-- 
2.43.0

