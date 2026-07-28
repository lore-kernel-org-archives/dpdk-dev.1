Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F684C53219
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E71E14060F;
	Tue, 28 Jul 2026 16:12:36 +0200 (CEST)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53]) by mails.dpdk.org (Postfix) with ESMTP id B3E05402E3
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:12:35 +0200 (CEST)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66896892b6cso4605533d50.0
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785247955;
 x=1785852755; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bxaz7hRJZyQl8aBibpd30nW9skuoo6TjUXUk7wZ+h7s=;
 b=j9ebdvCU0bFo900Jj+bBR3fjoeT5tpcsLCFTf98th4s7a76bpPbjaqd4PDq2nm24Rb
 HeMM9zv4bPVt5YR3bJhSUfiMSXQPElZHfuXLeLWu/MvLPX65I4LfbMNu0S5T8VZvYBd+
 7rEXFmYgkFxpvx9+EXFQTwXklwyIdPvg5NHfdaJZ+/DnQYZ/DepyNHlwi1htOo0eP+0E
 ox5Fw9VS2E34XZjAaDAQg3wJQBxv8iRtlxU8SDb13ZxQzi3CKiyHewVK2qlLaeQBoYE0
 M5juC4yrNGbVF+c5PsAuHue/L+1GSQlzhnJ9YkcYp8WRLz2BcsM7CT8jUQPArc388BpQ
 Kn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247955; x=1785852755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bxaz7hRJZyQl8aBibpd30nW9skuoo6TjUXUk7wZ+h7s=;
 b=mVo7qkl46j1hE5ZAIEAB71O5MNyzXmqWSqEEiLejzRhul1YCEXxyIKusBVAJGqleB7
 dN7CY0PyDpgZJwG0dsxAbCcLf0uHOjpwzoCtYuj2dfJprdLQRwXXT0EJCJCH5EdEv2XA
 zFYrfnHTQBLHKy0D9ueP0OWrwkMlNIFXeNP5fsAGHspv9HtwUItx+caPMK2UqgUhBIZ5
 /GRJFfpsdam6tHk9Vx7giedFsn2uLBUPcmioQXpzYtHBnOChrhfwZvgoSHylanDINtWO
 0CretsY3VjI2Jrn14wRlAMoTJZRv/FTh4wHCq2gXfGV0PlGf0Lh2vdn0chwgo+wwnurt
 WatQ==
X-Gm-Message-State: AOJu0YzuDgY40kNSwUhsnhkI/h2mlPtGbwIrRv4ozQRLhFL6Sg7+xJyF
 MAr2Z4XL5ey3S4fjZZ91TuGY6CpEtOUNih3aUFkwdhzWzzFLU4eQDq5POOrntwlsB0AvGZco1p5
 mqxKX
X-Gm-Gg: AR+sD10J4oANu0Fg6mdGCO8z/iHMtx4PK8mMnNjBCqkIJsy9Ttta7UTpH+kpWCWPq1M
 xkhGpzJsujdf9FjDAhE53/8hInIpMFFcwfmxD4HkL93EZnrnui8bvJJe4fUk7NrNvEV1K2cMtUH
 dfAJBrGhCZjksdhxQT1s6p1eKLWHv6AnqAvnYl9AHKm7lBJriWIKiNjh2loTn+cDLnvUYsKGtp7
 NBSWRuHFUZP5UTExdmz4L1P4ibbl+h7yezAuGBwedCz1ATdBWIJntqTgVe8e8l/BNe66wt5+CVB
 AUNU9YjH3W2LC9KFUJXLjrpLeO0lcnARHrm1WMEix+MhQoLMsbuIob6dYC9iWGZ7kzltRpzZI62
 2PCZXLLFaF+b078TceO/unN+iztXJGw0FPCBmm+3joiiyT8XJ/pnObvJFqzpM6FJX4po3FgSPO9
 5CqGLxrqv8XSSuJvIdO6mtIKblrq1Leg4EHdfJcGvsJewupWRZephC7PMdI/USryyzUB4ZZpOxm
 4cFHshh8UGmbyPG1gIVlEL+4aY=
X-Received: by 2002:a05:690e:488a:b0:668:14b:e5c6 with SMTP id
 956f58d0204a3-669056f1dd9mr665422d50.42.1785247954979; 
 Tue, 28 Jul 2026 07:12:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6f6aea3sm5065610d50.12.2026.07.28.07.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:12:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH 1/3] net/sxe2: remove unnecessary checks
Date: Tue, 28 Jul 2026 07:11:43 -0700
Message-ID: <20260728141229.93878-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728141229.93878-1-stephen@networkplumber.org>
References: <20260728141229.93878-1-stephen@networkplumber.org>
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

The DPDK rte_free API already handles NULL pointer.
Found by cocci/nullfree.cocci script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c    | 6 ++----
 drivers/net/sxe2/sxe2_ethdev.c      | 3 +--
 drivers/net/sxe2/sxe2_ethdev_repr.c | 3 +--
 drivers/net/sxe2/sxe2_mp.c          | 3 +--
 drivers/net/sxe2/sxe2_rss.c         | 3 +--
 drivers/net/sxe2/sxe2_txrx_poll.c   | 3 +--
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b09989fe50..4c0e656423 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -263,8 +263,7 @@ int32_t sxe2_drv_rxq_ctxt_cfg(struct sxe2_adapter *adapter,
 		PMD_DEV_LOG_ERR(adapter, DRV, "rxq cfg failed, ret=%d", ret);
 
 l_end:
-	if (req)
-		rte_free(req);
+	rte_free(req);
 	return ret;
 }
 
@@ -320,8 +319,7 @@ int32_t sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter,
 		PMD_DEV_LOG_ERR(adapter, DRV, "txq cfg failed, ret=%d", ret);
 
 l_end:
-	if (req)
-		rte_free(req);
+	rte_free(req);
 	return ret;
 }
 
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 8bbfdc3a15..625365e31c 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2063,8 +2063,7 @@ static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
 			ret = rep_dev->dev_ops->dev_close(rep_dev);
 			if (ret)
 				goto l_end;
-			if (rep_dev->intr_handle)
-				rte_intr_instance_free(rep_dev->intr_handle);
+			rte_intr_instance_free(rep_dev->intr_handle);
 			ret = rte_eth_dev_release_port(rep_dev);
 			if (ret)
 				goto l_end;
diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index f32318b731..86686ec548 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -594,8 +594,7 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 		struct rte_eth_dev *rep_dev = adapter->repr_ctxt.vf_rep_eth_dev[tmp_repr_idx];
 		if (rep_dev) {
 			sxe2_repr_dev_uinit(rep_dev);
-			if (rep_dev->intr_handle)
-				rte_intr_instance_free(rep_dev->intr_handle);
+			rte_intr_instance_free(rep_dev->intr_handle);
 			rte_eth_dev_release_port(rep_dev);
 			adapter->repr_ctxt.vf_rep_eth_dev[tmp_repr_idx] = NULL;
 		}
diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index a4a5c76495..9aa5461a94 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -282,8 +282,7 @@ int32_t sxe2_mp_request_simple(struct rte_eth_dev *dev,
 	*result_out = ((struct sxe2_mp_param *)reply.msgs[0].param)->result;
 
 out:
-	if (reply.msgs != NULL)
-		free(reply.msgs);
+	free(reply.msgs);
 
 	return ret;
 }
diff --git a/drivers/net/sxe2/sxe2_rss.c b/drivers/net/sxe2/sxe2_rss.c
index 1d56613043..44e1ecda27 100644
--- a/drivers/net/sxe2/sxe2_rss.c
+++ b/drivers/net/sxe2/sxe2_rss.c
@@ -439,8 +439,7 @@ int32_t sxe2_dev_rss_reta_update(struct rte_eth_dev *dev,
 	rte_memcpy(rss_ctxt->rss_lut, lut_tmp, reta_size);
 
 l_end:
-	if (lut_tmp)
-		rte_free(lut_tmp);
+	rte_free(lut_tmp);
 	return ret;
 }
 
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 21925f1cd4..5dcbac9953 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -1121,8 +1121,7 @@ uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts,
 			new_mbuf_pay = rte_mbuf_raw_alloc(rxq->rx_seg[1].mp);
 			if (unlikely(new_mbuf_pay == NULL)) {
 				rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed++;
-				if (new_mbuf != NULL)
-					rte_pktmbuf_free(new_mbuf);
+				rte_pktmbuf_free(new_mbuf);
 				new_mbuf = NULL;
 				break;
 			}
-- 
2.53.0

