Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDECD6E69
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F05F94065D;
	Wed,  3 Jun 2026 19:49:57 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 035FA4064C
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:49:55 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-7e2f3646c10so52196007b3.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508994; x=1781113794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M6RdX2cE4d5tJiE4kquHflPoaFupXKbWypY8XZuXPLY=;
 b=M2YE/0b0nduUZb8xPsIJqLBIy/V7YSRg0hoyGwwo5kgL09u0P9oKaoYTVVU+Y5xvc2
 5YVCFQTHqdnUHwJ8FpcrWud3McgrEPmxpZUl1KhIJJAkzDjf7hB3nnJD6FXNVPLn+rgf
 xCGG68sgP3isHyyxDx/Ri9x0vqO6x0avhOobtcg9xccoLER+ziHa52fDAECswyVBAqof
 U6WedipmltTa/emgZF0UX90PQ4uNit4VjfSeL8nSWEC72ojHC9vIm7Gwa9C9QMF0EwvZ
 O7j9ZxQOc242k+AZcXPChVmk0D/jnpF9C/LkyqrIFr9EK+T4VfRxkXNhVkzyFrn54kNx
 4YMQ==
X-Gm-Message-State: AOJu0YwQBPVXDJKEiHW4zKjo8H1ohHoa3hY1g2Cb9s4C2pR4WopfhfB7
 iSbq/CrRqo4UJZHeyTd4JNs6lep7yOTjNO7FNbj0mFxCnokRPme8umo8AzqjHlDedkq+9OKCSI+
 le7+jIvFaDl/la/aE/NbcBAKDobDMV27eWhdAN7ycjXED+jei9SlvEtTVb04nThE/PIi6zZUlOj
 ZFQFjRDTXfaAzLEhWtr3PCC7ORTqZ0ydgyaZ+nG15olh+8i3LzWpYPA6uA2UVSgGGfrm7Z9MlzB
 yLDtiYmCKTG
X-Gm-Gg: Acq92OGIDVSO5t06J/jfs4e3pPC1ziSagFAJnLMNdfMWiMyjmwDcnrE5NJpbju3LhZA
 fui0m0iqEY4aJJZqnLv7bkHRBHOaHACgT5hjU2czGSdh2csxAE0cSUqlUrSnLjT5QBY4GMLPD2U
 gCXfyfuGrk0l0GGgR7CjvS9IqkmIhjMbFPouVjO/RkpKx5cTW3H8DcQsVV+7rutzZBhZwk/+lpW
 iYgLgeSNHFCsC/fUWfFtAZ8MK1KsxEwVUY8pzTAFA14KJEcmfTaevkFdoOcw3p4pqP/9QXJfWHI
 93Db3CQQPYy8DJxrHfUNQDlfhpI97amVI6U8w68xLrROo6UzHZPjy4/lgzVwWb+qxU4QPz1BEys
 jvhoN+adEVLp3DCuxFoQiffj0oWyHcGuFt4q3gNjYV0DQ1gCW+GYFEl9lfA8+E2pr9D58cZbKPB
 U/HbUxdqp0LX2Zy1b+aBanp6NU36GCrQTCkni06kwdKYb/besu0TfUkSgBOZwyUwi5BwQ5YkxjA
 +C48Fq04g==
X-Received: by 2002:a05:690c:3512:b0:7bf:ff7:ea6e with SMTP id
 00721157ae682-7ea4701863fmr45123097b3.4.1780508994196; 
 Wed, 03 Jun 2026 10:49:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea21968829sm2306827b3.12.2026.06.03.10.49.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:49:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5177f07eb05so19198061cf.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780508993; x=1781113793; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6RdX2cE4d5tJiE4kquHflPoaFupXKbWypY8XZuXPLY=;
 b=T5I9cxs+K42nV7RNCmttjW0XeDvTrGen+Vdiy2Hs51RbbTLf/ALdSS9JCGPUGpqDor
 JSt8YQZzLAWY1WcNFjtbkBY7i33nPQikEwhVpvd8VUMnPw9eLX8kAm6cXD+dkPOUd2ti
 652vUCpZ+3EwXC+YuoOV8drqjyLYmzWGtF+Qo=
X-Received: by 2002:a05:622a:188f:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-5177874af8dmr59307241cf.46.1780508993548; 
 Wed, 03 Jun 2026 10:49:53 -0700 (PDT)
X-Received: by 2002:a05:622a:188f:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-5177874af8dmr59306711cf.46.1780508992951; 
 Wed, 03 Jun 2026 10:49:52 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm29021021cf.2.2026.06.03.10.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:49:52 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/4] net/bnxt: modify check for short Tx BDs
Date: Wed,  3 Jun 2026 11:51:34 -0600
Message-ID: <20260603175137.1990204-2-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

There is no need to use the long BDs for transmits
where only checksum offload is needed.
Modify the check for long BD and use long BDs only in cases
where TSO and other offloads are requested.

Fixes: 527b10089cc5 ("net/bnxt: optimize Tx completion handling")
Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 27758898b0..7ef5b15ae8 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -111,8 +111,7 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id)
 static bool
 bnxt_xmit_need_long_bd(struct rte_mbuf *tx_pkt, struct bnxt_tx_queue *txq)
 {
-	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_TCP_CKSUM |
-				RTE_MBUF_F_TX_UDP_CKSUM | RTE_MBUF_F_TX_IP_CKSUM |
+	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
 				RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_OUTER_IP_CKSUM |
 				RTE_MBUF_F_TX_TUNNEL_GRE | RTE_MBUF_F_TX_TUNNEL_VXLAN |
 				RTE_MBUF_F_TX_TUNNEL_GENEVE | RTE_MBUF_F_TX_IEEE1588_TMST |
-- 
2.47.3

