Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD7E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38EA04066A;
	Tue, 23 Dec 2025 19:14:39 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id B459F40651
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:36 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-649e28dccadso8623481a12.3
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513676;
 x=1767118476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=befFi1oBJmAawI6FVGtgUqfH9g4xPQQaLqCjHyuvMEoOCDd8cQv7bGQ1UcCJMFZX3o
 3h0ZDVCKbE3dfzizxbXKb5nb6S8draF5lqz6P7DaMMPx4omnTW3V8U2ZmGHkUJTL4WYE
 9qyFXrS3PQOt0eh3L+dE3VY1Xrr8JoOUcJlOQtNHPyv6hksmQdY/myX48g6jVj1PW5+t
 klsmVDVy+rBg70O0jN9QTIfajVNZdW0t+EYaI/0ZOwgRopShtZhAh5GVq6t19CrZZZ6Q
 p+YXe1fMjW3sqpclPbI40rFgOH/Cx57U0k8CCleLgz0JW+OcrNn1m+zDYEwbfqrLZf34
 ozqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513676; x=1767118476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=NBLblozVYOxgeDSdjAZM+PYzzGoEag9p0IA1Jaqlu7y9uksE3OmCB3GkQ4t/znNoI0
 KxkqgHWpeUa7KNGjMWyniqyfN6dCPPcSYF6tlvn4rx080PsryUDMDzG8kD+s+M3pSKcz
 hjy1TZEr0Z8ua0ML4qaAXMn6zRvTktDHi8U9xXsSeQTJNJn6q9EmeI3jYCI36xUyOkhe
 opLXx2i2FsOSiqpczjZg+PNAeHK4/lUizwSDNJW98U8nsgvHEhzCCMAPvy6AHMX3Nd6P
 776+LNIziwfJzB/xORENRMm3nGTBaanqELcHSdWLHPyjws7G80G1/0RFg6UTdfrwlsWx
 IoLw==
X-Gm-Message-State: AOJu0Yz/Uge7sWztE9+zHru/ZT+k/g/ACjgikcb/x8enyPDr27GX8iqK
 pzR03xxJ2GN7gwmonh8EGttvaA6BT3YtOlxRDu8eipRG9tG9oXxfasUvIbzyzyKk43vp5FkvgnP
 IjXjWndM=
X-Gm-Gg: AY/fxX7uuDmQC7QChxYgTp6fKUeQPakBDk1pDhRzq+pHGcVk6CKjExcBx+mXKP0DZIo
 KpGs9DDBYNhFWRcvG7Sj4j7SBt5JN/XH2fmVgtpH7f61D8PkAqaWaNHGpQs+kXi1+sOZ4MnxJuf
 /zOIKiDGPoZKAsSEGdqyex+2HTLB75/jhV9zuFEuGvmSiuKqxzcRmlnCEWISCx9bd69sRxRs1BI
 iRHFnrgjVB+dcv2drQjF5OCyrAEq4kyJOkbxBObhH3BJ+9iXMDh+riKndzpBO1b4jGfSTODbPhN
 GP4RX0uNVJddehxIO/CLfAKP7GoPsPgCnpJHW4hHAYbDh4ZgJwTKLwAq2LHc5BNx4OcXIRK/Dgg
 2Q6spqi+DdJNQnFq9hS96veA18QxWtlj3kVd+Fdqi7L0tnSlha11bcOwb7tqdQwS7QMilXXeW1n
 YKzQgzz+16S9O86RZr2JI2rdlbcmN/xARGsuaoymtdMGQedW3XKw==
X-Google-Smtp-Source: AGHT+IG7coAzO5EQ5rpXah+tY+kAvGCSnAaUd+JB4z6LRyNNqMA0x3hs/EUMncNXFOa0dbmwe5qFGg==
X-Received: by 2002:a17:907:7f0d:b0:b80:12f5:f6aa with SMTP id
 a640c23a62f3a-b803722927amr1828000066b.56.1766513676313; 
 Tue, 23 Dec 2025 10:14:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 08/18] eal: warn if thread name is truncated
Date: Tue, 23 Dec 2025 10:13:06 -0800
Message-ID: <20251223181418.40834-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..beda7e0c5c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..8b539f8601 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

