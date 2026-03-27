Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908710AB82F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:19:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB1A44027F;
	Fri, 27 Mar 2026 01:19:17 +0100 (CET)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 1D43940151
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:19:16 +0100 (CET)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2b0c96f5d9aso6944915ad.3
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570755; x=1775175555; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ITYLtC/U+B2JMK1n1BozNjc+rxdO9sJ/mamZOkmdP4U=;
 b=hdBZbbFWPT+ZC+R5aqiRFTzsnzJHiz0azDia33pduz34ZLijDiWO8GhwQh/xCP7JYD
 3ZvVtEzJD1LvzvmP6yPBSV0tDCRKm1NS+L/S3bcdN0jONDzz4BxxCj0DE+Hfh8aSep9P
 MkgUwd0il4wO27NPPQCa352gcYwoHEg0tlbloYyi9SKT7QZWhWZC+0DPiI8FM/uu3g9A
 R5Qn5RFpCZHQ5VxtSaYeAlsvR1l+QIxj+C6cap2PbRBWO8yJlPt9zwfCZqogo8jFUSyA
 6uvO333yrJ9X8YT6Dt6+92GdueM7uVgI8Vrx0HBKvzAzBsQ7MvQJfFW3Q432wdIpQkdc
 GPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570755; x=1775175555;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITYLtC/U+B2JMK1n1BozNjc+rxdO9sJ/mamZOkmdP4U=;
 b=gc9FaAmBiw/Os3Yq1lNVt9T3J2tdwvF+qI4ep5gLShFmNFj6g4WFrLsZtRljepKriq
 ZbH1IRRVa8Olcsi+zeUsvg71lCFomSnS0vYAqgTWX5DC777VgYfs00fUhWbIH4xsbU2G
 CQatqrOffcRQkY2yGPMm04+KJV0yJRm1Y1sc81nV/naJiRvnuDBeU4wwem5sASOAWnHA
 zIGpwcJvfgMnIXUMvAp5B/ZHb8q2PNqIsS0QF1RuX3+hmD0vwatyqR6PqFhQs9WYAUQG
 uAb0CM4LbBQzHK3FK9X1ZtNivEjjQnFsqCo4zqNrDWeTVQtcmG3JIL1SsJLkXA8H+W7S
 f2MA==
X-Gm-Message-State: AOJu0Yx2Ounf8jxCqdeBSk11gRs6YlrFDTatWMZ5k51yRv1VjTN3m6I6
 cz9aM5/IBp7BtZKy61njY4ev9siQSCY9B6lF3D4ZdzUgesj7G6+vqbc7X+PEagncDP8zCldGFU9
 HGVQ4K9n2Y8TbvefHt7iRy80Npg==
X-Received: from plyv11.prod.google.com ([2002:a17:902:d68b:b0:2b0:c971:cfd4])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54f:b0:2ae:5797:e082 with SMTP id
 d9443c01a7336-2b0cdcdcb63mr5657695ad.24.1774570754844; 
 Thu, 26 Mar 2026 17:19:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:18:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327001827.3385001-1-jtranoleary@google.com>
Subject: [PATCH 0/4] net/gve: clean up minor issues
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This patchset addresses minor issues in the gve driver stemming from both
compiler warnings and feedback on previous patchsets.

Jasper Tran O'Leary (4):
  net/gve: fix comma operator compiler warning
  net/gve: remove variable length array in rx refill
  net/gve: add checks for flow rule struct padding
  net/gve: add minor fixes to flow rule code

 drivers/net/gve/base/gve_adminq.c |  4 ++--
 drivers/net/gve/gve_ethdev.c      |  8 ++++++--
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_flow_rule.h   |  2 ++
 drivers/net/gve/gve_rx_dqo.c      | 27 +++++++++++++++++++++------
 5 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.53.0.1118.gaef5881109-goog

