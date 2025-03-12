Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD3C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9906440E45;
	Thu, 13 Mar 2025 00:17:38 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id AAE4240E26
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:33 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2239aa5da08so6627125ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821453;
 x=1742426253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MsNmpAQuUPUEMM/L+gIisI6TeBxUqLgqSRwIVDptcA=;
 b=KP+apSMO2GqfqY6iLJwJNVlql6tFARAvyYRZKedLy8Ll9JWSZ0JE5Y+quJi3eBECE6
 Ii4ZKs1Z4WZzEfYS4nIgZW9aUoApis3DDYuD1K4aQ/cVph9gGTJwSp4CVqr7T1ziqsRs
 0frfH/QUGgYB8wCju/IccH1xQ36nV6IBrtW1qfRTbqlQo/7hPcOGzeldTcplX5GOJqZy
 LcmIQl7M9sxLm7rBGBnr/lwVYYx3h9Fz0BxH0b/aFfiBndGtGcvgaCcePgF5t+5C5WbX
 KIJ6Ab9TbTrHjjDd5koLEKIDO5F9Zvcs+q3MD8ub/NvXF7EpuMA2aBw6DNJpsBcBHkRH
 SGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821453; x=1742426253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MsNmpAQuUPUEMM/L+gIisI6TeBxUqLgqSRwIVDptcA=;
 b=Kk787re72ftsljKkauSMR96eEjLV/1CzWwsM8UbftTUe5lzNRwukUHhUNBJSf3tnDc
 Rp9T6OcocaQjwEpt7Vc+upe8FmVdXwYf0YxKiimGuP/UMI7HBqmttLKkBnyhvcStc2Qx
 0xByD5kT71Lly0VZ698LHtrG2ioO7sjZ+QMIAGCUz38rVhSrhNHDUPVT85o2zGTzDI5k
 tLs5xRyrht/KYxrZkTcON1IpQYYHw1pymNYDKy9coW5Qrm1M/d4m31S66XREcn8rzQfe
 7LTzb5oGIqqTeU/zt8jHjzcHkAB9civq8/yRr3JBrrlD2Ke2b12LHKJELh8NpLa3G1X1
 Nggg==
X-Gm-Message-State: AOJu0YwxuMLTpr+K63aq6SH6fwFvB4YNaxCdJoG8s00eI0zBQGz7kJeh
 w8eLFmNxCnP/Beo1BvgMqKJWZt6RgvAixi3tmz5iNzuzaH+HALwKzwrpnLGNm9KW3r5ROeTIvj9
 9
X-Gm-Gg: ASbGnctDuZxyH8hv3UbrRSYl3dVcJ+1qRUl/wwVFmbEY+De0I/36/4UX16V163Ct+53
 exy37N9heebZG7wYLNSzrP+XCj02CS+CP3w2qr2+l8GO5lz9Yn4CmDtWaeUF3jqc0n4lSnKugFe
 dVYQhfKvWgXmQbn486DxNfAJpys+HEiuH0LNce9NJ3iRSLpN3du0iNVKTVvquJ03d6Bzh9vGE2s
 QBtWUM1EINcmPcYaK8oMu5Y/F7bBjC09iTEaOo2hd3JF03vPh400pu3+r4ZGFXTQkMRb1U8TCg+
 bNC96VhwKBleWoBY7KV0Yj+OFaIzoQkYpIV+lUAfwx85EYdoLKpaC9sWEvpSQIh3JL8BhZiP0a3
 RJzfpUKSmFnuZ/T9TTpnxtQ==
X-Google-Smtp-Source: AGHT+IGOcgY5xiWsgLc/HqXvJm35EN6aKKcLjdJ4ctvUKh8TF1S+8G76Z2rioh7Lk98JLWIRtOT/9A==
X-Received: by 2002:a17:902:ce0a:b0:223:37ec:63d3 with SMTP id
 d9443c01a7336-2242889b359mr304533645ad.18.1741821452923; 
 Wed, 12 Mar 2025 16:17:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 8/9] net/i40e: replace open coded version of
 LIST_FOREACH_SAFE
Date: Wed, 12 Mar 2025 16:15:37 -0700
Message-ID: <20250312231715.222149-9-stephen@networkplumber.org>
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
 drivers/net/intel/i40e/i40e_ethdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 1c5ab35a8b..616053dd5b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -29,6 +29,7 @@
 #include <rte_hash_crc.h>
 #include <rte_bitmap.h>
 #include <rte_os_shim.h>
+#include <rte_queue.h>
 
 #include "i40e_logs.h"
 #include "base/i40e_prototype.h"
@@ -5096,16 +5097,12 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
 	if (pool == NULL)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->alloc_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->free_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
-- 
2.47.2

