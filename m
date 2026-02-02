Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD0E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 036064027D;
	Mon,  2 Feb 2026 23:18:27 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id D77294026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:25 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so53120375e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070705;
 x=1770675505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piVoKS9jhv3kZ7RU9/doz+cVCRgEtPT7PqzQ3mJlOHU=;
 b=cMCrlSdlse9zaZxLXY+SC4wFMJac7Lzl/JSsDkQ11qJaPzSyrQQLnOhNAF1tfwvKzT
 bsnYHjBvouvhh0ltEwf2Wmy0kEqyoTiaUxqthXoR45aeSSmxHTlANvOug5F1V5yqrLBV
 PO5g7GweB9EAJ80XLBAcbPoUoIta7SUlHzu0e5lNup6YMutQlF4HTz0F6ful4D6udTm/
 etyMbGkJHkuM2HhLigOr6D/wIxSGV2ADEnY5rjySViN9rS4MWnngl5h+eoyVKRvhCnsh
 GkteYQOZUdYmUGuLKutSBK9gUTrsQdeLrDUI+E9zBVLREx/D+zSiNMFf2PofWb9X7YOH
 DP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070705; x=1770675505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=piVoKS9jhv3kZ7RU9/doz+cVCRgEtPT7PqzQ3mJlOHU=;
 b=QxAZCNOxdE7lcP93t1fK6Um0xYTpxu9HPE4gtLuvN+icB5vjzky5LOt+rp2h9b70mU
 Hk7Ahzxndjc7wpW/g3SgWnAHAY36RAdK8TMDCKslufrqrcweUQPt0VCZta8yRNtT+x6m
 h+xGhSJXOV+Y4Sy/zdsPqEMPUMvjhSIrMdPMRm7HRYKK8taYvS0daqmKAz2XzUuo20vt
 TzFJhtC2vcUr+EgTXVr2P1hpI9l0alnnoXvR5SQVXA7Lh+HCRgPSmTscr59PZE/DlSqH
 5+p6rWU7rmoPzvCoMGvvih2CsiyHBxMnCHtLCVWvvmLurIXDuHi8VrcRMBG1Bx7AwYt3
 I3Uw==
X-Gm-Message-State: AOJu0Yxt5U0DaHzAaaoIvvLOY2PFytDiZdK/x9f+/tBJo1RR7s2/Cy34
 Rr6c1eh4ZBNPjIi6eP23D1llUt1yRcJCWGICiFa8zAK5JNMGz3Wu3KEGotqiZFNpRRgvF9yNRGe
 uZKGL
X-Gm-Gg: AZuq6aKyiN9Z7an7PJAF6mtKSzXQV34o2RlfUNgmRqaYzLP1gRIOUWY4Oz7DYJbgKc5
 iDVkPKtneSNf1S817GiQ0WFtMfyg48C9YS/fehixxq0kSZPdfz3b7/Ugywe/uByjmfwD89f+2Dm
 5+sNgsmJYpoSCliuuoSchdMwyk4p0FBxNm7PTy7gFPw1Vpo84YjB9bK3PitBtyHlV7ZdrOILV9u
 XsBAdR3F74Ij/vGG6L+NX3dcxai90rxw92/rTznfHIV9kLC+GfihpH9CADnl/My/u1qnAyVE7X/
 scFl8/URObXsLQKe2xkL9szwhY9Hf+aHvrntFpumMbHw28TzYBt5N5sXlEW/aFw+6aJ4HcEqqSR
 vWAK+m7fxpmfCVEVMR3bcP7CzJ5ZQmxCZfHZm4pToCki2hRzbSZbvczKrelbMtAfvnnbxcJsxlN
 SKjiZCKk52pgerdteLhlpBa7s82p7q3cvswCzKvvdbBF5jTFUxlg==
X-Received: by 2002:a05:600c:4591:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-482db4607cbmr169704985e9.11.1770070704998; 
 Mon, 02 Feb 2026 14:18:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 0/7] net/null: bug fixes and improvements
Date: Mon,  2 Feb 2026 14:16:45 -0800
Message-ID: <20260202221820.204680-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series makes several improvements to the null PMD driver and
adds comprehensive unit tests.

The series:
1) Cleans up the info_get callback by removing redundant argument
   checks and using proper constants. Also sets min_rx_bufsize to
   the configured packet_size, enabling the ethdev layer to reject
   undersized mbuf pools.

2) Adds proper validation for numeric devargs (packet_size,
   packet_copy, no_rx) using a common helper function that rejects
   empty strings, trailing non-numeric characters, and out-of-range
   values.

3) Removes redundant argument validation in dev_ops callbacks that
   is already performed by the ethdev layer.

4) Adds VLAN insert and strip offload support. The driver advertises
   RX VLAN strip and TX VLAN insert capabilities. When VLAN strip is
   enabled, received mbufs are marked with the appropriate flags and
   a dummy vlan_tci. The vlan_offload_set dev_op is implemented for
   runtime toggling via rte_eth_dev_set_vlan_offload().

5) Extends the packet burst generator to support larger packets
   by widening parameter types from uint8_t to uint16_t.

6) Adds a comprehensive unit test for the null PMD covering RX/TX,
   statistics, custom packet sizes, copy mode, no-RX mode, link
   status, device info, RSS, RETA, VLAN strip, VLAN insert, and
   multi-threaded TX.

Patches 1, 2, and 3 are marked for stable backport as they fix issues
where invalid mbufs could be generated or invalid arguments silently
accepted.

v11:
  - Add VLAN insert and strip offload support to the driver
  - Rebase to main

v10:
  - Fix mbuf leak in eth_null_copy_tx

v9:
  - Consolidated argument validation into a single patch with
    common helper function get_unsigned_arg()
  - Merged pool vs packet size check into the cleanup patch
  - Removed redundant argument validation in a separate patch
  - Reordered patches to put fixes before tests

Stephen Hemminger (7):
  net/null: fix missing mbuf leakage in the copy transmit
  net/null: cleanup info response
  net/null: validate the numeric devargs
  net/null: remove redundant argument validation
  test: support larger packet sizes in burst generator
  test: add a test for null PMD
  net/null: add VLAN insert and strip offload support

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  34 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 947 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   | 156 ++---
 5 files changed, 1050 insertions(+), 92 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

