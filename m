Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABECD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:32:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B239940654;
	Wed,  3 Jun 2026 07:32:31 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 655D0402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:32:30 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso4054535e9.3
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780464750; x=1781069550; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXpZqeMCbE9Bye6wZciR4n450Ip7mO0CrTlaH7e3VwQ=;
 b=gkrOL2mZiMvnu7ozLSu62Yjd+S77IC2Iu938naL8wGriIywOrPchYALgl2JCcS5IIz
 Ubqk6KNm6i/KcTw+vfaGDyKsSWAKJ1E8zOTLVCEgrYkmkOKHI947aLdIzJEKIP5Ktxny
 pecWvg+IwQvegRsIFDXJsJb2si3uvYG7xTfpcL3VuzR7uKYo4afKqC7UKhyUORfYEzY6
 XqsKhy5KzVqAcqO4Qba13/xmPgHPCeF8boLKISs5mTrz9DX9Y7/Sy0Cw/yfK8htfehyg
 xuHOlJPsH1McdG+80Dy/AHOw8soDGe8V6mrM2tmrwZTM+ws+svZmj+EK1NmtvuoHQAys
 BoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780464750; x=1781069550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXpZqeMCbE9Bye6wZciR4n450Ip7mO0CrTlaH7e3VwQ=;
 b=pbIkIzRoev/yVoq7fWzJPMss3ZFMRwKYiCScanwNaQPiLPtQFZ0e2UziMwxwFSH3qx
 qwLCbpxUgkTIv1vG7T470XY1ZvIlIZheil5op7dMz/VRT4SsZfeTXCVGvx38irIY6wIQ
 kaF2cw0XzpSqNmFOa15GyGuCDEDHU+7eG2mFKM0CF/O+lDirzNnYjihcok5lYHPGaw4V
 sMhls7O9opy67TWfIDrIO23lvOypITRBJwyEoVL7m0hHO/JKrD3QcLM9rYtMLp6lCv6B
 24D6TWApfmUxGEcLPkkA7QtRoQn8Vw5VkKEkHkmRkbuBS9OHQafUSfSng2l52uBs+nG3
 XQBA==
X-Gm-Message-State: AOJu0Yx/Py1QaiUHvXabg7na0mRaLecMfcWmq5zCICo2gHJ5dZZ/6EKG
 Aj/sBEoIJo+I0QvhEcM820ZRGlXM0SXKUvTRH6Zwp9AbU9R3eRv+iliJBoxZJ4kA
X-Gm-Gg: Acq92OHQ6ypJ2ICPE3Mu8p/UVQvdU4bxwy1TCvlhiDjMI9yZ6LDluK4Pli/wT06TbKJ
 coY/dtjCm6XGdUaIAey6vZ1fk9mIxSTE8rFlVKzUOyzhr4JSou9a+nZ42RzBrq5lHFKFlftYuUO
 LfsDP3YdsZFyBRz4AzzIxX6Klr2P7iF4EKtM68OcPKHdk8CGUovjcFbjGrTOpVYp7VWHIJy/LCJ
 41OAM9AKf5hKvnmrNry9c4dVkcvezuT4D4NQVV2N2IQ+8dymVi/nC09mlp3vkQyf5j/enyMTPje
 1pHESB90zy7aMkI8+cS8+mLsrWZBV+1nEerl/jEFrDvQaKSSVbNrkwN2G9313KSv8KEwzSJ4YPu
 74YrcabECRrFaTrSsaIW+9YNJfxPCYLVIuJKSRUic6vFM0FAy6eK4Nqmsur6Z2w7WxXENNVeMls
 BVAo4Ks9xpiBTj9kM13M02zBChgvfl/NHkNSKz1tnMsa0bE7STrIB/hKQUIf+57yAaEgs=
X-Received: by 2002:a05:600c:6288:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-490b5fdb17amr25758985e9.26.1780464749734; 
 Tue, 02 Jun 2026 22:32:29 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm5146220f8f.6.2026.06.02.22.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:32:29 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH v2] net/ark: fix null dereference on allocation failure
Date: Wed,  3 Jun 2026 08:32:02 +0300
Message-ID: <20260603053214.119296-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603052207.118688-1-denserg.edu@gmail.com>
References: <20260603052207.118688-1-denserg.edu@gmail.com>
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

rte_zmalloc_socket() can return NULL when memory is exhausted.
The result is passed directly to memcpy() without a NULL check,
leading to undefined behavior. Add a NULL check consistent with
the existing check for mac_addrs allocation in the same function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bf73ee28f47b ("net/ark: support single function with multiple port")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v2:
  * Fix Fixes: tag to use 12-char sha1 (checkpatch BAD_FIXES_TAG)

 drivers/net/ark/ark_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..546a44704f 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -445,6 +445,12 @@ ark_dev_init(struct rte_eth_dev *dev)
 					   sizeof(struct ark_adapter),
 					   RTE_CACHE_LINE_SIZE,
 					   rte_socket_id());
+		if (eth_dev->data->dev_private == NULL) {
+			ARK_PMD_LOG(ERR,
+				    "Memory allocation for dev_private failed!"
+				    " Exiting.\n");
+			goto error;
+		}
 
 		memcpy(eth_dev->data->dev_private, ark,
 		       sizeof(struct ark_adapter));
-- 
2.50.1

