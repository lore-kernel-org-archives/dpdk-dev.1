Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132EDCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5EE40BA4;
	Mon,  3 Nov 2025 17:49:51 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 5618140B90
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:47 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-340bb1cb9ddso2199353a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188586;
 x=1762793386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YglZsCzvEiGOjd106ngvPm0GHR6iymv9yQJ2WKUg5wY=;
 b=3Zc9pyaTgCPb0fBaxoqSS0fkafihL5hNOLp27+Zthytfw0hws329s6mrr5zcOgo+Se
 +pXb4XgigHnHU2Ak7+7KpUCoIIDDnXdjailJJ2esc3jIB+HahhR3vlzmaOCceBiyox6t
 FDt20xfDJ4Km17ArlokVUHOpaaC4wJdwexUozV1DgW9TA6QOVKdk/4DzhM0jEkrs0Rj+
 S7ethcz2lHtEhp9QAL9YzxGIzXUTkcIrF8srvKaO6mfRiK5omzbQDimI3uq/grT8nU5z
 ipKWqiLM9m/ufgqsrC5YgkZpHAHErxcYvt2G5TltJMiuKELkRNQ6814UW6npi/Qnm9wc
 GP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188586; x=1762793386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YglZsCzvEiGOjd106ngvPm0GHR6iymv9yQJ2WKUg5wY=;
 b=Z0/dgYnUYqdvOs/DL+TAlBcTjXf+j37jf1iXaEJfN7BqENyQYdMStX4vYphNFNQ9W3
 195CP7sGysuT1E3rG5cqpwz8wqZv0XRuo4+OzBH1YXvWrbjvd+XTH/X8/PwrR59oHDok
 VB64YnSoFvAbydgBay3Rll20zPZBkwO5Zq6Jzf/DUAanZmNDc1kAQRcvseJVjLIMPivb
 BoVhnO6ah6Xkm+uLtLjrDXh1vkdikHrXv6HRHYf9W4Voi6+84s0Qg2Ca9rd5mnPlI/QS
 yWWSDhNdv4VZLlQPWgD6uoatTLrBSbPjcVsIaPnzS7w0TFksaaIbJ7NOo8lMXD7VHdL1
 W2CA==
X-Gm-Message-State: AOJu0YwLXy/lyfBvEAnrTJ+zTOfenCNdbx1mCXlNb8zVdRoNtaiNzmRF
 OsXvwVHk+2PrmCn1Mb0naqE1RN16HaIh7S6+rushq8F6ofwkT8qx/JctVpvEmGBdBvCQXEJDdpl
 8fkfT
X-Gm-Gg: ASbGncsn8GBkz521tP2+aAk4+9YJwiU1CooI9BdmMr7R4P5WBbcz0mFc+dtor+PGSrS
 iIV/1KiPZXnDfAxUGK9VuiCPwIA+Ak52SvxpJcU7DxIuyYGpc+NIr4Ec/eQbflCN8u+SbsQ6Vpk
 /ekgGBpiQx+xAplOTSrlzInxEXbUGWnIXX9SgbibUdDm6ykaG3p3luPn1MzXSZHiAAl5yImVfk/
 vCCKMJ7Lm66GAA4/BzhNhMufJ3hx32xQ/FXb4nGmB+/HFTlxfi79VlgwFIR2eaXoIMQVbHnWhXK
 t4MGCSH25/QdpPlEeCyLAq/xVZJdiwJrxvJAyBODHmPOy4zKgEmw0O1eKBWz0SgfrZQj6qryRpG
 VlIJA0cISbz2C98AiNjokk55f/kcuipVRDf/qIY3/J6D3bF/Hlg6xVYQISnJOr/kjCUWMFAxECx
 Fb2Dxl50ssq+Me3OZ9ZrHPjBxypOxc0PeQY8GAhTY=
X-Google-Smtp-Source: AGHT+IEUWooR8uQDDuy7nKIr0MGj39pLNmFGERGfQr5LKiMc4eBaVauF28ujnwHCvXV8tCjgn4vxdw==
X-Received: by 2002:a17:90b:2882:b0:340:bc90:d9ad with SMTP id
 98e67ed59e1d1-340bc90db2cmr11319355a91.10.1762188586524; 
 Mon, 03 Nov 2025 08:49:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 19/44] net/tap: remove unnecessary include of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:24 -0800
Message-ID: <20251103164915.101713-20-stephen@networkplumber.org>
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

The macros in sys/queue.h are not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.h | 1 -
 drivers/net/tap/tap_flow.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index ce4322ad04..055a9e9b23 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -6,7 +6,6 @@
 #ifndef _RTE_ETH_TAP_H_
 #define _RTE_ETH_TAP_H_
 
-#include <sys/queue.h>
 #include <sys/uio.h>
 #include <inttypes.h>
 #include <net/if.h>
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 9d4ef27a8a..90fab604c2 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
 #include <sys/resource.h>
 
 #include <rte_byteorder.h>
-- 
2.51.0

