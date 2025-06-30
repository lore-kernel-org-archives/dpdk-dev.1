Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38B5C8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0050402A5;
	Mon, 30 Jun 2025 18:05:55 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 50B8F4025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 18:05:55 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a818fdab84so21268561cf.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751299554;
 x=1751904354; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qHZP+wMkE+pluugPHU/y9Uy9WE4UlraDjmSwKSnF1ZA=;
 b=GcDsaM2x4zF8fYSv04XGpV3+yuL6wGY+oG2Ag7jhlqZaOIFiLGzqrVFazom6Me4NrE
 0AGU0icC/PtXzwbMqrYoDMO7j0GcNNH4X1baDh7rZ0FR9Byi9NkqxZZvOTLDoNX/uvgc
 5NrBeX/fPi73srcy6v4O/EES5wmIDsbJMEQkaD6vEM+PXGAzAvU3viO0skLefvFefsWL
 p6jbz9Zyd0AnyMjjkEP7tuSj4G7hTut1nS6QVx8sKQ4zSW2N+MvD/bnbh7wUU/+x/Cbr
 1qbnhbqDCnhLVkmFX5lP7En0Ab4oG4KG//vy/kjFLZPtAs4IJge19eN5hGpX9sDK6HeH
 oipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299554; x=1751904354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qHZP+wMkE+pluugPHU/y9Uy9WE4UlraDjmSwKSnF1ZA=;
 b=oY20MBgJYHX2bCBQcTLKP0EreQVSO1ucaAy7b13bx0GZ3Bu+NTSDS4Q0hk2iKZEvpg
 pQdw2wsBeRZ/u7L7gybC3gXHOOOvRnJCB9JeGDi5i/RNAaQLGGs3RwEzlsMGhbS9dlJY
 idrJmC7hmc46zeCQOv3O+BSxGas+OYYyTFEWJIBTinkFS1aMt8ArlGtfNVFH1IfeOVN5
 FpxeLvz41XhYie/5zWIhzxsqEoz4eodoBUZFUCOO6vhl6TZZeearWAFifFqMa2qptbSt
 KdY4oFFpb4pvwb9+VVPJhEy0yz9TDTqLNsb/xi5MCDu9v3GHs0Rw+SDxKMkcSNO6UFPi
 QW/w==
X-Gm-Message-State: AOJu0YwAP6wFlXXppSZ1+PtiHTrwQpwW9fdUpzx2NuEFmtJ/iKVkgH4m
 HUv3PYFWUadbEd80+iCrzZ3a+qeMzl8iKV83i13oXcSr9RQYbh7/vmlUSq23V9SwmwmO70q6EUl
 XzXKS
X-Gm-Gg: ASbGncsqy6qO1mXXRk2QjJfI/gmCdSA5bZVqgTwMx+ncm3ibFNGwJ7HPt9cLmcHlfiS
 3Ew7ONyloscNL2D9rq09a/QwTgxUv0CWj4c4Wt2SK41NJWUVUMMjhnVS6bSkOcg3tb9TXi6UOAH
 PNgk85b4369MqmS8ymIaT452JGmwgBo0e23JsDC5kWQtgSK1Jq/cXi+jMHcAsDJNhO2bOwvB5fl
 7Byhy8XC6hHsEWz9ZpPilt/GdTP5gnFHEitFBgXsuvqTQLrJ/1Imzk3R7BLRvlEa6AolNjhcZtR
 h1EnFjifznJs44BMMrnMPfG0hqZ0tdTQ0mKl0ep13En9BLbhNojGKEjlIPOONmbzqQ2H8o1Pb32
 XWrfU8s61o2xfupVz502GhYpbuUQLIhE1J8hc
X-Google-Smtp-Source: AGHT+IEt0V0GbaYS5G6q0juStkOXv7t5ZOiNhSnOiKylNwAAkFoTktgZJ0pM+zGdEbbI1TrunG5rTw==
X-Received: by 2002:a05:622a:5290:b0:4a4:3e89:d5b9 with SMTP id
 d75a77b69052e-4a80f53604emr119846921cf.43.1751299554380; 
 Mon, 30 Jun 2025 09:05:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc10bd52sm61177591cf.12.2025.06.30.09.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:05:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, howard_wang@realsil.com.cn
Subject: [PATCH] net/r8169: add missing newline at end of meson.build
Date: Mon, 30 Jun 2025 09:05:34 -0700
Message-ID: <20250630160533.126163-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

All text files should have newline at the end.

Fixes: 65b2af0e4e81 ("net/r8169: support RTL8168KB")
Cc: howard_wang@realsil.com.cn

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Anyone want to figure out how to check this with check patch?

 drivers/net/r8169/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index ed644059f5..e0b3e88c3d 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -32,4 +32,4 @@ sources = files(
         'base/rtl8168m.c',
         'base/rtl8127.c',
         'base/rtl8127_mcu.c',
-)
\ No newline at end of file
+)
-- 
2.47.2

