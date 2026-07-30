Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0190C5516F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 15:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92C5A40288;
	Fri, 31 Jul 2026 17:56:33 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1EC4240272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:43:14 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ceae1ed204so24481905ad.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785404593; x=1786009393; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IpBn96xyE5N7ijOni8UGXaKgxohTrh26bACtJCf5JI0=;
 b=nfHtvXuuRKwn0XnxMgTXyF/yhrP7zDb5lovItVdA3zCXibajrEyqQL4TNChd4phJnK
 TNEuqPefKRCmRfUY3uoSRp0kItPoOoGhuUTAsYCDhPwBFrH9xPE5lXCdh2hSsynDeZ5J
 cCD6oLsE4FR9O18Bm2dqf5A8tt39lSruXnWdZe7pAdVO0D6VQsbuuVmdv4OqZMYF4iEI
 U3cWWED5xhLiF6ek7pRhMzFWnSjrfyHWIvIjH8jG4l3OUYtCM5hcDYZY//1g+XVkO1pD
 py6ozBbWGQgSddoVRwJohgyJEvYL3fqYMTauaghqdN64Nn0uA31yp9NLf5HT+HuM8fxQ
 iIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785404593; x=1786009393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IpBn96xyE5N7ijOni8UGXaKgxohTrh26bACtJCf5JI0=;
 b=ga/wmro7RxQjGIe7Z6bYbvBqk14kRopFmdOlwHIM6My6WdFXCIjq7f7OZeUj2hwOrm
 4H9uYYihUKlJUXH7R/doQ6WtBZs4YOe29CrJD0kXRAyGq7xN14WTKD58U97XD66GAc93
 xCUhDqMU/MWTZSLsLNY7E+ynvRWVhXsMWwLtXpEFEjlILEJNHEXQo5CTilMgIOYrOymN
 yikqa+CYRJTiZerPhxpXB7fabS/zjuzjnkfI8xH2QRvJAAR32My9TkyeSx65KRZ5As7/
 9YN9leYFcis7bkloyQQ8aKMuGqnTHnLRQ/Gyi5qq/eYVzzdmDCrF8wHOYP3TJDlnFSn0
 U9Sg==
X-Gm-Message-State: AOJu0Yw9LWWRgU7HLWHg3eARdTn0dg6g08RhWTPGmDWV+pJf4D9RuAg8
 t3XAke8wDtt2lHuDLSnZtc9wxZcsjsJn07O0GNNN9Ao9mWyN5lBilCzZ
X-Gm-Gg: AR+sD103iA4HsfER7LBds29EYRkC/hTt5ZJXBCUN3nmttOiJs6hH61BX1DfPbhcFl2w
 s0viuNhmofp9XUVDP99wq2sW2KvenkENGvsfqNB5W74KmUyUSw8iTKxPocj63NyBruubgP28NmC
 v+Yo2rlWxvbj9BDylUrvGsWL7stsfUrHk/LiGuI3B8mD7eVmBAmtfi1ttaSzpm6vzILetL8N99e
 sZJ3xbwdyLFdF0U6Lrv/JvjmeBqpOG0fQjzugYvuTSAWXt6E9v8tvCwARdHqGvB4kLcg0bQLYfU
 L8fhir6FtRuA2bJXPdaHVKwHiV2+0h5G96n0hstALw5Tga9FG0MxithhlruijIt/HguM21TzOFr
 dMVrVzyrFy3j4usN3tuudRVDIQl4YLLCTu6tk+4TaOMftR+a9VRkZY3J6tIjPfZ6qbIib9fZX5K
 ULidCvNpLWYdyUpYkiD0Cn3AZRlkn1FP9DVtftUTkuHKHXqvvRZUe62PkEM0M6RKIpEl7m2L6at
 26WLfcQsbubk6Rx8zsL0o+fwWahMpqA7w==
X-Received: by 2002:a17:902:d4ca:b0:2c1:ee75:56bb with SMTP id
 d9443c01a7336-2d035bf4545mr17962395ad.20.1785404593060; 
 Thu, 30 Jul 2026 02:43:13 -0700 (PDT)
Received: from khadem-VirtualBox (mbl-65-129-4.dsl.net.pk. [58.65.129.4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d3c68asm21637323eec.24.2026.07.30.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:43:12 -0700 (PDT)
From: Khadem Ullah <khadem.systems@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Khadem Ullah <khadem.systems@gmail.com>
Subject: [PATCH] mailmap: update Khadem Ullah email address
Date: Thu, 30 Jul 2026 14:42:49 +0500
Message-ID: <20260730094249.74189-1-khadem.systems@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727062821.42394-1-khadem.systems@gmail.com>
References: <20260727062821.42394-1-khadem.systems@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:56:32 +0200
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

Update my email address to my personal account for
all future and past historical DPDK contributions.

Signed-off-by: Khadem Ullah <khadem.systems@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..efe57990b6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -877,7 +877,7 @@ Kevin Liu <kevinx.liu@intel.com>
 Kevin O'Sullivan <kevin.osullivan@intel.com>
 Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
-Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
+Khadem Ullah <khadem.systems@gmail.com> <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
 Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com>
-- 
2.53.0

