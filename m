Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C94CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE19A402BC;
	Tue, 12 May 2026 02:54:08 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 2061640278
 for <dev@dpdk.org>; Tue, 12 May 2026 02:54:07 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso134980186d6.2
 for <dev@dpdk.org>; Mon, 11 May 2026 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547246; x=1779152046; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w/jIuhHKyG7gga4MGd1OXvsdEHJMpYmlItHkPxFIvL8=;
 b=TMsGQjSxNl46MgDmCvdBY8ZGbfFzCvqz8IXlxvGMWy/rCDHKRnjwlAGWRyXgyiQhaW
 mnohdc14a5n39H6HH5IsHN3cQ3KLql2K/FWE00h4auKCRg2WzjfFiqn7cGK/IKTW4T04
 HLWy0du2X/t8oyqPeN+/teOePHglTB4kQOAbv41sueNPCrj7+YO+JWSsvRmMGbqaHi5e
 ehRMRf07xXDWTyoK0FJ3x+onM1C7K41ETAiIVmgBMfAD7tTIGD1kKiHlYySy7V/LZfTQ
 t7UoVW+rYWu1bTW00Xf26Mp14+okhA82CSvDYpHg9pjYLClpX+jgRGhCk1r/Qx4olFGe
 xMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547246; x=1779152046;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/jIuhHKyG7gga4MGd1OXvsdEHJMpYmlItHkPxFIvL8=;
 b=mNxGeCOWgzlH5MG6I3062FYekJ+YXBT+/Q/sQnUMnrSBoqeuu5PGy0GsQ1A3zuCVMw
 mYG8OVSAez9H0kWHHvBvSF15LUxmJuQi9IEJVAqK3ND+ZL9E0IVQtCJpIKTrMSzMRl7U
 fXKPGxauN2r+n+zB102ZpcfqbjQt65wxCx7jh1zdNQ6haFmKQxQjIF6RPVGR+DdXfEBD
 8mP9FNj4uxiEo3UUQsAzZfmaxx8YH8zpsT3SMR0tOz0Y7mYbWK/UNdaR8mMe6PDPb5MW
 JI0T+D7hrBXjGZV9YpMZxWNN0S4oAr2Qpiwt1DSP9pkh0ikXD0cNDm2n3+GWGT5WXSaU
 t6pQ==
X-Gm-Message-State: AOJu0YwGvMdaM1n/u6ftvWlh7196vg+vmMoMTpJA3qYa/fF1vm0MScgR
 RxOVHTw4fm7RUK+Wgx8WANQF/e3VUbBeEIGa6XSLUzXjlJUm5OLY34oRnHyQ9clGMBItHfBVRHZ
 ZHyrbng==
X-Received: from qvbmy5.prod.google.com ([2002:a05:6214:2e45:b0:8ac:ad04:ef63])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:f10c:0:b0:8bd:b32c:68c3
 with SMTP id 6a1803df08f44-8c660f09ce4mr13181636d6.2.1778547246279; Mon, 11
 May 2026 17:54:06 -0700 (PDT)
Date: Tue, 12 May 2026 00:53:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005404.946979-1-blasko@google.com>
Subject: [PATCH 0/6] net/gve: add hardware timestamping support
From: Mark Blasko <blasko@google.com>
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

