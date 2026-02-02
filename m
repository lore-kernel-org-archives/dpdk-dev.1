Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7CCE7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F10414042E;
	Tue,  3 Feb 2026 00:12:56 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id B81FD40151
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:12:55 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2984163f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073975;
 x=1770678775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=KW6SIULWmdIgTcnBxWX/k3eGnhGgicTkplWflIR73KJqxZ2saKnkQKPiLrywMLTLE6
 5ILYoZlji274cEuKIdsvzxSY2TFGItGQw4yiEnikDwtsMdgKfUURAj07o8c5wqxoitRH
 E+5DP/Kvo7R5cQwNjoM7ePb1yDK2qG17T49SPvkIMRM9CWDLSktk/srZoSng6oVJILe7
 kFUptoykEn5iz4E/YlsGCI6/pq+XZkstrUolsSO8OHO3pcsZBCIsDBThqBxnW9zwYDqi
 6aZrBvejKfpqegd0MDldGeaKH+M4b6wNPWEKpi6Wjs/00XAapEF1eEMBgq9nCzcu5YW6
 WJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073975; x=1770678775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=fN1Db0nT10l6hjbpKdxuw1pHcW6HXS46hz4yPmw7GzkwhfcMn2lfSX7/AbuSqnY1G8
 i8IxZzEYSWqYZE1bf4Oya6KxoFfdTlX3cBixSWmttz8vriQlJqFlB9zlDnfdWZlheHNu
 tDs7HTLufnnG9Wfc3bWZXm4jht7ZAw8C27Vz8BMJP1lU75UxR0SDd4UohRknE9kjh0OD
 BTrHaZiiONVrkaZRcvlExScM1f+4ecIrG/AYVWdUASboUr6txqtE/GIa78i2tXcR/8ql
 l9DVWrv5rT9uRGjRZOggjGA9JZzNfp1WMkvvuptu7i9/O0YztoyRGQIQHTladYNxHJmm
 BAxA==
X-Gm-Message-State: AOJu0YzOAM/LxgVz/7F79ZXcbwR9uTZuStxZbMYfX7o1fkRZI0Lx2QIf
 t/nKzvVrpycavF+JTDy1bb2xjOTUManfwc8eJUleZUow4nIF/DkbRqsJOlgM6or9Y+b65bbhOs2
 Z9Gi0
X-Gm-Gg: AZuq6aKXpY2CTLrVtr1/xzY18VaBlzJVKUaPU2D+9Fu/QvvC7S/TquKFAlTNVGWvcT2
 rDfW/pJqwY/E8Df2aFPGKWBcVWmaD0WnydFJjdEQobWfFWJ5+Ush+CCghyWLYjyM8FlkM0OVRTn
 1oJvf5vz7ywQliyY0tPkZINBXZ+KRUcYhp6DQiXwUnXECTDHwLBwh6g7nEpXsYXzWLzsYBg9KMF
 RPRA7h+ZPhQAots+rCbiGf8jKlyjCojwtvZtx9gAJsxROPxlN8onxm4tSGEoBPR08oDEWi0+2Y3
 eL/qhqTlnF/MovMl1WiktIi48DAQZK2Se8mJCvRMj0AaqsR3C5LP6I14R+1k2xRoshsrY6lTBvQ
 XaLYUoGoEY2M7HvRXzyC4cQfolnBzgMXMBNr2Pt6EF+9SY2n6sQhDxaKHeRtB+qWtwzK4alsfNs
 9xXqhOnBlcO3Vy6fxe1bG7v8z/ekC+JJCgmR4IygvVU5XZEjuYIA==
X-Received: by 2002:a05:6000:4305:b0:435:aecf:967d with SMTP id
 ffacd0b85a97d-435f3a74231mr18220071f8f.16.1770073975271; 
 Mon, 02 Feb 2026 15:12:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:12:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 02/19] doc: update features for PCAP PMD
Date: Mon,  2 Feb 2026 15:09:05 -0800
Message-ID: <20260202231245.216433-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

