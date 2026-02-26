Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F9FCE08C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F1C40E15;
	Thu, 26 Feb 2026 15:34:24 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 3AC40406BB
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:14 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4398dd671daso1016261f8f.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116454; x=1772721254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6P6hxlOx8ziVHu5gMzHKdMPxQpfbjtp0QIMM+A8LAGE=;
 b=Z1ck7dP/9mce0rTAXv16XqDYbvKkID2Zu02UWmZ9KGKG++5mlDN9Nled/z+TPY/r6Z
 jVhY5h4I4JVUU9ptjcu6QBiTmwWxCApejlEpvwfZ6sGS29xOIG3Xp6P9sClb2zkg+A9a
 zXyoQW2ZMvr25ZntkFUIDgjCeK2g7QQfAu9puU5F1i8ioIKMWfVPgRhk2JngTexmq9Ui
 aWL1zNN1rM0St6Vfp35cOJaZTpBXvrUUoMqvR+fWIMepaeNsIaQ7Lj44GS1xHwqwJID1
 uzqte2bxW8LrEv1Pequ6Wu5G3on9BEYwBQEQgxQ4x4DNOo4qM3aC9rNekDVBMX7bytKn
 SRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116454; x=1772721254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6P6hxlOx8ziVHu5gMzHKdMPxQpfbjtp0QIMM+A8LAGE=;
 b=F11U5phGWXel2W3fDdzLMrnLt0mqWnVpeC2XUxqKEm2fmf0N6OJxpbUgXONO6dfqze
 BJa+N4LXiwhklMYJi2/3gvw1qLvkLXC8jxuMthzPTteLGeGUxs8Txqta0MHDsc6xtzUk
 2ntMb7ljwNh3KntZNd8ivRacGT7hWOC7KTXImvba+eNIxa5h2m1HEL2d5JUS9Qtjb+LB
 ttlOySBtt09v2l7hIklzaLLpDPklE8cuFwexQ2Qi89ECm18dyJJ+RYnnapFLXd0R9CC+
 TfRax5vYvwviRp2Kmiz05n91zPt7nh5BXke8XEnMtPYv1BTYuCk9bSCmtsmpNelGe/IX
 /Q3Q==
X-Gm-Message-State: AOJu0Yyy0ZB1bqU9FuQSZ0Ke7lrN946vn4aMS0m8QJ5qf5cGHvroT6B3
 4sh6gCa9eT89xPlH0e+tjkRtSHz48Z0blFKSD2vHBOrLWmn6eWXAWiJxrHOXWA==
X-Gm-Gg: ATEYQzzeWTXgR8Bh0HCyrBtFt7e88biOIOC/ZEzd00B7M4clHq6TJMyonNMUD36p73v
 3AqOp/mh9P9u8JpVDlZhuk5rrG2IWOAONrnwm//DRe4/ojLsdOBlCyriAxBJA9pfO77qm7GpmQQ
 uBLu+ryH1+j+8Z9SmMMCsCZJglJUKn4qeln++kzEwul6jXYcuv2lsZORMlKuFLn1gG/LqrvD3Cz
 SzdFouN8KG2OmRw9QoMWQ86fLSSO7ZPBoTsJdzxZO5RhlJpm54u0fT2qfr2L88LdBOxZUqvIb6j
 FiX0BddEvmBU4aUI4ZjBrOS+Xfk4U/HQDJv6rpHZNg+UnuavK7Jc0snGSCbBnX/b3lQ8Bo1toka
 pbAu8EjszmZSFjyQq1yEewvzdVick+2Q1+0OpyfTEeQPVfvCZPfEuvuawV1HV/ZO6QBr33Phpk1
 3J0Az06OJrlz2KMp8lALQNwqYJ3u4Ljlw8XCQZ
X-Received: by 2002:a05:6000:2308:b0:439:90a5:68f with SMTP id
 ffacd0b85a97d-43997f37ce3mr5178018f8f.28.1772116453557; 
 Thu, 26 Feb 2026 06:34:13 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:13 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 13/17] net/dpaa2: add SG table walk upper bound in Rx path
Date: Thu, 26 Feb 2026 15:33:37 +0100
Message-ID: <20260226143341.282188-14-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

If hardware or corrupt DMA data fails to set the FINAL bit in the
scatter-gather table, the while loop in eth_sg_fd_to_mbuf() walks
past the end of the SGT buffer. Add DPAA2_MAX_SGS as an upper bound.

Not tested, found by code review.

Fixes: 774e9ea91971 ("net/dpaa2: add support for multi seg buffers")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 8275ba9780..b316e23e87 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -335,7 +335,7 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 			(void **)&first_seg, 1, 1);
 #endif
 	cur_seg = first_seg;
-	while (!DPAA2_SG_IS_FINAL(sge)) {
+	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
 		sge = &sgt[i++];
 		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(
 				DPAA2_GET_FLE_ADDR(sge));
-- 
2.43.0

