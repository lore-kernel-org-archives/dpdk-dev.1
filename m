Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6CD2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0FC540E6E;
	Tue, 27 Jan 2026 18:21:46 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 31A1240E50
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:41 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so3467745e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534500;
 x=1770139300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=VLVJoQu3jkADpR5eyberbSjNaiqNHnBkM7Ky7gTlPOwrkjps9ZCgl0YFWOlI7+eKHJ
 CMhxtbE+Tm+8dgBYorwgz02YyWwNUSYquH37cWdgJupClowMC5aPy+wo+cqH65RLvF1n
 fmIDd700wr7cJXYUdD1O/leoHbjpzww2GArlhdzM2fv1LbpokTZm6vsiE8EWTkoNsddl
 dQ13l36+VTrfvgEfrTK25tA/EAhHxhLGJgTu4sWxecLw2wbD5NIEewMJ6yhQ47jo2JJY
 YlS7ZaK1e3TxZ3Lifkm8dZLED3lMI8N0vnnasV1FFdOK13Jo5Pj2jFLVQHKSWM4jJFDu
 aOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534500; x=1770139300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=DM2C0yG7jRgNpxBVKOCVHx6oDI5OpvJkPDLC8xvM/yBGRBjU5+ufqj/aJJMJJEs146
 tEZcWfpafsYgP93xdACrcC85cbIiYDRyoaz83lZ+XYc6fh1JWn20xYIxFtAfYM5gR4aI
 j+wrUVhDjIeuZaHDZTAvH1gzglVqbunK5j0J7rf1qlmCoK6nqxAja5c/I5ZbPwPnl1M8
 Dpc6eD19voDwXs8paBOSTLrWR1vKp4Vqk+1j7A4Va96HcNyx67yPMs65PV5IUr53idX3
 N9pP4L5vaEpMEXuFvDEBga6pCqDjot9LlD5VMzmqJW19G4UzjcS29hr4xdwtlyownKrY
 5ceA==
X-Gm-Message-State: AOJu0YzowgMGRdjxU4LiSpiatMhJSQdyvpV3iLuzFXOtdoKbyaUpQff3
 K7KvRSP6VvPyALu/QpoCYo12xYI/DATn2gxRnPHn6YvtRZjobxTLfAi58Lxibvd3o4YAxnvP4LF
 OlUmu
X-Gm-Gg: AZuq6aK5Lxk8WL8hGkzLXNuH4bMsgj5rUlxQ51Mk51eyZs2948cpyXUMGC+6iYkWOto
 3RSKclqeE0x2ksE6dryiIenIRrm0n58OqWlV3o+MWsOoA46nrEO8fPHA1F1MimvnwJFBUJ59x60
 b3KFqG3QDc4FzKFeO06goRFYnOt2RrW/U76eTX/QsQPb1P0CC5OcAN6OHjkxtUXEk6oKFv3SdRr
 34e0L/aI55TkXlzYHz8ET8jGlEZPdB0P2/4KrDKzBAKN4uUxuboluhg9RtoAhpIsdyD8WUHEy5m
 pdBg2MeUO9ZeWODA6kDY26Q9g+ZcZuJ8/u359s4jNL++1LCSZme6VZ9LGtGJ+KGr1fBrwbgS+dD
 dscO8k5HsHGuZlWs/36hCkdzxXA2xnYzr+3FP+r3/uC9Zxai4nXh+ZIT9CtnBnZcBO/zCrJI6+b
 unxlRKk0iQXMnI7PTq8YfR4Ba3D4USeb8Y7RlUwf0YqmS0ojy3SA==
X-Received: by 2002:a05:600c:1e0d:b0:47e:e20e:bbb7 with SMTP id
 5b1f17b1804b1-48069c86b30mr31234895e9.25.1769534500617; 
 Tue, 27 Jan 2026 09:21:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 01/14] maintainers: update for pcap driver
Date: Tue, 27 Jan 2026 09:18:42 -0800
Message-ID: <20260127172128.124473-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e90cb8c28..62da2be759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap_ring.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

