Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D8C982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9473C42F61;
	Wed, 16 Sep 2026 17:56:27 +0200 (CEST)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by mails.dpdk.org (Postfix) with ESMTP id 8028040264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 16:12:48 +0200 (CEST)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f16so949980e87.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789567968; x=1790172768; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XbJLsUCIkrrRj8QInN7Nnl+7JoevjrJmf0fKmswS+co=;
 b=f9AsBilwAWKt59wBpgrR/a8mHQOWQQMTbuoNBL7EaAQKkB3SPVLHYX6O3eY84yrqG5
 y96et+ig3lKJYouvCjAkVsmIMUf2qRngGovGN+XezfpXP+5rDSWvqpWOGJzXTysi6Uiz
 2dorZszU5O2p4jQGSbHY44qdl5PQOsdzp5tNk2/HG84Rc3cTfZBsBSs90E6z0ufc1nV4
 3QZEeHd3tDytqcRAFO64JNLUBgFfhQAFJogsQI/dn8k2IpksRYrZxDkvIoHMEXRkd8A+
 HrF/VVAhpGMxmSkPZmx0erQl3d5oUsHsVRcSVII/u9EEkJCZ3afmqH+1iF+Nzk+G7WXq
 we7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789567968; x=1790172768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbJLsUCIkrrRj8QInN7Nnl+7JoevjrJmf0fKmswS+co=;
 b=ttajh2yt8x1y2Cvdrw4TqxI3P8BUC8YUas6JsmgKv5HfpAXFnkz05IzsvUi+RMYNWZ
 du9YGmpSaJ1HRAXM8EeHLikJoP9GtBeFDxGd4F/gVvOCUq1DRQ62hqJdUHz7QZrzjrwY
 CIefBds9HBJlGYyBjpSf70b7KzLmXiJ3fxyJ4qauS9sdV3OhCAKsY0jNkgKd5360il2L
 SKKOF6c+xs+5UjKR4UUB7+3SaNB28tw7zZOAbcMUiD07+TeJvVKB+470sEXe4yZIwpSE
 fJKGkZJwwTQq0gxfPUsQlX/fO7S7k54x8Z82SFCGKH8lRJs8ha5BfpVdFeX0rhYYk0Jz
 BCCg==
X-Gm-Message-State: AFuF++lylY2D37wsvDkI6nM7HbCdJDiFTYZfVL6aRC1W0ImrNixlJLt1
 TUURJQzttCrF5cUxrPmWoS87KXQcIhWHumFmG/9LTrRFTf4hiJMqJr4u
X-Gm-Gg: AYBFou2guSA/90BG6proywcDMe1UjVEFoCAS1DFGivK8Fjo1P3OeDBDVbDJdK8gauCh
 rcrBEB6jGZK5E0+v2tAc2IgYXE3/4x/LQZVF2l/W8VnIo7pOvTgtxs4kQTyVQE9suSetK+z+Txc
 o3Iczbv9EseD+hC3J4hrXkGCpGBLFZuy6RqngZb91b4cwCmnq7E4m2zZWRjih7vNOKfaMqjLRoy
 GwKMDmIIrc8Qenw2glgTOcclGDXK9i3F68JTxoIE5HWuViTG6SvcRhRyqRpVuwILCNd4AHDPuCu
 jd6C6MstDtgy56+bqhEM6gKe0z/jiWoxEySdMNueRu8dQhuFzqheInewuWBS5U32uGpWTNeLyqq
 rhxuSweUCxlDxWldGw9xUiF2SbeCGdcXhvb5GIuUWXZhmUf3gPfogna4i9hAtroS5tZ8tIdTTqz
 Q6CPSn06Yf2XsR+xXUd6xKUTh/xkuF70hkbiFZ+B5M9TpAkEJzIVwIEpIz/qjrAOkHo6jSGXCXZ
 t5NtQ==
X-Received: by 2002:ac2:4e11:0:b0:5b4:a97e:a56e with SMTP id
 2adb3069b0e04-5b8b6631083mr1724864e87.15.1789567967279; 
 Wed, 16 Sep 2026 07:12:47 -0700 (PDT)
Received: from fedora ([185.61.79.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57cc54asm935036e87.33.2026.09.16.07.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:12:46 -0700 (PDT)
From: Omar Munchaev <omarmunchaev@gmail.com>
X-Google-Original-From: Omar Munchaev <omar.munchaev@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Omar Munchaev <omar.munchaev@gmail.com>
Subject: [PATCH] net/intel: use rte_validate_tx_offload function correctly for
 i40e/iavf/ice drivers
Date: Wed, 16 Sep 2026 17:12:35 +0300
Message-ID: <20260916141235.2074815-1-omar.munchaev@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 17:56:25 +0200
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

Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
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

