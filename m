Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04305C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA574064F;
	Thu, 20 Feb 2025 17:42:11 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id A4077402EE
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:07 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-221057b6ac4so21498535ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069727;
 x=1740674527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=LqWFRyLch9iH2PnpSjzm41ieopWXQMUWdMfsIYtiOIHvv2vtleLHdampbeUwIQ+upo
 DeIkLNRjv+u5qwPHEf2Hv52c21hvrnrrZk5g/L65m9IW6eOdLvsTN4c1aPWsd9bE133F
 MZ1qmW+LdXrmYuNovcJi6aByz/po0sC3uoIhD/ZET7eBFUyFtMnaVvsVQgdqlRhknICR
 NqbNlF97Uh7YfjT1GHMdO2b6X5Bze8RhY/uvXLK36NvZ0LGDhPj/JIwu7fam4ygvs71O
 GL9fgDM31YN0t8vzIAzxw73JNiVcgGXz4hkxk8fKGQI+6yx+LfcZRq5BO4iRnNvYZZTg
 Tpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069727; x=1740674527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPG1RZ9fQMg6hK525GE2IDjJ0Wo/k+Dqi9zz5mryuL0=;
 b=eU/LKxZ3GOtmYuZuD10NNK1LNAqbdsFWYU6T3B/Kco+zkMvZmvMQOT9crHZI/MjKcT
 BMcGVzZumhv53ZjxKCODzkUSD9yf3Z6wDuHbh92RdNCFh+hastt46DvBDkodSiym5mp+
 e5pK3sg5ZpXnPulrJHN8GpFBqisdVailIp6RVCOhlukDMr6qo5CxC6eJqhO2DHz+ulAG
 AgNdEokPbk2RDUoHRt7q4mmfddq2fmOIOCx9IDwWrE1fYYqGE40bALmcHZmE2qE8F2M9
 XixGd0JZzf0MqB/mRoxSj2prLvB4ykTk/4PtSrK/gY8jddowt0SmHjif5w4dqw+C8GXl
 gQUw==
X-Gm-Message-State: AOJu0YymtWjBGtNRbzXGbG7s6QKy5bhJcfkLQ1YdP5pC4cKkBoIFo+H+
 VfOVKJl1TeZ/ddMbbVM7kO2/eeYDcK6XzDUZVdb2+FmqD44TVdUrxWCxVr+3ZZ6UISAVylmT030
 Y
X-Gm-Gg: ASbGncsYqEdSN9oEMVm8522C8nfxX8JKISHAP64UxJsn+01rbOZuH0JAD783l1RQbkA
 zX2Q3BLTcjF3tSB03SbM6wjSw6JGecJLPfY2DqXF33vOrt53QwHhHR/hzNRc3oQFk+UYioEr7yG
 Zvn0FKLnmMNKHFsjZRD/dJJoKApc8UOvH2jHZzM4NETLPCmauWV9MZo2JcftpY7Wet6+pWty+Hn
 1rmwQMJaEMg/W/f6SokyAzc70a/ZlQbFF7VIsbRq/fEUjeWa7/PoxEOTaD4hTimPY/EpqwHANrv
 YuB2u1e74zRaN9vMfjEp+nfWflxy1RDCUal0Y1YLywdzK5v7i5gldK3kXZNg3c8bvqUL
X-Google-Smtp-Source: AGHT+IFHfDMoy2BJR0Jfmbq3pEfyE9IhPJtZTRReGLrWatlbAVSbqcHykXjNOl4cq2Ba1KFwmTvP5Q==
X-Received: by 2002:a17:902:f547:b0:21f:752f:f2b1 with SMTP id
 d9443c01a7336-2210407c49emr317901655ad.30.1740069726916; 
 Thu, 20 Feb 2025 08:42:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v9 06/15] common/cnxk: remove unused variable
Date: Thu, 20 Feb 2025 08:27:12 -0800
Message-ID: <20250220164151.9606-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

