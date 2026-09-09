Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FCC79FBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E12640C35;
	Wed,  9 Sep 2026 17:04:54 +0200 (CEST)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by mails.dpdk.org (Postfix) with ESMTP id 70EDF4067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:04:53 +0200 (CEST)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso4252045e9.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966293; x=1789571093; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9REAxfG2zY3W+r4B8AXBdz6VTW2Ou7LW6Dp8SMDCCM=;
 b=mgelADWQ7D+DF29FXzx5a5FQd/QN//rKHdW+cSowOL5r59J2h/XrKr4F0X6JvF2voz
 z5D77UUpx33q+3wcRviiGW8lJiOYWJmvY+wDi2qI3JvMuq5RqKPZnScT8kkUjVS9mEAn
 MRkkMhWnL4mnGGvZgN13sdpcEnmJ5AhE4D4uzzsb2ue0F/EnO5hK9UPRZEipsUSCKLTv
 ircew2kzasQ2B6Bldo24aVDS3pmCX944OJoUyZyTgcLi28zWKuAlh4uTEsmSaJ3zPeWE
 RlyX6Ga3azXUKOjVozsHniy6i2VAH7FFyfFtHCOxAsj67gtqjiIU7jauyNGQFWNC0w6l
 tPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966293; x=1789571093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o9REAxfG2zY3W+r4B8AXBdz6VTW2Ou7LW6Dp8SMDCCM=;
 b=JoVBEq4dSFfWHdlS00wIutRoY8dJU3OzvYsXleAvuRHYFu/jxIbywsKjedbE2JCdUj
 ng6NqwX8Z+F8dFUjXdjuorR8deFf3/wX9Hn92KmNQGviUVOF+wU3JIrL3q0W8wq6Sz5A
 V2pBu9MaeUTCLBEgBsWaoyS6RfT011bAKmMGz2X23prvaMcOUTxESEpSKSL7mKcAqdW0
 npKvmPjiZeODHsd7MRcR6RhnwOaHfBosYP/f/bTflnwKD53jkyKj+ULD1p4LA0+AQJdk
 ZX8X20VJfxcuq7EZyPn/+KS5bR5HM3KbYYKA8zAhQNnETmoV6RF5wpjldCtM6yv+DTZe
 959g==
X-Gm-Message-State: AFuF++mrpxGPD+0CYfSVcP2GCGAEcmCcFNtuMvM6mFVp7VFFKrGTPO3x
 drwxaCfPJxNxxbpuV6CKi1gtHAhAcJzd0U3aV+Kdw4/V9W5tw9kscQbgDARJfQ==
X-Gm-Gg: AYBFou2W3DATcMQqhbO08vWg9RH6j4hzJpacTIA3mDlAbcs8+xMQc6bd1bK635WjGPU
 RkIqhwNsb9TGQ7mupcvTF2RukGvU2HLYi1PZWPjiKbztu7LRXwjZYvKtpDWitU7E4e9tKWi9Q8P
 aHhQo/rQe1nJoa20SQvCqvMZ8AAvBU66L+eFWGM8pIYvdHM0Nq5PVAv395HMbfhK8BXUl8xjmwY
 36a4Yk28N8+wGLKeVC2TFbfOOIepwcX9LaosncYPen9h7X6bNrcXs/EvSg8/QldYj4diV4Szz+K
 Rk8sBqxuXuH6kCABU7ZdMgKGss9TMDeCvlcWoqRYRb1VyruxvVOWaofbE6/z1vh4jhqki4GqklS
 gLEaY5tklJPmGPFnlzmoA7iOMIBU+7J285i90vMbvINCYxnNWH2F+m4DISnKpevYb8KWxo7IbhY
 LRvfmqy9XjdNiSQTW5T4CeP9sZ+nLyizNwTd8TPuenVC5YZKrbWKvQVxAvVY7gy/jpPYEdMBwbQ
 +RLES3E1n/96XsuYZh8ZoW13kP4ShV8rGhgwN7ImgjYq5OvdPJQQnySJUZT
X-Received: by 2002:a05:600c:524d:b0:49d:577:532f with SMTP id
 5b1f17b1804b1-49d25947ec0mr31827905e9.15.1788966292631; 
 Wed, 09 Sep 2026 08:04:52 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20da3354sm49779815e9.2.2026.09.09.08.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:04:52 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 0/6] examples/l3fwd-power: fix Rx interrupt mode for shared
 FD PMDs
Date: Wed,  9 Sep 2026 17:04:43 +0200
Message-ID: <20260909150449.856295-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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

l3fwd-power's Rx interrupt (one-shot) mode was written around NICs whose
interrupt fd is assigned per queue at setup, stays fixed and is
level-triggered, as on MSI-X hardware. PMDs that do not fit that model
never sleep on interrupts: they either fail to arm, watch an unbound fd,
or miss the wake, and the 10 ms poll timeout hides all of it.

dpaa2 is the motivating example: it delivers Rx interrupts through one
QBMan portal per lcore, so the queues of a lcore share a single fd that
is bound when the interrupt is enabled, not at queue setup; the
notification is edge-triggered on an empty to non-empty transition; and
arming a queue that already holds traffic returns -EAGAIN with the queue
left unarmed.

This series makes the interrupt and legacy loops handle those cases
while leaving MSI-X NICs unchanged:

  1/6 factor the duplicated arm/sleep/disarm block into a helper.
  2/6 check the arm return: on -EAGAIN poll and retry, on any other
      error drop interrupt mode for the lcore instead of sleeping on
      unarmed queues.
  3/6 register the fd in the epoll set after arming, not before, so a
      fd bound at enable time is watched only once it exists.
  4/6 accept -EEXIST when several queues share one fd.
  5/6 recheck the queues before sleeping so a packet that arrived during
      the arm window is not missed under edge-triggered interrupts.
  6/6 block indefinitely instead of on a 10 ms timeout, and wake the
      workers through an eventfd on exit, so a broken interrupt path no
      longer hides behind periodic polling.

v2:
  - 3/6: keep the registration state in struct lcore_conf instead of
    passing it to rx_interrupt_wait(), and restore the "RX interrupt
    won't enable." notice, now logged from the arm error path
    (David Marchand)

Maxime Leroy (6):
  examples/l3fwd-power: factor out Rx interrupt sleep path
  examples/l3fwd-power: check Rx interrupt enable errors
  examples/l3fwd-power: enable Rx interrupt before epoll add
  examples/l3fwd-power: accept shared Rx interrupt FD
  examples/l3fwd-power: recheck Rx queues before sleeping
  examples/l3fwd-power: block until Rx interrupt or exit

 examples/l3fwd-power/main.c | 187 +++++++++++++++++++++++++++++-------
 1 file changed, 153 insertions(+), 34 deletions(-)


base-commit: d55ccd4e6de64e3f797f60de9e81f1d60f849775
-- 
2.43.0

