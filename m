Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E061CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:39:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F431402DD;
	Mon,  5 Oct 2026 21:39:47 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 444A5402B5
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:39:46 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db8e9fe9c7so22937735ad.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229185; x=1791833985; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K+OTAEipVkLnMSlfgYh+ll5tOKCxUNfkBov1be+AbZ8=;
 b=MA9e+PR4b8nQS/X/wovc6F5BYNGu6b2hm7rgzj1ts3OhMGubbtrI9WRy/rQI4rMnjd
 1EJGruwTVJsNcgc3MwJ9n6DgaLOBgy5wzPmaLuV+nwXLd3rG2DGZCCrjl3q7+Lf67wcf
 r2dH8w7c3HmMSFhYrBIx/jloCutGAXaVvrijm+nw70eQVGxWQe9ToLipO6dnLOrB7j/h
 BCxgllMU/GwPFAjiSFqxVme5yDTyi5rIGSkMTSDWfbURMn8fU86Em5af6nJILs//MKgf
 EATfInqvMdYgY9e0N2P3Xxuy/btRZawFLITar34EFDWr09vTX7AjgehovVTAMsJYY0d+
 gwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229185; x=1791833985;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K+OTAEipVkLnMSlfgYh+ll5tOKCxUNfkBov1be+AbZ8=;
 b=YCyfXmWMS0KnDv1jfk+/YWCNH4evEYXG3ZuodwnWSGaxO6kUk7wCU1sRPasfvZF1S8
 /3jYnQiXFtlxA+7MI9WZ773NGQu1/YiL/peIezD57dzXjElY1IfYEPHcOsLHOVwTutYV
 s6bNInFQEifTDXg0Ztm6Dh6ZVXvJFTQVf6sfHZizsevNImpJsI1QG9bFUmKxCURAqPHB
 HUL0qJiXZZF1Oh7OqtvM9T6sp5aipItcaSFIByB8haafJMwmG/Q0dDeo7VXga+XXdKGA
 7RfS5ZuqhRzyRuM3FnUmk6GATAAeKTQPQvE1wPdUq3/1kXCSvJAfYFwn/yZh83ONs99g
 B3XA==
X-Gm-Message-State: AFq9FYKxzaWCm976Rj/BZu6ahqPVRFD1/oEhMOPL8Z7hltbY5/RW/mue
 AeRqRm2b6w4UFLsIePsHqW5Y+3ajU0AygUxbyG8sFQd8nl24V0v4hoQdE/SxTT6mU42yUl/pCV1
 PTvHiAYg5rDbWxw6gjTygDDd3kZyFuSLLcd2F7SEOQVBQg8soync+sIGdhYP1ocfr4EUwKKyf6g
 /5x6bORblDBg1e+Fd2FZQukPHKElfmQcYCYQ==
X-Received: from plfp9.prod.google.com ([2002:a17:902:e749:b0:2e3:1abe:72dc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac9:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2e49a104238mr110359785ad.3.1791229184671; 
 Mon, 05 Oct 2026 12:39:44 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:31 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-1-joshwash@google.com>
Subject: [PATCH v2 0/8] gve: precursor control plane changes before bare-metal
 support
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
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

This patch series includes a number of precursor changes to the GVE
ethdev driver layer in preparation for introducing support for a new
GVE Mailbox control plane (an alternative to the existing AdminQ control
plane).

The most major change in this series is the introduction of a new
control_ops struct that will be used by both AQ and Mailbox for various
operations which may need to communicate with the device. There are also
some changes to how RSS and timestamping are handled in ethdev due to
slight feature differences between the control planes.

---
v2:
- Remove -ENODATA return when updating RSS cache

Jasper Tran O'Leary (1):
  net/gve: fix RSS config memory leak on close

Joshua Washington (2):
  net/gve: update RSS config just after successful programming
  net/gve: add RSS cache boolean flag

Mark Blasko (5):
  net/gve: refactor ethdev for control ops interface
  net/gve: rename doorbell BAR variable to be more generic
  net/gve: split default queue counts into Tx and Rx
  net/gve: clean Tx queue directly in dqo
  net/gve: refactor timestamp support to clock read type

 drivers/net/gve/base/gve_adminq.c |  33 ++---
 drivers/net/gve/base/gve_adminq.h |   9 +-
 drivers/net/gve/gve_ethdev.c      | 208 ++++++++++++++++++++----------
 drivers/net/gve/gve_ethdev.h      |  59 ++++++++-
 drivers/net/gve/gve_flow_rule.c   |   6 +-
 drivers/net/gve/gve_rss.c         |   2 +
 drivers/net/gve/gve_rx.c          |   6 +-
 drivers/net/gve/gve_rx_dqo.c      |   6 +-
 drivers/net/gve/gve_tx.c          |   6 +-
 drivers/net/gve/gve_tx_dqo.c      |  20 ++-
 10 files changed, 237 insertions(+), 118 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

