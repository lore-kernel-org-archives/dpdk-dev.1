Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02AEF8D755
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F31174065B;
	Thu, 16 Apr 2026 20:47:39 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 0A9CF40659
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:38 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2d96243c91fso2122687eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365258;
 x=1776970058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=tF/DB2FFgtYOk4SDHEkErvb5+qtF57wzgFmgxtlc0yK9RwPDaej6sVz/1V9SQwsvV6
 7L1HqPlvNraJfUZ+BeG1QAKzZ1uUsyCccRwnNiyyYiNTDNaaUd/yHFyU6BZZfBkkqhNJ
 Rd+Q3n8Yd29KBhQ3wYvDAgTZ8Bj4YzyLWRg8OJGr/HXb4ZR0MSWTxPVofDWI6sXQq4wZ
 dDeSfV/dY8CSxQ1BELelt+gjgjrduJ6wtDdLEmomb2oLUg8IcOfh+KQFaob7KKZqgfMr
 su9lSmsSOtaCXRrziliHlIkDrdH8fIzUULW9kTVl9lwCNo2QPNOK1svAFcGdUo4VygrG
 CKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365258; x=1776970058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=h7b7EyC1gMCKmjodeFehzWMVLGsvB6Truvy4x8BSTj4QFxl+hhv8yzf1yNhsg/yDnP
 bWNNOfJfqeGa+MedsPjcUUbADOdi/ALpBw9Yv/ExqpqpjBCdq3thoDdA6FfobJIg6Wnd
 bolC7GWER37TTs7bel6lJ0p68WcCw0M2QsgppvSNqAPd9rsRo3ITOUmzrHOEqbCLyA+S
 sz20SuAtIlnKbTndjIvlfu+aRfsLGaoZLmUrtSWyLgycfW/2TKftEI6LDB+UwYuaIIwc
 GnNximbV9LCJP0gjR2oC9O5zSu9DHZ44mBmt6vDJVc0vB7C/lRdFD3WMdZKJMunQjKDH
 hh7A==
X-Gm-Message-State: AOJu0Yync2Xm0tLpqHaGvbLKnV/F1IWUd6fnxlOaQ2jfM36ybo+gAQzn
 i8N/3RII3rshxfjnje/hMS2ShWlvy501UIo6OFShD/iKSEfUttTsykyIKFSRVEhayiLkddhM2XZ
 bLzxQ
X-Gm-Gg: AeBDievDMNmqC2U02yeTlJrVm49E0v4nm+9fKcgfBCYZPc2BBYsM93RzQ5ryBdXtbHk
 jwNY3mS6S7QmPJ3nyVIzqlhQRHtV7suV+0U8GKqn3MuBZsC3wOEwdeAgo/Nw+USYALQG9+kn8N4
 Me9ckmNVrW6agtPdICeHXHwSyi0/f5NWu22aGG1yN2AeTOt+RgvQHVBMIK61Obu8GQimKnw0Q9K
 Bu2Bqgl+joJvYxo3awaabw9hWZIBHoicp5rfFbvW1IMo/QR/6lzmop7FovLuHai9jmOQRYTlDDX
 O6kgdBWKrwYDGr50c78fbB77n8xsNf83xVtYdoVkgWfFpx9wxG+zRnNct8DbNbzlKC4d6ijwLZ/
 lz+YwtCymRH75jFsfWM+qcexa7ijYRWcCo2S1N8bvp54TMaAf/kTjKxM08kFs90Ua3ZeoAfldTZ
 70cU5pbGVD37no2O4jRClHqtsRa295oT6X6rM6c3YeZws=
X-Received: by 2002:a05:7300:cd95:b0:2df:7b88:a1b0 with SMTP id
 5a478bee46e88-2e2e68d5f20mr252309eec.27.1776365257775; 
 Thu, 16 Apr 2026 11:47:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v24 01/24] maintainers: update for pcap driver
Date: Thu, 16 Apr 2026 11:45:23 -0700
Message-ID: <20260416184731.1347342-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

