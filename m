Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5835C4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EF3A4068A;
	Mon, 20 Jul 2026 10:01:05 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 1D9C94068A
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:01:03 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so67933835e9.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534463; x=1785139263; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iabB2WJs9J4C06owAffS03sRSIhIYkVs/b8Vm7Oqyws=;
 b=m7mqDed+Rv+e0CrxymUoFkiLEe5L3sxziINhAi8dJ9H7J9aRjtC1CZdeYper3oUEh4
 T5pOAMzexNd/K0yEMOiQ60NMUEnjmG+PtggdX047Ia8kPnlOL7H+kfRH2lkyeWHMDIgh
 uKvIG6nXPg09578j/XZeSJUZ2VTBSdiw1UwaB66w212aQyWftOJBBqUy8IvSv0x1fhbR
 PHh7DP8dmnvsGdptl+ZV0X282J7mTAE0MsuY0J6tJnpo61NUvE3iGVSwK+I3TKboIWvw
 KtLzsi+P/vOP5KEbBIyonGODMklJNtzr1YHSy5YIL/G90BmxOoWak8KNRT/bzRXVi0Ch
 Nbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534463; x=1785139263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iabB2WJs9J4C06owAffS03sRSIhIYkVs/b8Vm7Oqyws=;
 b=AZn6lnfThMxVBrm/PpYM7Ws7SmZ1TWrjDjJsHsd5RTc9w5Lhx9uPTsnAJWwtaJONUC
 uHpuxglnmGWZsl35NOjauz1OJwijJDDfpJByBU6obL6YfeHdvNcNO2HHzEvIBT9kzEab
 J1l0a1m50dRLl21cG6V4p33X39/idYfBMUJqF7V20M1Cocwn6CAB8uE5Ye/31I/TImDh
 KEoyEKswCFxTvd0luDKRcoji2PPAP5u2mtbdO4E8XwHbsS5JpDAAhPGyjAy4Fwp+7aeR
 9Z/9KM3Oyj1joNWCGViXcf0o9zs9m6QXjr6rDyOnb9J5Z9HZW3QIb2G9dlD0pS8DBdnj
 1r7A==
X-Gm-Message-State: AOJu0YzOwV+CpgondHt3gxxlT3ng+IkmCrA37in3uE242DxSIDa9Hz7+
 bRoKufzBXFXzFW5F0gwY2FvzcZxAItMOnjdWDp+LtKcFs0eQS/ulEZmH3XRbhQ==
X-Gm-Gg: AfdE7cmq3pFg1W+lYK7MVeN12v/5edsOiYc4d8Ce53Vm0jq7HxNnHqyC40V2tjShiQM
 drJZvDlocEafs2D/LsuCNxLBvKYgscXmNxUXaZ7hfPdp+/eL01K6Cljvt9eF3HNuMBm53pME0zN
 dzE0IW75c2PKv/j8dnMgvk6HneIxRmVCt9JhnxEh0B0TKUWbLR5JprUGk2tIftGhmCIb2vCaLis
 vq+9dAAFf2Y+8FPPpCy+W0tCGxCBA2BSjZdVvyyNVhova2Tazx7MdiFuJOeWD7tp/M6wZdwRmpb
 ao72n/94Z9qrx4zbBNhG/bU5GM3sLrPMujlZKWuuprb06/MDr6shU+xmmQsh1/G+/4ze6C+zLxx
 ayjE7xTgyQ8CflHl+7NFgewUA+Hha2hZhMGrLEcZVeffoE7+AZNGR+ZOIDJc3/7LaXF4bvhkH4H
 TVj9tqknDlfrnEMsAMLP0H7nmMoFTz32jeQmjsFhKj6zNtPUqbeKA=
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id
 5b1f17b1804b1-4954a40d0c3mr140326745e9.28.1784534462352; 
 Mon, 20 Jul 2026 01:01:02 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c841a0dsm220551625e9.5.2026.07.20.01.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:01:01 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 4/6] examples/l3fwd-power: accept shared Rx interrupt FD
Date: Mon, 20 Jul 2026 10:00:33 +0200
Message-ID: <20260720080035.673782-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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

Some PMDs deliver the Rx interrupts of several queues through a single
shared fd; dpaa2, for instance, uses one QBMan portal per lcore.
Registering the fd a second time then returns -EEXIST, which
event_register() treated as fatal and disabled interrupt mode for the
whole lcore.

Accept -EEXIST as success. NICs with a dedicated fd per queue never
return it, so their behaviour is unchanged.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 4874a55de1..fa64e28e5c 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -937,7 +937,12 @@ static int event_register(struct lcore_conf *qconf)
 						RTE_EPOLL_PER_THREAD,
 						RTE_INTR_EVENT_ADD,
 						(void *)((uintptr_t)data));
-		if (ret)
+		/*
+		 * Queues polled on the same lcore may share one interrupt fd,
+		 * so registering the second onward returns -EEXIST; treat it
+		 * as success.
+		 */
+		if (ret && ret != -EEXIST)
 			return ret;
 	}
 
-- 
2.43.0

