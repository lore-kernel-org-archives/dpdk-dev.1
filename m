Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74A1840DD2;
	Mon,  3 Nov 2025 17:49:55 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 8976D40DCB
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:50 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-33255011eafso3890035a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188590;
 x=1762793390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdjqOiae/V2yzXzygbLubEP5uJc6/yvBANrYweICpS8=;
 b=v1y9ixU2pdRhI82jWOlKzl2PGnE5rS7glUrQ67+7P1HCFcb8/0hvNqUtcdoRBZA19e
 lOJXKkN7IUAdnsblGhA94OvjsX4SdaliNpe+XwItlqKwqeJJWAFcWq7P7G9pzAe/Yzwz
 PSxgvx4h3FxfcXqIo0NYe1om/H1/pOnE5vK3InuB06gxGkDplbUzLRsVNlktdjfA1bTu
 6DR85YO5w5cVTGkFKWVwh5rj8v7dyWefaVvVMHvpnPGgBXjsKNdKkCZne2mnl/bz4d86
 dNN+dFUEnTSv3/MBIeB0tKS10ZHYF8L6rvvUlt6NE6QsJynusMF5M2VLVfdVQWHt6kU3
 ysWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188590; x=1762793390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdjqOiae/V2yzXzygbLubEP5uJc6/yvBANrYweICpS8=;
 b=uOSU7QEPVH7+lANZiKkTOAVUk65m9pQIW/ds+dOo8zWltUbXSlCjIBso06vkSB17NX
 d2B2vFSVON9y88LfXXmVcsq5FVSr3eVS8dYfl2eX/Fx4QBL9bufHx89MqKolDMPDuRpz
 RcOmC9H6f16GrdmK4E39o23bdbpPIgynF9z1XMzm7v864TlTyDsPYBD+QYgYQjWlAbY6
 PRQcjGn9KsJRqXaHz5EJb07aQtCKGt2Mulsjf9LohLZV6/fEvSKY7XHSSwzVlWYe7bLB
 UYUnWghCxSusFyslY6h4ptU84ysiO97LwOs9iubrjwHmd8VLG4mb9W+m0RE2oZaAjm0h
 a+vQ==
X-Gm-Message-State: AOJu0YzUWMUjtGdBiu/EI5Nl1xyrD+fq6pBYxTAhWzUpTPIdGCf+Ur6x
 1v60jYXtj+objiZg7egGJ0LIaNEdtNfdwy16dErMjh4QB9TFyYv+NbUOmvBPEFkfFI07I4bF7pE
 3nETA
X-Gm-Gg: ASbGnctrn0IwiA5NP4f1Ng/9/mxB53EW7wbGIEBbW+awKPCSfdjSNauCOFrGpdAtLAO
 48GCeFYaioY/yd3TkN4ebQo2p+MJqvqwjnUerTwdh09qW4vA7bXaGcNvxSmzj7eaLaqqdoJK1g8
 tWZfpkcDC2Q3qED5NKlgYXWhXDh52QJzQXkiS1/7OuNaULBRkRilLrRDoZFeT+2KVhWVo8ZPwKi
 +hdiOFfUuKxXuWvjY140caHXNNjkRmM8QK8goCENdWmrbikaaVxRu+eB+LAVA2jnLWcj5+9kj1L
 f6xwEWL8YBOZCedTG8P8pj7vnIgi3mvTl5+/i4wGDmQ4C3NS9o0To0X68rRnLhw7wbE9MrYVl+Z
 hNV2MCwmFL9/nOpduioXNFwmjIJ429Pnl5Nwm6nQpfuWJZhiPqvESgCaY0UkexiOSYCyfB0WPwe
 AyIMgz9pUaGLi/BI5p0uw3kqkoQ8Xgs+MXZN/lpUIbu7WRSnDpxg==
X-Google-Smtp-Source: AGHT+IEbBrBGs5NgA+W+A+IwpnWOWbuNbkUy1wiHSuXFlpZomFG/I6cHIGNn50nGs+ztAOfIhT7xIA==
X-Received: by 2002:a17:90b:4b83:b0:340:ec3b:b587 with SMTP id
 98e67ed59e1d1-340ec3bbc84mr8296585a91.1.1762188589679; 
 Mon, 03 Nov 2025 08:49:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v3 22/44] net/bonding: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:27 -0800
Message-ID: <20251103164915.101713-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
2.51.0

