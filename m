Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C48E78497
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 752214042F;
	Wed, 24 Dec 2025 23:13:12 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 4AC234042F
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:11 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so3019196f8f.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614391;
 x=1767219191; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E57LSt9/KCHzx2mqe5qaQ882fj4LRwn3+6bIUYNlnew=;
 b=XGFE5gnRTkx54ASEy29eUPbESY+HmADyoEAVWgHoEXcrtUyA4R0YxVPIoG3w9tPh+T
 rRCmfB1lhqDh4Y/IaL6gDIozsyF+YNi05LBdE68bGE269jN3ZEtWDJB6AOtvmRDGVZSR
 KD1NDwHo72cIfIeeIAkMJpFSLpanhG0r+7gPs5XXYXd/1lO5+2j5FXqPPsTCYtbdED/9
 0sHsqJ+0pbFkJAqJJpa3MvmhFAHGB1VGS0CRIEfU6vaPTySRxqJBRd4XMWhYXjC5a7Iu
 f79K6yxMZW2kaiqavJv4zhyCgkYZYwwTg4qLNWCaUEg6ZFziQmuKjWc7IzoRKScT9Bkz
 JzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614391; x=1767219191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E57LSt9/KCHzx2mqe5qaQ882fj4LRwn3+6bIUYNlnew=;
 b=OVN+BB00jfmIhKsYLhFfuqWsjkhUsm3A3XURIMLEnfi2+t1t7AXNWQT2hmh1jA3UOJ
 7ujtA90m7hlwjDpziv/RkC5kyTyQ8Q3i2GxcP0/ORh9ejUc4h9L+BQdQB5NJgm1IEMu2
 MuSyrLxXFloMSPBECe9lLnDO1Zmqg0c5BwVFwATlnbcqsEPzi3KialZ/BUAaqK2rl8Nu
 L0f3txUGHFaQAAe8jw1i16oKQkd9fQbhofXuNyMkSNjLlI26+ts28PiG94zSU1Np15Kc
 whXA+lQLIyUtvAMX57fA4uVBgW1FQK2parDEoTyHVEHs5uVhFhSDTs5VlwmP4F9g/y6N
 ggXQ==
X-Gm-Message-State: AOJu0YyOQU2+tiDP0a2fwFvbSe60hRe/5NbEF4GsfZF7BGB8JjL5Wvv1
 xWinpwTsFaA2TtNYxTDf4BzEl/I2m7w3Z3ykKjasOREfYC0E5OQNegqRnksHj5pK4/4TYprhSk2
 kG00xpdg=
X-Gm-Gg: AY/fxX4linX2vWfwJ8lCSr1i5zbGKsVIGO3u2Nfo4iZvQL317mfYXoD185mPTLXCvsP
 rXPPQMPP8Ztyg4uFYb+fZ7pRIIH2jhw9b1Y/h5Oy73mV7ksIrshKTEww5IvRTkn7AR6ULI1JxtF
 etuTdm+2XQOsRtjCdQ8oagnfFGR6jm6bbIW7e9O7UGUkAEuP1W7lhxW490eiyRoDt8nDwe0IsH2
 RUi3XXL69EhoN+2Lyjf+HPkNNWZ/4vRhtvPdFh2dBIHANj05OWA4RGa6uW3bvNpp8cwww9lU44T
 4FS+CHf0dEZ1CVFeK9GiVSWel2dslGD88u8/QWtUcPZt76BsDhwy5+m0i85LSvvwDuKulJYsX6o
 79xdE4EUgJLX3UQu6hiUgDxIeVjfjU2aaFjawac4wamxDwFyyoM4An0iG7W3npt3+bsawYeVWI3
 AhI9uIcOW97tv5zE8N4Yi9KTKTwxKA3mx67DSAZDRYXUfj0HZTCw==
X-Google-Smtp-Source: AGHT+IGbxkWuVbN4L3bm49+fxw7h1MzntZdOr4mhxMEDPJf+NRGCuY8otuef3HASOdI6mR2iJb8o5w==
X-Received: by 2002:a05:6000:2dc7:b0:431:16d:63d1 with SMTP id
 ffacd0b85a97d-4324e50dfdamr20847593f8f.44.1766614390823; 
 Wed, 24 Dec 2025 14:13:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 01/18] lpm: restrict name size
Date: Wed, 24 Dec 2025 14:11:42 -0800
Message-ID: <20251224221301.52714-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

Chec that lpm name size is within limits and add checks
for truncation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..2b49d82769 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <stdio.h>
 #include <sys/queue.h>
@@ -152,7 +153,7 @@ struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
 		const struct rte_lpm_config *config)
 {
-	char mem_name[RTE_LPM_NAMESIZE];
+	char mem_name[RTE_LPM_NAMESIZE + sizeof("LPM_")];
 	struct __rte_lpm *i_lpm;
 	struct rte_lpm *lpm = NULL;
 	struct rte_tailq_entry *te;
@@ -170,6 +171,11 @@ rte_lpm_create(const char *name, int socket_id,
 		return NULL;
 	}
 
+	if (strlen(name) >= RTE_LPM_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
 
 	rte_mcfg_tailq_write_lock();
@@ -327,8 +333,10 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_LPM_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-				"LPM_RCU_%s", i_lpm->name);
+		if (snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+			     "LPM_RCU_%s", i_lpm->name) >= (int)sizeof(rcu_dq_name))
+			LPM_LOG(NOTICE, "LPM rcu defer queue name truncated");
+
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
@@ -343,7 +351,8 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 		params.v = cfg->v;
 		i_lpm->dq = rte_rcu_qsbr_dq_create(&params);
 		if (i_lpm->dq == NULL) {
-			LPM_LOG(ERR, "LPM defer queue creation failed");
+			LPM_LOG(ERR, "LPM defer queue creation failed: %s",
+				rte_strerror(rte_errno));
 			return 1;
 		}
 	} else {
-- 
2.51.0

