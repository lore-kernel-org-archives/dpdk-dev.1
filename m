Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F71CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E660C410DC;
	Tue, 29 Sep 2026 02:21:45 +0200 (CEST)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id 4640D40E45
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:44 +0200 (CEST)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-880d942556cso677542b3a.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641303; x=1791246103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8WHHNs0308/7z08qiKgRbx09aLmQb1vzKkQ3rgYKWfY=;
 b=0gWAME/C9o7aSaymBfSWI/ScBTwV6bClTjrXHPNucFkMKJkaQKYG5Ql4ilcWBM5Pm8
 CVf+l7T1mL/o3alooRGndWx+WaZgV9I3sLGHIikpFI1ORnAFAcNWXQfFuKEJ+gvurvLz
 S+g0ifcuXQhTMDCq8I9mHR3HsLGNf/svo6GvZhEfMz0MkY6GxkZpgZmtZM/7qShkKLK/
 obVk87R9Pq8o/fTHM9Ix4G0s6kXnKOveqdvF0H6PEkHr9CyGONpy+fqWWR/shmchzeyq
 npUvM8TF8E+Fp2QKT9teOjLFwnge0TChIRjkq7u/Dx0Fly6BlmS9mQMKldnnbHSy5nob
 EyPQ==
X-Gm-Message-State: AFuF++kNztM6Ms2gV5leMCXodYmj0HpYPTMh836sZTsbasf29mzzPK3L
 LYYYW9vI/HXI0GoFcE41S5jpaTo6WaXTjAnDGDTc4kJqU5leW4EBp6TrZHVkPzf+byOe1+UaA/i
 UiT152X5rTP5mavlXcYjUjotO0MiD/wDEdUailzzCMIr4AZO9p1ezmURXIYp+jGFvjFvXuiOQeU
 fvKXbrCQXf5qkRr4CbuIt3hMzg8VIASv2ESezcTdsorZ6u2nBbNYDT+LkwEmZjqVCj9I1AGmLGx
 /s1FXg6p063
X-Gm-Gg: AYBFou23MEaXBDWBf7pfR+ekSDUGPu5ua5GP1O+EH8K5Ta9JDVHxFW2jOLtJcwhEqWa
 R0fAmFI7Gc5PrVAx0ZFMOELQGBcqpKujy4IBDXY+t6Yh2PCGxiBxD3Sz4ipNrT6mTrPQkrEnqnn
 JoxLmZ6O1JoLmymDtQAM1NaK7uUIImtSyAZG8aP14qaNFKdOQz/MG7E+sX4SkcpTUwaNNzb6Grx
 Mrn1i/FnqANMeJPfpxqlas6zYC4IEG9AP/NABVZhLigMUELRKWCbLWejdSau/hnTFrh1yVSyOtR
 Agmp8KUOqydzjiV03h9fw5hioxpeju2Gf2r5L70N7yYacK25XgQ67TMKjcqFOv5HFR4UzXusgQk
 SF0FeWK9nwV3itH3OurXhry2gLLhs4qPZf48cErbqfMvdheKkG+Oyvh1CgQMFi+PkdGx/ReBClD
 9vOHQg6Zx9bswOvG7fvRV6nWrDhasHFqfQZVtJbJvJyTgiSVmWVA==
X-Received: by 2002:a05:6a21:113:b0:3dd:85a8:cad3 with SMTP id
 adf61e73a8af0-3de0e8ebe93mr11882838637.42.1790641303262; 
 Mon, 28 Sep 2026 17:21:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc787760a08sm7403075a12.5.2026.09.28.17.21.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9106fce784dso74673636d6.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641302; x=1791246102; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WHHNs0308/7z08qiKgRbx09aLmQb1vzKkQ3rgYKWfY=;
 b=NSscoD0PmJMmHhMdjoF84GFBzyPiJfn90bTtZRX0CcfdGt8kiKWkiHL4IZltrawCaV
 eocrzfLJdJBq6H5wUhwMSCTG1A1FCKceWrf08hwK42nUdr+qJEjYQygbgEe33/SF4/m8
 iWQUZzJJo9/vN6uR4KzUKXyT6PvPvj2oufizo=
X-Received: by 2002:a05:6214:2b98:b0:915:bec:310b with SMTP id
 6a1803df08f44-915eb128c32mr93768896d6.5.1790641301808; 
 Mon, 28 Sep 2026 17:21:41 -0700 (PDT)
X-Received: by 2002:a05:6214:2b98:b0:915:bec:310b with SMTP id
 6a1803df08f44-915eb128c32mr93768506d6.5.1790641301212; 
 Mon, 28 Sep 2026 17:21:41 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:40 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 0/5] net/bnxt: fix flow, Rx and naming bounds issues
Date: Mon, 28 Sep 2026 18:24:37 -0600
Message-ID: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
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
 - sprintf() calls into fixed-size buffers with no bound on the
   formatted string length,
 - a caller-supplied MAC pool index used before being validated
   against bp->max_vnics, and
 - a firmware-supplied Rx completion opaque value used unmasked as
   an rx_buf_ring[] index, an aggregation-segment count guarded only
   by a release-mode-compiled-out RTE_ASSERT, and an unclamped VF
   VNIC-count from firmware.

Each patch is independently bisectable and was validated with a
scoped net/bnxt build (and, for split points, an intermediate-commit
build) in addition to the full compliance gate.

v3:
* Patch 3/5 ("harden sprintf bounds for device memory names"):
  dropped check_snprintf_rc() and the early-return paths on the CFA
  pair_name sites entirely -- Stephen Hemminger noted the rc < 0
  branch is unreachable and plain snprintf() is enough. See that
  patch's own changelog.
* Patch 4/5: retitled from "fix bounds in MAC pool index and flow
  parsing" to "fix bounds in MAC address pool index" and dropped the
  flow-parsing half entirely -- Stephen Hemminger pointed out
  rte_flow patterns/actions are always END-terminated by API
  contract, so that bound guarded nothing reachable. Also reordered
  the remaining fix to check pool-vs-max_vnics before dev_started.
  See that patch's own changelog.
* Patches 1/5, 2/5 and 5/5 are unchanged from v2.
v2:
* Patch 2/5 ("fix bounds on TPA aggregation ID from completions"):
  corrected its Fixes: tag SHA1s to the full 12-character form, and
  fixed a real bug an AI-review pass caught -- the legacy (non-Thor)
  TPA end path's new bounds-check-failure branch wasn't draining
  pending aggregation-buffer completions before returning, unlike
  the sibling in_reset early return right above it, which could
  desync the CQ consumer index.
* Patch 3/5: fixed a real bug an AI-review pass caught --
  bnxt_hwrm_ver_get()'s new early return on a snprintf failure also
  skipped HWRM_UNLOCK(), which would leak bp->hwrm_lock and deadlock
  every later HWRM call.
* Patch 4/5: fixed both Fixes: tag SHA1s to the full 12-character
  form.
* Patch 5/5: fixed all three Fixes: tag SHA1s to the full
  12-character form.
* Patch 1/5 is unchanged from v1.

Chenna Arnoori (1):
  net/bnxt: fix bounds in MAC address pool index

Joseph Wong (1):
  net/bnxt: fix stack exhaustion in flow stats

Keegan Freyhof (1):
  net/bnxt: harden sprintf bounds for device memory names

Kishore Padmanabha (1):
  net/bnxt: fix TPA agg Rx descriptor and VNIC query bounds

Mohammad Shuab Siddique (1):
  net/bnxt: validate TPA aggregation ID from completions

 drivers/net/bnxt/bnxt.h        |  1 +
 drivers/net/bnxt/bnxt_ethdev.c | 28 +++++++++-------
 drivers/net/bnxt/bnxt_flow.c   |  1 +
 drivers/net/bnxt/bnxt_hwrm.c   | 13 ++++----
 drivers/net/bnxt/bnxt_rxr.c    | 58 +++++++++++++++++++++++++++-------
 drivers/net/bnxt/bnxt_stats.c  | 23 +++++---------
 6 files changed, 80 insertions(+), 44 deletions(-)

--
2.47.3

