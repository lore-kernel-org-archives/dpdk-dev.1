Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A322CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:47:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 622E04067D;
	Tue, 16 Jun 2026 12:47:45 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 3424B40DDC
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:44 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso2976630f8f.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606864; x=1782211664; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeJG09hJ4y4grlxwxHT8Wn+2zAuSODhT5k/KpsJ7nwY=;
 b=mrjSVcE+0cW3A2kZYfI5QCPQWWDhtVqIY1gLUGWUIXONoO3JjVLZeQ/0AB/mNycqyH
 23FyEeSupG64A+4IfXx6Glea9JeT3zmo9PfUCF9+9+uH3qFjpFLJwE9ZwBHNBKtW62q2
 dNB95g9WKZ9DvX8BqEnD2BcSw7RoguKefj2tl3TgQTq5D5xKEr9XjVAuZ+BL8tIVlLHx
 uB5SW4UYMJxTqDAUO8ENjZUEHmZ3JLCNloL76WgLghkPrXcwjm0vpk5S0VsI9x6+VdJO
 x9S2SaunD2XfV+d3lw+ywhfINqBOfYj6H+fgJsgYlS+2uktlwvGE8c6vZBwEGYrQVCn1
 lNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606864; x=1782211664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeJG09hJ4y4grlxwxHT8Wn+2zAuSODhT5k/KpsJ7nwY=;
 b=imujc8+XNZW1V2uIBD7+pfEh8Mkdfe3gV6jGwf93vz+o9+V4JdxG+TgXYDoD/Yf9Z6
 reF7KZlXj7su3OaBxsUmmKD4+BVVIupewO+D1FCiBBcrvHBDFdQJRmaQCUjxmHNpaLSk
 IzWq9mBHI5VTzTFX3jjVjDImm9dJbOBU4aCjwriYKLDyzJPV9aDcEkvn5/YbQAdYxj9d
 x+jLbOm1GxZU24xl5rF0qw10nqza9hTQrxiF3yA33UgxKfwqecrUpnc1b9C81Ice5I3A
 BiQzNYQFp2qODpL/lqA/zPWPCj9pUZ10I2d5WlvkFGH6cqkgC0KNwjDXa6gqNYXOesjA
 5SQQ==
X-Gm-Message-State: AOJu0Yy27iz1If12Z+tiVUjh9SurciczitcnokSVXOXH1+Rmf+B8v23T
 z0t9aywurvON5M0eUIgifRhzk7n/lfE4Mns8m/TXreJZLGSQMTuYcRa1bS2NLq5p
X-Gm-Gg: Acq92OEVqpdXQ0ARMBHRUuOPkNT9L/VeEq52IYEjS27Fs5lMg2Sx7FWdI28Xnh3k1Br
 VGkRiqX7EgYVJsy8LgBxIgBHx2Wh4/T4L7HwliTSLx7FT5wUwJ57CODoyNl4J5DxhIoSlodHoQ6
 TyKRbgqNrD4iC5v93C+zrsHhIrG5gZpaJSmKqQOTAiFJ4XvJuq1+2vipWLHAJNPfKHWhWq0qlot
 veMSCGfCOSLldS6iLl1YowxRtMcaoxLa1osYh7VhtgfmHjsDi6+gkEh9rZUiA60ITZbNdOEgoCO
 aDKProdJovUBh+FehrAjaTnxv1DD1NZhE1+VP34Ipq4n2eKdpNOmM5on529pAokZvO3vENAHdBs
 /dBAk+66JIFljd/Qvhe6O8TLGkL8prHprFvCMOgUXPoqbd6QpGl0Sr92bETTy98XGWePHXUknl2
 6xiQ254l6rZ1LSs2wK+VTfAsjdDOosHZCaz3o2k1wmNB656ac6oGfd
X-Received: by 2002:a05:6000:4e3:b0:45e:db3b:921d with SMTP id
 ffacd0b85a97d-4619f3b9a73mr4278537f8f.31.1781606863646; 
 Tue, 16 Jun 2026 03:47:43 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f20e77asm45805577f8f.0.2026.06.16.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:43 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 2/6] net/dpaa2: use L4 port extraction for SCTP RSS
Date: Tue, 16 Jun 2026 12:47:11 +0200
Message-ID: <20260616104717.723087-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

DPAA2 hardware exposes L4 source and destination port fields at the parser
L4 offset. These fields are valid when TCP, UDP, SCTP or DCCP is present.

The driver already uses the TCP port fields for the TCP/UDP RSS case.
Handle SCTP in the same L4 RSS case, so SCTP packets use the same L4
source and destination port extraction.

Fixes: 89c2ea8f5408 ("net/dpaa2: add RSS flow distribution")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 32 +++-----------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index e7578b7576..4df66d8f33 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -228,7 +228,7 @@ dpaa2_distset_to_dpkg_profile_cfg(
 	uint32_t loop = 0, i = 0;
 	uint64_t dist_field = 0;
 	int l2_configured = 0, l3_configured = 0;
-	int l4_configured = 0, sctp_configured = 0;
+	int l4_configured = 0;
 	int mpls_configured = 0;
 	int vlan_configured = 0;
 	int esp_configured = 0;
@@ -407,6 +407,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 			case RTE_ETH_RSS_NONFRAG_IPV6_UDP:
 			case RTE_ETH_RSS_IPV6_TCP_EX:
 			case RTE_ETH_RSS_IPV6_UDP_EX:
+			case RTE_ETH_RSS_NONFRAG_IPV4_SCTP:
+			case RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
 
 				if (l4_configured)
 					break;
@@ -433,34 +435,6 @@ dpaa2_distset_to_dpkg_profile_cfg(
 				i++;
 				break;
 
-			case RTE_ETH_RSS_NONFRAG_IPV4_SCTP:
-			case RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
-
-				if (sctp_configured)
-					break;
-				sctp_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_SCTP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_SCTP_PORT_SRC;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_SCTP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_SCTP_PORT_DST;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
 			default:
 				DPAA2_PMD_WARN(
 				      "unsupported flow dist option 0x%" PRIx64,
-- 
2.43.0

