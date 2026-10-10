Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D4CA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 00:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40146402B4;
	Sat, 10 Oct 2026 02:59:46 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mails.dpdk.org (Postfix) with ESMTP id CDB2D4027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:44 +0200 (CEST)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd1e45a268cso108313a12.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593984; x=1792198784; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PcuIhCQV/sTzZ45FBn1aVYC/Lz52MsuDAeOtY/V9tkA=;
 b=m/Jxt2mn8YRT/ppT43wQD0URa0fsVzPVtAEMmjuqrk0AMzA8261rMOSQJGxRk9CiPx
 Y4QqbpQ9HiVGw7R27fjWliLpJYoadoTXzIIFOSzGBaIQIv/3i9/vuDcL0bdZd1qy6JXJ
 CUOfl1gut6bHD62Y1GHga0HogedPYDkpMwgmIfzpZ+m2o3SYfF3uWX8ROHdY6RCsjUw3
 og/Udl3cZAhfPxoyELihkyiYYHm0qHyUjFSeSTwgoEmZgcib3OtVbgcn+dVeiJh4f/CC
 d8Im1vR20f3gsAmFk4HJf4BXUjQFMTKnBmyxTm5qcOm/7UAs2w/87J1cgC/Fefs7Ut2Z
 B6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593984; x=1792198784;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PcuIhCQV/sTzZ45FBn1aVYC/Lz52MsuDAeOtY/V9tkA=;
 b=0dgfpoyirHQRcpnUh+H5myum4UlxD+wQCUbobPw0lOx6Af9y7Fq6q3D8CjrgJlSbUI
 pDxXmASQ0lkWXlBeu3BcqP40K2ZEpTncjB2CJc5d2YCShlvZeWX9InxGH4eJP5DF0zwZ
 E1vSsGw5lUQQkQpgu0Ux5tnsHErd9haWhrv37qoA4s3fX6iHOxeEoS25cP4+XnX+TJOp
 wvAcG6y5K1Ch5tk3GGrGxFFU2uWP163QjhDhRcOhngI3A8vdoeGXVTd6qtE6J6kDaXtg
 xmyBiA5dKZUOx/yROsRs4o/IBIShRE3sGMy/WKoW4RhmNiQedI9F60CqrapkMyFz68kV
 L42w==
X-Gm-Message-State: AFq9FYIc58KQXK2FdvBr67QxFgzFmaiz8bwfhhiCVg5YzoMcw7RhyNEj
 3Rv3nUzBsAEnQhfAwTF86/sU6SasW9Ejt5zKdXM/7Wc69rdfD8Q2fkhWXPOvDv0SkZ5vcM5UI8R
 /xNO3jczklFMJCvocTQDC+n0piOSLhwlLO07dv3oGRWpcxNMV9SaxZhNjhF0maAV9aPBZJ+s8hq
 C2S6XcmshYCQOTOTQCiIyCnVdIbzkz4Ke1sQ==
X-Received: from pgbj19-n2.prod.google.com
 ([2002:a05:6a02:61d3:20b0:cca:d6f4:95b5])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a8f:b0:3a6:e985:5631 with SMTP id
 98e67ed59e1d1-3ab3a99b88emr3110852a91.62.1791593983278; 
 Fri, 09 Oct 2026 17:59:43 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:32 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-1-joshwash@google.com>
Subject: [PATCH v3 0/8] gve: precursor control plane changes before bare-metal
 support
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com, 
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

This patch series includes a number of precursor changes to the GVE
ethdev driver layer in preparation for introducing support for a new
GVE Mailbox control plane (an alternative to the existing AdminQ control
plane).

The most major change in this series is the introduction of a new
control_ops struct that will be used by both AQ and Mailbox for various
operations which may need to communicate with the device. There are also
some changes to how RSS and timestamping are handled in ethdev due to
slight feature differences between the control planes.

Changes in v3:
  - Move fix to be the first patch in the series, and update the fix
    reference commit
  - Introduce process_private pointer when setting up ctrl_ops
    interface to avoid sharing potnetially unallocated pointer across
    applications
  - Update optionality references in ctrl_ops struct.
  - Avoid clearing RSS cache when sending AQ command
  - Remove checks against GVE_DEV_CLK_UNSUPPORTED that are either
    redundant or incorrect.
Changes in v2:
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

 drivers/net/gve/base/gve_adminq.c |  32 ++--
 drivers/net/gve/base/gve_adminq.h |   9 +-
 drivers/net/gve/gve_ethdev.c      | 266 ++++++++++++++++++++++--------
 drivers/net/gve/gve_ethdev.h      |  55 +++++-
 drivers/net/gve/gve_flow_rule.c   |  11 +-
 drivers/net/gve/gve_rss.c         |   5 +-
 drivers/net/gve/gve_rx.c          |   7 +-
 drivers/net/gve/gve_rx_dqo.c      |   7 +-
 drivers/net/gve/gve_tx.c          |   7 +-
 drivers/net/gve/gve_tx_dqo.c      |  21 +--
 10 files changed, 297 insertions(+), 123 deletions(-)

-- 
2.56.0.170.g584c36229d-goog

