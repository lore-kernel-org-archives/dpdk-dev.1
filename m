Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B4C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EC0240E6E;
	Fri, 21 Aug 2026 21:30:52 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9DA0440E6E
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:50 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1843556b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340650;
 x=1787945450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TeQOZtGV/AQ28W8Td/uJRmXYvnKMYKoEZ8O7Zo5MVXM=;
 b=djSM9i4cu1gY23w6kBXz+QeQrHsX7U+Hnrsl3Tf4tXcdJO516eKRQMJgKRT051OxXR
 6Ljoi44Yl1v2KyNd2RONcY0MVpLqhSp8EyQBdFrgyqqxP9E33cB1NNCN1FB2TeJESuM2
 79lPY3pRHOkxPGvBj0xuJo+15vGJscff2k/jHt8WC388azyW9KmrEqdYtx50hZw6M8Y2
 lJjaCaUGkVb2U0ppCaa2ODEQnHz8eado4k4QXE05ssFfjjSTKoqiGGPYmZqp+G/AH83i
 Y6Ik+IofMJn+qk7eCr6e7Hh5JQWxEu+UGdlwcuLIL9TZkCnf78IfePccnI8NboOIYvef
 b/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340650; x=1787945450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TeQOZtGV/AQ28W8Td/uJRmXYvnKMYKoEZ8O7Zo5MVXM=;
 b=gCVihbUJ/80uZVh5JomGu3UlZEfes2p+kl5npH+mdYfG+3d0EAD7jKaPEzSQqkMyzC
 HyhzsHMclUzWp3SjMkxV/9NsFH4tDyqLn9QArBslfOM/DjCySbOX5e/XwI9EREkWcnSV
 k9xtsCn+O2AE/oJwjj/rOd7RgC5Jxj69B0ugbQdxbJxaOFtbx401MmlgvkPRAJarUrdm
 N9bh+8n6uXreeiFRD9WCID63Bp3EDc7RqMySJukmCg+nqtzSO69UzUsNEeqGxAsJHOPw
 2mtR0wK0tb/0dz63aa9KA3u6aWt3hdY+HdGXcOtfXXMEJTRaCdpDw6JPvIZ6aSe0B98G
 c1aA==
X-Gm-Message-State: AFuF++kbT1YN1WbteGZpFRlkpS+HzEsUuFyr4ITEF1OPAGdux3gn/yWs
 NvsWb+r9SkGZpIH3O2llR5IYINPmXbZguYb5Pl34SuMV8JFuyjA6oqjPzTDV2z0OoNPhvVqUgnW
 3fEuYZ9o=
X-Gm-Gg: AR+sD10aft+IBx29r8zWFyJzQ4FUDwfaIg6McdwNLAZXdHAY7Eo2RlHBxKOfcetx9RD
 rnDdCeu8KgFZ0tFNltjzQGwX+lVJjAcR3CHRwWM4DCZCw5VOJdCpfD7XMUngXncaTdCaJSSqd71
 8/DJdKrWhci03qy2uPFcDu6sk8Ktpl1woUuoo1uxMvp3FJJbWylj6SDzi8eet7BBmwkgqiM4kUp
 uDE+5R0yimpmLXoErAOJzyHk/eKu9cUO4v75LyGSQwmn5eJ9PsssWNEH5+1Db2qdNx9+VzKKEVU
 kEy/n8bzRipACZBocEVHnTZpv0qiQsbGWoMB66SJs2z60dQiW2GJ2uNTtb0DT7Wi5zOqhYRjsbl
 kpTSChzLxILP/p1GsFYdlDWbrjh+338lJKMVsVK58EWPG7Z6Y6AoxF8b7hYwIRnxZNlP6/K3qhh
 ftg3ZwVeSrdh31NMIKoACD53VBmBLlhtqUODQAnn4Ad8VZONzBl+lDChHPk0f0ahBsIqYdDQFkW
 QXOSCDUJUjBq3yDLTFxYbqEdro=
X-Received: by 2002:a05:6a21:60c3:b0:3cc:dce8:1109 with SMTP id
 adf61e73a8af0-3cd14c6b137mr20685066637.3.1787340649656; 
 Fri, 21 Aug 2026 12:30:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 49/68] net/vhost: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:44 -0700
Message-ID: <20260821192646.146382-50-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..97d60ecf5d 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -13,7 +13,6 @@
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_net.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
-- 
2.53.0

