Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC585CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0220E40E03;
	Mon,  3 Nov 2025 17:49:58 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 42FD340DD1
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:53 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-340cccf6956so1349312a91.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188592;
 x=1762793392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSrgqcmebU9qncubTm1MGUSfWD/Y9GO/SzcoaaXNEc8=;
 b=xzu8sDVl6HVLslW/Qp5wx2AMINNs+rwq9dCvvf/jpr/eH68TX3tqOw1DEulPx0AXj6
 PjvYshLq08rqLdF/JnkX4npM0FsNriHI4FqBAFAu+FtkujwYM9jxYFK950SbN7Y8/mqO
 9RXLQpssU9OwVRWCc1DbxCQhqTAEMQ7JRyjEUkrEPhinjC4/9LxBdaI5gAwcXm/PCcYa
 5Rv6PI+pzFyiRM0sBOtA8cweM8kKXRCTrzhCiWVgU7/2qCOn5EV/zaWdyJbLs0kHzZHQ
 BDTN0FVhkFKpTtM28y1kHf+bBp4xcaiRzf3HOBhM2MbmGndvoH58w02152imJe8tPIUL
 eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188592; x=1762793392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSrgqcmebU9qncubTm1MGUSfWD/Y9GO/SzcoaaXNEc8=;
 b=dFcuwmYYD+f9Bh9QcKSIQ6cH0omNr8ACeti14qE7FN7uXddluZLGwruXFXLWipWQys
 iX3m/LrcXy4hVsysCmfkbi/3KQ6df1BfP+pkA9qppK5Rs/ysV7Y97JSQpwan1bXl0FDz
 9k7vFwGyciaxOM99RZuhdN0NsihWxiq+Rn/7nGXqfoWZe5fmFHxOsrM0vxUwB2JuBljh
 Pxl0xlLmBVdRrtyda763BIZr+6NaN8DGzjwtz053k2jywBKXYhs6EZaYFy2jwrNBu/3g
 P01JURF+lcMvK4eWt1S4tZoM8QcmDSlMXwtwwkYmOGWgj6aIy6uymCVZy4B23W0Lj5d3
 yTxg==
X-Gm-Message-State: AOJu0Yx9dSZjszJCGDhaIcBoxkcjN1JvNXOaAQzBSqlwIkK8yT3tZxni
 ksWvA6OxCQ7VZw0vNGxiVIo1BmFm2iJ9QmYNgn/9fR+2I5VOf56fQQfrPADu26i/J+Qm/9AqyKa
 Tm6TX
X-Gm-Gg: ASbGnctRXfEH4Oh6LxhgjRcoc39kYGDHrIOeRPt3lRGsB0F7rhhplv7CukReHf75uxG
 DJI4x8Wk4x4TBbN4U65TxfZMNTmKjEYoLo12+tHKwiSR6vp07zXG/r7BwUcQzRIZSF+lAngxGvn
 Uc8j2W5/tOS21198ZRFzY0GwtyA4Z+QbUOcO/q7oCKghqiKuWImoeemrfH8V2uC5z7jv/ZHGF6c
 OOH4C31/b5l6izomVppmiBicCdID3Nf9IDW7Y9pVMB7+Kk2DWEuRUo7zyfO5gTurECbbp54z5Ae
 8NDkgZM8BA05JI942Ahq0LRTf9gCfvwuO7uFPKY898mZKIe9ot4vE9zzdB/xm/vj9EZw8vx48i1
 EX/jGvwoZpj1y4ndZv6eVOZiOut8O5n6etxAlCnVUbCtGYtYCOb4TSj2iWCV6VuWPlXAb8zCYv0
 cR6yOTxoJbf9neHixkwMGq5MvzWVYYJt4deAG/DLg=
X-Google-Smtp-Source: AGHT+IF4Y6DlnfTZg/P681Ix6MPGW4Q1kW1e8gRBaVWczC0J0JQbeiMiuDXwrlRSpR2gpe3+xDTOYg==
X-Received: by 2002:a17:90b:3a8c:b0:33b:ba64:8a2c with SMTP id
 98e67ed59e1d1-3408307cd82mr16570785a91.25.1762188591850; 
 Mon, 03 Nov 2025 08:49:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH v3 24/44] net/enic: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:29 -0800
Message-ID: <20251103164915.101713-25-stephen@networkplumber.org>
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
 drivers/net/enic/enic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index 87f6b35fcd..163aff226f 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -21,7 +21,6 @@
 #include "enic_res.h"
 #include "cq_enet_desc.h"
 #include <stdbool.h>
-#include <sys/queue.h>
 #include <rte_spinlock.h>
 
 #define DRV_NAME		"enic_pmd"
-- 
2.51.0

