Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4626DC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D8A540E32;
	Thu, 20 Aug 2026 07:25:44 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B222040DD0
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:37 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2507529a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203537;
 x=1787808337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D9G0tJ1oWqIcyTmPNFS5iY547BRlbfe0HzxhXeXdxpE=;
 b=008tleV3sOt582lzL5R3XPQfRyMwuVVc1ltThH8sANwV0DzihmMMm8Um8mZbpqHLjO
 10hVK9BCOTmXOM0r2vETFARz7EH15WCVxcU7Keuf/UIA/q+ziJ9pbFU2Hl16K6p3ukYW
 yLW3MHcD+7qlIgOCoVA7fYjjXCZQyrCxkb0dX3IXfmckwnCUT58Z5HrsdQp8VXkar9gf
 RaLXlPCVrPP4HQh0rOnh7NEPMe2gnmsJtwbgOljoGOZzv5wOfow3cmOcYoUV9yqMhXU6
 PcU8yzyq/eW9CaUtWPQ4KQLYe5dt9nyGVF5GMdNFberX4BR7iAzqr/zWyWuO8HbHd8Og
 uetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203537; x=1787808337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D9G0tJ1oWqIcyTmPNFS5iY547BRlbfe0HzxhXeXdxpE=;
 b=ACYhJ8RFxkhxozlvKVZySGebZMO7gH0jH9eCr7TulxoKKAX5mORsBapwEiZuIG6/Py
 5Cf02zTx7y8z/AdBnIosGEL4Icsn8mE2/PBcL8nesweAA0F7p5PVQZLLa2UPC0tAeuwF
 zIcg5556KNQQW8/3GLGdQDG3J+QsVLyr+u9kVsqB+6rpZjs+M5RlKptJVjcwKcjgvwG2
 HkJosCye8K/NFrgTjvaNwD0J6B8AuRkuInlngrkGgji8v24M8vHpV5WIinGkZDe0dfS9
 eBuQulPMe54bp4dwy98sVpoON6exXLC76hbV+R2okvfdSPX1IxhD7l5i1nD53kGzNtUS
 YERg==
X-Gm-Message-State: AFuF++mVB/J8zHOX/EJbcDEEfjPTk6qA+aY/iTvDmRG4BaU/lx1hoEWr
 t3zxIDpXJ5gFdf+PrSrkhP63xwlyhlelABtHsp6Gkjw9oR9E3zLVHRetJ3ABAUKMniTKgtikdan
 n26vG
X-Gm-Gg: AR+sD11tUC21trvAEJ1EQjzkolVYjRlRLbGFMLGLB/bmRrVrRn9aRB2fEOA3DPbY3rS
 Imwq2qUwcDnurRzYwvk6ii3ph0qmYrj/yQVx6ckbSUSGxznzMJVzV9cO6DKGYu8Ct0n1JKne2ki
 7SKLc2ouw2Nmadj5epqw6oy7t+6j5GR+DAYMrIdt1P3VbdA3+UsvgkXzVlbN2GM3G7KWgB+nt+p
 JpJAlPPpluTuoHte8BfaK4XIRCM+S3SIMpk+VEomqmJFBmXDKP+eezbF0oZtpGsZP2HszMXa3qx
 F/CUctkwRXcQgF+V+IODa1SYesXGCtq7+/GedJj9nlPqNKCBls6HLCDh+1CCvJj4pXSVI3A5CP/
 8jMbpole0Mb9rqu7Pr1RAk8If8yJvmjjp0rAv8Dwq2vEFGllCu95CZe51sssxH2Aqb4kBjSAgzT
 wrSXdnZmPMq6BNurKLYgDaPp/Ng6aEXxqt78kcaBnSY9BfPvvmXlf2fdaE6hZUbK7FsF7eCDzIi
 02XXoZwycjd8B75WdwteRSt/qY=
X-Received: by 2002:a17:90b:544f:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3958108a4b0mr19581087a91.11.1787203536880; 
 Wed, 19 Aug 2026 22:25:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 43/61] net/virtio: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:33 -0700
Message-ID: <20260820052251.1453273-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

