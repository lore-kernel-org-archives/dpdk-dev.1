Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9943CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D07342EF9;
	Tue, 29 Sep 2026 18:39:32 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 3D7DB42E91
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:39 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-86efece610cso2239037b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699918;
 x=1791304718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6GnF29wGs5kq37uX8acSSEkksNimQ7Na4wWcXwJFLE=;
 b=E6hJyEuDdXNohZRw1YZVmjZuu234eWZn1EWEIoSV0oZsoEdTXYn0vegpltrolHp5kD
 W6/dzygdeqxlt1C1ZdKWgUgA7M8ZukPOXTWWFOX/fwHap7Syruio/DKDsCkHa9dyXTOn
 t5K+7msHQyIHVaoeLi68s3SiqEBZ6mCqnt2QcK67xzGQVMBYWIKEM6JrnjNDykzCB4/1
 HNocAHTJ2mohUs+5tgYo64+TVCtSxmSv+aV01utORoVHV1BWm1Vv6taukSIPkRj8HulK
 +F8V2fthoXstgkLQcHHGQAIee+gTxGtpyKo0fc6NobNR+mxH8vzXVbL/gJrHB6knFbyd
 5lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699918; x=1791304718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6GnF29wGs5kq37uX8acSSEkksNimQ7Na4wWcXwJFLE=;
 b=gnDdmOpvptJB/huWwEut6Qs+igUA3Xq+jTBLoPoaT5blq/SFrTqeuhqZL2WHsKPNS+
 C1uUwYd7e/lu13z8ZtZlx7Z1j+ssp2sqpGrqpJ75qkutnfEX4ufcqJCET4/chQzcl99M
 sTCHLBw9d7rhtopxZYo+phD5MqD8IR9zBqpj9yknqrgezQ0Bmszmy1O3H879+feI+dLt
 s6I2lRe2gOgZtFTSWFRZuSurd1Y1ecT4XZ/mfJCSeOW43gV4vqlO20iA8BE1kTvhUgir
 m7pwRvHlBBDYJcr1OlhQd+teSBcKb/Da4cf22v4+UNIhUlFN+svuOq77k//xigfqE+sn
 WV9Q==
X-Gm-Message-State: AFuF++mvrB4srUfMtyz70X+ypROghcmQdqp4hvAF+AagRKcLY/H50E0E
 XlFMyd8pIEmhczYscpF83sdtXqY9FUISSuI2ZtW+pVMm+IfEj9fLqsUKRHwh7/GQRvIUr+pxlwy
 7FNiZTlo=
X-Gm-Gg: AYBFou3PcXyHbQbDgZ0OMUHzVLu0qdwUxDlbj/waYTT1DWRNLbK9h0++sf6dw2ejCJU
 S2uoQ7wMVbve1g4FJaM035msvVgfB7vek0h47G3YgGuTo5wfSRPxbub/JeqQoEEo86qJ3pL2AOG
 Rd2ydal1S4R2wDSzBij6Xver6MLeqYxiFpnP1V/OKjmwAUSzu2UPIvswftPojcqLVE/OcQa1jZR
 yaLZbVK4DX3VXy/m6FXj/1BdywgN6FwkWOClkJbqFnNz7U3TeEcePumwbmEj99rAC057jGe4huI
 yq6jVdOPq0qFk02YjIOly4VctdPQSn7nMdwCiChSRYncyK723dtiYldiGwn48mB9L9ufd9OjWQB
 6fPtS4KEgj/JaCdiR/kX5uNTNaLmsPzKSv33pC/f1/HwOti+5UhuockfvlZfh2q44Fxlp9u0X98
 XXHpCmDlaFHI1OPRDxAxN6lLc0UGSBmO0Vl/Agps+gSMoiJY77yyN35HgHyUzuVAqBCaaJq2OMn
 RjxEefG6LWqKct5DVqYLKx2uFNcwXxKQMaSqA==
X-Received: by 2002:a05:6a20:258e:b0:3de:5a86:9dca with SMTP id
 adf61e73a8af0-3de5a86a2dcmr7234574637.19.1790699918423; 
 Tue, 29 Sep 2026 09:38:38 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v2 34/61] net/thunderx: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:37 -0700
Message-ID: <20260929163800.1108305-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

nicvf_parse_devargs() uses atoi() on the skip_data_bytes value, which
cannot report an error, so a malformed value is silently taken as zero
and the argument is quietly ignored rather than rejected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/nicvf_ethdev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 30d03f4db9..aa45bd96b1 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <assert.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -2161,9 +2162,17 @@ nicvf_set_first_skip(struct rte_eth_dev *dev)
 
 	for (i = 0; i != kvlist->count; ++i) {
 		const struct rte_kvargs_pair *pair = &kvlist->pairs[i];
+		uint64_t val;
 
-		if (!strcmp(pair->key, SKIP_DATA_BYTES))
-			bytes_to_skip = atoi(pair->value);
+		if (strcmp(pair->key, SKIP_DATA_BYTES))
+			continue;
+
+		if (rte_kvargs_to_uint(pair->value, 0, INT_MAX, &val) < 0) {
+			PMD_INIT_LOG(ERR, "skip_data_bytes is not a valid number");
+			ret = -EINVAL;
+			goto exit;
+		}
+		bytes_to_skip = val;
 	}
 
 	/*128 bytes amounts to one cache line*/
-- 
2.53.0

