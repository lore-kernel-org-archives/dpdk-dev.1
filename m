Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33CC54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A71EC402ED;
	Fri, 20 Feb 2026 06:48:40 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 78696402C6
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:39 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-896fa834290so19586286d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566519;
 x=1772171319; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=p7CjpQFCCAAgRLvARc2Oyv4iAwdIHRnHUA/xgD3umo6lW6uG+PX56pG5yRboXzU6qP
 BRvL0a+rh7/mmeIYbNks1psLj5fsaCY9Z7RUqlW1zpyZ7uGMZqguPEH88am/Aple0AoR
 5PvBM+DIWFjVtPt+BVzZgx4OjGbLLxLEAu5vYqexHS/K1EqMwuvldjwOgfNPvSs6npD8
 frJ5ixl9YhVspzJ5pqTztRMeqVUtkli1kq/9kdEGmFzA2bBNQbbEcgDxy9fiGmEp0x0e
 PRmY2n6DZBWoQT35+wm6hwYAxHAdgMhZnuv36fzXNon5SPJ3YVIHbl5DQPXn2LPB9/rt
 nipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566519; x=1772171319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=UKQRrAl68JVw+G3UYCkJO2oPd4LPWeeHWPJrnnu4CM8BwvAVJ2rJU+sKJZfvjQ0w5s
 iUxGG3GsWd5AinuHUL106QLZ+YOHDcWTulD3ud3jr0qd9jFKmBoislE7rRcp46Blf3QF
 IvmEFJjQO0bUynsSANHrhlCascV2Q9WPG2UNv0W8m29wlKGqgNahuhq/4jLdF366qK4Z
 yQBXJO/kU1RcHDn9fOyXVLaBOGj1al11F4DIgCrnG7wrFE4MymXg84aqju3Q4BWCHAMp
 e0p7F8M69wcylegSLE38SA1qRakzpekiDGQYrBMnSk2mVnys4OnAYl19d6t3WoBI8NTA
 qW7A==
X-Gm-Message-State: AOJu0Yy1GuTjK9bnukCESqYKQhiSEbZ8SRa7EvmVarIGtOg8iek0oMEL
 Bg2OpXK82ycNscaCI3vdtS9KeEu08jYwZk8GiT0hYDx60Ewmkbep9YgZ6zY3vdheSTCndKLIVvY
 U/imz
X-Gm-Gg: AZuq6aK/QDlcjotfnKxLbkja6X1DLiR9QVxpoBC11amxQu3Ne+8ITYsvyF9CeXRKdiY
 FaoQk4megpEWvdkg7DozNwIbpHDD4PNLke1Ihwqqbivjm4erNIdYdmp72y1nhT5d7aEDzfb4KjQ
 ZMfiYq0vS2zE3FLNUBExhdTOfNXdRI9X+l1EXFScdfH03Raa1N9oGapa+mLiL0lW3qstQDjPlI8
 ktBQI+1CeNi7bCFI3IOJ6T8L9FaSeOV92SawJDaxg9cGAR4DNYc1BAhOKTF0ufvqCG1qoTzmZAd
 f6x7H/ZlZv1icBIrsRCU2Y8PSfxgywmaBJgqytnltDNlro3qgxTHgPYSNYFOxUr6ZcvJov10fNI
 yNk8k6ybJlWU+XNNkx76+IEqWB70/FIif6bO6lbvF7HCuO/FAvHLxf79hEnKxd7advNYQw3yayi
 uWVs6hVe2sxe1ofY9K/qLlqBJdsGmp57D6kWX1CeE4prLHr2fzJiXH5GOGKnzJcQ==
X-Received: by 2002:a0c:f201:0:b0:895:4c99:b1da with SMTP id
 6a1803df08f44-89965b691bdmr53876666d6.24.1771566518684; 
 Thu, 19 Feb 2026 21:48:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v17 01/23] maintainers: update for pcap driver
Date: Thu, 19 Feb 2026 21:45:36 -0800
Message-ID: <20260220054834.1632201-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index 1b2f1ed2ba..93ac176573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

