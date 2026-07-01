Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D98C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A9540285;
	Thu,  2 Jul 2026 00:37:07 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8774640279
 for <dev@dpdk.org>; Thu,  2 Jul 2026 00:37:06 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8000e21f014so17403937b3.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782945426;
 x=1783550226; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X4dGOK17LFySI3T9SsMz+f6pEUALx8dP/Je0nL1y/pA=;
 b=C6j4kNQMR2uo8c47U6ZkRUYacOLQtwTyQks4o18hkkeJvpfrqVhxH/eWf7C4g2M7p0
 VtQD4JeYnnFmRUmD7YBCHi/yiVFHmw40MvmrAmiPmfOIxMim+xUdHopblZ0hLBH7AASt
 AU/q4gKyOzYnYTXaAJ9/ZswgJt+p209mXKhLdj0o93pBFLhAWzz5+qubLBgZxx744+pk
 RyXlF42eg34+u2DrJSrbtXrS6QTRRMm28uUzPoET/I0dikXrUYpuTi3m6hXptzyUAr9O
 sKMKFYP/dlfoWCHiSQX3T8Oa1IULe+JhChStj3k+RFrsbQAD1UHNRuaUjKI6FPKFCNrz
 rZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782945426; x=1783550226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4dGOK17LFySI3T9SsMz+f6pEUALx8dP/Je0nL1y/pA=;
 b=qviLUfv4Sp6TAfbFr8V8ElxYqLV8VI4r6/JvW9DL+0BRxPXrGi8PpMG3U0Ituz5Rjs
 a5c2dtLbJlOegV0DRuBJCAG+co7qoKwe2QAV9X8R1myhxg/wz1OAR/8XzCSmFobWhlJy
 nQpjhElORt74b/ZOtJS4rkoakkwIfA/0c5muVY1Cs6rXepxXRuzvU97VF646b8nUD+kq
 PhXjJBrT5OvBwlbygBdfggdn/M/aoLg44XcygRVAE9dOy6EkD0Hx1JeFcXAaDMsHX3NE
 t5XgZvDfls72gOv9cMKXRWwunfXWUprlIWqh6fXW5vvTRWyBw3lDfnDHVmq2fTq6KJ7S
 EA4w==
X-Gm-Message-State: AOJu0YzeCeSgiiHJMuXxFf7jW7Sb2PxcFynIyI91CbA/b5ZnCm9kjVv7
 bY0Kmb4nXd0tZ1r4xKzO37TAfN7u5fJ28nHnupYorJNDO0p35xYlBTGBycr/paIfPcUs1BKzVAC
 F/kWy
X-Gm-Gg: AfdE7cl/Ggx4uOz+ilqVPS20OroVtSssRbWymyCujtXjmY/NvKOk0AVNJrEWJwa1auC
 WmrP64g6ntnTnfdzJY0C1vL0LKs8GWbvZR9W94q7OgjmVIDvNawtYUDyR4NDrLKaeTLXHbji8vB
 w96ey9FuziUOijY9e3hePDNd0NV7/1lNrro+1erjzrFZsluexxVxK32b/6gSvub8oJzanPOVCU+
 cqWVz9MnXt5l8wMq91sFgPMzvgp5Z3gDtplWmrQiXz4P8YmWNnMMC13iTB4t+m6H1wcpXQVMClQ
 x2/jsKhPsIkLIkaKMVi3EmtjO/L+ggMoWvyad+hRg80lNiS/g6m1pFr5P+1e0NgsggruslMrQiV
 ZyIrDhn/UT27sJ7LaQcnh96OnXZnyw1+eDDcGrO+XE8qCZcTAZnogegdZH6+O2f/RUgfava5aoc
 SADYrrTfXwUnO4inw3SMC9T9ljvcq+LVl25oIqIzsVBeU5UCWTS84=
X-Received: by 2002:a05:690c:4d47:b0:80c:85c6:8993 with SMTP id
 00721157ae682-812ebe614b6mr43275717b3.66.1782945425839; 
 Wed, 01 Jul 2026 15:37:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8144af52027sm5530707b3.25.2026.07.01.15.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:37:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH] test/pcapng: add some leeway to timestamp test
Date: Wed,  1 Jul 2026 15:37:02 -0700
Message-ID: <20260701223702.105995-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The timestamp test sometimes fails on busy or emulated CPU's
add additional slop to allow timestamp to be up to 1 second
after capture was stopped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 298bcbd31f..d14ea84f0d 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -440,7 +440,7 @@ valid_pcapng_file(const char *file_name, uint64_t started, unsigned int expected
 	int ret;
 
 	ctx.start_ns = started;
-	ctx.end_ns = current_timestamp();
+	ctx.end_ns = current_timestamp() + NS_PER_S;
 
 	ctx.pcap = pcap_open_offline_with_tstamp_precision(file_name,
 							   PCAP_TSTAMP_PRECISION_NANO,
-- 
2.53.0

