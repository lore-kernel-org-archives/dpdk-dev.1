Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E49CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E09CC40E17;
	Tue, 19 Aug 2025 01:34:07 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 0E4D140E15
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:07 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b0c8867so38894195e9.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560047;
 x=1756164847; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnATGGGuuNyCq3XA29IRUndEsafBleSf8jku8O9QELU=;
 b=pEzCQBA0cd3SwaHP5uzBMlCeQkAS8FMkA42V91xhhwFWTezpu1NDrYYqek+F2J8P9j
 BP16U1tJrBljzAR3UIqk7nS4FALOoQVgaskrnUn+sDfrY9fQ1FXoPz8PePRbY+ocX77M
 F1LrqgjmEwj5rY924+daMnmM6PGN3u0ZWTm+Nf67QH7hXmgyMD+RBplhZ58ydSAHBrwt
 DCFM3xTB2mVJSsyUeVPLXuDZwednaIYAcbmrW63lfOiuSPO8bqN3NyYOkklLHGmXSBJW
 VU6ofp5ymMLOP4ngQiOzlIbzp57GdfqYrOS0j8QmSgieeWlYx++uByAiTvh8fj9ZYOjv
 2tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560047; x=1756164847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnATGGGuuNyCq3XA29IRUndEsafBleSf8jku8O9QELU=;
 b=t46y//XRfOMbGQ+XO3x9OU4onp6RT68+ozKILSvlklrSgWqfcjHDjvgrHoEDdMBFD6
 UE+ZgxcC5xK/Kd98u+R42QR0VcdkPQ4he+P8abxXwvhtnLV8kRKMUUmEMj/o0JCh0p4p
 xW8P/UesG/nh+uhy7culDPNLQKVNDVXjusEwVQJgqPlGsslj0FeVLIivOYs4Sz67xkv6
 30od2DA5un0MXj99Fi90XbnQvXCK1nu8RxopQD2N05W5aXxBC/1pkJNxwM/OddQoIriQ
 c/bEsEg8GUM+bFnmovCIJPw5Kr/Vv1zSIJhnalhBC/6Y5q1pbZskHvgAnSgo/dynvS+R
 uKIQ==
X-Gm-Message-State: AOJu0Yw2oXtPTBcYprIhk75Aq2AS37O3pByg2T5/CKICcigZdZNklEVX
 zS/v5qE6lLyWkYxhzgIajTNw4jFPCQMrMlUMy//wJFYx3w9Ljqs+1E7vEWz4oJOMEbTMN+iKLfC
 h8laN
X-Gm-Gg: ASbGncsNrHUY0VtDzuRaULYIMZJHvZCnwfiULG0VL48PIiU4sKvNgCDvRosvvWwswlh
 7Zxz8eWV1CTTM4qHxcWAWPRdd99ksTh4eIeSaa8i5mByr08zx/0KfkHJMooAQvxz7V296vNvc+I
 06CQkclyc+yrRoTF4Zr8yZ/4jUwZle1j6OtReJT72t2X38BK/1x6DwucOT+9NvAUHVNl5rAlpaO
 ODMYUOkqn8Qi5cI6p62QwciRrzfxguyhBPaxHrpzk+iZLTRG8DMIkMN5+weqEMzLcOo2MmeUT2x
 C5ZdxngvsEjp1mm7eG+kTcBbGkXa34GHAOsOq+dnXESoDjEQ+pkJqCrsDjrrdQjTD8xjgmT5QzE
 xIGL4XkDfnAcqkr/FZJV56xI3K3QywusUqLYlNI5Ca48JknEGJb2Yu9W4f24l2R1d1VESgEF5
X-Google-Smtp-Source: AGHT+IFoMEA/DGcLEipilIUsIMWHnblMGjgziQv8M1+eP3KvtyJn4weztNRbasT76Q7/llSp3NlCTQ==
X-Received: by 2002:a05:6000:2409:b0:3b7:7936:e7fb with SMTP id
 ffacd0b85a97d-3c0ecc32100mr283418f8f.30.1755560046628; 
 Mon, 18 Aug 2025 16:34:06 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [RFC 36/47] net/ntnic: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:47 -0700
Message-ID: <20250818233102.180207-37-stephen@networkplumber.org>
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
 drivers/net/ntnic/ntnic_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..dac1cde891 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -16,7 +16,6 @@
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
 
-#include <sys/queue.h>
 
 #include "rte_spinlock.h"
 #include "ntlog.h"
-- 
2.47.2

