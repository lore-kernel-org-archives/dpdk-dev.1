Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F1D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 16:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F6D4065F;
	Sun, 18 Jan 2026 17:59:52 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id D720140613
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:59:51 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so3229018f8f.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755591;
 x=1769360391; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=ojJGr5RzbjrMU4Y8JSL/AcfilMEtBl7Hb8spkNk+xpj3xIjwt9cljGzpwC2m9v/jt6
 PGjWAxXeLrZ/NBGktGAhjMNzfpS1G3Za9Bl8WturMOMB36UfousdMuQbwQwfwhquMWY2
 /qn4a+I8zSLnQ3BMrhBpKR+EGncPkPdlyS4bdKhRn3mSPrNvHZfYo7TZDAQffC3Y3SmQ
 a4cvPcSuJ6vshywsSZetkARL7ywjAflwi+XU6YIJudXeRotlE+wWtola2zPJA0i9HpZF
 mkeRoN8e95dORfiVtu9H1JK+lZr4q+GFuunZIRPL3j7jOgG6pHsu1r3pJY0JyJGvET5K
 B7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755591; x=1769360391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=pD4l/r24gfBobakH1kwL36fymMSM9T1eBsdes+oSa/ZZVVcJdSFOeLsV3A5lwd0yyC
 D3HdCx3X3SzAhkB7RgT3owl5fMvkChhNyXi5z5M7KWcniGH2D3wjNSqGUtYdlYMdm3qI
 cAtTYtex2VTbiwjOYuawMUSJ5F7jOT1xlk+fmRJWoX5BKzArK3Ymh+IrvtFvdQ6sayem
 YJLola1GsmzsPWmXe89CnD/oUnBPuADxzo9CLa+eMn1tMhdXWs6HIxxojqvZUQGRJrBY
 o1Bi+63Q/dNkAVGD7AGUTKxjSX/lRihoztofQqHKnO3X5zoE5oCJ/fRyTyN+8Oz+e/3z
 hpHw==
X-Gm-Message-State: AOJu0YxrS+ycowTFVev86j5D9xau2v00TkBqTH9P72SQ7HrTd5OqoZYd
 Pg0skKl2Fd5EWXrUvLBAmWX5OVaf/mc2NzsBPB1vqTXPNkdT1CdKB/2jEbYADo/Sjxw1dLUMCTH
 cBvce
X-Gm-Gg: AY/fxX4ksQPSN8cbgl01B8AU/3GHImWMt+fc5TwrOtXihwXdOQTlFaNZidZ0n7pa2YY
 a8p+ycoV12Is9ybyI617PvQWMzwtcJLVNps4LirG8fK7ogHZpMNRw6WD/s249of5G3FdhYexFOp
 jaMsoFMD0FK2crO2UHNpXVQkAcEFOTLffbUchCgx/uni9LyvJBcMbRarTdXKEWOPyno2BovIm2R
 bTox+fMooolua9iqdab6S6UkGuCwByvjX9iu7pv/+t+983KEzat4QMmxlebNXAe17ohBeaWh7qM
 W1nBsNjaO0ZwrrSCA+q93kPAGoQhS+KEMXPDjMJYZulRcQVjtT+47s7ZD+OEvXdMfjh7DYwnjwW
 azyOJ0vBVJ2mbsWd1WID3i2z9KGFIHoV+Fgtzr/2KsyLhdYVhNzoipLgevoCn/pmF9drcMKrN8A
 gHF8gNG/NIn/LoRDZ313IlUCnRgOC/BeY0PyDpAgEp9hKSrGhWAw==
X-Received: by 2002:a05:600c:1c19:b0:480:1dc6:269c with SMTP id
 5b1f17b1804b1-4801e350488mr101504875e9.37.1768755591435; 
 Sun, 18 Jan 2026 08:59:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 01/11] doc: update features for PCAP PMD
Date: Sun, 18 Jan 2026 08:58:36 -0800
Message-ID: <20260118165944.41374-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..b0dac3cca7 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

