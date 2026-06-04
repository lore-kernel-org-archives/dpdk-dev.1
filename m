Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E630CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 22:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 772A0402BD;
	Fri,  5 Jun 2026 00:54:37 +0200 (CEST)
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com
 [74.125.82.226]) by mails.dpdk.org (Postfix) with ESMTP id 2CDCA4028F
 for <dev@dpdk.org>; Fri,  5 Jun 2026 00:54:36 +0200 (CEST)
Received: by mail-dy1-f226.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso2159368eec.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780613675; x=1781218475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8K2cDGEjxk4KgCJUneIrXkKr27o7+E3/S0+ZvinYgM=;
 b=U08X9vKFNiZtRzUBijiM3NZjR4HM/+MNGSPAQ1QDtqCLtUsKtL403dcjgSJUdqpEfD
 WWHPThxmEmJM7EhBr8p+yODswLF2LMwhRMZbHd1im8GfAn90+ipXS5y2BnDd9LZMCXNo
 QG7DGr6oUi+QZSX4uoALF+uJ3gFbCczK03nmL0Pa90hhJvvKjHjYXGIDnLyzPJnwFdyG
 /S1ExcGp5//6ZXut15w0iVD/tQFDPlvNFaCachY8YdM52887nrABz5+EaM9o0VWxCUKB
 fY5Ar3U7/Pt/RtdImJdlBn1d6NTGKSMzNSEOnrcSnSnpHXY8uSUyRXTrcV5rJt9sITPR
 Bcig==
X-Gm-Message-State: AOJu0Yx2yYof/nt2Kxbwl6WjXHcAqMaWNH4F8jPhRQIiaNMA6afOgakN
 03UhDDvu/EpE7dKneYY+5e0yTazGD0/H1JPbHB9XccdIco0TOu1+wtyTw9IsysLsJY3Q9nCIg/W
 dhuAn/r06PGmvAax9RfdtkGM23qNCjKHgGCDC1wLs1jVryeVxUHfmm6JpQxvxo0wUooF0hvhLt6
 FBshW2pza3WQB1j9wrWXwXtR5aTcIDqZYE7sEmMXPPLMe3fmUDaJIXFzQ1WXWL8NjCH0Ikrrei4
 KL2W3F68zYK
X-Gm-Gg: Acq92OH147ZWsoV/96aMYX0CD3mC6xfxdmfH1W5qdiAbkwYVn01nqXLbVV0s2+I73xu
 bDvd5c540zu71LjPlEsFy0tBTR+zZpPPeLt0F5Cwm/iSjEnBi2FiFlLFaBriNadXzVNZRWV9eTt
 /Qj+5/I8G0+RtolOPezjvfUsH+hOZUohJTSwcheyKP9gCvX21+iz7I6kLgDsh5L+WNNea+x+nlj
 Klv63y1ZCpCWniPE7SCuRzcX6qN+0bdD3ETJjN3m+r2wftK2zUSMmWSeuqUL7N0wbLlGNCWw17B
 sm8tXl4JUCwHwdsKcC/SVNiepwJBrB7j4z/kEGp8CadRYpgWVrgbPmb4NdWdrBfn+mXTXwF5Cbl
 aU3+pu8R86Fsybmca8AtD9zYwYAMkYrK0NOyhZbiLd3GGW4d7oL/4CM41j7kykcoMEDImeKvAVS
 tAjgfc/bbjvI0olIUZEUBhOqF1T5d6eFV5RJIhSNpXQtRq4hYo2bPKgZ+k48XQfVwn3eNbIVVuR
 apjG8GYeQVN
X-Received: by 2002:a05:7301:5f09:b0:304:819f:502b with SMTP id
 5a478bee46e88-3077af4c61dmr410341eec.9.1780613674992; 
 Thu, 04 Jun 2026 15:54:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3074de3b5cesm398102eec.29.2026.06.04.15.54.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:54:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ce9df49c6bso19375416d6.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780613674; x=1781218474; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8K2cDGEjxk4KgCJUneIrXkKr27o7+E3/S0+ZvinYgM=;
 b=biMI2WiZS6Ya5yKsYKhQxcdumcdWT7Hza9NAnePZul6t8eD2GQB0umAxqZDyKq3TG7
 QizQc2SujIUrPQssZdDdawvfZFFJNDwEZ3Qa9LBFYZVcsdu5YFGRxXCVsdRam5lIfQn6
 iuACtpjmsM62+0SrwOCamhojBclttJVMApnt8=
X-Received: by 2002:a0c:fde7:0:b0:8ca:1d2d:4a3b with SMTP id
 6a1803df08f44-8cee5fe4e5dmr14848306d6.19.1780613673725; 
 Thu, 04 Jun 2026 15:54:33 -0700 (PDT)
X-Received: by 2002:a0c:fde7:0:b0:8ca:1d2d:4a3b with SMTP id
 6a1803df08f44-8cee5fe4e5dmr14847926d6.19.1780613673061; 
 Thu, 04 Jun 2026 15:54:33 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm67043146d6.24.2026.06.04.15.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 15:54:32 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/4] net/bnxt: miscellaneous bug fixes
Date: Thu,  4 Jun 2026 16:56:18 -0600
Message-ID: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Changes in v2:
 - Patch 4/4: add missing Fixes: tag for RSS hash mode fix

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

