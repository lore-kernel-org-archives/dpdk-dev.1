Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8DCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2CCC40E2B;
	Tue, 30 Sep 2025 09:05:52 +0200 (CEST)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 80AA7402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:04 +0200 (CEST)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-42571642aa7so27858195ab.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192624; x=1759797424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RkGvL5EbhK9r1jri/YoRw/QZsPy9zdY7wGPQ2R4EJ6w=;
 b=tGMb7iuUPQDBjm4v6MAZYkyKarnLa4dV5iLcMz6+aWdQ3k5n3U1SjmRKdx8C5bVkL9
 bXuuF0NXXlyHWCftSkcXOr6roPvoHuXSZo4xAeT2gXNPSaWzYOylXfJ29F3P/HqSogKn
 1XXh81KzNYPHzfyq8/7wc19Efe058mIKtCbLGO960TADBit8etcjuZwxTsPjmz9kiohC
 WTZCgL4uxzYyOUKGVA1eA0CTZ6tvnWWvU05VF86AyFrHXBndLyvTQ5sPHrN86bOoVjEA
 JjAIhTJTJDp1lIFa8wzDvgq51BqTh1C3uv74ZfTRXqp1syC8DKnq3bf9qagH2Wgg1/EP
 6etA==
X-Gm-Message-State: AOJu0Yz6TSvLcO5z7M3jM67Qde6q2uX//GBvBeahG8s9YZF9+uClaK26
 QQZaYPxvvsuNIqwHqS0QdCMzpZP9TTE50onqlQVtEAB68Uvq0LjLNjlzWx9efkFZCz4ij9A8taD
 iRug81lNOejmWeQsulUBphRT+VhvECBoUot5K7/ceknKgUZy9SwYqOBI9fX2s5HqsWfQW+g24+w
 CoJEubcYjR6Y6vFVlafKtsPmQ10dMS2OsiryQgbn8X1Cy4TDtHGd1896IPiK0uegXaAFQ7SQ==
X-Gm-Gg: ASbGnct5oczYAMYTZxrd5XfGhfaqsP1Ish+qGGj+XDGun0Q+7/fKD94HIfgTs+1wuSd
 WQ2ImZZb5CNJliNOzPyYihXsudeAWsWo8Xa9SVd0Iv70+uYTFUfk8xDEVybJ061Zebe2h3ZvmKo
 v1QV8DwVttP8MjtB45WaMzyrxtCeIU+jCoLGe5xqf3Og2JKqR0EcUcmwMXW32PB0W7YdNACkCL5
 YmgXdSh31bXf2FOgji6SCBAyuyEoqt8UpQbd3ZICsAbrnNzwNFBsDRdGWFg/UhpZfn+YJFLJFlh
 gXWtYWompV6aK8pN7sXGfp+HTf7BqlkESIUC7ddLFtSaesYhuQC7NYEtVfNaivzzjvcTgxDAPgz
 WfUHiRUU4AvCr9vkkcFKGi42wS7nJVuOKoCRbs/6LLtOJL1vljAOeMlRtMaptR65ENImtzUWACe
 +dLQ==
X-Google-Smtp-Source: AGHT+IHOifJ/Xpv0X6li2yKLVp9Dg/+8xueGcdMzVqSKNgR9w94JR50/BzzyAayet2jYCkpVHgykqlmkXJgV
X-Received: by 2002:a05:6e02:1fcd:b0:426:4470:376e with SMTP id
 e9e14a558f8ab-42644703b4emr329705395ab.29.1759192623758; 
 Mon, 29 Sep 2025 17:37:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-573f54eaad1sm259761173.39.2025.09.29.17.37.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77f68c697d3so3695119b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192622; x=1759797422; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkGvL5EbhK9r1jri/YoRw/QZsPy9zdY7wGPQ2R4EJ6w=;
 b=Tgw1WuKju56CD1CjI6xPs6zWX5EtbFOLMCSrqEqgwJcEl77Sq0jT+X2IcleEi9NrAw
 lrgd1SLlqpy/Qm0P10Pw3XKV/skZmJmYlIJXG9AU1CB87agO7D38iWP+dXrEJfnsLGGp
 4DyhlPGwckfctTs+BPI9m9RIn8Tov0YT38/vQ=
X-Received: by 2002:a05:6a21:6003:b0:30b:2a99:4424 with SMTP id
 adf61e73a8af0-30b2ac73b16mr8614217637.17.1759192621937; 
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6003:b0:30b:2a99:4424 with SMTP id
 adf61e73a8af0-30b2ac73b16mr8614178637.17.1759192621285; 
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:00 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 22/54] net/bnxt: fix default rss config
Date: Mon, 29 Sep 2025 20:35:32 -0400
Message-Id: <20250930003604.87108-23-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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
IPV6_FLOW_LABEL. However, hardware support is mutually exculsive.
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

