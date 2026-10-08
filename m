Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90ECA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE66C40DF5;
	Fri,  9 Oct 2026 01:37:49 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7517940B91
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:48 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-891d19d00ceso906807b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502667;
 x=1792107467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=IsXyFKllYVTyqXjPSp6eA9jTXAr7aHn1lN+B4otrtygBCroxRMXds5szLgCAHH0seO
 D5eqjKxL/iF3awjQGyTZ/SsiuvDfikWozS22atRIuiJRfUmM+8Yp1nH9LrSwUsQcWwE9
 6zE0TQ6CoiofuJrPmp+XJBoahPPhOJGJEdOHefBiPjqye9L0obM5fWjWcrcOZXJc+xAl
 e0VH8mcuS7Rc1dvGMlZWZxOAFFghMzlVdsuIBKqszT4GvfCiLViqWh/tJJlId9tj8VZK
 MyMkVIoDVzSScOHIXyMIMUmS/ihpsVewGF+d3oYviBLJg8iFZRkFBUsuayHWV4q57zbm
 cxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502667; x=1792107467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=RvL455ZfcbSMVpp2HlphkVLsR0pCQIvxRriI8XGzcbVRZg6L6hWAYhLxOprpkPxUQf
 s4/lGLtacrDG3pRQsNB0marZ3FAqOFJ5YzwrpG3Cy1QApEp/f4nFFMB15RT9yVcWX7Wy
 ExO5ZVCg/KcXSB+f4dJgZyfcg+BX+qma/UVMY0xhiVhV5jU/rmi/oyrU4+G/mdZY0Fc3
 GkfAdlw33fVWwIzNS4v3fd4OaoipySUvi2GxzwkLOPbFHbKiouFZr1/RNJNSAGhVauK6
 p2ZSc1FTC3al03Weaesr1X4lMltDhbdeFEmZn7Oh9MqbL/FsNTcsq/QEr/3kyRbcIq3Y
 k2GA==
X-Gm-Message-State: AFq9FYIEwEcST6RPLRlDpJtwomZikq5XI5rGsnb6fU9LQwYG0HS4xmEn
 ZAGctPrHnKyfyKuNNk8ZZwE8alxl4pWVVzGHSaS8oQ2LzlC8LSbweeBLEQUlb6UzOEtXl7eVflv
 j7tABZvc=
X-Gm-Gg: AYBFou3JKKr05U9m1pPkj8uQ7Y5MbndogOh5iz+ex0dDbPjKjHqaZ9e9vlFLdkGgQAx
 9/gBET/jrgHfoK1nG+yQWi522QqySYYLaSIxHNcaojcoc9j9h8AQQmVyTELpKe6coc9z9k/YFeE
 NId70qZ4GB5X0HXFBFPsZt0D3xI6abhJ9bSRbjX6hVZIoW7QeX15TVqPxOh57iofGR1NQ1WlZpY
 jT9mmWr5odfwIHbE5WVQ1q/73jGiyLZzcohaadKCXW5XTLNPsgoe8tZw4HPP9FrtL//pf7/idoG
 E+Hw1cgUuwxrAvn5Lyn4Llnu5L6ZQ9wKjktylMBlNj6QCn3VnWEryL0BvB72fm4zDfSu70300Y5
 5er5wlO0RPQEYmzy1WUF3lEFNEwfLoKFTOGRcYn/2E8pbLvCWN3ivzKtJiUkkxhQCoBpA/quSeH
 JQ7MWQbaeFMIUReHNnpaxWvhWwtdQ59AldrznFyOBIjNpvsJESm0TCck5lRP/4ysUfxVWAPzREF
 00jOHO6BHpMj4Y0+bQ4LBLPZNsB/VAYWTh+MQ==
X-Received: by 2002:a05:6a00:22c9:b0:874:705d:f651 with SMTP id
 d2e1a72fcca58-897c68361aemr54138b3a.31.1791502667624; 
 Thu, 08 Oct 2026 16:37:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 28/29] eal: remove stale SMP barrier in rte_service
Date: Thu,  8 Oct 2026 16:35:21 -0700
Message-ID: <20261008233649.1260843-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

Leftover missed by the C11 atomics conversion of this file. The
barrier pairs with nothing: no store follows it, and the next use
of the lcore is synchronized by remote launch.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_service.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index d2ac9d3f14..0c6467285b 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -795,7 +795,6 @@ rte_service_lcore_del(uint32_t lcore)
 
 	set_lcore_state(lcore, ROLE_RTE);
 
-	rte_smp_wmb();
 	return 0;
 }
 
-- 
2.53.0

