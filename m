Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF137C28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2AAE40E2E;
	Thu, 13 Mar 2025 00:17:34 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1CE4840E1B
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:31 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2232aead377so7458035ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821450;
 x=1742426250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bul09VnJ/fuCMGh8j4kRd9FN2i7+3mxIBTXunzK7rsM=;
 b=CXxAxGM9lTvLDdbr0nQzUrgXhYRdIgPzQx+uz5hjWZRjScOqklfTGn4n6kh3VgpYUK
 6qc+9k83Q/Q2qMKWIrL7kQ3DXRc17gH5Na/hCiB2MZtj/aNC0BUBdNFsAYJD0fmuE6oB
 w9VYux9UaFHuLqsNPTg5TYhYi94BsZbSXVPML+gxmy/3na/4NJe3X8q9zhVkdEjzQ5RK
 Xn1TjyZJtm4xihAhfWtdfLGElpjFZXvKrPHvorexFuydA8lymDIokgy4SfgxjXF20Fb3
 AFz0thu3580OtsCYAWKTi+cuWNjaB0W0kcaGCdGXhNf7jgxkmo9YvF427aozwgBOmgQM
 dVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821450; x=1742426250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bul09VnJ/fuCMGh8j4kRd9FN2i7+3mxIBTXunzK7rsM=;
 b=vVHKY9Oz3/K1foeYBZJh6q6cNdjb1WEVI+FMdkuPeA9XApk1fPcDYP1lXozdRXSxnF
 Rd3b5h/oQ28MN0JRwsdedtgK2+g/JnAUjMA5di7BrUPYHM2Hd85RISRU4HPLR2AmeZz4
 6r34EmMHvz6/dqIqFgpDBdz6OFJrGQ47vBuj9DBF/205wPLYp8AhfWBMr5Oqhsn96Zm0
 9xyqSFS8NZpCrikN05D5VcqkIq3jsHwjUtqX35uUzORv0GJleA7tCx0zB/Cfr/cdhTNT
 zIxshEEPnMaczYm6UoMNA1jC2NmeI7wKezQCT667flcrPVBGcg/dZkFqsH+z5y92ueQ5
 EBrA==
X-Gm-Message-State: AOJu0YyMiRa5vT579U7A4xDKRebxDMG8TcyUiMWweIgX0RrC1y98uZzZ
 c1jFTEht2WX0gqqw0QYHOh449maOclm/nic3JlU4iPK6otS+JNiicsf6n+8diuBXaW0j5hgkEFG
 V
X-Gm-Gg: ASbGncuy0NTkCyg7SrXN3RjrJ6jols79cYAQFoytozfpYBBGL+sB2wXmngWhN1DT0ix
 CjIdLZl/0cd/48N3Z4bFxdxpMG43CJXwLkA4ofcnMmaCOgXLAne2vsVlyrTH3RLQPM+xAyXgkNU
 JRdasFpFPNA6hroq4nIq8R3iDocdga+cXDWWMEvbsxtG1y3xkUP2UNK89GuVHk79e/VbmUoSIHW
 yWfZwLMedZV+SWqquQE5Gy3FOIIdQkB0vMaF8e+ZJD+EEaBzpCTKU6BdeCzuTziWIGNTAymCKpB
 cnsOmPKqfNcMWMh8KJCtr78GahXJ2ORmdBO0gMntk6zm2iL1l1apRK+lNz+ehPvDwgzTCfzr6++
 5Fa1wohLBPU3+gFtDvpSHUA==
X-Google-Smtp-Source: AGHT+IFxh581vVIYND5QGGD4DSxv8QQRWoX+L+hrh88DwDHLX4wJJVvJ+0mo64hF+5jPJjlARXMciw==
X-Received: by 2002:a17:902:cf07:b0:223:58ea:6fdf with SMTP id
 d9443c01a7336-22428a8d325mr432239285ad.28.1741821450370; 
 Wed, 12 Mar 2025 16:17:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v3 5/9] net/iavf: replace local version of TAILQ_FOREACH_SAFE
Date: Wed, 12 Mar 2025 16:15:34 -0700
Message-ID: <20250312231715.222149-6-stephen@networkplumber.org>
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

Now in EAL as rte_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 6feca8435e..0b7c35250c 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -13,6 +13,7 @@
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <rte_os_shim.h>
+#include <rte_queue.h>
 
 #include <rte_debug.h>
 #include <rte_alarm.h>
@@ -52,13 +53,6 @@ static struct iavf_event_handler event_handler = {
 	.fd = {-1, -1},
 };
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
-
 static uint32_t
 iavf_dev_event_handle(void *param __rte_unused)
 {
-- 
2.47.2

