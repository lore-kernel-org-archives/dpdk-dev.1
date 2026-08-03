Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7BC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA63F40BA5;
	Mon,  3 Aug 2026 18:53:35 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 33BBA40B8F
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:28 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caed617615so48736795ad.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776007;
 x=1786380807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Go3XJW5+Jl51o1tcrhS4oxtPg+y24Hoca0TlixUZ318=;
 b=C0nP29yUgiB85F3h8/HZNwKDS0uBVuPnFi1YQ7pPdn3OxR7ALgBCXmbCznAR22gglS
 Tw7iboJSIhPwsswuG3QiUeq6YCw5+TivZiDGRMtVtH/kW0y1siRE60+xeWuBOjp4VJI5
 H6YeYnnRT4ClUGrKOSz9f1GeE30GEhSPoU3ikkvkWJJZGmeakxW6F614x6ORmIkDeOwZ
 s00vWPNV+W2chXKRmxoYL8JePfuxnadVkjzKfc9rK8PpJ0E71Tu8RHiSrVhNaV5LqhVY
 Ylm9UcuiYe1wB8SPZ6RmcKXap0uTrycqSyxTM3jdc1qTI4w7oblyaW1uzOlP4OOsuKmR
 1gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776007; x=1786380807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go3XJW5+Jl51o1tcrhS4oxtPg+y24Hoca0TlixUZ318=;
 b=f1IsZ0U7nWUQZv9oeG34l7n3s+2r2hpmfZ7/1oDWT2IDoB9eWx9zasqLHLUsZt71E3
 ZV1tdQxxRGHUAt+92c4mkMiZaitBsQtpFYEjViPJJgMwIr3KPeytik06vfCiRhDvV95e
 MEzZ6Y6OT3w+EXw4TZkuvZhS7RcW0/Gu2oqsGI5+dz/0wfoap8j0IEMUoO6b3CuWQ60r
 BmWOBzcI93JoJcOPwt9aP1HA4zvPohLl9qkI6ulL9lMbWdDgYJ6rMsxQ/F0OW/CeRvh6
 4jpeK09TboFh8MRskN8TXqOZaTm5sTX99O84BieBhEJ7zivKP5mImNT5oG1/D1Nqiw3B
 tYXw==
X-Gm-Message-State: AOJu0Yye4Lm5qenr8L9dw6JmjG/59Ytd/ywJwTiw+LnBh3pQ1k+Lfxnh
 4bSb0+9mXEjggxBQRCmCK+GG+JZFZAYzUu/v1jtzb5ZZZg2aNioESCrRxy0RPiWXq9gwSSMoRpI
 4qbvl
X-Gm-Gg: AR+sD12UELAvD97BPNgwiZQIbmUh0Ot97qvce/M0lXJau3pjLGFCAm5RaYcU5hCcdQj
 OxHuPQ7Wjpg5IXFkcoK+ezZaknb4D0k5ijC0ohCJf87YG2kkcvOtMgJghS2ULejnHY+dJmlrvUs
 LFTD2dUrXoVwt9j723duk6OlXtKJ091eQNnxOj5LtV2DQhz2nY2vljDjwAlRpQaU+8Ge+A+Xib8
 qD0+XcHorovsd7JI+YltqVvjRktaijCoT0uHzA+cemSRmdHUjgZaXhBThcKiIvHqtWuj4SycUtq
 nbvm3kln4cvFaWoTEvWEMOASnIyfKfoQYugt4NlhAFaVPTjkssPaUhdgTovLcAp1Imr7YakF3ZV
 +EE/rBKBeLRoVyALpMH8mcNLNHqGlhLTS4XPUeCh6CIS21+rzNDSNiU7dUZdI4BBz8nD2zJHvF7
 /Zqx00KsEpRddKzio08nu2S3q4lSZac69ymrEMEbrKAk1UC73r+7NUtkbKQO3oxv+9YmLdj73NE
 eeX1ABvS7V6VgdJZNQPka1pQK7HAkh2LCaiWm4=
X-Received: by 2002:a05:6a21:9995:b0:3c3:b4e8:5565 with SMTP id
 adf61e73a8af0-3c92a8f301emr11501878637.61.1785776007392; 
 Mon, 03 Aug 2026 09:53:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Apeksha Gupta <apeksha.gupta@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 20/22] net/enetfec: add missing sys/types.h include
Date: Mon,  3 Aug 2026 09:52:06 -0700
Message-ID: <20260803165304.289869-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

The enet_regs.h header uses BSD types 'uint' and 'ushort' which
were previously available through indirect inclusion via:
  rte_ethdev.h -> rte_flow.h -> rte_ip.h -> rte_ip[46].h -> sys/types.h

After changes to reduce rte_ethdev.h header dependencies, this
indirect inclusion no longer occurs, causing build failures on
PowerPC.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetfec/enet_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/enetfec/enet_regs.h b/drivers/net/enetfec/enet_regs.h
index c9400957f8..a834fa5889 100644
--- a/drivers/net/enetfec/enet_regs.h
+++ b/drivers/net/enetfec/enet_regs.h
@@ -5,6 +5,8 @@
 #ifndef __ENETFEC_REGS_H
 #define __ENETFEC_REGS_H
 
+#include <sys/types.h>
+
 /* Ethernet receive use control and status of buffer descriptor
  */
 #define RX_BD_TR	((ushort)0x0001) /* Truncated */
-- 
2.53.0

