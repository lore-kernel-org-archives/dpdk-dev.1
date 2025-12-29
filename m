Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A50E92FD7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD2040689;
	Mon, 29 Dec 2025 23:01:13 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 6ECE040678
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:12 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so10636953a12.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045672;
 x=1767650472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=jNjBm3im8vQsanb1KVnaAd9IwAjWR6pBuQn5DEkuAObTxuyvtOYoYJoV2xTV9BYXgk
 3nqMcpqxnRt8k4rM6+dgbZlCHYunM2dNVizOWz2r39yNZCD5MKLTKflbmktw7A/88WmL
 eiJ8WOZCS0oc2JysocgO1kdr68exjpQkVuu97Vaw9Qk2iAS9GcxxsERqBB/R/FrsCyGh
 PsnYxf9ZEt9WolhS7xapkUsx5LgcEnfYGONDtlH7jTqCn5MgDsPgA3+Eurqj7FBqMkeN
 u3hSX8BfXabyksHKeCrUmXKJzLHjK3TWbnOindkfhfNxNmK0J1PjlDX0Y11NjEzoFfnQ
 YV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045672; x=1767650472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=GatqR0PgKRiU+51koG8g48KHSWjdDfXGFilur/PVcQi8/xGdze5c1bSqV0RfA7guzL
 BGrvNE8+LPWRCcj3X/MoJSLdF+Z4Xsvg909QkxBpfWnUPl4BnMR2gNPVe6LDEGsvwMbA
 KOifqWBp7kv4IBoOsLK5Ak6r3NNOEQASHgNp/5IX0HVafytNaCG+NlI4oLBUqHzhdETS
 k9h8XaTFE2kDJMRyO68p2QcUzvy9vzScDFhU68odAz4NAAQdeveET9/T8VPzq8lRcxYd
 rELO71i4ikV4a93bGFH+PZU8C1y9KMzXJIKTfhg5DTVwXTRHGpCYnEvh+xoNj/A8hk03
 /ovQ==
X-Gm-Message-State: AOJu0YxwHJGThlI4CFIM2mFEaKNvtSkH8hqeMcbcX39MtUNNg2KR94TQ
 Me9g+HmC2MgFghj0LPjHPHFZEJgqe1VVbvhJqNF8ttXhrih+HBIwQNi9kU/SZJ0tobBJ2KosqVe
 nHhY4PB4=
X-Gm-Gg: AY/fxX7fcKKApGvGYu7QZXm3Xj5IoBX8D/hjUBV3XYxfblcf9DapLJLPRz4E4e8rB1Q
 1iRunKlGsiHJZ7ziay3UdnS1WpUiGC0cZrhyO0lkA4JXO95i+kJyyKusKipuZnk7rQexVDCeasg
 uoUJu/VL9RB/VdGKjwbSleiVInjNkuVFclXElaVkXHekdOop6Thcc5FNYm3T8lmdA84eyVraBbG
 ZwYJp02/OzV2pQ0PG6F3+Mp+I6li7QLw4sqB1i7UPmoWiiopX3CloNfHtwiLQVHL8r7wf4i28Ft
 +kbkQ29+5FFrWi8DLScuZ52sZHIIU3ZsaBL6xueDLL4YncMH7Do1qMLl7obGxmYvEetraF0n2SM
 XmdDCic5aaJ0ix/oSg2YQxUzrbJVQrcfPyeBcypgF84F+9cdyH5U/1YfReAo5YU7dXp9EXTmN54
 E98lDG5yfv6sa5/3ioAeRnmVeHd6ke2Dg4OnU2twJhIfgzJhq8Zw==
X-Google-Smtp-Source: AGHT+IF1sJBJVgFQnyPf/V6h8v/NCz6L8p1x2atkG9y2H4EHqCCAh9bo1xg7KoygCbkt+WJSga6pqg==
X-Received: by 2002:a17:907:6ea3:b0:b76:cf68:72a7 with SMTP id
 a640c23a62f3a-b80205ea0e2mr3563452766b.27.1767045671907; 
 Mon, 29 Dec 2025 14:01:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ciara Power <ciara.power@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v10 7/9] test: fix format overflow in cryptodev test
Date: Mon, 29 Dec 2025 13:59:07 -0800
Message-ID: <20251229220053.21981-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

The vdev args buffer could in theory get truncated if there were
lots of sockets or lcores. Handle that by checking return value
of snprintf.

Fixes: 8bfdd8a7f0f1 ("test/crypto: refactor to use sub test suites")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cryptodev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 9bdd357727..bd6a2d3fa6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -17713,8 +17713,16 @@ scheduler_testsuite_setup(void)
 		RTE_LCORE_FOREACH_WORKER(i) {
 			if (worker_core_count > 1)
 				break;
-			snprintf(vdev_args, sizeof(vdev_args),
-					"%s%d", temp_str, i);
+			ret = snprintf(vdev_args, sizeof(vdev_args),
+					   "%s%d", temp_str, i);
+
+			/* If too many args the result will have been truncated */
+			if (ret >= VDEV_ARGS_SIZE) {
+				RTE_LOG(ERR, USER1,
+					"Cryptodev scheduler test vdev arg size exceeded\n");
+				return TEST_FAILED;
+			}
+
 			strcpy(temp_str, vdev_args);
 			strlcat(temp_str, ";", sizeof(temp_str));
 			worker_core_count++;
@@ -17728,8 +17736,14 @@ scheduler_testsuite_setup(void)
 			return TEST_FAILED;
 		}
 		strcpy(temp_str, vdev_args);
-		snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
-				temp_str, socket_id);
+		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
+			       temp_str, socket_id);
+		if (ret >= VDEV_ARGS_SIZE) {
+			RTE_LOG(ERR, USER1,
+				"Cryptodev scheduler test vdev arg size exceeded\n");
+			return TEST_FAILED;
+		}
+
 		RTE_LOG(DEBUG, USER1, "vdev_args: %s\n", vdev_args);
 		nb_devs = rte_cryptodev_device_count_by_driver(
 				rte_cryptodev_driver_id_get(
-- 
2.51.0

