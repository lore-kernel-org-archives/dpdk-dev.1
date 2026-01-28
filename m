Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D4D46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:41:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A0B940647;
	Wed, 28 Jan 2026 19:41:39 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 1C3EE402E7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:37 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43590777e22so121405f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625697;
 x=1770230497; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=jYwj3BQWbTvKXv2cLSlbfjgyk78x1n3933/5mGE2p/UtfHeqztiA0JpRLVpZSTUYuW
 uLudjW5a6k642IWr4JCmh+Nfx8v/oJZEQykqw6rVohMNzRNGiVAvhfWFYYW4xf8t+LNO
 8eKrM70NvXJJZInaiVl5Se5MNl3yn8lp7GOREE+k9yA5HG1XhWMwJeDtIVxkA6xijnl9
 sUC87j2Me079CsD18ISk1W1Ize1GvX13NVXLSflsP5GvGnEpv6OYYAApcsSbTjepnTRM
 KLWTAMscTmfn2veG574TOUGrSir00GBULK1QJQAui7u9Ov9xKdFM1b3z0UHKCrezEizF
 ET6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625697; x=1770230497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=EXRKpJnExsc88RJqESkmEy9cX0+79JWovybJR5S01KoqQeIf5H29/LUuNsGmVA0Y4k
 zD/mFU7EVXyJcs/SxbZI81EZtaBMTGPXAZJz0Tc0BWwEpNPH+EGSnxgkZ3RxM3VsY2IA
 sfz/0T/nEmpfyW1AWPJ5FiGZD/XYap0x+wtRsEBgBV9McHtzyl8J3JKZmk3oabGvkZ6D
 1wH1djTJ3jDIl7KWjL6kTZUaJ/fgblrb7BmDEbTqNahaU6B2yTeOIXO5+i3Ym3+ZcEJU
 RwpV01XZNNC0PoK3L7v05awyid5PtwOvG2naGg9yD25DqtOIFBveHn2JLWW01sjYqW5P
 yj2Q==
X-Gm-Message-State: AOJu0YwGawUa/GMHvnUS7hLoKYU1eiYYnxT48bVXxE6qIyPOGdY3C5vR
 JMi4YBodljtCHKT0uhx2IvSl9T4SJnZ2yBuK5pyDqPuS4SLKYcXu6nVJIjS0fcPFQy3TmkXSFQH
 1gaOa
X-Gm-Gg: AZuq6aIdHfdOkz7Yfzpk+eXpY2Tc8Vtk7A68HjsmPwZLgw7XuqBbl4NM9pdpk9ivv55
 IooPjAzOltq8FhcJ8oTOMY0KGJQU6Z4+VjjLk3ByCgtAmZGjhF7h8YG5Ku/qEIoGcWj+qFEoGLO
 rw7eX1xIG9cfsGqZgkbstX57yC5c8T2nfYmvxFxR3AP8Wy+Ll2ARt4xcl2JaKtJxOGRWtHuy553
 5qmvH6Xq9Ce9ty6wlwqOVCt/Zu7YQVPoGiwyHKn9wNHYSKKdziTKn6tXQYFCVANqDAqJhMt0gZ/
 lr6NjGUgm8zLPn7AyrNwjEMrfOUWYXnSbIlELXiNEXyEgSSPnxuga6BN9QoRI6qNNJIwnk/yGx7
 QFkDIU9GRsOhRrH+e0MAtGmyBiMybBOTsaxlbE7GPc4ABzR8gN4PmLb0Vn0dj9y/ZexIL+WYsRg
 w4sqhsibUssb8o4V/UAXA/1u0IXT7NB9wuUrEpDD3acRvw/gD8ew==
X-Received: by 2002:a05:6000:2481:b0:431:8f8:7f1a with SMTP id
 ffacd0b85a97d-435dd1bd7fcmr8334929f8f.31.1769625696681; 
 Wed, 28 Jan 2026 10:41:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v9 01/15] maintainers: update for pcap driver
Date: Wed, 28 Jan 2026 10:40:30 -0800
Message-ID: <20260128184130.445567-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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
index 5683b87e4a..28a3269568 100644
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

