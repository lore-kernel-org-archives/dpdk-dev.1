Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B45C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8816240ED1;
	Thu, 20 Aug 2026 07:26:14 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id AC27A40E64
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:12 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2236607a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203572;
 x=1787808372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zD9Ju5Gjj4ehztE6RosvdhQ22i/T7jSZWJPvYJd8mng=;
 b=BEaB1ctT9jmIlsYg4/y1laxtbTLFf+wE526rC0P5NIuVK4x9/QGtcaHr/YlcZM59zF
 r2cMzFEEJuQsSy4yPAIyi5u7IwjoXfH/dqI1cAoNWFBNJAqpxuW0cyrRhNfnts9XMJid
 whGIMrJGAhS8yP+SZCp6pR+EFe0qlSAxGjVVoZm345ffGZraVy9bxdv/PbODwo4Vpimi
 z8MzIn4WzWIolKF62dPzE9naT4L7WdtD1cuz/M5eqWSSAgZCa6+EdVu0IXciYxohSt5a
 YCv22D8DCj1SX8NdF65CeyUsSigSUXz31guzDZK0l5XgD7ykbxt2t1Lg1LjXq9tqxxzr
 6IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203572; x=1787808372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zD9Ju5Gjj4ehztE6RosvdhQ22i/T7jSZWJPvYJd8mng=;
 b=qHTpyP+kq1zubOZEGWih/9O/s892wRhe0xJ3ExIwERFX3SJ7UiQ+ShBA1RrmaSR47J
 KOKSO0dHKE51dwTf/YBrJgaWScA9LVqjsRGw2QJcC9IYcoTFwBgwBVOp8Dz2lsMcoVrx
 UbiYKn8sA7Cm3bHMESja4yFr/UEBch+pYS+fX4SHZkr4hJW/n8i8zj5lUaYPc9TlPHkJ
 jjtOS4LqYmgWtptdABzKB2h+I66Z/Jsi+arr+ATQ4YJ5OiFT9/WVccOXsrZiSAxyjk0F
 dt+IbRZxAXYoAiHXUoba3gMATv0UbOg4xDMwDeeZDasZhYOLhzGUuUYUbW6WcnoXdKYm
 lYPg==
X-Gm-Message-State: AFuF++lcLcFCul2S9ptaPvzzHypN8uQ0Fk28Es79Fwj95wA/bIskJEqj
 4bT/eHk2adkd9JNQofHsBMEkNlrt4kqgwO1bBCXPw93f9mJc0q0xMUtrFyRLT3ezFyCFCU0rBiW
 y3StT
X-Gm-Gg: AR+sD13IAR6M+APJ6o9OxbNWtMAnQKSzBVzcZ+XvjJ5RhO3KzJ/0FAscUpZR0eZL3Mu
 9FaIrvwnIgbiGE/8O5ijEkvFHWO3jcNKBHupxxHnkT+EKFixFtB8tsI1w4EiclTmaxxbNgIrZjN
 z14uv5vRSr2clbzlLTsxiW3HEoGs4OA/z1oyzWWK33SaF5X0vgCWh26fI9RhK4djRZbQbaeJ6OF
 CTZb25M7K48d2Yoq52Pc8cQsqtwNTqeCg9wGkYYxAFBySROfPKEk7JKBOiupo2xtbf2MP3qq7el
 tjETUpVEefVC9GKUYvxD/qylwEUDqWh1iydZxXpOWA8VMDZ5qHS+ksl629YLi0iEeIIUyagivdY
 xaKL1TS1oQP/RBh63ImuSy1i0eEI7uj30woBzLgfw9jfThdiNpcm28gt7vFJPXhtIg1EX+3gXHY
 p61MiFhwGTzeq0Z0NSTxEPlQ3YOu+P7Mz9C087Jqw1oALjQzYsGLK7l9olTQxUpY9zNHyGMARPo
 NNHBhtCzEF4L+waq1BbRLIVreAp
X-Received: by 2002:a17:90b:3d85:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-39580f04a31mr20305729a91.5.1787203571831; 
 Wed, 19 Aug 2026 22:26:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 52/61] baseband/la12xx: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:42 -0700
Message-ID: <20260820052251.1453273-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/la12xx/bbdev_la12xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 1116dacc4b..791ed5e5f6 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -599,8 +599,8 @@ dequeue_single_op(struct bbdev_la12xx_q_priv *q_priv, void *dst)
 
 	op = q_priv->bbdev_op[ci];
 
-	rte_memcpy(dst, q_priv->msg_ch_vaddr[ci],
-		sizeof(struct bbdev_ipc_enqueue_op));
+	memcpy(dst, q_priv->msg_ch_vaddr[ci],
+	       sizeof(struct bbdev_ipc_enqueue_op));
 
 	/* Move Consumer Index forward */
 	ci++;
-- 
2.53.0

