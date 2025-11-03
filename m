Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C67CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11B140676;
	Mon,  3 Nov 2025 17:49:30 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id D810040658
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:27 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-78118e163e5so4577088b3a.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188567;
 x=1762793367; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MahEuFvHuyx9J78HDyZMC1hFASJOucr92lDu49v54AQ=;
 b=rLKbLkO2Z9qJsHvmp1KOhcIPzvQewmjzSTLtQKtZu7M7RZfmnL3vfs5NMBDQcekClU
 NSQqbgpysnltaou4umPwq4uvBV3yImQKOqiSTZDApm6+O5nbH3yhPBS27N7pGdBpmIQY
 WVLcAFaV4Pz4AbRhcirdvBVLpON3UsdLjYQNahyVyd3EgqhHQcysLs1y/I0I+OhX6qco
 PZX30UDXPKqrgHijscQXRuCFmaQnI7UyG09VPxGwL423PTfzeXBrKe/YvDaUgzwRI50d
 aWuO/HGFVGMFibc+W6G4Vi/lomA4FvaPjC42TX0Ovt6h0862UX13fHYrvxKkZXhmfOUt
 6v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188567; x=1762793367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MahEuFvHuyx9J78HDyZMC1hFASJOucr92lDu49v54AQ=;
 b=vUXQerpt8TU60XyOsnfU42B+xfjHNLHM9qTPzqyJncTFkX9AGDIxLIwtWvUXFqfL20
 0Au/AU9EOBGryhCq+EnCTVc/mcxzkze6Bq0dfzaDUPCClcAVFlYURTpye5ADbVIiN2ah
 p0qdGYC5BXCEJE9iGSDB0ect0dkZnuWHYvyMbAXenCCesvxWt47HWEtua5fyBESyLYjJ
 5cFZPC3C2oHxhfG3YUbkZXbdjcUp7ECZshpzgEMFgwG+jQyOGWrLe1sOgrecJ+0bfhlE
 YmV3bgCMJz2QX6yzJxB5O5YjDr7AfUzods4+9mDyRtyPyBwxOYGUP+b1e17o+uFdm/0C
 7MCQ==
X-Gm-Message-State: AOJu0YytXsb4qgtNV6P+nD//6ulUAgNKxkTEmSTsGFfiTUj8bWSoCiUU
 UFNWJxZKsO2uzu0K4KiqG5TsFhVDXqFtSRNMqQJ4YHYuSRRp0CXOW8WtnM0V/1oHASuFkjSXU5J
 +av8S
X-Gm-Gg: ASbGncvaI7e9q4eR99fDK0GRS7J+15OmvUtNXdKOWr/7yeiMxbwleBTBclsh8spR3UZ
 MAV3bRYJ4aDo8ipUWX8pCHdtaLVpNxdvQ+/9O9H/WEF66bHOvB4TBAdKxLUv9boalp0bTjwuC4B
 bmU2WoBnlBgKNmzDznONeOER8W0HAhuz32eyG67X1QqL3wh9Bvj/XZj+p1BcWc0jM1QAHwQUoqB
 NWtHeyGoIgt4D4MO8+M9ia/jI+Ul3t+MK5sWMxNiRmkQngxMNutSmHO1FCbzf5UD6pSC/EOoOOC
 XqSDinq69WqtLdyiwY0dj3yUA6OZGGNJruKDIOWN48qiLMH3xUOfMxCZVF22J7jBbcyIQS6TRcl
 O3xUQwaWnrRDuCjG0lZbBo5HqdjbOthRS80huxhz2S9v9sKsNfDzv8WYl5pbnTyLXc5AI/+Dfd1
 CZ+bkqMH8rJZtBtm8MHSwFqP97girJvGk3O/S6QmRdHWbmx3yZug==
X-Google-Smtp-Source: AGHT+IH6M/PW71dskb8rgL0Ts0IITgYYnnbT6iirw8/MyrMTakj/RG/RmTyPbEspSiwPJOY2mKRS7w==
X-Received: by 2002:a05:6a20:3ca2:b0:342:1d16:80e with SMTP id
 adf61e73a8af0-34e2882975dmr64457637.4.1762188567010; 
 Mon, 03 Nov 2025 08:49:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v3 06/44] test-bbdev, test-cmdline,
 test-mldev: don't use sys/queue.h
Date: Mon,  3 Nov 2025 08:47:11 -0800
Message-ID: <20251103164915.101713-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

No need for direct inclusion here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/main.h           | 1 -
 app/test-cmdline/cmdline_test.c | 1 -
 app/test-mldev/ml_test.h        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/app/test-bbdev/main.h b/app/test-bbdev/main.h
index dc10a505d1..67a10e7a9c 100644
--- a/app/test-bbdev/main.h
+++ b/app/test-bbdev/main.h
@@ -6,7 +6,6 @@
 #define _MAIN_H_
 
 #include <stddef.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_hexdump.h>
diff --git a/app/test-cmdline/cmdline_test.c b/app/test-cmdline/cmdline_test.c
index 21b4a4278d..dd00455d30 100644
--- a/app/test-cmdline/cmdline_test.c
+++ b/app/test-cmdline/cmdline_test.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test-mldev/ml_test.h b/app/test-mldev/ml_test.h
index f35fa8aadb..a2de5b3a31 100644
--- a/app/test-mldev/ml_test.h
+++ b/app/test-mldev/ml_test.h
@@ -8,7 +8,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
-- 
2.51.0

