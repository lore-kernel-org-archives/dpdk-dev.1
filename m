Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01368C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55BB042F05;
	Sat, 17 Jan 2026 03:38:37 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id AD7C642F15
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:35 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so345254366b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617515;
 x=1769222315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L94o++XYmppN/uOGPmSYyzqre8GCLglOjy8jI0F6OzQ=;
 b=YQNR+Al2fS96c1NmXEWkGEhYFSpNSf8VuyeVf1q21y/5d7+eFDXDdJ7TXq69UePTdX
 S3i//NV1xIacUe6LVA+fj6F8cCgRbN8eJ0SZSoHiutRVWcxO6qzNV2SdDiy6612jiNc5
 53gUC7ii4VncyQ/hGNQKD35NbtHxBwf4MivrlV1KR50kS7L/8+I0h+75m0s2jo7SfS8e
 Y+dBXmM6wprLscYSQT1wzhtvOGEG4Us+MyfQOgXNXfTSWJewyxi8bMG8sksEXrdwFJE9
 F8w5/WwXddSwN8AYV/nSNO7tvJPxyDTk6YyapCyXGA5lpi2QLQSa/Yidj7PO8q+jCgz7
 Ksrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617515; x=1769222315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L94o++XYmppN/uOGPmSYyzqre8GCLglOjy8jI0F6OzQ=;
 b=mqtWc7CA469LKQilhRSSV11tB3SB6gV5eVGmLfV7RjbThWaIASFXvqp7GPfcQmGyVW
 xhrN/fc+5Ld4DLhMJ2f4XzCSoo/aYZm7YM+J7kqowAyR/UdP2mi5Nq46AfeTFpEQCxh1
 h4Zp0jpZxGP5+P6NzpEnIDRY8yMIuROg77WAn1yqguiwQ48EP93ew/73L3cToGUenFRb
 tJYHcm2FeP4PxnBZmdF6YPY0SXwI5FMSvB6ao5yh9pHI4OVm4/2zqxOx3tFq/jmkAEVW
 Ju5v+DwdSnrkU4EnBr9JCumUK8vJmHJGKUsI0mK6O24JRMCkWMYDdiUhs0LPZ7PM8NQW
 Ir8w==
X-Gm-Message-State: AOJu0YzDqxuSQkoLx7RvWpSlA4FNo1Dis1+lBZZTRB7aIJK6N2CJQhYv
 TYMCK55hz/JxGbLvxU8OD/P+1rhIcFtX8zvvl9rl8UB/cdHOsXsurAawRyshlFdhoitcqjoM0O8
 TXYNI
X-Gm-Gg: AY/fxX57DohpmmSqgV8TS/NsOSAcSahonshSknF7zx5bWyNvxTPJkUjpPCvZ6CVZ33I
 EdRshgYhdDFu51zauF+kJy6vCZaN80YiH+DjdTX2EySd8TQKOOUm1Be15ca9bG4upEWReOeDwg0
 5somYT5ChkrMn1bzR3bMvleK2YS/8uoe+phE79kXVh1dVmqcxT8h7H945RtCJSZ6Umihhtoxgon
 pA8OLFfNPSyOFHjsYf9wRsWZekncZNY2X9XuuSV+EHMmJxfEyKdrnQTvpRsoGLSWUjmX+1HAcLx
 2KZM9RnSSh/wzNWUT8zNl30YNVvUokvf741rYkbN+F53CpMXp1Kr6dsk5AKBmhP4EdGOi/WhCOh
 MAdJVIYsMzh4h+BYSV9nW9wAy9DZyuUnwPDZId2LAxssivwFoMYPUOoCYir7ZVEfwQsq+DNUTsk
 Nn8X/pWl0ZsOBxjprtTpsMjtd8DnzEMoVG5gyN4X5HQ5qLuO/bhQ==
X-Received: by 2002:a17:906:ee88:b0:b87:19af:3e4d with SMTP id
 a640c23a62f3a-b8792e0f4c7mr444250366b.22.1768617515212; 
 Fri, 16 Jan 2026 18:38:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Ciara Power <ciara.power@intel.com>
Subject: [PATCH v11 6/6] test: fix format overflow in cryptodev test
Date: Fri, 16 Jan 2026 18:37:01 -0800
Message-ID: <20260117023817.196694-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117023817.196694-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260117023817.196694-1-stephen@networkplumber.org>
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
Cc: stable@dpdk.org

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

