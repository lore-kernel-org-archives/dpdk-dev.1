Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC92CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1730C402EA;
	Tue, 19 Aug 2025 01:32:38 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 5D92240262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:37 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9d41bfa35so3990069f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559957;
 x=1756164757; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvFtvhnWumDNYbWVMyEDaqX3/WRfV26Ta5nAQ88zLY0=;
 b=lSALpKURqJTf8A0NCNpzFQVFWmriXH2ikb24Fjo6QPK1wnWByERhOIfiSOIzxiapSe
 l7q1fD8qTadvakShljJhdDY6d8OvsOwna+MnQiCzOD9QLh0Wym9mVSfvF96WcgXQ0EWa
 FJjJDviBNlS8QMILCpvLB2cT3O1wVdZk6fKXY+p+Op7xvoPsoY0/KAuY16d2D73azHol
 aAyWtKfSDZobcXPu12PIKAMKF5/mPPfOTPtiCiHPFi7Ovm4Q003ITdBuJFvOPGRjTeOP
 VFZdsM62qtqowTd+bnjsbjRt/UnOfuvkfmTQ26nj0CyM4S2lmLepPawyD50mnDYgSt7I
 deew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559957; x=1756164757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvFtvhnWumDNYbWVMyEDaqX3/WRfV26Ta5nAQ88zLY0=;
 b=XYHf9vR0tqUIw6RlMCpenAS1lCwwSbWGp2R7bVBSZoUePvAWD5eXtRrhuvd/EUSPn+
 X4oogpLNZvzpT6A2ZVH8TT7RuitH6JnlbpbGSf4pCCiiZ6MO61Eas2pbPCq4bu1Ji4GG
 TUXQzR2MzmRwaBnW0W8guaJRTPlbsoN85tq1/w1gcUpVdIylf1qjAst290CCjW0vhd1+
 HtZeJ0uaTvyr+PdxvRpN2EQKcyX101wQOJKdmZ4fmcHTJeaF5MqwXDDLBZh6eyUNt0up
 erDGXv0qvejmLw8EOd7KoJzAqo84TSI9d+xWe4APWyqLOucvz+6D9lbgJX2Z0n8OHGrO
 0hXw==
X-Gm-Message-State: AOJu0YxIzQCWrGH8nM5/V3HJxAqavbSyUovzTH/HMJEiR6Z7ApzwcvJl
 eR+nTjvJmEiXEBXuoVF9UQrZEsTn0UspE+G+ARKdaZhDoxWhQiijlBmT80aOMEeNlZPYzl1ELvq
 N7LXg
X-Gm-Gg: ASbGnct/ZIY0fyok1R1wZoHwcHMRKCOmwxNhuF9X9MC9fFXaREQ387ZUKlzi3dvwqvL
 qTWLDK7GIw6sYIsnqRavcnx4/nfAc6OTnpWNVBUXEL9LmjIANiqXUbRgK3QSDj+iuJi/pVDT/0B
 S+JMc4uiW2VFZ0Nsj/UEnJkXRkyMixfEtZRKN5DG8gZEfL+1eiuj9aaKos7bLbZJiXmY4IFr3OT
 SN8hjuMtUVUpvadr6fO/URRc50SzaUjcTVBk+D+O9QacIvfj3wEESmG3jEo+yZzn6qa8vTSPxSC
 lNTMcDM88H2YjJCNKHfbSeTdeEE8HL+wk1k9loo7JmH8betCsDO5bfpNIwxOv9xZVf8cvgDCMGK
 Tnz8bS/dau4oBo7dP9HvPpgMJ47q7zI/lIqezyBGUYIZwWOPaSwf8A8WHym5lRqKVpfln8T+h
X-Google-Smtp-Source: AGHT+IEHPJIBJqwe09sDcmJR2bjgYemamADhxOfeHxfZcP0gqIRA4g7v1ZFv01XgYbemXiceJHkhFQ==
X-Received: by 2002:a05:6000:2004:b0:3b7:93c3:7d49 with SMTP id
 ffacd0b85a97d-3c0ebadd7e0mr297639f8f.39.1755559956904; 
 Mon, 18 Aug 2025 16:32:36 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, jin.liu@corigine.com,
 stable@dpdk.org, Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [RFC 02/47] net/nfp: fix use after free
Date: Mon, 18 Aug 2025 16:27:13 -0700
Message-ID: <20250818233102.180207-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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
rte_free(). Can fix now by using LIST_FOREACH_SAFE().

Fixes: 2caf84a71cfd ("net/nfp: add meter options")
Cc: jin.liu@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index d4f2c4f2f0..904d2126e7 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -1124,10 +1124,10 @@ nfp_mtr_priv_init(struct nfp_pf_dev *pf_dev)
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
@@ -1135,17 +1135,17 @@ nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 
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

