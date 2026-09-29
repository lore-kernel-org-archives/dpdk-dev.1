Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CECA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75A0240E4B;
	Tue, 29 Sep 2026 02:21:27 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id AE02A40276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:25 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-8ab3d3c5761so1217487b3.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641285; x=1791246085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ivhqcPFon5evjfXv9EkW8c2oY0OOUagQkUhlZfZo54=;
 b=WiO+qBGKSheXf0ZZENgJdzHWRVHfrp4skEd1NS1zOnHJwSWe/JqcMGe+Sf4erhIpB6
 2GADcZeYMdS9qxDwMpx0tYmYBtMqRIcBBXtkyzXgzHQROJ8bcZkyTKwFpOqDpLfwtTmv
 3AVDvhBZvXYiuwD/2bd0A+vWDFDyYs4wPG87F5zJKtb0eqpadDaXyXyAvaTNAfXz2SKh
 VtqBQe1zVY3zfx/SpX2AYk+/0nOp6eocdIEqhPaCccUN66mhqP7WYkxG/lExxmkkc+4t
 mgh+/ZHP0sbVwNcckzQ7LWQx810WaHD6n5UvQ1gD7Ra9EDDAqbYZLOOiuImE6jNQfqH2
 eKDg==
X-Gm-Message-State: AFq9FYKCQn9xkuNiRFyjEcXNa96Wx/v3wBa/9c2XP8YjsPf87gps230A
 OjaR96rW2CwZo/SfaGbkYI4UDD7i4vSLW2FduuYVeZ1+d/bfwyi0sQIVsf3AKzfAB+93MLFBQb8
 mG8AjFLBnAOcXFsZp+1EdYMAJPYHxVvLEGiS/UDgSBSUJgg7F6jpAA1Gn+hyXAjLoRJqJdaH0ye
 XkpaoH/nN7fY8isGJX3TuXfKbzqKkL/4Suckl0tmtpCDhJBoQ/2nFiGCNnB/9jUZQB1ExsKMGpJ
 nBIAvSEVk2o
X-Gm-Gg: AYBFou2LgKjI+L0Um5QV+R4RPmlcRVsYLqmvuaQx11w48NC2V6+4ZXwwwPSWUdZcnAc
 I6gpPMadsskHxgikGUIeSSUgZLEnRxebEcDi08kqkHikFodzQJmubqodbBahH85POKgcOxkACva
 uSF1oR9raFS/6OzRTiCKiyOdjxrd9gPq72VgyfIRe28W3tjR5FiyCVQEmkx8/KvUSinU85JsUan
 SeQH3Valh0Vh5gs9+GYAFofuW5aBcSQPnpmA1ac+GoeL2drs8MwI+tuuL6xb+WFes7CTRfoTLzo
 qraiZ1NQ7+PGMT5d2QxKI2kPDmwfBLxqNxifjfUWwIZu+MOv1VZe78lEP+q8QxXVjQIZsEfYaAT
 ER6EN7/S7hkn7/Nl+063PmuOHzqSrnk3NIH0lLWe1wA3NtIe5xh+INeBvhD14cXImhYs7TZUIAM
 hk5GlTiaTxQvHIFhDY0Mcds4fK62EI2D3YF9r8SuMFtPj8/6WU9vJz
X-Received: by 2002:a05:690e:128a:b0:675:3d9d:875c with SMTP id
 956f58d0204a3-6753d9d94fbmr3553906d50.62.1790641284968; 
 Mon, 28 Sep 2026 17:21:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6756534a9b1sm56509d50.15.2026.09.28.17.21.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c77c0d96eso209525985a.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641284; x=1791246084; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ivhqcPFon5evjfXv9EkW8c2oY0OOUagQkUhlZfZo54=;
 b=fPBvDErDO3QnaZWtBYUGO0owjQEJ7oommM218sNj7jseggBhcjYx1vf6M3luTnr1ve
 xdYR8WiUhwxayKfVfm10WT2En4mJOryB3hLjhtgIOMLawF9JQ623SCMZE9QG6GAwHQNE
 VndxCa/4SsBD4yP1manayfiaaiQB0YXLqEadI=
X-Received: by 2002:a05:620a:1d0a:b0:93c:6f06:8f2 with SMTP id
 af79cd13be357-93c6f0609ecmr1151622085a.48.1790641283798; 
 Mon, 28 Sep 2026 17:21:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0a:b0:93c:6f06:8f2 with SMTP id
 af79cd13be357-93c6f0609ecmr1151619285a.48.1790641283279; 
 Mon, 28 Sep 2026 17:21:23 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:22 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 0/5] net/bnxt: fix VF and firmware-facing bounds/leak issues
Date: Mon, 28 Sep 2026 18:24:19 -0600
Message-ID: <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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
 - a VNIC filter list walk during cleanup that stopped after the
   first entry (STAILQ_FOREACH()'s advance step reading a next
   pointer this same loop had already zeroed via memset()),
 - a memory leak on the VF VNIC query error path, and
 - a memory leak on the VF info allocation error path.

Each patch is independently bisectable and was validated with a
scoped net/bnxt build (and, for split points, an intermediate-commit
build) in addition to the full compliance gate.

v3:
* Patch 2/5 ("fix bounds on firmware-reported resource counts"):
  removed the defense-in-depth clamp v2 added to
  bnxt_hwrm_func_resc_qcaps() and fixed the actual bug Stephen
  Hemminger found instead -- that function read a uint16_t firmware
  field with rte_le_to_cpu_32(). See that patch's own changelog.
* Patch 3/5: retitled from "fix use-after-free in VNIC filter
  cleanup" to "fix VNIC filter list walk stopping early" and
  rewrote its description -- Stephen Hemminger pointed out
  bnxt_free_filter() frees nothing, so the original description was
  wrong; the real bug is the early-termination leak. Tried Stephen's
  suggested STAILQ_FOREACH_SAFE(), but it isn't portable to this
  build (no STAILQ _SAFE variant in glibc's sys/queue.h or in DPDK's
  own RTE_TAILQ_FOREACH_SAFE() wrapper); kept v2's
  STAILQ_FIRST()/STAILQ_REMOVE_HEAD() loop, which is equivalent for
  this always-drain-the-head pattern. No code change.
* Patches 1/5, 4/5 and 5/5 are unchanged from v2.
v2:
* Patch 2/5 and patch 5/5 had their Fixes: tag SHA1s corrected to the
  full 12-character form per checkpatch's BAD_FIXES_TAG warning. No
  functional/code changes anywhere in this series -- patches 1/5,
  3/5 and 4/5 were unchanged from v1.

Joseph Wong (3):
  net/bnxt: add VF ID boundary check before usage
  net/bnxt: fix bounds on firmware-reported resource counts
  net/bnxt: fix VF info alloc error path memory leak

Kishore Padmanabha (1):
  net/bnxt: fix memory leak in VF VNIC query error path

Mohammad Shuab Siddique (1):
  net/bnxt: fix VNIC filter list walk stopping early

 drivers/net/bnxt/bnxt.h      |  3 +++
 drivers/net/bnxt/bnxt_cpr.c  | 27 ++++++++++++++-------------
 drivers/net/bnxt/bnxt_hwrm.c | 31 ++++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 24 deletions(-)

--
2.47.3

