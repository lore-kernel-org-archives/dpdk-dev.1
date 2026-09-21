Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0199EC982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C986409FA;
	Mon, 21 Sep 2026 04:21:21 +0200 (CEST)
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by mails.dpdk.org (Postfix) with ESMTP id 0C780402A4
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:20 +0200 (CEST)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-5c9801823fbso470231e0c.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957279; x=1790562079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9AjVQo8Iu+O7edl7V4sw0vhnsta77Yefzg4Fsj7pp+s=;
 b=pquQu6bjdw1K4PCPbTxL7dW+kTz8pSGCxNZserJfGzqFeqExl72rAgnSckUqnysR/p
 /kG3WsEbTfYUeoOREQt/pPoYCnnlInAwwwZkLkEwkZ/HpmOKnK+rM+K1hnqai7h+Rxhr
 XGqkcCb9pheNa9NwneIDVYDHK91D2eec6CHRGDvmuu8OualfUlcY8LiF+z5u/UAdOTZe
 LZKAcTxLgyqzaO5fSOVaSFzPXUxBaZz0dfLRamWfCIeTiXBu7xNvyM/h9SzfMQWcP2kE
 29KciFVcI/swuRz1dXwEW1zl+W4cSDwVSc5wLuhHJ1AiYHIFhzvFdyP8h6OfjQPgeVad
 7M+w==
X-Gm-Message-State: AFuF++lirjf8QYFisfVn6iaPTwqlD92KqL42ERP+h/YmX8OMmUJrEMtO
 TeKFMVTIzs8ZPu/QcM+bl01BTR/XLYlG7HdZpZa//BbJcxtoE60kQzkbQfeGH/v8kMfGbob0qM2
 xPysSj+yE+XEnCONOLvANRRiUXZ7nPUOtBqlfYZiqrlgSC9qClt4FYK3D9yfUnj8FleEGEw60pe
 IsDSX/H26Qh0sveq72+tbVM9fpOD/OIgLT2qmPAP2roImVzORyVOKJpLXINxNULYfMJuuRU/i1v
 1oIUc9JpfeP
X-Gm-Gg: AYBFou1vVnwb6rDHEf7FBLMhky1yk1Gmc973Eqg1cD/weJldtxxFQ10Tiq4mOKKX+lF
 2/sfXjrp2HBoCSKG4MxmGl2cBZcAsqSaaBqYh3x8d8e6euEquO5XB3Cu5sDt6dNbzBAteNATK3U
 oO8Xm3HL0REG1R/f3kedQ/KOOXapRu9ytJb++GAGamxfYTVonB8IUuzsUfWuIjepkRANclKz/3f
 9HT0SNIdkrWfGN6E2ZRxUj5kpfhhvJsqeQa+lbmNLypYfspiyZbNxPcjF/Ae6YcBWgHtxTO1swH
 2gZwrXgzJk+Y0aFwx7cUcpCQzKXbs6lvlca9dpNdkbFQtvbIh5rRi+xpZkZC+binpsXdQKDHVcJ
 d5wfQPDhhuDX/115BcqWIoFWYA8QG7FOf3M8v8nKR6MBB8uh19eKoRP7jWwjc5CnTCGGsQO6m/e
 z+JnmJk6Q3rUvqy+s9RsNDALNkG9S7sIa3L24fWOvdRLYstaJy+g==
X-Received: by 2002:a05:6122:1d08:b0:5c8:46e3:ec57 with SMTP id
 71dfb90a1353d-5c9b8a6906bmr3966939e0c.1.1789957279150; 
 Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c9c1792961sm2169724e0c.1.2026.09.20.19.21.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc51591102fso3742229a12.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957277; x=1790562077; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AjVQo8Iu+O7edl7V4sw0vhnsta77Yefzg4Fsj7pp+s=;
 b=XdCjd4hSOMsDBnfJdEX2UzWnQHJ4Vju4PQLHE5IFQp4f2kQqFlh0gR2brQLTWdBVSo
 dnQISuRW61atp2PHT/CI27HxZDFP3K/AgZoWG8LtWa7YibcJulB3nfMU0ejtYb47NEGO
 EhXu3sDhI3jFp5fj5FHEaAckSVhKe6hmZS4V8=
X-Received: by 2002:a17:90b:3fcc:b0:39e:6c69:34d9 with SMTP id
 98e67ed59e1d1-39e6c693748mr9339994a91.61.1789957277255; 
 Sun, 20 Sep 2026 19:21:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcc:b0:39e:6c69:34d9 with SMTP id
 98e67ed59e1d1-39e6c693748mr9339950a91.61.1789957276614; 
 Sun, 20 Sep 2026 19:21:16 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:16 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/5] net/bnxt: fix flow, Rx and naming bounds issues
Date: Sun, 20 Sep 2026 20:24:15 -0600
Message-ID: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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
   bound on the formatted string length, plus four related bugs
   (a leak, a stale flag, and two locks left held) introduced by
   this change's own new early-return paths and fixed here,
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

v2:
* Patch 2/5 ("fix bounds on TPA aggregation ID from completions"):
  corrected its Fixes: tag SHA1s to the full 12-character form, and
  fixed a real bug an AI-review pass caught -- the legacy (non-Thor)
  TPA end path's new bounds-check-failure branch wasn't draining
  pending aggregation-buffer completions before returning, unlike
  the sibling in_reset early return right above it, which could
  desync the CQ consumer index. See that patch's own changelog.
* Patch 3/5 ("harden sprintf bounds for device memory names"): fixed
  a real bug an AI-review pass caught -- bnxt_hwrm_ver_get()'s new
  early return on a snprintf failure also skipped HWRM_UNLOCK(),
  unlike this same function's other error exits and the sibling
  cfa_pair_*() fixes in this same patch, which would leak
  bp->hwrm_lock and deadlock every later HWRM call. See that patch's
  own changelog.
* Patch 4/5 ("fix bounds in MAC pool index and flow parsing"): fixed
  both Fixes: tag SHA1s to the full 12-character form.
* Patch 5/5 ("fix TPA agg Rx descriptor and VNIC query bounds"):
  fixed all three Fixes: tag SHA1s to the full 12-character form.
  Also addressed (no code change needed, see that patch's changelog)
  a reviewer question about a possible leak in the agg_count-overflow
  error path.
* Patch 1/5 is unchanged from v1.

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
 drivers/net/bnxt/bnxt_hwrm.c   | 75 ++++++++++++++++++++++++++---------
 drivers/net/bnxt/bnxt_rxr.c    | 58 +++++++++++++++++++++-------
 drivers/net/bnxt/bnxt_stats.c  | 18 ++++-----
 6 files changed, 175 insertions(+), 62 deletions(-)

--
2.47.3
