Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DACD343C
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 18:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA2440E0C;
	Wed, 12 Nov 2025 19:14:28 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5E00E40DFD
 for <dev@dpdk.org>; Wed, 12 Nov 2025 19:14:27 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7b4933bc4bbso1012361b3a.1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762971266;
 x=1763576066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=d4oV62e6LUQc93CUFK7/NCRTqBO2A/PSqRv+5oPIvNUawAaD18FllaSMVKHEMMq+Ei
 hSSAX/jreM7Dd9gONN7uhp1wXs/M5D3eTCQ7xBd6KZ0HuFT1NqPqdbA25fy3IiyyzjJb
 eyMNnVIy+KG0KahQN86P9XLyXpTbewXxZZFlz6moL8qa8bDJwTNTpl1URLFZaEhrnfee
 flkIRVJz6v4ft/TW8zlDWeeS8YeqKmVVGITkGhHhnKzWEalJEmehcVOiGLu/oy1gX5eV
 PiM/HptSn3TRPiXrGmbAHUtmZYbLxh5my5lB++vIS6h+Aa0EnvoeJOywnweP1klVWfNG
 396A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971266; x=1763576066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=ORAte4TKsMrUT2xtt3+QT5U86cSODgzxOVKv2PXhZTQCeyGL4Dl3n9iwCzC3ZZeg8Z
 hny1tzR8w8CXVjxFU/r0Hgty95EV+/DMP73+OLjG+nZK6yAMRA2I2+KMCtc5Lx7vfA6f
 Wu4nyQqzijsZlNgrVlMX0WOKy5piuOwe57fe3ml0ihQFH1iPUS80ATqrWuaFniOTqQdl
 moDEIaDxHabRJbHFDnHybaEPCQP++kaQsmZaEDBk4lP7vTpbnhPho3q0OpmQXP8ThRx/
 2ejOoeyPd6veu9iQfyclBZmUvJ+pxptKQj6d+2GsPR3ISw8lnpRivYpjD024oI9NDJWV
 QmcQ==
X-Gm-Message-State: AOJu0YwsmSWwmFIHPu/gkMnmU3deFBoiC+whTkIq3vTWsMZibFygmYyP
 Sy8seds5raXGwRVNPchdaZeW9iWcGWwWAJ/4jJWAJCYT4MjdTzmCCf+bK0a66YLlUcZeNUV4tM+
 yMlRd
X-Gm-Gg: ASbGncuMJ3x3N010AbIxF9ew9V1kksCBLcupsk7xX0UZVby2mW3i1zycURtzj0WbAVr
 7IrEnlxDBLrfJRAFx/AQvNb7hqtqZmXJsrwCB39egMYs2wN0yc9Ik28pry7ZxYsqa0WQ5YBvrsI
 +xuWdKgU0bHAig5PkTI0vJsaUaXewz1B09EuPnNEW5HkuiLNY37cCegj8NhZl3VxZVcHt9bRKHx
 xoCKye8AbcxQ3Wf9Mwmp6rpHH3xetkdE8dsDva1OVMx2nfOz+Vv7jDbXHVM7nfxrT/VRTfU7m+U
 2tJjKbvYjUShxFo7F4tNSc+r29jO0cFJRMlyGY7gkYuYHgDzLWVcLbRz3wFANjHUKJTZCqqW1v3
 yo46xLhScwKtyGCy7ak+O9KN2ulGe7SL+JiI7JvjMWxhRHLR7uPQcBsVgOkdbzyCrlLrhkxWpfz
 HB5YXmIrqttF8qLDGjzFFo341sAFcenQjrVvm5+H+D51KqGvK8zw==
X-Google-Smtp-Source: AGHT+IF+MHnPaKjOzjp4OsitgV0TrAtNK36XRIpsmiuifLX0zIjuRB3UlSz9wlTbfLe/FN1EhHOJPQ==
X-Received: by 2002:a05:6a20:3d0e:b0:334:a854:64a7 with SMTP id
 adf61e73a8af0-35a4ebf67b7mr453031637.3.1762971265772; 
 Wed, 12 Nov 2025 10:14:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17b0b5sm19294006b3a.35.2025.11.12.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 2/4] pcapng: add additional mbuf if space required on copy
Date: Wed, 12 Nov 2025 10:12:48 -0800
Message-ID: <20251112181421.285119-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112181421.285119-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
 <20251112181421.285119-1-stephen@networkplumber.org>
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

If comment is passed to rte_pcapng_copy(), additional space
maybe needed at the end of the mbuf. To handle this case generate
a segmented mbuf with additional space for the options.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 3067033e89..7c3c400c71 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -540,11 +540,24 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strlen(comment));
 
-	/* reserve trailing options and block length */
+	/*
+	 * Try to put options at the end of this mbuf.
+	 * If not use an mbuf chain.
+	 */
 	opt = (struct pcapng_option *)
 		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
-	if (unlikely(opt == NULL))
-		goto fail;
+	if (unlikely(opt == NULL)) {
+		struct rte_mbuf *ml = rte_pktmbuf_alloc(mp);
+
+		if (unlikely(ml == NULL))
+			goto fail;
+
+		opt = (struct pcapng_option *)rte_pktmbuf_append(ml, optlen + sizeof(uint32_t));
+		if (unlikely(opt == NULL || rte_pktmbuf_chain(mc, ml) != 0)) {
+			rte_pktmbuf_free(ml);
+			goto fail;
+		}
+	}
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
-- 
2.51.0

