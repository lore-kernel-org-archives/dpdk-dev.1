Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FDC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7F8A427B2;
	Sun, 18 Jan 2026 20:14:10 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id AC77542798
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:09 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso4856258a12.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763649;
 x=1769368449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=922ASratHNyU4hJ/CODFTaKG0e43B89mH8dkNr/4bCE=;
 b=LhMz8U33Dk26D3Ir0lJNtabcRAx5ZBSlnM09CCGOkj73soIGdMMfqFOYW00Y3RYG9Q
 BmdM9fqKh/nszDliYxvTcP7GlAvrMBf0THYgWY5d/NofTbo5rKu86zIGsKIl7yMff0t9
 uBOidBJz4BXYT92ocvEaejt6dvjMRqHFWprt9cZ+zZsrtb4kT5JcQ5pNQG51tNeGqFbg
 EHGKmcK6kzrkr5oV7yg6TsGajp1PADFnYxBNiVft6mRLQjdMNW7Jzhy5DTabhXRw1XBU
 LFsRMMgnhbkZfP6UMqv/WtpiFJQkQ0YsECFovFH5Gd2e70+Pluw3eJoU9+pcgVyVvNeU
 SeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763649; x=1769368449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=922ASratHNyU4hJ/CODFTaKG0e43B89mH8dkNr/4bCE=;
 b=TO+wQX42gpqOl/c9n4d4SoMgapnttFzBM1oNazdKfwFLJvqMRxNlUPGY+K/C+93K52
 iUPo6Bx6vT/90xgHHcK6IMtQFeBqexbCcUm1lsKffESm5vkVo5GFG8it2r0HhGyIykyI
 vCpqMFBP79/Mm6e/makgNACIUq9mdi9YHxxlQCZs008AzLP5jxczRNP+7709Eml+ZmdV
 jrvGTV7LP4irgYH57BXw1z8LR/iOym4tS1yWx3oS5Z7S5oiibLQDxtKCTy6YZQxyk4Ka
 Im7tqI1e4YaTm3ILYn04skf5SDGN+FnOKdKhg5Ps8jIlrYdnKSu6iHxF0i+TC2z7zNN9
 m/Yg==
X-Gm-Message-State: AOJu0YxWfrKJZOa/D5+QGb3mnvwXCCZVdzJOPdFT2d02QtdPQ8UJbkCQ
 9mpeNwsWU+8U/bq/VcOBXhKBwUI/l6BJq70BrK+GBCF8mnfFkjiMw/9uYrMy+D5dXDFZPH99jWe
 HpGK3
X-Gm-Gg: AY/fxX7WYDdQhjWzJ8qniAj0ecxTbuEQIPuTUpDQhVH00VQnl6jTWUWdIPXE58e1Uou
 3hpcCJaDkfvH6H3SjOXd1GKWr2kPB5We15eAU+dWIoizmrZYqqY2bED3pVzB/3U4UjNqrT2652J
 1Dlhd57Dljtg2ZioNwTrIVMZGxfssDPJYfAn4prGzyPQ1WGRztbd3cnjKDoXiXso9KT+MZlb8Yb
 ewtNHz/chdLA2ZeT1q0GS3loSXzgIGRQMJ1inorHT8gmNHrlFCfM+xWmugVe7gEa7wnXzhDls57
 DJhrINy4xp/Ss6uJfOmej02i65905LGTPAppZ0IooQv6xLX/tNFW9A6IuUZTZrPmZAjQKf1FiIr
 XEMZCzGGKSBVBi5PwcgNhxvWNEQCJIwOPWJS3pPn7iupVlQLT5B2MDDsB7K9BIV+qK0Uq9dzPyl
 NobqBm6nTlNrahd8mdx7nTiVglhpK1Q4GsgB5O06fDHBCbUZ4O/Q==
X-Received: by 2002:a17:906:9f91:b0:b76:d4d0:68da with SMTP id
 a640c23a62f3a-b8792d36131mr701062466b.6.1768763649183; 
 Sun, 18 Jan 2026 11:14:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 26/54] doc: correct typo in link bonding guide
Date: Sun, 18 Jan 2026 11:10:29 -0800
Message-ID: <20260118191323.241013-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct "down stream" to "downstream".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 4c1d69175e..8e5a651e39 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -48,7 +48,7 @@ Currently the Link Bonding PMD library supports following modes of operation:
     packets in sequential order from the first available member device through
     the last. Packets are bulk dequeued from devices then serviced in a
     round-robin manner. This mode does not guarantee in order reception of
-    packets and down stream should be able to handle out of order packets.
+    packets and downstream should be able to handle out of order packets.
 
 *   **Active Backup (Mode 1):**
 
-- 
2.51.0

