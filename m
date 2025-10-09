Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFFCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3946340E2D;
	Fri, 10 Oct 2025 00:16:46 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 4882D40E68
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:45 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b67684e2904so481918a12.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048204; x=1760653004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=Uivv8uuRx7+TF2t90MtlkKnksBfbeH1Yz8NHexR2FtT0QDvAzlvvOZE1DqXsi8ANO/
 bnqYgCIzyJV945H9prxrvaqTw8QS+nIRX96ziFQXI+avavHx950NJ06T/xin9dTTAavA
 WdQJcn9KgNOD/MNJGR7JCCUt7U0w/ZsYBRJcA8kAkuYkaKnsb2msPW03qfVLJBNSIPdu
 MQ8Zj4XX4KU2OLmZCeNMqIqwLKnYqkLVSwytjIVJC3W0tIGOuaziBTv5XqJalRlNW5Cy
 Llg+9cDLquV0RAVgMrFo9ZY2nPMw0WJIsdRFpY0b3H9atBKrC3zhj0iY4U1x1l843CMn
 k8xg==
X-Gm-Message-State: AOJu0YxhCdZ5zkZ777JJfMiwQLDd9totdqscFzrNSeS2JNgt3YlbcSPf
 59YkAmBByA8pRF3v02yiqh+S1zreGo4NegdWylcATwqQMHlr2KVeY6HJpcfyFCagHj4+qLP1aKA
 lU7pVBZ2dXOajCdXoGNwoFiOwyBFIM3o8JosAxNeZHdpgRfZi4poqbWiuRnvIGzgCC1mTPjMurd
 8FiiyxmWXTV9LvpjD4Uxq6ZR5BDsIqV6kmx5MtIx5DzjVY44EpULPl3TwX/PIcl5u86pZOZQ==
X-Gm-Gg: ASbGncvFoDrZKxoBvW4Kr9KwgHhi1yDdNgds2IVZDsx37zNoRWahPw0rp0rf+AbpU2Q
 4qh4DJwtcqYBvm4sxVZqiNBYY0l6CqXv2NbOGNzmCi5KIJSJO1Bf03exnvdoLWXC0cZJKaTcjFI
 H78Ab6XfwEXgbHDddpHhxRUEmlNb6vqg3CBFU2Dq7fCQ8IbK/nOcaETxLDx0y2dn8ru1+dUE35X
 x152XllJPAvHYH6YXEh716nMkXxMRoiaaHBOydC61eCIDDQe7gw8IfUlC7crBbb6AdgqEiBWEJH
 Hbhp/+zLHP+9XYkFwdNLO2zp9UI/Q+yG4sVYkq7Xq3PDQESqXU1nc2UxrzpBYlmlWxWWbJPrEej
 20YjM4nJpPSmGvsuvKdL1/q5pHgMGG0hScs0dtY27uXItCvaAOVGpJA6rGYQl7Vi7oYGPFQcdZL
 rk+Hv6
X-Google-Smtp-Source: AGHT+IFZg3+qwMnhW6lYjGbZ62AMWnvF45bTPeq0cZ0u5vm2md4dvC9l6mVzY4445tzvKny1t8bp7n0twIV6
X-Received: by 2002:a17:903:2acb:b0:268:1034:ac8b with SMTP id
 d9443c01a7336-2902739ad00mr111683375ad.26.1760048204407; 
 Thu, 09 Oct 2025 15:16:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034df065esm3075875ad.1.2025.10.09.15.16.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78eb8a9d229so42250706d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048203; x=1760653003; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=fN6gZhOGmvGo89lwMgmUtSUVTgcftk8FlYgWoxGfmr8s4z/hDo3UGGdhp0k0sTR0ih
 PhAzjpi69b5XidgOhpGt8e95xeY4FrhAUkGBoM1iXkRHNX01Hm+ch9N0ySct8pyCjSr6
 cLdpkuvoSiS13MQt2bBF3xAtOVLo9/MPKivRo=
X-Received: by 2002:a05:6214:811b:b0:87b:b70e:c76a with SMTP id
 6a1803df08f44-87bb70ec840mr40202526d6.12.1760048203038; 
 Thu, 09 Oct 2025 15:16:43 -0700 (PDT)
X-Received: by 2002:a05:6214:811b:b0:87b:b70e:c76a with SMTP id
 6a1803df08f44-87bb70ec840mr40202076d6.12.1760048202477; 
 Thu, 09 Oct 2025 15:16:42 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:41 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 49/54] net/bnxt/tf_core: remove excessive debug logging
Date: Thu,  9 Oct 2025 18:11:24 -0400
Message-Id: <20251009221129.28256-50-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

