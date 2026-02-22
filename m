Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F2C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D5740666;
	Sun, 22 Feb 2026 18:32:40 +0100 (CET)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by mails.dpdk.org (Postfix) with ESMTP id CE621402E7
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:34 +0100 (CET)
Received: by mail-oi1-f196.google.com with SMTP id
 5614622812f47-45f015a3259so1132122b6e.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781554;
 x=1772386354; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Dh1J9qhXtp97x33Et1RA32wwbQBNBh3rdk2usI6Lvs=;
 b=cZq8w+nMulUq7F7WCuxvdJtnoTjM/DLf3OK/Hqp28Rkb1SV9Wxp31hqpoNyY+srG6p
 sl5DsztKFap2zpTPiCjzxfdEOXFdilywe+L7bqNvNAJ2y2GbAyuUa1PnQK6hMC8aRUyy
 +LR38Jzvrc3+GbSnnSqO8t2sIixdLTC2qrcENshqC+i3JYQquQMOlg/4BkK2w5BrJfCV
 Xlo0CaWSVp4EJEhF7w92cMZhIY4HYE9D2eppcknm5qMR4HEt1NlNS9GZy6HQXum+gNoT
 5CpN4z6tg+tOEhhjcdzf2SBhUOo0sOyf54JCE5sLCFPvJ7D/iqnLOP9Y4l/GZ9eQ3jQ5
 T5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781554; x=1772386354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Dh1J9qhXtp97x33Et1RA32wwbQBNBh3rdk2usI6Lvs=;
 b=CgEQmk4PdgW8rucQCyRLQN+qMqTODVbgUYjgOdOCHF99JlrJXNXzlDrGxB2unD2U+L
 o81/gienD1W3nSIWCzNxOTByuREN3gvorpZBWiU4G2+Utz7B3EdSaZbJGi4Zx3VrdIFU
 duZ/M7TtY3l6i/NSmlowqluFP5uYBv3CgOWzArHGNP8/CRJCZGy7MpAbG43HeJUGFYNL
 zvnkpSmyreM7wzOJwfpGECTn8fRKSlFd6VhkcmQXolnW91Eh5KgGafSapi1AdjG+suLM
 aLQ7zm5Cm/FiMLdhxIP3ZvVByXQT+Uub0sdFGRI9TBIbVjJ3T+c3Ynn1Y4grKHVe3NCQ
 iCsw==
X-Gm-Message-State: AOJu0YyXl4sKEG4zQkMdeypIgHLbw56F3pgmuhVuY9/Jn0KQqqf5Pkin
 PPBb6MNN1H3/TSO4hM8g9whm61wm1ruNp6vVwr8j7j6G7dNK5g4fneDwsL+2GauPX8X+PwPqFD0
 uxxYWlag=
X-Gm-Gg: AZuq6aKQqS5BoZH0cJmcD4hlYWDaE35vUNOk2b2Ygsdnv69xYl5q7A4LeO8/te6Al+9
 OzNw8VXCOALH2Ro9eae7hEdG0CV0Ivphl1iDKSOjJXYBUklrTTG6mzEAYqCYHtcdDqEc0WRxzc0
 NxMQlmM67yTMKqTPfrLwTajfHhgTNDGSAF557GdJkXR28KgvJhfhRxC11YtPrR+KI1GavPcDBhd
 4ewEQg/TTzSQqzpSFyHilWz1o77OE4u3Xly4J8eUWeWfESy4O9JfBAti7QuSq7GQpL7GShCk86f
 UDzonWV6/5ri6oSnQhTb6k1AKGYggmRHdIn46NJ3ysMZr63UeYarZjW0NK8qvuFnAEVFR+LLB+h
 iYa7PuS7b3X/oLcdIlljIvr4G1Fx+eDDC53r+ubEsALgYWnKqsbRLn+U7DidMxEKxOkcgh1nNj6
 hObzKldyuLwI9JKAbK0hQt6nvHB80Jb/8pMa0f9+N7O+JSyBMn+8NBhr/5YBntPw==
X-Received: by 2002:a05:6808:1186:b0:450:bb4e:8395 with SMTP id
 5614622812f47-46446377c97mr2826567b6e.53.1771781554134; 
 Sun, 22 Feb 2026 09:32:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 05/19] net/tap: clarify TUN/TAP flag assignment
Date: Sun, 22 Feb 2026 09:30:40 -0800
Message-ID: <20260222173225.522754-6-stephen@networkplumber.org>
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

Add parentheses in the ternary expression that relied on operator
precedence between '?:' and '|'. No functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 9dac0eced9..291c3b5a9d 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -155,7 +155,8 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * to check if a received packet has been truncated.
 	 */
 	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
-		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;
+		IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);
+
 	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
-- 
2.51.0

