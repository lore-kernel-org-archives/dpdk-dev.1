Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBAC88E75
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A2B040262;
	Fri, 18 Sep 2026 05:24:24 +0200 (CEST)
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by mails.dpdk.org (Postfix) with ESMTP id D82E840262
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:22 +0200 (CEST)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-5c98e3f0d74so135057e0c.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701862; x=1790306662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3AT/HddiFnQLyWCn0/GO/uZEsj/2YMO5yMf+sNBTrMw=;
 b=JZ/FHu4Dp5eXwUydw4/uw9B9bcrMHUZ4fWyf1D+lOW3G1t/zK3GPlGFzrHRWrZFU0R
 ypJ/YZUiwFILAFLI/jiIohWMtusDv50RkfH22UFDtZmSU4u8nLe7YSicgTwFhirM7tgV
 yW6HrvPrB/4zjuUSxBHFTedwTXeiBlfWGG0pfYqnpNuiaCpHLvDpbadCRVV6wzrlICQ/
 kWk1Dy2Yscs0B/7OMRFOV+Moy2Va3dj1LFOM2AtLyH8YBbpniWED59rKD5KEDqGCF52i
 tA4Ey6f3/041uX5SjNvxqmPsXUg/O25RJJ0YrOpUXBiaGJup7ByC4DPLEWKjTh8L7WkT
 OZ2g==
X-Gm-Message-State: AFuF++lndeseXw+1sRLnSB0YoCw7pHA5JT38PCKDInXD+p1THLQXXDuz
 ZxPZeiM8IHILgA2aB5vgRbrrcdHfElMiMG6UFz1UYLP4vuHfSg7Ppk4qFjrImWZSYqV/wauPBXr
 q1FpDTquF0T50k6GSIThwt9jcq9SVosvX9y96gxNYVmP3fKSXRF+Ug131nchEO8sOubnqFbE5tm
 KOEoVEZWRlJGy8uGB0+d9znAhYzjs+umb6dUaNzSN7VRfBZUtKeNMbN/a8hsO9LnWAsoGHWtWLz
 0tg16iyb3F7
X-Gm-Gg: AYBFou3chX7WukI/Ryo6MUBpUAHG4GuO0hvSzNLfeuC3MOHJDKV8uCJMker6MyvgOaO
 fDJ1szKy//L+UTVr/yTS3SfdbUUVdnA16hOhndQGRIgQcYK9Rj9glUJTO3QqHv+OBCXrLm1NBRv
 CG0X1iHRZcIRYdZDjDBYjC/B7xyoLD0lvQJqYcLQvRxTJvqMBvVYGVjvAcIZkOp219TricUcUap
 pSptJT+vbYXIfqG1S29tCKrEwjqYCqnW+ZPfh0731ss49EyJ6KBM/AdxFO1GS3UdWvp7kPXzsOe
 1Zp9EaIUzmLNOz00bnO2LR6ftx5vM3RDnZl83XZ1VEAamgekXCq18BBHSB3cQvR+JVgWGevSfkg
 cWnd8nR3nJ3bWHD8EL7yCoopD5zLWXLvNv3kLxJTq198T5CQseeQtYY8SOafNkXIr0xMU/4Jt5J
 lirqIOpqpAjnVPYHJVCbrRgNLTh6bRJ8QlMP4hW9rq4A6CTZwkRV1f
X-Received: by 2002:a05:6122:787:b0:5c6:599d:8730 with SMTP id
 71dfb90a1353d-5c9b58cad6bmr416447e0c.3.1789701862129; 
 Thu, 17 Sep 2026 20:24:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c9b834e6basm199463e0c.7.2026.09.17.20.24.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b8088202so257693a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701861; x=1790306661; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3AT/HddiFnQLyWCn0/GO/uZEsj/2YMO5yMf+sNBTrMw=;
 b=IPpoc9jo5s30yI5a96HDx8pXKi2i2LPGK4GrYJ6s8AY+Njpz0VSzXSp/ZtvoL1wD3O
 Jpff1Bny9kOgdj7kV7mcFwRDLBh97h4G5qQVWe8ijHhb4TNh9hNW2CtB6LZ1lTeeyiP9
 z6+BDhEwrmPhN8NIG9h0uNbWjjvjYASSVrAqs=
X-Received: by 2002:a05:6a20:9f05:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3dd8c331ce1mr2282803637.17.1789701860947; 
 Thu, 17 Sep 2026 20:24:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f05:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3dd8c331ce1mr2282756637.17.1789701860389; 
 Thu, 17 Sep 2026 20:24:20 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:20 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/5] net/bnxt: fix VF and firmware-facing bounds/leak issues
Date: Thu, 17 Sep 2026 21:27:21 -0600
Message-ID: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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

This series fixes five independent out-of-bounds and memory-leak
issues in VF- and firmware-facing control-path code in the bnxt PMD:

 - an unvalidated, firmware-controlled VF ID used to index
   bp->pf->vf_info[] before range-checking it,
 - firmware-reported ring-group/L2-context counts that were not
   clamped before being cast down or summed,
 - a use-after-free in the VNIC filter list walk during cleanup
   (STAILQ_FOREACH() dereferencing a node this loop had already
   freed),
 - a memory leak on the VF VNIC query error path, and
 - a memory leak on the VF info allocation error path.

Each patch is independently bisectable and was validated with a
scoped net/bnxt build (and, for split points, an intermediate-commit
build) in addition to the full compliance gate.

Joseph Wong (3):
  net/bnxt: add VF ID boundary check before usage
  net/bnxt: fix bounds on firmware-reported resource counts
  net/bnxt: fix VF info alloc error path memory leak

Kishore Padmanabha (1):
  net/bnxt: fix memory leak in VF VNIC query error path

Mohammad Shuab Siddique (1):
  net/bnxt: fix use-after-free in VNIC filter cleanup

 drivers/net/bnxt/bnxt.h      |  3 +++
 drivers/net/bnxt/bnxt_cpr.c  | 25 ++++++++++++++-----------
 drivers/net/bnxt/bnxt_hwrm.c | 31 +++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.47.3

