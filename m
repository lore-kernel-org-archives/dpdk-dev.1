Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0508C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA0840DD6;
	Mon,  3 Aug 2026 18:53:34 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 25CD040A7F
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:27 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so49995455ad.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776006;
 x=1786380806; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=FK9kT+Z+W+fmK+l9PX1wC2KNdY+vtrCYTJRGtOBmigGasRI/fZvplsaY1S2OyB//Ru
 8g59P69zogFAUmVDiaroAePr2r9zGGdB35VbNtNNAH1y4bFqzlQCIl8aClHtxeRUEolH
 GhpcGF6lNmVtyz8GtlCipYZKsu4U3CmJcTPtmdczseh/5S3dA4djaQDkLT3/A7ZTDzmO
 DYj4juYuwwAfTbiLW392p1Myg14VB4ErNtcy2f/QzUAjUvkhGRuk+dQkCMEdJdb9SAu4
 T43Iggb/BUxEiDFnVCAysawX6F+bosIVxDhdB2UEwevLIUVgyC/XdAWvB3PYRCX8pQf7
 Y1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776006; x=1786380806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=PSlQQNey53v4nqRB0bc+k67aPibhWY4JAfH6fBH1MbDL4eBYdPkEaH3aSADvMITAjf
 PVgP+e4DuNbW/mXVr31yTqlQlmVKcNXZjclnZi8q+cy66hCkD6UzD8x4VZ0udoYVvkjz
 NnK52DlAjaza9rS6EszPsZ5bD4Pf9whxTi/JGKGNZudsqOmOIgoxQNEalkIBwx8C8fiB
 3MKjnPjFWz3JrzZMHwWcmfrYp+QqhHirMGdPIe6KTTkRObyvZ9iw7ghBhn7hMAMoDw9J
 S+OgdEdZZDZRAkcwaQ1BWXAAV7Y0sbaRD3ptGskWpqjofPJGQHzTu9ntxyPC6dyt2TLF
 i7HQ==
X-Gm-Message-State: AOJu0YyyZEnKD2y7I7pj2eDdswZXf/hIk3OUqOatUfOwumKRLB2gcV1v
 8XSu+9Cy0ITYdpwGBOmYGjKUVEPMIKqrdIoKRo78jzcIxLa9Bko4RtNZC7z4ryuPFu5yJzfEpPy
 4yBgv
X-Gm-Gg: AR+sD10vouqq8itBVkhl9zAEytQRSN0yEUtcZ0diGiM1g0a0yS2oWLRkovsO6A6quQM
 P1a/J6ecEl1qn+o/ngKeZ3oiRMK3fEQ/OLamjsuvmnkbh0VM4x0wGPJhwy/OHrQjD2k7UzJTGkS
 tx7xXXIqTZSkjnOElyVQeNDhvteAMbD0COttaaiafNjsjU2oWH83pJMnvvzkVjM2YQdiw3G7Wok
 /V20jSII4NEll1H5UDUAnJogcQiFMfjYC5siS1Yu7HpPZb0v9Hh+ad7cj/x2tgfG8B56gqmX0t3
 t5fREH6GniB4jzuvH6CB6vfuWsuepJOOEAWWBTbRIGhnmx9wxsHt2LrnMkBdwCanmvG9hrBmVD6
 56XVHy8rt7QKFkw0j3KkppnRV3HObgs7P7WT1tDv12ewngzP32pEVJw3al1Nv/ApJEz7Yvg5QDQ
 Yudk5ttx4NPmoHlqjLeNhu/0nTDdgKLr7yJthBXoSj6+YLfPq3OU0x9sVCv9G3w3BIELPZf4k4l
 ZQtswD3wv3l3RzXg55/v2URcQw=
X-Received: by 2002:a05:6a20:c997:b0:3c3:7bb9:c93 with SMTP id
 adf61e73a8af0-3c92a8b625dmr10896970637.53.1785776006399; 
 Mon, 03 Aug 2026 09:53:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 19/22] net/intel/common: include network headers
Date: Mon,  3 Aug 2026 09:52:05 -0700
Message-ID: <20260803165304.289869-20-stephen@networkplumber.org>
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

This file was depending on network protocol headers getting
included via rte_ethdev.h -> rte_flow.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/common/tx_scalar.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 11ab6c08fc..dcb2ea5542 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -8,6 +8,9 @@
 #include <stdint.h>
 #include <rte_io.h>
 #include <rte_byteorder.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 /* depends on common Tx definitions. */
 #include "tx.h"
-- 
2.53.0

