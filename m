Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA4CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C4340B8D;
	Mon, 25 Aug 2025 05:42:52 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 2707840A6E
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:43 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so22808615e9.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093363;
 x=1756698163; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImTNw3aS/PjlUuKc4EwCASjA2TAOgR2vLqVW3Vjrw7s=;
 b=XbuC2nbK5JidRbloUgWlR21FAc/745twtA3R8Zgkn1/zTDFJ6AOs7qocRTStYva/09
 mN6TzNc9PnmbUVjooo4bnHnsxrHPk9bJOQ6skvxB4MBypvd3Ys1KpIPshli1VaAWXato
 mHVzOcYlB8C5SXZXmsFs1cUlGSuzDCvLl/qnOCPOQWiWWXqcpIUqnyD7pnfmbHyKb6vG
 iNgXz49n3xnAiTauluq3kXR1BY00VYeCd5cVxcWlVQcQeFD5cTugQaIw+8XH3PYsDsBC
 RXpxYrqhZbN9z3RljoAe0EJ6Q6JRh8s7sW0eIseFVqqHYZ19l168jehrMonOW9fPNpdb
 bFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093363; x=1756698163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImTNw3aS/PjlUuKc4EwCASjA2TAOgR2vLqVW3Vjrw7s=;
 b=lvgkJuLdA/VFt8FD+4oXpy405p4eRpwHQ5gEcIPHyhTi/+II5/j8HFuzVPZAt2O4J6
 HL0RFcbO9vY7WQKEkekN2wb2lPydCp5hxr86g8bPAAWi+Q2eWTHiCCmEIFUuAuJtZE2p
 5o6PNnSROjdX2vYaHHm0TF0ZjSAYv0f8mQw2dyDExJvvDVe4S9xoRU+kPcNp4FLsGLX1
 ZmRSmqEslX6U0JlKUKptP6UBRTHyaysfRTBtGm9S4wmaHYX83Cb7AvRonH+a4qgKY/80
 FeIKss+gdIaAcrmxpRrpzl649sY/JGvtHu//xjBmnQ2iP+Cg2O1x5D+oqwqV7bEukWrS
 b+Bg==
X-Gm-Message-State: AOJu0YwUONDW1VYePb43iOSczu6W9N9LGjWYW6wZ0L79I9rR6BTvg6Ix
 My3AIFUiQsdw/qqCygu+UA0Az5W9AunWcJJXis466HSvtFXxyiGgLUx5c08jegcJMSZdSHrsUaY
 s/IPo
X-Gm-Gg: ASbGncuz3+U0ZxP5/AaIOH26CA20YQoqourkYrCUnCopbnzQ7XKN3oGFzqqt2tGHcuH
 K9WZdETiORJcMB0wFRRWR/fUESUd3+vjc5UG2QkRvpoBtn+c5YNQ+cFJfWtFaAI8UrCMV7/KN4j
 T0St7ZX1i428uKfCli1DtezpXYrM5z8k3cYc8DtqNqHfn8VC+KmTjrm6k9Zyy3OO5BZi3Z9ST+n
 beYsQL6wM2DEDAEOsHhOElcsAjoKBSVra3KR7ug+saGYN3LCiifHVnWoQKJc7sOvKfarqMPFZRF
 ysERusrIBfx5qSUJ57F4j5f/MEIyRQgwBrLvICPKLjVXwbLRX8L+0foOIMm/Ufsn8ij+3cS4PIx
 UhGKCmkst/ZbaPFp+ecrjyihJBZKDZibs/7BM7l9ucKF1LhIn30jn9rf/+jRBXXAvtx0Apjbu
X-Google-Smtp-Source: AGHT+IGEf8yTLGXTI1Y+CvTLXZonaUAB/IpqfFASW7L3Q1YisyROUCooKf+CJnls2qjdJNg+ihGXEg==
X-Received: by 2002:a05:600c:4fd4:b0:459:dde3:1a27 with SMTP id
 5b1f17b1804b1-45b517d4160mr83674075e9.26.1756093362738; 
 Sun, 24 Aug 2025 20:42:42 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v2 26/43] net/memif: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:39 -0700
Message-ID: <20250825034126.12046-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/memif_socket.h  | 1 -
 drivers/net/memif/rte_eth_memif.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/memif/memif_socket.h b/drivers/net/memif/memif_socket.h
index b0decbb0a2..f95b64fd61 100644
--- a/drivers/net/memif/memif_socket.h
+++ b/drivers/net/memif/memif_socket.h
@@ -5,7 +5,6 @@
 #ifndef _MEMIF_SOCKET_H_
 #define _MEMIF_SOCKET_H_
 
-#include <sys/queue.h>
 #include <sys/un.h>
 
 /**
diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index 8e45a3ab78..dc6ca8be58 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -5,7 +5,6 @@
 #ifndef _RTE_ETH_MEMIF_H_
 #define _RTE_ETH_MEMIF_H_
 
-#include <sys/queue.h>
 
 #include <ethdev_driver.h>
 #include <rte_ether.h>
-- 
2.47.2

