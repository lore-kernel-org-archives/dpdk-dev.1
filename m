Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472FE784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9602F40654;
	Sun, 28 Dec 2025 19:46:02 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 7796A40654
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:52 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso46869885e9.0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947552;
 x=1767552352; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZfzALe6PKCrK7rCoXCS7mqZVNQcc5ogYC+0nF/rwYM=;
 b=x4wEXo8a93JGTH7eUlfz7ZfKKEDdWEHwI8nttT6kqFD+9wRSvo2SruJfq+au2NcJGG
 vyF/G0PYoB/gnM2tHxA4TMdpaxiPXEw9oWw+D/3zndFrrcwMFylUxxOmPXLenKiFRRIA
 3LbVcNd6HYaWg9wfwcIWNNzcGS9wISY3WcbTbMVLASS5dUP5QkKlk6MXeh9Ix/pIapGq
 p9vSVN6Om5NhPtYC6yLIzFJD7FW2qiozS4nBxQbfoNftXQiZoKBiqr9lmL8tAq+GEg01
 h0/z7Br8SbWUdHj5mV3WOwJ+4Xc511ySZVuJI33FAnioaKyNRmBJ2B/StZ26C2VH2/SV
 Tq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947552; x=1767552352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AZfzALe6PKCrK7rCoXCS7mqZVNQcc5ogYC+0nF/rwYM=;
 b=LIze0yhou0dOZYqHQQ7gCeVKkjE7AYahdCdIzepgr5/lE3Z/RLX7CVyECBtaSdIXJ8
 XTalbQhJvOFIWFE8ZBxNGBnxJ8uh31kohM4gHZfaqkbYHN0CPaYHTapbg2ehjN0aLjCM
 FEyfWxgladwrTeDzmD3Esi9iS5M9gd2YbyHfSD/OoTi68gwU8obJRQWi71YLJl2lPvjU
 SJAZjxDUkSBXiC3pUqNbUEHdPamXPxPRQ4V9FH0QNkayRAicVg2XWJsok0K3Gd8lOofS
 zfDL4gkqlPfB1knFgiDQuUPV8Kqou6g1PTjttuRJO1aldkGALvY7930fYew2y6u3gDgw
 qo1A==
X-Gm-Message-State: AOJu0Yw06nF3yNwwZkbdgC1+gAtXhb36VzFtYMbZLC7OvIqK6jVUAwRe
 p5TwSxRouQO//ZL9dJUtZZiMWQy2W5yf6ApYawOsLRZIphDbpwNpxPv7y/rgBftmQJKb0Muy8dG
 KDgHKE/Q=
X-Gm-Gg: AY/fxX48NztZeTDHNN6bo9dyipRsrDp5OoDL62FLhBsEbnkV+n3AgTCwmdqll5Lj+TI
 i0fbZoYszO6cW6QnV7BEcCzWpfX+zdh1Nq1J8bLA1JjrkJSgK+VWhShpXq/8HB4+YZM4/97gkwl
 slu6ddMQs5kzVA17jz92OgpfCM6XUVnvVv6khLPEIfji8fAvQ8HtgQ8DJj5LbOY4iLdGv7bWvPW
 FgrBd3QTbrRe7uZmPUJWsx4NzR2+PHp7emqQR6rqOm5jkkrpPd5nj3LFcK6Rz7Vs8njUSTuPTm9
 T0OmlSYXOob47aF3keUGERJmfE4Scd9s66ckMvmDtbtFxGgOPjAEgHenSGv/RELYDdbzUTBvUfS
 o9ttHSBf1n1OlaeJrb3VTjIuX4QrxUs5G6C7xnFzyQUAC0S519YtAD6QfWaggLM1+fGWa6KAidV
 Ks0e9MUwatOyq2wjByCEC1f/0NQYbrfVgLx0JjhDO4SWf4ffcfyQ==
X-Google-Smtp-Source: AGHT+IFdS8+yvG8UxVkAhue46f+hMFBINoXIWLT9SwkmOkc2DVzjYwbXnBbiVCRx2rO8lzzzeBhc6A==
X-Received: by 2002:a05:6000:2c12:b0:432:88be:27ae with SMTP id
 ffacd0b85a97d-43288be281fmr5846851f8f.23.1766947551969; 
 Sun, 28 Dec 2025 10:45:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, vattunuru@marvell.com,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 6/7] common/cnxk: fix array out of bounds
Date: Sun, 28 Dec 2025 10:40:19 -0800
Message-ID: <20251228184300.541639-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
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

