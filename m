Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28709C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37BFA40DD6;
	Sat,  8 Feb 2025 21:32:35 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 28EA040B92
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:30 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fa21145217so4309208a91.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046749;
 x=1739651549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sg76zCYgTOR9gfS3lia7wWJJOv9HAGuTBZmYnGP1OD8=;
 b=TxNPX79A/qKT/lQ2a1YAy+YpShmxiF5zGCUSQ6p063C/zZ7V/uROfS5BrkCXtkpbIq
 AqnZV7Zs42KLZZCFfLERPc9rVMZ3CcR+n5GMt0/gPSM33t1lVYXc7OIy5GMrIuS62P7J
 DQtl8CtQ3f93Mv1vOZQrr5J9GzyA6ru2TAh1iWkBNcsADwvuHAji3g7Vp7lin3NWzRKj
 sNfkdscwwHsdyeI08z+rW2C1bQW7DrkZY6NLT5LSTIMw5FlqrT7Hv/AbAaby+Ujk6tpU
 Qxn/4Kg0Mlq5U6Z+Ek1R/lw0nlP4RCyZSOPGPK1AjWPnp5rKotnP+C2JIG15IOm/UDg5
 IM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046749; x=1739651549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sg76zCYgTOR9gfS3lia7wWJJOv9HAGuTBZmYnGP1OD8=;
 b=cxtHr/FIQ5YSoPPtRLMi7fQAzKVKKj2p5LsU9ZBUylCioPPD85qQr3hJTVxQam9CKF
 IiHhfNDFYHze3tsmgY6n8a8bPfl78lsue0Y3VPJVsx+LJjggfymPGWNqbZBa4U5fLD6G
 PsBTqRVVPoIC3d1t4ZTMIQZG+PKHwlf5GjtcR3cbutDh4dBQyVdEwSluC8EsBfBuyCvD
 mvSWf6SXfS4ldSPnYVuCFM+mzRfBaFRVgHjGv0cGh7KJdOWq10LSdJqD0PIaZ5ACmu7U
 DmN7qkv7+N/FlXaMYvlJexSNTHAk1Wiq7EMOzSdEK9u4dStRQ5h/QpIJ5JKPVk3for7P
 ZKCg==
X-Gm-Message-State: AOJu0YxL9R4EDY8Lrt+gHmLEy3YV+XToWbNw6fesdtNESsFMlx0CXP3K
 N5QHME/75h6e2grWNf1+AUwT2QqM2zPrJEZZ2v3696utk7nGmf3R+xEK3mQkoeTIbuLP0E2QyMF
 Tpog=
X-Gm-Gg: ASbGncuQGNTWzGouhJEf7/p8QtKG60U7xw+FHI/KzeMHLw3ETpKf5K8Hb6d7PUCin++
 B/m8cmL1RejGNDAj1eQew5P9GgUvpGS7k0Z5VOTcbUivwJBEzkYh//IjpEbZ5MZw0B4UdN482OA
 4BIKnIJ4KmR+1/Do53+u3Oyg7mO5tpoL2nMoX6zaTtmB2s4vrTl0vGYDU8C7gg7gv1Ttf5wOX8K
 7o1wAm9A4hIGwiGP2fNewMpImwU4T8Vz0ZzLTmWy21ciryGaKSpV9ausitRODhBmVYez932vLYb
 3+Emn/1KLB6WSPsfMr+g1x3uHrVunemlwez9YTCwl/4ycRaT0N8/U9S3bxgGTJdkv03E
X-Google-Smtp-Source: AGHT+IF0CLJgNUMQS1rd0t7f8EZuEDsSf+OCu62oENzCqDLhq6avu8ysYRuq6bQ3e0skkcjOPakUEA==
X-Received: by 2002:a05:6a00:1890:b0:728:ea15:6d68 with SMTP id
 d2e1a72fcca58-7305d51c70dmr13092394b3a.18.1739046749380; 
 Sat, 08 Feb 2025 12:32:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 30/32] net/ice: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:22 -0800
Message-ID: <20250208203142.242284-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_hash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 00d65bc637..aa6a21c055 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1309,8 +1309,7 @@ ice_hash_create(struct ice_adapter *ad,
 		goto out;
 	} else {
 		if (rss_meta->raw.raw_ena) {
-			memcpy(&filter_ptr->rss_cfg.raw, &rss_meta->raw,
-			       sizeof(struct ice_rss_raw_cfg));
+			filter_ptr->rss_cfg.raw = rss_meta->raw;
 			ret = ice_hash_add_raw_cfg(ad, &rss_meta->raw,
 						   pf->main_vsi->idx);
 			if (ret) {
@@ -1321,8 +1320,7 @@ ice_hash_create(struct ice_adapter *ad,
 				goto error;
 			}
 		} else {
-			memcpy(&filter_ptr->rss_cfg.hash, &rss_meta->cfg,
-			       sizeof(struct ice_rss_hash_cfg));
+			filter_ptr->rss_cfg.hash = rss_meta->cfg;
 			ret = ice_add_rss_cfg_wrap(pf, vsi->idx,
 						   &filter_ptr->rss_cfg.hash);
 			if (ret) {
-- 
2.47.2

