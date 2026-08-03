Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA230C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1FD840A79;
	Mon,  3 Aug 2026 18:53:26 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1F017402D0
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:20 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so49992855ad.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775999;
 x=1786380799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HZuja1SMQv3wIypwVyshpuVu+2o6oXKLb+dHLPNDdYk=;
 b=SkET/8gaQJhWMSJunq6bd8R2NhxOiAGIGuTxK4g6C+6CVe+jb+Ljc2C72zYVN6+zGi
 7c27mDdrL6plP2WUCkswaEFaWmcda3zZBxVxXscmlyixhv3zQ0ox7ymJMmoJCQKUhAwE
 A0BQJOF2hvkbMcmkx0rqDbcJPMBmfVawUtLD/h3y2H+XD3q+k1zokBGUp2tb8uPy6Iob
 oDkCPdjd1Go70T66dmDM2RktTmZmpvEo2UmxzVxumtgNC2ALxY2zmmsHwRIT4glJCrAm
 +UpYPm7my+9t1a4Nc6zJxk5k7Nx39Xhyj6Sn1831vlYF28GmrQVstoYi0UfmkcQeu0/W
 PKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775999; x=1786380799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HZuja1SMQv3wIypwVyshpuVu+2o6oXKLb+dHLPNDdYk=;
 b=ivQQ5NM4c0ZUj8/rYFqKYUNy6vubfNTVpR9btRMeWZF8dd0+6t3XiSSX5m1fpa31BB
 tH8doJ91gjxKjmG97k0agxhy82/994njhCl7hApMC/sWRTPeYPUszbZszai8Vg0j0HTW
 qFbw7Krm5GemAwJfnkNBsk01yjN55LwA/pPW5kW9GmFyS8n8aahN4hrheSewHW+ffHDn
 0uATqJqpHJiT1Di6pdgmD6rBJ7RO76U+/LgodZJTOY5oWTxWK/4abHAJDmcgRTzTxf34
 PU4CRhx2RFs5ZpWTKXIBJK3fHzP3oy+qFr9nYTHcaRqc6bWb9Uf8TtB6eNxdiaKN4Xlm
 P9fg==
X-Gm-Message-State: AOJu0YwhIvJ/7XjG/ZWEtmiiNrBm+XBrz7x5LGH4duuMRood1sxw+gG2
 DGiO9P0/XYXFMUueVeLTv/ol5wh/9yZI3exJOBJ/E1fi3Ujxu6O9t2FkW7jXGemgN83/Wix63IE
 zuycd
X-Gm-Gg: AR+sD11FEBQ27lOIgBMabX9ISHIt1fpWENofZijwtFE3fJpkoNdz8XCqrhpa2Llw2Tp
 sXKeiTNh0G8rEUUERzOEJUhy5BQBi4aJJBHJjB4mnVbBH5a5K9VbJh/mN2LoKhMkoNmv+OfmF75
 dcVlD9BL2v5rUG6ZRLlay/PcGKktE2aQ8HLvzeq92xLuEIF618FQSN2PGrLqnfh2iHXA5QKbV4P
 jOATr8LdtQpzRmu3apMc5zJmxOlRfyDGoApQ59+Hf1g/bxWhJwvG/yfKwhV2U54PxCPLEUbayGP
 TQab3rzKbSAYPP3YPuWgmveaOZyo0RUFhT287YRKPZvGEYEnB2P37ktklLzltMH4OWawlKPe9hK
 TyUVZyjCc00GZK62XvV5GGJ+BWuNSeY3dlupZs7WEsQHN6ZmrQDwtD0Djx+0PI8ytZ2bz2j8kXx
 35EnuNjIJiFBy2RoGaptPIX5or7c9/28K/mhlvnSsvZA8G0+aTLCY/8WpPkO6+TZGgZqyPn4d9J
 d+Fz/jPGPZGElEMWPu2qwb3b5A=
X-Received: by 2002:a05:6a20:7faa:b0:3c4:3321:4ffd with SMTP id
 adf61e73a8af0-3c92a5d4da0mr9594752637.20.1785775999243; 
 Mon, 03 Aug 2026 09:53:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v2 12/22] node: get UDP header
Date: Mon,  3 Aug 2026 09:51:58 -0700
Message-ID: <20260803165304.289869-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

This library was getting UDP header indirectly via rte_ethdev.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/node/udp4_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..fb62822b76 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -11,6 +11,7 @@
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
+#include <rte_udp.h>
 #include <rte_lpm.h>
 #include <rte_hash.h>
 #include <rte_fbk_hash.h>
-- 
2.53.0

