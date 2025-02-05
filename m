Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FEC02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:27:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A1D940DDB;
	Wed,  5 Feb 2025 17:25:54 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id ADD3140BA2
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:50 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9ef7a3c3cso933074a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772750;
 x=1739377550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m59IG++74hiOwfX6DwsbQqLgqP9dXqv2ZyoMq8Pyi64=;
 b=fTKLqN/CpIot8uAgiZAcVvgYnBRBeXnmAKEqSXwW8lZi3h4+r6jfnP+zjm7RIR3B8l
 SY8jV23AMeYpSqyBeW90oNWB3G32Mu8S5nC3UBwSIXwpovnbcCbwD5EXO0orJ/rqMQSj
 sGVUuBa5SX38Md/jSughgrfX9UepXurNVLkKj3BaVnV7TPzl1HUBn3CHQwQtQqhwBlxy
 YYSVcrNL2laaHwrO4qJ90zPaELuLQC5JiQTUoLKKPPji3r5yDbtWArOWgTcYtRhqw9oi
 FfFuPY9ti0WnMveXrRTvMtrdncFbQSmGdPkFP7vr4OJWHKiezstkpx5yt8lZU8agg5R4
 RbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772750; x=1739377550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m59IG++74hiOwfX6DwsbQqLgqP9dXqv2ZyoMq8Pyi64=;
 b=Kn/T9L/u/m/CGr91M+xU8THs5Y11iq3eGkjVnVgPgnBW5+FMIEMlsotLYJYj4UHqRi
 Ckqbf0ynieaz7CvesR1LEabBhWpw7h6xhysHyHr1/m4WlL6yE0M+0afTJOFwZ44mCUtl
 sQc6Va5iY9FkTFYZ976//8WAsqUG6TXiswls7/0R2Y0MG8prHkHoqmn/Kc3NLhPUEz/y
 6xGfk+TGC+pnclLcv2l1hLDGJHgpUmw0kvsxf0grp/qmNdTQML3ZG0qPdXULkvaFwYzE
 FGMsJbR55Inp/FDqXJeJEgb02zJUb8WCanhz5RffS9ab4MjQSVrf6Oq/80lkmjkM6j0E
 nJoA==
X-Gm-Message-State: AOJu0YxVnDP2S/rrNZCPwdbQE8oVQ6GxDNUTh0qtjgoQs6Y9O6y8OQPi
 X1xiuiYTT8LLn8BNVkocyZypO1OtCEzw0IjRXgD/q1ZXoOOqiTtZ2cJN90e1abVKXGLc6hV0J74
 5
X-Gm-Gg: ASbGncuIFaQr08NbdC1acQPQuD5MnmmvTH4agkGHDEoTDPfCtSTIFUuIRPqoocaLxXO
 VTir+AJDPpDALzDYQnHSBCyy3I4IH6dpFbd1pk/y5w4i137mEnRMioosNNkP/DFYW0Aw4VbNArC
 DTSWi8aLf13AD2WIlxXUrGv2u8sKtbAddHcm2/djpStJlCPSW8SEh/1qzS6L3PO+B2jhwUUpyDf
 qYYajQy4D18BdSajrjhYz655YxkK9M96OVJna8hcD9589sgif4GB7sfd21kFchuZ07uGbSUHmb9
 4dLY28egwFbddFUoW/oyHO+P5W6PnQ36tNaNstZyi3T50reTHzwwnLTiUAuJScpeK7d9
X-Google-Smtp-Source: AGHT+IGJyV52MvRTWCTuYXTBJXKFEs/iQBMfI12zR9NJaG543CuivuCPH0qPfPd/iHn9OSD0W41rsg==
X-Received: by 2002:a17:90b:4b10:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-2f9fdf62111mr60457a91.16.1738772749896; 
 Wed, 05 Feb 2025 08:25:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, tduszynski@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Jakub Palider <jpalider@marvell.com>
Subject: [PATCH v3 19/19] common/cnxk: fix null ptr check
Date: Wed,  5 Feb 2025 08:23:20 -0800
Message-ID: <20250205162448.161161-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The pointer mode is used then checked which is a bug reported
by PVS studio.

Fixes: bd2fd34ab86f ("common/cnxk: sync eth mode change command with firmware")
Cc: tduszynski@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_bphy_cgx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/common/cnxk/roc_bphy_cgx.c b/drivers/common/cnxk/roc_bphy_cgx.c
index 882cf65474..db70bafd9b 100644
--- a/drivers/common/cnxk/roc_bphy_cgx.c
+++ b/drivers/common/cnxk/roc_bphy_cgx.c
@@ -366,20 +366,20 @@ roc_bphy_cgx_set_link_mode(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
 {
 	uint64_t scr1, scr0;
 
+	if (!mode)
+		return -EINVAL;
+
+	if (!roc_cgx)
+		return -EINVAL;
+
 	if (roc_model_is_cn9k() &&
 	    (mode->use_portm_idx || mode->portm_idx || mode->mode_group_idx)) {
 		return -ENOTSUP;
 	}
 
-	if (!roc_cgx)
-		return -EINVAL;
-
 	if (!roc_bphy_cgx_lmac_exists(roc_cgx, lmac))
 		return -ENODEV;
 
-	if (!mode)
-		return -EINVAL;
-
 	scr1 = FIELD_PREP(SCR1_ETH_CMD_ID, ETH_CMD_MODE_CHANGE) |
 	       FIELD_PREP(SCR1_ETH_MODE_CHANGE_ARGS_SPEED, mode->speed) |
 	       FIELD_PREP(SCR1_ETH_MODE_CHANGE_ARGS_DUPLEX, mode->full_duplex) |
-- 
2.47.2

