Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C1ECD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 04:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 410CE4060C;
	Tue, 19 May 2026 06:44:45 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 9952140296
 for <dev@dpdk.org>; Tue, 19 May 2026 06:44:44 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so1737027f8f.0
 for <dev@dpdk.org>; Mon, 18 May 2026 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165884; x=1779770684; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjPODLZZjKSH0jJ+Gu+rURcWdKv8JqVCKlk7QakaoWw=;
 b=hp9/LxqaNFl2rjREB3Fb9nKJceCsMTc0EvTLV9BIOmfMA7F0I2ytHEX6iK3BYLeLcx
 mCOt927YVXS9A7z2ZFKVhLHOLqLYcnw8n+3LHNzf+W2TFGHCFSb/ODgz8ot+ZVYpTSb1
 5BrIcJ73bvzl++587GThM8/jG6CFNcGMxxxlgY5aSlOfW7YNa7m7A2B6z1IjAPxPGEow
 NRkAFg3jCVJR6ZiloSRp/htUOlHftlklS1QA0a/5Xt7d/j0hcSGsWzm8QskazBjOyv60
 UGQ+QVUYhFmtExTSJPq01uX/PjKeKxbpB3NDoK/J1lPgAWUbTVgMZrBoQsa7OimI6qDz
 EVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165884; x=1779770684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjPODLZZjKSH0jJ+Gu+rURcWdKv8JqVCKlk7QakaoWw=;
 b=JdUyZr0ouc3LmvsowSYQ/lVKbrfbQ205aBxHLjwDRm0gJwY3D1GGJGRDvUL4TJKVAd
 bJviQRA3KoH9gsQhdWsdREUmG4ozG7aui98BXHso/hmDvCm2zT9K6BIKXiaCNSOnwZO7
 7IoWzX8LLbGqDNEwH3TpdSS73VdbsBaKj0R9+twiWIaqK6XTaQ5YRa89GGQLD/sIMcAQ
 5GrCq/lrfW0AwckqPbLhIDvYSxtvZ69ILUDnex4BMQN2sCDbyzgpUEGdTSYeX8M224MA
 c0WRRPACl2hmHq+sT56cw9IL9wBIPyrkCLWoanxxOeDJAgZlRN9VdjzZMxPdwMrHgmGk
 OCpg==
X-Gm-Message-State: AOJu0YwJkZ4dLtJ7ugVkEmFwteK+UFUqDtFlLBB//BevMrZzA4+qTrHO
 JGEyG9bH6GwGeJdKJmLXIxWZjmIsyfmbPIDOx0neUCVKt2SlTMQKmX7P+N00NmeG
X-Gm-Gg: Acq92OESyEF5/aapIA6pfxo8qqjNMPXOB66T7sHHAjN8rdn4dmy9iubEF/e4FbyJm7q
 99BaYxSP58Ny6QAy7vyQ+KkdX3hTjASYHDn7wGEMULoXQ9lgztom8VUiVF9fRY+ccVSDXs6l37o
 V5IsQab8CbrGdyrOZDaBkJP5Rvypr3Z4M9PRezL2StpkByx9LMQZnxzeqwhrRMEgqSvGDYHDLYD
 7F+VZY6HeBGC1cu9E59U5XA1vCv04dQHAECI8RBcHFlm0yQrAgKdPuGJINr5+PkmNLPZdjMAS1r
 SyQ7u5URJENCZfqB4wlbiI1NXYJlmUBzFLr6oMkLhgHPND89q3UPKyg863IoM2hFWCQ0gnbfogq
 JhuPSG304lFDpLxZMQZlSOwD2i0QvG9+g0EEKsmUzvsNm71vkHI7WpH6q46s9qlgOmClbtr7LqG
 thkUYou1gYZR3lsOoh32EMXLXm6ghkvL14y2sle+QsUDAYzA==
X-Received: by 2002:a05:6000:400f:b0:43d:c95c:4259 with SMTP id
 ffacd0b85a97d-45e5c5dd488mr27430517f8f.30.1779165884120; 
 Mon, 18 May 2026 21:44:44 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm42842861f8f.35.2026.05.18.21.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 21:44:43 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, ajit.khaparde@broadcom.com,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH 2/2] mailmap: add Denis Sergeev
Date: Tue, 19 May 2026 07:43:44 +0300
Message-ID: <20260519044344.9544-3-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260519044344.9544-1-denserg.edu@gmail.com>
References: <20260519044344.9544-1-denserg.edu@gmail.com>
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

Add my name and email mapping to .mailmap

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4d26d9c286..3d0fc8c7da 100644
--- a/.mailmap
+++ b/.mailmap
@@ -373,6 +373,7 @@ Deirdre O'Connor <deirdre.o.connor@intel.com>
 Dekel Peled <dekelp@nvidia.com> <dekelp@mellanox.com>
 Dengdui Huang <huangdengdui@huawei.com>
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
+Denis Sergeev <denserg.edu@gmail.com>
 Dennis Marinus <dmarinus@amazon.com>
 Derek Chickles <derek.chickles@caviumnetworks.com>
 Des O Dea <des.j.o.dea@intel.com>
-- 
2.50.1

