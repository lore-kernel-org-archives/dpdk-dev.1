Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA0CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 267B340DF5;
	Mon, 25 Aug 2025 05:43:01 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id C2B5340DC9
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:56 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c79f0a606fso831954f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093376;
 x=1756698176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xysQpGuqzGeDZZWRxuo13Z8VK1piMz6YCaWotiN+rqM=;
 b=kadBTnijt8b09Y0zrKNXx3bbFck6J9YlTcmppEfDDdAc+BzwiOap36xoVnifk7pL2c
 ROp9lMqqJOWCyfWY51MXR7JjjcAyCDwT/xdTQmARtVsQOyCHOIjUIh1lFo6PyqV7oD2n
 bU7RkIymmYMpnN6f8tEzh5IhDfVfv+lub2qZ+ItOdKWvr8B7BG8sFJ+2l4RyZQz2BYQF
 rZXvA008GcNWbx01GJnM8s2yXmitm0BF+49MqV6yTIBt2TcI+rOymBUwyl+9TbZvKeTZ
 hW/sCiSyQLCfUQrbr7rNq7tJvUMS8IJQLIbkIfFyEsT0N8yCduANgWJx7fkwT9NEvT9p
 rRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093376; x=1756698176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xysQpGuqzGeDZZWRxuo13Z8VK1piMz6YCaWotiN+rqM=;
 b=SbCeuEV+wfPbtWkPFLOmm0fQFLi5jDHS0q78nTPhrHKChLg6bIt8BER/jcR/mBhWgQ
 qW6GHWWbE04YdLOyEfGiaTYhzXagCZoaCkK1VroOinZhewN4RTLfJEC1fncnm9Bi/mji
 Joj4pJFGLn6Om8VyM5SGT3M7VmVd08eU+6GevO35HrKhhVSgPO1u5hpKdYxZQKKYQbxq
 uJk668/15uQ8Dnogvuaf2IpOwaTbL1bH8Ga4YyxWB7C6Av4Gk1026qjq4bCNbquN+ZBe
 MCcWFZM3s9MN6FZfin7DpwY/eGQN0HVR3b+9wKC7i/63r8Xp/cA9BIjmF3v6w4U547rq
 PU2g==
X-Gm-Message-State: AOJu0YxbzNkKFO0lkNhaGF5hzwhvEsXncuRQA8Lzv9+2WIYTlZVZrio1
 I6QbCYsuumVsK4BewRlNw4bwplgfNYas7yto9GG7otFlL3qQ7iPYkAEJm5UzxIb5SOmKbHyx+fc
 2OGQS
X-Gm-Gg: ASbGnctcpTXNJ5ABuLM/DZEBCxGL3ISnMj4+Xz2z6IUxpj0UBV4GD4q0d+AcOpswx1W
 fQdtICSwvSyMFLH2WlBOxep09W9N1ikDMGDEUqZdQuI3ySOH2/qcDxCdiDwAxGeaH4RWaXhcudW
 nlvG3G2AiQgLUzpPYrj9unyXHQ3JXZ0nVkdCZ4B3AaWwlkv59xO+vdoOIxBiZooHPGakwkKlUOE
 xkj3/AQd0+5JUgf60NRYJauhraj6ax6JLk+g4sVby0p88t78O8epIHEDISjxm38AdPVw4b7O+Pc
 1NuzfnZfVHpXCGXSvt99U31xZ8CxDfOAIr0rfdc0ncLmN+hNnXlCCKMg81hkbW79ob4LOGPx+KC
 n6FhaLRf0JsD6Xer8E2Bhnp7JuwKx2m2lUkge0eSCI1hDieS8IHYktFvkeb8CVrxavoQy17wm
X-Google-Smtp-Source: AGHT+IHi15ticeRHjC9iv1fjdSGYSnXezNt5uoyNo9W3DCrrozhQqHiXI0m9oRXiRl5B4KhZwPRZgQ==
X-Received: by 2002:a5d:588e:0:b0:3aa:34f4:d437 with SMTP id
 ffacd0b85a97d-3c5dd8a9fa2mr7635870f8f.37.1756093376423; 
 Sun, 24 Aug 2025 20:42:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 33/43] net/vdev_netvsc: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:46 -0700
Message-ID: <20250825034126.12046-34-stephen@networkplumber.org>
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
 drivers/net/vdev_netvsc/vdev_netvsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..7d4800af6b 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <sys/socket.h>
 #include <unistd.h>
 
-- 
2.47.2

