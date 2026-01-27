Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163DD340A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB3840FDE;
	Tue, 27 Jan 2026 17:33:23 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id AD2BC40E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:21 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so5303360f8f.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531601;
 x=1770136401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=Xuy+Xuhou3GHXaRWEeRoCQ8zlTMV/fnJlPjPIgE2vKOkf3ZjGQMsIwd5zc4QAcS/mZ
 haBAnakISU0KE4TcmgJPxhIlc/lqP2ROj8Cw+B0lgeefd0ygQaC1M3mos9He71/hQm5l
 MdhZaG5thUb9dNFnppoXkB4KO3IoSPqxdnAyG+GYOGAlG4nK6FWMolYWrhj/vNs7fv47
 yjzGdEIv4DObKLengDk2K0RcPLIHn9iahDGFomi43OczyCdrp9aSN+1vYS0bT34UM7RM
 VFZAlWm2MyS4oJ37L1j+OMIli0Q4CSs+YjZL/hCeEgsvfaNrEN8NWw5UVqmenYsXs98Z
 jOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531601; x=1770136401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=bwnLWqywggaFd1Sj1FeArhn6+wnPAivqNuE7TJY0P0wI3UogJw9Udf8owlrm/rR3OZ
 s+fF9PuPepzRDOO7FU6RPmyM450+Jpje16Rf5+6uloTZpPInLlXWpHyyxE2M3+yDv3Dx
 G9xFt55CWAs9DNShEfK/6628oBgVb2G63ona08gVHxE9kS6MqOzgPspMtv2ENFsq8wmz
 a8JRULbH9PtYvYcTO0i/fGL0Xj8E0wzDRMNCtxaB0vZS7CIHVweZM79xnLDOJSjTUmTG
 d7LQ2C/xKqmVCwv1ZZxR5+VVLNi+TzH0Ar2UcjmOzrz+haPst07SpHoQjHrem4kD3D/f
 KAYQ==
X-Gm-Message-State: AOJu0YwsU7hwkC+Adlgwl3aKK1QmMmOCI0v0xSOltleM+uFeQ5d4TxdW
 Nj+zFSFlHGn3TDpO6JP7rJ5rqAd5x1OME02P4Bn93kz8bPbIsKGLgTbGJoXg2HvsJbGjINpPa6u
 BGqKp
X-Gm-Gg: AZuq6aJKuZnR/Tz5XNrVFaGtMpWVMf+OYqTy8Bq436y5eT5Gt24HX5v1w06MQ6SAPYn
 KIs8wW1RB91ke4wgQXn4Y/BOauHKjjkO5WjzEa+qUST8qfgYPSxZIzumTGp7T11z9UlOd8pVNJe
 FYYBSMpjy/2x54KPE+hoe9cqJZuexYqoSjOBOeCbwZ+jFO/7HlQFkSu4pUYdaxFmp9SBtGTuh8G
 bqOnJEFTBLWSgMwQEgOYgDys0MNILmPbEDIQYx2XYPRqqkFMd5RRQLrOoEOmZP7V/owqv2Te07F
 sBoVrL14c4Zo/1e8ATTLVhxG3PYcHhZFuCL/+u/7lhJL//lHNNNCU8swC8qOwOr2qI2Q2M5LBxc
 VePlZRt9edigFLdlcEBrHKKmnyyMqtOkTeppY8krlFYYphtmgnvjpY9adlUbDP3PndmSOQN0jy+
 3yWCb1C2u8Pu/1LDXuM6OPbdDPtXezjx5KxHhHYzbyy04qyziouA==
X-Received: by 2002:a05:6000:290f:b0:432:7068:18a with SMTP id
 ffacd0b85a97d-435dd032b79mr3905692f8f.20.1769531601179; 
 Tue, 27 Jan 2026 08:33:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v13 08/17] eal: warn if thread name is truncated
Date: Tue, 27 Jan 2026 08:30:22 -0800
Message-ID: <20260127163258.75566-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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
index 6215245ad5..60f5e676a8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
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
index 21fe7cb1d9..f06375a624 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

