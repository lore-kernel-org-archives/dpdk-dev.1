Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE8C624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D9340E37;
	Wed,  2 Sep 2026 17:57:34 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7106C402DE
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:32 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d8fd3b729dso11295235ad.1
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364651;
 x=1788969451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPPsyLzC7Rdt8DyAs4yrYKdoxH9157wYB8b936Xvitc=;
 b=lWXyGWciULis9SBurayovVaInesit1lCqyhLiY0jk76oUg/nhGh6SclYw0pBHET8HM
 Ja7jAelUqQ6Bis399C/whhR8cPG+myua2OH7QdWTExLpfOgJIAzlSG5sUq54dj+sy1PD
 UgXphy5wkAt5yxnCskJf3uWcU/lS0QE3pP6HONsX2vakcTIUTppaV649Qas8mhVnfucM
 W45SnNYsshSfy+lFKUQwXR8+YkaoeDnFVR2ivK5wtF0+HBfYMhn7FjwFHw0/QEYuPA2e
 p9tCI14PdxCcbwVtCQEeu11qbTj/JN3AaDm70cxel1+Nf0Xa9BSGsdXenR+xUbVOnezC
 mPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364651; x=1788969451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPPsyLzC7Rdt8DyAs4yrYKdoxH9157wYB8b936Xvitc=;
 b=i6EAVopvSvKyUJqS5PGLsdjzkOPkGRauaHMYdETVr+deygrf6DC1XK2V6h3FfI4cF1
 oGV8sSOIMZ+Yr4xWhCfrXlHYZTkssqE5Uq63ZUC2GkgzVyqhGBTn1zA+qIrhermOk1Gm
 JsvZJn+E2aIxcq05yfsH2JErXHyFSyNcHrUlaG06seq7FJNkonZ1lPL0UlJTB8l1oLD1
 utqNZauByOZEQgyT2UsV86EjQk+7M5+pDXm/ZRpz58K67kVC29UMGL6MJCp7zgSfdJ4Q
 diMcX0OVRmAIfydJHNYZcklzg9Y5ppnutMRL65njRRN8qpGHmgA5k6BDl4suwJiIXM8s
 EwtA==
X-Gm-Message-State: AFuF++n8iQm4dSqNCaaCTtrNY00ZjIksO5aA4rF3qe9o2yDpdsDruwGM
 4fpNmmizXd3guzY98ls4AMV7f5O96rsqOeHd1xmDJbdyv1vvt0D+8661qkj5fcD5pw1cUfqbVA9
 76jGw
X-Gm-Gg: AYBFou1+KboLj5PyAYm4FTgcU0y7CDFqY/H/qZjonV+KKwphZW84uya9Toh7xYHOoiy
 uisNbxBBF1AAsEfL/KBkV6RF7sKDnHXEB0s58ZOI+DViqX4Gh+g8/iHcnp5UszyaMq5NTv+vWFC
 t4j5B5nqmrXBSRVrkYz69GAWvE1eyh50KYG49+hqhicQ8WUXGY56BfO54DX3CbUgtNEh9IzXMK2
 vkC61/H7b8tGAydYtqG4CGm9oazsWojSlBUDs6vCEF8Bo+6lXpk7a7RKFAifWitmBwkGatgHaVZ
 T5AkbkkXy3wjGm0vD6TVlARIk6F5QCa3rqAQ/pFPhIuSbCq8pxGP/dqeTHFW9HYymjGRTkmp0qu
 YFC0l7WMDLnawV33OqWNCWzUWG3k42KKWr7uy28AD5fAtcbOJcMOzivDk7YctPNvP9GxX60Xkg0
 uqIgAKz8QglJMEuye2aeh5b2MUtdC7e2lldSndFLY3fPwKhWAp+//pwpekrzsq2Pz4GpqRe2v8s
 lRjsWhoBP6y7p90f5iuCHiuifg=
X-Received: by 2002:a17:902:e947:b0:2da:c09d:b5d2 with SMTP id
 d9443c01a7336-2daec5f4a05mr88849655ad.3.1788364649728; 
 Wed, 02 Sep 2026 08:57:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] eventdev: promote long-standing experimental API to stable
Date: Wed,  2 Sep 2026 08:53:53 -0700
Message-ID: <20260902155722.577747-1-stephen@networkplumber.org>
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

The eventdev library still carries a number of experimental symbols that
have been unchanged for several releases. Per the ABI policy,
they are overdue for being promoted to stable.

This series removes the experimental tag from the eventdev API that was
added in v23.03 and v23.11 and has not changed since:

  - Rx adapter runtime parameters and create_ext_with_params
  - Tx adapter runtime parameters
  - crypto adapter runtime parameters
  - timer adapter remaining ticks get
  - event port link profiles
  - the DMA adapter API

With these patches the Tx, crypto and timer adapter source files have no
experimental symbols left at all.

Deliberately left experimental:

  - rte_event_eth_rx_adapter_queues_add(), added in v25.03, is too recent
  - the vector adapter API in rte_event_vector_adapter.h, also recent
  - the remaining experimental symbols in rte_eventdev.h

No functional change: this only swaps RTE_EXPORT_EXPERIMENTAL_SYMBOL for
RTE_EXPORT_SYMBOL, drops __rte_experimental from the headers, and updates
the release notes.  Since these symbols move out of the EXPERIMENTAL
section into the stable ABI, this must go into a major ABI release.


Stephen Hemminger (6):
  eventdev/eth_rx: promote adapter API to stable
  eventdev/eth_tx: promote adapter runtime params to stable
  eventdev/crypto: promote adapter runtime params to stable
  eventdev/timer: promote remaining ticks get to stable
  eventdev: promote link profile API to stable
  eventdev/dma: promote adapter API to stable

 doc/guides/rel_notes/release_26_11.rst  | 19 ++++++++++++++++
 lib/eventdev/rte_event_crypto_adapter.c |  6 ++---
 lib/eventdev/rte_event_crypto_adapter.h |  3 ---
 lib/eventdev/rte_event_dma_adapter.c    | 30 ++++++++++++-------------
 lib/eventdev/rte_event_dma_adapter.h    | 19 ----------------
 lib/eventdev/rte_event_eth_rx_adapter.c |  8 +++----
 lib/eventdev/rte_event_eth_rx_adapter.h |  4 ----
 lib/eventdev/rte_event_eth_tx_adapter.c |  6 ++---
 lib/eventdev/rte_event_eth_tx_adapter.h |  3 ---
 lib/eventdev/rte_event_timer_adapter.c  |  2 +-
 lib/eventdev/rte_event_timer_adapter.h  |  1 -
 lib/eventdev/rte_eventdev.c             |  8 +++----
 lib/eventdev/rte_eventdev.h             |  4 ----
 13 files changed, 49 insertions(+), 64 deletions(-)

-- 
2.53.0

