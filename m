Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E49CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 15:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D61B3402BD;
	Thu, 21 Aug 2025 17:25:42 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 07AE5402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 17:25:41 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b916fda762so979337f8f.0
 for <dev@dpdk.org>; Thu, 21 Aug 2025 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755789941;
 x=1756394741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pPhvjvyGpgn5I0EPkiSDD8fp36I0mwvxLpDHZmD9v6s=;
 b=Cssy3tL084LlyRMKTvEXzIUMe7atGwAzg8wButIDyoKCrJxCfcIv9vMomtVl4ldmSv
 87pAt+Ke7iwltgs0pxBty0bu1xOP8FoEKgaBX9w1456cwezDrlpJSzs407mvlKsoYYJf
 SWJsWWhnx3lM1qBU+oD022ju1CNbDk8yJEbG1Y1WzE8MO0r8NcxaVl1Cs3UOaCdWf6Do
 siFezlnFgz2E2Daef7OzgT2uNxpgb01rTLJWV0fismzMMsP2q6IV5LyigcdmXAGUN/VW
 Hi5VhesT2D+pj4S64rhyjnxBQaAwK7xn7rym/upXdK4YLej6pgv6wcZpN+Gr431k/6+J
 K4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755789941; x=1756394741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPhvjvyGpgn5I0EPkiSDD8fp36I0mwvxLpDHZmD9v6s=;
 b=hLMLRywYl16vNd5k19e8dw+Zg+OKNBqD7cTUliQluFA7YU2pceorKrwvI3vuqv6X5p
 E1YgTNST5e3CD8QIq5dQZxxQnrtJM04jVlRD3i6rPhb+TvW8B88MaWKpk6mMdlfoiqp1
 eF+yXWD8Ec6YF0k/w5FEQEfJfrDgAERNAeWej9waIu7GDnUfRXR2zD5nu/xMT1cMgtbP
 qkueIGbPcntxAyGL6EL2JJ5xNiATc+s5/nlTsqRRlZdNDJd8qwcFaeQiRFn3Df+/bABV
 9CakW3DnHhAXZFscGDUqqIZw1Gno26peSCVZG58wbEOnwVk8qCYR2sjtCOHZ6lZQReUs
 nFoQ==
X-Gm-Message-State: AOJu0YxKBv08kNhbgZpxhWNQr4uHKofOG0MhJM2DIVq5kTZunFn1vWlD
 QCH2mK7YpnaZK8v8+bDFPcJ5yq/eB/ovFpn5OO5RV0VyWX4wmQMIyDd0rkZkn8St0mXAczXhL7E
 JJCWq
X-Gm-Gg: ASbGnctNdODSkPKNZaJUML8R5QlSdWvcpJGo0q8R6KGwTpCik3+BnOnlweKZSP0qK0d
 dE8UVJ0zKlBKLdO9L94fCbWCof4xzCHcGfM+uLF7e4NwAEHgy9BAjraeNu3sFRpVFPJk2W85eZO
 0x5BjhjsI2LmTjyCg48lZdb2xobWit2F9MSsHMmIPUw1fWeMFAc4KsEUR3DOTLV9Leqk1mj8wTI
 GrLxlijQ2peL6BC5hzV7jVpxIYQmkEoAJttq3CDXexnM/lUIC1qg53K0Z7QoWpsmN3zslPbqetC
 g5GEQCQEvAU4M94Ktm9noqYs0zEo4Mk4RIlL+22WXdh2yXPZqNe/05k1cY7NzOFrjsBYzWB4J8f
 EZ9QevZ2obJRyOIybjsM6lxm+NUrdGqS8VP6IWLrTyrEJfCNgEKUbaASWsx6M8qDhofUVirPu
X-Google-Smtp-Source: AGHT+IFgyL/jDXoSmTxlmqiMgCDpify8dx5nXj0RgEVi+q+dlkARkiAdQpuZyjJ4JM1+p0iwlPE52Q==
X-Received: by 2002:a05:6000:4012:b0:3b7:8735:9453 with SMTP id
 ffacd0b85a97d-3c4b41617dbmr2575019f8f.3.1755789941471; 
 Thu, 21 Aug 2025 08:25:41 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077788b39sm12060100f8f.47.2025.08.21.08.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:25:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: replace zero length array
Date: Thu, 21 Aug 2025 08:25:35 -0700
Message-ID: <20250821152536.5934-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Zero length arrays are a GNU C extension, the better way to
get the same effect is to use ISO C99 flexible array.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_np.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_np.h b/drivers/net/zxdh/zxdh_np.h
index 1b8f17474d..31cd844ceb 100644
--- a/drivers/net/zxdh/zxdh_np.h
+++ b/drivers/net/zxdh/zxdh_np.h
@@ -1058,7 +1058,7 @@ typedef struct zxdh_acl_etcamid_cfg_t {
 typedef struct zxdh_acl_key_info_t {
 	uint32_t handle;
 	uint32_t pri;
-	uint8_t   key[0];
+	uint8_t key[];
 } ZXDH_ACL_KEY_INFO_T;
 
 typedef uint32_t (*ZXDH_ACL_TBL_AS_DDR_WR_FUN)(uint32_t dev_id, uint32_t tbl_type,
-- 
2.47.2

