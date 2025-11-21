Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1BCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3ABB4065F;
	Fri, 21 Nov 2025 18:10:06 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id CEDBD4042C
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:58 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b98983bae80so1904529a12.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744998;
 x=1764349798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=R8Jgeon0Kvaao9Hb3TpsFuGN64wGWw/gZDIDZ0qd5VO6zPRm+70KvQFkjamlb3zlPC
 1365BjEEY1L2Asj1mu4o9nsa2h5KuRebPbv1/hFgWJmQQn8ZtSi9vQkCCIASi9CY3+wc
 lUfhy37wnYN4bhNznwAoe1yh5SSqi15t0u4o3MpL3hD/1xOJT8bEdLY/HUatTnDU4wK4
 RmbtpJjZnUb2OGYCvfjV9CxkriD/NBgty/+rDUuyM+mpYqydlBZCzmxf1ZZFky/cEvjZ
 mlUI47zWNfYVZ0l9Zlb9sJNHt1QRYoWdFPS2VRplNq7zAmax06P+YhPt08quHKk/jNbL
 sEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744998; x=1764349798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=m4plR/ioU0ag+eStGyU5++p/5U1oSNECq4CbannxUGz4nvdWB1AfptEM2Tj9lnyONi
 zVt9Jpm8D8YUgzYRh3iRFaiYgMd/KG/L/T3n6FcQSteRqmsOOygqwFamLxFlmAdTxoJE
 5HE4WcIWq4PqER6JknpUqVlIibOfy5ffH+JbgRqm43Tsq49Tt9MUcepChshcuh3KD8Ff
 HDtf0vfeUQNDStRw2Grig3QUDB3nUEwZ8eGj4K7Asz5AyFTRB8u1bWa3LHg0vNuruPF7
 8Vq7YF6LYz70UrQGamyeYryH+bNeE313qAQ9AD4Z9UGo2mGItLUvOrwsx3WvzE5ryRns
 4//g==
X-Gm-Message-State: AOJu0YyEnnxRccRolj5LKbnt3a6tDrCeAqEMOpz3bM8h1rwSK4gC00x4
 20hXJQKb0xsEGMxFqB3FBR2nO0BnQcLsa6/lEYoejYhH4YI5nm6u5mNW4xajf/Sd8KaRIjS7SqL
 gBb61
X-Gm-Gg: ASbGnctHl0QlVgM8IR+0CCUrONKhAElV4qQ8yUUlNsBcPkYz4Kwj1hTwsRpidKe9c6O
 iNZTcSdMqP1frwUsjFcF/lykE9zXBj2i5BCMHx6dHCtMgG0Oa4FJ9lO1wm2oMYBryXfpiejH2pV
 Kfioe/JzFS19VAJsl7pv6KYy5KnWNMHRtjonwGaWEyn9J2Xnz1brTxjp5K8Hh8CDuEKX3cG4xtF
 Z5S0+cMPSpQM54MwXjrkGiG41CT/LKrP2coZCuIHQlbsHbDZ/2n7qsPygGac7Ss/R5rRNBmLt0S
 cIkphlc8g3yn18d0zdLqyd2KA9SyH/8Iqev3kfKgXmzpiWZIyE4OYntV0vZfvk6ScU/o0nQU3q6
 SxfNsxWlV8jhG/ZM2hOrq0lrFHwcA8Xu2cfJ4FLjr6QE5LCT7unf5DbItl8rEzViHeJIJf6Pwpp
 +sqtT5YFTJegl4hqBvcQu6/201yNMtkBxMSG+P3xvsNz0nw+BVcw==
X-Google-Smtp-Source: AGHT+IEXHmIUzE82eIPRypeIFTJmXjHH3Uzrje2Lhg+6nPrHXH4QZzN9ha1rsaVd5EyTX7jcbGL5dg==
X-Received: by 2002:a05:7300:ce90:b0:2a4:61a1:c0d5 with SMTP id
 5a478bee46e88-2a719fe5c5bmr962908eec.36.1763744997792; 
 Fri, 21 Nov 2025 09:09:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Ciara Power <ciara.power@intel.com>
Subject: [PATCH v5 7/8] test: fix format overflow in cryptodev test
Date: Fri, 21 Nov 2025 09:08:26 -0800
Message-ID: <20251121170947.134502-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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

