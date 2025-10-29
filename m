Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B184CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026ED406BA;
	Wed, 29 Oct 2025 17:08:55 +0100 (CET)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id 355F440695
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:52 +0100 (CET)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-78af743c232so83317b3a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754131; x=1762358931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CxB7wWO80ywp52HefvVp8FWJFunxq6ZTbeR8TZkk02E=;
 b=Bbdpy32WCLFLZM6PYbb/Jgzly+J/VNHDk2Xd+BgA79Khv7CgGHKbdcIPubvezn5vor
 5W/6/GBC7ejI/DMm/Pm5K7LYZALn7BWOnauZxEfU4NgnlxwAx9Zc8Y+0FQ9DBpjtcXSp
 TGAkseysiUK6qgaZwuPBkP+2ZmxNUEC+8k5PDUBN24bKtETgzKPB7dvWaB9XDy+cxRSL
 qyvrEIaTPueFD1RmP0rpXl05yn2LP+lZw1eU24ABbPOZaAyCCvXA6yRz8kKOX1AptwM+
 sAh3Y7R4CFfkUtZoRGNKAfkpSc0O5SDvezIuL9bSJRSlwSSKflfQg8km657cNVpYo1g3
 ZqnQ==
X-Gm-Message-State: AOJu0YxZh+ivFbYJQTJw6xtYgU7rsfgEyEc63Dp8tMfIxSXTsDKtm0Qj
 C/yKmtyJabocQRDppKGBmirJH9MK9hZAIGsx1jSg7MZEnHN6JSCP0CotugDCFzG+8pyaD+Lh3Cf
 EUmhZhAx+xFmq0axUU3zHI14qH4BPdearUeFffN926tn7adc+43XffBFs+AlhLL3/JdBe5nhe5F
 IUmGeBwHmCxYfFfMa5Sy3aOfM06kLuHnjFh7XlaVuomAN1g15P6FdShAzpVV3bNgMVM5VwNw==
X-Gm-Gg: ASbGncvW799tK9f3MYvIXSjlpYjiFRCBAnreEitC+orcQEI2UsvTt0Lk+yLCjKjGJLo
 a++sNISZZ/aBuhjhTvTwCQyVKdWmKrJ5YEzYkX61asKcTqiwJ1jNSdAxgt55GJoydMA5bLEkl57
 jxEYoMGZeyCCYuOqSEKZWhLcWLwFEwnxrGhxkUcwT32EvFhiRzs8I87/FDTQS4ZQUzHaKoqIzhp
 sh0boJ3kVMNot80JaghZsJxX6qMjjPRPeXh74a5PHpLwJDbMOU/l50md38IfJH8y/lnDoezJBNo
 tK6LVM0OodVcIxl3CBCmQj8YskHJyeC1VbkCOETzasqmOjnQQvliA0EOBSf94elBLPTVjcv4/wD
 O9Fwci1K7j1Z+fP/lS08hTWfs75kx4sMX1/oyshyl6uH0o2pFvSivQQio1b0UKE2IcWars5gykC
 RaJvyhQLwAAvVrQZe3N8UMX7VcTjCD2dg8efWf
X-Google-Smtp-Source: AGHT+IE75KwtouUzGrgb+/nNDPSq2Gc/xNCNDiixyb1xsgpVYf+pWwhNrRwnezHSgEV7FNR+flH3foYe7ns0
X-Received: by 2002:a05:6a20:9149:b0:342:fa4f:5843 with SMTP id
 adf61e73a8af0-346553f7217mr4481613637.43.1761754131270; 
 Wed, 29 Oct 2025 09:08:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a4140c47a0sm992125b3a.11.2025.10.29.09.08.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a3f828c9bdso952524785a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754129; x=1762358929; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxB7wWO80ywp52HefvVp8FWJFunxq6ZTbeR8TZkk02E=;
 b=RN4QWQ/RZNygZfUeJ0L4stfBN6OYgV3QvkiihcqqonGXpEPehrWlWlGTs8KJPCB8eL
 FQ9HctnPwGYQTmtuCZmJrACEffVSC7EdYLmlk5pyL3oNCMjBZnA5eqQEsVc+MV9ozZcX
 UZ2KUQZj3IGDqQwse1FR33aogpsfbDcMSh/AE=
X-Received: by 2002:a05:620a:29ca:b0:8a3:d644:6937 with SMTP id
 af79cd13be357-8a8ed1648c4mr415174085a.6.1761754129268; 
 Wed, 29 Oct 2025 09:08:49 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:8a3:d644:6937 with SMTP id
 af79cd13be357-8a8ed1648c4mr415167285a.6.1761754128629; 
 Wed, 29 Oct 2025 09:08:48 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v5 16/57] net/bnxt/tf_ulp: increase shared pool size to 32
Date: Wed, 29 Oct 2025 12:06:31 -0400
Message-Id: <20251029160712.58519-17-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Increased the shared pool size for table scopes from 8 to 32.
So that 32 instances of application can be created.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index e7778f8b1f..e4c9bfcff6 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -373,7 +373,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
 			shared = true;
-			max_pools = 8;
+			max_pools = 32;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

