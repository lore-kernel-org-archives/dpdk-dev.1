Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F5DC021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 823EA40A76;
	Fri, 14 Feb 2025 18:21:56 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5BA409FA
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:53 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so48789285ad.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553712;
 x=1740158512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7/jsndJQPNgEcWkkGfEfXFUukIP+mYcPxHjyCrqN8Y=;
 b=kN0fgm3IfAcGVl8eGJohzdKxv1lCBpdSKSkXERqr8cSbif7AIJ9Z7N+/7CM7jWlj03
 HOIuj8f+7mDW7Uc/999ncHaeG6catmriBnDCnPkJkuLys+i0ZWrVf6w9TYvA0Dj7Xzl+
 MTq8EK6bxc3s9gDpMEQtp8CK/lAsMBW8PijHytD8yL8VvMuia94dVHBpV1GwHhcj8SGl
 cRCCq7shHv7NyyWj2VWtNK2negStxQal7MKIWn2i5yYwgT0uiEAtcjhW8Vvt2+/PFpTK
 H5+8BDFajtivFA1qChP/ZDQXOT/+Aa7zMuD0EVk/Yyf84igUoWzrhmWo7a+Sa3xe2WcZ
 Hrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553712; x=1740158512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7/jsndJQPNgEcWkkGfEfXFUukIP+mYcPxHjyCrqN8Y=;
 b=IUizS16B1pHVSGhs/5oUsRsrRKRDNws0fczvxqep7+zswq8ypw7CqVXEICBEdDGS43
 Fo+/fFVGez/mePO4wrGZV3GEtUGqm/uJNW0jxJbuV7IxWOHZ57E/Fn4YydYjo/nTHoit
 71C7naXfaieVVb6KPF3cc++eN48DqryG7x6MHp8KjIs409UB/qx8mdf2LbVVuICw6HHe
 zAfL2+F8JrkyXcOatYRO3mSe7L9zLa1/oWeWMbF3PNglge0bzgFxSG4rcz6FdLBAjRiS
 ARkaZMsDjXsY5d0xYmfPqXUaoP+N5UontnbxJqeePkjRUVZ18yS3HkzuWOr+pxn2l/pW
 C3eQ==
X-Gm-Message-State: AOJu0Yygj5b+90D5pnJd7F+IPNjpQgfgrlE50RaXfu1lp3OOnMyQSXmM
 PVHNGwA1LeD7G5y85VAmdYqDg2wN6srwT+15MKuHNA0k+Lj2RUgBoSucVA5Z/fwuqHQuJUUjQiP
 V+YI=
X-Gm-Gg: ASbGnctK8wpDslfUjpHVE/27XXOjd+uoQiOniUDFiGfDPBolg5Egj3nhx7qwOb1GGlx
 nTVbbR2+X1A8zbNwjIgWKHGCMzClTuh9zzs3n1a/h8IkiOL0i5VCD9voaPaCIQbEEL5N9odVaT4
 dApXeBzFzfjRUPxMfWjnPVDEWwQEivpd3AiH6y3Mu5fnVH0fKcL+yyiSXgInoZS+HB3kQRi8p54
 b3yDNplRCq3dD0ZB1PhRlAOD9gfwemJByktNfzwF+HR5StKiW1EwoxXpdlF+dSTu0Yf1O8O0tvh
 eVQzICu8EbM6DkV+IVn+rdPCi1gnnoFdEihF+MGYCBc9gVGHyp0F2Elk/rzD0A70KcW5
X-Google-Smtp-Source: AGHT+IGa680d7Q1jIiNj73qmDzFqqViB+d1qvMcbhzUUjNFvTNIF5vSf8rDMOEQNLo2ZmKAfQI76Bw==
X-Received: by 2002:a05:6a20:a107:b0:1ee:650b:ac1f with SMTP id
 adf61e73a8af0-1ee8cad1005mr470294637.13.1739553712571; 
 Fri, 14 Feb 2025 09:21:52 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@intel.com>
Subject: [PATCH v2 7/7] raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
Date: Fri, 14 Feb 2025 09:20:15 -0800
Message-ID: <20250214172134.73908-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

Prefer the EAL version over local version of macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Rosen Xu <rosen.xu@intel.com>
---
 drivers/raw/ifpga/base/opae_osdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..b483d00a54 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -11,6 +11,7 @@
 
 #ifdef RTE_LIB_EAL
 #include "osdep_rte/osdep_generic.h"
+#include <rte_queue.h>
 #else
 #include "osdep_raw/osdep_generic.h"
 #endif
-- 
2.47.2

