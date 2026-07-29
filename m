Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B1C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9494B40B98;
	Wed, 29 Jul 2026 19:57:36 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id E09B840664
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:30 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1015856a91.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347850;
 x=1785952650; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uc6CKTt4J/rs+2MByFfL1PislzEC7x9D2Hb/MJ7FE4=;
 b=iTeCJHffBHWHQn3lcQ4+Nl63oexXYKL151Cvd9KKw0RZ8FB/LmW9jkmPZA8dGyJtJz
 oNF02EkY8TK7UZimuiVjOzgU0fFbIHPJOi2ZRGEP36LaLNcFlBTi3Ff7AOv6xi3iXSYd
 jb7C3eROQNbubpjaDftGqq1b6b43bVx86+vC9093XGqBtt0ODTMaVq+glN6yZ8WI0GiE
 xU7phuhQkbL6TXkjJTHIUqFNJlSJWxQOO6rEMO8pBkpivtG0kotnkMX9pvo3cJ0pkahh
 orO1XEYOIofURRsGkD0T0zqalh6gdOyFCTJYWMt1jGEQsJIl0OjeEV6bh694prxDhjsj
 sZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347850; x=1785952650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8uc6CKTt4J/rs+2MByFfL1PislzEC7x9D2Hb/MJ7FE4=;
 b=M5pILK6JDdigqOxXvz3NqYst09Httm4UAl7N1BD8ytMPv7cIGcACEA4jJAuqMOpaJv
 cjRqD2Xxrar3K4+gae5XTJgiXBJ84KqpOzk8Jlo58rUeU01HIb4lkzxpa2sRXTDQqlbe
 tDmpYQ04oUAPLIrNgF6dBu0MSGRpFYUm7BJvOCbMgJ671897rZYtLeDcQljW1hzX7y7a
 jehJLZldyOjedDpxlgS9BE3j8CZTahTd6OnshvcbDui53CU1LtOYjpKmSTfnL0PO3dwd
 kAZCeWWYZ+Ex+4aUmvHyUbReZghDKsmAhK99ZLH2corIXg4F/WwbH8V91P2SMRqaltD2
 LZhg==
X-Gm-Message-State: AOJu0Yx6egv4TUoFeMQTEfPBQ5RFoT8uBKSi6NQ0/WbJL8A+xKxEQagt
 ffKzxqECB3r0H+NKY1URFLP4nyMFqojA/OufRNQzWLFFSRffICpFc6LzKwcLNFZnBRWKt8SM6OW
 Ww2Pj
X-Gm-Gg: AR+sD13Nr197X9r8hpKm88BVKnhKuyy4nlVMVNs/N3TTRhX3sGTbWSj2JMIc1VO7RHz
 IKACnaiLQ0cZl2La5i+tbO3uzF591O89uFOmyphk+NQQNRPSM7n6N9l9MQbU+ZXyyTEg4AR/RG0
 dzHAII4nHfuov9lUj9doHbrGGjoa8K+4dDJPSgDAE4ZXzkbH4PpmKG2nEmlAO9d2Y93m+9X+eDc
 jfoynmvclXPEeCDekv1rqdDpE0ToSJazDwom43J5tTvriqEDf5jLvS058BdexvW6kTgD4+S5ctQ
 kXThtFcxOUgpDvK57fOohaxVbvp8CFHBOajyKUY6Obo39fcpp/5kiKMudPEQ8Ar3nmjwoC6+E3M
 ySNjkiEd4oMPM1Wg7T2zzxD/6aIEjgICQIUrxTFRy6YkdNfx08IQ3zFfybC7KgTJ1fD9ibvOQ6C
 55ZkAMNB0dX0a2fWpnjeEdSCt0OorGeUFZe/LkHKZYIw/0LqUoz8cspsuD+F0VFDIdHxhC+1MOG
 spQTHSujQzMc68aJnWL39uwyug=
X-Received: by 2002:a17:90b:2747:b0:37f:9ce1:735e with SMTP id
 98e67ed59e1d1-38f6a57fb65mr7967359a91.31.1785347850096; 
 Wed, 29 Jul 2026 10:57:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [RFC 11/32] net/thunderx: replace rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:04 -0700
Message-ID: <20260729175715.165120-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_plat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..7d22563035 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -26,7 +26,7 @@
 /* barrier */
 #include <rte_atomic.h>
 #define nicvf_smp_wmb() rte_smp_wmb()
-#define nicvf_smp_rmb() rte_smp_rmb()
+#define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

