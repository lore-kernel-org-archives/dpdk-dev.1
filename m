Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30893C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D1C40DCA;
	Thu, 20 Aug 2026 07:24:29 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6425040A75
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:27 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so1841250a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203466;
 x=1787808266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIev71qLRRHn/s/7s+HKKz2yRmRFpmM2FbiMXANh0Hg=;
 b=QJcRIt/bsGi/xHouYpMOptuSKKSmD44NSnlypzIduZxVYE9wirAQwXrp+ZJIlOZcY8
 f218qKTYhEmghmIM8QkwsB7qRTzNrku1XoZnnZaEJG5n67N8EA/l4QNYnZD+I7D+2RGR
 X+FC5jWTQTRYa8rdAtBPuMpcKbF0DGh+pEikXY9p8VAC+2VnXCIpue8VCn0pt4DBJpLV
 iDgH9J+NMYLhaCXd9WNJPAEf6fhN9M+ftMN+fpefCideW88KsNt+tPP+55yJInsoTkng
 O1m1pvRhPWBm2IEsQY7MY8Pi01yIdqQWq0v3LWSuYOV9OZkDNjUYuU4wW3IXfAWGABsu
 W1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203466; x=1787808266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIev71qLRRHn/s/7s+HKKz2yRmRFpmM2FbiMXANh0Hg=;
 b=dvz1LpPx/fUGrtO6QvHfZ9C1N21izeiFqzT0IHi19upIqr8Br8xf5z8zm6y0On0Nx7
 aDBiMs6PHs1ujri4WP3w2G1JbwzJ+3rn+EMTRW+K2sEHuAKXigxKp+sSZ/afSzC3hvVK
 06A5O+Zp9H/giA+WakyE0dGaAh6Fa2LQxG37IiNUcaYKbVbfmW2wdKgpwnBksy4qkYMb
 vLWi0N2Ys6ytWuYG+JGvjaT6VqzVML6NWnN6vCBeeSBXYvGMGqRi9xhKK7QMnhU7ppF/
 ChTc9tAfJWe49YDR8+wU5qAuKXiG+s5sW6/RcYiMfrMHIp5FWEbokEgVV8XUVMo3GYYu
 jVlg==
X-Gm-Message-State: AOJu0YwiodRP0LN2FsDuaImLpijzwPAlqAMimAoH/v6ds3MKAq4X7+tE
 WlKrMp0dvnrA/0XRQW7CeWA0uUL14WnQ+xQh+OM1F3qJPyZI+/Vy7jFUtC2KX481M3I5xE0DeGS
 qOPLC
X-Gm-Gg: AR+sD1133HPy6VDmUwszfIl8HTa5OnYjv448Qu7/CnTkNTJF+JMPP7bI01B6wxTzteb
 fsDy0i2KYqvZMYoBhRDlQ1c8TSGaxT/bUnx14VmiWjhfMu/aFevVO4fUUCH+eilzdnp1mE+hpFm
 HbFClc8OzUJ0Ls/AFtsC9JhaTcKHtdmCFPmrpzyuTiXS/dbF6NYH7Z0dBDO+Y2G6ThnLY9QXIqj
 9p0B9tqY9ijiCpo71AXzBFiYisXV+LwDZaQaffPet4xfvixxMX9KqNczYUYJD+3JxOEp6Xh5SNx
 BZCSf6/9D9mXwNRCcTRkljnKry/+pPldhLfC3WjLhJwS1Sb33XyTHR+pP224sWfOZ+GlzlUdnHZ
 MXqyDz3qX2DWro41WK089y3daWLgZZlSG3TJTgfwpdFwl/HmJwd5R2E5FLuKW3h0/cgN90Nxho/
 daxXpHGSGJA/AjcXgkT5QQrvaVGpuAhxuJawq5o7PbHYMJdkaV+ueX70OqjmLFkxM2e5Raxx33z
 shh0aRKLakzJJJwAjrfkfes0kI=
X-Received: by 2002:a05:6a20:7347:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3cd011b5335mr16503252637.11.1787203466510; 
 Wed, 19 Aug 2026 22:24:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 22/61] net/bonding: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:12 -0700
Message-ID: <20260820052251.1453273-23-stephen@networkplumber.org>
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
 drivers/net/bonding/rte_eth_bond_8023ad.c | 4 ++--
 drivers/net/bonding/rte_eth_bond_flow.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..6d970153cf 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1548,10 +1548,10 @@ rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 	info->selected = port->selected;
 
 	info->actor_state = port->actor_state;
-	rte_memcpy(&info->actor, &port->actor, sizeof(port->actor));
+	memcpy(&info->actor, &port->actor, sizeof(port->actor));
 
 	info->partner_state = port->partner_state;
-	rte_memcpy(&info->partner, &port->partner, sizeof(port->partner));
+	memcpy(&info->partner, &port->partner, sizeof(port->partner));
 
 	info->agg_port_id = port->aggregator_port_id;
 	return 0;
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index 5d0be5caf5..bb9d347e2b 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -182,7 +182,7 @@ bond_flow_query_count(struct rte_eth_dev *dev, struct rte_flow *flow,
 	count->hits = 0;
 	count->bytes_set = 0;
 	count->hits_set = 0;
-	rte_memcpy(&member_count, count, sizeof(member_count));
+	memcpy(&member_count, count, sizeof(member_count));
 	for (i = 0; i < internals->member_count; i++) {
 		ret = rte_flow_query(internals->members[i].port_id,
 				     flow->flows[i], action,
-- 
2.53.0

