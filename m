Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4BFC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46AB440E24;
	Fri, 17 Jul 2026 11:59:04 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 46B3B40A75
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:59:03 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso66191565e9.0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784282343; x=1784887143; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wHQNFr5UOBkN25nBjHpXn4/tBnniDFWkhEEpfWDjLao=;
 b=Jw3PcYsFmjWZZG8/9NLm3EZX3OtCm5RxhZizTdfP81IWsrum4FzuYgdgF5i7NputBE
 OKm07o9IfdqBfRBNgVjtk720ShkISHDP8fILT3JDgtPuHF+h8L+uC//YwEAWyaqR6jbu
 +lAZuWH8mF0IMUhZgAGRjbSur/8h/PB95/4yIVlBafD5JdwkjDGo0SHZQCiKgUXq1wI5
 CLaFGmuqT+VJi8wj60itj1r+La4jgiRE0YwVI2+N7qKdwIQNEWOk5hs5grflcUHan6EA
 6u+xfyrhDwdIJ7mghatcDsIEm5UJaFkye+YhXXZYNWtYoTht1ENDe5TKkrWKuX8UtPYE
 uGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282343; x=1784887143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wHQNFr5UOBkN25nBjHpXn4/tBnniDFWkhEEpfWDjLao=;
 b=eyuX8VdQ1gpHwRistETowr+2vVDjKwjIWRQh5ILwuiOXXgiPPnA6npEAFsGNSLR6sM
 KVIGwqlz7wOue8z9gwDX222PUALw/tbvbR5esTgrnKFxmUqtBC8rhzOfah2GBdKATOBB
 kP/Sa8nQPaYf7Y47s8z8TVQOl2rXUXrW+Joyn1olt2/bC4IU7uka4e843EQgRS9tdM74
 HPVlwVWyj81f9MByEbs+UzkMIvKdwG8tHu//zzG0YDtD/L3QRDwu5/bewJsnoBzto58l
 nvO28wtaTK/4k2nh/ie6VIHLQIvf8pGv6ID328L46EDMVMmS60XpglpRpsRGTjSan6Pl
 MSZw==
X-Gm-Message-State: AOJu0Yy31btiF0U3DZwoqYPmsrqz1emKyErkXr+9bZaVALcJVKg6jwW2
 DdJ8jprbUU1LXlFEnGmbcVhiLXl/GRnuRJrsTnbADgJCan8qn/pCJypYvO0hfc/r
X-Gm-Gg: AfdE7cm0lJt5hzyj4vQeemvntBMAVZvRvEzP0XfWlnIG9M3SZWt0w3nde9PVlMIcYEW
 XrNbUuBFCXTLgQhEfbOSYy31Q9UEJwTRJVEJh4K54xQf79k1V5xlukrpp5iBUOrjc2zzBKRlo2y
 5B+Z2czsXLLaZw7KJ6RZA127oWj+KM3AkUFWwvTKkzEj0ykEKxoHmlfAsxWZku3fkkGfOJJ7h6R
 ZWxS2uyzUVlWll3reAaeBmUGArkxhCGr55/MKxKf3rMYyx+Dgl42Yib4xvFXncYNAKTKNqyag3y
 TUFyUgGKFidXauVC2uA2jgjvipA44tboVm97OArzm3+HkwAiDa0UIAZelvrbHK60VOd80k9GipI
 sQxGINe4fr6G4uCRlPr4jI6MZyGDIcWBlRykWEO6zLIbfhqgmZZC9zi5aIVVTchmivOCKV6HPGn
 5iYTZXpbQR92CJu14ALwHFsA2VqylDK+nrvwVL22Q+
X-Received: by 2002:a05:600c:154e:b0:495:405c:38d3 with SMTP id
 5b1f17b1804b1-4954a3df9f9mr25239505e9.9.1784282342520; 
 Fri, 17 Jul 2026 02:59:02 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm2789131f8f.5.2026.07.17.02.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:59:02 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 0/2] net/tap: fix Rx queue interrupt support
Date: Fri, 17 Jul 2026 11:58:40 +0200
Message-ID: <20260717095842.419130-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

The tap PMD registers each queue file descriptor for Rx interrupts but the
feature is not actually usable through the generic API. This series fixes
two distinct issues, both against the original Rx interrupt support.

Patch 1 adds the missing rx_queue_intr_enable/disable ops. Without them
rte_eth_dev_rx_intr_enable() returns -ENOTSUP, so applications that arm
queues before sleeping (l3fwd-power and similar) treat tap as having no
interrupt support and fall back to polling.

Patch 2 fixes a traffic stall specific to interrupt mode: the Rx burst
skips reading the queue fd until the SIGIO trigger advances, but in
interrupt mode the application wakes through epoll, a distinct signal, so
the burst can return 0 right after a wakeup and the fd stays readable with
no further edge. The fd is now drained unconditionally in interrupt mode
and the SIGIO trigger is not armed on the data queue fds.

Both patches are candidates for stable.

Maxime Leroy (2):
  net/tap: support Rx queue interrupt enable/disable
  net/tap: drain queue FD in Rx interrupt mode

 drivers/net/tap/rte_eth_tap.c | 23 +++++++++++++++++-
 drivers/net/tap/rte_eth_tap.h |  5 ++++
 drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.43.0

