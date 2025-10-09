Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454ECCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5638940B9A;
	Fri, 10 Oct 2025 00:15:52 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id A2B834066B
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:50 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-26c209802c0so15077605ad.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048150; x=1760652950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ETsUrltK3tUlhd9CVuWx6LHfT0jEuxqVgRQYs/Tf/o=;
 b=TfWTOTM2vgtNx4NgOxsnzsun2HKvzULidY2Oquexy8aCWeWpXwq8p6hZRP6Wv/f9qQ
 Mq0z98c0FWsUcrpVDjnMv4fPX1JIZS4VMG7j5Lm/2rZU4TzlNBtHoK6OLSIxKD0p0yDi
 f6acUgm9FJiRE30Uu+KTXkfxR+i1oLkABsi/bheHdlIW8EQjsRNEMEb899BTPNbtEMga
 md4yfpaXKyEgCfRHfRt35I6HvqhNealwkRYMz3SlTTsIPwsNnwILfzRU3YuXii6Azc8D
 ax0ZQaBtL6AQ4eVdPUw7HmDwzNbpvXTMYDYrIVa0gow5dsdScC3Xyx6zo/dHSaDRDfzV
 ApCA==
X-Gm-Message-State: AOJu0Yz1vNmf/kFrgAwPV1u70yU+7pn2y6TxhQJW2r9C3onDJcvmCNL8
 xHrbrxK0K0yQde4hb7Rwk05g7fst/5Ez2vsQbsVcMC6W+bV2WkIvAzAyH9hpyGHDRIJmiJd7cUh
 eGskoyxhXmcHtv/kWuE66Y2nvMxkZ1tUGUzztlW7Y+SH+LJtVAB1BrRxFmaV/jglZ0hJlhWje+j
 i1TB7TcAHAdCXBaYyW2cFMU4IxESpuYTDOG/WUa6piqvjZnjccJW3Pn7m9MZn36AzDg0Qiqg==
X-Gm-Gg: ASbGnctUYFuB89oGvDlidiwwE4uAXZX4mfMnU8HxnMAIKwninb2fppZgJR4SWqyKlah
 g1CsKBG6Cd5uOVrX/T/KMpkxaPaZhs1rC+mERSYQlBIJ7lgMj1YtCvk+7OHKy411XcsDErK1KFF
 2FcuPljHfbASoWrvh2ywj0Z5HKcx6EluRyweO7qbYGWUvaalUIpkICk6n1nTioEo3bXCcfuGU5d
 I0H/vx0YyhfpE3yC+mAiHv+Z4pKhtwgcCqYo3N827WOCBaFaubSTrzyaiPdMH3rwAYbYhB2j1bU
 K218Ykwb3sr7CKEjJrlWq2qDO+WpnciZc3ctSs2ej4MimeJhqbZtODvZDxlwyAc52ebqy7aNSbr
 87diZmcCO0Z+nFhao89gwQrDUcS0aMoo3xPJpdUSa+3G1963y0+2HVwQ18LyhPsGeCD3f3laeZQ
 sqqFqKpB4=
X-Google-Smtp-Source: AGHT+IE+SZ/tyLrxZueo26l81QaT5fwV2bwDzCcLFhP7DmLxmfRpiRfu8jQdUppPMuN17eqkNP/DkDKNnwbp
X-Received: by 2002:a17:903:3c65:b0:269:ed31:6c50 with SMTP id
 d9443c01a7336-29027356b55mr104417305ad.10.1760048149740; 
 Thu, 09 Oct 2025 15:15:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034f2dbc0sm3372875ad.53.2025.10.09.15.15.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso72524986d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048148; x=1760652948; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ETsUrltK3tUlhd9CVuWx6LHfT0jEuxqVgRQYs/Tf/o=;
 b=XNQ7MwH11fbo0zMaKHauhRqBpYg9VwvhXgJQZfprme1Vl0cwpdbEoD3f5otrm/71VC
 xwxds76RIYn+jSwjbj7eUxTk+U0+bw4X9ZFFkgGmcjUDfUoX62cJPU7W4USjzYnrY5hx
 JLS7pIBrCjR6fllX+DnvzySQLfWjkri5QkXPo=
X-Received: by 2002:a05:6214:19c8:b0:7d4:840e:d9a0 with SMTP id
 6a1803df08f44-87b2ef93692mr168637976d6.50.1760048147952; 
 Thu, 09 Oct 2025 15:15:47 -0700 (PDT)
X-Received: by 2002:a05:6214:19c8:b0:7d4:840e:d9a0 with SMTP id
 6a1803df08f44-87b2ef93692mr168637606d6.50.1760048147437; 
 Thu, 09 Oct 2025 15:15:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v2 22/54] net/bnxt: fix default rss config
Date: Thu,  9 Oct 2025 18:10:57 -0400
Message-Id: <20251009221129.28256-23-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

On Thor2, the set of supported RSS hash types reported in
dev_info->flow_type_rss_offloads includes both IPV6 and
IPV6_FLOW_LABEL. However, hardware support is mutually exclusive.
That is, either hash type IPV6 or IPV6_FLOW_LABEL can be
specified, but not both.

But, an application (such as testpmd) that sets the default
hash types based on dev_info could end up specifying both bits
in rss_conf->rss_hf field. This results in an error when both
are set in HWRM_VNIC_RSS_CFG command.

testpmd> port config all rss default
bnxt_hwrm_vnic_rss_cfg_p5(): error 2:0:00000000:0000
Configuration of RSS hash at ethernet port 0 failed with
		error (22): Invalid argument.
bnxt_hwrm_vnic_rss_cfg_p5(): error 2:0:00000000:0000
Configuration of RSS hash at ethernet port 1 failed with
		error (22): Invalid argument.

Fix this issue by specifying only hash type IPV6_FLOW_LABEL in
the hwrm, when both are specified in the rte command. This works
since the hw includes IPV6 src and dst fields also in its hash
function when the type is IPV6_FLOW_LABEL.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 11 +++++++++++
 drivers/net/bnxt/bnxt_vnic.c   | 10 +++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 7edfd8ca89..7177941e09 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2485,6 +2485,17 @@ static int bnxt_rss_hash_conf_get_op(struct rte_eth_dev *eth_dev,
 			memcpy(rss_conf->rss_key, vnic->rss_hash_key, len);
 		}
 		bnxt_hwrm_rss_to_rte_hash_conf(vnic, &rss_conf->rss_hf);
+		/* HASH_TYPE_IPV6_FLOW_LABEL and HASH_TYPE_IPV6 are mutually
+		 * exclusive in hardware. See related comments in
+		 * bnxt_rte_to_hwrm_hash_types(). If the cached user config
+		 * has both bits enabled, make sure both are reported in
+		 * conf_get_op().
+		 */
+		if (bp->rss_conf.rss_hf &&
+		    (bp->rss_conf.rss_hf &
+		    (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_IPV6_FLOW_LABEL)) &&
+		    (rss_conf->rss_hf & RTE_ETH_RSS_IPV6_FLOW_LABEL))
+			rss_conf->rss_hf |= RTE_ETH_RSS_IPV6;
 		rss_conf->rss_hf |=
 			bnxt_hwrm_to_rte_rss_level(bp, vnic->hash_mode);
 	} else {
diff --git a/drivers/net/bnxt/bnxt_vnic.c b/drivers/net/bnxt/bnxt_vnic.c
index 637e9b9aa4..f0ec87198f 100644
--- a/drivers/net/bnxt/bnxt_vnic.c
+++ b/drivers/net/bnxt/bnxt_vnic.c
@@ -285,8 +285,16 @@ uint32_t bnxt_rte_to_hwrm_hash_types(uint64_t rte_type)
 		hwrm_type |= HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_TCP_IPV6;
 	if (rte_type & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
 		hwrm_type |= HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_UDP_IPV6;
-	if (rte_type & RTE_ETH_RSS_IPV6_FLOW_LABEL)
+	if (rte_type & RTE_ETH_RSS_IPV6_FLOW_LABEL) {
+		/* HASH_TYPE_IPV6_FLOW_LABEL and HASH_TYPE_IPV6 are mutually
+		 * exclusive. If both bits are specified in rte_type, set only
+		 * HASH_TYPE_IPV6_FLOW_LABEL in hardware since it subsumes
+		 * HASH_TYPE_IPV6 (see comments for HASH_TYPE_IPV6_FLOW_LABEL
+		 * in hsi.h).
+		 */
 		hwrm_type |= HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_IPV6_FLOW_LABEL;
+		hwrm_type &= ~HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_IPV6;
+	}
 	if (rte_type & RTE_ETH_RSS_ESP)
 		hwrm_type |= HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_ESP_SPI_IPV4 |
 			     HWRM_VNIC_RSS_CFG_INPUT_HASH_TYPE_ESP_SPI_IPV6;
-- 
2.39.5 (Apple Git-154)

