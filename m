Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB2CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBDC340274;
	Tue, 13 Oct 2026 16:49:47 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 91E27402A4
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:43:55 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30b6dad2382so6471508eec.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791888234; x=1792493034; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SssEwrLotsUYMxD6QFJYybe1eIZRVWxhsiE202wYZ+Y=;
 b=Fe1xVZULDT6WtRSP6vrbuVr6sWIBPd8PB3zIx7cAmvgz2cu4IhhnnVX+Owo+B3qUzm
 5CMACagqt3Ih3VNDNDYrUNipuIXInSqE7+0Oa5nEGF2h8m9wdEvPVbRHU8Ws7eJs30K8
 SJiafP3CjCDKXyon+Xo2m5HZaulpHZutSau3XoQAlSpKGz61ZeYK8r7Wq/MTeA134Sf2
 QD4AELWp8tWALC/NFA7QyFLcGEwevY9VS3kq3mzfmhjRSIiKv0LlCYH1bBLfUkLDLdQt
 nXdrBH4t6bVUn9QzhfgNLBmisaReTlKgtvXVfVRHQRRXM9ZcyE3dWmcd/eJfZGplIPA7
 ADCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888234; x=1792493034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SssEwrLotsUYMxD6QFJYybe1eIZRVWxhsiE202wYZ+Y=;
 b=Ad0qwnpGvTqhd/RzmS2d78yUcixD3UFgLKTvrTAvBHpLu7W9LvtCA2uRXDxc0nZcJF
 5sdgNGQSYWi3WDofsNgh+NIx0VD0KKo3YagELwayv6n91s15dBlqh+VZiczu4kcgKXrv
 PfrN4qQHDBXXVxO2aY/ZXn3OyuT5eQXzrTJjUgJHxaSnfHV5zzEYeziCV4kK0ABaEqkj
 Kal0WBRj1B92SD30clKeeGgr7tvonqRfBNgmOXnRp7yhBjjwzw3DpEmgRNCBv+sEtO0J
 D6IkH9a+TapDfpHycVcYKCekeCxCC1seTFb8RPNaA4UmrpLgvdmFUp7/DraJUyXJttTH
 4XEQ==
X-Gm-Message-State: AFq9FYKd2q8d0b8slUumO98B3Fgob8LF7+nKgLi1Ww8Vqq3C/ke2fmqo
 WF77mvlIQ7cjhuY95Zlru7zUoeebuk+9Is5eFtpgPkXwPKeVjOPvbJ6qW1uLGg==
X-Gm-Gg: AYBFou0tBRR2JDzy0GyAEd9AYxBScOM6Hsk76MRlpc+XZlUeaPsMs5eCb7sxRa48dDp
 beWsjJfbgsHk8SIb9C63/XRzgeoMLkvMBhDvI6mUZtSmWsxNHoucq9CmKnk9Yxr5YCOrb1JGGUr
 SUGoqdA0YmAOOngXIgUvJuSIO+tkjJmkgMO9W3mPbkn51CvDoX2mWu6d6mT/pyxpHIOvNnnEhBO
 DuIIJmAJoEQjpYMUmWwYdNAmTqXZ2foAuoQH6fzIO1dSrEs/fK2j2RtbWF3QnZS4KfXhdASc8Qg
 jz9RgXtmCyx8lwIm6HjEG0Xjd7DkUZ5HV1t/j5wzg050KVjJk4/G1hN8A+/lwr4LKiH4xT/Pkx3
 28p0eYgsGtgF92BJjWXepb7C+Y6jdwZ3v4uIq+cG/VHq4f00fHHX8LjNRFSuGho1G94yeZ+uY/G
 fVMbkrXRInrfh+Tg/kX6kRVd0hDEcU9yqALuCSxklJ5nsSN9AfhMMp26dkl4F+SYaamquoybmVe
 w==
X-Received: by 2002:a05:693c:6099:b0:35c:1f93:7f2f with SMTP id
 5a478bee46e88-35c1f937f93mr3571727eec.41.1791888234137; 
 Tue, 13 Oct 2026 03:43:54 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm16695675eec.24.2026.10.13.03.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:43:53 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org
Subject: [PATCH v2 0/4] net/gve: fix Tx queue stalls and sync DQO RDA with
 Linux driver
Date: Tue, 13 Oct 2026 10:43:44 +0000
Message-ID: <20261013104348.714550-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:49:46 +0200
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

This patch series aligns the Google Virtual NIC (gve) DQO RDA transmit path
with the upstream Linux kernel driver (drivers/net/ethernet/google/gve/) to
resolve transmit queue stalls and hardware validation issues:

1. net/gve: fix DQO descriptor cleaning loop bound
   Fixes the off-by-one error in gve_tx_clean_descs_dqo()
   ("while (--nb_descs)" -> "while (nb_descs--)") and avoids stalling
   the completion queue on unrecognized descriptor types.

2. net/gve: fix DQO Tx queue stall on multi-seg and TSO
   Tracks descriptor intervals with last_re_idx per packet against
   GVE_TX_MIN_RE_INTERVAL (32) instead of counting packets at burst end,
   preventing descriptor ring starvation and queue deadlocks under
   multi-segment and TSO traffic.

3. net/gve: add cacheline overlap margin to DQO Tx ring
   Enforces GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) margin
   in ring space checks, avoiding CPU and device DMA cacheline collisions.

4. net/gve: add packet and TSO hardware constraints for DQO
   Augments gve_tx_validate_descs() (which enforces the 10-descriptor
   limit per packet or MTU segment) with the remaining hardware length
   constraints: [17, 9728] bytes for non-TSO packets, maximum MSS limit
   (9728 bytes), TSO total length limit (262143 bytes), and validates
   header contiguity and payload presence on TSO packets. Invalid packets
   are dropped instead of stalling the queue.

v2:
- Patch 1/4, 3/4: No changes.
- Patch 2/4:
  * Write the Tx tail when report_event is set so the device can start
    fetching descriptors before the end of the burst
    (per Joshua Washington).
  * Pop the completion tag before writing the TSO context descriptor.
  * Use reverse Christmas tree declaration ordering
    (per Joshua Washington).
- Patch 4/4:
  * Drop (free) invalid mbufs and continue the burst instead of
    returning short, which caused head-of-line blocking
    (per Stephen Hemminger).
  * Validate packets before the ring space check.
  * Exclude dropped packets from stats.packets.
  * Rename too_many_descs to dropped_pkts since it now counts all
    dropped packets (per Stephen Hemminger).
  * Use a single GVE_TX_MAX_PKT_SIZE_DQO for the max packet size and
    max MSS (per Joshua Washington).
  * Declare seg_remain and mbuf_remain in the smallest scope
    (per Joshua Washington).
  * Reject packets whose descriptor count can never fit in the Tx ring.
  * Enforce the TSO total length limit (262143 bytes).
  * Add Fixes tag for the original DQO Tx path (per Stephen Hemminger).

Tathagat Priyadarshi (4):
  net/gve: fix DQO descriptor cleaning loop bound
  net/gve: fix DQO Tx queue stall on multi-seg and TSO
  net/gve: add cacheline overlap margin to DQO Tx ring
  net/gve: add packet and TSO hardware constraints for DQO

 drivers/net/gve/base/gve_desc_dqo.h |   3 +
 drivers/net/gve/gve_ethdev.h        |   4 +-
 drivers/net/gve/gve_tx_dqo.c        | 152 ++++++++++++++++++++--------
 3 files changed, 115 insertions(+), 44 deletions(-)

-- 
2.43.0
