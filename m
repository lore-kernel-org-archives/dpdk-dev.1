Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC4FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41C2340654;
	Tue,  7 Apr 2026 05:52:23 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id A03E14014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:19 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso2658863c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533939;
 x=1776138739; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E3A9UrVkOEqXvjmrT3o8cbqP9IbxFDYNBIMjXHlfUk=;
 b=tPbhAvpp1JMEG5swAh3GJgVq85pxXeFwPUen1tO0dYIG7aC7di9pgy1XNeOdCymsjt
 vUAs7afHJqBnxF1TEvpIhDNy94F8HHMymFWgdBzm7iQXd2ItJmbSjc1VCk7rbMjfDlgZ
 Z9lZwTWv5mTCyDaSjaeALe6bZSXx9RC89AHHYiVzREw58oZ5pANZ2DH5ldzP0Z3LbZHI
 +5zfNEUnNTUx7ahNXJlJY/3mxnCP+DfNWk0WHa2F1U+H7XpMA8CW5AA2EPigPfxeiSEC
 mYTEu+IcPQPtfNuGiPAKD4ErOPIz2v+j4GvkAeBPwPfUlzDJqhQexYlHmnm/W/tBpIS/
 6dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533939; x=1776138739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8E3A9UrVkOEqXvjmrT3o8cbqP9IbxFDYNBIMjXHlfUk=;
 b=lrucuMQAmLcU4aifG8DV5Oh6H9U6gdZwbWmOOFbFkjBEYp8bS5k4F2LCVgEcSs7Fjp
 6eddyOMynTPplILXJ8v8exTNuizi6JLSz/RKYWFpSYqBfp0RdEZ++4QhyzqizkWRDngW
 CDtLD/+We6A4Ftm1p0Uju8BphqGvTQ0FTIeUW5qVcmn83ug2YIHYGQdIelCkmPmmu4cd
 Gs91xzRnOybac409ACyPrUXe4cSR2AZ8ErJU98Kkwj8Yu/pBtohOI4E423ycDo5fEgDD
 D8x6mcwRNDoSCnJTIUbiz1wLmujmMh/ydcrjgJI9HtFAhjo86j87nGUHYDsy0SoB1hiD
 Ndbw==
X-Gm-Message-State: AOJu0Yz5weQ8HJNzz8V46DhgDrrIkM6OuFwEoVLblctJ4gYLDdIdwohE
 OzlX7Qqz611eDt/BT0Uzc6hgExTqYogsFdtz5N0b473WRx6nOd/wJ5pXkH8Sa3TkB0l+S0vGZub
 kCXhS
X-Gm-Gg: AeBDievA0EoL+sLH4q7GpmsChTE5CU4SShs6ic0eWuzlYAijkbEuzHGrkhhY56QAj2E
 +OwsLgF914LgDBzmkY3iYoFYl3eiYqK/61lzZf/WFidAykuHDKiXvFCsUFvN7ZRLcxYWNgICMs5
 k7OwyqyogMSVk1xJHai8EZ4kcDRaVKgqvi0JoHYi8dc962OTX16KRzxp5Syt0JHo2t12VSUBTEf
 Ft/7JsGVyUg55/zutmxI4QYVuo0qzfr+wRMuZ+UxOAiIUYSE86l6xLlHIJHPReBgVJScjwi2RyH
 2SAVvJSe4jePFVZ8Gy3/Z3f44qeyWV4GUR2xJfAijJXSmuIchCAELBiZxNShdlZYUKMiGA8blUS
 wUr95UaCo/sw811yIlQaX77P9gCtBtp01RbN7wIMahqhrs4SW+LpzthJf+8tJJu7KIW6ylWW7iW
 figEqFx/fultDbPHnm5qMhwiOZcNclCoQY
X-Received: by 2002:a05:7022:212:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12bfb74468cmr7202939c88.18.1775533938555; 
 Mon, 06 Apr 2026 20:52:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH 07/23] examples/server_node_efd: fix shadowed variable
Date: Mon,  6 Apr 2026 20:49:33 -0700
Message-ID: <20260407035209.650419-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Argument to parse_numa_nodes() shadowed global variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/server_node_efd/efd_server/args.c      | 6 +++---
 examples/server_node_efd/efd_server/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/server_node_efd/efd_server/args.c b/examples/server_node_efd/efd_server/args.c
index 0e5e89705d..cb0486a952 100644
--- a/examples/server_node_efd/efd_server/args.c
+++ b/examples/server_node_efd/efd_server/args.c
@@ -81,15 +81,15 @@ parse_portmask(uint8_t max_ports, const char *portmask)
  * and convert to a number to store in the num_nodes variable
  */
 static int
-parse_num_nodes(const char *nodes)
+parse_num_nodes(const char *arg)
 {
 	char *end = NULL;
 	unsigned long temp;
 
-	if (nodes == NULL || *nodes == '\0')
+	if (arg == NULL || *arg == '\0')
 		return -1;
 
-	temp = strtoul(nodes, &end, 10);
+	temp = strtoul(arg, &end, 10);
 	if (end == NULL || *end != '\0' || temp == 0)
 		return -1;
 
diff --git a/examples/server_node_efd/efd_server/meson.build b/examples/server_node_efd/efd_server/meson.build
index fa0e15d73a..f1a6616738 100644
--- a/examples/server_node_efd/efd_server/meson.build
+++ b/examples/server_node_efd/efd_server/meson.build
@@ -10,4 +10,3 @@ allow_experimental_apis = true
 deps += 'efd'
 sources += files('args.c', 'init.c', 'main.c')
 includes += include_directories('../shared')
-cflags += no_shadow_cflag
-- 
2.53.0

