Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57842C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1204406B6;
	Fri, 14 Aug 2026 22:20:39 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id EC082406B6
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:38 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cc891373e0so20945615ad.2
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738838;
 x=1787343638; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJnzJGD7o62kHjLlXNyobGT5RHdeN6M1yGuq52c6nNQ=;
 b=WjDjurNmwnxK/IvwTai2am6Cbid1gN4I3rO3CbnROrNKyhcPGgKlZi3TO6nrMyqFej
 5enejnGprVX279YqsUCb8KciQ25nxxMhJieb2M6tlMyiMvoFlJEclr4832GuKxHSelYo
 mrTbNXIYO34tXKa9g/1soalBg7OFHjOiYIHm3/kn6/0EILFR0eWZuwB+ol/Yx+PARJ5y
 G47kqPJyENuXX57VFLMewsahMFF5DFU7MaqaBieebVSrpNCdXCDB1pEHZd45sln3Y21d
 z9610r4xxfaWN7xI3NsCXbstwOP3SHo4nbaRFLL9QiLJP0zJw3NUJ/wf4sqMCBUqkkqj
 AH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738838; x=1787343638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJnzJGD7o62kHjLlXNyobGT5RHdeN6M1yGuq52c6nNQ=;
 b=MS1TzuRgFTuvML2KBBgdSLx+ENYZA0ZslCV/qBNCAZYV28tlELqtsLf9PGLvKHAEAE
 ckBPeOI+4m5VbgrJxPZRrEWUTqWV8tYPDUmDIY8mAgYHFmcq2/gCq960ErAjfdIPqfHt
 l3uVE79fVQM3dJpQzNaXC6W/A8TYPqjw3XWDR0APTgX/+xN7PWUC7I1ieqSRxHUqqWY+
 +eK/TmoQuumUiSTfDQ8DM4TvlFHfaZQkS2ithmKLQOVRX802bqaNhG1P3Q1Znqr2jcD3
 NmVL24kzTIgyjJ9/pII6BFLwMoxnlTURVjQNvWXCJoxyMY7fi6LeVQ4vlvTUQax/r3Lt
 OYmw==
X-Gm-Message-State: AOJu0YxhXmw0R2YnlZDxLtJiBLNgTShtLtRwQ16BtDE4/03gaDgPDz/1
 J5VK+4G0gZvysIMP6Ygc3Z4hY0XZ+426qJqi+XTZd1ZpKUcRy254+MPDxFlpztWMgjuQK+wPs7x
 Q/JWe
X-Gm-Gg: AR+sD10Non03+jzy+0xGJ8Pow4VVJd6FuTxpXE6OAyHtyoA9Qc7kVWVCYgEwpzJ6NjF
 TMfQakxDobwU26h1dOPswzsVKmsRwLqJbpjaoroXohjR7TieDSR8e1wSeX4PSxLOpIlzKEKzQnO
 igJPTCg8fvMxnhR/0hU/FCr1gHrcWLRDmbjp/c2HoWUeRObA72uA9XxOkH2SRfcIz9cU+mhtX7m
 JVHcZzcvcfyNEg5xLocWP++ltx6LQiwQYlo1HN6vAQoBhco80NQaV64ntOCrUf1Y2Wb+u3UFAa0
 FxyAjRMpDpqxsigY8QO3CFJqGuyVsGxFOJ4NWZjsNbxhuVmYf2Xkot/FXCGUcqRTka8MDT50iJ+
 wccPa8viAB3K5Q7qbyUphMI6VBg57rgx3k4fiYj1Irk1HuMDww4Gc84CK9VNfSWgR+E5/Vb1shb
 WSP2mw4IXdZ72YYoCVgMN0OhcisBQ9sZvjvzhBgvyFHvftikHbJZRiH5Xldg33kS5g417Cx5A0f
 7D4gJDXRVg2Ts7mzY3gXK07FBw=
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:a543:e7f5 with SMTP id
 adf61e73a8af0-3cc71d533f1mr9807239637.3.1786738838026; 
 Fri, 14 Aug 2026 13:20:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Liron Himi <lironh@marvell.com>, Jacek Siuda <jck@semihalf.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v4 12/16] net/mvpp2: fix out of range Tx queue stats write
Date: Fri, 14 Aug 2026 12:46:08 -0700
Message-ID: <20260814194757.329424-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

The Tx queue stats loop logs an error when the queue index is out of
range, then writes q_opackets[idx] and q_obytes[idx] anyway. The Rx loop
skips the queue in this case.

Add the missing continue. Latent today since MRVL_PP2_TXQ_MAX (8) is
below RTE_ETHDEV_QUEUE_STAT_CNTRS (16), but the check is wrong.

Fixes: bdffe0c70a0b ("net/mrvl: support basic stats")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 1074092d43..bc947ff52e 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -1546,6 +1546,7 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			MRVL_LOG(ERR,
 				"tx queue %d stats out of range (0 - %d)",
 				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
+			continue;
 		}
 
 		ret = pp2_ppio_outq_get_statistics(priv->ppio, idx,
-- 
2.53.0

