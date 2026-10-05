Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38793CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B837D40A7D;
	Mon,  5 Oct 2026 17:17:13 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 6E757402EB
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:12 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3a0af54af74so455787a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213431; x=1791818231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wd63vhPhEhq1GsTjYYKeDLFyGsA9UPX8JenFSB8hKCo=;
 b=HxCw9ON4tHEqnEZN7ksWcke26bMkmppQ0ZuAA15m8pIlouzzVN1MpgQbHwJki3Sz6p
 9G8jvMDflt9hmv8xVvXLWlY8g/SU3scyC7Y6nOJGE9yUlvcMABMbM5XFeCtQLXrPMIig
 kNIRJwH0q1gDY/KKFM8R8RfxtJytyrQe9q5TbnGJ7mZnm0MKpCs53pMKxRmnGZM4XFU5
 5IGJ+8Gv3PmHIn1zi0EF+Omsulnk89U2csLJP+G/4EadPqdVgfimSDYBJwKtCh06DuWL
 U5wXXRhlnR/Obm5+Fi1BUlDhBX6D1tRVfYo3vKmk2pQvXkHs3I50d4buOlID2cVRoEcR
 Sabg==
X-Gm-Message-State: AFq9FYJUNpgL01427UAwd7VKejjfhX9cAAQYDKFVTs2lF5KQ/+XPiO2X
 XGHlR/i67BcKLO56DBri45mvV7K+9mYuQHNMTQ6d4SwCRv0AwlMpAdUmdqsYJQ0SGbZ5Qa4LuLi
 ZWA7um3SUzEXNM7kkZajzvhp5oJSKMd+orygxQhkL1GlOrLKAmQ1oEHaI8HcbpsaLtF+6KkmCCW
 pw0lvBTj1b3r0C5lCpUHwQSaKLS7kemKKRUoYdsYOlMyfEjdMnwSOMG5l9ory5Dh5Kk+MJ0g==
X-Gm-Gg: AYBFou3r2b+PjXJDY1EvvmnHyo+amwTH3oItYCBGU8SEHuxfmRK81VtwKcDMUD0e5Hg
 ker4eqLx7OAGO+14sZzG3H8YO1V+cEgY6ruqyXBOJe/qLZRrYTv14Sep7N3Jz2Bwn6f73vHTJWY
 nzIuW9p8Th05+Q7GyEpNdZN7vPgoKQThNlOXFTMGUwksGQZUe5pB/R4XBwciB038Cb0TQ0Aztmx
 qtiD1Eti7WCHkKoMJsBbXETDkZiE2OIpPKMgvxafHsBFrU6jIiEjv4Ul/jZUP5JgmHhKpPsl7Yz
 AK8KfA00CRYPX76DcPPRSUf5wroYVEz2MGd/afhpS0dJbexk5QDGJarI6KWFiRu+kI9FtV+RYE9
 5ftFIlyr0XyzPh0WPU7RWwXXJlS17uwRh9XYtrUCKie9nk1bLEcVWBaNyPRGNXLfk9ju49EKwNL
 iv9X7NFTow1mP5d4TnSDTNl1c1bSfmXbUEu53e1w==
X-Received: by 2002:a17:90b:4b11:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a6cec9b3bamr9509963a91.39.1791213431185; 
 Mon, 05 Oct 2026 08:17:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a851627eb3sm830a91.0.2026.10.05.08.17.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bfb2da664so403893985a.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213430; x=1791818230; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wd63vhPhEhq1GsTjYYKeDLFyGsA9UPX8JenFSB8hKCo=;
 b=e9h5c0WhPuR7pDnNbXPT7KxEOcb5QfC/7gcQBw1gqJeSG4Fg1S32xqS2yskXp656eA
 M2qdgUAqYM9Sd2XrMuQ4kl2xjO3f9mAcDtbUn1abrRlKQ17cS8meg70ddUlwNGtwgPE3
 SzNNDevsKrqYFlkjMsDwkEOyBldLYfznv5wqo=
X-Received: by 2002:a05:620a:6014:b0:93e:85bb:da8f with SMTP id
 af79cd13be357-93e85bbe337mr4029685a.29.1791213429715; 
 Mon, 05 Oct 2026 08:17:09 -0700 (PDT)
X-Received: by 2002:a05:620a:6014:b0:93e:85bb:da8f with SMTP id
 af79cd13be357-93e85bbe337mr4021685a.29.1791213429011; 
 Mon, 05 Oct 2026 08:17:09 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e7ec53cd0sm110432285a.14.2026.10.05.08.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:08 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com
Subject: [PATCH 0/2] net/bnxt: fix message layer and hot-upgrade issues
Date: Mon,  5 Oct 2026 10:16:57 -0500
Message-Id: <20261005151659.1705967-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This series fixes several bounds/pointer issues found by static
analysis in the tf_core message layer, plus a related validation
limit bug found while fixing them:

- Patch 1 caps a memcpy() to the caller's buffer size in
  tfc_msg_idx_tbl_get(), adds a NULL check on that function's
  caller-supplied dev_data/data_size pointers, fixes a fall-through
  in tfc_msg_if_tbl_get() that let a size-mismatch error still copy
  oversized data, and adds missing NULL checks on a caller-supplied
  pointer in tfc_msg_idx_tbl_alloc_set()/tfc_msg_idx_tbl_set().

- Patch 2 fixes the app-instance-ID validation limit used during
  hot-upgrade: it enforced a limit of 4 (the number of concurrent
  instances) instead of 8 (the actual valid ID range), incorrectly
  rejecting valid instance IDs 5-8.

Manish Kurup (1):
  net/bnxt: fix hot-upgrade app instance ID limit

Mohammad Shuab Siddique (1):
  net/bnxt: fix message-layer bounds and pointer checks

 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |  2 +-
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         | 32 ++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.31.1

