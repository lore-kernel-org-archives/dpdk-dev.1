Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE5C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF6CF40A87;
	Sat,  8 Feb 2025 21:32:26 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 026E440A6B
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:22 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fa488351ffso837593a91.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046741;
 x=1739651541; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oH5uTmmZlTeQlsWM1XMd+2q8kxfIxTDVtV/uIkhbvA=;
 b=fsOupnl9bQ7jmwGScY24zWPYGMXp98rhQZkL8Sd8z0rHX5MXGKFa5r6K1ixW2+2I/w
 PRrsHsiCHVb4fTfDvcSBHzUZ3S0mywz85B8vORSJ413Wwv2cXqEkLJqA5AHZEqtGQFEe
 EGjsKRvCYydTyecAM3YPe1XbkRNx5phMVbkI6SUkEaWRvTuAtqG/d7Q7hpTdTgNe09b2
 GqRY6BG++ZvvCaDHOM7f21ZzBWt89O3JES9xvJOhnOjpz2ZUOkBazzOYxrLEI7AQbkPT
 RJ3VsD+bkQJP+VvFeDleUo4f5VdWBGTR8vKMUV2lRG7mJzSfNyv8ppJpv66huR7i8rm3
 hz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046741; x=1739651541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oH5uTmmZlTeQlsWM1XMd+2q8kxfIxTDVtV/uIkhbvA=;
 b=cCkinVDHqkWOqv1X9I8B4XFTkXF/Cz6gD6dPLIoXUCwLJ+FpVGaW9nU3UY54FS1508
 SuUU902MZS/xtaoPeScHTtktxQ8pmKfKBYsPsO6zQCijo+wkUtX7/QRG5DiLHD3YbRhC
 m/SgyN2QdnZkRP17PPvLUxpYLLnr/j9oduTJsH5qSV+XGqtY0CmPEuMwc9bniI7P6vkv
 d2Ib4eiANUCnPl2ftDmk3DGkSXIqzInA/qEtviYEkWAYgWoxTjGGzCASKrdq/51DgHXX
 LB/ShCHz0hJV2RrhiNfX4Ubt70ADMSdNxBzgSsekGStIy9CmrbzioPNU0bI/JlQLZQgv
 itjg==
X-Gm-Message-State: AOJu0YyhtpKy0WzfI/7drP+YHCTzcx9peVLSGkrR/606W/ptpwAE43b8
 VpAlPkM/IBUEqnTakkFqLxS8WsoGnpxFFVM3gfO7R5S8fbLw+48ua/7qPIkboiczWNO0tIZON1Y
 xX3I=
X-Gm-Gg: ASbGncv5RagrfowJ4OejcaATdb6ltoCtYdcok64cmQYnVE6PtS53kukOrr587lyz2zi
 9iD6f4MwD5vKdxtqDznXj6RkQkws1/FoyWHjivqdrGwj3fqhpYHZho0P6SFh1KUXALe2aOln8We
 CEk+0Q11dnWHnTcMMVYjgtmCl3NNrgjQ/OVxWg5iCflhr/Nx1rFO8M1K0W38O/kDIqhVAPI+2d4
 acfXHwTMUHpzXUwwXltnKXO77ue2Ll+JD6yqMKp7OoUueLuwu/dwDUqcYA7GP6c9Iqw0ekOj2Gl
 /QAYSuIkIWz5yBU5/6nr95HVbb4dFF11wlyzu6bnDNMFwDcxZHfpt8OsOJU71WVxix9e
X-Google-Smtp-Source: AGHT+IHhoea/QF1gQ9pTncIUa5FMJqvgbmB/JMfou++23reA63bYMhgxaTIbRo/xcyRDEkXahxQhQA==
X-Received: by 2002:a05:6a00:2d8a:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-7305d5058cbmr11388620b3a.21.1739046741192; 
 Sat, 08 Feb 2025 12:32:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 23/32] net/txgbe: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:15 -0800
Message-ID: <20250208203142.242284-24-stephen@networkplumber.org>
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
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/txgbe_flow.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 5d2dd45368..9e446c80c3 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2827,9 +2827,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
 				/* It's the first time the mask is set. */
-				rte_memcpy(&fdir_info->mask,
-					&fdir_rule.mask,
-					sizeof(struct txgbe_hw_fdir_mask));
+				fdir_info->mask = fdir_rule.mask;
 				fdir_info->flex_bytes_offset =
 					fdir_rule.flex_bytes_offset;
 
-- 
2.47.2

