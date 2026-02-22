Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D4FC636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EBA4066D;
	Sun, 22 Feb 2026 18:32:44 +0100 (CET)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id EB02E402EF
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:36 +0100 (CET)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-463ba60966aso1040922b6e.1
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781556;
 x=1772386356; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAerORJkQDysDtQhhNKPVAsKM8rNwtqY8JT7cq4wSIo=;
 b=Y/te4vp+328/IX+e3A7f4GjqLsRLg1IdXcRgZlmPMUdcNh8pKqQgDkb/qoCO7XuhHf
 uUbe98TISPDuvuf1nOKsxpAdoaOlDP8euh1q/4Lqhsi6m6tnLr2gzdGB3nZ1oYJcw3Qg
 0YPvxYU3h43pS20n0xnDHjiN0Md0lRpNHrCBA15W0ECNfIqJCnlanp6T5sivI/XB05vB
 pyoJKuYcerRsJSgL5qzwn+MJKAbKXACbRZdsjNKCPcS2UxXaWgWnwvht0MEEIkxu2XH/
 TI9uYUIj4tPhYFXAaM/5caLUrx+RyHIhcHeiQD91GLmQ6Plc574xQBCEXMDkyuXwUXM+
 yALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781556; x=1772386356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAerORJkQDysDtQhhNKPVAsKM8rNwtqY8JT7cq4wSIo=;
 b=nIfspJ0RhqG0RxkME5KM+cpj7GviJLZ6ROJTnhBzjsE5yzW8mC8WdEJCuBdEnAs4Qi
 OCEiZV53ywwRIF87fqYqBpU8gAnhX508FAG5usF+mrresfYR5npWZP3B2eVMRoVYMv91
 XFceedAGQm8fi5EZTWvRf+wxQ0PvPyiye5baRP4Duz+YgmafZ64dI53LK4R2PEeMaTpa
 BHHTKC5YFQeVt3uThm8tIE1X5Mw30zgL8N2zXfvbJkMnpy38N3bTLrmx0tIxRoDlHdpm
 roxOklN04ZUEGUHx0eIdRsqqk3uLA6J0NfstPYfeGtA37UgcpJivLMiSGNhe8GWOqGRi
 1mrA==
X-Gm-Message-State: AOJu0Yz1QS9PO8GNEWD/chFzoLPFpkRl5ZURBRnIve+ZT2oNCi+or/fI
 Q0gcm+RSvzu89NDAYeux3zW8X1NfFhEksXq4BFimOgO+OwZdGJG71i7M2URsquAcwcADMYJBqgv
 0Jht9
X-Gm-Gg: AZuq6aLYcUIGznuio1OnNWKoo7fAxeEbUI5jB5hIcyAeXuAOTUly14Y1Mn6mtlZ2988
 VpPLmb0ltXLOsY//tz7YDSSPB65J8i7lLgFxg1K+2T8DLiNmrvCg0rAlbfTOGjxhulr3WpDv0YV
 MRvhRyb8lQ6lcbv74ZwlkY6F4KwkhEM0tdlaEUsjyKloTbkS6I0FWYi+K61mVXH9QJXre4q1Tzx
 zP+7kJUQq66bx4pvAwS7FDRpzg3qjnq2X1H7idtrQeX2vRq7O1nImAofOynsrzgN67XK6q3y1QB
 AuXl7I7UVcY5KzEk+EqzYTbQDIyZw4vtA+Z1tXFS3B4G5D8pvndagCPiFWJbgxInljQEhM9FWw4
 kfg8Ei7/HTLp6ibyZ0SZFLa0BC3ymIYw7AX4dZzS/9VXCyPFXgDvUq9BSIth+c2CcUI09vQRLFL
 6A/B9B5xEqlnPoJ1BEO4b912u/gEpVIURfVx+UMC4KVzG3guscbO57ILmFA9NNFA==
X-Received: by 2002:a05:6808:c2bc:b0:45a:78b:65e1 with SMTP id
 5614622812f47-4644635f19amr3360760b6e.48.1771781556260; 
 Sun, 22 Feb 2026 09:32:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 07/19] net/tap: skip checksum on truncated L4 headers
Date: Sun, 22 Feb 2026 09:30:42 -0800
Message-ID: <20260222173225.522754-8-stephen@networkplumber.org>
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

Add a bounds check before accessing the UDP or TCP header in
tap_verify_csum(). A single-segment packet whose L4 header extends
past rte_pktmbuf_data_len() would cause an out-of-bounds read.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 47dad54465..c810b0df72 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -365,8 +365,15 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 		 */
 		return;
 	}
+
 	if (l4 == RTE_PTYPE_L4_UDP || l4 == RTE_PTYPE_L4_TCP) {
 		int cksum_ok;
+		const unsigned int l4_min_len = (l4 == RTE_PTYPE_L4_UDP)
+			? sizeof(struct rte_udp_hdr) : sizeof(struct rte_tcp_hdr);
+
+		/* Don't verify checksum if L4 header is truncated */
+		if (l2_len + l3_len + l4_min_len > rte_pktmbuf_data_len(mbuf))
+			return;
 
 		l4_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l2_len + l3_len);
 		/* Don't verify checksum for multi-segment packets. */
-- 
2.51.0

