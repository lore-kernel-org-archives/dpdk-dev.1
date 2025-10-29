Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC1CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2B4040657;
	Wed, 29 Oct 2025 17:18:06 +0100 (CET)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id 9D9E740658
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:18:05 +0100 (CET)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-430c773eec6so70810595ab.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754685; x=1762359485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmxiDSYyZcG6x7BKQ7FR1Gw6d5ylGuDHStGWcjLXcbg=;
 b=TdBDG/WBW40h2acNF1xcSxZL16Q4LjD7IRKQLPKenAq0zJWFsacdz1I0+FgYu9yE2X
 EePTtuyf5XgB/aHOa+dxiuNHRuBmdF5vS9+rWapXom9a6nn6G2IgzSLUw/XIAHjF40nA
 qyAbo6PgfEJPDaNIRlxva9bdidIGmcxli/N8e0zc5llbAZvPf4mKEj8ZavpIjiHrJAdT
 WEUjJJKI/A9QmVzMgSOkH4qV9Ym6O4E4uMa8woGk6wPagRDDeRlfw/su2pTZIR96pSwE
 K1LtTQIg2f5B0rz8X5B7rtTudardtZRWC/DTcF/NZTB8bqvBodl5x8CNI6+Qx25lMFYK
 rfgw==
X-Gm-Message-State: AOJu0YyNmHqUHPjzn7JEr6O5lVtCq3rZIH0DFK9Wak/LxdafSMQSDEGO
 x+Nc3xEM+/3fbDA6tvM2dEcxOhr6LRPQhqukwA5ghsJZwHgv6GRRAwCXWI2Pxh3ZH8B1U00AC14
 WMmEloTtypzeIrfQZldVo/QbdOdjv87ST7S8NHgXOA7LE00Q+uJbMckFv2tAAYkww6iUyGgmv5/
 Dn1PIPumII4378Rl4FnqKoh77zzfWYQ0fb6+aXCKxG0Qbo4GVcD2cKbCOqUdySfNF+7h/WJw==
X-Gm-Gg: ASbGncuCK4iW2iY/fySTp+36nm8lyfGupc96KytwwQOSynI1A2R7N3Dh3uXjZqWlD2G
 OOuK2SHEreoS0aWNB8x0xuJIk2QM1/Tfsun5oMqsTO631AUT76GkwPy5tmQdTic8PL9UuxLB1pC
 SiqcemU/qh9TcYkjm5GoyTNUUS3Z0e0dJf2CR6RTfrbhPomlOQ3zvp3ANAnLV7wNsJVkvHAt3UH
 IWxzDa2q6sRpsRF4+nTyNXbXBWFZi8Ow/EGYFXhkoXbHZ0YUgX2VMmmWmuPv26Xb/qzkwOq2AzR
 pYebtk62r1WKjFav9Rio23MlLTOs64NMdoHRW4rM+Jwq0u1/s5Ar5yS1srwcqThCw5UTomHj6O8
 +5RNOgYptmGujsrK2hQbwANf1hQcIg3nplTogPsrrsRpsH7HtAERwr6mDc/7jyXd6NlldBUv+xC
 OS8WeBWBz02jyxcMMdLSBZe2M9iWjptt5Mcx5J
X-Google-Smtp-Source: AGHT+IG1epntvVduJMkvxUHRtLzVbjgZBHo6lyG0cC6al65ylNh9qoo1t4G0g9YCo5KPRtlk27IQ9qL6aL7r
X-Received: by 2002:a05:6e02:5e84:b0:430:ab80:66f9 with SMTP id
 e9e14a558f8ab-432f8f87012mr46784375ab.1.1761754684778; 
 Wed, 29 Oct 2025 09:18:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-431f688c4ecsm13560005ab.19.2025.10.29.09.18.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:18:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-890801794b9so939185a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754683; x=1762359483; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmxiDSYyZcG6x7BKQ7FR1Gw6d5ylGuDHStGWcjLXcbg=;
 b=NTmFtpgp9SSaMHAXEKH/NQekYL/NT3w2V2fK8v39t+Sfaj65QNq2r4dyzf1fFYBPXA
 f4alHN4DWHeW5+3z+d/mKCS9hMDPJRC5F5IGR+S6qxGHCWzi8475rgILglAx6G3TAf9n
 +qSompFn1DZYodOhoN52U8Gvd5ijrS5cPOCNQ=
X-Received: by 2002:a05:620a:199d:b0:883:c768:200a with SMTP id
 af79cd13be357-8a8e473afd8mr477977585a.32.1761754683587; 
 Wed, 29 Oct 2025 09:18:03 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:883:c768:200a with SMTP id
 af79cd13be357-8a8e473afd8mr477970385a.32.1761754682956; 
 Wed, 29 Oct 2025 09:18:02 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.18.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:18:02 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v5 25/57] net/bnxt: cleanup default rss config
Date: Wed, 29 Oct 2025 12:06:40 -0400
Message-Id: <20251029160712.58519-26-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

Mitigate this issue by specifying only hash type IPV6_FLOW_LABEL
in the hwrm, when both are specified in the rte command. This
works since the hw includes IPV6 src and dst fields also in its
hash function when the type is IPV6_FLOW_LABEL.

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

