Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D2CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C56C40B97;
	Tue, 19 Aug 2025 01:33:55 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 104EC40B9A
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:52 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4296544f8f.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560032;
 x=1756164832; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAdqmXUFlOdel42Sr6OpPU8ldg01PwEngQ8cqIX77rw=;
 b=lu+T+5C0g1Ckg1D1KtdVx/tL/HdoCV9s1ggOdQV7LSRPSk3v4OeR3yYBmHXxSvyvnL
 QkGZIwjqaCbCA+XYY9kUWT4XLjFIO7Sg4UXcPGJ5myGVPEqj7K6YwFjmrj+k++q0WrjT
 SeSybdsd86Mp/QFtKc5EBGAa3Z5jwSnsybfCGORGzN/IgTiqdpKfnjuM622kcIk1IWEb
 vagy4aNHEgEHr6aDN28CwsWJeafnnMOZdsYOp28FzjQ5THr5dXRRqZE6+baOcWWUmaT7
 JX4RJxUAE05mPZFnqyyBmKzvD874f0+xFd+wWwy8DtBGD0DDEGPBJQC+GKzYSsw1tyf6
 QwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560032; x=1756164832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAdqmXUFlOdel42Sr6OpPU8ldg01PwEngQ8cqIX77rw=;
 b=jijwKWD1X4Jq/gHTkEymKwOMOLTU4pqElSJO0m3iMHyn3HcDIATv23VTgKk3EmoZac
 mJB1V5+M+w/o2Mk74YC6d1cr2P4LV/JdxDyoOxNd8C2xqbBTzic+qVXDCe4iF8dR4Y8c
 /Y1e6TQp/4WqJTamRjh+UxJiJGXgWrxTopoFgg0Dt3hGHwM9WVzdFg3J6u1oupCsWW46
 Bu8crSvxzIjv98bW6JQ+yQtJtP/KyfiFfS32znR6x3b9rEyoERbpBf3dBSdc5cVeKc79
 Q6OwkrZHwMN0t84QyF2vNMaPwljgiP2PH32qF96L+oxS35ur/Lx37Yn8GclQ9Oqlkb/f
 tv4g==
X-Gm-Message-State: AOJu0YzOXMIuC65WzcUNRzLVw1rj30PZ3z5zpU5l7mmJJO+HnlgsXiup
 JOFNctR8Bn+8dK1oqPSYdghMbt8gvQG9h3ewLUfsHCE8llgdVZKapUMUT2Wk7WPR/p8NJXx7ke7
 ZYW5u
X-Gm-Gg: ASbGnctZqgEcMR5lWpFud3lZQ+nRJyeCCwhqM6q/APuwfSLk/cmSUSWKfe5++cJahhk
 sGQPBfzsdTdybnIqLrewYJOqLOtflI7fuENE/SkpfcuGzPtI1jxdJV2vDz3QYh3jc3r72miSWxc
 wxCbqegDBN/ymScnV+vCl2MwDRhr8qerXDYKtv/B3wrD0tuxDlWaBgZKFBKRbrGoEmENR2qFwcE
 bANS4HHXoVUEoNHVmtkBgiRuY9MPXWNJ04Bd2r5/ZvUp0HJ2fegW5/FgXSwam0u2qMIYQ6AfREw
 nkzm8rK915BP1UfwjEo5QD1l3ile8W1iWlKRtopcxuO+15/dFnZdIQSubLkTzTH/CTziZ5WpN9G
 0JHskg9vfBK82MDK0butdCOZzAPksIG6dpLYuhRv5YdDOgJt++5TscS92Z/HwRsImeRO2vItx
X-Google-Smtp-Source: AGHT+IGt2kSPG5BcR7K2aRT5SQP7Ttohnpw9clYRhtqP41gD6VFU/jARDyHtdrtgsVyHfDBudJZB9w==
X-Received: by 2002:a05:6000:420a:b0:3b7:90f3:cd8a with SMTP id
 ffacd0b85a97d-3c0ec476e26mr260159f8f.49.1755560031682; 
 Mon, 18 Aug 2025 16:33:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [RFC 29/47] net/bonding: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:40 -0700
Message-ID: <20250818233102.180207-30-stephen@networkplumber.org>
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

