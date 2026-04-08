Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6810710F995A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE03A4014F;
	Wed,  8 Apr 2026 19:04:13 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 6E0284013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 19:04:12 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso68475a91.3
 for <dev@dpdk.org>; Wed, 08 Apr 2026 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775667851;
 x=1776272651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P+I2t2ygQ4vBAN50fmwgtQi0ULsSfgTXucsYHFSqfIs=;
 b=eTgNKCMqKm9D18ghgetdzDt5s6/JQRQvI/Ptdp8AvgM5Xa/iYretAkRhAxqkpmrLMr
 njRIzSjQgszOG89nsdl1689rjo2vkgZfXN7CB7SYMfmYIER1ASvEmetNvgnV3zLV0mAv
 3Bl2eL3uhsY0OqpCefFoCH8s1yZ5VMG1cTpuxKYWSghbVIz5GPjR8a/sYTWAR8BmkdZq
 QI80TUJjPaoDX/OllnzjP1dt8IhocKB/oYLY/E+GdU47awpR3vlAEzj+NNHDhNtyi9pG
 uNMD6kQTFiwROdpjp4El7EqXogcNyYhIKKfU85uuFuFSkFDimSEzHwRCgKIzToqt+Tfy
 WsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667851; x=1776272651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+I2t2ygQ4vBAN50fmwgtQi0ULsSfgTXucsYHFSqfIs=;
 b=AawVh/O4KxxX6gT8RC15WMCSRtWCNzNz852Fwp2Xwdrq83nfQEoNWaDkcXXvsutVKl
 jUsoCVDoUYVbj4L/5Om3kw7Nn/vFZck/r2y7V4WdRoos1vT+T583yEC14lqEUnzuPGkQ
 egbO8EQKoE55Sq1W3S5FPSctSYeoaQ8L/of9S8051hbb7kNrsCSds0Vo0+YctdT5oeOc
 nkzkSn0RLVl7X4tGrvaObcxm5pTN/vcBqNWZ8RoRSvPJj7Cvp/F/9SYRfPIta/M/u7+L
 AQiSSDqG/AH3t67cY8RSKGGoXW/FNlq+Koc8RnwYv+jIX93K7jxAc/cgbCH1s93ssdz/
 jvnw==
X-Gm-Message-State: AOJu0Yz3hmMI9oSJfEciovdIJcmrnbsD/R18svFCX9WWZuQrYqU214mu
 Z8w36Qt6ZmjTCj7r8lMcVzCBCbNr54fy+0bKpGeVngdPoWNuhJFzzyyw+MXjyOKhkdRisYo5C3H
 bAjwA
X-Gm-Gg: AeBDieuf0gBzEko511l9M+rpAgLaHjRsqHXJuzIDEiLjYBd+kKuLfHaAY6wGSUl3HFf
 Z2qeH7/vbjkvCqyE+D5PSDiIdD9jjBeUyHbFLQM8GgFJjBShk0zlJKDlPfFo4xod9N3n/lz++Qh
 rWCCibxGC8jhcxe6rCK3MtOyEPxvktcf4mm3t8FgN8N0BpHvabCSkcPjYsEXWTbdj/vITNUN/VH
 9o+xmLk2YyB1sh5xgsZZgKynRFeRW2gVHtx4Zd6Wb1Xhksce0QEGsQ/EN7WjrfdoftIK+bPVV3O
 NCuEFNN6f1YVprlqyHx2plqhrx9Guf1FQmstrFuNCkr9Adfv88uruntAtu/fJAaUylb06A+/EUP
 MizCbynwPOBMj3udh4NnparqifnAfiyTvJhFph4J5KOiKJWabGsXgF7yPhrzL3CjG4eDi4n5lLI
 JuOC4idm1M0AURq5gWPfRi4Zc/EI5pfCjL
X-Received: by 2002:a17:90b:3a0f:b0:35d:9c32:6219 with SMTP id
 98e67ed59e1d1-35de68632f5mr20180221a91.9.1775667851413; 
 Wed, 08 Apr 2026 10:04:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e34e959bcsm237025a91.0.2026.04.08.10.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 10:04:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [PATCH] net/gve: enable comma warnings
Date: Wed,  8 Apr 2026 10:04:02 -0700
Message-ID: <20260408170402.452672-1-stephen@networkplumber.org>
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

This driver has no misuse of comma operator in current version.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index 11560056b9..e93dd2e270 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -21,4 +21,3 @@ sources = files(
 includes += include_directories('base')
 
 cflags += no_wvla_cflag
-cflags += no_comma_cflag
-- 
2.53.0

