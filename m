Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB1FCA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E6A40693;
	Tue, 19 Aug 2025 01:34:23 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 3875840693
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:22 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso36289595e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560062;
 x=1756164862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeEr3yvAg8dnM1r0SFw914iUL22iKidYALFFDVVVb7Q=;
 b=TWFmvWKUiK9bRS0M4BIcpXqJZBxvEEXaIfegbyLLEbHtQBcCPTG4A3mnYKoNA0Agbt
 lDQAJ3PwZGXP8fT6gjYeHJkw3CsLM7+gpXbLDakRhljgLaoberXrDJgtPuSr7CBseBMt
 qfbqXFQJzrgwM2wsQZ3bENBACmj3UgcVHinV6C10dbZ6BB8stUzPtHDYRp+fBi9clb3W
 qAVBWWsccvELwPrJt5kN0MZq/aB089GLNQtZtUpEhqPRnNa/LAVfkXkaro8/bLePOzNq
 uahfsyypwdx/eSmHTzTt5A3LHeFzVAEOvJPMAJJGwNRHpp7KWeN3rAkyvQzltB35RPo+
 uIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560062; x=1756164862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeEr3yvAg8dnM1r0SFw914iUL22iKidYALFFDVVVb7Q=;
 b=GdeeIiq98amd7afu2JVYL75E/1kCM9xVVYd6uAq+WCEGuM4jYx0HCA4wmgOvzoYnPd
 kQ+Fv1IU/VIRcdw3tAhc9YUCUxXgk/Hnq0IIRIMaa9CEFp7bCfcDSrQD1Te1DsAIyoaD
 809uutFXCaY/4IvytmbkfHK/rSRYhgk/2sjtbrsjeStqwue3pc5+xIuZv4WakT0XVDIS
 nRAPmBB+dFSXgSA0pnfrM0b6+LVYQLPpAlxAIujkdjDH/N3HLhw1fE20GMIR2D503XqE
 3Z9Dd0TY+WlKVhI7Eee4YGx8iayJaboTbifgnKaj37EoCHHQF2IEZnh7i7Ir4BkbI2kH
 wg/g==
X-Gm-Message-State: AOJu0Yy5kQ3sVfBg7IQFgasWxDbWy+zPold/Ad2ctBy4nd6H73eIGbR0
 7FcA+9qu2zh+DscAKR7lmMEuQZ0Cj63XXWYnqvWpBkmbb7O9T/gsh2EXiOcSKxTNTkht/IQR8Q3
 U/sYn
X-Gm-Gg: ASbGncvp6vRsRP2F4veNSk9mBc+dkRXKkfAs1uVOd/bSgolDZ36OKkkGMkFBFzccMYG
 ayt4qjCssfn8zMllbJVN6tHsXXtSblPbZ1lLCXi6UhVBl5C6poMDdMW/r6cDR75CjbJ+30i8mG/
 SPNtaOst5GQL/k+w05ToYn2Cc+8hsMpIEG0XGL2rkg6FBVCjyg3rLETpeWq2olsd7K7N5EKP7CR
 VBOUNLR1nqQiDkNx5ZdGc2/MLX6/0I26c1V321UxgfbPKgyEuTt19MdCer3HhCabiKIPMHUMxm9
 PmpnBGtapyYiRKysBKRb1uUeou5pPkysHjA/y37Ubbc87n0yTeoQ8y+hPDlAHd4kCLuOMAeb3G8
 qf7XE1AW1owXO61hdD6DPuuQbvZpwKecl98yRHgWRJI9WXEOSTjxM4iMaaoENSINMcUjzUG8k
X-Google-Smtp-Source: AGHT+IFXxahXUUxY1fLy/7+waFmrg6Tyi9AVT7sR7iGWgCavXnbfq6UD5tOCLAq645L4olasbBdcVQ==
X-Received: by 2002:a05:600c:450a:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45b43ff6be8mr1594155e9.8.1755560061858; 
 Mon, 18 Aug 2025 16:34:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 43/47] net/zxdh: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:54 -0700
Message-ID: <20250818233102.180207-44-stephen@networkplumber.org>
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
2.47.2

