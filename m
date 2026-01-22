Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835AEC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 069044278F;
	Thu, 22 Jan 2026 01:54:36 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 5A78D42D2B
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:34 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so4411085e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043274;
 x=1769648074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWobI9ftNgr1zEzTN06TVY9GUuBpvF7DEVE0FZUndfc=;
 b=GqZ7uXldvTc8YVfN+SJE4Qho4pMc+sUOyfzSXX+/IyYkR3UkjjjgydsVNsA0/FZHRo
 02MDvgIF3n4U0CeHfjTWUMG5Ta9JrlG5e263jvxJx5DIGXU7cjLWnP/bLZdgH8H5wB9i
 xQzNaCgPQZeMGXS2hnTasxOq0UV+VFX0W19hotLplIzGrxXl70wgTDpGVs4EbVcydOGF
 PFb3S2nLWgr+vMaed/2+qUfbvZnTLbOHy6wWJMfId/u8JDM7o67RHh1qjS9xGvALaMna
 snkL5/Tr2t/wzUYduhN9RD6uItW+3dBpP6Lnkrbnb8HpUf0+jwAcZc60vy84QQ6hZAEI
 QGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043274; x=1769648074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWobI9ftNgr1zEzTN06TVY9GUuBpvF7DEVE0FZUndfc=;
 b=m+fLGRl1+Wg8rD7PP+hl6XkY+0ydN4J9WZM0bGsB0Di4Gbp1syq7RFgqVXAyNHPyA5
 aN6AnB8pamhBSRulv8AgeCRCzV1U2wocTCLZQbPmniTIDHKkpjs2GPN5hEqKrdHr79mf
 qWRh8H68CBJL2NH99oa4BjrxhGKn27QlbcSM5AGkOL4t4b2tDZeBBc3odqqbh64lzFIq
 FhhduGmg16euGdiU6mvNRkBCkayWqogBjccadTh2L+iZuojRCOMFnEhCjlhvNUQTigvC
 lbsHpEzO4akWEHqsufasjlfsOOvcCtd27D9XRn92iSmdtzBRqVxk7T3doBrf7EwdyYkE
 3HCw==
X-Gm-Message-State: AOJu0YyPM9HdL80A3A+/IdAtU061u8uZyPZEY9V5OeDcIF3llvgrMmyZ
 bkYVQsW5bIkmfdC5qEdkl1vYfB2mUATA8Egr6aXEXgwOqDayRHaq61FuWxoybTGfYmNokIqCKw0
 Y0jAcqp4=
X-Gm-Gg: AZuq6aK8Lop4wW/fKunvSG43WMBbkrDtcuOJH5OAs/+DMbjY9TcH+VtIpxHU56fSvI7
 Xc9TzIdB1GgklGkttWRVMFinuwP5LTZ4c5+TLjoXl4a4WidcHDUrtaxk8kyws6t6N/xETb+HOMC
 AB9NxItwdSC3ja471n2XG4yc8bffJYeS3UdTfiKzQ4fnL6aSMkH16PUiMwUMkx5SytJ6ZItKTwc
 oFhENLjAmj7UcaJTbc+IMm+M/ZsP1RjQBVdSbyTYIAKyb5lQ3fhuzjtyfP68I+BMoq9R9L9aE5D
 dowAibK1cCLrkk30Zw7nm1VHOD8vOrOgfdyg+hPpcD5TlFzDumdI+HfkADKvdnhYemSHzDQCyd1
 385mhIebgSloQ4KlHlZi2Bg23Q1AOHDFkavxPpqZSQ/keqPj+a1Qc31sPBAzzFf6CYir5X7jc3p
 YceQDAajWQRZZywL6FoMmUaUUrKMLNy18tsFYLP7Cq3zaw4zdpoQ==
X-Received: by 2002:a05:6000:22ca:b0:430:fd84:315a with SMTP id
 ffacd0b85a97d-4358ff26c83mr12367255f8f.39.1769043273819; 
 Wed, 21 Jan 2026 16:54:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 14/14] test/bpf: pass correct size for Rx/Tx load tests
Date: Wed, 21 Jan 2026 16:50:30 -0800
Message-ID: <20260122005356.1168221-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

Use the correct size in bpf_prm to help with validation.

Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
Cc: stable@dpdk.org

Suggested-by: Marat Khalili <marat.khalili@huawei.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 8bf783c00c..bf92bc545c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3533,7 +3533,7 @@ static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 	const struct rte_bpf_prm prm = {
 		.prog_arg = {
 			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
+			.size = sizeof(struct dummy_net),
 		},
 	};
 	int ret;
@@ -3632,7 +3632,7 @@ static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 	const struct rte_bpf_prm prm = {
 		.prog_arg = {
 			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
+			.size = sizeof(struct dummy_net),
 		},
 	};
 	int ret;
-- 
2.51.0

