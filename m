Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B6CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BDFE402DB;
	Tue, 16 Jun 2026 12:47:41 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 38E534026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:40 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so34382695e9.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606860; x=1782211660; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=kf6M2yx68XnX+BJH1EPkuam0kc13j9h1ubKu5LXmdfk=;
 b=r4An1mx4rwSo11WRSrJYAt+j7Bnww4L4gAJUJ7HHcnXmpJq1Ri4jZUCgdlFesGjucG
 4AL1dkOUywbHeeg63ZYhahjgOSDDoB8H/WP8imQpSeDpOghs99FNbgjrqrDRhO7D03Pu
 roOCCuaccw3fcJnaYpKpUhOOw41exMQGJAtggAWSOGnhiVzMdtXUgAvuXoXcIw7Mo75u
 NROVSV29Jz/MH4wPNB+RfavomYN7cQ9xWu1rlOlbGYooQLAnZIspziApd/MS2anrMQ22
 hRSL6+sLwjI5xJEXaFeQZW3WI7QLld4nqSSw/PQEcZacSUwgrEfyWoQnRziB6rfFfOU1
 gkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606860; x=1782211660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kf6M2yx68XnX+BJH1EPkuam0kc13j9h1ubKu5LXmdfk=;
 b=UTg/xEDZpN9eW9RNit+vpjPGTSmA/1obGoPaAtwlrtX3N3wH0EwGkn5pZTkWGkSPnf
 cG5j3smuoEqvBUWT1FsDOA+7d4H+OTh3FrRAN1Nu+0exetMe4Cy0U0xsZsAkuwQbq9jS
 N5uY48PV8puz4RkiGeA3tsl+oadorcwLvSzf8/1NROwuVv8JyudKJNcVd23Z3RftnVVA
 SsIcFqSupeBBnjqEWzSsfBIbdUk+4JCNyW+H4GymTlDMEVQ0A7w7Z/YRWUrPZcbFru4L
 HFgXj0hXlNuEy12BvAnxb/7+ybrOtjc3ZnSWPLpd4EAKEF8MdVGei2WuALSPX9bFz2yQ
 1i/Q==
X-Gm-Message-State: AOJu0YzP/2JxtiwGMqsPj/Ire/yHzpW+izALIws+J1HFYyzdcuCTUlF1
 EH/Y3qjMq0qNyCqvglYkdm6H6xwZFJkbSC/fzinsrv5tw6rTA82+RH6siQeOV2li
X-Gm-Gg: Acq92OGDoB/THgaNddmYebBrl1+C8xtQYDg2YgSt2RWhIUh90p/iLs1WaNE0fous864
 mzjE8y6QfDPc9Emb6TOn4utaZOex6DCa0UI+E+J4p2G3BcYudlhqOU+KzcnLYi/TEPMXoAIGL8D
 tPzTdgIwqVUEHY0gJxKo1k+AewEkUAp/o3okFd27j7heJOt5IfCzw51ymNyhuWzn4AbJ2aEPeGH
 P0nQia2AW+7KlSD6xig0jDmXtBfYMB2lzpTEO1B6ohikWFMF0vu48VC6fNTQ6eQALY18nYZZ48t
 JQrvpuOge0CyKKWIhL+4WTyD6dZEvPEPUzkma/s7Zl2XKKD/qrVCrq6THILlAmO5MXz8V3wugkc
 hffw6JlD2OlbCM9QmkeJYjoJ64tQcbfb8wxLWdGiK8pyRns23NkMzZ58x4RhV83vx7vVNSJA40D
 4Mn3y4mUtSun+8+3ETLaLXc2b3Z69n7X8VdGLjMKmPiA6JNdmuP67l5NtPCqljHvE=
X-Received: by 2002:a05:600c:4fc9:b0:490:b446:fb8 with SMTP id
 5b1f17b1804b1-4922ff938e3mr49847725e9.11.1781606859489; 
 Tue, 16 Jun 2026 03:47:39 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm150875f8f.2.2026.06.16.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:38 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 0/6] net/dpaa2: RSS fixes and improvements
Date: Tue, 16 Jun 2026 12:47:09 +0200
Message-ID: <20260616104717.723087-1-maxime@leroys.fr>
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

A set of RSS fixes and improvements for the dpaa2 PMD.

Patches 1 and 2 fix the RSS hash key: the L4 destination port was never
added (both extracts used the source port), and SCTP now uses the same L4
port extraction as TCP/UDP. Both are tagged for stable.

Patches 3 and 4 are small cleanups in the key builder (a dead num_extracts
increment, and the unset PPPoE guard flag).

Patch 5 honours RTE_ETH_RSS_LEVEL_INNERMOST so tunnelled traffic hashes on
the inner IP header. Patch 6 implements reta_query / reta_update as an
emulation over the HW distribution-size mechanism, since dpaa2 has no
software-visible indirection table.

Tested on LX2160A (lx2160acex7).

Maxime Leroy (6):
  net/dpaa2: add L4 destination port to the RSS hash key
  net/dpaa2: use L4 port extraction for SCTP RSS
  net/dpaa2: drop stray extract count bump in RSS key build
  net/dpaa2: set PPPoE configured flag in RSS key build
  net/dpaa2: support inner RSS level for tunnelled traffic
  net/dpaa2: implement RSS RETA query and update

 doc/guides/nics/features/dpaa2.ini     |   1 +
 doc/guides/rel_notes/release_26_07.rst |   5 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c |  94 +++++++-----
 drivers/net/dpaa2/dpaa2_ethdev.c       | 204 ++++++++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h       |   9 ++
 5 files changed, 272 insertions(+), 41 deletions(-)

-- 
2.43.0

