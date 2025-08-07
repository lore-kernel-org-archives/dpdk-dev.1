Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADDC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA9EA40662;
	Thu,  7 Aug 2025 19:34:52 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id A36024065F
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:34:51 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso1019701f8f.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588091;
 x=1755192891; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=h1pASvOkkGxVDd38XyeyCUZf3zf5jjItpJarYQSBdBY5msU4evUpD2ApGgOvqZ6VCq
 bgxsb/s4E/qex8Qm5FBrOBP5ZBkIQZhJvS/jOsljf7AJdgZGVgqB6QZMnAPNz1khPkM+
 TbZLUeKT87LBMTjxeTAx6aWRoYG04jPNfLCxcVuz5QzGDSwk41INT/Ajr4zhcQqaIjjT
 6YfW5XFgSXUGL75lR9SEc5qaBdWtqo/Nsgjlquv3eVQduOk+L9zXzDH2jmDX0RCeOtiB
 F0XC3ud1z1uzQvBJJrnVFpdwHXK7ox2tKVioK339o8fn+ZK1t4SAwrZOUJycofZUQjY1
 sZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588091; x=1755192891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=VCyV3Jx0cxO0EMfax3nS/VO8BnpT9hzEeh36ZlJOJjH6wUDA2PEco3JWjCP+sSyeI5
 EOjmQbO9GSJjJx9AvcOouq4xF02YfVLxjqxYGZoQtnRLMQSKOBGV6AGq8trnpFnH6bU8
 uCHHGYlwX4r9b21Wg4w0/VKWAGOFv9S2OuwRIzSOcrUyaDDe4MHHOlj5h0Z9+i4vEZdv
 z/lW3FbhPRaXhmxeyWDTiYfXura7AKTO1N7BBqIx96okuVCAoogei/RIJlPOyTc7pTRi
 a6bFCGzQsqvZYBZnYjfrKJ7Y/tmy/1LIsCkoPTFuZhR3gjLxWpFNBI5nbM6TwFD640zz
 LR1g==
X-Gm-Message-State: AOJu0Ywik2JkyIhbAPZ0FMCE76XWR1n0vgywSDutZ0j8wITcHA5pYSXH
 nS/mGHmk0gi/IP8HDDiMPDySUcECUmT/g9M1uldNwjUB5uc0J3QGpLdMM2GWY/Bg6oxpnE5MZNE
 ea35L
X-Gm-Gg: ASbGnct2Br2b8pFcXig9Tcy3jAx3ZFuw2TL95MgOXyTy6X0mN0sWQgJxgsDyXXIzYUL
 nEXAnPixl0AqWovetFPLlYmT2DQO2fVzg1yKJZifI2/XON1E4H2Co20hCv9IpccyCoTEhpMbzIF
 jhL2RZVuXwsRxgxXgZ7eyGptNZj9jXn1UUxuAJ4iek5860qVHqsQYc2BWZAjKGnbB2ZDjynSaos
 B0e3OaowfmPKtWscTR2RRZbAJRxnCaqJWjML3trqJEB1P4OcnFdAqKJ9kjKWDqYBs6+WxhGFMfg
 rjh4ofjTyIIjcY39dhsJx7+5DZwpeo0thJs0AZSykJo8IsMiWQ8jm3RaVDMeh31Bc4yD0sO/5c/
 74Neq7losNkAHzrjF/lOj+md/R5MXmPTLurPC/S/AcmrRJ/DRRlBj++eQVxQSEVJGBm0h1+65
X-Google-Smtp-Source: AGHT+IGfNwJIqAjGfS4MSNCbAx6YLkuVuMEzn+k0SrDyyldJFLsDY4JQHT3rftgAiBjX+0TOqw0ltg==
X-Received: by 2002:a05:6000:310b:b0:3b8:de54:6e64 with SMTP id
 ffacd0b85a97d-3b8f97e6e52mr4233286f8f.26.1754588091161; 
 Thu, 07 Aug 2025 10:34:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:34:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v10 02/14] ethdev: make sure all necessary headers included
Date: Thu,  7 Aug 2025 10:33:16 -0700
Message-ID: <20250807173437.11442-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 1d423290f1..000b8372d8 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

