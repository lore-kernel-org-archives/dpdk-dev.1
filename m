Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C43EEE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B993C4065C;
	Tue, 30 Dec 2025 19:58:57 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 2104B4065D
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:56 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b7ce5d6627dso1816737266b.2
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121136;
 x=1767725936; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plmdpy0emRLZdrEswddEpVbrhic5LogNoy1YBwG4qnw=;
 b=dYs7Kt2ECOZrOiioV68nVz6jVxEavYd5nNpHuQd6kmiWDfgQHXCvLcmJKBS3QosHOH
 XLbwPEjl7JNlA7IUo+lqQuMbQrjhA658+er9MfYNV0R6ziuYnWb4a64wKCkoSy1S0yzY
 fc5lXGmtLPGOFYt9jWqFQlzKVZUpf4ZWVvHLqdwBw6QPR4OxbKNZ1eXjSoiVw3wP681l
 lcGfsHkwab+gFwIijL5wrAVBQ7Xaojxsq16tHM4mTrorkWGpfr1ijlalAMHINHmA7Yf4
 rmEq434iqUoM9d9KtAhu3REqeSedCixoUGXb+uQlmYYRIgUZCGkfD68YzVR7QW+Ksmgq
 vzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121136; x=1767725936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plmdpy0emRLZdrEswddEpVbrhic5LogNoy1YBwG4qnw=;
 b=r4bJTSDQ8KpyxB+AO4/r5ozWFMA2aZ1WUjpy68o696lF/NUVEb0LWRmrG4+rIiVbRC
 3AJVLrimPejFOnUhPABtFJFq8Z6xzZynjL1IZ51Py0GoAsLNeZSsXex5RUQ/pStFTCFN
 aVVaHXI4eIb0ADmswyg75rpNYanUJNtFcMEEu2MhtD0iSiPbV1sDYxcXjKatNuakHucH
 Svpb2XIuW0fQXfUPw8kMLF6GRz0q9sEbWD8XSVfFqRrRirrXW+lp6lvYDNepJW9Q/sJZ
 Gw+s2PylmRiTGcC5DBkHeGRijTf55CgossMtuGqGg5Hc0VX5lBkXvzlJs0+KbKMbR0ub
 rAQQ==
X-Gm-Message-State: AOJu0YyVDHJYKV4l3+1ShTlPOOGnOxgYVU7gSk0awKbULv43fw1Cz4P/
 6Knw4T5Ngono8Ibvel18xPaPh6QWVGkjIMUQuN5nEt1Y0ZAPOBXJmkyHsS5F2X8LMnjSLjU8YSg
 T3MhfUZI=
X-Gm-Gg: AY/fxX7WGDVG3CZQbjiMnv9tigohilmNVB0OMUY+vOcjNhdccxS5FqfvlPqZIRgpIx0
 vmvJ/AomyiztZhGS/vxC1mgGkMu3XyuMU+tPaNz5p8FdqmEuwZ9PRq+JGbvVShZS4Blv/igGvql
 uiYzrm7EijDdrBMQkhrtT4IEb11a3tEthHOkTCCEONTdMeT4pW2KF13Wt9TEOlGmDP3RySBcRv+
 dRWqiwZo1/1UryI0Jnw51ejDAjC+59NHLbWGVLHgL2uE1JAlNWNFBfDgrGhcCl7iDc7ru6jt+HD
 4l4JAP14qkcoxP4NxPCmARnjQOvmk7W3PX4P3Wrccf8ZFrqV3nzryGFV9igGQPKS2EUHSZPORFm
 PjqZopjyfF/Iad7PC82WyzusVzzExz8vvK8PSWG6T32xpUSOyYOWXaHOCWe9KbSD9Rra+aBq6Ev
 izc5KiuEh2YRRgoOwRHvjrGlN2FJEwwrO98leXSQ7dwz6MFDE15hAwYwl8LP+H
X-Google-Smtp-Source: AGHT+IEJFUviTDI0Hmck83IoINbN2oHNS00o+i16Iup9BZHsu0KlXVH9KmOob8AM8jJAIinm5IP21g==
X-Received: by 2002:a17:907:7e82:b0:b79:ff94:50ff with SMTP id
 a640c23a62f3a-b8037178545mr3592175366b.34.1767121135654; 
 Tue, 30 Dec 2025 10:58:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 vattunuru@marvell.com, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 6/7] common/cnxk: fix array out of bounds
Date: Tue, 30 Dec 2025 10:55:14 -0800
Message-ID: <20251230185837.301163-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Gcc-16 detects out of bounds reference in this code.
In function ‘nix_inl_selftest_work_cb’,
    inlined from ‘inl_outb_soft_exp_poll’ at ../drivers/common/cnxk/roc_nix_inl_dev.c:1173:4,
    inlined from ‘nix_inl_outb_poll_thread’ at ../drivers/common/cnxk/roc_nix_inl_dev.c:1201:6:
../drivers/common/cnxk/roc_nix_inl_dev.c:43:19: warning: array subscript 1 is outside array bounds of ‘uint64_t[1]’ {aka ‘long unsigned int[1]’} [-Warray-bounds=]
   43 |         uintptr_t work = gw[1];
      |                   ^~~~
../drivers/common/cnxk/roc_nix_inl_dev.c: In function ‘nix_inl_outb_poll_thread’:
../drivers/common/cnxk/roc_nix_inl_dev.c:1172:34: note: at offset 8 into object ‘tmp’ of size 8
 1172 |                         uint64_t tmp = ~(uint32_t)0x0;
      |                                  ^~~

Fixes: bea5d990a93b ("net/cnxk: support outbound soft expiry notification")
Cc: stable@dpdk.org
Cc: vattunuru@marvell.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 1eb96f913a..3a4f1ac1e7 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1169,12 +1169,10 @@ inl_outb_soft_exp_poll(struct nix_inl_dev *inl_dev, uint32_t ring_idx)
 						     (entry.s.data0 << 7));
 
 		if (sa != NULL) {
-			uint64_t tmp = ~(uint32_t)0x0;
-			inl_dev->work_cb(&tmp, sa, NIX_INL_SOFT_EXPIRY_THRD, NULL, port_id);
-			__atomic_store_n(ring_base + tail_l + 1, 0ULL,
-					 __ATOMIC_RELAXED);
-			__atomic_fetch_add((uint32_t *)ring_base, 1,
-					   __ATOMIC_ACQ_REL);
+			uint64_t tmp[2];
+			inl_dev->work_cb(tmp, sa, NIX_INL_SOFT_EXPIRY_THRD, NULL, port_id);
+			__atomic_store_n(ring_base + tail_l + 1, 0ULL, __ATOMIC_RELAXED);
+			__atomic_fetch_add((uint32_t *)ring_base, 1, __ATOMIC_ACQ_REL);
 		} else
 			plt_err("Invalid SA");
 
-- 
2.51.0

