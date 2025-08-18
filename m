Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E581BCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 179834060C;
	Tue, 19 Aug 2025 01:33:01 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 54FF64060C
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:59 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9d41baedeso2485902f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559979;
 x=1756164779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rt6ye2/tOaA+8gY2VdVNb2cbOT/xtkdqVDFjmTBrIo=;
 b=CvTuPNKqRHr3PgnyRTvp7zcbzw992RVwLu23KD0aiSDn2U/O7YasNevbJGXkb9SSKu
 6pYCBVpngk4sHDF/ql6aHS1IWRqZRvSyHs2c3OZ9wJC64e453Y/4Q5n3jMS4bm0fmv7I
 2LsHLtZqs0oCu2/PRogjVywJuzjJjerajfUHipMnFyN6Ni97cRZG6xwGdXvLAFSnsjh9
 j3s4riNOswgLfi+SfMj6fqfhjvymlysDEFXvrbpcGNKOX8v/ALHFHE7BlwViunA5s7bu
 Ex9kVqBWVMv61mIST9xb4iXEB5oy5aysui4jGpBvIvLyQYamSW7VQmyjWh92mTf68NVx
 B64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559979; x=1756164779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rt6ye2/tOaA+8gY2VdVNb2cbOT/xtkdqVDFjmTBrIo=;
 b=qp+vkxuTjiBb7ejoby1tFi7nCf7aHYAkxlhfbiQkNpDlU9Odd4ScYqFL3yZceKi3mT
 8fEUE6pCA3NEp9eHow+SJ8+hDLusy03sz0BJL1mREjLeInyM3UxfNtuHrkm+H8E4gOgZ
 ofFbgCJXfbxJaTOF731NfU4J0/+xIQP19T4hJaHJImwUlpUxdzDcgtHwm8e/UWId7c1D
 aIchztMVZf9Z6lI0UcoiTzbvL2DHT4m2maAvG2fRgr5HO9NX5xQvOHHfDMMQqov+aVNx
 7eT4uiii+zAzGsbK9qWDed4r/GnRIUP/Ayrk7HV7jYDDPkHbriXb+wvJHI5Ymk0KEnmI
 R4nQ==
X-Gm-Message-State: AOJu0YzC3mOK47oJkijjGvXjr/iWqIpnQl/aN2EvcaYFhcstS6JpAcCD
 hXoXDKpkw+dsEqqmLeVrRHFE8wA0x76w3X+i0aihMd/NEvktApl3go8nn1N5GY08AfTCTyFR4NP
 Fv7PT
X-Gm-Gg: ASbGncsBVu7lpz4PNYDCA5CXJoVhtaSOZZvCc/VnCWETyp1SwcmeKj/zKkOtWBvdtnA
 sd2fbyd0QjpTmrQ7LpURUC3jqLOcZobwJ6+OhWpLodClGprMBu7NlntGV/gb+0T4JGSkBKYn4v1
 KGwzLwm6nZ/4b9gvfqG+7oNPxIyI6nS6jNQiUybFUSU89kiLzgagQ/V8AGxfRSepDSKHdUkWuih
 9nw1FPNZoJLUt+HPCO+PwBjYfyxADiZI4Rl+K/5rSfDpbDITvRnHM1Ct7gltkCtFmXELdag2oY6
 kqgINOhewDGYpu60m+cdjpYa2e5HaaeLHtJLpsCn0vlIsZBSbbnD/VJ8Sa45VRLaIzrxjIide22
 BTa67b2h1E2Fm+z61i6JJAf1v8k4GgmuKG9Hcy1ivfPZ24YLEjAytx8UinXznzKhzEtu0+5KQ
X-Google-Smtp-Source: AGHT+IHpuSlNXe4tKmHMyjXO3Pi96j4AT1Mi9FxfxpdXgKIUhBo1W087AWdrP9Awidj0J1N1NGDRKg==
X-Received: by 2002:a05:6000:258a:b0:3c0:49b1:2be with SMTP id
 ffacd0b85a97d-3c0eca488b0mr281012f8f.34.1755559978900; 
 Mon, 18 Aug 2025 16:32:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [RFC 10/47] test-eventdev: use bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:21 -0700
Message-ID: <20250818233102.180207-11-stephen@networkplumber.org>
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

Use the replacement bsd_queue.h header instead

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/evt_test.c | 2 +-
 app/test-eventdev/evt_test.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test-eventdev/evt_test.c b/app/test-eventdev/evt_test.c
index 72d6228bc3..4d1b1689bb 100644
--- a/app/test-eventdev/evt_test.c
+++ b/app/test-eventdev/evt_test.c
@@ -4,8 +4,8 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include "evt_test.h"
 
 static STAILQ_HEAD(, evt_test_entry) head = STAILQ_HEAD_INITIALIZER(head);
diff --git a/app/test-eventdev/evt_test.h b/app/test-eventdev/evt_test.h
index ad3f531dcf..30b248d5db 100644
--- a/app/test-eventdev/evt_test.h
+++ b/app/test-eventdev/evt_test.h
@@ -7,7 +7,6 @@
 
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_eal.h>
 
-- 
2.47.2

