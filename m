Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338CCC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD664026C;
	Thu,  2 Jul 2026 18:12:49 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id E1C6C40265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:12:48 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8478fe07f65so1846461b3a.0
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783008768;
 x=1783613568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FP0DCKE9+aOTkFu3ceuxTwDZuivNOGJEnycR5a6cvTY=;
 b=VzM3KmUa3Ir2XH7YhIWGktxxUK6ixY90hivQADQtVF3oG9NHiPDnT3nUf+5aodINfE
 rUx8pELrRAV80beZQxZMK37fBXekQ2YGtvle5fsaJWLeGtF0Y5Tk0t2UBGlmFxtqhSHX
 2C7Jg9aF2TQGY2tik/v/T6g/HdosQvzg6EpS5eWMhjK3oEpA+lGLkS8Zbo/7Uk8aSKBU
 H1M6ItVDlB33ef9f5cj50dtN/YS/oNCYdWrEysw7lw1HDQMP4wHo3QVvwBh+r2kVzzk9
 ZeanH20IRZRWZxU5/e8JgvqSMfaOYpt5QAASEEfEtAcWQ0076Ga1DyLpVKLtLSMr/tOi
 mrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008768; x=1783613568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FP0DCKE9+aOTkFu3ceuxTwDZuivNOGJEnycR5a6cvTY=;
 b=Lp6x2OBhsyjlk9BorHItRakSLrBfXsk7JsDUreTGQQS/0LCqCcMUcrLqd0B4R0zkj3
 Yt8Lw+oxb980mi9d/PVnzOStg9QGD5oVcuasKUez/ELG9BgY8n6huCb3fRIL5duOAIwd
 ugxwXmBJ3U5jhb0lDx3DAQ0CpbPhsUEeLa8AotERDJyfSoJZbCBINk3gYKNnuYEp3VxS
 UD1a1Q+kDf52tMIudB7FY4s0jO2kVuUS2qERnR2qKvS8XH2DnmKhontsbr82kaN0WlQl
 b+bWeVX+C4jF+EXl+MGghdZOUgrls7uTBrCduAN8nFAJohql7AXRL0CrLK4sl1T9nLJb
 4lAQ==
X-Gm-Message-State: AOJu0Yx+eUpk6AtjdHcnlB68KXA5WFu6kfkN6PjyMpOi1u3GCK3vg1ki
 MPdC4kAFxVtG7ACsfIHaJ9Jr/J0HweL8u8HWO0NN1Qwa3bjid4v9/vy/W7kJXfxoqZm0ydjtwI/
 T7Elx
X-Gm-Gg: AfdE7cmHrTtvnF0BahawIs6qGF4XFTkEHzRPCH8JjYcpt2rcgMfNo/3V0kgP+GvxM20
 FeRpsSLToWziQHU2t9FVASYi0uWVRE+S76dyU0/KtTkCAEtGrKmLWyHeAtOHPYEvB6d2G7FFCrM
 VGmpVMoC5ULmZXrh5/TWkHUy1c4AEk6UGQN8keJaOrdQkHCAroTRSP/AuBxvbgveviZlQc9AM3K
 LITh6d643DuXmZOmqPpVZPYl7+fEuAa2qRXWoDRY6ij41Og7a0l+8PkL8kbSV7rvFMj3hgucz8o
 2BL2GSolCFqoRm6YzhaA/jaKkfbcW7IPaxosDbzwUM6bsT01u56J9QWjV8B0DxI+MaHV3gUYBgr
 z9KBG+f0YS5uQgzdWUdM5CiJc1WsXi/fuIMmmzrY7KA1RPpmbmqIf+boS9Ive7xIV11Bt6te19h
 b/hBn5n5l816gIQg8q1RbVv1my9KsBC2LORxwLDAsEJJ8XM3yZ1us=
X-Received: by 2002:a05:6a20:b603:b0:3b2:8685:13e4 with SMTP id
 adf61e73a8af0-3bfed194ddcmr7878677637.15.1783008767548; 
 Thu, 02 Jul 2026 09:12:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm9849304c88.4.2026.07.02.09.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:12:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] app/testpmd: fix socket id handling with NUMA disabled
Date: Thu,  2 Jul 2026 09:10:10 -0700
Message-ID: <20260702161244.363233-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702130729.26577-1-mkashani@nvidia.com>
References: <20260702130729.26577-1-mkashani@nvidia.com>
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

Alternative to the patch "app/testpmd: fix multi-pool Rx setup with --no-NUMA"
from Maayan Kashani, fixing the problem at the source
rather than remapping inside mbuf_pool_find().

Since commit 835fd4893a31 ("app/testpmd: support cross-NUMA allocations"),
mbuf pools are created (and named) on SOCKET_ID_ANY
when NUMA support is disabled, but port->socket_id still holds 0/--socket-num.
Every name-based pool lookup that does not go through the single workaround in
start_port() misses. The reported multi-pool Rx failure is one instance; plain
"testpmd --no-numa --forward-mode=txonly" also crashes with a NULL
mempool dereference, and --socket-num no longer affects pool allocation.

Patch 1 restores the invariant that port->socket_id equals the
socket id the pools are created and named with, and removes the
start_port() workaround. It should go to stable (the regression
shipped in 25.07 and 25.11); it cherry-picks onto 25.11 with
trivial context conflicts and was build- and run-tested there.

Patch 2 consolidates the three diverging copies of the port socket
id policy into one helper; this also fixes hot-attached ports
ignoring --port-numa-config, --no-numa and --socket-num.

Patch 3 prints SOCKET_ID_ANY as "any" instead of 4294967295.

Patch 4 adds the error string to the interactive queue setup
command failure message; rte_eth_rx/tx_queue_setup() can return
-EBUSY silently when the port is started and the PMD lacks
runtime queue setup support.

Stephen Hemminger (4):
  app/testpmd: fix port socket ID with NUMA disabled
  app/testpmd: consolidate port socket ID computation
  app/testpmd: display any socket ID as text
  app/testpmd: report reason when queue setup command fails

 app/test-pmd/cmdline.c |  12 +++--
 app/test-pmd/config.c  |  18 ++++---
 app/test-pmd/testpmd.c | 120 +++++++++++++++++++++--------------------
 app/test-pmd/testpmd.h |  11 ++++
 4 files changed, 92 insertions(+), 69 deletions(-)

-- 
2.53.0

