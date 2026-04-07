Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B23FB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46D2740A82;
	Tue,  7 Apr 2026 05:52:38 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 021B840A4B
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:33 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12c0b72daf7so75078c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533952;
 x=1776138752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQomFkqJBQp9N8e0WgFtkFBKCLSGZneXu8qPLroD+4w=;
 b=Epu+sOW3JLARy2Gt6SIg8V/tklO0oMh8/Cs4VA+GyPPsnYhOmS2aRlXpEsWmujb9WR
 c2ycGJG9krf4e7YUqNcYYHsludUP+c+d9vYD5vFn28pbJSNcX1G53JJjDmJe3x1byqWy
 niyTFGLTaz57hSsb2gSKlvU9NRtoYQomEpoWJ3x4ewgv7wRcyOaQsf80JDBY1oVJubfZ
 291KUu8UnUubokTf4A8dzh+6+joQUklXa4DNzqINQl3CE15SlKfDpiQBy9TycEvf3knw
 QxBXRny8IWTtmXPTEhZw5bCTDEO3lQGuqTdLCGG16nI16V7PihePzBM7AILAbygbfNip
 Sxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533952; x=1776138752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQomFkqJBQp9N8e0WgFtkFBKCLSGZneXu8qPLroD+4w=;
 b=kZeFsd8HvAtH3vu/6rB3txhJLbzexUbuCjj04m9A4wuXv4ll3/zhpD1Hmkrl6vEiVW
 S7vpH5HhgGO9a6NcFcpMeVxNh6pr8cqACjN3FsURqpub9dUYr/uw5K1bCqYnabx8p9+h
 GrHthlTUzArqfnyx6aqdbZYT7DT/Iaoi+Cpp/b/ivEZtknzYqTB5by+lCiM+ixt2Oij2
 +V2dvw5/gOEnOv1fC+0KfZKvTb4Nnkwk6lMUj9MD4E1sQ/OcNZcKzGO6y5EntSCEk66Q
 Fcja1UMxjOi/RWN1fPYxQv4iyIQCT4Zu9fp0+5DmVbrgvMBwnXny1mDzXenuwo5eRk0u
 GaCQ==
X-Gm-Message-State: AOJu0YzkxMwXQNRLIXFaxMUjwVsdDc302KW6L6s08Lr7rsuerYOeKFRE
 jzgOI6Cj8Oh+0+aCFJdXKjCgdPkjhT1O72rOQ6knvz/hD+DTMmXsgfyNYEJXjJWv+cy2RnjGB8v
 HAKeB
X-Gm-Gg: AeBDietgOZ9pE9gMqYx8sU3dncvq3NhLkG936V9ZTeKoa2GhGj5VVp87NpL4K6RhWm2
 cqIbtUDxLOJlprH7Qs6lNDDyUzXgTCaomQhaHq5Vo30eQk1Wj2cvuMncpNuwCrinP5ujFQkaVIr
 6UZv/iQajLRNPZUd463VGJQDSebN88O77wn4XTn7VZyGQ/McGnL1Id01GTnx2meEc5VdalkceXI
 cTPpGfpwV1KsaONIcEOBB1M+3KBA9BREvdIQHJjkwFuTMp3DpRM9xeAe84MBEB9Xj/L0TqkNf90
 CdjkkrbY4MILlYPtWpz2A5iZxvRQZEB/TH+zks2A4ecC91sQvHwovdo8RlULkPS/OyVrVfSAMqP
 HlOI3Dwx9GOmB/AD2yOQftxBi6mOt3lUcnJ5u4GniiGJ1iUUnxvmO9cL1AHxNo4FxH6rQpXX3XD
 7pQNBhWBE77zsOrWfxzhHKJ5SUaiZp170M
X-Received: by 2002:a05:7022:6725:b0:119:e56b:957c with SMTP id
 a92af1059eb24-12bfb6ebbf4mr8348445c88.1.1775533952029; 
 Mon, 06 Apr 2026 20:52:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH 21/23] examples/l3fwd-graph: remove no shadow flag
Date: Mon,  6 Apr 2026 20:49:47 -0700
Message-ID: <20260407035209.650419-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

This example has no shadow variable warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l3fwd-graph/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/l3fwd-graph/meson.build b/examples/l3fwd-graph/meson.build
index e3f4fa8df2..b3ceaadb59 100644
--- a/examples/l3fwd-graph/meson.build
+++ b/examples/l3fwd-graph/meson.build
@@ -11,4 +11,3 @@ sources = files(
         'main.c',
 )
 allow_experimental_apis = true
-cflags += no_shadow_cflag
-- 
2.53.0

