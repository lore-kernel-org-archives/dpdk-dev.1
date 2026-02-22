Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F030C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1315340616;
	Sun, 22 Feb 2026 18:32:37 +0100 (CET)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43]) by mails.dpdk.org (Postfix) with ESMTP id 187B4402ED
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:31 +0100 (CET)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6759a5576f5so1712342eaf.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781550;
 x=1772386350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjyvQIU5fbj6djIZLU/jFpRH/E8acjtWBxgF6EIMA40=;
 b=cZR1OdF9mMN5dqVmd2iTWDSTFfCSLwyjuYjnVz1419b0LPNIvznb/FqRwbQGgpnRjJ
 qlOFAGd2d5vDAZsPcizHUFu2fRAgJip5X5kpoAG5Yqzobypiek/8iWj2pd3gfMhdbkpg
 7FjCrLMA2L5xiX6HiC8FDpcfFxUcuNfE4DVCNMJRuaHPcR4atDeXmt8stmye1qnA3bLr
 4ayk/FWkW5VnK0qGg5EGtfOtAfkUaBMQOQJhxowzpbhVylNdGaTxn0BrbRYkbZB+xtUW
 vDKvi8HQ4+4h4k0L4nZihSTVVsaR5Hw8Pl3P52GQXlP//EfWylrakYyHvHbujzCF9L/J
 RISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781550; x=1772386350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AjyvQIU5fbj6djIZLU/jFpRH/E8acjtWBxgF6EIMA40=;
 b=skXahj5fEH34Zr5LQt1zUXvJJ0cQiu31lEcMeLosIYSpYWKjlxiEMQq488hGHYhmk7
 kVyZ9HsJJUjKnjM4r/fhwexH5LlnIT1BsXOS1Ir4El/Z2Q0Jbde4mOGy4CYMbmTwD0PP
 b7UNFevcYobY7svoWokSIYuxYCsb7BitTFPnDRPdh0FPnsvzU+o5fdqS2O+4M7S/FbnV
 Jm406HahW/XJuKGfOlk/PKezqB8cHTfLE38+7DwipQJq7ik07q+K4WmkTKXogqEKQ8Hs
 QDmlPlPbdr4x7ObneNEBuww9HymJ6F02WtxaIYXOp7ICmyDPXiuIcoQJ2XQJwe/Q2Bz6
 fCzg==
X-Gm-Message-State: AOJu0Yzz5s6rbaQzTRujwhmgoBYaQdAJi5cyRvekS/iOB2161kY6W9ha
 D4guMAP2OlEU2WQiJ0Ke5Xr9Ucvt5Q7lKnAHjzEWU7k16QNbeavGi8n0CLGq4V+HqnUxbMY7kGr
 yT58U
X-Gm-Gg: AZuq6aLQPDr4xt7rIqtRQ8ZfTMDH1PlJ7gFyZMktFUklpH83n24jkL6+PK4r2eEw4ly
 uWlUe59FKqs3gCiak4Kxdb7dST9Bzx0JBQLvKeU8HLS6P5HT/wbg+i+sf9U5Kq1PB4OnEPZadmm
 qKZ76MSeE1H8bkUb+4Roc+RtYZ6elVPTcmDP0E49ripPYbApWQYgIUPCI0SJmBzU5Z9tYwNyKbt
 YVcCjrF4pzcT+US9eWa4gnKX5cQFju8etNcrQ+y4zodKzczB6sZt3Ezj0mJYVUOVC9+z0R37ki6
 Ga2WMwM5EX2YZYO1EZf7LP0GFs+gI2aBTMyIL0MVC5UMacDpp6RL6TqA6c9FhfsPhfNY2EfleJk
 Gk2Gy7rxBPSdvgx8NzHG7LzE3RGvpmafJxn/oRrbVFTYvvAxGlZZMJZnRBo9kmGIOsY37eAQFP9
 9lQU26gSUKiP9+VJYcLNqOo2k/gQ8Im2FJtyBp2VZEinBP7gs2Je/dvu24IVmL4NT8L+Di5F6+
X-Received: by 2002:a05:6820:460c:b0:679:95f9:f1 with SMTP id
 006d021491bc7-679c461b1c9mr2703073eaf.72.1771781550365; 
 Sun, 22 Feb 2026 09:32:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 02/19] doc: update tap features
Date: Sun, 22 Feb 2026 09:30:37 -0800
Message-ID: <20260222173225.522754-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

The features matrix for TAP PMD did not match what is currently
available in the driver.

Also, reorder to match the order in default.ini

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/tap.ini | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/features/tap.ini b/doc/guides/nics/features/tap.ini
index f26355e57f..fd04e3bbd6 100644
--- a/doc/guides/nics/features/tap.ini
+++ b/doc/guides/nics/features/tap.ini
@@ -8,16 +8,20 @@ Speed capabilities   = P
 Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
+Queue start/stop     = Y
+MTU update           = Y
+Scattered Rx         = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
-Basic stats          = Y
+Unicast MAC filter   = P
+Multicast MAC filter = Y
+RSS hash             = P
+Flow control         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-MTU update           = Y
-Multicast MAC filter = Y
-Unicast MAC filter   = Y
 Packet type parsing  = Y
-Flow control         = Y
+Basic stats          = Y
+Multiprocess aware   = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
-- 
2.51.0

