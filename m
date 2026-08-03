Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB847C55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15737402E2;
	Mon,  3 Aug 2026 18:53:11 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 59AAF40269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:09 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc891373e0so39438965ad.2
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775988;
 x=1786380788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=ibKIIvQcKEjHxA0RfNOgbkRiZhlk81d2aHM12LdAp/EqTBQ3xmdxKyHHw1XggNS297
 PRP/RJziFxDsJ+gVDpirgZK94VC30vgkaJDbJCoP987i72NkYDQIIeGJpTv3MVqcUOBB
 6ENKh42VDgwpnrSs/Khx/kqpFi1o4hgDKr0VMsnq4BJSeHc81Ea6kvtNiN9V5smWIQIj
 2Z3/u5jV5Nvwyv2or7Fn6dT7VSBJUroxivnPtrWDY3SEfOhbYtHMQp5CaDMqR1hXDCjF
 0mWnRGJXFUoEeOj08cXzcb6/ywDgBuxmmtuvszZvcwFerZcn2Ppwk8MSL/Qtjm7JCS4x
 EsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775988; x=1786380788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=KmWv00M9KwJhVx4/TlVfs8GKcCTxFgJclPF8zMlhu5kjWe0gJ3oConTTDeSSAOt9eZ
 7WN3i5G+TFG7t/f0pHE8OOhv8F3Fr/2/PHQYMtwQwNFZ4r6M2GzSa2/TybjjAXza0fNP
 JEXOnBATwImM5oPUnvlteElc7nm5bmJcfN7NcIUSvr6Z8iMKeU0dNcNHmehzdDZ8CFGy
 xOcM3N2EO0p1AJ/gtVYKYjY2BY8Xh8iyP8AaSgwVQlDBbBw/kS9zcDpVf+I/LHyVlNpp
 bRXJss7XydXn0WTeAgFmquKTbtGK3wdLyjcl/KATV3gsbvBv9Gdxa5XXLXTHlW+mNAX6
 Lzkg==
X-Gm-Message-State: AOJu0YxKSYQBN/cf1AWafZ2oqZCGaHmOl8OeVBIoFXU8ABLANb9MTCjB
 mGovxUvzFyS8+nXsaLNuOkhA0fDUULwA5990s91oX2XQOA7KfItuWCtUfFfFIih98kd7URA4G4h
 JL4G6
X-Gm-Gg: AR+sD13oKwEFW4ezfN6B2U8hJHjFKqGcS1nCAKNOZQym109x6AApIvhK7yNJSD+f1l/
 P54wUnDqnSVaGNQyH//lCvvlhG0ExXMR2cm7IESDOJDUsrHVtKZuY8djtYeFfVfa9vLPimvIXlq
 VOgYazjenciLV3IeOQ2xbE9KgkLf8oam2vKAl3igP3D4W7xOa7+/qq7xL5LRlpfAkQ3EY585u4J
 uu7j0wRoqwClpK/s+AmojiQG90XajaS1Xr71RdxQluoYlY/qHqts6b3wSlO3uRS0p0iz39ZEOp7
 7w5liM0DBY2C6P3c4fCtj7fuzSmJNj2W595QxKC4PgFFYhn0qQkTs3P0/OmQFhdl5FXSOEjmNvm
 hkzRZ/TkQTYhkgMkKuXYP7xMk1PhgyNWuZS/J8+wOLfAKSkgiJ2rhBT4zlb4pMd6jaS3CkcIpIJ
 RmaMIJJL0q88f1ajlgKohpoax27UoL/owzzqrwL9tiwCXPs9U534nP2pTtaBQEBLJIxLwAvi6Tc
 xvyWpkXgA38hihisDWVlMIPp6g=
X-Received: by 2002:a17:903:1a30:b0:2cc:670d:9b2f with SMTP id
 d9443c01a7336-2d052412606mr116824985ad.33.1785775988028; 
 Mon, 03 Aug 2026 09:53:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 01/22] drivers/net: remove unused include in dpaa
Date: Mon,  3 Aug 2026 09:51:47 -0700
Message-ID: <20260803165304.289869-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

rte_eth_ctrl.h is deprecated and its contents are not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa/dpaa_ptp.c   | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index e9b332c571..f91d3f9ce3 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -9,7 +9,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..77d5d82b44 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -12,7 +12,6 @@
 
 #include <ethdev_driver.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
-- 
2.53.0

