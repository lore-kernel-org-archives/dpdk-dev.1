Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D59C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A843B40BA0;
	Fri, 21 Aug 2026 21:29:06 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 44E4440B9B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:05 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cbedf6a6fe8so1038252a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340544;
 x=1787945344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0L0MVUbnBnuT7NFe+zg+190J6RTfm4NeMhb5b7otfrs=;
 b=rEJ3MEG4Nt/UFFFU5fFj9bfcLJHLgqWGtytF58xmro7GMoVreOTC2AVWnKZvrYa11l
 4h8SxfPsYgUJQHnsIxV6aSN2o9CX/R1QyBcuGuzn9TMI+/ghxYQYap7IRSKuEpiCM00+
 PTrsFJbF/CU16H8bY1yXT1ap0n+bE477AnFqGfMQnHYk8iwfTVINteoDJXXSMEj4Qgsk
 WP30WLKbN0KyKHN3X+M53lzYhdtFgYV5yOMPfvgpPTZrWqM+yZSmqT5Ivh2IyRLml/T8
 oK+5PVbIpeiT6I3XXQHy2lpHh95SK0iFtjfWuwRnWsbhiSJYrfOhj6cy8gsQQiKsujpl
 zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340544; x=1787945344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0L0MVUbnBnuT7NFe+zg+190J6RTfm4NeMhb5b7otfrs=;
 b=kdzu6c54ZS7zLu/3LJRxSSiXk5SwynUCbyhYdQGkX4GZaGZF8mHa9oBnAwRbVS3Ad+
 pQLk5sbvuJj+3VIPUd+tXEh/eOYIGzyDb5V+a86hOtER483ERW0c4OEIkrVnUD6IvSFr
 3pV9VIfu8kmpDGq94H3sNdC4ZbT0ghCXY1C+AibySZdVVNoBkk+Zzwd2ajATK82zuQCL
 H9pn3E4IR/hcvpBbw5I5EJ4dXCBdHbrzD+Dn/tElMuG7CsYhlG06gSIYQ2YtyHUlVydz
 EAY6Uhj1n0g17dLx8EQuwgqQlRl6kbvDi9d5wsdJSJuFCvIANp/RZx73/cq4WMJX4+M/
 AtKA==
X-Gm-Message-State: AFuF++kHko/rK7vstScvykx0bzuJjVx9GhHpz2SizFxFB10vt/kXeFq2
 DBi5w/0I/ShX3qI4aAizjvqyZJcD9Zf8IxamzSx5D4r66Ry+qguAqKdAN5S89Fg8ZjWWS1NLgrB
 o1e+S
X-Gm-Gg: AR+sD12IQlFusi2WaTcf/IbeL1HWKVreHLJXmSoHM9rjv/JqXkvhHYo+OEhq6LurpuZ
 evOKqJykd25rHynPiMuYZ78jcycjAt1L29UUMb+hOuoeDFhOSiWqkRpdtM2iGBi9aPkRFC4h3cU
 KZ5/PE3OfbcHf1hy+1tg8GBFS8cAS3zeBn1qGK31Sx3EyYBFTYXWYRPhO8knnYvIU7Ype5SmMNF
 JhpoUwbg/uj3JuXsoljq2JpsTcIXiqoSZ1H4bWey01cLpBB8ffprEfdXXrVmm+fN2eidmlPPnby
 nddEkPt/USFb/8EMtgg1XPxb6tCfp1IzXG7/z4lSAPqty7aO5isuL15IDwzZ6NtrmiShnrfR6Rs
 xjRhxg0z6hGJMhZI938nngNRLH6SccmuM3n9sNP1RqhbZJQiKVHlW0vlOwBqRJQ8JjITgcX4HXu
 F2A2RUOnolSrZB/lwoHiNZiQ2erM+OZPwl00uqiW6VHqUVR7zxhZkhtEzQ4XsqO0Tjl5D5IzcQa
 bzj+46IQevNRHB33+RqwHpmK+k=
X-Received: by 2002:a05:6a20:e212:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3cd4bb987ccmr1775384637.10.1787340544436; 
 Fri, 21 Aug 2026 12:29:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 19/68] eventdev: replace fixed size rte_memcpy
Date: Fri, 21 Aug 2026 12:24:14 -0700
Message-ID: <20260821192646.146382-20-stephen@networkplumber.org>
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

Using regular memcpy gets more checking from compiler.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_crypto_adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index 3f9cc7379a..b6707b50df 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -700,7 +700,7 @@ eca_ops_enqueue_burst(struct event_crypto_adapter *adapter,
 			continue;
 		}
 
-		rte_memcpy(ev, &m_data->response_info, sizeof(*ev));
+		memcpy(ev, &m_data->response_info, sizeof(*ev));
 		ev->event_ptr = ops[i];
 
 		/** Restore "struct rte_event::impl_opaque" from mbuf
-- 
2.53.0

