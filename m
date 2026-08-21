Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C36C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66BE540ED2;
	Fri, 21 Aug 2026 21:30:55 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id D3A2A40ED0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:53 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1760604a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340653;
 x=1787945453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D9G0tJ1oWqIcyTmPNFS5iY547BRlbfe0HzxhXeXdxpE=;
 b=HxWwql/tonl+k2fJKbd029ajTVk7OwsMZweyiZR4/pp6PzePrKVklNdVoZr/Ms0tB6
 HtFqiivR7EnAQpx8bOOmf7eOzJHbB81zHwBsLzENgpwrRKNJrbGgFQhAXIb3VihAriDo
 fHV3Aw4fhAxK6JPxnkfjEjmA9bGOnS5n1zC9yuxFFCWbnRsHIyhn7A5u19zNnpDxK30Q
 Theq1CrB1aTiDwVvAihSdhH6WDdhBGBPl9yFfN9YFDmcUuJ550Y0o47PCk/+L6o4QYRo
 GKZPkqCztgZd5RBi1HxvOwY9W5Yd7ym2W6fbcnYOqKPMBC6KuR/H8NmFlEfsuc4WfPpA
 DNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340653; x=1787945453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D9G0tJ1oWqIcyTmPNFS5iY547BRlbfe0HzxhXeXdxpE=;
 b=ACyaTorWzLpe7uMfoSpo2vgkbDdiv1shj97CtkWem/QaP/R6E82/zPmOSJNjWybjtP
 4LG1uOZ7SwX+S0sw+qmdJ2E4IL1oRusNDOlQE52luaxm7/87PxKF6amqX8ZbAqfKkp/9
 kyaDCxm/tunxFIqv1LQ8YwaYOeptIW+eecwMvE2qDr1voFfJBIWURAGg6Hz/LZKOwJLr
 OHtRfU7K24MNbXjpYvR0YZa8fnuvD5HZNW3TpWoYksjpr+P/QUl0hs1d406s0nET415F
 eIFU5iPGS3Qef7B32fMwL0kpWvS9Vxg6n0BQKhkEjyGW/zEnY6/ER3MMTrmcB5ZYuxR+
 w6Cg==
X-Gm-Message-State: AFuF++n4llFq/Vww3YPuiF3mXf7vrVeYDUNB/bxQd3YKunhCh0gp/adi
 BRH3Jmrla1rpvPzScnH19P/GUaZMURtcMKUqlwwVb3TWfV/t0gvWrWwatX8V6S+hmMi3+r4K9C+
 ZQcJLj8s=
X-Gm-Gg: AR+sD13340EkX9s3/JXoP5EzSXLw3TvANTucj2DBFCsd4QfOqpe1VQDTChkYtl8DVtY
 dX2GZcA4KGE/iIfdzRZvTthGbFyhUW0/5kJCT4TxipVixnR8lUBAdDM5jFPrdCv36ZBPjv5PEfX
 T1lAocLnd90uql5Wek75MZTwS2D+htu7t0y5eoXvTUwhLMm3Pj0qKXZkWTkIDmVteXX5FWkVQwz
 H/SJPt3hxlNzOYwNjdljMJg2CEuH827dOJ1+wn1xpDfh6/yNkRsd20j3FLwQ/WxfZz0C1sht+7g
 OiThVjykJ49oPTdhTNMf0g9/8nJdkL1hRjtk1XkOvnYIV/9sLZWtCzdCuz1gAtt/1yP5q/Vn72c
 m8XP8jkdDOOeWUNvol2kQ0GffLgJIEczZv5z0z7ta/KnB59CH0ju6gwr6OM65k1H0DZCxU19ldg
 ffws60Y3l2OvX2d0cLYB4rGpc5JRmnsK1m/cFzwwrXzV1bIidIpRpW7HXDUchf87ScAhYEa29ZE
 JMSBWz+Zww1u7csWTAAN3xU0Opm
X-Received: by 2002:a05:6a20:394a:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cd2fe7a34cmr15726651637.7.1787340653031; 
 Fri, 21 Aug 2026 12:30:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 50/68] net/virtio: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:45 -0700
Message-ID: <20260821192646.146382-51-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 9fd746b80f..62a9d7fff9 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 
 #include <ethdev_driver.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-- 
2.53.0

