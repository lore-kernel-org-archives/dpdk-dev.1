Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA0C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EFEA40E11;
	Thu, 20 Aug 2026 07:26:40 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id CD89740EE7
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:38 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so1553818a12.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203598;
 x=1787808398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFG5tooDgrAuydVb29KYy4a2h/GCo+j6QtnljmkKfUs=;
 b=pf5RvE1TvNd7n0ja+ThKz11YC2eHAoVO4RqmlKKPNxUWgU2jRskFjjHmnwAIzH5Oku
 RSgoSpEtOPiafpL3dzj+701CUrWARg/ZL+ZCZhXZ7MQNGqFozb+tdhuEi5Lq9QPxfvvI
 Gjm70QK2wSpsXEfQqTgc5p0SWJAJIklkj4qNhpB6CRCp4QvimBrO6z6+YDbSipJg9/lt
 vlU69LXuYewUdlrNikDiP4WfOZRlszAGcyxk//uUc8Ustlnls9GivviFO5hWzz+vgIIO
 bpRtnUdFBIk4J5osWkZ+cEFSwp5A0C+tx5bINdPU/U35RUfobmJt0iuX44Wxscs4x7sb
 9ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203598; x=1787808398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFG5tooDgrAuydVb29KYy4a2h/GCo+j6QtnljmkKfUs=;
 b=o+bh9gdd+zh8SKXZAo/HuOmrkV48Vj9l84HARwwP0ns6UQlchblBhdVz/W77ylvuJd
 vLv/J5psBscRkK9ihBy/0VmE1pQ6P4zniV6uPA22E5hyfZKHNXExrp+Vb3Iu3ZymPkrg
 elSy3tS+4fVxshoPRFOziWy8HmTahsZNuU5aBpvPTA6CrNnOd4an4B6sZgNeGAoJQaof
 nIYeHp9hGlLIqjrQUPLrVqo2fVtaYcPPf1nZw9BX/QoX4AURQ2brZmATIyyvKhrLN6OT
 WsEmR8r7NwZs+r2TWkLDLxrW3fV2NiBNGAS/OM0L/4xIqVlACCL9bSH2tdWdKa7Ao06z
 fJPw==
X-Gm-Message-State: AFuF++mFoSKzyrDjJnuG0RLu46owZ7zcd2n5kLCkibpdikR5phS2u3ao
 D5D7lNs/tVKnvI06OqYjDpdu/m2szDyxY2Bnv6zpkMkLnYhW8JKfbEmqw72XrdAfx7aS4Bw4pg4
 H/BFy
X-Gm-Gg: AR+sD13xaiOk8hKJopSBO8AGXAGvDMFxjDT9JXHdKnOsUqJvpmvfgbd46ZX5n6fSDfA
 FFLCWzdjlndBQY4mpMJeEFinK0fsYJJf04PBSVY3F4Fm6pLUo9BfvVmlHkKn8ea1Y+GO7fVdLzg
 Q74aUH4OXsoRCdBovyulhlB25bMW29HkmKX0lKBx+MnGzerRDl55oNUf6UXuig+cRTQ1wApGmsz
 +1dTFl+eNbReyHyzINk/z7Ng/C03AauQWLv5pNFhvLliKzmUxm6Ja22AfWjhAi38RTJ+Jy+f9rD
 QbH4iJtJZ6eRHervksUX0UUxEB+hmgi6F3/QfGM+dGC5lsoNwSTK2zJA7ae/Dzf+0iV+zisxuKi
 v6yt1zv43AQZnCpCVfJJg4uiuyWRYC/UczK7fDVsgbcpPe4FCW1kKsmrJrxWKx4Y1Q8jGPQ5a7B
 2EQb4UGPRRmdAKSN+QyHxl2olim69JENgA8+0IgJbhCh9WmwAMG6as48UROCq5rT8bc6b91+nEU
 e741/t0PCoHNB9dL4fCVSojWXo=
X-Received: by 2002:a17:90b:5250:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-395810b57d1mr18825412a91.11.1787203597971; 
 Wed, 19 Aug 2026 22:26:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH 59/61] net/xsc: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:49 -0700
Message-ID: <20260820052251.1453273-60-stephen@networkplumber.org>
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

The use of rte_memcpy() when building the RSS hash key mailbox
command is control path only. Regular memcpy() has no performance
disadvantage there and gets more compile time checking of the
arguments.

The remaining uses of rte_memcpy() in xsc_tx_elts_store() are left
alone since that is on the transmit fast path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f489516..baec15d153 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -159,7 +159,7 @@ xsc_dev_rss_key_modify(struct xsc_dev *xdev, uint8_t *rss_key, uint8_t rss_key_l
 	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_MODIFY_NIC_HCA);
 
 	key_len = RTE_MIN(rss_key_len, XSC_RSS_HASH_KEY_LEN);
-	rte_memcpy(in.rss.hash_key, rss_key, key_len);
+	memcpy(in.rss.hash_key, rss_key, key_len);
 	rss_caps_mask |= RTE_BIT32(XSC_RSS_HASH_KEY_UPDATE);
 
 	in.rss.caps_mask = rss_caps_mask;
-- 
2.53.0

