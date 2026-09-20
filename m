Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3E9C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C2840E2A;
	Sun, 20 Sep 2026 20:14:08 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B52AA40DD7
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:01 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1785669a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928041;
 x=1790532841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prr1ZiyuPdQjHHBTznmI1B3UiWnT7ZH7Ejyond6nCHI=;
 b=ZB9PtWRHfXCWDNNsXB3fY5u6Dz2PYtrrmHYjK7w477uHNi8AqK4GTfIcR14korJWXc
 8kV38vQX0aL3RhYIpWW7mpegMwa/HQ61g5GJoj/qsj8qnntJeAxP14Bjjw+5HHtAxnQG
 e8Rwmir8Q4Oi4oXEQHF2pluJu6fpd0k3GQCleXZRlc15PC2EQWvVxtk1aXKNgARjW7sS
 gwVBnQjbTrwTv5afGG54DaLvsSg6RaaR287+v+sDP8SS1+ifgsue7L1qc0AmKUIiYHo7
 /fMM6fL6AUwKD0gLpkJYwAev862H166OMaxCoXNJy5pRInbKi44KyMpLGbxbgHHAwkoB
 FWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928041; x=1790532841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=prr1ZiyuPdQjHHBTznmI1B3UiWnT7ZH7Ejyond6nCHI=;
 b=LAffKpfyewJ9QiGyFDC+NeSD3A5WdLAF+NJ5NcJV/7b/pBnKI3vJ4fowBk6o8Hcs5+
 A+KHtsOs5xAhio+aQlGuUyRNTmo1qcK2pc63pW1rhHS8r0zyNF6DcsbaEoZuDRYeBudb
 HjNuIdFvII8VIB9bOeB9Dcvv56/iDGAVt2cv4dyRoPWP+3xz2jE4zj8UHwBg05Atjcsp
 fi8JrGQXSydBbAj+nBcU67slG2Xq5ueJG4kLVFmclCN7J3j84/W9mxCefYzS3rUjhVL4
 NVxs1m5JTJh69mnRAwGwxDqKxQECpOSg1wdMzAS4BK6O3dA8NgbZ590OmVgjyvJHBBcK
 Mt2g==
X-Gm-Message-State: AFuF++kw7htk8/R3qdVQvq1ja2cN8+1VxPd0WmHMeCgKQNzZLWs4BSSx
 LfxHamMcjJGblY4CCnrXYizLcpTggrm80JyKtdtu/PSOnppHZfrhPmNh/FBGHQW8YRWAV7yNn8w
 zKn15
X-Gm-Gg: AYBFou057rcJKbYXifOHQ71vUNor3qQtwXWxlBS5laFGU5fsd46cH52zUmt8AiugfXu
 LiJ2KA5NfUJ/ru85xnO7FN7bHfH/kaOqLg2geUZue8aHJxEkdZNWXssxnTuZRfs1Jh78le3xJ5o
 Bj/a8CRhN14EkeF+733NorXCEUELofEFdzgzjwwAAFW1r8Zg1LF2hUCWRFTTKJ7NJsw+FSn/J9S
 aF6oVfUmisqcrMerqzqF0rHVyK+FBRotjBvOb69g8FdFdwf9uF0N6RFjXNTsnD5yDfqWcnolHbl
 jO9I6GmexoBvuny1UtsOKirIsMKxmjAV5gmQx66qf3gPuxDLr3dK7mmYdiYzyRuOlhYgGoASo2x
 Rmsm5wlaQXOTubGoAwvDDJJeVvQLkclfcU7e5J8ccU1E0vjY1hwru9xJtG2t6nz23GPihUWF5ol
 VztCSpDfO4SfwjquULkdGUEvaTqyf/atWE/nlJF4Irf+Wnl1Ch520YUByuXIQNWNYMiy/MhGMXK
 ht+nkj07N8UKv8ddz1vlgLTnUNva3/DN9zLJA==
X-Received: by 2002:a17:90a:ec88:b0:39e:6c68:1554 with SMTP id
 98e67ed59e1d1-39e6c6832aemr9022731a91.28.1789928040868; 
 Sun, 20 Sep 2026 11:14:00 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 08/33] net/intel: replace rte_smp_rmb
Date: Sun, 20 Sep 2026 11:10:00 -0700
Message-ID: <20260920181347.747210-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c     | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..6f168e358f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1955,7 +1955,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = ICE_LOOK_AHEAD - 1; j >= 0; j--)
 			s[j] = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..ce0a3dde34 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1549,7 +1549,7 @@ ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = 0; j < LOOK_AHEAD; j++)
 			s[j] = rte_le_to_cpu_32(rxdp[j].wb.upper.status_error);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (nb_dd = 0; nb_dd < LOOK_AHEAD &&
-- 
2.53.0

