Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77702CF9C51
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B189640665;
	Thu, 20 Nov 2025 17:57:29 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6A14440651
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:26 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2980d9b7df5so14554815ad.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657845;
 x=1764262645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZCEgpSgSzYrHwKms6F3jdJNEiK7RZbWagLb3Zf6u3E=;
 b=eN1ZbhQk2BNW1L1GNKRNcPMfpex69QohAB33Znw4COjZoNeCoDol2MJWKD0NlAulRE
 L1XaGVcVTeDmPtpys3g7r5kP4GfxoxDLLHr6q1T0O2GiFiaHvNgRvdcWoqmvGxrG+tra
 ZHXVz4KzfxDjKd6BbyrmlsZklOu4adjVFPM0stAvOUY+D/Gn8Ocz0FHQBZZi3kjGk97Y
 MkAmsjN1TkFbpGcbaqgXrDsKql4dWyUa3rhyLKrmC/YNVi0QcF2WfezYQ+iRrsaNuuIQ
 Xua6cGiFImP9TNOVnkKizqi1qXYQ6PIOOA6Z92oG8It6Cvh8HIZYWc8rwuDmJJLAGW0B
 dfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657845; x=1764262645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ZCEgpSgSzYrHwKms6F3jdJNEiK7RZbWagLb3Zf6u3E=;
 b=G7cJcoIR/5RMw5E6phVcg/pIw01VfMqgKwF9W7Q34mAfmqanM7cZ3RxYh7B53KCH8I
 32AIdLsUSweQap4xb3Ppd+MP9kaAooC0mx+vuiNeMk2bZVy9+kp18CUuk//6i0/5Se5b
 FtnpP9Rcq1ayX1vBkkRa+wRg4NGRFxvAAP4DQetUZ137f5eK8SYNeZlDiKS3i6Nn+p8x
 Dx3lQsgJTEbNzmwCPyFloZLWpD31yUfM67QIjn4DXLP6+boeJmJtJNE0pF8nbU3TtJoh
 LzpAqWC74b/aAgkMvS08uPpWqYM+J57mfQmIWg2T28kXFYpp29BissPZhb87HsKdtSNh
 6XHQ==
X-Gm-Message-State: AOJu0YyPqJk6dSxTHGXDttPg/KIa2dwiA03CH5R6Z3EhFnPIoiivexOf
 QkUjnM3UznOaRp0qtGG4sii/1qATIl2bGCGPAsCiqkUcxZzBk5pZ/k1U0gPEjvd81v4pfGtNLdo
 FZrsA
X-Gm-Gg: ASbGncvcRNY8i+JShA/S45/1sVegt0iFOCpDDMnvk+xU00NuY9I40mlWjR+1JLI+WCf
 KBdYiEK/nlhfwfkTTK3h7H2Hgr2RVNiaTpo20j4knz/Dwo2NII5t0T4nFc0ofNUXk6zC+NJoLr8
 g7V15KsXOe6tm7Lkg15byFNn/uVEa7TRgHyTDRsURpSWtE15MGzJUwwEUikugNvJZ7ETElCYiCE
 k4NLHGlg94xACmVM4MaH9DuzQD5CeVLNGAIddEw+Dt5++oJI9uy1BhYrdFup9Mefant8EKEUydj
 80PivVFWtNzo83Fx69r6WjBBO9J448fcV/1H9MRqQ8hsqnm4guhJKwVRxz/s///EO2JEkxOVq0c
 FZLIv5jGk701DU6ZdSX8X8KB4H9ctnDICXPRPkrgIli362KLSvhu9WHm7orL9jaK3/XD6fRF4no
 D2lEm8tPqUjHJtMvm6iXYLQlORHCpCs8obzPcr0Z+madwNgvNR2nLb5Gn1tmua
X-Google-Smtp-Source: AGHT+IFXFhm+RmUCq9ep2zQv+vbTMaylJ6lUIZOyL+hNcu5bHDsfBLwrrYHbHcZLF0ugWtjU9M7PDA==
X-Received: by 2002:a05:7022:660a:b0:11a:335d:80d3 with SMTP id
 a92af1059eb24-11c947dcffamr1435457c88.22.1763657845288; 
 Thu, 20 Nov 2025 08:57:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Ciara Power <ciara.power@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v4 7/8] test: fix format overflow in cryptodev test
Date: Thu, 20 Nov 2025 08:55:35 -0800
Message-ID: <20251120165713.120238-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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

