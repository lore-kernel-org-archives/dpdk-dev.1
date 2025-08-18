Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA0CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E9240DDC;
	Tue, 19 Aug 2025 01:34:00 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 72FAF40698
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:56 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9edf0e4efso3290945f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560036;
 x=1756164836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i//J8QWfQXiARFwRkwEcx2y0bIouHBpgLy/Y/cMkTpE=;
 b=rrFmt6bhkZtSFB2JIGBbGbvGr3gIk5TYZTT2nHadiksyP2xqToD66P9ke/m4n0Rg1P
 ia3bqcRD7KxD79Df5L4H4/0xd0isaA88Jg3cWvtVJNbtVSmNxQiNW0zKGTZrWvNivCOQ
 eGFS+We6RAeJTEDObl2NPFIX3l6GfH9cTteCLL40YXM5uYPSVLk64XMjp2/uS5bjT+Fv
 aaaQUsvHt56gP7M3VcgDgWoKHuPMSQyEQigMKP+rajXruUBySUMqOU3Hj3zmAaM0S6EU
 PoOpxS4K64mqlJ5cowQOgS0fWhb6UlvSa6i0fyVtl/uovQX5yh0nXQDSbMKbbGOiCJVu
 oL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560036; x=1756164836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i//J8QWfQXiARFwRkwEcx2y0bIouHBpgLy/Y/cMkTpE=;
 b=aNL8UJVBKjRjD3L5vS3V3iRq5nQEX5zhbIwzJIaFf9K/sYOcLOq6+FNn6AA4A4KCtH
 E3p9w30iRTAMpUH1aQ2999IwQWpvUiNCYmLkK7QOWhTvaihiwOZDu1N/6fYUR/FZQVWi
 vMF5szC3FkUV0A/VOPoywa/B/C++gw9TWu6xaDHMIY/KbftPYFLf1NnTSmSQeMvnVh1v
 o30+5vRZjkwAHxI/nhWk5M7TYYG245K3cc2qMW3PXhUCq3NVNBH87HvhpjoguGahWlZ7
 rC+1Fqtd1mCFsGNyFeCXZ9rWbCEHGeLa2A8QcxyuET1n4ds0Seruwlx6XVV5Vr+yQCZj
 G4Ug==
X-Gm-Message-State: AOJu0YzAXE895W6A0neHG1pmT0HVxj2N69DCEP1cUyYH2vUZ3t1xbO/o
 kf5b36Y2gWzfhRt6f5Es3YFk1vsKxzk36Se9IUt0ssoDWt/F2GqKZJE+5x6IoDkApOTuYLKLG9q
 l4h3E
X-Gm-Gg: ASbGnctaQA+reH975Jbb/6/mI9MSQuRE2ZN4Bv8ZGzxxM9WAlBHjSXGP3Pmt+zcMp/R
 5DzRug7aNyYZxPUOAUppwVMZQLzakd2ip4l/5drEYKGzHf+v9Xl/MOUCuwdjd+ALP0I+REEAANB
 KRfmdlmTBOTcIR938e3vMqQsJ3qtCeBE9x5IVorHLzFYkEeSW18chIET+eCW/Ak4EvVjb/len0b
 JpGdDsFyfW564b63xErEObGc6ijeA0yWOccAVzkmQuflY0BiCm8meQZ5vdnt64GMBUz2DoBeDp1
 sCsfjOOX/moNygtv+S3ByStANCKQUNAN0rB0qYMnzv94aE+vlFWuCJe8sUzMi4EwBn/zVC5vKKX
 yi1iiA5johKZqJP4OvUspURn3ufpaKWmzldPT+aKYB2bCby1iwXlCgdTpFIb48KcBL47TCZcV
X-Google-Smtp-Source: AGHT+IEhhUBiXIpY6htq9xp8+EsUnS4gvqPMf2OOfg5/QTHh1ytDjcYVyVuHAJn5lZtXSrb5Mi0SSQ==
X-Received: by 2002:a05:6000:240d:b0:3b9:132a:a554 with SMTP id
 ffacd0b85a97d-3c0ed1f3e04mr300440f8f.51.1755560036088; 
 Mon, 18 Aug 2025 16:33:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [RFC 31/47] net/enic: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:42 -0700
Message-ID: <20250818233102.180207-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index dc1d16f7d5..7c16356a58 100644
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
2.47.2

