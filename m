Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2288C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC1C94027E;
	Thu,  6 Aug 2026 18:26:06 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 876E340262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:26:05 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2562602a91.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786033564;
 x=1786638364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BtuhkfWnvgdtBcaxSX+sP0R/lZ99N0s3oUDglH9He5o=;
 b=e8ISijITRwdUU+soX1o4T4BKkLtWUHvN/ly8s/sqpa31CIQxRlOjQKZzjTwyhd/xnN
 eutLOjqIZclKqcHFVvjCThirM9F1WrIh7u13KGWi6XNrxxpgYM97iX6VuHC0Gebno8Xg
 AisSr7Astkis3nVQ9XJQ+S+p1Y5bNtOQGbyCgYFi/o7F+jE1j5Lp1/l3Q2awyV8gTT8z
 mL7T5p+IYdx7JyK5BuqzDCMSnnKCwo6uK6KSv4w6vwPJZkfMKC8dt/KmD7xIPiNeFTKa
 m1eHPTnE1A/YQ+UbE48fOSqLmWjunIO8bIBmnoONRKL2TOTEi8LwEWSWD9O0hFPjfc7y
 f+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033564; x=1786638364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BtuhkfWnvgdtBcaxSX+sP0R/lZ99N0s3oUDglH9He5o=;
 b=h1MzqtNX3olm4/KR1e3HjoEm8R8PxC5YobPry6IowRXUDHP1ZSyNv4HbY/aGvvxgKb
 /Rezsj1F607rZzbyMg5cLuqv4RayMCTthwNqZPAd09bbjonLpHmaUPgMclbfNP5M0lYo
 5Z0yRDmrHfz0WhHp7O2Xg43MP12WPlowh/ygSxznuag7psX0qL8CskRwFMsk6AGEyz9e
 3MBqOGa4qQ+kd4sODxspyKHls4L2qkDO/Ml18inW1PgI9PFxXqS/U5S2a7mXmKvqqUWK
 ToaL40rVK9AaKByt3OkZOy4DdiSh38Ix5QrNsRUoA26iWus0uvQi2+YvtNEm+BfI9oOr
 agXQ==
X-Gm-Message-State: AOJu0YxsbCXCSm53TT68uWC4Utr+nOB4FIljKy2Lsk2BSwHmZOJfCa5J
 LJHN1yzR/t+AVJs08siUEURUND2BDGU3gulNAddQ8dFjgesCmK1ewpfxWwww/CT4np0r968f9LQ
 wIVcSiKA=
X-Gm-Gg: AR+sD10ZTQ6E/XtFgLJ5jjtm1vS9IjB3FDPvgOfiO2lMLlubX72fiYEUQtIdT+NJwi0
 liUV2TnRfodgQdXlmeKA/muiFCtX4L5B1z25MFTHLhLg67zN4hpCps9XVhpll2VL4KohZeeOC7V
 ukXXCKvuGEtf65IpnjkKA7tslbNTeFTkRqfdSZElwhhFk4QT0w8QBNbPUmkcNB27S3MlJdn2lMH
 wvYkMuTdf99T1gBP6kaSdyJfflgfeeUidfQsyVLjqb+Z7g+N/xFSWZnqv6I3O0rYfeNumhX4ymJ
 jJZiRbD5x3IaAsFJu0nlvOqkwDh+260A1++Ppwb/TklWBOri33HljPOKc2n0ltUla+ML/EnnMEb
 yHtMvlQ4q+nC21tua0lueNfq4fDrFFmP4lVdewHb2mR0RxdJ8QxAT3Vkd3CRKqnw4zeW3lzxwMF
 MYQJyg+A/igbHR8Noa2eTCqv0wIFHif0w8+d+elBCfyvQMc6Yn4RSOgDWc0T9XeIHu+Kz6uM+JY
 +w6zk8cT7lg0YvxNdN3/z/geDk=
X-Received: by 2002:a17:90b:5447:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-3903c634cd0mr17129792a91.20.1786033564455; 
 Thu, 06 Aug 2026 09:26:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bdasm30748565eec.22.2026.08.06.09.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:26:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] MAINTAINERS: remove one gve maintainer
Date: Thu,  6 Aug 2026 09:25:58 -0700
Message-ID: <20260806162558.673588-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Mail to jeroendb@google.com bounces now.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..1b69945574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -765,7 +765,6 @@ F: doc/guides/nics/enic.rst
 F: doc/guides/nics/features/enic.ini
 
 Google Virtual Ethernet
-M: Jeroen de Borst <jeroendb@google.com>
 M: Joshua Washington <joshwash@google.com>
 F: drivers/net/gve/
 F: doc/guides/nics/gve.rst
-- 
2.53.0

