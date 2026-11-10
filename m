Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0801606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YJCDiLc3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D6540283;
	Tue, 10 Nov 2026 03:18:06 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E5D94027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 03:18:05 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso587057a12.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 18:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794277084;
 x=1794881884; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+5cga4MItAjswVRpeT1LAoI/iPy562xZ1h/qVZWKD4=;
 b=YJCDiLc3cl8o8AGBV72YYMNL8hnXzvfHk+qsM+SijSs/srZNzl9+oS8zb1GLOoltaT
 DnNuOYEv4N/f+fhyPFYdix7SMy1r6x9PlMIuCnOjjgQ3eoEBRQQKMOq8TQr6BUH1d7Nn
 hriDQSBI68CXduH59B1yLOuCC8mSW9uSL1esm+PuJJ2vyjtzjzKe2/w9pBRAf2NBvCY4
 W06H7BYVqHlCtdroojuugHEJHZaeXNFGmknBhBHM1WQqKgAADV75U4x4JStPuOPqQ3Z0
 UGii8sqHyCljQm7u9kLDNKH/Ox0wbVvh+uiTesVmW4VGMRGPUJ5X2hkLmwWsOyyqOba1
 HfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794277084; x=1794881884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+5cga4MItAjswVRpeT1LAoI/iPy562xZ1h/qVZWKD4=;
 b=rWw8c3JUja4Az9sE2KfQTFy5LG9b25BQm0v7uGMYXdcxBqnKG2PUCoDUVxQQ4EJjQB
 MJ8W1rG0tuzyari6aiPJraiKqK98I0kU+Nwt7SAyk4XMCEP7UbghSH0s+YH/DEyESusf
 nK165qzmyLu6IEtm1s4x40n5lRS4zQ/060D6NCdGw2tMwNQm3cpK0AjsEbVTxymfb4Yu
 QKXGRwNLeM/IihLVKZI6ztNuNxU1eQahQBDOFM/lH4oO2pn1xep1iOSR3esGmHT3FTO4
 cvvIMNvXXFvUIj0eOm1wu/FnVIpdvFF+GFv0ylzlr5rPAtt0kLr20POxM4eLpTURp+Nj
 vwyg==
X-Gm-Message-State: APuU4Z8DUsfEbN84+JcymtouRS8SaPeyp/Val0/ECst8relx5vk9vIfF
 hAiesS7G/84mWv1cU4YlC73qK0cwzIKnEMfInxlC/A5T3X6S+63b/tO33pV6maI1W0D6i2FIDsd
 qFVW8cLA=
X-Gm-Gg: AYBFou2MRll0z3gv+HzEZdGMUmafEWC682bfggl2MSu+BafgtUjAdDaE1wNbBYvEXto
 L9Rjolf2JAc+RNfOJbCrlDW1h9E+AR1GdFQB16QK1vuF7slZ38IvOv/HGvUYaeD44+26HnT6jHr
 lWvQlXu6psttUHvZ+bkmYMoJSX20dkKKE/PkU8Ro39J/3TRPLbEGSSBb1s5ZlmETGHM89RXn1+0
 E2QgZ8mN49VIOdO1uCbe0CEc7m/zV5A4KzzBDqpvvFJlAVQjaE7cjZeO0GR6oQCutTdJCR9E312
 DYi8lEktZJkE6u4FDvWq38+7J3uxCFiaqFzMt16cE8EFDhOS++aa1qSNdu1Pg9MJK1ydXpwfv+p
 dzj0vyILKZCIIGGTWWoy456lz6xMHnpaxxqXrIQK8rEu//jWRlf502ZI7uo7991hDnnL6oMWVqQ
 hm2APqxhokcW9wK6T7kuosmbzFlWf7FIKn5lqTviYYZz7k+ApJOWeO2yLjYQMIZjjIPCCtJxMfy
 fNHPYYVHg1dnwQl5HELxNsoLBsZJFU2952ezQ17Ov01Rp1rHK8az1T+EaTR3oULntAwlZGVYlM0
 M0t+pIbVVf+QULR9bV7riNW2KrUd+wES+8pUnmA4bm/IjA7ocNosBYILvAP8gwNxsJb1
X-Received: by 2002:a17:90b:2705:b0:3b1:a1d:3fb6 with SMTP id
 98e67ed59e1d1-3b166d300d5mr1501411a91.51.1794277083628; 
 Mon, 09 Nov 2026 18:18:03 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1676d83absm1758957a91.7.2026.11.09.18.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:18:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH] net/xsc: fix uninitialized return value in QP modify
Date: Mon,  9 Nov 2026 18:18:00 -0800
Message-ID: <20261110021801.766315-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If xsc_vfio_modify_qp_status() is called with num <= 0 the loop
is skipped and an uninitialized value is returned.
All current callers pass num = 1, but gcc 15 at -O1 cannot see
that through the dev_ops indirection and reports:

  xsc_vfio.c:491:16: error: 'ret' may be used uninitialized

Initialize ret to 0.

Bugzilla ID: 2099
Fixes: 31e84e37c0b9 ("net/xsc: support VFIO")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 0a1e507f7d..bae891cfba 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -449,7 +449,7 @@ xsc_vfio_link_get(struct xsc_dev *xdev, struct rte_eth_link *link)
 static int
 xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcode)
 {
-	int i, ret;
+	int i, ret = 0;
 	int in_len, out_len, cmd_len;
 	struct xsc_cmd_modify_qp_mbox_in *in;
 	struct xsc_cmd_modify_qp_mbox_out *out;
-- 
2.53.0

