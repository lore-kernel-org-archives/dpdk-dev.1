Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4574F106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7514340669;
	Wed, 25 Mar 2026 21:45:53 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 73463402F2
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:45:52 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo13164f8f.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471552; x=1775076352; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xg66GSL466atRQp7gWMk9zQUTcXHETdPHslsRg+NJ+8=;
 b=hr9rICexX5xs0eRtzSdMLZ6/8X4qvQeQ+Hg48epsE9vYixrAnyk+E1RiVwFvhCfkXo
 CvVhu6DJ/8zi885fAelxTLDwftYtjdfgdjXfhva9Ql1tCCyC+3Yfdv+5IAxPsYC8vCjB
 dhR2vGtde2ziSzduCAmLCfIbnsUDBTqTSmJzMxiAdyoMIo6VnMLpiR7WxO8kha1i8dGw
 lME0y3twx1H6rbsVsXGO2uv4O4cFw2LvQCzGsvQMdB9+UlPquEubYTezHfTdwLj47HpK
 u32ayfpdQ5mPUZuyLTPb+2hQsT1GaAWA6n0Wd2rtZom8htKVN8VkXA7Ni73eO47iwPOk
 NSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471552; x=1775076352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xg66GSL466atRQp7gWMk9zQUTcXHETdPHslsRg+NJ+8=;
 b=Cif+LwhYqDmZ0XKtgVajKe9VEWHFw87hGd6YUXtVj7wioAHliM2dHszQUhVs0Z82iT
 3KbJ0L6LyX60TtMvTNEnTcQZa2YoJmVWR3vPoGHA8wMzEOr/2crQAcBw7epBuT073417
 bkwGBxjZZa9t+zmEeKBjcChxD1Amyp3RDx7pMNQX/ipH5/yqJ+4hwnY15M1JERU+4fqr
 fmy/jiufm1JfDmdJ0eq+We3/9luFzWPY215/6p1mAR5TenG56zU1O997aIOp3Dx3kcfH
 fizZKeOr8S4wFGnju/4SOtD3WaqaQToM9p/+VqHAcBHcXf54JhpAvkdHb+9M/AURG0oK
 VrZQ==
X-Gm-Message-State: AOJu0YxtJJaSygbiPz0EsHY4pPBXZw3dDhDJPOcIiwABM0Mc3owI3+/2
 llFbim0RCxEA5BxVZFbSiidJB2N8oEYqWURpuAzkvMKBRoOIGbQLwfLB72Bfjw==
X-Gm-Gg: ATEYQzxXym31A990nz1CdbVJ21cenHxaCUHgD+UiFYVa3CzXCezoYPLFd1GOaeHR9B1
 0ZQ2FB/BX5TC7emtPecxAAxLwWEWsagesUAWQz0cqgc6CLx+0Luzd+eboCaRUCz0FhrzCL0iAyJ
 vlbCkhhnK41F5OaG88I1uxBsP9MnKJu3nqh78i+XzOHfgh0mlfLsG9jpALAcG13m5ite2NXFfvA
 bUbl08mKesiKzk/ReiZ60kopMQfPVBZ6TcDhhtRZ+yBVUcIegUoIXBvvbylmZhTptbxTBw7TKUd
 mBU8Hq6JoOjdNQ9gWzYkxFcf27xO9pWwSuz0AoGacHdR9UzeTvvjwq61wJRKz7XmOz5dwD560ae
 WgkBINGOmQOYi8Pi+2R5oTf6wZR1gejIflh49sgrrVlMEcnjiol1xtiZfeKUujhHBIugMrMgKi9
 AdnbV4f46P1PGlmh8zkUm5PlaKSkI=
X-Received: by 2002:a05:6000:1acd:b0:43b:85d1:c45e with SMTP id
 ffacd0b85a97d-43b883d7f45mr8187812f8f.27.1774471551866; 
 Wed, 25 Mar 2026 13:45:51 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf1c4sm2410175f8f.23.2026.03.25.13.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:45:51 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 00/17] net/dpaa2: fixes and improvements
Date: Wed, 25 Mar 2026 21:45:27 +0100
Message-ID: <20260325204544.101444-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306133035.179709-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Various fixes and improvements for the dpaa2 net driver and fslmc bus.

Patches 1-6 fix resource leaks on port close, error paths, link status
and devargs propagation on hotplug.

Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
dump crash, packet type classification, checksum offload flags, software
taildrop buffer access, burst mode info reporting, SG table walk bounds,
and MAC stats DMA allocation.

Patch 15 is a minor cleanup in the link status area.

Patches 16-17 add devargs alternatives for getenv-based configuration
of taildrop and data stashing options.

Changes since v3:
- Patch 3: rename DPNI_OPT_HIGH_PERF_BUFFER to DPNI_OPT_V1_PFDR_IN_PEB,
  rename MAX_NB_RX_DESC to MAX_NB_RX_DESC_IN_PEB, keep total_nb_rx_desc
  calculation unconditional and only guard the warning, update warning
  messages to suggest removing the option or reducing descriptors (Hemant)

Changes since v2:
- Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
  long line in commit message (patch 10)
- Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
  fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
  (patch 8), remove colon after function name in commit body (patch 8),
  lowercase macro name in headline (patch 15)

Changes since v1:
- Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
- Reorder series: fixes first, then improvements (Stephen)
- Patch 2: squash with former patch 4 (Hemant)
- Patch 6: move devargs refresh from plug to scan rescan path (David)
- Patch 17: keep getenv for backward compatibility, add devargs as
  alternative instead of replacement
- Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
  avoid disaligning with other buses (David)
- New patches 8, 11-14 fixing issues reported by Stephen
- New patches 7, 9-10 fixing VLAN insertion and packet classification
  issues

Maxime Leroy (17):
  net/dpaa2: fix queue block memory leak on port close
  net/dpaa2: fix Rx error queue memory leaks
  net/dpaa2: warn on Rx descriptor limit in high perf mode
  net/dpaa2: fix resource leak on softparser failure
  net/dpaa2: fix link not up after port stop/start
  bus/fslmc: fix devargs not propagated on hotplug
  net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
  net/dpaa2: fix error packet dump crash and memory leak
  net/dpaa2: fix L4 packet type in slow parse path
  net/dpaa2: fix L3/L4 checksum offload flags
  net/dpaa2: fix software taildrop buffer access
  net/dpaa2: fix burst mode info report
  net/dpaa2: add SG table walk upper bound in Rx path
  net/dpaa2: fix MAC stats DMA alloc per xstats call
  net/dpaa2: use check interval macro in link down path
  net/dpaa2: add devargs to disable Rx taildrop
  net/dpaa2: add devargs alternative for data stashing getenv

 drivers/bus/fslmc/fslmc_bus.c           |   4 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        | 210 ++++++++++++------------
 drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
 drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
 drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
 6 files changed, 164 insertions(+), 160 deletions(-)

-- 
2.43.0

