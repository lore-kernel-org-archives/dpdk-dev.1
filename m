Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B8D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2D544067B;
	Mon,  1 Dec 2025 23:04:37 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4229840673
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:36 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b2dcdde65bso679342185a.0
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626675;
 x=1765231475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=Xmcll48fJy7Ksz98bP8bOp6w2KPQBNxqqZmFhCO04lLdjrcsKExptJRwjupI1mlgGe
 9Npc567rSHEAUvQygPjnWAzZH+nLhpVGDLnq53o3fSkowiPnuojaD2rPk/nswJs+uyms
 d/OtBgwQ5X9K+0gOPNuan4mks6OWfEBT04KV+0R1Xx6ZQo//4gIvQPUQGIT3UWD1zD1Q
 73VT4WSqoswFaEiLKKeTd+99m3lmrpIWIYhR8G2/DodZQLi1VW71bKdKQMDuFRzd/IX9
 j6lmOWjDT+azyCIQVt4pUxqGWO+2M7CwmOuv+bMXSZxlELS1N6yUFMk5ctzoeA1J9eL2
 Xndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626675; x=1765231475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=js+GsS5Mmos/04W9AnE3hNssA1HVpAvfWdnNmpfi6t2PDLX8VijELYPFTZpnwrkPZn
 zf2yJMm/ZVG9hAy69WZTnm85pb8/JDZmPzLmeOJvpy3ylrvqLTlkv9KliinCWw67HxXm
 0cHShC3m0UQzH9c56urz5XSJtwAhy5cSEluooYjOiY0uuVK8h75YtUjJXQK3bpS+0YWP
 PEET/VOnaLRgUsdbK6GL00HWSrVyRYcgs/MFlQ/63M69T2yhv+AzEVACnfetwiENUiAs
 j5V2iB5eiesnTfimS8Nd7/g2cXoW5X7pvBuegKGZjf5VbfdCTGyNtBFuxynrYktRT1G8
 c4FQ==
X-Gm-Message-State: AOJu0YxZOTfwS0LhKtRUKoS1EDFMFeg0so3PpffhQ3tVmFTccyZTe6Da
 J1unHO++sxkkQRbs3ldO8VQbFmSsc/8LyBMJhMNTaXjZ/bNr6UsCLBpIii2O6kOIeq17RsM325S
 fu73b
X-Gm-Gg: ASbGncvymhTjZ3ATIB63Oqn1Dw5H7d6Id354FMJxo324nHzJsybTTo7HvcxiRUCuy5n
 CNWVrJYQ9zP37sZZtd1sAJpGJCPiaSoIJ09IDy89gjkibn76y4A7XkkuabWLSI9MjxvH0WR/2fG
 2EttXQUfchQqP/QLFnqjwqNAPxekJVxxTjGpT0Aq8+1bWerU8e/+Zr6tBNOjwI3E512euhwbpVm
 V8lUorU9Ifk1le0JdGrYkoDfwDkmAeNQi/CjPI590FOBjgMbjYLt/H5KMT5wbSx9+e4OYRjinof
 uDNbmir+Lh/12B98GKxDI5zMJgoB4k+8nVtj5iCYVr7UfGzTuwwF6JGyFSrl5p6ul4tKML0axAa
 +Vg/d//14YYHclSQt65klFTTgfOqsnWOhLx9jFxvaM5Ux3tMPCX8Ty9KZwzGOTpnENmlyoamq4j
 11WE3FmAAKojeIDy0rQPgCdQ6gwnqV93wm+W0swvfUFSjAHkDP9GTj5PMH4Me0
X-Google-Smtp-Source: AGHT+IEn0S8kzQLPZIx08pGzufxNe6CpiulHF9cIS5lrZws7uS19hHMg6WkqmVx6q32ENR0W3NqEgg==
X-Received: by 2002:a05:620a:3f85:b0:8b2:d7b8:f3b0 with SMTP id
 af79cd13be357-8b4ebdcbc14mr3877466985a.86.1764626675424; 
 Mon, 01 Dec 2025 14:04:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Ciara Power <ciara.power@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v9 7/9] test: fix format overflow in cryptodev test
Date: Mon,  1 Dec 2025 14:02:05 -0800
Message-ID: <20251201220421.207285-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

