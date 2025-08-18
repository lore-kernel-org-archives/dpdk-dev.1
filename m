Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E67CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4CAC40698;
	Tue, 19 Aug 2025 01:34:20 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id A548F40E2F
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:19 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b9e418ba08so2631162f8f.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560059;
 x=1756164859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzkcsdR//pyUkm4xvYdsPbZFMS17Fjq5l3zFoZfRKl0=;
 b=YtBGCt77658mqhTyinmCKpfXqRW4FRdTk0oPfms+afnAwxzJMLTDzrBIlEIT4s+zlq
 bcDgCYyvGTzL0vSEgKzm0ML+LQRXO/3KclJCAhSk1c0EzazYlveKBVB2f1cZm6ioZ6JI
 S7ex3TxonpGpX4xCU87nqcBKD/q5RpFZdESwbZlpa1eHm4Gyy+XrdUiIBaf4TUQnzGJz
 b2EFwChVA/EY6zaip4oWVZMzjNyfoXtuKbwGkifla8N8l7R9UWrGT1qLY753W/2b2lLm
 NVYl86efKtWyCP7b904mPuDZoOpNNK7obffVDBqSE6rSyZGE8IYf+tot0k0EOpcgmO5l
 Qfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560059; x=1756164859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzkcsdR//pyUkm4xvYdsPbZFMS17Fjq5l3zFoZfRKl0=;
 b=rqoVURL7Z3zqdJNCLCbcF9scm5VwBT2fIjadVdrVJQHpgOmHRW/Z+RP57/kLOPLkhQ
 yw73AtW27odhHPphvSR9yMX3y9JR5KlI+nt/IJZsyDZ2rvhHIyY42QJsCnD5dOzFRBHC
 LwqMlks0zF87z/h2UUGQ+BNwGzltD47WsVKcW5TCXEu2LqIcKu20OgeSx1q/xJ5UjtxB
 h9UYXw3cy6UyS1S3dJsiacN8GJauudCInkvu3XWbiF8IgwzUeoVhyC6ib+AoFSJ/5mS4
 SnxM8bW2YJVbScKkq17yfJ93lzrTRU9ebLOijXnF0nqMZiiobYtxHpFzEdiUiCEHv91y
 ioFg==
X-Gm-Message-State: AOJu0Yx3wBBoBmuXL780ZBf406ICA6KDJyseP4OeK+kY3PU9j3o4IIGQ
 WJbYJpdScY+JvaK0SJXoXHchEUooWymBbj8zObyXmuSHFKEUX2IfphkiCOLLSo72z0VRNA5ywCq
 vI8En
X-Gm-Gg: ASbGnctMpOxlyJIhvds4+kfuSCF/HEIHphzUUGewNrDSdAJpUhkYbxF9saiC7S870MW
 1zOAAwQ9aZ4llvdPOu0CiIpV7Djaann9kp3PPPwjnmvsHf3dbbhUKbPe18pUxFRJBJ7chQx6mWV
 wEHsTXCvnqU3bUvQlAe2P1eKvPontBFZ/W/x3+nI8qdFQvmmzpObkUnxClMM+zG8oPso6CaQVj2
 8Q+w6gTPczdvKQLzOmbJ7vubLPQRE2jTEzkFhMZ5Ch5xO6x0k+LvOe9jIALJjZM2MCVd9AuSgLl
 6/DSQ/9LUc/VF4XenlukeMZwxIR9uyZEEeXxdRY+JNYBl7taKT07Xwk16sYFbYBPrc6u+DIjr7i
 j2/Wm7z34M71B0mmeU73FOzynkS2qLWg8OZ1vHIMlg5pJDqa/KFxhVwyMv/+tFdXOn2ItXiJp
X-Google-Smtp-Source: AGHT+IH0coxK0fLe6cj/5Bw3PPtMbotelASiOgiS+5UBelGqVXqJMbhH1J9JB0ZbcnJoLgvn4ffTKQ==
X-Received: by 2002:a05:6000:18a3:b0:3b7:8410:22b5 with SMTP id
 ffacd0b85a97d-3c0e028d39bmr318246f8f.13.1755560059229; 
 Mon, 18 Aug 2025 16:34:19 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jochen Behrens <jochen.behrens@broadcom.com>
Subject: [RFC 42/47] net/vmxnet3: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:53 -0700
Message-ID: <20250818233102.180207-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 1 -
 drivers/net/vmxnet3/vmxnet3_rxtx.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index 15ca25b187..cc7f540d54 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index e226641fdf..51db8d03cb 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.47.2

