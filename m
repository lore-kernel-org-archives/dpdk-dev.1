Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14576C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7E5642FC9;
	Fri, 18 Sep 2026 05:24:49 +0200 (CEST)
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by mails.dpdk.org (Postfix) with ESMTP id 0481D42F8F
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:49 +0200 (CEST)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-5c83fbd23a5so1225057e0c.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701888; x=1790306688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jHphe01UjcEruanjvCFTL4ygLlkD2GWIjpcIrtyP35A=;
 b=sitddJphb03pHK0Twu8nmFeUVoLNud8+na/QS4pm1FYkaOFE26aDM1xXId5Y9rcEx+
 9v2TwrM6XNp71PkVDKK3h4F1kuRl7+luyooK4BDfzGVuXlclG4VpuUk7GpGw1/wGxGI/
 3UqJexSWb/aiPiR6TqyaQYIqGefgNoFMft+1KURm0rYWq7pj7PAnBM9hb1/WOEaw4l3Y
 rVvt3bVtNmUvkAd56xeDMaarcWQndErtGi0720MKx48yJdMoDojqaLzrK4kJYb1cZUYE
 bU32d5mGBSFihqfh8MFGfLyh6YsgaSX9mLUyfAXpqxAoW0UU4aYlkv8aRvAa7nLDUAbP
 dPtw==
X-Gm-Message-State: AFuF++kIYutKqeaCpTn7oxo7zy88JPFQpE9znnr7zIaLQyNjXLKOXNsI
 RmYyhJec0WieVXOTYWyGZ6IQyvoBBr5tZrgSIz5pT1VehnGe4miXcAP/1cqTk3FPaAcGHH83MUR
 LracJQO1nY4gjy6MUrhtbBTc0h9N/sJnrTalSwsb8/cmwA+sYHl/IfVrv0gh4XoVyYIEmx646qJ
 76ZM8Ulj9OAPh9sIzj8Ex8fwQE3ha2PhtDM7LmHz9UhaDEK1XWn/JoZ8uvxB78alnJwAn1z6dvA
 hsNK/geniI9
X-Gm-Gg: AYBFou1nvVZCzyhXVu8pJSpzBXGMRq5cRGZouUcF//JvP9686ZLRL3uGT+Xd2XabXVf
 8K4qImNjoUI/tngy7sKMDnw3X6qHG8KQTmdF85u5ZO/liIVtXnmD78IcAP/4EOAIq5ZNiEPGr2B
 A/Wfm/8yNv0ZuA0I1dji6Gu42eK0vY35fg2LjG0ic/Gz4q1i7wcd1agiMrfK6GKXxP9IAVTli2i
 HMVaDxv8vxxfptEPiiw7SOx0FP4Red31cyLxTCkincoaDvDwj4jSXd3jcHs+1ki8vWlC+MDlkwC
 1KR8CsZuTLzAgYwKK3hjUmQ3vs8LPmRxFrKFHJ0/HTrlC9jYSCS8iVBA+0OzAHJm35XJPMdvKbY
 dLacBZ01E2XbB8fVlrylp3CGxKngdpCHBOJ4xLIlFPBuTv+8FEPqzts98RfMf7OANITFUHGs7at
 afjzm/p0Yzf8P979d3CosdIXlPZltpJHQ29XAPgFJ8Ar+fr4x0Hw==
X-Received: by 2002:a05:6102:a18b:20b0:7a1:f2b5:6460 with SMTP id
 ada2fe7eead31-7a1f2b5654bmr945893137.29.1789701888231; 
 Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-98337aa9303sm161309241.1.2026.09.17.20.24.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db22383e8fso4085045ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701886; x=1790306686; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHphe01UjcEruanjvCFTL4ygLlkD2GWIjpcIrtyP35A=;
 b=CMg1WFw+lPljUlrOGCdFHVkETkYzNgymUVHOOJ4xVVJmWbB0IBEdkCLsaNuxSdqMb+
 gc+R2dK604sWd1v1C8KkJPhfYjs1nmF4ACH8FZXetUBJ3379but6rq5jNnnNJ5w7+tmj
 5AeIh5RHpn1BWwMH1YKXOKitwb8vufMxiSk2k=
X-Received: by 2002:a17:903:3bc7:b0:2dd:ad7d:72e4 with SMTP id
 d9443c01a7336-2ddad7d74f2mr31935415ad.27.1789701886425; 
 Thu, 17 Sep 2026 20:24:46 -0700 (PDT)
X-Received: by 2002:a17:903:3bc7:b0:2dd:ad7d:72e4 with SMTP id
 d9443c01a7336-2ddad7d74f2mr31935065ad.27.1789701885843; 
 Thu, 17 Sep 2026 20:24:45 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm537742eec.5.2026.09.17.20.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:45 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/5] net/bnxt: fix flow, Rx and naming bounds issues
Date: Thu, 17 Sep 2026 21:27:47 -0600
Message-ID: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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

This series fixes five independent out-of-bounds issues in flow,
Rx-datapath and naming code in the bnxt PMD:

 - two stack-allocated variable-length arrays in flow-stats sizing
   that risked stack exhaustion,
 - a TPA aggregation ID read from a completion and used to index
   rxr->tpa_info[] without a bounds check,
 - three separate sprintf() calls into fixed-size buffers with no
   bound on the formatted string length, plus three related bugs
   (a leak, a stale flag, and a lock left held) introduced by this
   change's own new early-return paths and fixed here,
 - a caller-supplied MAC pool index used before being validated
   against bp->max_vnics, and an unbounded flow item/action skip
   loop that could walk off the end of the pattern array, and
 - a firmware-supplied Rx completion opaque value used unmasked as
   an rx_buf_ring[] index, an aggregation-segment count guarded only
   by a release-mode-compiled-out RTE_ASSERT, and an unclamped VF
   VNIC-count from firmware.

Each patch is independently bisectable and was validated with a
scoped net/bnxt build (and, for split points, an intermediate-commit
build) in addition to the full compliance gate.

Chenna Arnoori (1):
  net/bnxt: fix bounds in MAC pool index and flow parsing

Joseph Wong (1):
  net/bnxt: fix stack exhaustion in flow stats

Keegan Freyhof (1):
  net/bnxt: harden sprintf bounds for device memory names

Kishore Padmanabha (1):
  net/bnxt: fix TPA agg Rx descriptor and VNIC query bounds

Mohammad Shuab Siddique (1):
  net/bnxt: fix bounds on TPA aggregation ID from completions

 drivers/net/bnxt/bnxt.h        | 15 +++++++
 drivers/net/bnxt/bnxt_ethdev.c | 43 +++++++++++++-------
 drivers/net/bnxt/bnxt_flow.c   | 28 +++++++++----
 drivers/net/bnxt/bnxt_hwrm.c   | 74 +++++++++++++++++++++++++---------
 drivers/net/bnxt/bnxt_rxr.c    | 57 ++++++++++++++++++++------
 drivers/net/bnxt/bnxt_stats.c  | 18 ++++-----
 6 files changed, 173 insertions(+), 62 deletions(-)

-- 
2.47.3

