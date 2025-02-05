Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B228C02199
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EEE840659;
	Wed,  5 Feb 2025 18:20:13 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 145474064C
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:12 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-71e3284f963so33190a34.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776011; x=1739380811; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyWYKXiW0YF4TFx49ln8odujwWD+YZUdsHR102rFq6A=;
 b=UY19/K9urzhXkSB2RIlQxWcwFnc1jeUCz59FYt9BkxnytScFYIhEMLvxtblG8dprjD
 N8fsvNkmenDt3ObAehrFPC6VRumUiWFelE0CgQVOk8wXFxz2wuVCoi/ztGTw0MW5ro2f
 Ysco9VtkgAw5fp7KU5Q8UdfggKx+3n+8xi/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776011; x=1739380811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DyWYKXiW0YF4TFx49ln8odujwWD+YZUdsHR102rFq6A=;
 b=rznLTP2IebP/mr5ibL8kzouVm1KA/83ffRHgn1rlmY5QAa5GRd8+ymZpxBiO6k6jkE
 T4NPXhDGWmjmx6wy1JhD839M8aDCHbXDttkbFYOsKOvKxsq3nfFdr55VUWYHE8IVUalN
 tcxtYpCJ+gkjEQudqCz1P50CyPgttis/SzELLSM3Sx02NAz3hJEPIicJmcKPMXE332C1
 aOXsRAAYO+p8EwPuGVMAo2zr8duQu4+XLCXEFTmGcMll2bTDjCmPgmIKxPbX23JS/IEW
 I8iG9uFzfIztQqHchaooClUOV54Izl6JDtZy9lhp57dcI9e9Uvl6wYQqzJAM4zsBh01y
 Lg/w==
X-Gm-Message-State: AOJu0YzNhoLUiht/DZpsckbYrBHIzmuzAE6l3RfVH69V8qep6A+Vka47
 BmZ+77jF7dzwCjhnnysPxEcv7UHxnQX0XVJWRYhbdLjO6RcU04AOPFcKw+LBa2zAv8Gmb+VcGpS
 6j2A+GLo52qHsBibHVEwB85dciNjoAk9Jst3eeeSNfZm+esrr+snH3OdQLrowa3llQbeuVIJqPg
 5KN9ffdFdlCbWKNDeX/84pmeAOde/v
X-Gm-Gg: ASbGncsaWtgjTOJRO21ZwXuwdoyYlcgkhOtOmTu2q9WlFFM4QOMlgdh0yMAoHC6KlwV
 huIvAgAfYesWAdBVeEgBB+e5fRvpVi7qB8XLmXW3AAVGOmR0Ci/r4uF3IIEkIJqJ4atkcnCK3/b
 kxepDQAjMgJxVvI3ZDbXbAmGVyDvNCZG7n0RFeRY0IkDWThkECsoqzWZRdNBt9dADm5kBL8bLzt
 953+fEfIeA3fm+kTuyjm/Y/1sIk8caUSrwPIFc57SPsNvax9oY4rcfKhx//jnCC0ljQqw90n+qJ
 nxCy0FXH3s0gJ8FSelvkbRrUwed0/dOSPqhV1NOEDL56fHM0wSc9b+QfOwzomipnE/qjEERjqo2
 lzuDhFGpR
X-Google-Smtp-Source: AGHT+IEJQXtYDs6gUPSaXXVW3gn8Aoxs/Jzv5+d8SbE4k/pLU0pRE8gqmqmdZ7/qIyM+xndynoE68g==
X-Received: by 2002:a05:6830:6785:b0:71e:4fc:6ed6 with SMTP id
 46e09a7af769-726a418c41cmr2643631a34.10.1738776011055; 
 Wed, 05 Feb 2025 09:20:11 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:10 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Somnath Kotur <somnath.kotur@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 02/11] net/bnxt: simplify check for CQE mode
Date: Wed,  5 Feb 2025 09:19:55 -0800
Message-Id: <20250205172004.50395-3-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

Simplify the check for the CQE mode.
We don't have to check the Rx offload mode to determine
which CQE mode is supported.
CQE mode is configured at load time and once set will decide
if TCP LRO or buffer split can be supported or not.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 4a5c224c09..c9fdd36d3e 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1112,12 +1112,8 @@ inline uint16_t bnxt_max_rings(struct bnxt *bp)
 static inline bool
 bnxt_compressed_rx_cqe_mode_enabled(struct bnxt *bp)
 {
-	uint64_t rx_offloads = bp->eth_dev->data->dev_conf.rxmode.offloads;
-
 	if (bp->vnic_cap_flags & BNXT_VNIC_CAP_L2_CQE_MODE &&
 		bp->flags2 & BNXT_FLAGS2_COMPRESSED_RX_CQE &&
-		!(rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) &&
-		!(rx_offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) &&
 		!bp->num_reps && !bp->ieee_1588)
 		return true;
 
-- 
2.39.5 (Apple Git-154)

