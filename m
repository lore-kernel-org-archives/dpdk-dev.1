Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DAD46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E95BB406B6;
	Thu, 29 Jan 2026 02:43:36 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 58D504067D
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:36 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so4387885e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651016;
 x=1770255816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=td/XvmolIKah+7E1LjZe17Yn2RiGZMWf3dHoatY5av4nJ8wkQnAPGRWfDOPYSGNTKq
 RUNSSKWpP8GCmhVWnszj8GRva+rFsL/9twne3QMqGjmPVUPfr7Yz7JgSHyJSvPAGbJ14
 dDLDNRM6fjG/SjRpvKQM0FYjYsENFYFYqT3rbgriyC/v7uBkNX7C36PiffBMuw+dqNvo
 ByYtr8wLdvOgjH+miiGwE013d/UuNJPQnXfrH/BI8WlkaA6ROcBC/gIWoAwspgEHiWOS
 Ll243//ROWrhAlScXa0Etz32vwC1SUGRE3HwQySbkNCGV1ISwEZkHw4yrbTl8I/7Kiec
 XjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651016; x=1770255816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=bR5MuSksL0g3CBcUt6FyqrRAk7IKUxpftKMPO4w8ZTWiAlhXOaT+qAvR7P9ygXhcMQ
 EG2o4iG2+sOheEdf9umfnpLuykHrrUZTAT1JHDz9g5LD7JX01ZCnbhwmXMspjx7uWo+m
 NkJT1f9i5O61KoZKx9BdBKUUAUpOfuWFahvbMhHNKcOqOExGW6p5PIOe51Aw44BaJhca
 9rK1C5l2uFpc5XW76Pg8UjXv1MfS6rCJsu3zLoHxnPzgc4Gueo20D+7vStEWi6HuVfSG
 MBNnPSI/Yip9nCmpqTdU1TZ0j094TUtBTXhs8GWbqU08DF1/15R9KXwqlZSfLJ9ONVS5
 caow==
X-Gm-Message-State: AOJu0YyG7KWUaNRv7UBGjm9eFGejvx7IfOtAcszUhBE9biJBF2SWQ0Jx
 GBu9rgUPbpIqL5v7Ed6WLGBA8CFJWo+rHI9yisReKhSJj8xbGB0NQroneiI/FGGit1jbHoEGQiT
 uGxSg
X-Gm-Gg: AZuq6aIMq9a8EJt0P4a2BvwSV6IY/kp4CWLruY4jKOrvnciiuvGxs8ZOzwEh3X0N6rT
 SU4+ABpUN3weeRwAL94+6MgR3rfyT+EM9Yxfng0F9BsM+AX5YesVyW95gkiIdqKB+iGwnCxn41h
 LKwL0PMhnx2jzf9qjFx1nL2ZMYaxXLGjRk5n8/ORjkN147wXsy8sjX3lkfNWdQhaEsMHZ5gWQZd
 Vo0WRfFfD4UjhC6Qblb/fUWnCJBop39pnNiFht/0fL+EnXQVWNsyfvh5bRv1oKAnwpCY74DwZWN
 jNxzIvLeLEKDeUQt58wguQFEVl4jt/4yTZeHCE5N4ntn4XBJXSDelO5QWG0XaTw5c8havoz8ppn
 UWg99HcpbvF+0LFjPKXriQfKopUNNp61iu2VU+OlJAW/41j97t1jPh0b5cbTD7kbLJOjie+C8/V
 CSdFUkjCVOcAS9jKPvuNE8efHjtLqbEpkHvG9qL2ROnz5DAs/Ssg==
X-Received: by 2002:a05:600c:35d1:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-48069c5fe57mr90515125e9.25.1769651015946; 
 Wed, 28 Jan 2026 17:43:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v14 08/17] eal: warn if thread name is truncated
Date: Wed, 28 Jan 2026 17:41:11 -0800
Message-ID: <20260129014313.939831-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

