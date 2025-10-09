Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F5CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CB740BA6;
	Fri, 10 Oct 2025 00:16:20 +0200 (CEST)
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com
 [209.85.217.100])
 by mails.dpdk.org (Postfix) with ESMTP id 6C92D40E2D
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:19 +0200 (CEST)
Received: by mail-vs1-f100.google.com with SMTP id
 ada2fe7eead31-5997f407c85so500926137.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048179; x=1760652979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=PdE6lWaylDfyEY8kZSEggwEYb3Lk0ffKLmGvJSxLYhM3HB2BSm6vSXCjSTvZSCZWo/
 WGF8AcwKY+8aDwPQgH0dX5vU+C0M3oyUl8LZfNMGAgJHteveLmLRiZw3Y/f5ogYtMXX7
 6GmvURKEcDHkAYjovoy42YbX/s3fxSbtzadT+JXqfsAnfs+vtlIN4fzlSk1cnExJCx+B
 juj2ltiQrauW4iB0S6pHzxemJV5vB/lB4HCjoqMxBi8H+It42YDHdI64lZB60KJPLwge
 z+fA1RXfbtdrwoTJofGOdwl+Tlhwra7EOcmt10BRB61f2b48AzN1sxKNP7OnFqaSP6L5
 ArAg==
X-Gm-Message-State: AOJu0YyzLRM4/jInW+DapTxAq3dwobSUcAnYx38FYv9w3rxzfUq4qAJ2
 bwQt7Rlyj7zIhlUKCYvjiq/Ir3oncqKZGIFrWLp1SbWQmC5mit9KzV1Mz3ponNiDB0xjlbrIlh6
 2uj8KPs+Q4K9g2Rv+iZhg8gyNSCZGpdov92ko8EjGyUQjSY6ACGo//YouUZLufhpwnZSFWauqwB
 8kzWE6JLJcboIm0PFpYjiLWVFZ5X5sTtFLjPsHuKrqBbUWkwzH3EMAv7icUDnRY01R3PlNmQ==
X-Gm-Gg: ASbGnctpeYKvsg5MF63KEOXkkQHC/xUm74kPCMPyTaxvDt9bbRgZx74LKP10D0cZa5q
 8ktDc7u5wLuigoPM/UfZcvUa8Mg9zC51cDVkn62EzWwnuHH+o/xEzew6SYs0QrLl3vkxoH/rrlA
 /k930AucVcIZZ51lEocq5zwOw+X2QXz4/9s0MlvTUTAtPEu97cNQEhplNF/GBUU0mIg1+VrrZyX
 38b9L98VLsBQpxdw8RTT4Z2+hwIkF1+CoyGTuB8q7EL3nGLTFuOIk3+q9hhcNR+vV31bPzXGkIK
 NGf3izkvUCnJTc8v9hQSSG6zhaKOjDG79ALX1ZfLmwaxq2n258z1BEfMl8ai/IQ5WNwb+Y+17yT
 s3P8YK6IQcofOvS9l6IjrJgs6DmYPnrSD/k9FELibfv3U1f4GSl5CRl0En+yUR/nEJhdIf+w5ZP
 nSBmxwjwM=
X-Google-Smtp-Source: AGHT+IFj/3iUkePtuX9VgL9s6T5HZPihsPzWNqIniqlr9u0tmrdP36O4UApOynDetCyVJ/gucGzaLo5J3S/z
X-Received: by 2002:a05:6102:b11:b0:519:534a:6c26 with SMTP id
 ada2fe7eead31-5d5e23b15c9mr4378000137.28.1760048178750; 
 Thu, 09 Oct 2025 15:16:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-5d5fc6c5a1bsm91186137.1.2025.10.09.15.16.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-87561645c1cso587921985a.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048178; x=1760652978; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=QKmsTh76+sNv4+6NGzxfeBryXyoYflnkGudbVkmmvO36W4lSIcPIZdLVqEBvvsVKAO
 6uZZRbqk0DeTlG+p1SnfZISPYjH67A0FFmciThNE0BnLlu5q6QUkKH0IgVBtU2ZPHrNl
 1GgrxrjJ0lRmMa3VcChHxjMwSrD4meAN8JzMI=
X-Received: by 2002:a05:6214:1ccf:b0:72a:2cf6:76df with SMTP id
 6a1803df08f44-87b2ef92c84mr137462696d6.45.1760048177654; 
 Thu, 09 Oct 2025 15:16:17 -0700 (PDT)
X-Received: by 2002:a05:6214:1ccf:b0:72a:2cf6:76df with SMTP id
 6a1803df08f44-87b2ef92c84mr137462026d6.45.1760048176869; 
 Thu, 09 Oct 2025 15:16:16 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Ning Wang <ning-nw.wang@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v2 36/54] net/bnxt: avoid iova range check when external
 memory is used
Date: Thu,  9 Oct 2025 18:11:11 -0400
Message-Id: <20251009221129.28256-37-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

The function checks if the iova is in the valid range. But this check
is not relevant to external memory; avoid it when external memory is
in use.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Ning Wang <ning-nw.wang@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index f88e214790..27758898b0 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -221,8 +221,9 @@ static int bnxt_invalid_mbuf(struct rte_mbuf *mbuf)
 	if (unlikely(rte_mbuf_check(mbuf, 1, &reason)))
 		return -EINVAL;
 
-	if (unlikely(mbuf->buf_iova < mbuf_size ||
-		     (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size)))
+	if (unlikely(!(mbuf->ol_flags & RTE_MBUF_F_EXTERNAL) &&
+		     (mbuf->buf_iova < mbuf_size ||
+		      (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size))))
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

