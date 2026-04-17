Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7484F436BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2A82402A7;
	Fri, 17 Apr 2026 18:55:35 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id C76D5402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:55:34 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c080efc1eso1402291c88.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776444934;
 x=1777049734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QTCISmdPWaDQlTrAOJ61G5jUdFiNmeExIP3CeHx7dfE=;
 b=DRB6OSubBGIL2aWpHnFFu3ehy0fK5ytKfhFd75OlFIVPN9OA9TTqvYst8gaRc53p59
 8jZpHPQhjYcQC1c8d+GBA/4KXZgPwu4qr38mE6KP7eo8sVBLvrsEAlBsvvIUMPumPazf
 oINjqA24iTHyd37MkoN/YX1Y7DCXUQQ1ELwjZiI0I7GlvfI4OhS7Y1CtKp1u+c5VR8+L
 XBrNqyAfTKvaq28Ic16RTx8fepAQVGKvOFU0PxUyHpvSBOB8MkIGzetJzaWMM3nxchM9
 HirDz4C/d1LcZivcitc2SxwUS+ICN6Q9kwTRmOl4OditoLvayzSfyv5cvzb1cKIaLroB
 Ow7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444934; x=1777049734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTCISmdPWaDQlTrAOJ61G5jUdFiNmeExIP3CeHx7dfE=;
 b=OlCsFi/LMu8GQzTk7+gT0vBzajHjvmrSLDt2rsRXYPrmYHkyF9leyEVx6Wa+FyjrFD
 kvYaxPNKE1XsdjtJUGHeZ0znYYVDxG9gTFrk/pPUY5dvqglM/9jpkY1/CxoMFWLWkKUx
 Hp+lskCQNcueu9WWLeRPSJl4ULyWf5zjstkP532+0oh00oYn6kdtqkODpphOL19T6iqT
 0oNm1RcLlkyeCe9rWKmdwV6zbE47fW0mQXGzwB8VDUWTL/Uvd4gxZ+u6P1hrpU1xqLhP
 LVyCM/c80DquUsqAE42KZlsDC4q+CgCr6yIVBNQJpp9Ehpym4RsAK2ZyAaXb7/stavOF
 adCA==
X-Gm-Message-State: AOJu0YwiO4IGYjxyXk4mApHIND5oUMoAQBmcoeEQFpsMVsKCXWe5ZcL1
 NlytqGnXlry7pqKYlLo1vdf5yXNx3WsR4McOpJtERkP2ZU922VkPel893KIv3gqxjkpyjs+1N1i
 bp7bX
X-Gm-Gg: AeBDieuoC36CGicf63BzeYT8cmXOGJymRuIa/KHlm6hU0rkXlTQmo+q1KeC7lJ+XMD8
 gbwBRKj2WoaXbVMvMqCepN1TIml2TvrM7KcuhegQWDlfxXt2fkEln84iiusqGUwQnttuczGkYI5
 xt882/mGZ2mPfYgG39bTP4+fkHgbxteet23rHPmadC4yU+mxcN05sAuL3BcIGu+uydGjy96m7Gs
 4m0aCMroO+JNyMmgowcK1MoPlGJ8bhea+DvMYCjc4n8nkKZYIg9usfWyLkB036OyRd5oWHcAGdY
 4jKlf02tiQ6AuWKORuWjxkutfyH84eO3886cj4Mf+elD6cs/Ec1We5awlAOv4cQCe/RaWmGjLml
 vcQTuHPkyxBMBZB8jjdWTqlxJRUv88HmzfmBtc8iffSfgKkm4AyZbD+9jIxkmXjJsdDfdvAJJel
 Al0kyyjT2+umFWAprrD/xGV/v0Kf8N6/PGh0icz31EKPM=
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-2e41a1e3fb6mr1561298eec.0.1776444933381; 
 Fri, 17 Apr 2026 09:55:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm2891264eec.3.2026.04.17.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:55:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] net/bond: fix secondary process crash and related cleanup
Date: Fri, 17 Apr 2026 09:51:34 -0700
Message-ID: <20260417165530.653328-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Patch 1 fixes the 8023ad dedicated-queue APIs which ignored the return
of bond_ethdev_mode_set() and left the enabled flag inconsistent on
failure. Ordered first so the secondary guard added next does not
leave shared state corrupted.

Patch 2 fixes the secondary process crash: a bonding port attached in
a secondary crashes on the first Rx or Tx burst because the probe
path never installs burst functions. Blackhole stubs are installed
and mode changes from secondary are rejected. Fully sharing bonding
state across processes is out of scope.

Patch 3 drops redundant %s/func from log call sites now that
RTE_BOND_LOG supplies the prefix.

Stephen Hemminger (3):
  net/bonding: restore dedicated queue state on mode set error
  net/bonding: prevent crash on Rx/Tx from secondary process
  net/bonding: remove redundant function names from log

 drivers/net/bonding/rte_eth_bond_8023ad.c | 19 ++++---
 drivers/net/bonding/rte_eth_bond_api.c    |  4 +-
 drivers/net/bonding/rte_eth_bond_pmd.c    | 66 ++++++++++++++++++-----
 3 files changed, 66 insertions(+), 23 deletions(-)

-- 
2.53.0

