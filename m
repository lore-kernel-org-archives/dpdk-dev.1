Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF71C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9371400D6;
	Thu, 17 Sep 2026 08:31:15 +0200 (CEST)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76]) by mails.dpdk.org (Postfix) with ESMTP id 4250E40264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:29:41 +0200 (CEST)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff16dd47so10639731fa.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789576180; x=1790180980; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nfRg/qgcWVidIvhv/bkVG0gkGvxYJeWpkK1uLZ3Qri4=;
 b=APHZSezAhHSeEK7/o20EaenKhqLHmC2JHo9QdS+MXnNmyv/VHpxSRPJX55ey5PJkfu
 N0lKO0YnwfHjrJ8AGVTSmBzZIq9Jsylye4T16KGjCJ3Jwd0FQrTmRaO412aRieWb8aJF
 pdtjCFwVhTao+6lmvZXlLGxtYmxPS4C0QNb2bdkNtIRdfd9EnKjmv8L+mN1Fc3aGFNrg
 aBKbXvscj3fZnyAH3OGwIqSKRhLnt5CWryuOPxv2W+LMqUHMRNKY4dPUSuwYl1hyDQxN
 rACWF4/sB6PVD5KMqe0S+3A6MNdeBFjwH47hg3LV+tmENpfnL54Y8aEnADpBqR94soim
 6X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576180; x=1790180980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nfRg/qgcWVidIvhv/bkVG0gkGvxYJeWpkK1uLZ3Qri4=;
 b=YitcY2F/Q120rKJ1bnrk5FBFzJlUH+KFg+H7WFY+by+iOJI8SgT0h8hxj5akSlHCfI
 GeSUONGdohBgpW8rlZlZSR31/UHlquvJ3gK2Ghlz4kAq0ZQs3hEAja1omdpnTlPp1OYy
 4j3gzXKdP2X9XWPvSUD4mwcODHOz+gxJ5JFB1w7WEUAafQ1gUA+s6CEzxkYSnVwT7pqy
 xFZRr757V9kRMliA+oW6I8zpcKAeVlj4vKJalL3AMmCDhpPBs8+09GQtv0SZJosF1aha
 benPoLMt+6IsG/917sJw3cD3LPfIx1bnypsncIX6ItON6JIRC56ALBC+6jjI5fcHQYFQ
 Rrbg==
X-Gm-Message-State: AFuF++kG1JWhDgKaj+aGQFiyx2/f7c+I6Q882iS69EHbKdrzQb8zM1tu
 x57rArnWoj4tMKB8Bb6M91S6jPUpnidEd2zpDBYiZxKwoexVjruIws8yL3EaLKv9tlA=
X-Gm-Gg: AYBFou1bQKea6ptPznHqDcNp+euObdHoHoXSsmkOWLVIsae3xP0th2e+L5+ysEgClmV
 e4884bTsX79Cx3kBz67VMXqSraxnfDOVEZwtNTww4WbmyR9XNM6zmeOLbiQJumQnChGREFLTd+v
 xCmjNh/m6DJB+RVbrQQUru4LPElpA60iXoPDlZzFm9FV0r9kHri4H3ypiHDKuFL8pFboD7XuLhg
 mGA6gjH/M7EyGvQzNDQduTQPYr/yBxPA85uPVty+AEnAoXvUlQsh9Hw/xlfAxXV90s9Mvwn/Rvz
 CqPumKZlvDTqdrdIIvlGHgy3Xh7rHaxf7N1dMcuvHFlVCS41zq2f/d9EYiKZoeyFElRVitvBiTx
 jcwUWkM9R3PRHu6LP0UfNv8s+t9zb1G5mZJtfXDg2FKOKFsINTf0QKw4RoVnaZPkGj+anH6R/Wd
 rPfpqQTehxhxfSc/grVp1m+vS6PxFq4/fiRZVToA5YgsWFiKmGtGGFyU0q8sXXnhKgIg==
X-Received: by 2002:a05:651c:a16f:b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a5dc9f2721mr6272061fa.18.1789576180276; 
 Wed, 16 Sep 2026 09:29:40 -0700 (PDT)
Received: from fedora ([185.61.79.67]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5dafa9cedsm7560801fa.27.2026.09.16.09.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:29:39 -0700 (PDT)
From: Omar Munchaev <omarmunchaev@gmail.com>
To: dev@dpdk.org
Cc: Omar Munchaev <omarmunchaev@gmail.com>
Subject: [PATCH v2] net/intel: use rte_validate_tx_offload function correctly
 for i40e/iavf/ice drivers
Date: Wed, 16 Sep 2026 19:29:04 +0300
Message-ID: <20260916162927.2137856-1-omarmunchaev@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 08:31:13 +0200
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

rte_validate_tx_offload() returns 0 on success.
The i40e, iavf and ice drivers treat any non-zero
return as an error and drop the packet, causing valid packets to be
dropped when Tx offload checking is enabled via EAL, e.g.:

    -a 81:00.0,mbuf_check=offload

Only reject the packet when the return value is not 0.

Signed-off-by: Omar Munchaev <omarmunchaev@gmail.com>
---
v2:
- Fixed From/Signed-off-by email address mismatch
---
 drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
 drivers/net/intel/ice/ice_rxtx.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e29fcff661..ee70f7ce4f 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1194,7 +1194,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
 				break;
 			}
 
-			if (!rte_validate_tx_offload(mb)) {
+			if (rte_validate_tx_offload(mb) != 0) {
 				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
 				pkt_error = true;
 				break;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4f2ffe6188..10d33660d9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3813,7 +3813,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
 				break;
 			}
 
-			if (!rte_validate_tx_offload(mb)) {
+			if (rte_validate_tx_offload(mb) != 0) {
 				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
 				pkt_error = true;
 				break;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..3d98d821b2 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3669,7 +3669,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				break;
 			}
 
-			if (!rte_validate_tx_offload(mb)) {
+			if (rte_validate_tx_offload(mb) != 0) {
 				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
 				pkt_error = true;
 				break;
-- 
2.54.0

