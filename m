Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF42C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F2D40693;
	Fri,  8 Aug 2025 18:58:54 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 6D6EA4067C
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:53 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so1295849f8f.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672333;
 x=1755277133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=vFUhuh5+vufYNnSTTNufiiZe8axUxCaS9PdQsTmE3z6ByhCo6P9INC7YCFgvz6R/Bs
 wrKwXjzL6ZVtzKiDfnuFRKaDLpvBIBcDSm0y5cqeUN07TgEJ+RcEKH9bYN4mvTwKFKud
 4TWiEYX2eY3pmSAZocHpn+pRMJTxAwIKi3e5tGF0V0Uz1Cq7ZUuc/a4549rtl+vXh2UV
 MvNv+3+bLTDZtUK7BRvzT22Fv8+pD8AJ2p80/3uECK0h1cPebYaGt4m7Qzovbh6YEJ7T
 wpQdkkzffNF6tMVILHxurPfPhb0mdA5s6baFsAyd6IAxRZur0EebG2KMcvhr4GPuJW+V
 SeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672333; x=1755277133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=grGjItXae04jBG5SLqLOjShUhPFdJrzeQG015Ez4tjRRewoPK9uzNMhLlGlkYA8Dil
 /Pge3Yd152/8iHXDFpIutLS+wYkWNwP4zeFIKNXf1qjbw3C+sIhPT7b/bvdcp1p8KeyG
 exv7EEc2wa8sYTPRzNwWkL+gVH7ZdrKVlawgOd/isbFsZ6bqlIbwY+5i2HhuMsWRubi/
 fKHeN2ny7Yu+re4c0txuuQc65MQU9O4XdigYbVTxj8MUD21LC2kobkGFD4V+insrVShk
 H4sWFWQgHHEGEOnIU2N3H/7ad2TtB6yO6XkzFCOcCWgyS5HxBuRVoWsTtFruiqFbsOYc
 3NZw==
X-Gm-Message-State: AOJu0YwZ1WuyPokIbMnFSyJQ5RrQSCc1Nf2a1A9hBmfnmwHx9JpyLyXG
 8hHzx75FOMcBqx3HsPBhXNSg+EdvUwXBVjx99IkpVcexbfwOoxPWr4XFEvz1ujtS+ZvsVwlx1hY
 /p0Za
X-Gm-Gg: ASbGncvY7iuEVBpNXPjZB/oEaqgU0sOvLUMtzE+lVdcpYMfJjl7cq4wAizz/s8HNDbx
 xFRTDqihxt+JfcthRTR1Lobj0vz5zrTHVNO+dS3ks9CCoYUu+Em9wJ4Ws0Npel/94DxLnQ9kw+9
 /6M8ER+cRctdCRNZKLYMyZ4SpDodkOlp94OxxanXEnsXvjQSoqq7WgiCDH1wfRMXoL9qHxPKMUb
 jYuVYvnSo+GDSmmDjzAvbzHM2x0793bRbyYauMZbDbU9+sNuZ6F6ZaaWAoKKrIT/fI7a2ASMPfx
 7YKP0NH1CVh2JfWCAjx81GOMgDPN8rruKhH8OVe+CAwxOVmm2nqs9MocCV5xh76+2VflFSgCrLt
 nSA7uS0MLGg/ypRlAtSA3svHJ1b4+2pZkqq5XDYmyEhFVpGKkj7ftnP+gziAmk1vJqsYVPkmB
X-Google-Smtp-Source: AGHT+IEl+hZJGrQJIDmjz9ub8naHfQ3fH4nNOjeb4PWukX2LfVQDw+w6CuY3Zuow75M4N87dfX7weg==
X-Received: by 2002:a05:6000:250a:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3b900b4b93amr3029815f8f.38.1754672332974; 
 Fri, 08 Aug 2025 09:58:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v11 02/14] ethdev: make sure all necessary headers included
Date: Fri,  8 Aug 2025 09:55:40 -0700
Message-ID: <20250808165843.39075-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 1d423290f1..000b8372d8 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

