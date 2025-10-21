Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE672CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07BC640F1A;
	Tue, 21 Oct 2025 19:53:05 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 49D1F40EF0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:59 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-33d463e79ddso5044250a91.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069178; x=1761673978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BnjICvWo03rToGq636QEQBwAsqS2j3fxgQnCoDETIVA=;
 b=sXqIgUV14Cb0RznsfXffeyh53QdTj4vHHp+BuF0AsFhqGOS84BQDBozT5zAt9ZjYmd
 Kgl5i53Htj2k11eqTvTISi536D86tmydVXJd+XVtVJQsSKDegdGbgQPQ3Zhg4gh5L8WU
 Yw4Xzr0bAO0p2V4Tkm3TcyjArFG+i+kTb/I8Z36j4oEGIUCIQnKzaISvnqM0xMKoEZ6V
 b89+rOkp2T2f2f/hoahsl7YWwadTmGkTO+c8xzxxPuaQA07PqaxOvyX8FK9Mct60ii1T
 HhEUm8ZNqYnnIgDYOHw/sYZky05uLWz5s+X1phqVAgJkLaBc1KOx2N0ZSiwS9Liuy+lJ
 xP1g==
X-Gm-Message-State: AOJu0YwYf3ovd7J+X7UwnaRPLgQbJygE8CGwIeRgulSVdoVkeA/pLhDD
 pECXxpwzZ1gdM7H+m5igvzrgQE9/Sn9x2Ar06c/7zBBjw0eKr/ylIZmMg1OYx6uBmOBBS24JDZv
 QOCrNW7JHOdEFAxnmGWAUqPHdW+Rbi7NK5NaZZHNLynhj7qFdK5RLfNTWyoZd4Fj1QkEdzLrbpG
 BaWbNGIVv7O1qN4ez1qNKLg5Rujvb8yTmnrhxH8KAXgXwTYKLqblX/emSd4YLrM8+J2B2/1Q==
X-Gm-Gg: ASbGncsjqxl04hGnyTnhp3cQbfj9Fn2vZKlCo/4tQec6AveQSkGgWtwYM0xG++tgpFf
 tIkZGzdroW/5M2S94pzFx41Oq/T0jnB9POowzHgbjphqJY6B71THgIzZnN30fmxjcROoJY+6IMy
 LigwFJt4zj7EpsFJSIYvrdDbegyiY3mYFzW7n+2RW15o9j8M0NwlYIIj2Fx4mjKjwKSgF2TfW2o
 ax3LB0v+XK8P/fRbIEFxEf3AymKhyDRI2hVjL6B2jExlP+UXzixMCfHpLyqbzIV7pNmvo2vdeMb
 Z1KFuKmQjKnfiEtWq8P5OqG/P1abwcqdY3QGr/TnMcWqM0l6ItIBqpl0z7OONTBjeK18bYT7r42
 wm2jVUj86ZBQHcouoCfJJmqEbzuOvlCTNJGR+MbqBnsZedzX1cxy8sL+RhhBMEcmJ50abBJIfLF
 S9ITGaSAhSfvngoK3r11O2/m20jL2ezGfgpA==
X-Google-Smtp-Source: AGHT+IGrLzrohsXAhZUbnvxvbirTiUbNTQqmApMDI7GBDG1Okxkf7XXVIULiHcLSdBQjvqd8E3bcRvE7xnHv
X-Received: by 2002:a17:90b:2789:b0:32b:cb05:849a with SMTP id
 98e67ed59e1d1-33bcf8fe212mr20811270a91.29.1761069178279; 
 Tue, 21 Oct 2025 10:52:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33e223d250asm17821a91.1.2025.10.21.10.52.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2904e9e0ef9so115012935ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069176; x=1761673976; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnjICvWo03rToGq636QEQBwAsqS2j3fxgQnCoDETIVA=;
 b=M/0il2C1SGi7HZ44s4N/qujl7wd/iTMsiDOFmXSJjl68Jd0eTcy+zgpURaFL6OmXJo
 V1QKBXd5b9xLDTohnrMiiBs4uox+d0J5GfUxLebpNGRDRTxikGwUza0hFolWtnCAAaEW
 QO0MetXfZtXpufkV/zVIz3PCLvoLlZJr0poCM=
X-Received: by 2002:a17:902:ce12:b0:279:daa1:6780 with SMTP id
 d9443c01a7336-290cba41dd2mr194251065ad.52.1761069176208; 
 Tue, 21 Oct 2025 10:52:56 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:279:daa1:6780 with SMTP id
 d9443c01a7336-290cba41dd2mr194250685ad.52.1761069175441; 
 Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v4 25/57] net/bnxt: fix default rss config
Date: Tue, 21 Oct 2025 13:50:17 -0400
Message-Id: <20251021175049.46092-26-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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
index b2b8e20516..4bca2239c3 100644
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

