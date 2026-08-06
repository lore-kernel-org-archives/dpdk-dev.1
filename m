Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E847C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F147B40E0C;
	Thu,  6 Aug 2026 07:10:38 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id E5CCF40DC9
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:36 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1790138a91.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993036;
 x=1786597836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=QhXk5tIHzFxKZCbBALgMME+MQSpD8UFAe8y++rPr3blaCj9Ti/gF5iFhfFzk2Vmuh5
 SSd95nNwGprqcel40k+jbltoMCYcqTpu6gTflMDhrpdEP6HzspjOOtJkNo580T50tJ8O
 4HeyatCpU0JuL4J9ScRUdGb3FKE2521IAbNqEf1QpjWvOJ9A6PKVDbeF3Bl2FJPviFM3
 w7Yza8EEoE9mV+waN0UB291SHrNNhn+DeGR2FhoS3uhCrP5+n0IgTXLIfJA5bCOEJKAK
 o1K/O0/2zzo+lHk5z6VO3DIJ59R+a/33H/lpJNiIDiuFKURbk67cPwjGNdspl2uioBVM
 7+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993036; x=1786597836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=oFKuwXSLYs3H4m0R+5sTRmBfwDEqcrCiCDzb3q0VN+EhkdGXA8QB2kLqfpreR2AmFX
 zN2TbfJCFZV35QiSWPUKs2959bMu8HJiAgwUWeuFbRU8I1XpnFp5Q0dUV2jaBdbL75e9
 HxsDlbrxG15vvyxsbDHJsXuwzW8yXf7wZLIkjEbpHfxkk7B1oVbj9EqKO1Tsxb33qmjV
 peh6WGZ/ay5YVlpKkAdGxKVf7FleczJ76yeNRhd1bKRw11pTuYF85ojM/KiIAUceBWLW
 N2H7sbqeHbSfkNjlXnvKMe3ayZTFNVs3wfdNGbv+4iJJFD7gIYmmHYOVJRFb8JVE9bS8
 70ag==
X-Gm-Message-State: AOJu0Yyuet2WvwDfm4t7YBcUyGtB18mtKFYH5OvDqx+4QtX7InjKr+q9
 e9yk1HMORU1YVSQ1qtLyRj2lGyhPibFWs6L5M1iyvf0A9Avu+m7oJ0XwMYKaA6iTK06F4JMV1rY
 JAfiADkE=
X-Gm-Gg: AR+sD13GY4SlbuNi+NugnE/ZC8Dfh0L47igePQNLul2/+it8J7FTkg+ePN3zpeXFXkU
 E8yjpOtRelGxnG/1T/VpqI01/ibyGathVneNk1RllAQHdxeoExROKo8C/meYqoyz1gs7VHX7MJp
 k08H+YFw5CWwjiNSpyEFqtN2fEzhuB/fN0Gl7N/1ydBE6Zy5cz4nGWRr+y+caL1SmAkV9a3yGNT
 V84vg2mED2i05uA4oun7nO5Ogml9DVDpQmZ5QRntLdwnyfEjk7jYHHpvmktq/Xg5XjoKcWfooHX
 Y7O96ZHipGPDTsXvxhoE+2kYHmyoPhecZ/K5IRTJ4aOVMFgkVdX8rvvR0NwdsV2TF43mDfo/pd2
 noZ4D35Uqm4FxLg06ob12htektVqQnCSboB99+t+II0cYmvJ0PqgavoHizh2gnVyNr+riYUEE7u
 7lG4clEcv7cWyFLUcjkU5FoG9OCzJrFBjhmN7DNz6tjakyiffswfmIdeaj3w6IOzLXl+sm/kkTw
 3WtKJx3t3LtIOmDS7JGNLGPJIM8
X-Received: by 2002:a17:90b:5683:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-3903c537a07mr12751213a91.3.1785993036074; 
 Wed, 05 Aug 2026 22:10:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 20/23] net/intel/common: include network headers
Date: Wed,  5 Aug 2026 22:09:14 -0700
Message-ID: <20260806051004.166778-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

This file was depending on network protocol headers getting
included via rte_ethdev.h -> rte_flow.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/common/tx_scalar.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 11ab6c08fc..dcb2ea5542 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -8,6 +8,9 @@
 #include <stdint.h>
 #include <rte_io.h>
 #include <rte_byteorder.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 /* depends on common Tx definitions. */
 #include "tx.h"
-- 
2.53.0

