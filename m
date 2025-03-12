Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C4CC28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6971E40E1B;
	Thu, 13 Mar 2025 00:17:32 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 44B0740E13
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:29 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22398e09e39so6790525ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821448;
 x=1742426248; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIymjlf9IFwgNDgb7kCJ/Em22h1cXz+zQcmRaHaRicg=;
 b=ObHa480YgqaG1MOkbiUbPvcQMxylFE3ssTrfKKKc5ICKPrYBYGcyJVn5u2oSO6q4fe
 y5/j1Q6G7vEmtfoZujIVyLMumhO9b2Qofqag0xTX4wEpIf9wQA75AJSCYYdb96kmGjJt
 rXkycSaFDsKWom+Ju08aC70rPEOF/pf2BefsABaT2MWauRz94QQQ9LvSEdJ7/Af7pQ21
 8WJv4BaI01/bKdvieINmQVJs9HIK8xeNic7rRSW45hGI3cwNnVxPT2cP9J5M7/zjwbyK
 ShhYgBtW9kPw/LEjxNHDlC8/JjLmHVo4+Rifo6BE9loYIHVct0BU/xVj1o3hfOUU0zya
 8Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821448; x=1742426248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIymjlf9IFwgNDgb7kCJ/Em22h1cXz+zQcmRaHaRicg=;
 b=g4PBPyQW/9E8wArZD3R9+Y0xyNjvL1nilpaRIrQZtQTELbLJubADK9i4IKd8xMps04
 vaDYu2MJ9JngliZxkUCPYK6apKs1p3GKc26RevZ6oEODY4Mi7fzmx82Rexa4oLJZFAU0
 5HjhJVkZD2hgGpUsmQaG1FFgDWqimmG911w5Zim2b/P0v8s/+UkQvBQGxMhdk3Qmq01d
 Z2j4RAtNLOaab1aYC8teG7bPXNBvjMUNDWjcaLIz9MV2CLfnSINhHSXqZ1McLmBFsQYK
 cZrhgcGX4afzlCklAYFQnAQkeJBvCBpIcgGj5xqbYAV7PWIbe1YD33qGza01580tN3o1
 /Eug==
X-Gm-Message-State: AOJu0Yz1egLqIu9dYaF8AvhjCuySOKTrA22Op0vyruNUAUwyoQ3cIbD/
 gz54WohtI+e8xvOyaJi0y+F0PghynSBHz1SLrjF4rxksXqjBIsrTClwtzFvwa+0nPEBTNQSf1Sp
 0
X-Gm-Gg: ASbGncuFnwLJE+NTp9bsqg8j/HVnaLM0eDhD33xt4ilW4F2hw7l/vffiEAvxh8vHpIC
 3UWlb6JrkEFLFlua9pKZkxHdAzLdayP3Doe3KRQpC/FBY8X+REDBRaCTU/aEZN4EXzkRN8ldxcm
 P/7G6fTru08tiYheahEM2L/mejDL+y43mprpQUWHC+u3/ApPUIBYlY4A0Ndn7mPfihjV2H06IKv
 ipG+4drT4HvQBIaaTY8NYRL4a6XQ6gYQMDPClfs95CN3gDeBhsnRVkGb8w1w4v6UxObWWymNyR2
 VTFdDaphMcTMqmxwt5zlz+3RH/3LKjFV9DMnHCOjrfsqUkNCauhFqaNVw6ecNZCJtNNIVfr/gBc
 I8lc10766iM10Nc4KLrvx8g==
X-Google-Smtp-Source: AGHT+IE4xRMBm3h1ps/otqGhpUmIOt33XWhMyFWHytZB6pBJGOSOKv1by2rhvSVMwp1bWlQlI2NN9w==
X-Received: by 2002:a17:902:ce0a:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22428c075e3mr404038405ad.40.1741821448441; 
 Wed, 12 Mar 2025 16:17:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shreyansh.jain@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 3/9] bus/fslmc: fix use after free
Date: Wed, 12 Mar 2025 16:15:32 -0700
Message-ID: <20250312231715.222149-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

The cleanup loop would deference the dpio_dev after freeing.
Use TAILQ_FOREACH_SAFE to fix that.
Found by building with sanitizer undefined flag.

Fixes: e55d0494ab98 ("bus/fslmc: support secondary process")
Cc: shreyansh.jain@nxp.com
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2dfcf7a498..6ae15c2054 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -15,7 +15,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -27,6 +26,7 @@
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
+#include <rte_queue.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
@@ -403,6 +403,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	struct dpaa2_dpio_dev *dpio_tmp;
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info)};
 	struct qbman_swp_desc p_des;
 	struct dpio_attr attr;
@@ -588,7 +589,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	rte_free(dpio_dev);
 
 	/* For each element in the list, cleanup */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+	TAILQ_FOREACH_SAFE(dpio_dev, &dpio_dev_list, next, dpio_tmp) {
 		if (dpio_dev->dpio) {
 			dpio_disable(dpio_dev->dpio, CMD_PRI_LOW,
 				dpio_dev->token);
-- 
2.47.2

