Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4EC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A777640BA6;
	Sat, 15 Feb 2025 20:06:05 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2A09D40A7D
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:02 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22104c4de96so11683635ad.3
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646361;
 x=1740251161; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=h+giyAOjSwTbq2EXINj0YmO3dTESkSAQ4/VViF3uijJltd/dnU8KM17cnTdsNl/iEl
 3NpkXIxcljsTwwxbpgADzh4sNxX2Lm4zw66DgHgfi5+jEFPcDbWeZz8leSjkjBMMOrq6
 Ycw0m4AjQixB2BnXb5vIkSlf4rBWu3dNxrvz5cWGLi61j1nQcAW8SzfcEZmN5zg34s24
 pr4xThrk4Dq9jFlNhaC7l3ilVt6bORhZP9T6yRS1NLtcyC0qJhDyxVgeQwqzncknWhh6
 gqF5tU9PNIMV57PyexIeXoFDDIUGU66BUogL8MhtnxPIpXeGAb+LL7hn6JRjFlc9cFpv
 /LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646361; x=1740251161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=ENBkzbGrbGSQwCn2VYMVRJNgIK1bUM3wA0WVqhF2NnfPnm8AWAkwSpLs3LJ9yOOZaA
 zSOQDAli5g3OMQueIdc3R5Dp4HJPONiw7fxY2ocmt2k7dP22F4ikcXKReaB7E7ezq4zX
 USdfbl/TiGsrit137vFuINt5C/d/HhkpZ9ZeqAO8EU9m2Pz0ubUlNEgDH1vQi3qlWFj4
 9a9pkL6+uZJDs+5iOyfMQ949QG3GSvV+9zqdX2PCP1o44nGQx4zO7T1NEeAt6gjXB2fH
 nPSGEzz+R+I+CuYHdN3AniBqRPD9NimuJP95wAqVwLETffx6rXa14vA+RlyvV1bCqxl/
 JAOw==
X-Gm-Message-State: AOJu0YwlgrrmuioTJeGYG4q6wjaobJAaRmacKQvaSv0usBn2qOGvHFuf
 sI3TWf/a0UnQQvDGt/lsNLR5ExHHfBssYwxMIlT5qZ0HoNbXaIed9ZFERRn2m/kHCEb7OHTfXz3
 c
X-Gm-Gg: ASbGncs4CbyJFUjhPlXkS01VKxRkJt9XMXWOsY1NAteM2kDm9f7WKYE7uqaIYX2bXgj
 0FnYwY43wu+qLvZh7fxEhbQyaj7J06KwWpRxKxSGIri31Zwm6i4Rew812+Q4FeFXhG8dR5DnfIV
 bfz/5Bj+KV+OxIWeDAvA3yoQIKZqycBcuKWqXvLuVMNFCnt9EB+dvlMlfkdrCFE3Iyh2mLthjPU
 nEeSVVnivy3aHtjfJrcF/eeQizPe8peY6U2SzWv6c5ZawMkllRsiGoejprqkxrl0JWbHODWJlsk
 rHE/o+sPr88tT0PfRlg4Ejkh2mz6BuL8r+lEcQq4FOJD8XZ/HJ9jD3XjBhRvXhJEXsVz
X-Google-Smtp-Source: AGHT+IFOc/naxSB7zh8tKDBcnrESlE720rYFQGWADW9jo5uiSafra8wg5SA48n3qWpvUOqOy7CPyzw==
X-Received: by 2002:a05:6a20:394b:b0:1ee:7318:fd59 with SMTP id
 adf61e73a8af0-1ee8cacbbe0mr8521518637.2.1739646361427; 
 Sat, 15 Feb 2025 11:06:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v7 07/16] common/cnxk: remove unused variable
Date: Sat, 15 Feb 2025 11:04:35 -0800
Message-ID: <20250215190544.988310-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

