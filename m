Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3834DC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53DE440264;
	Tue,  7 Jul 2026 18:40:24 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 0A5E84025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:23 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c891ed872ddso7244770a12.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442422; x=1784047222; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J7PEysz9HyrtlhNJBVVzsc2AAxM2BippXbCnX6JRSCA=;
 b=X7Di0YUo9bulNJdEkv0xJ6L+V6Y6mJ0LGe6u+0OgXs6ac8SDOiDss2DwB/M/LQFz80
 +dQ8s4aVuU2laOMUcyC9UCbGn3YgcdmoWCfUZ5RDW4Q1PDlR2U2XqH0eHRfoFZRQJdpn
 +xQgIdxnALfqA2OpkvrTbNI0UOJgz2IOfBqnu+dvC6E0DB1MvuBHaOU8UT32Ksq6zNt8
 eymKZ1Tnf/AUqn9SlwculPNNZuCKL8HiA+kzmsA2XadMyksKvqZOt3qGFZhuzhouU2wy
 Q52B4nvh+IHp6kpoZt2qwun1qGlPMpc/c5sZxrfRf/6ndN4VrNjpdrHfW7ozasl8tZ2M
 KtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442422; x=1784047222;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7PEysz9HyrtlhNJBVVzsc2AAxM2BippXbCnX6JRSCA=;
 b=C8Sa4g5UXXdVVqhs0K/A0jrzwROf8kTrgWzAkr3siof4OgtKdl/+xTFxaJtjzSpSBM
 iLE1ThBVKEJ7JcrUxbZxKbqijPRlkZiN9tcGzKnGeCtwjj7V+dZlnbPeHszsQJ+FgeWI
 I5FV1jBFAiXlnOyJfaJbULfzjK+p3CLTFsr9DzHoUazQ3decedySC9zO2ORIg0UGuIMX
 NIXxsiIYISLevfh4aFR4EE4epZM4AzGzBE6Mu0cun1JJrehZ+Mw2AiUJjJzdONX1aFm3
 7ty2VWwYxJYBoRxFPFPw5BsZXcrtvy7J/A+gaov3cXMx/1QbJu/m8XJn6MhZqj9x49RW
 09rA==
X-Gm-Message-State: AOJu0YzVnss4I711URvEGNz42cmYx+vHUmLPv4t8UHUFyl7OsrMg4VIo
 kcSuHAhqkIL9TxBHsBSrbBW2Qfyq8YMMKfIR6e7UPcCx4V/F625dPWydArjFyKzbxBnlOMQFTGA
 JJcjt/ARvZDk5JA7eDgt2H41eKzGQuknAn2lAI3jAm0yk07ZyuBGcEx7bGNDXXrb8Y+Lr7QY3Fq
 mUcrfDT962xH3e/9ahbyvM685LY864km74uQ==
X-Received: from pfbil2.prod.google.com ([2002:a05:6a00:8d42:b0:847:aa6c:47fc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d4:b0:845:e740:8ba6 with SMTP id
 d2e1a72fcca58-84826deadebmr5229790b3a.43.1783442421594; 
 Tue, 07 Jul 2026 09:40:21 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:10 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-1-joshwash@google.com>
Subject: [PATCH v3 0/9] Stability fixes for GVE
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

 drivers/net/gve/base/gve_adminq.c | 12 ++++++--
 drivers/net/gve/base/gve_osdep.h  |  4 +--
 drivers/net/gve/gve_ethdev.c      |  8 ++++--
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rx.c          |  3 ++
 drivers/net/gve/gve_rx_dqo.c      |  6 ++++
 drivers/net/gve/gve_tx.c          | 46 ++++++++++++++++++-------------
 7 files changed, 53 insertions(+), 27 deletions(-)

---
v3:
  * Fix 32-bit complication issue
v2:
  * Remove unused definition

-- 
2.55.0.rc2.803.g1fd1e6609c-goog

