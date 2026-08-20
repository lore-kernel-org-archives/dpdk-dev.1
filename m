Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BAC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C3C40DD2;
	Thu, 20 Aug 2026 07:24:42 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6FD6F40DDD
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:41 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so1067275a12.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203480;
 x=1787808280; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVnB25GDRIque1CRinvpZDiMaxtY92hftKxWPAKLtkQ=;
 b=Z7eiPL039GNOm7jVdfHVaolhY3nB6FxZrPTuVSxzcJtuih4h1MZYgiEjDGOXN0wIe5
 8Mac6ldsygNm0UlVYkbgDbf0bHjr0+hLoS6AXOtFpzpwFktDBsEnL+06o1/XVogbW3QR
 fYqLLAgxMzYdJS3OxTphWEAsokAOYJcIOKGPXjj5FLzjvLvw2xY++q1ko+UajuR85Tnq
 KjjZTmMSzYEDHGk0ZbfcE6apGRzvpaAcJGCWa3Mwzzyd+BlHEKUxF5NGf4hCS2XpqR+O
 PI27JQzXlnPyG1YFwsFKcxKd6tLs4dc6vY0KagNG4gteVSwqA6oBmspvnPpu6BOoc0cm
 AONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203480; x=1787808280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVnB25GDRIque1CRinvpZDiMaxtY92hftKxWPAKLtkQ=;
 b=DlzRvZkM63ZB8jzgrF404GfZk1gXUv/eEfoOpU/A1n5vBu91kLBaowgWH1Flz3egSM
 flznxko8Q4OF96230ivAGEJ8XnLwS9oXUOkQv+K+d1wuSIto7/OMOyXjA/PNx0Jzsp0D
 r2XumejmveVCTsk2mcu0Umg0d9oMGQeX4AU2RkvtsxLPlfx6Sf1kgs7NvgNUuRTtjBHP
 RXdSUiv1o5KFda9uRBD//at4xrD1JT8X0C3wmgNH0sdvtvKWOn9/2I9n0CmFUzpZUJ/B
 du9OXpQaF3HZf3SWr9zg2Z9K+g+qoO9i1kH+ljKEcxCDUPDrmuqhTMdLh1+yObO2zPis
 uNEw==
X-Gm-Message-State: AFuF++l+/A2vEu8A3atLUJls9Wyvqg4fXV+yPRj+XiidFNBxDDNzH5de
 Lxna8h6EI87kf1XJaVGZaMg14/IhbLHndKFGUgG1hR3IDbA3uGPbEY0Ly0HRQ6FwrFxfda5PQIp
 eQOUp
X-Gm-Gg: AR+sD13/JQdNID6xxgLAzUvo0i1ONoWGIyHRPmvZuCZbqj8mdBKBBXRrB2OFQsrUqnp
 sWTBMWhuVYTAXHpzJa2qY7aT43M0pHwTkkm8e/Td0EN7HIb2pw17BjD39HLBmNyIzOdpleeKxon
 n5eGFVfXtHQ54iGMrPUZ997el3+R4UEmzh2K+JJz7wmDVSPES80N6AQHyCKGOA00JKbD4lz/9s6
 MEUkUbIItZGQQmrBIfOcDWQCGCl2aIYrq5G4D7Rh50YxoXaBwTnHMYGwM4DHsF9Q0k/tqCooS70
 J/Bn9zqwgR/LcH/zxH7Ok0Dd5jCDe28asdYC2dtyWv5Yv59f7Yagw9oS7HAs4ryDfcWbGGGDd/6
 jC/lZ36aB9NZxF6u+UoTMbAzBuadnTkVJDlAsFttpCn655WJfLOrqcmQ1HVSinQLuGPhM1banF2
 sgBe563vZbjp/UMbf1bKw4bno5knw97GtFOTlwoSauz1O8cDhK3r9c8BANJIAV+lAS+C1C+ykrL
 MX3E/qv3D2Fh5xIcxGMmlAyreVTTY/JDhG+hA==
X-Received: by 2002:a17:90b:55c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-395813f758amr19464789a91.11.1787203480513; 
 Wed, 19 Aug 2026 22:24:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH 26/61] net/enic: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:16 -0700
Message-ID: <20260820052251.1453273-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 2696fa77d4..59a557a38e 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -1215,8 +1215,8 @@ static int enic_set_rsskey(struct enic *enic, uint8_t *user_key)
 
 	/* Save for later queries */
 	if (!err) {
-		rte_memcpy(&enic->rss_key, rss_key_buf_va,
-			   sizeof(union vnic_rss_key));
+		memcpy(&enic->rss_key, rss_key_buf_va,
+		       sizeof(union vnic_rss_key));
 	}
 	enic_free_consistent(enic, sizeof(union vnic_rss_key),
 		rss_key_buf_va, rss_key_buf_pa);
@@ -1248,7 +1248,7 @@ int enic_set_rss_reta(struct enic *enic, union vnic_rss_cpu *rss_cpu)
 
 	/* Save for later queries */
 	if (!err)
-		rte_memcpy(&enic->rss_cpu, rss_cpu, sizeof(union vnic_rss_cpu));
+		memcpy(&enic->rss_cpu, rss_cpu, sizeof(union vnic_rss_cpu));
 	return err;
 }
 
-- 
2.53.0

