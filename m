Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1CD30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AFF540670;
	Tue, 13 Jan 2026 21:23:43 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id B170D4066E
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:42 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so11704119a12.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335822;
 x=1768940622; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=Nu4+c11h4aFC3OmCOq+NpHEMKuQkdtM1bAWhz4L9HqknjqrgAjCOVzddXJ69tddrz8
 qyJCWeZgW54EOBbyI4YhS+iy82ygZraj4VJ32adQiTajF7dn+bhzmGmPEY3RiF3CAykr
 1o7tBPBlB7dUsT5D03f1MPfl5CW08miW7DNJWceUsg8MuXoimM33yr3A+6Q/gRz4Zb3C
 ksiip0utf1ks2MgNLZPHz+881FDjdHFyw2l2B28K/K8AtLRFc74xFjVI5nmC04gvl/5r
 wVq9wrqq4e57Y7ZhBlaAIoP2ke9wDGyoLkhgpMZqa1TmKKOjCuTYXFIv1ShG7kQRU37b
 RvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335822; x=1768940622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c85AU4P1C3tQ1LXq/w3KTTyJ+OfMU3cUrzEHUq9+fYQ=;
 b=rSceRaNbE0LFeBiy/Ai4jfP3h7zn6FRsoFkNuAYHFqfDDRIu8Z4MWAiYz2hcPRoIPw
 RAEavtR+HQ5fIa9BVT8iRSbLab5zZOCjUNxBs2LBxI/L5wAmtcfE3WuDSix8uPGMjnJM
 KIFDuyPV+shRrYWgBt9y612keFAtgsQ/fKQi8ojl/Zplp24Q8mrPvYE9dN/14iVTu4dM
 1DAGV8IwJDSq2A2etS2S3HmnahJxDBQGLBsvOZD5ByNz2LVkC1as+eSksys9kOy9zX/O
 ms6GjOw0ch+JG3jzBkFJfN9fBZRQMxlw5zr+Cn98mvxGT2uKf1X3LI27o3MfFlVEGgMg
 0D/w==
X-Gm-Message-State: AOJu0YySoKBZL+LMminnuSC/2ve9JuPD52HqkHRm05rXYG/El4j/oAgA
 uULFIjaXa3BIVuHldVxDm7ulhATcLyC7siiAfPKLJ6IczaBpMtO8vYvTJmNyfQqYJbA2isfyavP
 8xxqy
X-Gm-Gg: AY/fxX6RDO3fy/uB/IJugdR/TCxnve6+cK+hX2ELsKmc7DbGCh7f0xT7ByeAZZrECtn
 z6va7yAYdoxVm1l6Si8tG3NwuZVrCMntCLdOAseT6kPyh5HTpN3wBdJqBb5DfWDiwaoTDddLZTx
 hYhTNcO7lW6OBgUqbN6uiMLPwKlaYsWpaMjcZ4dfJx0gNR+kP+2yyqgvBLb0Iz/qVuv3AecBqxc
 pHzYWEtYTbOuL/pp61ive8DTG3ZGALp8lBcFBB+b6b/6+3/GXPeulUom/9RJ3lO9GfbVphZtG7T
 TTl1KFCVL8gjFTk48HR/ICZ9wFmqmokvo/YGmMy+zPdJyf+Sfq2zQhELRjQ2OOex4dEbfJ2Dfql
 PEwkytNV0mkUYHx5iyEaY4JM0BUalQBOW7klGi4oOG0zbVjGYtMuDlr3S+xpWQ3UciBTLmqvRST
 o20quKGIoNshw6tHjhvNEsR54aStrfHR2UhxQ/F1mF5I7K38Ahmw==
X-Received: by 2002:a17:907:3f21:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b87610438dcmr26186466b.29.1768335822130; 
 Tue, 13 Jan 2026 12:23:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v10 04/18] latencystats: add check for string overflow
Date: Tue, 13 Jan 2026 12:21:43 -0800
Message-ID: <20260113202329.35190-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

The copy of latency stat names could get truncated if in the
future a new value is added. Add warning if that happens.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..0861d00c6b 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -405,9 +405,12 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 	if (names == NULL || size < NUM_LATENCY_STATS)
 		return NUM_LATENCY_STATS;
 
-	for (i = 0; i < NUM_LATENCY_STATS; i++)
-		strlcpy(names[i].name, lat_stats_strings[i].name,
-			sizeof(names[i].name));
+	for (i = 0; i < NUM_LATENCY_STATS; i++) {
+		if (strlcpy(names[i].name, lat_stats_strings[i].name, sizeof(names[0].name))
+		    >= sizeof(names[0].name))
+			LATENCY_STATS_LOG(NOTICE, "Latency metric '%s' too long",
+					  lat_stats_strings[i].name);
+	}
 
 	return NUM_LATENCY_STATS;
 }
-- 
2.51.0

