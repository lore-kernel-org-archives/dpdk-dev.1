Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA736CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D21402D0;
	Mon, 25 Aug 2025 05:41:37 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 71198402AE
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:35 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so20308025e9.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093295;
 x=1756698095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y54OTTQPEGRrXvNfzlV5PaaCVzWe6msGJImFzBGj8mY=;
 b=f0seLW5PJk06XeA0WVZySv8v8EchjX/PYt12yL78+usvM6PjfIBV9AfQqWdKmehYBI
 7AKgIRiLxgE+hxEfJIwWedAexKDQq4Ik8WhV4CT+9v4ggkHxQncy6hwDnmLE9bgytX0p
 IadsM4OuifaX3srvH9jj0seurO77mW+280+UynN/p8A0jrRr2oRsyVdLTV3kqAfB+x3Z
 XBwLoLaWN9vMlBPT7wR8Hzg7uCULNwXGyUv0Yo75einQQ8SijILvBuS2LtlODEHMPCQ1
 5749ENHbDqOTJEs36d3txQXiYY/GzGefnqbSEtrVcrUq8e1wPBlU35u3OqdKGvVuGc1r
 h1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093295; x=1756698095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y54OTTQPEGRrXvNfzlV5PaaCVzWe6msGJImFzBGj8mY=;
 b=nhjIs5JNSZ5LZSRMaoJRMZgM2XntHOE3wOKE1OtDZWdPSxZ4yedIckJV+/MvhX0Mwd
 6PY6oDxPoqY/3YbAO+MBWjo+6fJZCAQnL7rbq60tp5Hg2eCYYuotZAosQe8uPhxZYHDZ
 4tlcQkDPVIQwes+acN6WNkQs8GkSSo+WtXC/G0bRhnRjhx6HjOuTVloirTPcd0H8HSnm
 6LcbS9d4AGd5VRUmBS1tAa6XH4njqke1ef9TtAwK5F8o3GFQsEUlGFFTqXBis9uH3bVF
 0zi9n/vGrss3c/I5D5wu02mthfRqjanQzxorv2ZE2ez7fVzuuH8iFsSyzOxbQQqNGpsk
 LX3w==
X-Gm-Message-State: AOJu0YzpF/ChCjXX85gZ2XxpQq/gSdC8CH0b6PSfQRuZMmOmZe5qiBsd
 1U9M52/L1QBGFzlZ84DX0bXDcL50g2dysUiWoQQUFTTIOm2TW4l+G30xtIO4/u+E0h3j0IqQpwF
 5eFni
X-Gm-Gg: ASbGncvacHKeHC7VJeKVajXrnwPeeddu0cgyHXOo8mI2qfeO50Pmw9rXh/W4EB4lk/A
 MqIu4b5OcYFuKcdBoO0KlzYX/mMIs6DP2fcm2F5HKHhdI319qagxsDPeBlYxjaWnVaesJYuFPdV
 LSRLy1j1PUhD3gUMI1YdlN7ngfypK6T2mYh7UXXZaGeXJ4835LZQEJzfu9jtCBJhTzQkLvHxdqx
 4OYRiDNABo9gERef/OUctVgVLndHQstl8DrzLZcnkXlIPisGDsJFTjQjPiM76i7gWUoqw1UW4wM
 6FD+bCjSr0hn5cR1DLlqIwFb9XAN9mIEGTswoWIdbGAo2rnokogQBJzowCyZyDgdw2bXEmAlexb
 i8fpVnC5OTYJkVI9o6QfNpatkSKFLR1vE4/3UErTsDF/CZs2TuZ5T4Id/MDghMizwI5w+2bK2sO
 5mFkmIxFY=
X-Google-Smtp-Source: AGHT+IEjSvjIe7lPtcBq+GUBhFCpUNsfy7RGJeP3kBu0G9+cTvdYjeqdrkAX/5+gtBSxglX+M+RbSQ==
X-Received: by 2002:a05:600c:610a:b0:456:24aa:9586 with SMTP id
 5b1f17b1804b1-45b574ece0emr50033225e9.21.1756093294957; 
 Sun, 24 Aug 2025 20:41:34 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, jin.liu@corigine.com,
 stable@dpdk.org, Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH v2 01/43] net/nfp: fix use after free
Date: Sun, 24 Aug 2025 20:38:14 -0700
Message-ID: <20250825034126.12046-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

The code to cleanup metering was using the objects after calling
rte_free(). Fix by using LISTFOREACH_SAFE

Fixes: 2caf84a71cfd ("net/nfp: add meter options")
Cc: jin.liu@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index d4f2c4f2f0..4833ebd881 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -12,6 +12,13 @@
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
+#ifndef LIST_FOREACH_SAFE
+#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
@@ -1124,10 +1131,10 @@ nfp_mtr_priv_init(struct nfp_pf_dev *pf_dev)
 void
 nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 {
-	struct nfp_mtr *mtr;
+	struct nfp_mtr *mtr, *tmp_mtr;
 	struct nfp_mtr_priv *priv;
-	struct nfp_mtr_policy *mtr_policy;
-	struct nfp_mtr_profile *mtr_profile;
+	struct nfp_mtr_policy *mtr_policy, *tmp_policy;
+	struct nfp_mtr_profile *mtr_profile, *tmp_profile;
 	struct nfp_app_fw_flower *app_fw_flower;
 
 	app_fw_flower = NFP_PRIV_TO_APP_FW_FLOWER(pf_dev->app_fw_priv);
@@ -1135,17 +1142,17 @@ nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 
 	rte_eal_alarm_cancel(nfp_mtr_stats_request, (void *)app_fw_flower);
 
-	LIST_FOREACH(mtr, &priv->mtrs, next) {
+	LIST_FOREACH_SAFE(mtr, &priv->mtrs, next, tmp_mtr) {
 		LIST_REMOVE(mtr, next);
 		rte_free(mtr);
 	}
 
-	LIST_FOREACH(mtr_profile, &priv->profiles, next) {
+	LIST_FOREACH_SAFE(mtr_profile, &priv->profiles, next, tmp_profile) {
 		LIST_REMOVE(mtr_profile, next);
 		rte_free(mtr_profile);
 	}
 
-	LIST_FOREACH(mtr_policy, &priv->policies, next) {
+	LIST_FOREACH_SAFE(mtr_policy, &priv->policies, next, tmp_policy) {
 		LIST_REMOVE(mtr_policy, next);
 		rte_free(mtr_policy);
 	}
-- 
2.47.2

