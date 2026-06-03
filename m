Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD66CD6E69
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDA4A40648;
	Wed,  3 Jun 2026 19:49:56 +0200 (CEST)
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com
 [209.85.222.99]) by mails.dpdk.org (Postfix) with ESMTP id D121A40648
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:49:54 +0200 (CEST)
Received: by mail-ua1-f99.google.com with SMTP id
 a1e0cc1a2514c-9640111c168so796725241.2
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508994; x=1781113794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZHo3AjRaFK03njsCeb8qyYU2AGZcW4w06fbDCaNnR8=;
 b=NeYhQLMeUJqxOfxQv/tDKjRvsYDMQ4KA/zjhU8tRH0cVl3yyG9d4BQB4OJVWvoam6N
 bc9ElUCysZDhiCjso/Mvz4kSyMc6ytd4kvnfLHg5NiNgOeeHLfkdCTKme0X6nTrfesvZ
 tgRmGTXkFl6/FOaydYm5P3fePh6sBAXilk7vTXvs1zCbjZuGe7TWF7hO1zebteBo7dwr
 S2BCM61WouGNwqJhUwhFu+NzD1nOSjssl81AtRZihaJw5J9h/Dmb4cIudmaBz94MkkOP
 iFH0mOQVTQEQbyKWgdyOhNACKBSMUUotB9a/x0msuYmvLLjagrq4QB4wx6Q4EK9X5fjk
 CgSw==
X-Gm-Message-State: AOJu0YxbfmSZt/+VafSeUm1fgqcVl+Fr2QzRRY1X6oQyM0wwptluh0Yn
 9q2Kk3mqOAUgXYxmeVmxGWV7luMFugkujEsvs5a5ysdYiiHO6sZpfaqmsyHcx0fncKGbN/HacTb
 faHdEHOcj7HbPzkuZ7InuhAVn5JZO800wFAb457MFWmMDX4f9t8Rh/Z6U80dt9kGZlkRFRd2PXp
 T7f3c9dUOZG/6AhOVxJnjqSKe1Mgk3ZZVgrdz+2m2n3GFBYCkbQQb0XW+JzAhdtzC0hNWfAz/O1
 bLciMxJgeW6
X-Gm-Gg: Acq92OHWx9V33f4xk1wHgJNp4ObP1KqirVVMkgtT47bY0mhZqiSn02Qhb+MeHfTBgUs
 l0Q7dYBFrNyz2kARyhCmkQ6XvF2cRBBYwEUGO8tnXcqpEtyKNELdm3KuYfuiIO6fB/lAMK5s0ZO
 7stVdK7azXtsd6UkyNWT1FOz8cXhWtdEq2yL98tHeaXE3Grv4rqBVJqY3BkuXS1qSSjde+WYm1U
 f5ySZ4iH5GZDEpJh2yotyQektmuTGlIYQUz5jf4a66IJ94RmsFplX+leWPnudEqL+3IGiem+7iq
 A9+TCp0E9gD0dIMGL0LNxXQ4VCi7GZM3AdBItKyPQcZ2yIjhjFUFhsi0yZIvI53F5hwwqb90eE6
 HzfJIesiF7XIgowy+2lo5vr/oi19KeBCdDSDVExklNfYhHsEil6YFi9YzYrXDeKflwb6uJxo0wE
 Y9RJxChchjFgTT49WkDPmKDn7Y1sQXRshFYIi/MNj54LRzVjR/FHssZHwt+k2VFQOrv5sY0q0xx
 MeaiFJIt9vD
X-Received: by 2002:a05:6102:5091:b0:6d6:c2ca:1c20 with SMTP id
 ada2fe7eead31-6ec4504f3a1mr2431490137.14.1780508993919; 
 Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6eb662a86e9sm223134137.23.2026.06.03.10.49.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5176d5d7222so42901971cf.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780508993; x=1781113793; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zZHo3AjRaFK03njsCeb8qyYU2AGZcW4w06fbDCaNnR8=;
 b=fVL275GVOKo1d+tyzqzoC3Fs+SWOEFAwtXZp+9JrpFD9JH3DDDFnY4VabiUNglxcQy
 dkeZ9+uTZCKQ8+o2pepqh2sWg91nrnkw+8qO2bQGzqhJWQE8Fo+NVIgtb4Kfbhd/wk9V
 kEumrpzBM8hf8jNBnCcuzAeKYppbWw5okNfog=
X-Received: by 2002:a05:622a:2ca:b0:517:76f8:77b1 with SMTP id
 d75a77b69052e-51778782d34mr66276281cf.53.1780508993177; 
 Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
X-Received: by 2002:a05:622a:2ca:b0:517:76f8:77b1 with SMTP id
 d75a77b69052e-51778782d34mr66271231cf.53.1780508987772; 
 Wed, 03 Jun 2026 10:49:47 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm29021021cf.2.2026.06.03.10.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:49:47 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/4] net/bnxt: miscellaneous bug fixes
Date: Wed,  3 Jun 2026 11:51:33 -0600
Message-ID: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

This series collects four independent bug fixes for the bnxt PMD:

 - Eliminate unnecessary long TX BDs when only checksum offload is needed
 - Pass QP1 resource count correctly when configuring backing store
 - Fix implicit integer sign-extension in the doorbell calculation
 - Prevent VFs from attempting global RSS configuration

All patches carry Fixes: tags and Cc: stable@dpdk.org.

Ajit Khaparde (2):
  net/bnxt: modify check for short Tx BDs
  net/bnxt: fix QP resource count in backing store config

Mohammad Shuab Siddique (1):
  net/bnxt: fix RSS hash mode configuration for VFs

Zoe Cheimets (1):
  net/bnxt: remove implicit integer sign-extension

 drivers/net/bnxt/bnxt_ethdev.c |  4 ++--
 drivers/net/bnxt/bnxt_hwrm.c   | 18 ++++++++++++++++--
 drivers/net/bnxt/bnxt_ring.c   |  7 ++++---
 drivers/net/bnxt/bnxt_txr.c    |  3 +--
 4 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.47.3

