Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B46C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1B6A40A82;
	Fri, 21 Aug 2026 21:29:25 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4455140DCE
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:25 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so1014123b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340564;
 x=1787945364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6vbcxqOFs1GdQJ09eZ1Pw+ZZLpsn9w1NPX+ZuZsOB0A=;
 b=dKsMabKrmsZRfSMtrcu/mkzk0XdycFTLKM4rBSq5a1oqc/u/7lzS5ed04XO/gPkDif
 F26TbVJThKIztuB82VId6NJTtjoLdgei2hmz379j2xETvjcT0/DggtkH2QLRS+K0PaRS
 LiJLGGybJ1D1q97vClFaQBOcy9j9J7SkL9zADq6sKTvgfOZ0ndexH+bScyAtsVkbhDSR
 n0aJst09n8Q/KegUR6QkYyHwXEYKkdwyetQxex4DefYBsi3hAvAOV4HoGfqdHLrFAm7J
 VdY/Mx3s1SzMR59hqVsuUuGrMWG4j1U0CaL7fr3NM3mDZPpUC84gDhHnH4q9Db81ihca
 QtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340564; x=1787945364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6vbcxqOFs1GdQJ09eZ1Pw+ZZLpsn9w1NPX+ZuZsOB0A=;
 b=gWkap9OwttpxIhOk0C/Gvh1ipDeSj69MI8wp17+1z8OWl070z3XTwIY52FeMF3upXO
 2iWnmTq2omtpYFwShduM8BTVnYkjDH0JPWX15X22AShUUmEwt+RuQ6UldlrD6dy1aiJw
 7U0D6pv90yvR1kU6ssQBJsrqsl4S3dhRMNMcLmaz4xbj+ynyTJHAwYSzDznCQnhKv33O
 iIZx+qN40bHvnmel/INzCkJs7uMk5Do1VB8MeoDSQKcKmY9/hN23XI1KMfbym0hpEPRj
 5lzMPSmOIluTeBhXqHZv4yEWl4QbIJXMOjiInpNFATqd+DCCIEBM6yaZ0rImOI34SBn9
 JfpA==
X-Gm-Message-State: AFuF++lZuPrPq97N+u8eo7kEgQiPCnjSqNshVHXxY9/iNBpf3enFX7fW
 RznpPVOXFxfAOXjMrs2AJzr516/+1UoicKaMk6tQB7Z4nI8Fc5mnawhR3/lVvDC+ei91aBjPBW1
 I97iu
X-Gm-Gg: AR+sD11JCm4ht+jiIqAPNyDRxJL8Y3E1ttgF7PD9eZ4Ppi4FBJQ88is0kBxQJqT2fAa
 2kX6IHigoJaMseovAY7vbbs3wLdrE/8+o4LqY0YAU6IrJqY0VLMhpV1oQrg+taznQob/USRHLEM
 W4tTADc5d20plfANPQLxEtXre9wnNyfFAG9Bng2W8Cm0mA5D6NsQ66UOL6F1GJlOWuT4aOjquTP
 iuOEUhDTcI9RGLE0WCNJYbLZ7AZal4GyV3nqPGugdtZjYbdkITp7HpW03+puyzzqyAmMZN3Ydlk
 EHW40yIOt8DiTDwSyriI8eWzohhL3TNhIbLFWB6TWCNzZHRjMIDKZ9zX178CLaGXHe5v0GM2l7y
 i8aws+C4gpWrSaAkh36696a5WZt5VCXg+ImswuirxhiOfOVim3Wp7vC92DX85CDigGvMjWjk9VX
 h8ldpOCGeBNFdgcuFMMbdJWfgbVY823IGZjpAMJRbCnViUBPaMc0Px5ky8tS+v7yJf7F5YdPd0H
 mX8whc3LG1Q5a+yx+YLiGIuNRg=
X-Received: by 2002:a05:6a20:12d3:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3cd2fdd1cd6mr13554476637.3.1787340564407; 
 Fri, 21 Aug 2026 12:29:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH v2 24/68] net/af_xdp: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:19 -0700
Message-ID: <20260821192646.146382-25-stephen@networkplumber.org>
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 8f976b80d3..4303c780cc 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -2235,7 +2235,7 @@ get_iface_info(const char *if_name,
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr))
 		goto error;
 
-	rte_memcpy(eth_addr, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	memcpy(eth_addr, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
 
 	close(sock);
 	return 0;
-- 
2.53.0

