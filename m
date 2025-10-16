Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A1CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4BD4402D6;
	Thu, 16 Oct 2025 10:05:39 +0200 (CEST)
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com
 [209.85.128.100])
 by mails.dpdk.org (Postfix) with ESMTP id ACEE6402D6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:05:38 +0200 (CEST)
Received: by mail-wm1-f100.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so3002645e9.2
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1760601938; x=1761206738; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zTPoXrrja3eS1W8OYddjdqcxRb5htzHobSy4Qaa3pDY=;
 b=WjJFn9lAurF5Fb8h4a9fbn0emhTk6oT7nNiZ0m5K4xmpk1ExNFUISo4BmqFKsILfWO
 Yxo8VhifY5zVzUxCccR5iedn+xSuZsrOwB6KYjVVWzN20Us1XSq2iSEMXDQMGMHp4DZy
 XBZkl94nObFapKKwKaPMzk7siRBI65bo4KOakNDb4lsiQan1aAt/RYIJL6XsaZvkkD3e
 6tqQgg/4MXsXOcs1iBxp/KxCIz9F7Q4jFGU2pRSpwxM4qKc4/y1MYfMA+Z9BShpBgH5Z
 SOwB9UxdbnRc++gYRXWYNc5EtqVV783Z0K0/VbiNQojZdkh39fUsO0qo5QNdqbddBef8
 AZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760601938; x=1761206738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTPoXrrja3eS1W8OYddjdqcxRb5htzHobSy4Qaa3pDY=;
 b=UWsnfSinj2s34XVNWa0jBBm3m2os1YJwJs9KsLpVFtVBa28pKqhzPenrRIdA4nQeIS
 gENjuPdXtUHfCvaB1C0LRtKKZWuBjf6a2P2cHBuJT+XL23M44F6QOVQ+5M1+vt0w19wa
 mXhFtI7yp/qi0H+jbFQQaQ2sOHChNMyCiq/F7kEt1QrNswY5kS7DSX49yvZiB6RGeKkG
 n7tNgXp2WMVx89LkMbysXx2Wk7WQKTUz5e7yzDvdcek4X884WM0Mq+n294kauXQEUJbt
 RqIjiR/mKLz7YeARkmrsWtqv94XziWB9yrQnFKRuQ+BHDBmWvSozOmQzFYmEIFe3d3bh
 jEzg==
X-Gm-Message-State: AOJu0YxF5AFWWThWEW5aiIAVD1Qz7YNo3DvFvPyScvMgh7sJO/lHMFA/
 zLqyiJfqi747mkts6bC7b6fvYd6G/F4Fj9sqbNJb9R2EM0CKWPLWHxz3hFHf4VwVHfy3pB8KcZc
 4VRFbJoSK6us55rJhEYlYlCZi6iJCSGZUtuk=
X-Gm-Gg: ASbGncvkf2Vo0Cgpukw0uTIxZlGTShMsjyV3Hjc8F4aR9AMhbbGKimRIEhkmZWRsrM8
 jYkmT0quhfMVbA2IkSN2FD/aFZsFvwWhwPZ4xUaOoIb5N4BbV3wJhTXXNTzb+228g4WtskFLf2R
 PukDrIkAWl18wfRc0PKUWj2MXqrWqTiTlfDB3wxmGMub/6/ZDibwd6O6qDDIPCBp3pHyQbYn9yP
 Y/fDPE3K7txLEpmwZ6suqpkjLs6ls7L3OMI1G5qlE3rJlzcSYeOoZVb7rPxgdrzaldA+KmAewlz
 KAHAmMt53+dx2eP3mlzCrjfQE0oa1cFn4QD6miMf+QH1mcn/hzaRSL/2gHrNev3kHOagOWmP2G1
 jQ68eDC8ZFJR2RuKehWqX3aDMk+qp07hCSLtTXQzAVouX8hDUMc/aXw==
X-Google-Smtp-Source: AGHT+IErG+Dy67gqvk5kqBCTNZ6vCnNlL9m/cxKtssAo/ImAxNQ/igUWWZ1pSaPS04/JoYmxO0Htud5G/ZtL
X-Received: by 2002:a05:600d:41ee:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-471152ae95fmr2243225e9.13.1760601938068; 
 Thu, 16 Oct 2025 01:05:38 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-47114459d3esm324955e9.13.2025.10.16.01.05.37; 
 Thu, 16 Oct 2025 01:05:38 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id BE99F11FAC;
 Thu, 16 Oct 2025 10:05:37 +0200 (CEST)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH] config/arm: fix inconsistency for Neoverse N2
Date: Thu, 16 Oct 2025 10:05:33 +0200
Message-Id: <20251016080533.535266-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

Configuration for hex code '0xd49' enables two NUMA nodes.
Then, the corresponding 'soc_n2' should allow 'numa'.

Fixes: ea85ed1f6882 ("config/arm: increase nodes and cores for Neoverse N2")
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 config/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 665f3fa38fcf..316f23941996 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -590,7 +590,7 @@ soc_n2 = {
     'description': 'Arm Neoverse N2',
     'implementer': '0x41',
     'part_number': '0xd49',
-    'numa': false
+    'numa': true
 }
 
 soc_n3 = {
-- 
2.39.2

