Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A550C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C1840676;
	Sat,  8 Feb 2025 21:32:20 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id EFA4A4068A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:16 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-219f8263ae0so58989945ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046736;
 x=1739651536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcXARBxuSrL/585OvNO6UlgMWVw5mWFsybo55mU5d9s=;
 b=iwU0urylU0Wk2cVmg9iJTrGVSl7hT5zMO7sKyYep3r8+DOImWUwDffn56QqBh3NbQn
 4+TMb7iFvdN8oI0jySOWgIfWiS0MMxSui/WUnFK3UeIJl+QFBUhqhewuq5ZwmxUI7zFJ
 GtoF3FbgAi2oTKKmRL/4tdXP9w9XdYXL5OEpWm0WLLifponAhnCftxaQ8xx+Z3+QaX40
 kYS/+SkaZbIMbk0FfDIai8JIg84rZVcVT85J2gunAaBePqb0dGQF/+os1y1vB8whplCP
 97c4cPXmyk7fyDQDWkzU6lPTaXccHCz7vd6yFGi3Mc3/xXYMkeqEFOmN80VaKOG4E7Ig
 64OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046736; x=1739651536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcXARBxuSrL/585OvNO6UlgMWVw5mWFsybo55mU5d9s=;
 b=AGZNQklnNNeYXiMQQN0XUHbuihnMwy2fKA9RSLytM+HK+RChSPVXCNNbNLYqtGnfgr
 aZTb5GDFZxnPTtEwxNiW2Yv18cw9vbAU67tDWRZlsL5pucrXnGG5NyvfqOPWDS5LzStz
 ydQo2+tWx4BuQCbqEwzNYvS8bEeQrae7JIEmlfJb9QUVxQUtN3DBaPH8XSD8H8QEdk89
 yTUgW3GokBWt9dWVz9rRdkXS4MSHqENGjNAj5Nqjs4+ZfJSJMjWm8qRoVU4lXLF2TLK3
 5yLaU+beVv2zGfFj/lr7c+SiHGkYVW2FS4CSweSlAliQzSMdbSOqbDKBCBFTmVpnqqpT
 0jsA==
X-Gm-Message-State: AOJu0YwHixG29rZ/c6RdRaetdatRWKlUCSwX5tGCCsE1vHpU47il1hwB
 t7wu8EAoCdn8KFJau/Ej0Rry3jroY1a11pB++j9+VAUicEtaLyEnEv6XeCPEZqpQb1+S8k9gc4B
 Vwj0=
X-Gm-Gg: ASbGncvyRz2MqU+/upF3XqFZEvnBmLsB1l+WCsgpvvbST0x0elGHIIRCXb94a18jSzt
 kdma8j+N+p+ZlSJs7WzcNPGUCu19E20UMDnk6MnapllBXUAtTZK8yqjVzYACVW7oJzayAeQ6KE0
 mGzV3AYopxifaRHW14G53kcvbVDowa6Z1CYDoEsB9PzgKjGrp9/LBhzxVYsodQEO/nUl/4L9BGs
 U9xro3Wr0X4BcdUeF3GBA8OMuYUD4UIfiGcIlBadOhWOTGOvF8wG/+CQoPxn0N8pbJt9hfJIpK6
 uaDtEGtSxC3+0FwK2zm34SysdriYFkkSSbWoju0MduTZTDNfYFQ/qGPOW6bBRsXXoveB
X-Google-Smtp-Source: AGHT+IGlexey7GFBFcP0HXdTpDklaxXeys7jAQTw06BxIufurGMLDced7r4t29b311ig48uxRkv8lg==
X-Received: by 2002:a05:6a00:3029:b0:724:592d:aa5f with SMTP id
 d2e1a72fcca58-7305d4ef721mr14390058b3a.19.1739046736191; 
 Sat, 08 Feb 2025 12:32:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 18/32] mempool/cnxk: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:10 -0800
Message-ID: <20250208203142.242284-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/cnxk/cnxk_mempool_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mempool/cnxk/cnxk_mempool_ops.c b/drivers/mempool/cnxk/cnxk_mempool_ops.c
index bb35e2d1d2..5c7fcea487 100644
--- a/drivers/mempool/cnxk/cnxk_mempool_ops.c
+++ b/drivers/mempool/cnxk/cnxk_mempool_ops.c
@@ -103,7 +103,7 @@ cnxk_mempool_alloc(struct rte_mempool *mp)
 		struct npa_aura_s *paura;
 
 		paura = CNXK_MEMPOOL_CONFIG(mp);
-		memcpy(&aura, paura, sizeof(struct npa_aura_s));
+		aura = *paura;
 	}
 
 	rc = roc_npa_pool_create(&aura_handle, block_size, block_count, &aura,
-- 
2.47.2

