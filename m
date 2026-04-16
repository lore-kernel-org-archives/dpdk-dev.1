Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDBF8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:51:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C22B40672;
	Thu, 16 Apr 2026 20:51:51 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id F14154065B
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:48 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so10780483eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365508;
 x=1776970308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=We7JLv6QI4NoO+JQp795gZwt9ZkqUAcbGo0NPCde1ewGpJRCWYShHKcEyLdlUhsuQq
 60ohlGr2tDXnKJCMX1I0uEJiuIP3Pb58kkhzzmQCcnfXY7VPLJru6K73kmel/QG1H5nk
 KYU2kCAeQIkU3dowef2WA+bpNb58OnAbAeXr+zomLFMsNLaD9FhWrU6ZGIrU6CM1sYOd
 FD7oBs7X9dfcDteua4mEtK/JZliNXLhr8T9127aJPaDmqpnBx1RjmeRznVRU+75pd7IC
 p8oFrhfGcOkG5Qot3NSs4gFGNMgwqtGDJO11fVScBH5fOxvwqGyUSvuHKbNqpmOO/ZLS
 2VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365508; x=1776970308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=JmorY/vVu23SAaWW9gJd1ntAAZPdK2bVPilCzYod0uzM0alBNe7FE0eisBA6tfsBF3
 rNurki6MfvFfyhklrsWojcyAf9YwboSn8+s9D0UaFElBHJTBriU35h25RXK7iMd1fe5w
 RaXkU5dNpo7gk0oXCfeOh86YZldvdKzZxO8XuJLzNYjREgEkYyGEfaDvZfTFAZSunJmJ
 s8xy7P+ASxRf6QuAahaXAfCXXdDhLaQyReeyOaD+Fr8RhHRkS90a+dcKF7m3U23Pwoo/
 y3Esh+gJgoNP1XGiTX408NiReNkRlO3fq/g+vDHjsDmi8PXXvDNCrrsKaNxA8SCgs9M5
 08Uw==
X-Gm-Message-State: AOJu0YyEJRJIGOyZCSPmoW9wttOj4moDBvVGc8soJhIhKM/q4CgM/3EW
 7Q3YjzP7KYi8T9Ix82RsbffVlYZh6AwqNgyfg9nZrRagI8DhXQv6wgSKeXtOXQafWgZbuvnq2p1
 bDQQq
X-Gm-Gg: AeBDieu++MMh4Oj4pGDYXXRSPkmOLOBScvZQhuyO80q1g1dKALYxj8nXCDbyjKoQZDU
 j5CtpnATx1P0CCVKqYv1a96ONT67AEkAO6hfZW99eyBSwz8yu1wR0XKEpdqSRejDUF9/HMVitM8
 VIkRqYe0dGVYlrPEFk3PdsdhaY5GAHiepIaD2g8Cy3y4mu6CSFKEkCMLxbi1fkk9fq1AqOB8dbj
 K0TaRwN0tmgwKW77AoTRSfAu1n0sGfMzsyKOscTI4OViez1dEn0TFwOi7hodH//fKOxuDR+/igv
 MxBOKijh0cT76k3fHjEJf5N0t8y0PVi9rQAG1mCxwLav8biqRWwi+xf7hMh4efPkhqWy+rp8dTH
 8jrFnZdb2JCQVbTUVDifLC+MQXxERwIx//WgqBhywkTuTm13CkTgpcWVcMkvY0RVU3te+GzGA3U
 hynP9AY/x1ccouQlPlzb+7mN6bFms0kuOzpKHTBaRroYo=
X-Received: by 2002:a05:7300:b58b:b0:2c5:220c:5673 with SMTP id
 5a478bee46e88-2e2e348a3cdmr284657eec.5.1776365508093; 
 Thu, 16 Apr 2026 11:51:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v24 01/24] maintainers: update for pcap driver
Date: Thu, 16 Apr 2026 11:48:18 -0700
Message-ID: <20260416185144.1359260-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..580113a658 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.53.0

