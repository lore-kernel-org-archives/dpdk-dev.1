Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923DEEEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:58:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48FED4064F;
	Wed, 31 Dec 2025 19:58:25 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id B008440616
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:58:23 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so9704898a12.2
 for <dev@dpdk.org>; Wed, 31 Dec 2025 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767207503;
 x=1767812303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAi7zg24KhIo8F8gRPXJ2RkLdic1yrd81TITz3bST8k=;
 b=TCStFM3kgOSEArls2jfi4iBtkIpNu5zFOSQqpotumZzes96OfdwNRMIr1BkUtIaSiV
 KuhNpnxDU62fc9K/PY0g1cMUGx3ZKBREaygz8En+iuVFT8WUFUkbOC5rAWDbl7U+2D45
 9KwF5duJM37NSWAUI45LBpUcCjLWQa2K5EgVP/ErcD6rUiJS3iWxyTtiSblu4jx5pS2v
 iAsie1SF60/Z1lTKZYtN4g7pHTmF3QJu+rdyh4HNufIt9DlYgP+6iDjmyY3MPzrPRVFC
 e9Hz5IJ/ViNf4n3p7racwSZa8u+5BfPG2c4l1jJC6t36Ht/H4auYywIWotwplBG265bK
 QnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207503; x=1767812303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YAi7zg24KhIo8F8gRPXJ2RkLdic1yrd81TITz3bST8k=;
 b=HyeUCQ2L4nHG53xJX3cPqTi+fZaS5fILrRQOhIplNqrMwMoUPed0LUflGSLHkwVh+0
 bHBqqsSIrN9UWIYs+R/y6cPYaiotE0qv+SvfO/CcFakLbHo7ymrHLX6ajvaHcaF8MtZE
 ADJbfzExxhphI5ag7rtYutY1kuggz422r73boQTQWe/NFL8w2fX88rjT5LbJPBSEV4Ix
 ermLrrUU7xcmGgaCHyKJ5tPHeIQaZZP71l33w2Wf6cFM22MZvs41C6Ck/uz80BUfGcD1
 g4kOXmBLVEb/7rubPvUT8eRRmTNk1P27NZ1bpuPbQUVmu7qGhOQux7P/o8R+FrCNshez
 cXcA==
X-Gm-Message-State: AOJu0YzodY6As3iFBbBF9ZVx51FDm7K6BClcEuHAS/MORye++zVVHUuj
 Dg4MyMFgB8B5V+FK48X/Wxh1BciBpC3zvCM7iE8eOOfWgy79pkTyh5dpJ06ueyjO/qRMqf4aT6T
 THbrhMAc=
X-Gm-Gg: AY/fxX7vapkUsqJawMwLdEOwxy1JD7piQUFQcdspmTAlWYc+hm8OwuSloOxLKdg/TsQ
 gYx9oC7O1/ei1L6zK9sGBstQdUw9SPvnSfkEj55Lr+NaGxnYSPZJmBfoLt5jGimQ5+CdlBIptDt
 F1DKrXSmIBC3gXHZpqlYikjTkXtV4EOBGVsLqXIFQHTj73JvZUVIfrYu40Ou6K+YpMiLxwDYob+
 LUCaUBlTn7fAlxeP7vhDzGRTXuwrX/uNdhp7OusUkdadYkxeArOF6Tvvp8ZM7wsMZJw5GyJuuPZ
 llQAly4VF3dJwFfcoRR0HlxsiLpdE7sHJkb8vuPdxnLJX5dUaoDuuXTdlY+oPEidEcizO72CIxG
 DLnT48S9G9Aq7WI2ErTUV/ZDoyIAjCgbKWz1PYE3w7ZEFS+kAFOVtNqghqGhmAKHZ3plsx4eBi9
 Eb3gUkRbcpvTpll1MqWEmUPMbc2z+uYIEv54TQBZF9c/aEu5QGKA==
X-Google-Smtp-Source: AGHT+IHAb6l3M99oxEsen+ZQ+3m5/1nsDei71MQxnX2WhofgFmjw/FiE+MFOfqi5v5DFSkdNOsdj7A==
X-Received: by 2002:a05:6402:5188:b0:649:227b:42af with SMTP id
 4fb4d7f45d1cf-64b8e82b799mr35182910a12.4.1767207503284; 
 Wed, 31 Dec 2025 10:58:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm39000103a12.21.2025.12.31.10.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 10:58:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 4/4] net/cnxk: move socket from /tmp to /run/dpdk
Date: Wed, 31 Dec 2025 10:56:28 -0800
Message-ID: <20251231185803.90528-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231185803.90528-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
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

Replace /tmp/cxk_rep_ctrl_msg_sock with /run/dpdk/cnxk_ctrl_msg_sock.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch.h b/drivers/net/cnxk/cnxk_eswitch.h
index 0275e760fb..bef78a95ba 100644
--- a/drivers/net/cnxk/cnxk_eswitch.h
+++ b/drivers/net/cnxk/cnxk_eswitch.h
@@ -12,7 +12,7 @@
 
 #include "cn10k_tx.h"
 
-#define CNXK_ESWITCH_CTRL_MSG_SOCK_PATH "/tmp/cxk_rep_ctrl_msg_sock"
+#define CNXK_ESWITCH_CTRL_MSG_SOCK_PATH "/run/dpdk/cnxk_ctrl_msg_sock"
 #define CNXK_ESWITCH_VLAN_TPID		ROC_ESWITCH_VLAN_TPID
 #define CNXK_REP_ESWITCH_DEV_MZ		"cnxk_eswitch_dev"
 #define CNXK_ESWITCH_MAX_TXQ		256
-- 
2.51.0

