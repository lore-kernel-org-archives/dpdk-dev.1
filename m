Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981ED116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3210C4066D;
	Fri, 28 Nov 2025 23:44:40 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3EEC9402F0
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:35 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ee158187aaso24595621cf.0
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369874;
 x=1764974674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=wrJPWNNVPWC4oDD3u6FVv3Vuq5yRaDQiVML8FwGMn0E+4DFtP8QC+I+e+1edoVuI11
 HO7Q90s7icdQ2SMdYOFTVatcZ5okBDSXEEBkKWWEqQV5QYhQNCsNopPElG1guf03bjV1
 Rv/tIolsyQCB53iM+5qRX8R8uvrKsMrnRKWnK0WFWOdyjH5qtknKvFcorJiv6QdWtMnY
 2v9WkQLoJTNdgcNhRtdavJ0MBZm6RDdMmzzZU8LVRrIkZySOcAJHYADFKC6vX5hEt5fS
 86hf+l+ooxJkvgfzTht5sMFXURrHEzvPTObRJvsykX/eWCdYB3nmYWDKXW0cHk56687x
 dDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369874; x=1764974674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=sl6Z2z39oGYbjHVFnOYU9d6k+Y/znifs4KRkPw14VVfFXH0CfAREl94iFlh2tDUR/a
 Co3c+r9EFBnTFbRnWpP3+uGFSmrQQAwRB0LsfHFIah1/FrvVmVvAbGr/yuJ4QTZ3zkvG
 o0oYkg1gueLpPflibnzOpsqop/iRYnWHtLW+RObZkwawE2n7jR45Nn2g1A5xSzjffWcd
 YSBd7d5jwD5X/VWugG0RwTGTWrKQ3asfLqG+NO51P/pYLzAZfyOEU7SY4pLnXRcwEzTe
 oGXDPwstM1j97Tt1OYH5eLUaj0OoGkdfgxMDwITXUvUo6ADX/J81ZKmcqaH/uhTOsbIc
 bklA==
X-Gm-Message-State: AOJu0YzNuMg7eU9klgf6oOKJEXrKle5hxGibpGSZL810ILNN03MIPH6D
 NoXnikcMXwKKbHS3GaSQQgBRdAMa5k2R6f/u/hUB02vCAZ2RfF6NyUoV7ktz8rFxLDu0ORm2AY+
 hUNll
X-Gm-Gg: ASbGnctMgRz9DZEsQd4II6QuIwKOmdyqwmg4iJx0KJzCS4qp3mVXXDZhobsVlLnV3LI
 dcV3qX5mf70TQsagO8hkjPl0r+4Bpbc1bB+Me/LNw/PIi4fL4FPXFLFOq6b0I3q5D/ySZH4twql
 Q/2YViIgMhJpHsVsV3CnG9ZZatSZ0mrAXQ1JFrK4+oSHfeeUCXO/2tqMIEeQqoYuxAMlz5yr/wT
 4axIYiunJGYafq//pzzV+3zx4m+3xXG6P/bZ2J3tKY9pIh0UmFm60iJlLDJ/lrIDTlbiFhepP2w
 p/dnXDNvf1lZhUj+SQBbyXXGKqNXKHUzqOe/Dcv4m1tACbrBJwxHaVzB5IzG1WK6V71D0YkZ8kX
 UOJ70MBPVBHTRkoMTsbtbJMNyNlhqDt0+zSvw8D/6l3oVDj6hZ6PqH6GbVlDGsUa2MbVU7ZsNu5
 NQfHR02BdG5xA0YA9IE9cy3gDQTeySdJrnfqkgf9Hitup7Jb4WvQ==
X-Google-Smtp-Source: AGHT+IHUA442R6ezRmWXUpeSuwxQHUU0osRs+0cuuj1XAmN8eQxJhYttuywgB1+vqOBGlSynyxYPrQ==
X-Received: by 2002:a05:622a:1394:b0:4ee:1b36:b5b4 with SMTP id
 d75a77b69052e-4ee5883fc8cmr327844321cf.15.1764369874597; 
 Fri, 28 Nov 2025 14:44:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Ciara Power <ciara.power@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v8 07/10] test: fix format overflow in cryptodev test
Date: Fri, 28 Nov 2025 14:42:10 -0800
Message-ID: <20251128224420.195013-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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

