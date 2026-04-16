Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1FF8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3F3406BA;
	Thu, 16 Apr 2026 20:51:53 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 4B84840671
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:51 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso121878c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365510;
 x=1776970310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=Br9oKUGYyrtL46RoU3c82znXcY5104v8u9i4Y4MJe+O6x4ffIXppRruxKaYVDFit7f
 JA2wSnVGz4wkwIcTdLaF1ehJOzmK8ad8AZ8xf/f3HtAlmfHKCyl8Ve5QTOuAa9RV0xTN
 X6jwlWaIml/XfsoGTi/tpWlx1JycmBTV6e6ScJbUGMq1Niyf/1Ila0s6zcfnJc96XVTj
 t0GR9xZcRcHGWewtqILZsr5QPgW325+Wc9b9BWGVdKtCBwoYNQ4tfdbs9QAN2YaRqzVE
 9tCG1yfoXPZyScFM+K+0csOoZmtStJ20cWwe8vyOh1vAlBgQJERt3AC08B9YAznIg1Lg
 Xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365510; x=1776970310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=OyquaI6GdVHzFtT0fEASBicMtDyPl6H6R6srXupmYf4R+00B7Q80LZS9fyps3ZbPtl
 aFd99lFwpnILtQN4qbd/fLcLXjgHrQ3umCVWc5YGBQ3ksOXjQGwSd74ooePoWdj8Jwos
 vimRNREH4Ml+xTcA3aLQ9U0X8f3MU2Mqawh91ZeImWD2BtyQI0d2Ibu4UVxYN4mfO61P
 50HMw8pNnKVLPuGwScJOj1PVAIBEqIPD3QusYg9xULMnxLq4JEyDoOLla0NVnOHiA2wb
 piKom24WaocHhnNb/VrhxgkwrQsfKLwsZw+9lnv1bWw/j9OXToY/el37fnwZVi5nj26x
 pxsw==
X-Gm-Message-State: AOJu0YzJ+j4k4TVsaWqVl0ZgjMmRelnNQTsv8lt9mAeDKtnyqf8+P9tN
 /qDDRCi8e8SV4zRG1Y5sGXG5Aa7o2/Gq1l18lZoVOlW87QcFZZOOxoyMRNRgCpnNQwCgfN8qYzB
 maCV0
X-Gm-Gg: AeBDiesfQXPpR1242ui/ZtAGTCYqkzWiJZX3YiIbklbgJzni+Ab4LEs7cjAkGnEcLjE
 e4PNCdgQtpmOonWMxeW5dGKuKstbTqOualXTuwcN5iQ5q+NSyRGi1hCs2fLgsZBPmMQwMufdtke
 EQFNHGXIvc+nmGOMWoGJFXySDeM2+vjckMRPSWDMLUF1JY494q57VZUfye4GDci3EbrF9fZL17r
 qqzzVZ4z9Pr8Ih4U0OzF17WiMZN7bblY9CMmznZYREFY406yAm/uTm7bza0Ge6bYXIw4x9i2R5/
 LVqyieMXI9ujJyixHzxh+ApIip7aIT1pBiVI1YQ/53934M0s4ThxQ9FsYfJ1XzZPHHGasqglIxk
 fcBjNXqZf+RClJ9g4LCJs6iaGyff6w01BiUTrLhElDlZFwLvdCcV1z/TSGoxgt2cpnLqi88d+6f
 MKkrB9fxRkhA5D57DqXWtjEYCbZTDk1pqHFi4vUs5LFeE=
X-Received: by 2002:a05:7300:3b06:b0:2e0:4edd:64e8 with SMTP id
 5a478bee46e88-2e2e64e1b78mr254242eec.24.1776365510384; 
 Thu, 16 Apr 2026 11:51:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 03/24] doc: update features for PCAP PMD
Date: Thu, 16 Apr 2026 11:48:20 -0700
Message-ID: <20260416185144.1359260-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

