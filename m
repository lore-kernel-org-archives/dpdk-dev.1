Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F848CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 401FC40E37;
	Wed, 15 Oct 2025 11:04:21 +0200 (CEST)
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com
 [209.85.210.98]) by mails.dpdk.org (Postfix) with ESMTP id 6A7A440E34
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:19 +0200 (CEST)
Received: by mail-ot1-f98.google.com with SMTP id
 46e09a7af769-7bc626c5461so2063477a34.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519058; x=1761123858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ETsUrltK3tUlhd9CVuWx6LHfT0jEuxqVgRQYs/Tf/o=;
 b=o1FKbiGX/suld2n7QLzQ/93jR0PIiVtrmZBgQ2RgktAJvU3USxXkBcl3jr8bo8dTBz
 Y0fHKN6KB07MeyyhGsjJ4Bqnx4yfa022nFaQkyCWze5DKyIOPuc8CHCedehS10XZdWey
 EtzrUqV0HSK3KnLdf+3ZY/0rjlahZeddb1ftQ6H4NTvTdXtT0wxEkBctK0yK1YFoaXcf
 Of/9B7bg77A5cBJRuUut/gxZmvAzz/gKllDxnWLsIfIauWdYaZI1llCeu48Vq7Fkp+Mr
 g/hO07Gte1aKAXNthu50xh9QG4Gn1V7X7my0qLJwTzxNDHQc8wCilLZV2aTvNPd07VH5
 ZlsQ==
X-Gm-Message-State: AOJu0Ywc3H+yG1VhNEzP5wpI0wZ9pXLWN4Pn3B9o/YLkEgX72E+H6cIc
 qD6x+sZIyjYw8B+RD4mqOp4wuDFlEDi2SD+FmtMdlpYVJXCo90p64LyCwjUC7cumzzzq0H4Ap2Q
 lgDvwYSNhw+7rAtCYmBk0MfOSAR3xSzzb7QhKqSLmj/TRifc4VNarFZbGMXLXDbYEIoPREUmEZO
 +XCjz2vFURZDghnmGg/GrtQKKLZwBcyCh59XB0mY+mDiK9vwPeYq1I9eDuvzJMXlMtalyWag==
X-Gm-Gg: ASbGncvFqWAEK0vwkLnvC6XGIL81y7kcteHQC4WGklGtjL+DFrMu/grqmsLhaDsHzFM
 OXQiHhZEcaSPg2YHKzSACtt8yArRSSvBcUP0WPTnKN0uzRKesyApSms1rRVmif0JEj07greO08S
 k8KZYCt31i+M+gECY3BDnYuWv2/sWM6D2Sl6lu12BvT2VwCO8ZwVC72oxsgj0Q7TjQMHxXjEJwZ
 4afB0kEMilk92Vtb61LHrLCH9gtoaRAL+JwdNURFoslwypm0mzOJkxkOI/fKLDHtY1AS4CZIgvo
 LR9h2kFlQx/0tP4OVUz3Zl7gdTLwLw82e+re2C7U4j17/SlCnkNjtkjcFmp2nXA8c5/F5WJildv
 FH/sFy3xTYib4jdbxoK0A21sUhQKJb0eGGNDLvdeWkVz6AUBRdGi+8fsLI9cgmRnb4ABevwwdJ5
 oiyA==
X-Google-Smtp-Source: AGHT+IFhKF4KSH0WjvkqMxK2KJiVJpeVH7REmV9UvXfhr7cdcAxFqHAlBTIy/banriQOjivMRQzJJfV7gQ9K
X-Received: by 2002:a05:6830:67c9:b0:745:9272:4a39 with SMTP id
 46e09a7af769-7c0df7e681cmr14194445a34.25.1760519058503; 
 Wed, 15 Oct 2025 02:04:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c0f901eba1sm1272532a34.1.2025.10.15.02.04.17
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-780d26fb6b4so7141938b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519056; x=1761123856; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ETsUrltK3tUlhd9CVuWx6LHfT0jEuxqVgRQYs/Tf/o=;
 b=IxdpFTBsAea0Suha3GD82AiUhH4D4sho24GNpb8wueC2v0jlUYoGSuuE9+rbRdr3jK
 jVieszmmH2JtioC1hV+TzDYRYmp6eUAzmNH34OUZ/eX4KifRIPxw00IVYMmuIeS1nGMZ
 7jfakVPyNwD1B98oJda3VwnofiN3sObRrw8iE=
X-Received: by 2002:a05:6a00:3e10:b0:772:114c:bcbb with SMTP id
 d2e1a72fcca58-7938570984amr28914536b3a.4.1760519055605; 
 Wed, 15 Oct 2025 02:04:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e10:b0:772:114c:bcbb with SMTP id
 d2e1a72fcca58-7938570984amr28914488b3a.4.1760519054940; 
 Wed, 15 Oct 2025 02:04:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:14 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v3 22/54] net/bnxt: fix default rss config
Date: Wed, 15 Oct 2025 04:59:52 -0400
Message-Id: <20251015090024.32250-23-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

