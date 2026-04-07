Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7992FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B333B4029D;
	Tue,  7 Apr 2026 05:52:17 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id DFF7240261
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:14 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-126ea4b77adso5120802c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533934;
 x=1776138734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nT64+z7/DT3D1G0msFn1as46QXrNl7PnhWllXujrkLI=;
 b=NWzmFvoIm2/ZR5+SxzBERyHkqnF0mzrx+myutrwCn42U4qUv7sp0lb/U/epH4zVJhW
 qzsAmiy+zn1Ybtwo9OaWLZK2b7mW+723VK7cFjqugOcN89GHPfY2x5bmVOfoMf7SODCZ
 PQVQbPDLo+CuW1WDihyltcXev9S19JVW87YXsEXXvsySXK1QAk8tmiNvgK13DjVuIhJn
 v0gWdpmganEn2tXZSt+GnbbXPpn2KZchLfQMm5rGU0gTKf6Mec+7d3l/EcOIhDARgaP5
 jqU34+Gz60GTCjYp4EtjGSU5mrPmPynfBlhQxin1BK2IqMie03j4INyLpKyc5x3k9gQj
 E7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533934; x=1776138734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nT64+z7/DT3D1G0msFn1as46QXrNl7PnhWllXujrkLI=;
 b=DdSGVaHZlyWX999MUN4+0fUsvHnmJoEABxB5Q1EFvQFJsKyTZLoDukkMGnBDAUbchC
 VOSUns6+M6eEpyGWOoogbp37hXjDH7cznbRy5IWoqceLn88pLQkY8wXmt5a7ReqTPfiR
 ZFr6KTqkNRxQDaFsFZ8Wi/xxSB18mjjeQShiKofnlG8K6NNwWTQEuKhtQI1P69MIswhT
 Qbmw8gRbdY2FMyD0Yq6j7V46KqRH+zgQ5o1w4YzPPgRPG42zDIfNjF3b33qbfRY6HGIJ
 wYC7FMj6q0NTsph0QMnKdsMMW2jR7G8pkDPg03IU4hObnkjRp8R17bfR19UsFO0+Hfk7
 47BQ==
X-Gm-Message-State: AOJu0Yz87rj5bjyhrW68M9p3ws3GhuA09ZFBwyzf4gphjdGJ+7v08JgQ
 uzduN9P7+DFqlcSr+nnpB9l4DmZBE5AKyFrF2LhVUrPnXhg66ztFuH2v5F601dv5lZuKQU9C70q
 bNGW8
X-Gm-Gg: AeBDieseBmww6HweGvC9tg++NdB0b5E/l1CDc2f+z003oT/cakWDA9aqzr37xAOG3aS
 729QZYUHmVP3FAuXeixamTZSawv9t1MYqQ0KSbp90NuUtIrfPGsdvoCAknV5EZJlNcIU9hvBEr0
 DqmVweYkSkE1iWCkz/pNDA/4bLha+/Ouc1d6QN9sjKfXjwvxyUwOtU8ANLpgR0lyKpM81QrWPGu
 Bs5gTc4BA+PKuGq9nZSWX71GQtSfDh+VXk6PA5pb78onTXr2lOjQlZ5pZMMsAnvdQIXDe83PlZz
 kkzJkIJFKqxTfSkcB1c02XNTT8H6bUjSluN9Abc+vw0p2JYg4ZRTqo8TZ8YmFE/uDSM5Ba98rtc
 20NXOl5vTt5gIKap9CZHYmdHc/xQVl1pwACkR+B3zoTj7Rz52HPO+D4KYdxLChI6uFOFltKHMvi
 4Nygsqh9OkGxjjIjxL2bD7usYpcqTo7Yok
X-Received: by 2002:a05:7022:52b:b0:12b:ee92:a60e with SMTP id
 a92af1059eb24-12bfb6ecb28mr7679852c88.8.1775533933915; 
 Mon, 06 Apr 2026 20:52:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/23] examples/eventdev_pipeline: fix shadow variable warning
Date: Mon,  6 Apr 2026 20:49:28 -0700
Message-ID: <20260407035209.650419-3-stephen@networkplumber.org>
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

Fix shadow variable warning by reusing the existing 'ret' variable
instead of declaring a new one with the same name.

../examples/eventdev_pipeline/pipeline_worker_tx.c:877:25: warning:
declaration of 'ret' shadows a previous local [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/eventdev_pipeline/meson.build          | 1 -
 examples/eventdev_pipeline/pipeline_worker_tx.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/eventdev_pipeline/meson.build b/examples/eventdev_pipeline/meson.build
index c317f4b3e2..b8f5cfe109 100644
--- a/examples/eventdev_pipeline/meson.build
+++ b/examples/eventdev_pipeline/meson.build
@@ -13,4 +13,3 @@ sources = files(
         'pipeline_worker_generic.c',
         'pipeline_worker_tx.c',
 )
-cflags += no_shadow_cflag
diff --git a/examples/eventdev_pipeline/pipeline_worker_tx.c b/examples/eventdev_pipeline/pipeline_worker_tx.c
index f7b7937d6a..a3090e3b49 100644
--- a/examples/eventdev_pipeline/pipeline_worker_tx.c
+++ b/examples/eventdev_pipeline/pipeline_worker_tx.c
@@ -874,8 +874,8 @@ init_adapters(uint16_t nb_ports)
 		service.callback = service_rx_adapter;
 		service.callback_userdata = (void *)adptr_services;
 
-		int32_t ret = rte_service_component_register(&service,
-				&fdata->rxadptr_service_id);
+		ret = rte_service_component_register(&service,
+					&fdata->rxadptr_service_id);
 		if (ret)
 			rte_exit(EXIT_FAILURE,
 				"Rx adapter service register failed");
-- 
2.53.0

