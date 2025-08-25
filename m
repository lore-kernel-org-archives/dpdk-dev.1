Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D758CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA5A4067B;
	Mon, 25 Aug 2025 05:42:34 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 77395402AE
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:16 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3c854b6459fso657692f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093336;
 x=1756698136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYfg7bc0jD7RMhYfXctm6B2LlorSosuGJgHK4OUhNxQ=;
 b=mSRAHrLj94H/nLin4nyBwJPV1oKAkDQiHS0C7gvIE44hbUhF55t79CocHyXT6jnnPK
 /Idu3B5/uPTKaUDo0Wyjfy4NeYvKJt4/ea0ClUvnOog+ruHGrYuKEiL7WaYJNVFkZdlk
 nEd59n8ckQ3YsC6IDlaowbJ7DCmeQ9mBRI8rV+dAdBM3A5RLYi3OidL+1x9/vNhnQCBq
 upIlxDVCl2gb/rYultYpKi+ATDlFgknFCfEu2Cgz4hS1WiId1E/mngxT2Y0eei4ePbeL
 k23c1so6GUd8bExfvzUh8r5fijFdluQe44QDMGVJFxsF1t6SqPRDE4eYEePysdXlfh39
 elqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093336; x=1756698136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYfg7bc0jD7RMhYfXctm6B2LlorSosuGJgHK4OUhNxQ=;
 b=Y39c6o3hfkl1ve6k+l8mUQ8rEkom+Ncr8QqWqCzaIU5HUSCrnmrw35bI/BDK7YeLcM
 R5S+Acif607q6T2nZpfBl2YL1w2/5Plw2ZIDObgz9CL8uiQUOoxIaDZcSg3ySc86N4FX
 yd/gfE5HjWzZ/Ivn9EJCu3HdRrm3hM+v2v7wZR8vEWsH4UBmOGWybmxEsqnK6bH6H/Fm
 tpilaRIZfXvPxFTwsh6ZUuAKWiIEMhL6czdB6y3MUvg+nek8BpFiNo9aydbWiFu9Uv9M
 tHq5wwesx6IxIJss8Oa1EBHFrGKtymOqxBmy4QgihfqYbOgX7cyKL8Dfq6AqpyjqMgh0
 wymw==
X-Gm-Message-State: AOJu0YyUxxe1bMWxJCgUxrhcRQGnjpUuUPIGKrbYBvz4q6zMbu5mr8nx
 eQQoJtjbgLpI0fh37Xaor026Apvgf0G4RmKAcjPIeJdJBK6MZ6n07tLzceEenUQKQzOwlggqA/6
 BFDtx
X-Gm-Gg: ASbGncsUhmVq5dLA77/4bAwct4Avkx4HfXD+hfhyP8HMN+zQrWWBJKMbuux/YpK2w18
 ajqBjEr+Atrj/M1gpeXf4LSPElD8aTv663KfDl3ICNPcD3QjUszB/X21HLr3lfoRfc+Bh6FOq1S
 bFLJeg3C1BvHzcruzDHfDLoJbmxgwLAc7FlwvcIX5Sq3ehZ+gcJ+qZ7WETVRoaMFLsAcl3lSAL4
 jz4CxgH2tFj7BcU9hrpwLd7T5ZX2BjhGYtYPd4TERTmxTurR8wMt2rnLyjyVaHoUKH4HzmERRzp
 ZPqIqa6ozB+lUpV6RjfsafdjIhu1ieZF3tVpBwtWnvyenRZWD4RwcL1N6pxM6kuk9DfGIQ4K+S9
 LsnAe/kDzjZ/Rs7owjmKuJoDBmlSC04zd/fbJ7rcLdaMnnf4wXuir4tpIuLAA3YS4AnzVQPIm
X-Google-Smtp-Source: AGHT+IGaaIa5IW/AcPZuAV/zy+wzrPSYnk7lHhcmkC6W42EYLGOKfAVP9dEohw90LOTm127f5pa3LA==
X-Received: by 2002:a5d:64ed:0:b0:3b6:c6b:e4e6 with SMTP id
 ffacd0b85a97d-3c5da740320mr8424417f8f.11.1756093336128; 
 Sun, 24 Aug 2025 20:42:16 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v2 14/43] net/qede: use rte_bsd_queue.h
Date: Sun, 24 Aug 2025 20:38:27 -0700
Message-ID: <20250825034126.12046-15-stephen@networkplumber.org>
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

The BSD version has the needed SLIST_FOREACH_SAFE already.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_ethdev.h | 3 +--
 drivers/net/qede/qede_filter.c | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/qede/qede_ethdev.h b/drivers/net/qede/qede_ethdev.h
index 3015c18504..87fbd07ed6 100644
--- a/drivers/net/qede/qede_ethdev.h
+++ b/drivers/net/qede/qede_ethdev.h
@@ -8,8 +8,7 @@
 #ifndef _QEDE_ETHDEV_H_
 #define _QEDE_ETHDEV_H_
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index cecb58c997..958ab558f3 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -12,12 +12,6 @@
 
 #include "qede_ethdev.h"
 
-#ifndef SLIST_FOREACH_SAFE
-#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = SLIST_FIRST((head));				\
-	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
 
 /* VXLAN tunnel classification mapping */
 const struct _qede_udp_tunn_types {
-- 
2.47.2

