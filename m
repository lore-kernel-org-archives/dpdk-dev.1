Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE45C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0526440653;
	Fri, 20 Feb 2026 06:48:44 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id DEE2C4042F
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:41 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cb49f63238so101825085a.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566521;
 x=1772171321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=ur98ap2/MoQp/fQtK0zNeUIracckiPtFKW3GSQ/aMjt3r3Gn3c7EomMzXywoHzTh/P
 vbJs9HdFXCWRvV/VuuOfpU3cS1DKd5tW5WPksjTGjkmF8RdRRdxzkV9gkcnzx9XjngiL
 KY2efiC8L8eXe8ZwxCU9kTvM1flClJiDdYKQ+FC2w2EyxlMmXTmvuHgSSxozamKzzN5x
 0gFiiCPtcbeqlUxSW4LAHKRGHLqPazYyo+PlKswJt1tACDIFiRrnKTkSOAZkd3FfIMZF
 a2WwtdGeASYMXrLzfaJRaJG1tx2qfdyz6fBPxAFvXfEq6tO+KMN4vLGQGd0HxB9wvsbB
 9jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566521; x=1772171321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=ngMQRG+kjsVQLSx02iiyhy6aGXyL+nFPLwdFHPA0OOkXtEQXcP4LCk1HFTpeACPMA1
 kpTazh0te6pUGf4wLVrYJthnCQTUUH/QKGCP829nJ0q/ENbWPc6GLRTEOf1in6EVfbUI
 +pgd6jsA+p6J2aIi1h0t3lZa2cQIM2hH4vBH5PoNkKkOxZ2CLkJ8y4QMU36eUZDGUHHu
 IVhF0TourC3mgP2x0AOZh6zXGavEOwdwFNj3TFPByzy2Q1jTtjRKXO/ZTsbeMvpEwa0u
 hVhhTewUmP0BIGyHBywfVKypxD/RDboAMpAHTlSxrfpP3okcz/g4EKGC9cA7AzDffHwh
 VbBw==
X-Gm-Message-State: AOJu0YyEf0QqHKO1yHrahc6OzGQ995YnPzAbqYGy/vSFoLMku3PAKG47
 /C4nlTKvBULCZEDT4/ynqL8A6KCUKWUJPEtrFfv+6lw44c7ovHu4rx1iESlpC4uqv2ldAXNOOW+
 ECmc3
X-Gm-Gg: AZuq6aI8i0iCjahYJn+oE2TSUYOHvTzhrWyHO8y+knF/H1iE3VRp9B3iq02Jh+jOtH1
 60fI86it528oKFfwClEHDNlubTNM6bigZPtdhUjntKtm9vDA4J4FK3GMno/FnwVZd+EQQfiEtqI
 RAaaWlh8SuCwbJQxgXO+Bs8VkcL5QZegJSoDS639ZD8GY1XzBQlLrYhNX0JW3MXW2+ONKrK1597
 1BRx2JGvtjgTVXFtcBSTEN0YCUd3eACLpS9vNmnIQtwJK1FJ0W7UCrp2rop9/oA3FZba/wK1Vvs
 V8Da4KJxH5rOYAsRSPnH+y8YDMYz2iZ9G3em9QbO341owhQyI0LQfgL5KAdvF3aZCur8zIGtF5x
 AbgXA4GSqBcQOCxk+MlkfT7+7TAy4lA6FuQ5NHXZ/W2XX5vly1YNLVd4BzEmZbKHToX2LwW/qKd
 pJzkTU/suy38i5T0tG5DdCzyCBgO6+mPX++hHkOQ3Q3GFB9GiY02ABpXmwz9a9+Q==
X-Received: by 2002:a05:620a:2a04:b0:8c3:6f44:46c0 with SMTP id
 af79cd13be357-8cb7401cbfamr1026165585a.16.1771566521177; 
 Thu, 19 Feb 2026 21:48:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 03/23] doc: update features for PCAP PMD
Date: Thu, 19 Feb 2026 21:45:38 -0800
Message-ID: <20260220054834.1632201-4-stephen@networkplumber.org>
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

