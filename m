Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF30C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36FF840279;
	Wed,  1 Jul 2026 20:35:34 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id E3AD840264
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:31 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-847a90cc5e2so1276453b3a.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930931; x=1783535731; darn=dpdk.org;
 h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8c78chj45bAoewl3z7OwY8xwzXqTJDSzsV+PqU4wO/E=;
 b=ZVZH5ULvROguCENQQynevFXKt5KFfmwsgnFtkheqcgW7k30m/0Q+wEdZ1+343ChTNr
 1MnI6smJtR4f07ugLPGfBPlVZSuGqtNRV+ItovSk4mUlKhnuocd67qGnHK8DWVEUKu7y
 JakRWTRhK0+9l2Vi+N4kt0N5S0MYkjera5e3ANxcDuh8jMgGgB7pJh/geqvYkWGPlJ4i
 H50Q35h8vhgZegQi8HXkVKRESRfxM6UNuk1aBz3rDxsBIUXViXBhEjxnhXJ/9O6G7vmu
 6Sb09IqJnhNHC07bPwapYRJaKJUDZaFkuTZADPUo9lM3SbZUoFQhlXOGi6/EqdMPVq0o
 xG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930931; x=1783535731;
 h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8c78chj45bAoewl3z7OwY8xwzXqTJDSzsV+PqU4wO/E=;
 b=DP7YTWW+VCTOeiYxp4XsI3YiJ2AHU1afoCrh6h/Lkkv1B6X9sjaD/O9EeCkgQzV/fy
 ahX4wXOAPfrYKIiNwoQ1NLhunijJUZROfIu/vQVVNOd/lSjdyvLgQ/weGTnRDEQhysPP
 5kpNO80WQmlDsWodIf6f/HgAAtmQbgmiYyFFIo+nYo05HyMAAoJpFFXhW9RbNuoKxGr8
 tSRAeh8I1pdg81XcK+gzAO690FZsejEC65NEGGs9mVSh6wfMSFLX2bEGn9n6P3xO97MY
 Xl8iBdpED2go/kaRY83t9xEpBIGSb13EFS8lL1Br+qU2XvU6cL01agzlt/48jYSIy2dc
 TDlA==
X-Gm-Message-State: AOJu0YxLpZU9yElo+AmSzBkuSuCDetdDHUz9C3j/4MfGW6d98YHiemk7
 aWuCdnE5YXk/bFXSTPw4lXVb0Ra41nxkIbFNb1Ofa9Opzjjg1K2vVQsEkWmT/IxlkR0glHP7Igd
 JYfWbI2WvnFixpbV60oojee60Wn/W9gHZ9Ga0tXsqVY9FIeo6zRWswUW/oZ8edphmDKB0XOE8Vd
 aUSp5EsyY0yhXJbyqTBO3nYXyCHwAorIlcKA==
X-Received: from pfll12.prod.google.com ([2002:a05:6a00:158c:b0:847:87ec:2a9f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:27a4:b0:847:83bb:9b94 with SMTP id
 d2e1a72fcca58-847c0a45044mr2288332b3a.48.1782930930425; 
 Wed, 01 Jul 2026 11:35:30 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-1-joshwash@google.com>
Subject: [PATCH 0/9] Stability fixes for GVE
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

This patch series consists of mostly unrelated fixes in the GVE driver.

Joshua Washington (9):
  net/gve: clear out shared memory region for stats report
  net/gve: delay adding mbuf head to software ring
  net/gve: copy data to QPL buffer when mbuf read does not
  net/gve: validate buf ID before processing Rx packet
  net/gve: set mbuf to null in software ring after use
  net/gve: free ctx mbuf if packet dropped after first segment
  net/gve: increase range of DMA memzone ids to 64 bits
  net/gve: don't reset ring size bounds to default on reset
  net/gve: restrict max ring size in GQ QPL to 2K

 drivers/net/gve/base/gve_adminq.c | 12 ++++++---
 drivers/net/gve/base/gve_osdep.h  |  4 +--
 drivers/net/gve/gve_ethdev.c      |  8 +++---
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rx.c          |  3 +++
 drivers/net/gve/gve_rx_dqo.c      |  6 +++++
 drivers/net/gve/gve_tx.c          | 42 +++++++++++++++++++------------
 7 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

