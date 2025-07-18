Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA5C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 259CA40E09;
	Fri, 18 Jul 2025 18:32:48 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id E10B040B9B
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:46 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7dfdcded923so248890285a.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856366;
 x=1753461166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=kfhT1K5PXA4OLubmkPagb4hb5D603sDQEJ7eMtOkdRDNHFrMilMKLweJafO8WbnyI7
 qNY61LlyozRFnZaB9/uASlV0FKNuHVV/qsxpHjLOTCJFAmvA18U3u7hD+FHZfDWaKgaM
 cqRInppSHiox7TcNnZS3koiN1yxCX+hXM122UmCQ1qVVcAypf+PJSKiqw1a/BOljpuiD
 tb6ySqmLSGbU/N35TN3MI+rM8MGd/G7AgF9eFNIIUThzdahczDSKtBkvx6qLqvo0zn4Z
 ROGl0sJVjrIjHZqAJ1SjW6bAh9Bek/+iO+rBGXTSJZPC8kOu4GOm08YzzgwKqBCIEYlL
 K1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856366; x=1753461166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=ioGILX0JNrXKGJPSHSl2yd7sS/CzE592iyod0fIfaQ4iU/vuDjVzP+hCkO1fqj7udz
 XLpS1lUBG2L54OABPVlir338IUKLdTGX5C4sqs7VHHLolk9YL8KW4IjO4XiTIYYwJbTs
 UH5BzqTcvbN8Z/YxUJNQc6TQLnW7vXUi2kcAXSegGZPVsGMljRGTOs1HMArmRHmV3wSW
 3O9F3k2e00IJ+ri/UuuX2CS71wxROg/zfUbLvw+RasGXXOdAYOiuIX4QGGGg6ywJMWMQ
 Nq3UVH1jYpTVG8zAUZCNmdqqLW3utSKqP1qGxiPe2Lv898+nBj3sguhWldhxthAB42aI
 VzMQ==
X-Gm-Message-State: AOJu0Yxe8Xi2qzjiuTHrIIjIOIRyBfRsB5UJ8XbdTzpS6GQHh+W8CCqE
 dN8xCvTEHrlKBFI2ZzvxH6AeEYw2dxTUP7dqPw+XPjHJOb5jwKh9lhuMs90sfcm08THYDWy8e7W
 vHGcS
X-Gm-Gg: ASbGnctZ1y3ouRPOPu1y1jmdIeMXzlI5GOwxd35IFIJDUqwIlwf5/jq7VyG4DIb372x
 +L7ffefimNNicpqaLQ0IjCUZyUo7AOFV82JzHxpR9Js92ZFesF2tj0cYY8co5qZXPxvs7DmKdFV
 d4BV5vdoPW4RPpnROfLT2WxHx7mksiSO3d17m6bJj1R0+kYKLDT1aqXGZGwVfqYy9vVARkaUHBf
 tMdHiAEgIqD/Db8/eKZZEAWaHV1H5Wa7y7LIeUH366pbzIsYRapDCyKncN4ljK0w5ruN3jR/4Ak
 nzMDh/9amU9i93DJgJT3amGeZRwFk7FcA4OaDkckjxD2LMhExmyVL1Mk5X5ptec2WjoVE8NTlgo
 OkLwFIWpcCQjyr9gIM2riXd+QVhHb5iuvqhJEuZ5ly9dh+ZSopuzRAp2nE3YEQRNsfdPQd0ot
X-Google-Smtp-Source: AGHT+IEGxLOLPkbPFBqY40ev6X/GOqvqXzB5YInJU/Dq/IUS0Y4SvqtTpn1Bktw4wXy64N3MXLwjJg==
X-Received: by 2002:ae9:f00a:0:b0:7e3:4428:541c with SMTP id
 af79cd13be357-7e34d27598amr890186485a.30.1752856366012; 
 Fri, 18 Jul 2025 09:32:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v5 02/13] ethdev: make sure all necessary headers included
Date: Fri, 18 Jul 2025 09:28:19 -0700
Message-ID: <20250718163236.9870-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 184cf33f99..fffffe2625 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

