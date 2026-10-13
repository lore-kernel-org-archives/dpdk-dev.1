Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D05CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD6FF40E19;
	Wed, 14 Oct 2026 00:35:21 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id CA0DD4042E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:19 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so23441945ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930919;
 x=1792535719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=D7DUs5IlvKU2/RJqR/Wh6NHJD63cCGvxtry/UpQyVP51RpFa4po/U57NNeDJLVj44c
 oVEHBYJqk/5UYjJMP9B/KW4444EzDSi1Cvzc73pWBgcvAsnsp6SwAJjJJ7bjB2vKtNEL
 wDaBUspZ5nx5m14RJkhHqOoAgg/m/ruhGUL1ssYRfso0+y8oUVcrUtG9iiohBIfh43C5
 f29660wx5OLz/W9n9nDaT6/tdzzCy14AgdeHKlRv/Yxnyr/MO756AQV7ktw4TKmqTCK4
 yNh7Gx5sxZjZ0Jxnbl+N919WWp+vLrqBeT7g4pdcQ4TaIryoqhR9bbnyOlTgCZdq0mtX
 VOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930919; x=1792535719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=oUym5URtWe3XJ4T08G/wFmn2uhIcEK2y/IizSTS1HaQNSBqDbIAEhQ16RZOhUXhxZ7
 kAHfmik2Le3x+dSso0ONjWcwMzHqvunT0Fx5pkdgi0NM+pdsQIjvcyU2WckWZPmRRGz3
 hVgEszxKteOlMtT6HyeckYGwQWk1pqP9RWSHUwmNjXybx6qlvfqphENEtCUKVyiYeS44
 b+wU6HwS9RJYBB4+eB6EMwJOpyb4hHY4wosnTy8BY2+6CY+OOBGI8AC0MkHFS0TGLYPt
 L81V+CxeM6mqyBlAgpeeprdFeVDTJSppFYFBB+pfbBOkKKJa2MS/1jq71sWswR6SnDkI
 a+aw==
X-Gm-Message-State: AFq9FYL84GyYUegxUOrymtmy+chO8q9sLxsXnHUTivB3TT78zsEbfDBh
 fjbYDThiE66Lz8whwjZPUV9Q+WBSTntAa91OeQkK+6dFYw3ZYY9NhVxT+vZ0QGX9CNSHQfy248/
 lplIv6K8=
X-Gm-Gg: AYBFou0LxKcqOhKh+Fnh6x4knbWBVc7nzCk5zMhsYUY7PbyVnq1UAdfpZvfAhj1MB3r
 b/2WEhFbYZdJ9PNU9OxbR7nlh3SznwzPMvgXOx6+af8Lq8B7AXhEpen962e2HeEg9RC4nMuyKwV
 4IAe0dYPZoUsmhY4VwkXg1vutpPhewFpHbYXb0z8Ltyo6FXqgcM9TBg9MYmU3IPLUOr4rdVzGpF
 0xcl9cblYC+ItRCdbbknJpv/85ttveijr9vHrlUZhsXBBQqgL9emGwkJyNIP/LUZtkfWDdufl/b
 HyXjI/Ybvk9qO17w7W6z26h7l1PBs9H0DIFePvQX2Yiwu2NH6v6+SnMKpqGJdFLpYBK9gbgxdOt
 IafVogoCqaHaUXOvkGAkSXZfd/5AB5i3/MMzW/GoHVnl0D9MnkJL2AR55afKUiF+26FuIKGf75O
 8f/mXblmKpF8jIMeE728jF+p7QMR7oxb0HRpNIdVpfdfwK0jLv0GCRK3EWZpjuN53YB91A9dog9
 3sYiuEoUwlAzP1XOw8oCxoAymedcm1Viha4NKo=
X-Received: by 2002:a17:903:22cf:b0:2df:b510:cebb with SMTP id
 d9443c01a7336-2e842835a01mr91054475ad.6.1791930918888; 
 Tue, 13 Oct 2026 15:35:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 22/29] mempool/octeontx: use IO barrier in pool destroy
Date: Tue, 13 Oct 2026 15:22:35 -0700
Message-ID: <20261013222410.2257622-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The barrier flushes outstanding writes to the FPA pool before the
teardown mailbox sequence. That is ordering against the device, so
use rte_io_wmb(). Control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/octeontx/octeontx_fpavf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/octeontx/octeontx_fpavf.c b/drivers/mempool/octeontx/octeontx_fpavf.c
index 6cd0fc057f..7051422cb7 100644
--- a/drivers/mempool/octeontx/octeontx_fpavf.c
+++ b/drivers/mempool/octeontx/octeontx_fpavf.c
@@ -616,8 +616,8 @@ octeontx_fpa_bufpool_destroy(uintptr_t handle, int node_id)
 
 	RTE_SET_USED(node_id);
 
-	/* Wait for all outstanding writes to be committed */
-	rte_smp_wmb();
+	/* Make outstanding pool writes visible to the device */
+	rte_io_wmb();
 
 	if (unlikely(!octeontx_fpa_handle_valid(handle)))
 		return -EINVAL;
-- 
2.53.0

