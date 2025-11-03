Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DACCCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7353F40E41;
	Mon,  3 Nov 2025 17:50:09 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1D21540E2A
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:05 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-29570bcf220so23568825ad.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188604;
 x=1762793404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQM4YOkDBI5WcJhrwIs0+8CzFhIq9v20+tXWCFYmjXM=;
 b=ilPznWdSSVLdBgjOhlZin16AvFVifIxQVTgyQ4UJp8omXEqGzt8Al/dLiK9m+ZLeFV
 irT1smGjHMIza8J0/3Pgw2SaTsq2/2GRZjiteMHHnIpixM7qF2dqV6zFi7EyiIJb+cfd
 anydgzy20XXvsSslTlpiZHy8OlRUnXeuKgFdhzvG2aCbe3SrsE11e88+xO65oOzxK/N+
 Nxjbz2MQx/e+Nez9EUbgm3KL33bPcSNnvFAo6PARi4fGzC9axwgXF7rXdqi/dg1QU9A0
 Q113Ci+U5D+vR2Kl2sT/sysTPM6S0ht18dVU6tKYFhq6DjguRKQIk+uB/qpmlUljO2A5
 p6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188604; x=1762793404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQM4YOkDBI5WcJhrwIs0+8CzFhIq9v20+tXWCFYmjXM=;
 b=ZHV5lE/axFPvL6pF1vlFq/3geqQ1vURfaJ1dNGWdP8uMWix4At035FA1vEAxCGGXHm
 WTuxlYtQ5VsDw5qQIx7e6LwWmG2sAvfxDdVgieG3cwswHasGtSz925gFbFV8NwL9M4KW
 qNxqRr2X5m8SwzXOP31Guki1we7LxrS/y/yCLqw5J6aTuJd7nXQUKiU0j4FfP+C1jp6t
 bG+wtdHzQ7xAr2BjNGtN5HZBsYaORv2zhKoWxfDDzajSzUNZFX8h1TN5Po0IPCdxOqO2
 s5P86H1yHmU2AMm+f+IAjsoWkH4ExJhW3Caufdjry5Qqdhwj/1a/tfSczXSmusaoeZY1
 p8mw==
X-Gm-Message-State: AOJu0Yy1vfC9puYMhRPLDn1J0Zx7zMbQUB1LM06kflfWoBUnxNG6zuSN
 eCUtLNEM49lkh55DOCEgaWxpbDSG8ywZV0sLDUts6cYtsF1aLMmyutKB7h/spcH8IiNiRusZSYW
 IhylR
X-Gm-Gg: ASbGnctJjsDvfMWfifHuUuFC3QfcYPRVWABuAojfW5a/nUd/kB1q6AFXKRJha7aA9Zt
 KV1w6OtgBZFvf7sF4BCcQSomTDwe/5+e954rlDIfzG2br9GB9JDkBaOgJsU7FpNz8E1cPToZsYr
 jfOWr504oxqZ7rFMx+ZXbcvP1NTuX7Izoh2ZNwmnE6rnY1wFmXCh6KAeb5Wg/psF7ulV728M97z
 Eq+SCyietwL2pldPugbF10J9rnVqXx4DvA4oebKE4WSawzvP6v0aK6c2LCwnWdH/EHOd4W2bq/J
 YXVjBA2vtVxvGw2b9yT7hAkLgJzRyRbL+HHbK0dKeT/R7Iy3VuS+LpeXXtEE8wCavFv/lbyCYpf
 pDVd5A3iscPIHYt167CvdtTXrpDXKlO7JjqZXo6LHTN+gG60KkFRxlCNrU+U3Zb7jIkXnIxaG8E
 1d9WuWt65mG4H9Spcv3qiwMM59Q2YGt60+VMvMwfchhLnp7AGD1Q==
X-Google-Smtp-Source: AGHT+IEiMMwGyS5qDz5Fz1dfetBwYWPp0ogXj7sa1MoutW5XZXQlut4nmXktZEBoZvag0oX486p/+Q==
X-Received: by 2002:a17:902:ec8d:b0:295:596f:8507 with SMTP id
 d9443c01a7336-295596f88e2mr98387085ad.0.1762188604235; 
 Mon, 03 Nov 2025 08:50:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH v3 35/44] net/zxdh: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:40 -0800
Message-ID: <20251103164915.101713-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
 drivers/net/zxdh/zxdh_mtr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_mtr.h b/drivers/net/zxdh/zxdh_mtr.h
index 3efcb6b591..4b9b409025 100644
--- a/drivers/net/zxdh/zxdh_mtr.h
+++ b/drivers/net/zxdh/zxdh_mtr.h
@@ -7,7 +7,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 #include <rte_mtr.h>
 
 #include "zxdh_np.h"
-- 
2.51.0

