Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB5CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10CCF42789;
	Tue, 21 Oct 2025 20:58:43 +0200 (CEST)
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98]) by mails.dpdk.org (Postfix) with ESMTP id 6A0A740FB5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:41 +0200 (CEST)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-650304a822aso1304612eaf.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073120; x=1761677920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=X4mwGuviIeh9H49UA/l36YGu3jNof5jii/uQqWjqJOpoMGuDrGNKX+48Q+fP1ZGipH
 phOplXMikdH4Z97d5FTMfqzF9UlW9YywJBsZ1+Bjg8KqlG1JZPaItTG731pgyNN+pQPV
 a+1HdALeaeAtHsTiZ9nx9T6x+ydZIbeDdloS6k/tto9KrFtyPJq7ca0vX1fBTkh31M7/
 zjN6pUgxSoQKMyu43iAq7W7uimj4jrW30W0ULPCg6v7uRUP42rn6P/lkyycFoli98/bt
 1pS3QuFgnIBkI2S6jigOEdeP75ne03KjAN8CoQ4eUDETFgLxNrIQivZSR6ZX9B+1BpGW
 ij2w==
X-Gm-Message-State: AOJu0Yy6ChVs1ILxAaQUwyEh54YieqqXo9+arpM+AFE7EQqI4rMxR4BD
 UYKuLocSeNsk+navMVH3aeR3/SZ0uug/cXwAgTpsq9+UfpoofWVTKwMfacNWozA+tSgUVyrJP59
 jlcmEN0i4rToMauwDkw9MTGn8vHkJcIO9WXblECyxrT2srvUUI13YiWuSz1qdyTIl4RnoR5S7xS
 rqyWIUbdQtmacrC0jNAYQFRO8TZzM49DjtqQ1u53XX4QZSvxbQ2JhC2InsX7UPde7AJBloSA==
X-Gm-Gg: ASbGnctqf93zsWMm1aKN3pqKzbS9BZyL5qwTpnd6wnO6kb6PSFX8YhRHBjd9IjsvI1L
 zXrFdtT5DyL/ZX1C+ODySnRwwFdq34HtVYAChwwjKqPLpppWF063su/iXg6EdYiFnxRfWlzRiXf
 F63KUp5HREc1VYTQgrtP0kO0frdMIGBAfKmpZWU+unzYNfqRVWT27qNf68w6MCDOQV8mIFwDZvP
 nKSKDBEX7jVV8vjwW955rXWbC5AQE+n2LTho6ouO24hzTIYZPKbeqUh/FsppYEKEHrykPsdSe4v
 k9r7GfcboLrc1x+ZwAzVOAPEYmZvWrwq5NJehThwPvomAl4SAlA0vid/UudxzY1sn4wVFbGpvky
 H5GJgQRcoSz/PGX/j7oOfLpYigbk4Qo4Y6Bv9DMbWgsvBhlQQptt9INZ2I544kGSEvy/1+0oavq
 9x1vkrtlWf6gi5qd+tQLiuecrlQX6AGpitQQ==
X-Google-Smtp-Source: AGHT+IG+A1nXNH9k7yEAEiogyYdMZTxhT8QteE8ksXLYvvrpN4uRKyIJewe/sphyM+wnzxOR0MlTT0ViiEvw
X-Received: by 2002:a05:6820:2006:b0:651:d1f6:44b7 with SMTP id
 006d021491bc7-651d1f65e5amr6210330eaf.3.1761073120551; 
 Tue, 21 Oct 2025 11:58:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-65364a67344sm17774eaf.11.2025.10.21.11.58.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-28e538b5f23so65761335ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073119; x=1761677919; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=bUikhSMW2NzaZGFyLxubeMam4mVq4Co6dEpvNIs2sqw5+3B33fjPjFMhKeRMkcViFr
 f0kq0wO647rAq7o3OnJwERkGsYwyfDepLyVgc5ayLskcEZji4cEAGupw4KAnPspung95
 CwQvZBvol03iFDamfO6fd3MrV/YEXmdX5V9E8=
X-Received: by 2002:a17:902:ea08:b0:28e:caee:40d4 with SMTP id
 d9443c01a7336-290c9cbbf3emr224906695ad.15.1761073118624; 
 Tue, 21 Oct 2025 11:58:38 -0700 (PDT)
X-Received: by 2002:a17:902:ea08:b0:28e:caee:40d4 with SMTP id
 d9443c01a7336-290c9cbbf3emr224906245ad.15.1761073117943; 
 Tue, 21 Oct 2025 11:58:37 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:37 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 52/57] net/bnxt/tf_core: remove excessive debug logging
Date: Tue, 21 Oct 2025 14:56:56 -0400
Message-Id: <20251021185701.71881-21-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change removes a debug message of questionable usefulness
that can spam the terminal if more than 5K flows are created.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 47870747e1..3fe4dbe3fe 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -1012,13 +1012,7 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 
 			count--;
 
-			if (j != start_index) {
-				PMD_DRV_LOG_LINE(INFO,
-						 "%s: OOO comp. Opq Exp:%d Got:%d j:%d",
-						 __func__,
-						 batch_info->comp_info[j].opaque,
-						 opaque, j);
-			} else {
+			if (j == start_index) {
 				start_index++;
 
 				while (count &&
-- 
2.39.5 (Apple Git-154)

