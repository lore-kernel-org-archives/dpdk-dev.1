Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B20CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8792040E30;
	Tue, 30 Sep 2025 09:05:56 +0200 (CEST)
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com
 [209.85.217.99]) by mails.dpdk.org (Postfix) with ESMTP id 7B01C402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:09 +0200 (CEST)
Received: by mail-vs1-f99.google.com with SMTP id
 ada2fe7eead31-59d576379b9so2635228137.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192629; x=1759797429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=EtJqkD+sF3BA01qMNeUQRNHO3Osyjsx2rRUrP3CvWwiuMgjBse70JdvqD9BMnh24mX
 LU7FKujToavXk8MugI21UhEBQ7/wYECfwLuRp9KVDi+6wj3klnahQMvZiZonsJCfxMrG
 cGH5tUVUESzwMGY0Tn/T2eCl439kmL+KaHq3HGIbLUDxqQpOfZbEbHNF9PvqUPUJ3Ubr
 YeDLEZe2OReaSyVkYiwt5HoMywYAZcsE7cud9QQvoNCe1uaqh59emQT9LVDbnQmp/omN
 u0h9VCWdlktdkOwAE1OE77NKlvSxEKefIeSoSKM7Wt/x/PS4lCpXnVtWBU1E/TLn8pe2
 FhNQ==
X-Gm-Message-State: AOJu0Yx0+lm5PRAbhudu5ObMuu41DmKRWODf4yvYC3y0iuE/gdDfyXFn
 1AZTf67DV7RpVZQhcQKurkMTegFswQNuaOrooMg3Ut/svrb8hy83Fmn8AJYyQLAgHd/NrPbnZD6
 dS5uUTY4pbWLnEqVH2YiW63DcZ/hu/zh+enXLRaaUqBkhzbE2PJpRh2smtpe/b3zvZiGD4D92yx
 SwNt9RHbs50PB9gK8KoO1pWvPg/LeJAEIyp3qXHEZoFAJuhcMxtxQSw16+hrmOq7khPmKMig==
X-Gm-Gg: ASbGncssMd2cjq7o7wuNjladdmpEOai714szIcuAtDR1hFZtxjS7xB/cZnrBza8mw3T
 nwGfkozm4y1ghksuaLtzKpqpiuO9RA4wGZQvMGDwHVYwPUUBbNb/M7fRcUqQLf3NNNyqN06xGW6
 //1ajovjVO83Gmp+FmnJdOE538HPqLCYoOyq0x6n8PnGu1w1eGbNjCwz1h39GU7FkjKkdZqnUap
 PI1xSl93ZaW3wMrlC88mnIJWjOUWF0/SYBMm605cGQI4fycTmKd+0ppxLT+QC1PW+oCgtHdpKm2
 Tb9NIgHpsd4kZLxx69RJLG+TP7IyTIMAW7nDtIXMKyyxt+GWbDDwH6NlV78m1QVJ33bFX725UQA
 OTMVCLl07DEqOE/EkAvO/1UkOKNxGbO+FqK0JqXl82pQ4UY78UyjK1F3bdN1lEntKrqcb0J8o1L
 0l/Etz4vI=
X-Google-Smtp-Source: AGHT+IG4reh5Ps72oPoCkIxskRx9Dl+C6NgAUGs52captHExfUnTx4LrcRUNKhVSPbWpGCI4uEoDMA10ESNF
X-Received: by 2002:a05:6102:5488:b0:55d:cfa5:9d58 with SMTP id
 ada2fe7eead31-5acc72a1b1dmr7681230137.13.1759192628658; 
 Mon, 29 Sep 2025 17:37:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-5ae302f2b7csm1038991137.1.2025.09.29.17.37.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7810289cd5eso7476145b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192626; x=1759797426; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=GOi1kNYoXYf9w0WzT3c49N1P54pdAgeaU0KqmnX5AdtTOdQQ43C+sE6fI/YdkoYZWv
 wp+WT9ItB3g03Y7fRws+UVtpymesn3gB4n1vZrwmAiRR/PZQ6xs3QiPxq0csj7t5WeiM
 EmxIg16gf+akWoJwgNxrQO/7ipczCs4MCGAmQ=
X-Received: by 2002:a05:6a20:4310:b0:2fa:26fb:4a7b with SMTP id
 adf61e73a8af0-2fa27291293mr16568681637.57.1759192626490; 
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:4310:b0:2fa:26fb:4a7b with SMTP id
 adf61e73a8af0-2fa27291293mr16568649637.57.1759192625936; 
 Mon, 29 Sep 2025 17:37:05 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH 25/54] net/bnxt: truflow remove redundant code for mpc init
Date: Mon, 29 Sep 2025 20:35:35 -0400
Message-Id: <20250930003604.87108-26-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

This patch removes redundant code from two files which is used
during mpc init. The NULL condition check for mpc member in
bnxt_mpc.c file is not required as mpc will always be initialized
for P7 platform. The extra condition added in bnxt_ethdev.c to
enable mpc for tf apps is not required as it will be always be
enabled for P7 platform.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index ff2f0d7043..2582b50782 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,20 +719,10 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue;
+	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
-	/*
-	 * TODO: This condition check is added to avoid
-	 * segmentation fault in case mpc argument is
-	 * missing in dev-args. Fix this by removing
-	 * mpc argument from dev args.
-	 */
-	if (!bp->mpc)
-		return -1;
-	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
-
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

