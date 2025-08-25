Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB9CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 341EF40DFD;
	Mon, 25 Aug 2025 05:43:02 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 85DD6406B7
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:58 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3c985f13d45so216775f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093378;
 x=1756698178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dNjTsigkjBKmJTf1IsK2zw7JZR8TzzHyWcRh9fQ89Q=;
 b=X2bEEEBz4tXm7mVC5hXoSFqE/m1BsNh0bT6yrFI4jD8KCNm4BsfNCD+FAWd6agFUH0
 0Df4Sw4v/JyFI/JbSuONrXZ26V8ZIWo15iNGLW9H2oZYG7ym7bGEGqFzAIn5xoibG6XG
 O0M6O5HV/OEksZruAMIq23S51nuvYw7yUIzLWVKGOO3TxxdUt7O6wmjwPgCl2JKFORux
 Vff66QNYTw2FZTqUs2OIg5y0rCoUyRYGLVf3s8gT5xWYchoorUWERLvwQknL9toeJZ24
 sI7N3EVjpn4awLyTK/96L8n6pb8RiRjH0G6dSYqi2xKEkSWEZMWrwp2t2GELUoXO0u+q
 7SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093378; x=1756698178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dNjTsigkjBKmJTf1IsK2zw7JZR8TzzHyWcRh9fQ89Q=;
 b=xUUaomNEetNV9u2XRIGlMlweQ4mu1TLlfyXjsJtF7Vnv8OI1WtJ4K596aSxkM8DXV/
 o64nEIseW66v2/3Rf1gO8QfMCoB7V8vfi8eXjWa0iFOUqEPlagHJIU1JcOFV3Hb7ffzM
 rjVscMwnDVi4WO6TcVN2FEf6pJyOFzhhA7FpHfH3aEndAtKsPX9PdFhN1pbDqarPtyQJ
 hCXoVle6vSlHmN7FVGY1Sd6LOdru9wzs/pAHBFhW8u3DZ8+SDzFNaxOa24Oj+mK78qCe
 LAyEg21AOZmO1Kp4p+OjaWBJ9O7HOh7vfH5xMVFGqTOZyegrINxJNGTmgJf/WL4PvdJU
 qJTQ==
X-Gm-Message-State: AOJu0YxHSae3V0GzB2Dlphoz+JtwClcFeLxE809baBChXfDsircuVHYL
 TCv1iQ0Va+ks0VQDRx50bGzBMKlpkKpjVqVQXZFSfYZQKvy6d8mIzZVcvxu7q0ElHcPhL/Secju
 sPrR2
X-Gm-Gg: ASbGncuuJhJ9j5FGlgXuxnAvzV8vwXnr3jyV2hdD6B1rEWpC17PRkM15HJxE7yekCA8
 9mPCYD3O17EtKMp170kEoTwjF4IHFLre5IJ9WC9RZB0JPE+mTkOez3YILWekIR6w5w4DoLFczKt
 bulkz8/sWaAhHLwbJQ5rMS5UqP4Bz/HHkqg20Dk5jCxvzgDLNjZ1BPsvg2+0lj8H9hxVNHU+zny
 VZBl3Uk7OyhvJVz9ryWN3imzVrQea8sWwz2TxAlEga16cjgvEcqAumylfyc5EPaggRRUm0M2HZq
 TH/iZmRflf+pgyIZgeR9wHfAu9kOkc+6xl4pfmcgaTatIyjs31XBT+XvIdex5OaY4e7Wtk6C7Gs
 DO5uFqZrWH9UfE+eT0klfslbHA1KnYHpd6BEHvXqhwI2f7ZtNSPpm51z2xbIyUQ+3e8zOEi59
X-Google-Smtp-Source: AGHT+IHICg42NnCiwQQX6Mxktz+is/ah/y8Au9rAWHphNY/KvIzFhvXQfixpGtgZhyf7CteNPzXDQQ==
X-Received: by 2002:a5d:5887:0:b0:3bd:13d6:6c21 with SMTP id
 ffacd0b85a97d-3c4aa95281amr11033838f8f.0.1756093378202; 
 Sun, 24 Aug 2025 20:42:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jochen Behrens <jochen.behrens@broadcom.com>
Subject: [PATCH v2 34/43] net/vmxnet3: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:47 -0700
Message-ID: <20250825034126.12046-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

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

