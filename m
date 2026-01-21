Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163CBC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 18:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23CF2427E1;
	Wed, 21 Jan 2026 19:08:52 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 3DB6C4027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 19:08:50 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so1384605e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769018930;
 x=1769623730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DjSjj91+GjiCjEWDADl3HaHH8NkhM8DAQuHRC5PI/J8=;
 b=gOJKpnt46ZmLVfrTQGye4TgByGrxsTCz12NnFPrrBWfYW7Pogt08EALldSoFFR9DcP
 Y+mqwXpsfdapRnRqH36Hkgzb+CLAwN9TG3lOLAqtAVPDzhwPQ+EUCqRqEYdasr3KjRiZ
 HVmj7abbomtg/gxg9Bi/sekPrPTEdp6+yKekrdnkOIQJxBBh+CbAK9z1MQZBQc32z8Gm
 6VAxXpYy0Mn7ZDG7mHoPO1YJEnr0WUgNIEf+ONqIHjOz1SwK60dWWWVBiEyuYd8fLPFg
 7t4tVxmQ0zKKVELZOULsSjhZZ7OnFAAnCxk27dMkceVqkS3o/TROsOjvDd2Fugl0cYzj
 QCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769018930; x=1769623730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjSjj91+GjiCjEWDADl3HaHH8NkhM8DAQuHRC5PI/J8=;
 b=Lp5bE1UN3rx8+x7hzowyK1FhOxxkVmQKH2pys8J+wKnloVGoMtUhGKBhfqeP8HGk08
 gBwrZ0vNu/I8qcamZb6LuCYwExbJXRo05SrnoiddcZ3FpEHJ3eEv8+KJMkk5pLRwcn0T
 3Ch+ctkP9JI9EHKO2QH4CqC8n1T3y6+4NA/g1hIGjHmktuNEug0yhEDrFVFQgy16XOfU
 UGabNxp4vWgDVJ6krvX+kfG2C98RajClvcCyKPy02760X2hbgiMTetiiXcMfSsIoemwR
 FkkmPcfm8bV/Y6AZlSGwFyIoaPHvY8r+ilhm0LjnL7AcHLZjsIAYW4UcOt/2mG6Tz+qa
 W4mQ==
X-Gm-Message-State: AOJu0YygAuyiomscrNoGuL4wKT0417QEvumAfH6Q9yw5SChKnf4y7Cxi
 7fzEgx/k8kbyzmt3qfs1Yw6TqtJAFoeQzacj9zq3fF5DqIWIHiugVYONqEW6UagG79vvPM46uPW
 Zqbea
X-Gm-Gg: AZuq6aIaOfBHheX4S5mPVUBMpSwzpKzbyJD9Y5lzfTTazItv82iVPkFTygaE92Bk5oM
 Gjopdb+lh31xDuZdpMN4Kfbyn81f2v3segdi3zgQ+Lyju4BSFi4/OQD6tWTDHkC4FxVrgFFGjBj
 LWF20TQgj5K3cgKGN5fQkOCkwuOU20I0+tPxgiW1Y0RaMrKKCNVI8ATYj1x28qI9NcuxXDEmoFD
 4YU4wQtDMeHpil/yFC1nlrdy4xexqbIwZxBxPMS2GN2pqlu1YeU94nKKrlfHXmBLbM12YrvtiUq
 E4MLt76kCHQhREofNkvtaYnK9vk7n+JtckN9rZ6HjoOX2iYZvJbbMAZIAFudm5DR37l0MKr/uzU
 VtQLIDlxxWeekhf6wFf+D89jC2y51pM9Uef7Zavlf3GbAip7EHShBMFjE9isIyWVT1gAZc3TS5/
 +TIQfYBGDy4l+FsZLc33dxdiYc0voHBIa48vbv3aMstdiYojFcqg==
X-Received: by 2002:a05:600c:a09:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-48045f7c2f2mr29853415e9.16.1769018929639; 
 Wed, 21 Jan 2026 10:08:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c2ed5fsm29093565e9.8.2026.01.21.10.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 10:08:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] Add pause to empty spinloops
Date: Wed, 21 Jan 2026 10:05:41 -0800
Message-ID: <20260121180845.889190-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

On SMT systems, empty spinloops can cause excessive latency due to
the spinning core consuming resources that could be used by other
hardware threads. This series addresses this by adding rte_pause()
calls to busy-wait loops in the cnxk drivers.

The first two patches fix existing empty spinloops in the net/cnxk
and event/cnxk drivers. These were identified using a new coccinelle
script that finds variations of the pattern:

    while (!atomic(&flag));

This is compile tested only! I don't have that hardware.

The third patch adds this coccinelle script to devtools/ so that
similar issues can be detected and fixed automatically across the
codebase.

The script handles multiple atomic API variants:
- Legacy rte_atomic*_read() functions
- C11 atomics via rte_atomic_load_explicit()
- GCC builtins via __atomic_load_n()
- Simple volatile variable checks

Stephen Hemminger (3):
  net/cnxk: add pause to spinloops
  event/cnxk: add pause to spinloops
  devtools/cocci: add script to find empty spinloops

 devtools/cocci/fix_empty_spinloops.cocci | 165 +++++++++++++++++++++++
 drivers/event/cnxk/cn10k_worker.c        |   2 +-
 drivers/event/cnxk/cn20k_worker.c        |   2 +-
 drivers/event/cnxk/cnxk_tim_worker.h     |   4 +-
 drivers/net/cnxk/cn10k_tx.h              |   4 +-
 drivers/net/cnxk/cn20k_tx.h              |   4 +-
 6 files changed, 173 insertions(+), 8 deletions(-)
 create mode 100644 devtools/cocci/fix_empty_spinloops.cocci

-- 
2.51.0

