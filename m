Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83ECD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FD7D406BB;
	Wed, 27 May 2026 01:26:02 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id B0CA140684
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:57 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12ddbe104ccso8332696c88.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837957;
 x=1780442757; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=zLelpZjA1dhsNBb7OKf6AjfvUufR39646wDZUH9TL0/OjuefD+dHyjcGzfRIVQpjyh
 2V2GujbEpXF/H2hLYrXzBbC+AnUAxbmybmhkmwuuFlQtMZVJFSWw6rpXKZt/mF76pQb4
 xWg7qV7ygs+xhnwJbFKwWdwYBe/K8jzdoz1EoiAMO8cEP0xE8RTukg4Ujpr2gMbFA/AH
 U04+A4qvq9BJZDfcyPn/g7AgrtBHWmfF8i2EX3uLlMohq8Pc0FjqVC5fZCTo2YkA03js
 VIpHiP/dBTWAHKO79vE86KSStYo+Lw1H+wAsSi1HtxxHu/IJhNqsrG3l+cEw59wgCAOj
 QEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837957; x=1780442757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=jVGkydO8es+40mgXsUfxFi6CKYu353sCdltILGtzpEY7SHWyFwVmQZ+2DjT2okpaIT
 sI0hc/MJipDzdH4h4FiRfDDvgXYSjY8oJiDM6P8BJV2s9S4APnh3llzVHK5kBSjSRBlC
 HrvbNkZeiW4j+405Jd7SN9taHs4ef33oByANhNHEznb+3rQ9VDddf6xv5CIaKjw9qYRJ
 3ghutn5rj631hdRaaJnuQvYSBv9jk1RpUOaGLlBzg7vfaQ6Ha0Toid7MdVwMa1OiZSNv
 NNOFJ3ZiT1A3Bc2Dj+/4+iXg4+RkI7knBnDaBBAPKIhR10vUND3CovWdbJ4UH9XMUiRy
 v+YQ==
X-Gm-Message-State: AOJu0Yx2JyUmO5y6vsv9U5XrHPcigkFxhx7bVIx1Nf24LvyuM57o/yQe
 inHeAFsgYhSh2P5siiXeVA+WHAqadIQUzM5c477nDbLEjT/jWc855QESSYM5lEtuTW+eVHwMn4k
 6gH/S
X-Gm-Gg: Acq92OF/CKZuRadxAOIqHvOBixKN2CeWf4vcVCsnye4Jan2g+TVMZ2AlUINWdm9mPId
 2YeXY8VLDuehJvpGxT4fA04sv6pnG32OYJnoCMBloUGSd52PF5ORL1Pu2zhhUsIrr94yu/cz49w
 ZP/tMCr6nYM/m/H/IUlYMZW7GHBQ820tnSlExf9aXck5BYxOtLxXj9A1u2xIdqxK3ZczMPXJAyd
 rVfBnEUAdHH89SdlT/0AZeM7mzxP+MlnlaWqReXsyeiNzYZEYsqzHbPZFYc3b47Ie5SCAwcgzZm
 v6OSawGRbj6ecgf3270LFMv3kV0fpGcTzJulB3gTGZPoMtusjXKa2WfG/R8JX0nemWWJeDbrZK6
 CiI7CAHhFjibIPcqiS9vfz9+5dYsiJDV+TVWetqgqyVuFOXHz2aMmadwK6GhL5oKRFrHINh7FAU
 /dIt6ciT5k9SLDdn2C8zYwkBFsfe9xSBe6YjlLVWIz1CDWbaqTMFQm3PqH9loeSvQxof3Ud0ps
X-Received: by 2002:a05:693c:2c84:b0:2ed:e14:7f5f with SMTP id
 5a478bee46e88-30449260415mr9807887eec.35.1779837956684; 
 Tue, 26 May 2026 16:25:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 10/27] net/pfe: use ethdev linkstatus helpers
Date: Tue, 26 May 2026 16:24:00 -0700
Message-ID: <20260526232542.620966-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

Rather than open coding with deprecated rte_atomic64,
use the existing ethdev helpers to get and set link status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pfe/pfe_ethdev.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 1efa17539e..1b183ab1f3 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -531,34 +531,6 @@ pfe_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
-static inline int
-pfe_eth_atomic_read_link_status(struct rte_eth_dev *dev,
-				struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = link;
-	struct rte_eth_link *src = &dev->data->dev_link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
-static inline int
-pfe_eth_atomic_write_link_status(struct rte_eth_dev *dev,
-				 struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = &dev->data->dev_link;
-	struct rte_eth_link *src = link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
 static int
 pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -570,7 +542,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	memset(&old, 0, sizeof(old));
 	memset(&link, 0, sizeof(struct rte_eth_link));
 
-	pfe_eth_atomic_read_link_status(dev, &old);
+	rte_eth_linkstatus_get(dev, &old);
 
 	/* Read from PFE CDEV, status of link, if file was successfully
 	 * opened.
@@ -601,7 +573,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 
-	pfe_eth_atomic_write_link_status(dev, &link);
+	rte_eth_linkstatus_set(dev, &link);
 
 	PFE_PMD_INFO("Port (%d) link is %s", dev->data->port_id,
 		     link.link_status ? "up" : "down");
-- 
2.53.0

