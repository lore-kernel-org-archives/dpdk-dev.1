Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45921C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A803040E1B;
	Thu, 20 Aug 2026 07:25:07 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 3453140E03
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:05 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1892862a91.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203504;
 x=1787808304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gBXHErV8JSFvcdWaymN5xPsDfWQMtEc1RGCRMED+2JA=;
 b=BBVCsSRPKsGUmUCswzzh9nU7j6bnoXAbXZOCQVbbs5gRt81p7dBu097UZnimAMKyUs
 Rsvi+rKyD0V7pFKZ2ANdZEBXJdJLtg0M/NaMDJEsGPDL9BFFEioRYPW0dKAvI+BgSF5h
 BOunkudl/FvwZD6kWxD5sq/3LCn2SPUD+At0Wf0gqkq3dW5sAcahCWVVQQV4EqF3eMy7
 uonY0CT9CNjGXqYckkvGslkHi919liPJrixq5U8q8P2FcDCm3jOVLW0AnEgrgDS45iYM
 PAw4FVMve2A8LHJFD0m5TJtEI1ocg+pTYuacZF8NT2Qe108sk0cMOtxkkeLm69+rLVkE
 qbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203504; x=1787808304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBXHErV8JSFvcdWaymN5xPsDfWQMtEc1RGCRMED+2JA=;
 b=iLEyOmBeXOSJhfWcdsjI29TQuaryjhhX1PLfU9g+zeGOEdj+5PFqTaX7WV3TwU+Iep
 OWcwJ8myrCgu4xDXy8xKIdbIo93m1846O9yJXa/1JZgZCV173Cdvm3F0qym5ten5qCyf
 Sxu6vyTZbUsLlW+2ZH9dj/KGB3RGkrRyDVK3a7CkEDRJicpfufPOudt50FoYeJk0hLm6
 AwV/al3aiOJcGe11Gsj8ohj1lZ2Be2H4JSlrUXBe46+CeUnO9FQb1OtpHe/wvAm5zL5+
 KwgXNKQWHNvqCxWDDjckU7Ctw/ZoLCQB2biaC+QrSGmhsXWOexYTzTCnu1hw65Q3S6CS
 W0nA==
X-Gm-Message-State: AFuF++m7tiq1R19pwcSGiM0EhFW2TcUlFqni8Wm9Twsxjzu8VQs5Brnb
 Gi6He/4NB29ULGgtz8lB6fLa7Cw/LKoPOodS4XoNPLmc898dvpfCkixq4Z0kOCRJHfZoHb5tfqb
 us0/k
X-Gm-Gg: AR+sD10EtK34UUuhny4lZxqikyv7iRBLLvoccYZPPRmAACLPdmnopKUb2tk7Y47GvJQ
 7EdsiHOSWUI+108d28PadOlGgm9uzKmotOHFgvb+vkzCz0NrdFOJkbs2/Iv1umrXB+cKfoN+2q/
 nJbMISuBybxqtjln/acpDGNsDbs9+odgPBWofsjtqSVYPZp8bi9kmdxJ6cbEl2TSVhup7p3izkQ
 Eku/EiQs9zVXkJAanEjfGF1JEG+gC3P1X1Q23mXP/14NEHYQHBf1CzvX6+VwUcttCiXcHlW/6IS
 Oh/22tVJ6ZaOQHyhIOUUTFgTX0pNAMBn2ZTYdWoDpF8mFIcmbEUVa6yFl6XC0RYO6xcEMEWjdCu
 XppOgLmuwEjuS/t0qU2sHmWgxCmVJV7dLxR3n+K22BmeN3clOKxgNWBrhlTMjDpd0+ChR56xv++
 I2sk+lcaWXVDbJ6qe2fBJa3CvP5EjMpc0Ht8LvXKSySmg6SIHA+bSZBJlw1HgEiD+aky/xXPWaD
 eaV+/EFN67MTWy0N1NOwp9CBJI=
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-39580eafaa7mr20014803a91.6.1787203504303; 
 Wed, 19 Aug 2026 22:25:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 33/61] net/netvsc: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:23 -0700
Message-ID: <20260820052251.1453273-34-stephen@networkplumber.org>
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
 drivers/net/netvsc/hn_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9a193e4a7a..c1bd55e6b5 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -16,7 +16,6 @@
 #include <sys/ioctl.h>
 
 #include <rte_ethdev.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_devargs.h>
-- 
2.53.0

