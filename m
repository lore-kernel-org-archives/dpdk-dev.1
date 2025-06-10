Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34513C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78CA642EDF;
	Tue, 10 Jun 2025 16:14:06 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4FAE84026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:05 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d3900f90f6so234838085a.1
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564845;
 x=1750169645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7477M+uuQljFjffGIN5OLiVcpHnKTTwgy+fR+eFyRc8=;
 b=r0+phN3MZ++laImKzVKuVK4Z5bUdaKOmbkxJTlLaEcqkYcoTKRvtamk1KSwcwRBR7O
 FBU8JSQzasZIvWlLkB+53V1a7Ebtn1nbwXFjF+jvVhD9ZyyE9U15KjHEUGXe9YkU2PZJ
 ausmPrmPyV3ANhelCu9v1EUYbot9kenuZEykeNiTJfwCgNjTSPraty4WX4JJbUtG007/
 rBnJiXAFnw0D1lWGZYQSFRXYbd3xKuNohItAgxJcvW0g9dniSER2EWu06e+NqIDXPowg
 9HtnRSvvF3V15kkaReoNlGlVwM5W6SW6FvBe/hdGfwlOjmUDOn0QzbiHAvYfmWQogyqa
 TLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564845; x=1750169645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7477M+uuQljFjffGIN5OLiVcpHnKTTwgy+fR+eFyRc8=;
 b=AMD7TAgrCrImzTZBrTx2mBBH79/V9FcAeWpUO1cOwNOL0Jf6Xncj8wVc+HuKRVxSTd
 TsLpR5drdYBLpEbB61j86IKBNFhiq8NaQYjW8Y46y+MZtp4/GNcuAdOE6K7zA37jPR8h
 lnG64hCmH3QOamS/Dxas9h7QTy/uaOgyllwJmlDBv03YPJIsV9DJgYUSUu8iepPQXaKo
 xHahFJOL0lDJHr7Yrax/6A8WbimAwW9cQHLh8Q5C/sRtcZ/458nBtlRwo9+M5tLDVh8H
 QdMhToukyOr/NanP9Phil2zEK+4OsB/b0W/0Lfuvk3B5bAqca7J3lXppD8pbbqReSwKx
 W0Vg==
X-Gm-Message-State: AOJu0YwYnMBQu6lbnUMX9AcJfR1xmKhol93Ai/kXlKDB/x+j7Fapp5fK
 wmBrGQIhHCvi4i8/S9En1wo9GuJinz8zQi0+UtfxPYh9BtHpU2SRApIS5GfTz6dabs3XNy+x2Xx
 Rv5aP
X-Gm-Gg: ASbGncseFwXpAsH2Jq6kgwQDfXsiQoDd1bNWOdNsk9VeFuIf7/421m2AdH55wWmyOxB
 8SkId4CwJLjCpId7Iw0/E7JosmZmU4JkmnBcAP0rg6UWN6PeCmzSHuJqhgUbBXqqH82PfXHSTP+
 GW7JkKMXkIY/FGCm3TNOJxrr7mpLuLxNhZecxpxRkamfouppkH0EK7mavDhOiO1ZKjFlsXrWVsQ
 1dBLe46DpdQdx4P4NRitnZcOMxnNYZIhMcO0IW10X4Ty0UFbhJGGfWaju39SkxnaUkrp33wYBNh
 AAEyIpc5I2L4+fc6B58ph3rrorgIgOjykPzaaKE7s0X7Wq0eS1BEu6Nsfoc7/RwyywVf23TcX1s
 a5mvc5bWNN1RgOr6axUPb5qd/PQSCr8y72ev6
X-Google-Smtp-Source: AGHT+IHo5jRbThjg3yTVzG63bIBzDv6M+Z7lHtqA8XFyOPWOcnkpQnpdt8m5wkkvBWJZdMi6ns92tg==
X-Received: by 2002:a05:620a:4487:b0:7ce:bd05:83ed with SMTP id
 af79cd13be357-7d22987d994mr3030148985a.7.1749564844510; 
 Tue, 10 Jun 2025 07:14:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 4/7] latencystats: update include files
Date: Tue, 10 Jun 2025 07:12:43 -0700
Message-ID: <20250610141355.91759-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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

Include what is used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 50043aea72..1e176492f8 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -2,17 +2,26 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <errno.h>
 #include <math.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
 
 #include <eal_export.h>
-#include <rte_string_fns.h>
-#include <rte_mbuf_dyn.h>
-#include <rte_log.h>
 #include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
 #include <rte_ethdev.h>
-#include <rte_metrics.h>
-#include <rte_memzone.h>
 #include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
+#include <rte_memzone.h>
+#include <rte_metrics.h>
+#include <rte_spinlock.h>
+#include <rte_string_fns.h>
 
 #include "rte_latencystats.h"
 
-- 
2.47.2

