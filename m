Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89425E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB04F40649;
	Sun, 15 Feb 2026 20:54:00 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 5772940608
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:53:59 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-4837907f535so13324695e9.3
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185239;
 x=1771790039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZLrehQaabWATWrJmzBRwxPWDH8rfzOieZ8HA2cyQR8=;
 b=trBXojDkpAwb1bWEHG+S2T7vE7fbGhn7fE5R32aXf+UbwGH+xRN6xb9Ooy57ggvC8R
 0BXHO5Hxcf52sNB2heaR0SA/hJfsy1wazWLjauvzfSMLJ5AHjkLHV9O69wq/ygJGMzvl
 w4oPEXMP8/KLbG4SdRSXK8yPV0nBmUhiSUwNu2iFjcI3Flkv5qovdlcY4W52GNZjQAM5
 bsEWUVNghuuAyN1wKHfyLiIYF4rXlplyvMJE3vp79ZOucfYWWeNzFITK40aR3VFAPrrp
 vc5GbWI2zAJ29CiFeF1LvMBt5OsZpyDSdekpFvK0NM+UBPtS+huVUTHEPwJQaDNKMDqA
 k4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185239; x=1771790039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZLrehQaabWATWrJmzBRwxPWDH8rfzOieZ8HA2cyQR8=;
 b=ouPxAvGhzL4egkgv9qb0MVuyBDTp1Ra4kG1YIu8zmwzXXTpi1ZD+XkdN25XhOB4H9G
 hKH1HzdLqFbXfxlE4e6QWJJVQEaq5+1aGtpOuDzBwWqs955zAAr45aGn3inm7cJcFgfx
 Sk2IH5IpQbs45ZkIwVH7APnIYmFQvtvJDpxaPZPqckNgzUzV0/V1EsTW6ZJmYjbVP3Gn
 Oy1J36tZmZ2zAxazwApZaU/lthXKdQlDEAKvwupsAxdjE2sLdKFeAVPdDpqE00psXNeJ
 BDq+BR9g6JHpPOUKWN8lL+cs+uI0hYry4U5UtHMIJZqO8j/JahHPwHZ78dlU6w1+Lf8D
 +jhg==
X-Gm-Message-State: AOJu0Yxn1z98ZKQoStcB97cE4Jzx3wuPHVT6Ay0j43NCqk39Tk3hmSyk
 IDPJQ1VBGAkcgjA4XyU2OqVBsaZhEExU3XUD4rffN9WCWiITDtqONduuSIAtC1DyViR34Kmoiq0
 XO5fTeuGZ4w==
X-Gm-Gg: AZuq6aKHeQVLUMG6hYmqkjOLSRpEE9fHsdK4uAoqYfJaFY4eYSslNYKVVkdAxMtVw3f
 qSyXw/kg1iE/8d8zkhJ+AgWh9Hfk+lSMZFhsm/ariEL9b5hD0OnJQnZ4Spt0A5GH+s5/rLyPVdw
 5dISu1B9ZA9NjRF2/bRYrRo4WliftTPt4PeGfeNzdB6iE5o+aw3K4Dt0iovCbZaEPh5GLeMygDD
 sz8RtI97F2AVOyxD28YNLC5/NLliH5sdvkFmQH+jwkIdhAkIXqq9SPnD1dz9VJU/IynUdrvF23X
 uisZ7IC7LP0MPgswg0jRl7lrQr5d13m75Zk2BGvC+EPNSzy4kpIprbtd1Ms2tmyhcOvrxqrJDzb
 Y9O6ihAE9aArBrT+AbTimxrQP0Ewpso35/Cr4mc9wIIgcm7W9rFNm/Zf3UAwS3P8vV59jiZcX//
 rBvIX7jH8aXvgABSIBjBljZW77dZzqHZCrFtHCDQDjd7s+KikvAJnYzkVcKusbcQ==
X-Received: by 2002:a05:600c:4ed1:b0:483:71f7:2796 with SMTP id
 5b1f17b1804b1-48379b9898cmr112915525e9.10.1771185238560; 
 Sun, 15 Feb 2026 11:53:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:53:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Date: Sun, 15 Feb 2026 11:52:21 -0800
Message-ID: <20260215195348.557945-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Replace a ternary expression that relied on operator precedence
between '?:' and '|' with an explicit if/else. No functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index aa236cf967..31c8c185e9 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -154,8 +154,11 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * Do not set IFF_NO_PI as packet information header will be needed
 	 * to check if a received packet has been truncated.
 	 */
-	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
-		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;
+	if (pmd->type == ETH_TUNTAP_TYPE_TAP)
+		ifr.ifr_flags = IFF_TAP;
+	else
+		ifr.ifr_flags = IFF_TUN | IFF_POINTOPOINT;
+
 	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
-- 
2.51.0

