Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C7C021B5
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EDDC402E0;
	Sun, 23 Feb 2025 03:43:56 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 54F1B402D1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:49 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2211cd4463cso65557365ad.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278628;
 x=1740883428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1QdtC/a4w7XZRXvJskpGppCBgoXPHezrklPUcuOzlc=;
 b=20n5Ojf5PhbPPKPRIQ+inGLjO8q4T7XPxFDaemg9ye4tkqbJ+blO7KOSa1ROP5WrXe
 Ai9rN8OGbsuPp957nkAIQC2VU+iZOG+WBOP+Z4RZpBdJeRjvBO36I566LReyJXXH1bgm
 jCXKkXMf/KXDieydk6yArGXB1fHD9jzueh90WUu92j6IAUVPGZdsAhgDYHkEekGlOvj2
 tMZ9uhuNS6Ugho3W6PyIj1omSmtAOPqnDJ3kc0Qq8O75dXp3PZbzukrxW9W37Pq8oYAR
 tT+2q1YUSgfaX3avJ+Z9PEMIo03KDJGkjPKGNn8m67PTY2YtePuxLfSt4pShR+vrHoAC
 fubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278628; x=1740883428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1QdtC/a4w7XZRXvJskpGppCBgoXPHezrklPUcuOzlc=;
 b=nMNIje5JQafZEXN1YXxiflAXHbUBWgTeZQYaQ8o81j6cG/R90RepMMnR8XpWEK/Bm8
 V0SnjKJyEMn11RwMv9LZIA2O4hXwUfrf6/75B397/g9dPgwOdufxBpUOloX7s0/2t2kL
 BCLFJhj/H5hOzWftgDDJr+EssVdsVIaHU0OUHQgJjO5vIvpPMRJ5POs8QpGmhqQNU4HQ
 vSUsP0WTnhjVUFfCVqRAsTt+27/BN8EbQgMGptOE+BYtIrs00s1Z/efJpF4EUO/9nRgF
 Ws2Zj96L9zWC6MgQowOl9QjYTuRnes5CarjgGS/2jZksd2yGT4J3VhiZQgzeCru5N18t
 hhng==
X-Gm-Message-State: AOJu0Yx+r02Dp7oHreVj9naTDGbFbZnmwfLxc8lIjZrshhSB6OT70cOQ
 MAHuL7j5DrL7ogdS7gCuRa3ZoexorxCuWxhnfBtyTiWTU0ObF/pKChO1kj4nub29hvzrgBVp/kM
 h
X-Gm-Gg: ASbGncvz6yoWGVNxDfDY7gydgGLGdFwDil513VLtb5t+axI7kxlzvxvSKoxaRQWnJD6
 2gOFxU4sNKCF99HMwp7VgbnsMXVsMCxY9T0f5ja8RjuLvRzZyJaZ99WU8Q+NutBZ4aJHNZaMeLz
 8KpJYWGQqST4yYTxK5T7p06jOXqbx5PhOTUqSHpBJU+Bs2jbpK/hAUqC/mDz0eXy86LK58kCkiU
 BdGK0LQEKtNdLFF7JHtDhBTEq0ZUxo87+88alS9nzXVEj97cEksxLWdHM9a9ct6owZEkGXIAQfm
 n+TjL7x7u8iHUDcuHpSzdsj0Q/EXuL+dz+1O9U7m+ekPLhnTapPpKjoo8OHULFsmcjwbouNqEba
 EgAA=
X-Google-Smtp-Source: AGHT+IGa0S6BiV1aZngIC4EVjBoxiMBrE27CxqVTV/eT1yIDQSmB40D4XUQS479EGOGcB+eevOK1sg==
X-Received: by 2002:a17:902:dad2:b0:215:8ca3:3bac with SMTP id
 d9443c01a7336-2219ff565cdmr136669195ad.16.1740278628587; 
 Sat, 22 Feb 2025 18:43:48 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 4/5] net/zxdh: make callback table const and static
Date: Sat, 22 Feb 2025 18:42:23 -0800
Message-ID: <20250223024334.1216477-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223024334.1216477-1-stephen@networkplumber.org>
References: <20250223024334.1216477-1-stephen@networkplumber.org>
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

Tables of function pointers should be const, and since only used
in one file can be marked static.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_msg.c | 2 +-
 drivers/net/zxdh/zxdh_msg.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
index 4cd58ca0cb..ca614d43d9 100644
--- a/drivers/net/zxdh/zxdh_msg.c
+++ b/drivers/net/zxdh/zxdh_msg.c
@@ -2055,7 +2055,7 @@ zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
 	return 0;
 }
 
-zxdh_msg_process_callback zxdh_proc_cb[] = {
+static const zxdh_msg_process_callback zxdh_proc_cb[] = {
 	[ZXDH_NULL] = NULL,
 	[ZXDH_VF_PORT_INIT] = zxdh_vf_port_init,
 	[ZXDH_VF_PORT_UNINIT] = zxdh_vf_port_uninit,
diff --git a/drivers/net/zxdh/zxdh_msg.h b/drivers/net/zxdh/zxdh_msg.h
index f82995bf0b..58836bb4b7 100644
--- a/drivers/net/zxdh/zxdh_msg.h
+++ b/drivers/net/zxdh/zxdh_msg.h
@@ -527,7 +527,6 @@ typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
 		void *reps_buffer, uint16_t *reps_len, void *dev);
 typedef int (*zxdh_msg_process_callback)(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
 	struct zxdh_msg_reply_body *res_info, uint16_t *res_len);
-extern zxdh_msg_process_callback zxdh_proc_cb[];
 
 typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
 			void *reps_buffer, uint16_t *reps_len, void *dev);
-- 
2.47.2

