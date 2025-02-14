Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59985C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36FFF40A67;
	Fri, 14 Feb 2025 18:21:54 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7F7E14069D
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:51 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220bff984a0so40906465ad.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553711;
 x=1740158511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bul09VnJ/fuCMGh8j4kRd9FN2i7+3mxIBTXunzK7rsM=;
 b=sGYgXytiBJfF7fQrb5QgYzjzsLdba2G4kOqTBfeh9lmCIqZCrsfoHQITpdgTyR3xpW
 btwzwBFo0G2StLeaAfojJekjQT3NcuETDHXwDhR2o1RectyFWXXhgFKMFZPm67OfMkDw
 lSkVEf49SNTtf/t3Kdu7MSk16toq7VpY30UjIxcPE2GqgOGOOAf+g6t+9+8LusOoquIM
 mxnwMavbEvXU522AAywSvlYxpMY+8luIzaYfxJ8nUBqSovf5TYsWQn5vDWTKCX4jkHAd
 3tlaWFmnIRCh5vwORx83Og89Ws3mMz/Fy+8uc7E2J2oAq4B8SDRy/lM0X1OPYoOnOrac
 Lfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553711; x=1740158511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bul09VnJ/fuCMGh8j4kRd9FN2i7+3mxIBTXunzK7rsM=;
 b=UNgIyYKMmBp5gUTLmn8vzWp6OmREc3E9QAOvqKULwd9QGFYq2sfBBvQzbtqQnAuydc
 ZPw88XTOC5dlaac+r3YHEMiHiEVzJSf7XgpMc8DG98lk8Ub/MoDR4yl74uk2P0wosxU2
 GnbX1ow/NawujkRFDw0tQmOqUrml3m/7hUvs46shU081kvqehaeUYcOChexGm9U5sBNt
 SRTNLjOo7Bop4G7yuYeULJ/cJUPblzm6ZZcCYKYNfsp9Xf8KEep/3l4xt2l32Lfr1YNB
 JHEUPyEaFb3UhoRkvtF0WJwivhz8cyKNzKPH9JGOQjkbG9pUsYrmWqWqoD0ieFIsc8KM
 Oyag==
X-Gm-Message-State: AOJu0YxfISr/L6SemhwpaJcnv+yG4uWIeSOfy1eKCGewSOdrTWIPJjcF
 6QzvWgtYaQ6PxUjFQpfhJf4+f8NXS5ABDVeUtJ1IJl2hs/7DcaoJ0JaJsnbYb+pmNVmAPGcGshf
 z/ks=
X-Gm-Gg: ASbGncuupkDlGqS6WIw4cSTp5s3lwKd8Yj7dghgV2bUMIhFe/WGxDXvQS5VMWAaoafP
 ahcW7VjNKbiA8Ow+ewVvRqqY8KOE8e0kwyMswWDiIlfzkVQa6/nmPkZC9NmolHGhsBNWnQskJs1
 UbuPR6DZn5QeThfp3sscABZL50beFoCAJvhANbg2p0vYfyRp6cUNMfNcjRWXUyFtLFSaDbWb/5L
 /t99Gvx0Ru6GAEBOdsRsz8D4DZdX+cOWBCiFa3P9WgJxuRgfjAsx7QTVAHOnVbS700vLZ+Fe+m0
 97t1Toj05W8OAFv4okAr238EnVydVVMKj0GJF4QKw1H3vnc2mu+0PyXS6VT54jXjbvLA
X-Google-Smtp-Source: AGHT+IH43Hkzuox/BDswWM0JZFc4pET8/lXatCrAaFwTXLNGVRt/AijCeV6FvGJNK9ieYXpv4l4wEA==
X-Received: by 2002:a05:6a21:b97:b0:1ee:76fb:8eda with SMTP id
 adf61e73a8af0-1ee8cc4ba86mr450175637.36.1739553710747; 
 Fri, 14 Feb 2025 09:21:50 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v2 5/7] net/iavf: replace local version of TAILQ_FOREACH_SAFE
Date: Fri, 14 Feb 2025 09:20:13 -0800
Message-ID: <20250214172134.73908-6-stephen@networkplumber.org>
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

Now in EAL as rte_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 6feca8435e..0b7c35250c 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -13,6 +13,7 @@
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <rte_os_shim.h>
+#include <rte_queue.h>
 
 #include <rte_debug.h>
 #include <rte_alarm.h>
@@ -52,13 +53,6 @@ static struct iavf_event_handler event_handler = {
 	.fd = {-1, -1},
 };
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
-
 static uint32_t
 iavf_dev_event_handle(void *param __rte_unused)
 {
-- 
2.47.2

