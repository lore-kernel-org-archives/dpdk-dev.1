Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE41CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 08:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B1D940292;
	Wed, 20 Aug 2025 10:42:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0FC0A4026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 10:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755679318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Cz4jBjRf35BA3L4SUx+REOHN+Y42/dQLQq3Ydtw6Wc=;
 b=T/G5twY8RCRQk0L++f/RwzOvankzg7oJHvDgg6mdX2gikQapzJTOTvGJ4CDYITjjZAv/w3
 qO2bjbbto7TqVEtxWbJawnEJtdtBfQZndXg9J65+bDX41hhdaTaKEPz8Ayu4BerwLqiu5M
 l4yWsHumvFv9NWNgipYh8hHAr136D1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-JtUUBWdLMPuw6nZmZ2usNg-1; Wed,
 20 Aug 2025 04:41:57 -0400
X-MC-Unique: JtUUBWdLMPuw6nZmZ2usNg-1
X-Mimecast-MFC-AGG-ID: JtUUBWdLMPuw6nZmZ2usNg_1755679316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B109018003FD; Wed, 20 Aug 2025 08:41:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7463180028A; Wed, 20 Aug 2025 08:41:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] ethdev: hide internal ethtool symbol
Date: Wed, 20 Aug 2025 10:41:46 +0200
Message-ID: <20250820084147.1253706-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xpzgXtq4ppORbon6hPRM0LakB8pG00fLjD7GrB_hGWQ_1755679316
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

No code call this symbol out of ethdev, remove it from exported symbols
and rename it.

Note: there is nothing particularly wrong with exporting this symbol.
It is just unneeded, and this symbol referencing a linux kernel enum
triggers a abidiff warning in the RHEL CI when this enum gets updated.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/ethdev/ethdev_linux_ethtool.c | 7 +++----
 lib/ethdev/ethdev_linux_ethtool.h | 6 ------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index 5eddda1da3..e989ddfbf2 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -133,9 +133,8 @@ static const uint32_t link_modes[] = {
 	[120] =  800000, /* ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT */
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_ethtool)
-uint32_t
-rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
+static uint32_t
+eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
 {
 	uint32_t speed;
 	int duplex;
@@ -171,7 +170,7 @@ rte_eth_link_speed_glink(const uint32_t *bitmap, int8_t nwords)
 		for (bit = 0; bit < 32; bit++) {
 			if ((bitmap[word] & RTE_BIT32(bit)) == 0)
 				continue;
-			ethdev_bitmap |= rte_eth_link_speed_ethtool(word * 32 + bit);
+			ethdev_bitmap |= eth_link_speed_ethtool(word * 32 + bit);
 		}
 	}
 
diff --git a/lib/ethdev/ethdev_linux_ethtool.h b/lib/ethdev/ethdev_linux_ethtool.h
index de235bd5f4..59fc84dfa0 100644
--- a/lib/ethdev/ethdev_linux_ethtool.h
+++ b/lib/ethdev/ethdev_linux_ethtool.h
@@ -14,12 +14,6 @@
 extern "C" {
 #endif
 
-/*
- * Convert bit from ETHTOOL_LINK_MODE_* to RTE_ETH_LINK_SPEED_*
- */
-__rte_internal
-uint32_t rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit);
-
 /*
  * Convert bitmap from ETHTOOL_GLINKSETTINGS ethtool_link_settings::link_mode_masks
  * to bitmap RTE_ETH_LINK_SPEED_*
-- 
2.50.1

