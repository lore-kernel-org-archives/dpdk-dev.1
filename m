Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0075C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 15:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3687402EE;
	Tue, 15 Jul 2025 17:07:27 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 348B34028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 17:07:27 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ab71ac933eso15735211cf.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752592046;
 x=1753196846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1frnzNWbQ4OxCHWIZ++4eSQbV2wi+B+S8/8qwiihmVk=;
 b=a6ocXqOmGT7DjFkadNrZsBdlPX7o53di+Tdaty810BbRZyHoMloET88A2wfpK5YE9d
 88emfmIwrDADnkgivdtVw+cu/gW70ZVZFlqZLY4kWMIYlE/PBKo9024bjMfOkW1W7jUU
 smnmLbhBcL5BCBAhhXmpAMZowye1TWh+pJwBChmMUiPMDC9W//tKZ7LeziW5FHFkNI1D
 oMFVQnwKJHSdYDoM4OJJCsU0I2X9HVbLm1kALcSDBkun9DtqjcGlzizyNbWtjNWZCCNb
 4cWOyncaZbRj5XHZ54uUYiGWQ0UARz2l+1KUomHNMt30+z3ytBoLYGJx/Lgj9wHE0ELf
 1SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752592046; x=1753196846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1frnzNWbQ4OxCHWIZ++4eSQbV2wi+B+S8/8qwiihmVk=;
 b=UDvX2vTJ6cXai/5BY6VdODt2KCyUVmnbHfjC3PghHQTTcDI8Uq6iymLAUHormRitNY
 ZqKLAqn4uvwxxuZnZrc7HfQo4u+hf6YznhlGzcJdE5Hhu2AUdB+a0NSa+DsIt72tJ1BJ
 PWEntsVvCOAiscEvewBJFgZbOoh0XzqTVfixjYC81l4LYuAKQt9pS/btCmgmrA33ORLN
 UIVG81YUC+sKD3UFhyutU53NWFM6Yz0YwOGtfYiTMgmnKxRA71+fIu+o3jyAuDnkj0aa
 DY93Eu/jmyvquW3G77DG33BfcTiuvIo6fTpcn7iE96NAW0dDN8eu9Z7ThQwf5Q/sgC5d
 lZ6w==
X-Gm-Message-State: AOJu0YzMdRe1kfYgjxZQWA8XJISBCpCs/b1ugIlkKWSiKsV29suq1px4
 2vBytQJJEK5270enOx9HsEIo8eEnv2Prvyff/S/b7SZE/TLpWZ3n1wBN7q16gLIrfTN75U6qmuL
 KsPv/
X-Gm-Gg: ASbGncvqERJngdW/Qnu/bLS3Tzbd9Hd1QAi+FarIL9mdkf+z7BrSI+udSIFnOhIkJOH
 lVWHiWBk7LxQ96A1XdIesBZlTRb9MMEVT11eqH8V06+GjBdhfOX4LtRHAYd1Rhd3KYFejLZ1e4A
 RcEtxULJgVfjp7trvEcnCRdTOWXhCV1ZhtEVw9sJ4knlbXc0yPOSFizNyFvdBN0FvUDyNZlIBe9
 VB++projPHHGZCpDp4N01HMCln1J3B5b6szCPgMroK/0IGGQUUiwC+1yC6fxDy6AJYF3dRWlIho
 q9/jg5qhMvc+IxFPufGGHN6dWyycTNZEcLb2gP7BSUSWDpV/i3Xrs3JaR6jZE83CyteK3H+Sp9H
 dZA83xDJjInWXmLKeHoYqyF0qJCyMSNgBJ3GNjqOlAZFRb6Wk/g9SG9/b+2+89dQj6pEfJadf
X-Google-Smtp-Source: AGHT+IG+yprOOZSnvBRixrfVEU/VD1rR8Cz2nXXT4U7VSJunFbYTsqiw1CZ7sl20H5ZhbDsXAzfE0g==
X-Received: by 2002:a05:622a:903:b0:4a7:5c3f:7db3 with SMTP id
 d75a77b69052e-4ab7e1b7dadmr65769771cf.2.1752592046413; 
 Tue, 15 Jul 2025 08:07:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab3a1ceae0sm44633741cf.25.2025.07.15.08.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 08:07:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] latencystats: make errors visible
Date: Tue, 15 Jul 2025 08:06:46 -0700
Message-ID: <20250715150722.39575-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This is attempt to get more info from latencystats test failures.
When updating stats fails print message with ERR priority
so it is not hidden. When updating stats fails in the test
print the error code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_latencystats.c        | 3 ++-
 lib/latencystats/rte_latencystats.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index 676a99d385..cdfc033b59 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -49,7 +49,8 @@ static int test_latency_update(void)
 	int ret = 0;
 
 	ret = rte_latencystats_update();
-	TEST_ASSERT(ret >= 0, "Test Failed: rte_latencystats_update failed");
+	TEST_ASSERT(ret >= 0, "Test Failed: rte_latencystats_update failed: %d (%s)",
+		    ret, strerror(-ret));
 
 	return TEST_SUCCESS;
 }
diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..1ce94fc5e5 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -129,7 +129,7 @@ rte_latencystats_update(void)
 					latency_stats_index,
 					values, NUM_LATENCY_STATS);
 	if (ret < 0)
-		LATENCY_STATS_LOG(INFO, "Failed to push the stats");
+		LATENCY_STATS_LOG(ERR, "Failed to push the stats");
 
 	return ret;
 }
-- 
2.47.2

