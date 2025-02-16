Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3330C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F5840E4D;
	Sun, 16 Feb 2025 18:01:33 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0156340E2A
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:27 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220e83d65e5so51015145ad.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725287;
 x=1740330087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=NQciNR38gibl9/+dvDzuOAYSAyNMGn6G3IOtgBh4r8pxiNa/wdbb4CJzKCWs3McRQQ
 HeuDBNaKME2CbpVk13fcn0ZzNioa1fMdc1VvJLRc8VO6Fi+YlrHsADT2NT1RyjnL5xKS
 bOLl30nbumTMhHkFq52ECt8psUU2U9jBlPVDUcVAED9ihPhqb6iuiaxF0cW5ZB30qDEM
 LxqQUurRDXD3fYR/uYvohAWuEdVZPX5nh6cmyMDD7KuaCFm+GqPjH7a1GJ0Fhg2+kvDg
 ZRt1iiDUdVdRAFH6ny9rMvV1+EAIJuQv5eyB/sSfXSIW8BIax9BAqVBPpZ/9dRKrz4Sa
 r2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725287; x=1740330087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=G/aVKGTwZTznfpmTxYTxwipeJ9bK8ZQ/r5Qtw90bI8Qgw586r8L5jC8ssQpAwt1WPt
 Xf0bAKid5K6bRyAM88RXNo3zNz7ErHwgKtYRl/7YgW9uzFgeGNN53WF8MlFgmaYA0+P1
 GpFk5qXBP4l31D4eZUNmq+8GxS2bym1rcgNmv/dKswAnobYATCHNIaigIn1AHVyn2Jnx
 2Lxdugo7B20gg8HGVcpz13P52xusdjLMkigL1+QGUEXVGeEe813BBzZDSJ6vEMJfwG9s
 gh78CmGrgpjwRXbuX3aePHslcKhBW4nAS4jItXSN+Z9i2CHpXuWhBBZp4jDIfItY5QNZ
 tQwA==
X-Gm-Message-State: AOJu0Yzg0yz07cISySyTNGGWGi9SRYUYo9Z+8yUBJBJ1UmyruApblq/K
 o+WTYw9V2Q2M0JhsmQ9dw6NDaEBKqkD3pPczqVIil5o3Ynq+hG9oXTgyctLBMUruU5ooNFE/COw
 c
X-Gm-Gg: ASbGncu8mBdONQLODfAFwAJO5973CpkaZ2/GJMp3GnZSWvy06CVLacNp1znWJyxohfX
 X8RMlwx51PVeb1nMqbDxtWnSA5oTfvViM1sO1j69WF/uGeiqXvHYxEN9vNMTwsuOr7phsMPnpJd
 HH73nC/Nbw56RUBs3s/e/M9szI/MTWR2+2YKu9bXt8RB8lVf3wFNbWkVXsJ+pi+I0PH5OUSipZ6
 DpIGUHrg9uJzGXeLjLGVWX+NLwEwGIxPhzAHLB2zGeHhgYFTPr7f67er6RjvtiklTF6Ru7qIVxC
 wQIXXHjhmOz3TNPJoOP1iJbelv6673kle81m7hYiYaALcp+Mpoy61/vxAHqMsVUuccuD
X-Google-Smtp-Source: AGHT+IGQ70Um+GjcY0dmtiCo6uvcGJrk7/5+vQq6bG9MkaFAn7RCm4DIviFDaPW2uBZBFkcec8/E0w==
X-Received: by 2002:a17:902:f547:b0:220:e991:480a with SMTP id
 d9443c01a7336-2210400f7bfmr103234135ad.15.1739725287104; 
 Sun, 16 Feb 2025 09:01:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v8 08/17] common/cnxk: remove unused variable
Date: Sun, 16 Feb 2025 08:53:07 -0800
Message-ID: <20250216170110.7230-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

A couple places in this code were generating warnings from
PVS studio about memset potentially being ignored. This is because
the ipv6_buf was declared but never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_npc_utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_npc_utils.c b/drivers/common/cnxk/roc_npc_utils.c
index 75d3b0702c..0b32a148e2 100644
--- a/drivers/common/cnxk/roc_npc_utils.c
+++ b/drivers/common/cnxk/roc_npc_utils.c
@@ -454,11 +454,9 @@ npc_process_ipv6_field_hash_legacy(const struct roc_npc_flow_item_ipv6 *ipv6_spe
 	struct npc_lid_lt_xtract_info *lid_lt_xinfo;
 	uint8_t hash_field[ROC_IPV6_ADDR_LEN];
 	struct npc_xtract_info *xinfo;
-	struct roc_ipv6_hdr ipv6_buf;
 	uint32_t hash = 0, mask;
 	int intf, i, rc = 0;
 
-	memset(&ipv6_buf, 0, sizeof(ipv6_buf));
 	memset(hash_field, 0, sizeof(hash_field));
 
 	intf = pst->nix_intf;
@@ -495,11 +493,9 @@ npc_process_ipv6_field_hash_o20k(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
 	union npc_kex_ldata_flags_cfg *lid_cfg;
 	uint8_t hash_field[ROC_IPV6_ADDR_LEN];
 	struct npc_xtract_info *xinfo;
-	struct roc_ipv6_hdr ipv6_buf;
 	uint32_t hash = 0, mask;
 	int intf, i, rc = 0;
 
-	memset(&ipv6_buf, 0, sizeof(ipv6_buf));
 	memset(hash_field, 0, sizeof(hash_field));
 
 	intf = pst->nix_intf;
-- 
2.47.2

