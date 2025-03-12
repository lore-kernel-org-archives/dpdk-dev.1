Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336FDC28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:18:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B074540E4B;
	Thu, 13 Mar 2025 00:17:39 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1465940E31
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:35 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-225b5448519so6970905ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821454;
 x=1742426254; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DuRTQrPLMKTCAZViaNBqgXNIqy8CMu4YdgEWQfYUxU=;
 b=nxefQon7SdKP1b3Qm7WD20V8yZxO0VEz7lyMNX/OSYYnyAh9gABF4Uz7HE/hcgkVz2
 6qHp/zm3UdzdEK5KvG7WdZie/P5UeLDmIkcMRE/pRUzBR3QrPjA97Hw03eLkRsPd6vX4
 W+sAxrUPgMyI2i3H7k3Xhlfxc9X3Gz4Iz15wo5LLNvpQEonj7Ird5i9z5ISoQzBJvFBi
 fKS5IWGSY/gjLTTtFefJ4/k1zCOD1mDBUy/6RoPkVG/R5iopx8QtLRL6L0BFxn5M0l/k
 7zfcZ9pr9rSAqvo65K+jI3/3dvoGxguh0eg1gOGAMJCZvSOEX60TMMkT+VlYj6Bwt7t9
 53FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821454; x=1742426254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DuRTQrPLMKTCAZViaNBqgXNIqy8CMu4YdgEWQfYUxU=;
 b=cDJmXat7TNUJ4N5nIffwk5wPDIo7z51nfpjpT8tgNFmLKjV5AyUpQmj3VisDv6CcPK
 CU6euFDJhb1R8Yt+L7Rj3xDbGntR1h9JF0sAaq67yADzUC0dhFfS5MMCED8RlmiP33Qd
 jRe9ykcLUxq3JSBUeBm9wrHjSWF0MGLxOnJ/CHkWYr2KHwwH5tFVubED4XbBDH4AhZoo
 CVxcFLMKjFxaE0Rue/LoPxM+Gsa0p6c/E9OrZqrNury9OC1wuBhgrYx6zJJeRzSU4kiT
 yi70yhnITw1FdBmZNfHPpvHv7zTeP71j8vlie5jKYWZenXoaYEDwQ/6EHJDYbDoz4ghl
 R/qw==
X-Gm-Message-State: AOJu0Yxh2FSseVukDX6Q8FlomX0jjEc2sUTUpfjCzhr4uHJdBELbXZNL
 1rpB9lNGHqIMOE7RB6Be5yeD3GMaIaDPe+56HFIrnNQn6XNR0ztfN1XRthXkKtcfG1VMMEmWprP
 p
X-Gm-Gg: ASbGncuzNYxkdelrOBt2g8otFp5GZWfUbtyZUyeY0Z6oif2jPTb/xNksagfRjRfjJjp
 wTqe/iiqco6RqGZvQJUcgeNk54oupG+//dJEp6Fb1ah0Fy+IGJfc3o6PfpenIbHEW4TfU/2iip5
 J4Ht9JIfA8rxXK8VQoPPacUb5Bd/2/5cnxffND94z0vMPnyGdHArexQEPdQRM9cbrWe+pE6XexX
 FDZLskjDbpel6j7CH+o2XPuAyDQXEJhEKH7kzFWOvUlxH3CC7gbKwD00ua7aLNqRE0WzWoxfCVf
 ytGkT9hT0TFU2NTcrlFzxeuh0y5fCR9jvVTZNZpoKfokQGHI4oGSmGH81moHH4L8rWeDhDPbk6n
 KpSKjxDtbnumVVLqY7+4g+Q==
X-Google-Smtp-Source: AGHT+IHzrMJdvJtguRPdvx2gZSlCGdJnSz3QQqD44OUZq7Rc1UWZKnqDkAkqp21Tbn4ZI6U1wDsszw==
X-Received: by 2002:a17:902:e750:b0:21f:68ae:56e3 with SMTP id
 d9443c01a7336-22428be5a43mr330960355ad.39.1741821454274; 
 Wed, 12 Mar 2025 16:17:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 9/9] net/ice: replace open coded version of
 LIST_FOREACH_SAFE
Date: Wed, 12 Mar 2025 16:15:38 -0700
Message-ID: <20250312231715.222149-10-stephen@networkplumber.org>
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

Use macro instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_ethdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 3cdfa16f77..72129f5e0e 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -15,6 +15,7 @@
 
 #include <rte_tailq.h>
 #include <rte_os_shim.h>
+#include <rte_queue.h>
 
 #include "eal_firmware.h"
 
@@ -884,16 +885,12 @@ ice_res_pool_destroy(struct ice_res_pool_info *pool)
 	if (!pool)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->alloc_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->free_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
-- 
2.47.2

