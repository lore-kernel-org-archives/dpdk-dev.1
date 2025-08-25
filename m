Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7ACA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BBD340A75;
	Mon, 25 Aug 2025 05:42:46 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 116CB4066C
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:35 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3c854b6459fso657774f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093355;
 x=1756698155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnuqNrbrON7tQVY9E1jL+0Uj3xz0WE/7KgUg1ar6sug=;
 b=RGQvwNgLhZK7bv/kueZ8oHOZhO13+p65accX+rtJISFniHBG6MZ/KqSUt7jF8xHDna
 TwiKYX6cMdEe1v4eIaNBNfCYyJ98fRGhNuVWLwY4HZigknrzFuo7kVzcTYw2D7GpUSaP
 bHHCZZdqu4M5pMtzzQQ+0wllr1utKwJ2IUKbKuHUdIH58jx7HEvshRi9O+LK6fH2j5YT
 tX0yBIsa6OtfDi+xSaEnvG6jFFeZ94CmVOqwLoEYZl1g9IG0QC2JHw6lpjRsz6fawyAg
 4GQkVIC5+/6882UP4yp9uAHTy/rkRUXYh3j0pXy2uplB+0P+JTi69h0FgY+ZqA97UOJP
 Fa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093355; x=1756698155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnuqNrbrON7tQVY9E1jL+0Uj3xz0WE/7KgUg1ar6sug=;
 b=IG4i7IpxxB1v3VBYojjJMPZeznBeXtqK5FgN4X9yjkXrJ7l2KzWue3zFZ3+1fNbZSJ
 pSqTmTUEoGeutsPLsFVSeRooDdyt2N7xiklLlXc4leRJSlBAKpgz4jCZdsYVTsHHKd+q
 RFTN0tex5onYDLiMz2L7WaMfaQpN/Wg379TdRM+ly3x7QmLTcgr1lUIIuHtXn77FIOaY
 dJmFIb6jtnZeuVxMirunOKzWewqZscSzfzQShDEsZ309OkqkjLqxrqGKABC0qOTLtpRL
 5cQGLLJSPrLIEGK2VkHApoCllcMg2ioXyiIEvb9ecRixS8dDcGg0WjMTc+jKmdHYrPH2
 E6sA==
X-Gm-Message-State: AOJu0YwVDmttye9Lyfct+Y6YTIVGYOpVtB5wMJQOfWNwfQ/ByIO4xN2Y
 AGKOrOF9aLchcZiRzG6e3mWW5k2C3t7VqU3Wht2hOGq87FVwztn5QESc5BR9DR1+jMSSx4O2yNR
 BdVav
X-Gm-Gg: ASbGncsFFfxhMIZID/eMXUxiV1qK5IreYCwkkdB+06qzAy192s1AYc+1ghEAcF/TeKC
 7vrjmZF9WYhiJKIowX3GD/uOwudvZNhkZA2SIV+0uzKJg/pSjmYS4moEVWVDZ0PcrZK2ntU4pTk
 PWqgd3sDU3bY7CYuRygi2NUq80H4M5LPIcRL/1tpIHR1q2ywGjgPeZlxX0IIj96p/ArspkmNurJ
 vtJb67+gCtx05dgwIgTD9FteOVTBldW4sabXbz5Z6PeCmhYw/m22OW4Lw/lqAYKRxWUurEr/nzM
 5Mr4I+dabwX7CgV20F7M/+qbny4D173gWM3VH4QfqcQFJQiO76X3MP4qPTIueK8sS10vGu8ARsp
 ezsOpTDukG8yxJUzZF+913JCQmiBJsWrrc1xaBbe9pnrXnYRGx4USoSVDjnJX1IJoWzhJ4irGtv
 pz4tWqOeE=
X-Google-Smtp-Source: AGHT+IHuCD2g+WVn5U6Y2Wb52xvyM5ITgL3n0yLAdtDYYWGW1dSTE/7pJTbUdvd4YgswvXHSa7lkmA==
X-Received: by 2002:a05:6000:1449:b0:3c7:c594:2338 with SMTP id
 ffacd0b85a97d-3c7c5942a88mr4304913f8f.25.1756093354649; 
 Sun, 24 Aug 2025 20:42:34 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 22/43] net/bonding: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:35 -0700
Message-ID: <20250825034126.12046-23-stephen@networkplumber.org>
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
 drivers/net/bonding/eth_bond_private.h  | 1 -
 drivers/net/bonding/rte_eth_bond_flow.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..9e268d77c5 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -6,7 +6,6 @@
 #define _ETH_BOND_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <ethdev_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index 5d0be5caf5..2d5b186aad 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -4,7 +4,6 @@
 
 #include <stddef.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
-- 
2.47.2

