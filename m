Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06CC021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A03C4065A;
	Thu, 20 Feb 2025 03:35:32 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id E10D6402D3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:25 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-220e989edb6so10855015ad.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018925;
 x=1740623725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJR6PF9InS1BaUTmKJip6ZgcqHzyePqPHzA16NlKzb0=;
 b=QYOzcFmpGllHY1mCVsf+x1xGaiqjMUSp51XaxlVQpy4/BO0pdm+S4xX9V9+TsShM4X
 svaK65VPadc2q+XFAID76qz89mhMEdTtsXKyDC5g230PQJlmtEilUz/lAv2iWlHZwe2A
 kAkZJ8zUEclAIwibs43W+CoW7uBud5bUsjms4XnxoVhFEWfSF8q/oIDIz05FHmM9zP2m
 1smTSuL+0Hx5BAWXuO1medRS2vfRdf80pM6HOAAj+v4evCY8FBKMPrxd9HTH+f95yDBB
 BeNMh6TF/XH3kU8wmpV5Z7VCYNOTqJvBy2C8nMglS/CcQ8t2WbOXp9IjaY6yXsuZi/+5
 PSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018925; x=1740623725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJR6PF9InS1BaUTmKJip6ZgcqHzyePqPHzA16NlKzb0=;
 b=CT9LR4sgh5cZQlEQrfxFuKFrpPE4zvAmBSkAlQZDabOv1+cjuXWyejPoHgoIrHrNk9
 6a+HZ/L5w/YLjNVskXtWDVX4xykSLasAB1h7b8jlqD/DsT8Ez5BYHAxur7vFLBGr+5e9
 i3m7dl+Fgyy/8Ol/QwWSS1SL7TjTL2zQ7k16/6GMYQOwpAsXzAvWLUpWURTgn8GjWPbh
 8ThWMpZKXiDz1gd0sSZnC3DXlWAqut6nTB6gn2eL52gw1imnxQLQ16JNomP34WzhxMZF
 PtzOrGYkn5T23o7rlPcQgW8EE2JMaOa3GQXFDDbeugEfkqnRJ0ognIdL8ZcduHJda3P4
 NWaw==
X-Gm-Message-State: AOJu0YxergTqf6L/Uxc6yHanlKX1vv5CQra9LnEXbc44vmixNlICASdH
 Eh4DYBVxSUyXKIVAOJK4Onq2pysl9mr643Tg6MfCZ0UwZE51tz1eXrDRPvV57Qwp00ySc9OMeau
 oHCg=
X-Gm-Gg: ASbGncudsSRBRdZIEngiDFjLo0G9N8X/UFfrCQIXz6ejJieT/vqXD7AnYKHnIwgIMmu
 XB0ouOnU5OM9anTGPc7ANIRgwkVhNLfPgAYA4ZMTzBBo6IIAvbG1/fP47JouedCEZOMmq2mmrmR
 MgvXXeOcbaDvd8UOD/b+jBPMoaSMpgYylH/iN+44lUJBblZ8FEqPY6MELSX/B9p40rofeZqHEbP
 tESIaHgZejdRXWnNXK9j6+sogLepDvqioAKNE1r0mS1ngODgcbyacVRoZPSRQyrirxvlH1z5RgM
 eSAEgi1ylrenyuco7nfK5JmVRswaurUugN+ZePjACsMzV8pBh2IABk7l6bAeQij+rkwA
X-Google-Smtp-Source: AGHT+IGp/sZd3gxqP27ygST0P7FLOIBE4pTIiVxoASHSbFgtDx8okKzFCIowLHS5WvMDcZ7QWoMFgQ==
X-Received: by 2002:a17:902:f64a:b0:220:cb6c:2e30 with SMTP id
 d9443c01a7336-221040bf792mr310136885ad.49.1740018925083; 
 Wed, 19 Feb 2025 18:35:25 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@intel.com>
Subject: [PATCH v2 05/14] net/ipn3ke: remove unnecessary dereference
Date: Wed, 19 Feb 2025 18:32:09 -0800
Message-ID: <20250220023509.630569-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

Since it is a function pointer, the expression *hw->f_mac_read and
hw->f_mac_read are equivalent in C.

Remove excession indentation here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c | 27 +++++-------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index baae80d661..c8f06a06cb 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -229,34 +229,17 @@ ipn3ke_mtu_set(struct ipn3ke_hw *hw, uint32_t mac_num,
 	uint32_t rx;
 	uint32_t tmp;
 
-	if (!(*hw->f_mac_read) || !(*hw->f_mac_write))
+	if (!hw->f_mac_read || !hw->f_mac_write)
 		return;
 
-	(*hw->f_mac_read)(hw,
-			&tx,
-			txaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_read(hw, &tx, txaddr, mac_num, eth_group_sel);
 
-	(*hw->f_mac_read)(hw,
-			&rx,
-			rxaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_read(hw, &rx, rxaddr, mac_num, eth_group_sel);
 
 	tmp = ipn3ke_mtu_cal(tx, rx);
 
-	(*hw->f_mac_write)(hw,
-			tmp,
-			txaddr,
-			mac_num,
-			eth_group_sel);
-
-	(*hw->f_mac_write)(hw,
-			tmp,
-			rxaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_write(hw, tmp, txaddr, mac_num, eth_group_sel);
+	hw->f_mac_write(hw, tmp, rxaddr, mac_num, eth_group_sel);
 }
 
 static void
-- 
2.47.2

