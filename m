Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F9C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 00:03:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96F694021E;
	Tue, 26 Aug 2025 02:03:42 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 798A340156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:03:40 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-76e2ea9366aso4468479b3a.2
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756166619; x=1756771419; darn=dpdk.org;
 h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=itV9VgfjI09kCHg01dD/VvnfvsgzHEyWT6Ps5HbHcbc=;
 b=fleWmDeSFDlKBjiZS4tszzk+uIw+7TMQWmROa4cH1TeEqzjPL54p6FrcyR8AHQ04NM
 7OYstbeZPNzusN7kAxZls2/lqGuuRDQ9JstmP9F1FrjRzL8IUo/lh8qOKerB7cMu3ecf
 ta1jAwmvVYODKD8+/rQA0enxPVPibPDdS7gjKSevuFAcYaZgEDIvsro5ArFPOPPu+a7I
 /AFrlkRduaX+YAzaIewGz2hEh2OiDwjz1qhGnh5Af6d38xRfbPCcYg/TR1OKQyfgtwTo
 Q5t2uS8ZpqkdNDQoikedz/4/VlmIu8SB7HWsFGhUGwFESGO134vjPiIdH+oRa6DwyKTE
 mM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756166619; x=1756771419;
 h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itV9VgfjI09kCHg01dD/VvnfvsgzHEyWT6Ps5HbHcbc=;
 b=WPZK/175joxpQOQFYll3MFFA+uc4KXUyojWkJbICdbftUzLyy3HvMxPkfuyWx/6DMR
 Np5QqceDtRjUJ2qiCT/HeSBQhsxJXWaNDmnGdYp0CwEOY6kfrfGCyggFuefQ12lseWxl
 HQxwch8DCI13ARbmCFCdDwJMuUiqgUJc5tMTIb0DdGPrsY2AVBdR4B6UPfDVZIL0K3x1
 50MV+I9hjqqTnYr3efqCyK0pkIYsRGb8P1c7wfPn46LgFwVY6TNfmA431rkwU2Ve8/+z
 rZ2BPZerOhCp0vlPRIB226Pixr/jbdkTf017rQZC0tk6G59Tq8X/O/ioCGXMgVpEL5DK
 nuJg==
X-Gm-Message-State: AOJu0Yzc0o8Dt1tWgmiZIO9Be+zQ1LAB8aKWffdO+3jm7F/R0PBJ9lwp
 Dg4fdZm30EVJC03SIMSMXTDHmbx6W4owCKlq4M1woEIs6Y5SSK9DY6HKORfDqSv4JD5nR0ZNZ+n
 7+DJ6AuSEJqCB/euFMOStHBD+O5Bma+ueun+UTTLYprCfReoB5NjVI6ZEfb+Kp22SA3ld11O86I
 UlT1BECjbKFZ/qr+Nuhf/OHycHvf667p4DAw==
X-Google-Smtp-Source: AGHT+IGSQbjHWpGAA0bxY+msX894ymX2ZtgSdtaYMRNYsBNOsz5B2Au+rypnZugT8jEoF067CqwQ14f2BiF/Xw==
X-Received: from pfbmy8-n1.prod.google.com
 ([2002:a05:6a00:6d48:10b0:76b:f0d4:ac71])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3283:b0:240:21e1:cbc1 with SMTP id
 adf61e73a8af0-24340d721a3mr17497686637.41.1756166619384; 
 Mon, 25 Aug 2025 17:03:39 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:03:33 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826000337.3922883-1-joshwash@google.com>
Subject: [PATCH 0/4] net/gve: out of order completion processing for DQO
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

Both RX and TX processing on DQ were originally implemented with the
asusmption that descriptor completions will be written by the hardware
in the order that they are posted. In certain cases, such as RSC on RX
and double completions on TX, this will not necessarily be the case.

Depends-on: series-35656 ("net/gve: Tx datapath fixes for GVE DQO")

Joshua Washington (4):
  net/gve: free Rx mbufs if allocation fails on ring setup
  net/gve: add datapath-specific logging for gve
  net/gve: support for out of order completions on DQ Tx
  net/gve: support for out of order completions on DQ Rx

 drivers/net/gve/base/gve_adminq.c |   2 +-
 drivers/net/gve/gve_ethdev.h      |  20 ++-
 drivers/net/gve/gve_logs.h        |   3 +
 drivers/net/gve/gve_rx_dqo.c      | 135 +++++++++++-----
 drivers/net/gve/gve_tx_dqo.c      | 250 ++++++++++++++++++------------
 5 files changed, 267 insertions(+), 143 deletions(-)

-- 
2.51.0.rc1.167.g924127e9c0-goog

