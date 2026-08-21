Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC945C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C822740B9C;
	Fri, 21 Aug 2026 21:28:59 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7769940B8C
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:58 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso1313853b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340537;
 x=1787945337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUH9CsNCT2AYo/KL1wiCsOtz/uHuiRHqKrMuH1ZeNEg=;
 b=AxY28hsthLthebX8SWRzK7SIyv6ZWe5agAqQzfZNKHK0YMGzWZ63lfRxcZvUZLBjjY
 GCKNqm+ZNPUKE6/ErIGK/S18c93TNJm3jNUs7Vnn4B5ANBBc1FhiR7wRltJwfoIKZ1L3
 efjeeQZ1YgLl9Xj8CrnL0RzPKLzJB2CLaD4eHA7aWwo+Hu5ubX+Gjmi+xiVnVBVKzmjb
 Qfh50uQ30WH/FVwX4ukYQ30Cu4JDxFZpLt+OvIw/+jvCigaY/qyt67efdvbhYvwyXtFt
 Dk19OHWH7M0y7scgVw3fFiElixQ6P7gbnOOlHNjkQJHQW/04EXtz31WQNX4ohsCz6org
 PoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340537; x=1787945337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUH9CsNCT2AYo/KL1wiCsOtz/uHuiRHqKrMuH1ZeNEg=;
 b=ZRpB30MyA3n6KDrlthOQoayGyL4dHLWquSoW2Wsvix5pNkE4o0h6vQDaQe/0cXFQ57
 XqyeyOHf1m7tZqzBKtAYp5SfSiY7uW0iVUmGggJs4j2SWe05hDMNmbJedL5TtCsIBHCX
 a4NF8GVyyrfXX2a7sgRbfu3OOKkdF1eFs/lB1VScQ+Ei8CTDHTy2kcu5LCu8y+/f/0ms
 N8Mcx5/blwGqKRmcNobpnbRnQqxftnsoK09J3Oj8rIAAUqVp7WVPJ11Ff9mO5sFYgvGO
 GOe2t55r/vSosAUCYOzeTVRVA32H3plGSDjpCJFDToNWESPqBZZeuB2pnWZ5g5bqSmjZ
 Ntxg==
X-Gm-Message-State: AFuF++muWbZxWAmFaAQkjUDUXw4dp5d5e9R6Kl15eMIClLX9lLBzClU4
 g0Hd82zpyiI0FxH7MdiIyDuYAkEgKanIJZGIlOsjQuWF6n/ULfCMTsS03b9/lh5oVXYR44/miY+
 n/w9t
X-Gm-Gg: AR+sD104qHfvpUO201VKXEmBOsF5SdRMWWu1/JRRMvoEbrvJMlU2QXbeRAvPXgAo2Bd
 vSzl1pkN9D0mrIlKdC1mNsjGc8rZzTc2Lqq1L0yWNFOF94EnQNQJm5WaI/8WP5Oa7+RO08CCbPP
 bjzUUpNymxCcIWN6kiuUDcMMFW/Q4Y4bmVE6pbPcY3qEkoxlcGuZDZGIvrLOksCA37pw7BlctlI
 d7S+WFFyyd/jmwB4C507gM1PHg1nqZ+p/y5kWowrJJaF4atJmcxwxhVyDLy4IzoJEIOwnquKNHc
 Vam00ES47SPx4wLVs1hVMumE+76AzEgX2fNgbGYyAhybFsPkwXL1IUPiKfwnPJmEi54ZS+zELSK
 vmBvAGFr3QZaiEWUJo7weF4Ou0QvWGwVk/zTYGwcYonVQjedyVrWG51QtLmY76dyavy3LETY2Bv
 WcwbXcZuJzTHmPGl6CGgk/XkuE4BDKDqT1K5xb7ZA89TYj+vAE8X52GSY4Rd9b3ll57aS/SJS67
 /7NPDd89RpQQAL53dHeclOVVEk=
X-Received: by 2002:a05:6a20:258e:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3cd4bbf65a8mr1766539637.16.1787340537691; 
 Fri, 21 Aug 2026 12:28:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 17/68] net: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:12 -0700
Message-ID: <20260821192646.146382-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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
 lib/net/rte_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index 6703145fc5..83009625c2 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -15,7 +15,7 @@ rte_eth_random_addr(uint8_t *addr)
 	uint64_t rand = rte_rand();
 	uint8_t *p = (uint8_t *)&rand;
 
-	rte_memcpy(addr, p, RTE_ETHER_ADDR_LEN);
+	memcpy(addr, p, RTE_ETHER_ADDR_LEN);
 	addr[0] &= (uint8_t)~RTE_ETHER_GROUP_ADDR;	/* clear multicast bit */
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
-- 
2.53.0

