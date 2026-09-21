Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC249C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03021402A4;
	Mon, 21 Sep 2026 04:17:03 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 93CD540291
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:01 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2db8ca58c46so8880945ad.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957020; x=1790561820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4c6wbT9kKPtd/4v5pskVHoRDbsrb9eTwpeLG7/LAHNM=;
 b=jAxqVldVAlnzEr5H89lZRcuaRHWuXGBm+huFb2KIhYJqYIYImcmt6+ulDGOvIh8j+S
 Xv186YeMQjpIjvX/LuNiHZs7rwoJYd4iDyc3u/DdC8zuvdDBqsUsz7fBb0trSipd3/IC
 FDr4e6e9EtGkQBmui0Qn8lB2EtgjcAZ6ipjiU50NW308X/UIxaM/v0oLHkcgXqMogGV4
 3hg9hzbcazWNcQX2vAI36LfS8ttmXOvdbywCUYLZFYo5dPNqYutheXUimdBFg6abG6tF
 /QUHplxN+Ay63H4Y6Ano4QrEqzYaEAWbvtAMKQ8Cpx6qMI+aFglx2sFhM1qN9GCQwtyg
 uHRA==
X-Gm-Message-State: AFuF++k4XvONx4NsxtsYSN2rZ2xg9UphT/oHr8MDgm8CccDudIlcXgta
 ZKgmqtjSPOi04ugVbOVv8ihJv/PQDlDSSvVWDInzPuJKrza/L9YTmq+osOl4Zr4XTPAF8LeVVOG
 ws0MKffv5FkwuN2ljN0Nr8jjbDP4SS+fVprD1oWAtTM83GeCY/ruH1e4Xpv2AmaIkoTnpUa7oyp
 9WuS1Cmrouvf/pQ90i0jPr7T7Nd+D/JTi0gOXjR5tdrfDOYbl+IYCPyk7hgTNl1RZvDjnZFT7//
 WdlcMjQ9KT8
X-Gm-Gg: AYBFou1UMMk5tZfKTjotFvG7jSHUuzC7oy9GIh8ylVsHXbhMjGb9QmXt1UEZSUqUI7w
 htz/mHwmlZqO0uviTG4z3IiXKYtyuxS1LojOiVUTe/IqcSVKeHe86z7BAea4/Huo4O+iThIvtNO
 x4CT5N5K5by/9HK1qagd8Qcy+9P0muvNyzyY502/YtBYxaF8hhNyryehZgFLd3+ROXc4OdjmsFj
 g3zb471BgocF0srRCClxRrgh/9nRB8SyXLh9nfTROuPR5THoyAWGTKLclK7h1qMwIwzW+c6924k
 zl6rauoaGXKn5chvglvGwnx/Yoz02jvfzbX9Pcmcada1LDjJFIzHOWY0g9a7SZokkDIWOxbphzJ
 p/6DlxybaoFADkPTMWogOGywebozP6G9kxhIg+kuXPMXOdx4ZTHiLnGWFu84i4Zq6JWyqR9GCv7
 G8/HU5r5QfF6OFqh34l30orkiing4VU8cKdifPVq+2QQ0xcJFRuA==
X-Received: by 2002:a17:903:19d0:b0:2dd:c053:e66b with SMTP id
 d9443c01a7336-2ddc053e697mr82290695ad.49.1789957020455; 
 Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2df47a213bdsm337645ad.11.2026.09.20.19.17.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396901263b6so4774804a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957019; x=1790561819; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4c6wbT9kKPtd/4v5pskVHoRDbsrb9eTwpeLG7/LAHNM=;
 b=U3ItSYpoJHRtTn0DLq5TqkBtSTiiV5zBN6EE6gGf1REY0/P4irRDh5uN9FbyHkbAi0
 3zUawODn1A4vgn+Tkh6QLGw4md7cwSx0tk0GMGiFXWNrpXByV+gST5Vre/eZBjMe+50K
 d419FjOta7pxKpGlEcLJL05O+a0ZMfygekudM=
X-Received: by 2002:a17:903:3d06:b0:2dd:ad73:5b73 with SMTP id
 d9443c01a7336-2ddb1d5bd18mr134518805ad.35.1789957018630; 
 Sun, 20 Sep 2026 19:16:58 -0700 (PDT)
X-Received: by 2002:a17:903:3d06:b0:2dd:ad73:5b73 with SMTP id
 d9443c01a7336-2ddb1d5bd18mr134518605ad.35.1789957018077; 
 Sun, 20 Sep 2026 19:16:58 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:16:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/5] net/bnxt: fix VF and firmware-facing bounds/leak issues
Date: Sun, 20 Sep 2026 20:19:57 -0600
Message-ID: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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
 - a use-after-free in the VNIC filter list walk during cleanup
   (STAILQ_FOREACH() dereferencing a node this loop had already
   freed),
 - a memory leak on the VF VNIC query error path, and
 - a memory leak on the VF info allocation error path.

Each patch is independently bisectable and was validated with a
scoped net/bnxt build (and, for split points, an intermediate-commit
build) in addition to the full compliance gate.

v2:
* Patch 2/5 and patch 5/5 had their Fixes: tag SHA1s corrected to the
  full 12-character form per checkpatch's BAD_FIXES_TAG warning. No
  functional/code changes anywhere in this series -- patches 1/5,
  3/5 and 4/5 are unchanged from v1.

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
