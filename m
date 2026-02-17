Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D7E909C0
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B417F40664;
	Tue, 17 Feb 2026 16:06:45 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 81A794064F
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:06:43 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43638a33157so4183099f8f.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340803;
 x=1771945603; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XtP29O9qOrPgPmy1yWNF0G1G0MJeVpJ/jGCz23inLQ=;
 b=h0iZrK8v71qAj6RpIPJYIh4QZ6HBwAwXEcPX1A4VrBoXi3g7zoH2OhDZnzTsqUrT/H
 wIKglbE4zJs/t2DMCrx4vQ7ZXriVHMUXB2uiY1qTykJzDiwTkWWPgwGLX8N0K1vdVxNU
 gXeMANXyLcSDZm1Hc+blQyvKOFbwQMl2Wj/bjJu2L7K7sXVi+76ciHtyHkD4kIkbVP55
 xlGTOwIPwufHaH+ZnqKWRbNxBCc3i3c0bjg0RMHa3A56n+M17sLuQ4tGb8zbFFy7EDzf
 i9N/DyH9Woe19DIFB50+jeOf11PGbq7lBXYyxm6Q0lTo5ON7ii+ts3BxDte6Kq94uhAr
 23mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340803; x=1771945603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XtP29O9qOrPgPmy1yWNF0G1G0MJeVpJ/jGCz23inLQ=;
 b=XpuLuwO4HVR00sJhlBAtv/M45uSLa3XRxA9qw7JK0o+ShjG1Fg8tNla5YmDD2h7bnG
 iFUQLzC5W4NMfYQtsSYnbXDgfycGPErZXnrOeI/db0FO71nW+uiDnhPz8kJYpPevpRfN
 rNXUnVim/tR8lQY/Lg/fdzsPgoUMbNTm7cam84iZlTuQmXo2AyFCZE74ihbvQY5G/1m+
 3QgHmFFdM70fcF4Ahr+8w8MGDznGkoZ52vqpEk8J1J0HzadAdrYoT3TZbkqfqEbggWBQ
 vYodSOqN6509SOuGErILHhqbg61ZN/02QmXg1MuY/W7gFsFd5X5CooOm2znPFh2xkvN3
 YCww==
X-Gm-Message-State: AOJu0YzeCySw5jLjw5ap+QhjElS0u24E3YSSh5uqTnuH8lX0Ltf3iTzB
 FG9SQcyvM+80C0uyij94c+XRaejpb342rnTLpcp1iwUmVTEbOBrKYuhJtgmA9OZr4Y+qM66EmzL
 ZsA7s
X-Gm-Gg: AZuq6aItp19DYqIXyALgOdj7UNJDxm+dh/pkJ+xN2vM0BqkUEnZxjNXPQ8tJq8lTHor
 mOgB86NrSzyNHW3yIsA4XArs5cL0jgTlSUdTiAndn83hx8rQVvNc2kli8iV5CtsybdXEpEa7Y6p
 p6BQKuU9al6A80/33+LioJSHUEyszIukuy0tXClJc45KQh8BC9gxDV2a4rPGSNgGd3D48eYoJGg
 wfNJj1eIXvGGP9OPUP9WNqsuJP4itI2mxcieSOQum68hHAjnXBe9uzqHRKOHRwrlvYHXI32Z42u
 V31tfpaY3SWlWOoX/zqNhnK8+/4u1PIXYhx4NidsNEdk8knwpqxAy5h53H7R1Aa0fwWHfMaYG4X
 ceKc44BNmKaWJUkbYmV+ibtDszItIlRATldVS8yWndyWs8PJNn/Tf7OOw0u4KLcNOW0nyf8C4Ap
 xDOpxP9HPBdlsV8vJUEQtapfGjqr8NXCih99rjvisYIak2a4CM5N1KVb8wzA8sNw==
X-Received: by 2002:a5d:588d:0:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-4379791c186mr23496702f8f.36.1771340802956; 
 Tue, 17 Feb 2026 07:06:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm28492012f8f.15.2026.02.17.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:06:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFT 1/4] net/mlx5: fix NULL dereference in Tx queue start
Date: Tue, 17 Feb 2026 07:04:59 -0800
Message-ID: <20260217150635.134031-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217150635.134031-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
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

mlx5_txq_get() can return NULL for an unconfigured queue index,
but the result is dereferenced to initialise txq_data before the
NULL check on the following line.  Move the txq_data assignment
after the NULL guard.

Fixes: 6f356d3840e6 ("net/mlx5: pass DevX object info in Tx queue start")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5_trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index f155b1a7a0..a070aaecfd 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -59,10 +59,11 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 	for (cnt = log_max_wqe; cnt > 0; cnt -= 1) {
 		for (i = 0; i != priv->txqs_n; ++i) {
 			struct mlx5_txq_ctrl *txq_ctrl = mlx5_txq_get(dev, i);
-			struct mlx5_txq_data *txq_data = &txq_ctrl->txq;
+			struct mlx5_txq_data *txq_data;
 
 			if (!txq_ctrl)
 				continue;
+			txq_data = &txq_ctrl->txq;
 			if (txq_data->elts_n != cnt) {
 				mlx5_txq_release(dev, i);
 				continue;
-- 
2.51.0

