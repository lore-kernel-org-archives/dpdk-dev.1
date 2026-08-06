Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCCC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9DA84064C;
	Thu,  6 Aug 2026 07:10:17 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6EAAD402EE
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:16 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so1823535a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993015;
 x=1786597815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOcs7Z8q5wS4DaLqhrr+XdUrK+VcEBuFuyv7YSTOt0U=;
 b=fdOAPsKGPu8UZq0p/odOLOjfXAJCQWriKAarmkxxwm8+FYZOgRq1QY6FCxm8jK+Zzz
 wl3zK91nqKki+4Va3UvqgWAx12UqltmvIWls/dW8p6SUum1AjzshR0mLIvrrGV3HJcGh
 VxLtJcmhNztX/rYiXSVkqYLC2ef4F6R4vmb1k8Tv+nLaab1xlAVqax+ABGEE3ecEZezM
 cZxRWIwdQqZFTvxIm5i/OIzJOylDcTrrknHMucM56eIEqX6tsqb+kxjmulNwy8sAJtLT
 H4IVykR1MG+Nk+VPOY+Eov3w3eNL6TfFZE8SSJ8D/p45kM9RFw5DA7ybRqHY15ZJfxEi
 3QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993015; x=1786597815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOcs7Z8q5wS4DaLqhrr+XdUrK+VcEBuFuyv7YSTOt0U=;
 b=Q/kfpu+SB21Jr0ownqhUSpS9MX7BJ5KXUe0767TVt2rmkoddMEwq0GlLS/cvbvMTrx
 pJ7fXN9k1Qq2n1z64SpHyRYqHWeFNw+AP3vMU3eX12iRjp/xvzOgWj2ddW3WgxL+dX4u
 txA0ayP0ojyHAnDgzjvTkpbD3S+gbLENQDOCfCzYGkSGREbGzFf1en1e7WZpEMiMdeUC
 jj6XEyQ3z/2HkVfIUL0fbxXqnzQidFnB8VZAlphyyEGfhH0wnwC1zHZdo2YC2/Qm2dfc
 wQPm4O651wshk7Bhp/Clfeya77CD/ttKp91uvHdD5BSK+ZbFrX/WT3braDSQFVt0xn2H
 JQ1g==
X-Gm-Message-State: AOJu0Yy4cTU1A56OdTjZYJMH5yOAQ3UAHyyC9WQnKojZZPGWsfGiBwFG
 ow2VURmSZDYlmBz8fKT68xgiHJAwFFard3AyxAat49Fb+I8CNmVP6jdHwbd3JFPWxLY7yerIPuo
 AvQ3E
X-Gm-Gg: AR+sD11pMfxj3n6csQbh5WbfC42E/wMiXb2wYfa0psjZZ1f/aWNVRuwnm1iohy9UP7x
 e72M6a1Zz5txE2Xv/Weo20kteIsaBxrOGMExr/l6ntKMmn6nAH0VOMTv5XmQRFuyPOoN6z/LT/9
 BPR3dWyXDv7GbvkS8JPBjIldbxbLbXAb+++ll3hISYkoCxzrEpdKSPnFwOjXbCXAvORbbz8YgPy
 8bqjSPuv86s5GXVwRSy8zBqZ/SBdDuYQz/rdvF0jjLwY7nDGjJYR4Xtw1NhScVt2q+F5sHknB46
 IwfPKZ8dByGs/Vl+qnBLxbikxTE+zt6MonUcMAs3CpvhuIWUdkHRb2Zz+vA+WY3fPSf2BMPNQw7
 ol48PEDSHDLiBaY5W+UlhYZwQEEM3P6BtO24puY8M95G+sngvM1ET+ChTjMDiHRt9pcR+Uld3gZ
 XvH2RVK1IW88gu1CbNZP60jHbpK5mbFAasISq/v7o/pFJ5Fn5ecF9MP5tgt8xbFhc/phNGTmBpt
 DtHshHOnX3gj0oQEt6ABP33IeoJ
X-Received: by 2002:a05:6a21:6b85:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cb85dd6595mr14354988637.2.1785993015539; 
 Wed, 05 Aug 2026 22:10:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 02/23] ethdev: use DPDK byte order conversion
Date: Wed,  5 Aug 2026 22:08:56 -0700
Message-ID: <20260806051004.166778-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

DPDK has its own byte order macros which are preferred
over the POSIX/libc ones in arpa/inet.h
This resolves issue where this code was inheriting the
inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/sff_8472.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..e29711eb74 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -5,6 +5,8 @@
 
 #include <stdio.h>
 
+#include <rte_byteorder.h>
+
 #include "sff_common.h"
 
 /* Offsets in decimal, for direct comparison with the SFF specs */
@@ -176,7 +178,7 @@ static float befloattoh(const uint32_t *source)
 		float dst;
 	} converter;
 
-	converter.src = ntohl(*source);
+	converter.src = rte_be_to_cpu_32(*source);
 	return converter.dst;
 }
 
-- 
2.53.0

