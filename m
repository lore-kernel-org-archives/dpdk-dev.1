Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A123CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8E140611;
	Tue, 12 May 2026 02:51:07 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 3164B402BC
 for <dev@dpdk.org>; Tue, 12 May 2026 02:51:04 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso116812616d6.3
 for <dev@dpdk.org>; Mon, 11 May 2026 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547063; x=1779151863; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mboujMWMGg/9S22SI7R6wHfTNsaeWhKSmNjxD62hw20=;
 b=NPPG69R1h2SaOLU1sX0RVdLJ9MoWZ1zeZKB4M1dK6m/EO+/c47j9esm/1TG5M3tLIN
 LEniV3L/IEhYyDG6VF/cERgDLr0I6oupPM8mQVhMbKooww8hsKMKQg9mHicLtxYt10zW
 s/Qin9tRn+dunvELJhi4Wy3eoBjGj3VY6730LYdmyguBW5qPAD8zIPQvp+wdVC2UG4vW
 h4G1D7IuKCmoMTttEBVEzDQwCBlyXiKmTzgoMpq2zy5hjtJ0BJdGe1IOXL2DAJVDrKPO
 pzxYIxChDKszzIoZerVA0quz5Y5+xK1UyLaC1UQlZLZ89Zmza4jp06pDNQU8fGfdp9UJ
 Aycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547063; x=1779151863;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mboujMWMGg/9S22SI7R6wHfTNsaeWhKSmNjxD62hw20=;
 b=WjEH7HXUTUDsSmrjIHoSg6OuSdScu0udq1DC5CTq4aWOkWJVZIhTkb0uAeg9lyIFao
 d13gzEDfRZxCN5z9Efu1aiPqUDvsL+Bj0bbml5pyBDXyuSQunraeccn46sUlSN7ZEF4P
 fUc+QqQyORowmoQ/CKnT+WDDJND6SeJEbsTWwRHk95+tWQj1Ve9cLTeUgLWL8n0xEffp
 HoHuAo5hYNlboj/7n7jb8RdVsVyGLEVhIoJEtIgsfFmg9PbpgUVyqxmcM+tkw+kqC3KZ
 NPmTspwh83nvgRPvd45/KE02DJ0GR0nmKQ1hzwQ9NwvzPfcIt7qMQwlhWWmUvYz72Xhf
 LLmQ==
X-Gm-Message-State: AOJu0YyTxPLBUY0rRswAx/P83w6Kujub7cZfcD0PpaHoPY9x/0rW2QUj
 RjZ1shJEk783ZXSDcoz35/G0hDt5Vmz0mnVRvLtveozcr8qIPFLmE+uzvCNNMcc8D+9p/Hq1IT6
 PlLw5rQ==
X-Received: from qkbcx13.prod.google.com
 ([2002:a05:620a:51cd:b0:8e8:e194:b874])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4455:b0:8cf:d386:1db1
 with SMTP id af79cd13be357-9090fa77b36mr1705529185a.31.1778547063334; Mon, 11
 May 2026 17:51:03 -0700 (PDT)
Date: Tue, 12 May 2026 00:50:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005057.944672-1-blasko@google.com>
Subject: [PATCH 0/6] net/gve: add hardware timestamping support
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
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

From: Mark Blasko <blasko@google.com>

This patch series introduces support for GVE hardware timestamping on DQO
queues. To support concurrent access, a mutex lock is introduced to protect
admin queue operations. A mechanism is then added to periodically synchronize
the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
operation. Finally, the RX datapath is updated to reconstruct full 64-bit
timestamps from the 32-bit values in DQO descriptors.

Mark Blasko (6):
  net/gve: add thread safety to admin queue
  net/gve: add device option support for HW timestamps
  net/gve: add AdminQ command for NIC timestamps
  net/gve: add periodic NIC clock synchronization
  net/gve: support read clock ethdev op
  net/gve: reconstruct HW timestamps from DQO

 .mailmap                               |   1 +
 doc/guides/nics/features/gve.ini       |   1 +
 doc/guides/nics/gve.rst                |  18 +++
 doc/guides/rel_notes/release_26_07.rst |   3 +
 drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
 drivers/net/gve/base/gve_adminq.h      |  29 +++++
 drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
 drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
 drivers/net/gve/gve_ethdev.h           |  39 +++++++
 drivers/net/gve/gve_rx_dqo.c           |  26 +++++
 10 files changed, 378 insertions(+), 22 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

