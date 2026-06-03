Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB1CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25476402BA;
	Wed,  3 Jun 2026 22:35:53 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD12402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:35:51 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-7e0aa486af8so8126977b3.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518950; x=1781123750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DD63Y2yuPpoZS9eNuxqs5kO2ijqlAHaEIwjlNwZxFck=;
 b=NmxMYbtvCxwu1AdoagQBJRI53IkwnqysP52ZHMNs5DhOkXgaBj6oLr2h9IPjkbdMWy
 8bkpkBHVd2EKBFDuObbTTivMxDxNvc1zuI7sh/1kYSY//ytd+hySQ1hg5nJ5WGonR8P9
 jmMK+lBah0rNz1uQnQ/zWQ5ezXyx+D9Thbf67m36kAKi2N/h4jn2CB2Kjcxvl5kum6cU
 Xa39Ofkg4XmE2vRrbXd0jc7Q/CbQw0pwbSE5G7QJ91GlPMc6ISwuIC/5KIB0XWF3pI2m
 Yrs/dK4Io8CroMmump9oGAFME1XzI1mp0DiYGS6fRz7etr4sABccM3wvrVdRsC9uhnSu
 udBg==
X-Gm-Message-State: AOJu0YyUBL+44l8irp+5NV+KHfk2nsfL+/Gk72ifX7+H0hG/MsJvSS0l
 edE0BWjI+hWl/0pHJnaCnseeLSHEsdfA7iGppPsLpW6LvXGMGhIysJesclfQAZJ+yDNpn05dyiv
 hBedE1w2NfIckIWcSsbD5kxSxgAVdsNu9l8j2uqNeWCcytl8QaEToH8o+LBucZw8M3eyTuZtFvL
 X9MXHnlnRKIQ8ZNziWYvr6RRAH1RBQwyEOFR9stunFEZH35va3G7EA3im+7ai4q5FosX1NCVZYD
 7gGLeVfEOtr
X-Gm-Gg: Acq92OEXiz8PG/8bb+8xgbujXAj/voKjIeq1fVocPqsMmhAgm1iRt7+za1bsComw0zD
 liNsGatiEz+Tfh3sMCSOs0VYPUWoFlI+a5iBaTfduNS2cwIB2rvh2Z5AkaXW1eUx3jCbnxx+ngS
 ry9UBlsq9ahoSkj6qwivMoBmhnOfg8LlEuxTRaqR3aTElSXgC/1mwyOY4kSytiu2mF6k2xbBSps
 kFYVGuS7TVlez5RKg+Zv2WGE4vsDDEKG2SzdqEBOC9KjPNuNIkj7rwVTT5+k/u1ge0ESsAN1NTG
 6C40MhqL0z6asVPc+yE3HLgnAYPNan3OZHa2+WovSCAVzUWJwFVE78ocVWAnXrA40ZZvgmJAKnZ
 AySV34yvrAjW8ac6mOQ4tpZFzLRbH33cYAXcVoLl80GSbcVWTof6hHbSX2NaC+oJsXQwBWDy0U0
 J7d4ZrdU5q3Lxn81Cm3zJSRo8zuZc34J0XXoerAIf6ArwGTLa2IYQfuDyt1flI5YGAkMqOOzjTN
 30R2SDuU/kR
X-Received: by 2002:a05:690c:e3ec:b0:7b6:7df9:33f6 with SMTP id
 00721157ae682-7eb8a7bcfedmr9721257b3.2.1780518950425; 
 Wed, 03 Jun 2026 13:35:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea20eab7acsm2632387b3.2.2026.06.03.13.35.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:35:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91565f8c589so233908885a.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780518950; x=1781123750; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DD63Y2yuPpoZS9eNuxqs5kO2ijqlAHaEIwjlNwZxFck=;
 b=VQ1KvtGVrn1euYqYPGIbrVXe0YR6hs+ZPAYLPJyaZT8+8wKgaqmbzWVc7OvDeSuUKZ
 LQzuGIQKgtVL+iZRCA4OncuUCLMMbDky2CsbZToY4MxEcwKN5Mn+5s/BWMdf0xnI0i9Y
 V4Z2J+oDaxd0NXAYqTUMggiHWu9/bQDlhU1wI=
X-Received: by 2002:a05:620a:4690:b0:915:7787:200c with SMTP id
 af79cd13be357-9159af2f994mr166594485a.23.1780518949644; 
 Wed, 03 Jun 2026 13:35:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4690:b0:915:7787:200c with SMTP id
 af79cd13be357-9159af2f994mr166578085a.23.1780518947739; 
 Wed, 03 Jun 2026 13:35:47 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm340925085a.13.2026.06.03.13.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:35:47 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/4] net/bnxt: ULP stats timer and PTP timestamping
 improvements
Date: Wed,  3 Jun 2026 14:37:34 -0600
Message-ID: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

This series improves PTP timestamping support and the ULP stats timer:

 - Move the ULP stats timer thread to a dedicated CPU to avoid interfering
   with DPDK worker lcores
 - Replace register-based PTP initialization on Wh+ with HWRM interface calls
 - Add HWRM-based Tx/Rx timestamp retrieval for BCM57414 (Wh+)
 - Add PTP support for BCM5760X (Thor2) including TX timestamp completions

The PTP patches carry Fixes: tags and Cc: stable@dpdk.org.

Note: this series depends on series "net/bnxt: miscellaneous bug fixes".

Kalesh AP (3):
  net/bnxt: Support for PTP on Wh+ using HWRM interface
  net/bnxt: Support for Tx/Rx timestamp using HWRM on Wh+
  net/bnxt: Add PTP support for Thor2

Mohammad Shuab Siddique (1):
  net/bnxt: move ulp stats timer thread to dedicated cpu

 drivers/net/bnxt/bnxt.h              |   3 +
 drivers/net/bnxt/bnxt_ethdev.c       | 172 +--------------------------
 drivers/net/bnxt/bnxt_hwrm.c         |  37 ++----
 drivers/net/bnxt/bnxt_rxr.c          |  23 +++-
 drivers/net/bnxt/bnxt_txr.c          |  16 +++
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c |  73 ++++++++++--
 6 files changed, 116 insertions(+), 208 deletions(-)

-- 
2.47.3

