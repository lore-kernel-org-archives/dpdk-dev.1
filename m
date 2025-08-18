Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DACA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04E3340E11;
	Tue, 19 Aug 2025 01:34:03 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 3CD544060C
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:00 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b9a342e8ffso3313794f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560040;
 x=1756164840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2Ue0qDsu8v07OzO7zWqR10Gf7cCmrFTbycuw7L/r3I=;
 b=B3TMfpZsiw/yxuYUexjJogcoMS80hNvhKZyBLXSWon2bRQ+gPfOPYo6AiOd2/9K4yo
 TnHd3LIGsUdOvOxuz4lSuLxY+VDaALdi3zpWVPRgVbRMA+HT6Bdbi3fDmATCdPxUVfwg
 4auUgIgz45e5mSUIg9tjs+hq9tH46aOOoxK0gDTqWZE4/rRsMktqc22SO6tz+lyRf2re
 GxK0U8O6NmfXn+T6I6OZW2uzqRwUd9841yXtoRsYBxWtHw4Sg7biio0NDMhsCf++fjNy
 T5E3HWLKVEilE51BRhIPiI6XJhc2vHe9TgUs95T287m2xtJi2jw+F4XsasOOGsCNdaQx
 K5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560040; x=1756164840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2Ue0qDsu8v07OzO7zWqR10Gf7cCmrFTbycuw7L/r3I=;
 b=a8+Fk1rSIKqbLA/ao9k4UPAQji+82jrXqG37r5sh16mnmfPTOHptzfEsmEanXKzd2V
 X36kqZR2oLMOET91D/JGDWdLvZ1Fhu7DdXLkywBVtO8WKUruKdDd9xLQzIP5DMjRf/2D
 uTWP0Xt3yE8/+g141ax/LkYnEFgSFK835qAzH2CG9jMaDNKd/CCTZ4C8X4vBGT6ct1mk
 Pd2JzKFd9PYIRZcdG81ltLtNMphPPQx7EBcvtxDN5jU6sD0t2r8OX3/gpMA5tnZalMqb
 QtksD7kZdUTZao0Ph8XbBGLLVbG/WYEhLR1lsbdO/hjnAkRjmHXN+vr380eGkAZi9/f3
 SHWw==
X-Gm-Message-State: AOJu0YwG3cfnti7vOkH9RB+IQuoI3+tqCUmcf8jQiTsGkm6KzS3kvpKE
 vrF1OVV+aXPBu8dK2Iq33I72azuQed1fnwBaZW4tfq4UXHjo2h8Lm42oddQTY6G9OM3VTxQjYPL
 DrXvg
X-Gm-Gg: ASbGncvOydtcbRv5zSBBKxVcc+TLqzERCZNvpybknw4VzA1CcPWVfF1Cw0d6Jxw472t
 ox++5bZnYM+7PYa256VXTGICqWCTQkSSlEt4vauHZqLcrn9PF++EjkUxsyW/yIMK53XvnmmH4yn
 4bYBT5K0S+YTL5Z6Avmc177URB7rpUmrc6ZbJ7X8MN+n0THlnz8v89rcqiNjXmuB/UgFDY3YdMj
 dSK3GrE5vMPmyypqm1BYmacR4IUyS9nClvH92NOvD71AwAYQx1Ja1UmdLSf2nj2Hu3iW6f3rOcR
 DVa/3nzFATZHNnWXN/RUWtxJ7EusGX6+UAAS6fSwB719J9yAwFHW3n5UUzA8bsZZi+Bf0OUxtPJ
 rm2F9eLvKuWvxa4mcbkbyD5bJtV72URsHCBRdiNnx1wQDQRjWOENWlmBEjDuH3p93YoInsTPs
X-Google-Smtp-Source: AGHT+IGSopaapZsEOYtHutmiKx3k+GjuyJfkR3jU7YbAKhkgaUYW7fxVL/9kFJZ7Oocj66zOYWGL3A==
X-Received: by 2002:a05:6000:2909:b0:3b6:d0d:79c1 with SMTP id
 ffacd0b85a97d-3c12add3401mr185490f8f.10.1755560039740; 
 Mon, 18 Aug 2025 16:33:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [RFC 33/47] net/memif: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:44 -0700
Message-ID: <20250818233102.180207-34-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

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

