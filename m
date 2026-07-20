Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44594C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7300F4068A;
	Mon, 20 Jul 2026 14:07:08 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 0A5094028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:07:04 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495437bb891so29411505e9.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784549223; x=1785154023; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KeRM7pBAcXslTBXwSaYxQWwFxjHiPDimp03/SkV9vrk=;
 b=o7KQFvW6DfdcgMuLjmJcNor8PpqfUiPQMOj76L6xmF7+skQ9rEROdG70oH5qZMddHz
 wvoRTDxmPsZMnJRI3l4wtyWfiKidPG6OcambLzI9ojxPWWTglm9Z+JcFNXSf0qF239VX
 EJJBmPLd+ZlGMLMS7qflRgpZcwZU0JahfmWd1YOxY48EeMEonzHBFJC6Orwoux//6KST
 smt23+7G38CTqFqAXjLlqfppXzIq8GWvdpSE9fea4smmovIm3+0z2yuPtcXPxIb459DS
 CwPWlS05EXkltbfL+rNxRf35A1WGXLMO9COj1Z3J7MUPUpCBuC3S+0lAMEo0y5ZtIxl2
 La/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549223; x=1785154023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KeRM7pBAcXslTBXwSaYxQWwFxjHiPDimp03/SkV9vrk=;
 b=aJZgWkg6q3FL2E/Dk42pgr+iURDhOxjI8Knjy0dVo+vHPVO8jD7jo21cb5nDwMObeI
 VELtu34eVD09rAyuQ1LuCe0GbsDlOo8VgW555w/QI+0b8/CgSxhUTDpLA1VfWri3O/ET
 0cQqtf6Ckue6mIOh3JCykjcJFQ+0EuweKhBCDMgK65j7WgtxSyKeUnx0xHcDaRwqRPXT
 9bak95r6pDtSPinfl52f9WZkYpY3/Kq958eE7Ad1rdj7HV5tSJz10E1M27vLHtWWtvhp
 ckb+rLMqMFZxLZ9NR22K+wUVTcUzKXn+K799vKPoZua0Ag8eXlmOlVm4WxSv8WwFI38r
 oHCg==
X-Gm-Message-State: AOJu0YygJvVkVHPGbY7qx36qWxAE4QFXB6h6eXBXyEVGouH3RP1NcbNe
 21gamoAa55bwBRkJlCZpjZ3lAh0XcBpTkez+1sZjT592uvyxOcktZRyi2FtJTvis
X-Gm-Gg: AfdE7clo6tQb2KuQlPFsqmHiTCbKK7O/6/wRDKWPSvrY+6dR1rKC5uw7Lm5MVV/Netv
 rNxJ78CopAF1J3XexdAWx2ZvuAt6ZlibfW98hfW+KOogIiJy3CdRKTPxaXaop8TKb/A9XZDkuNs
 xdUZTXGWa0F/v2mjP5JFFMKd8dR3famCyDo4mLv1xW841xUtIWrVPqfDyI8V9MxDdSrDGoSfrVE
 iMEVet+JYiCx7p0lB+nXcDLtbNJZIFshHkk9532dRAgHOg/vpiaB3ND5SMqI2UY2/OhliCAntdm
 4YHusLtwfsN0Hj4aMGdo5Ow3yA6gwi0Wpe+tAwhaDrtQYbD/7dQ2+ciNV2Z0rEw3KqS3uIGEF+e
 iMaVyMNUrBdKEtLh6kwRKOHK776fhnnMJkjyPNAe9wHH5EcxPdX9G9IQfU0Ir4Mqqy5ha5dfZ0W
 wjD9UA5LdtUMLoKmYJ+ucVncT/TWCshACGrw==
X-Received: by 2002:a05:600d:849c:10b0:495:636b:e50b with SMTP id
 5b1f17b1804b1-495636be74dmr13509285e9.6.1784549223281; 
 Mon, 20 Jul 2026 05:07:03 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee0086sm31703509f8f.30.2026.07.20.05.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:07:02 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 0/3] net/tap: fix Rx queue interrupt support
Date: Mon, 20 Jul 2026 14:06:56 +0200
Message-ID: <20260720120700.801099-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717095842.419130-1-maxime@leroys.fr>
References: <20260717095842.419130-1-maxime@leroys.fr>
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
feature is not usable through the generic API. This series fixes two
distinct issues against the original Rx interrupt support, plus a small
type cleanup.

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

Patch 3 converts the driver's int-as-boolean fields to bool.

Patches 1 and 2 are candidates for stable.

v2:
 - use bool for the new interrupt-mode fields instead of int (Stephen);
   both fit existing padding, so neither struct grows
 - add patch 3 converting the existing int booleans to bool

The coding_style.rst note that discouraged bool in structures no longer
matches DPDK practice; it is dropped by a separate patch.

Maxime Leroy (3):
  net/tap: support Rx queue interrupt enable/disable
  net/tap: drain queue FD in Rx interrupt mode
  net/tap: use bool for boolean flags

 drivers/net/tap/rte_eth_tap.c | 25 +++++++++++++++++++-
 drivers/net/tap/rte_eth_tap.h | 11 ++++++---
 drivers/net/tap/tap_flow.c    |  4 ++--
 drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.43.0

