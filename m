Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81437CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCFC240E4B;
	Wed, 15 Oct 2025 11:05:01 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id A017D40DDC
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:00 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b551350adfaso5167712a12.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519100; x=1761123900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=kdjhDFFwh6GFJctFdsLoYGYwMHf8fZrUpP3DOgY42/MlPih6JL41JlirARSn0TNAOp
 b6z4+zzElOTAfMl3scXLex/BbrK10NfELD8PxKtHv3qnOipP3T3EoczKdpXE2g/m44pf
 ANDRAGIYU3nA31z5z8PYvnutqGKw8rLeCtDRrVvum2ftQu4l5FfMYpVGUNBSi+I+UPWC
 Q+pmvaLWmnq6Y1wwI8IZsusDzBXYTip4hEv8zox/lLsj6zGhpAtZlMRaQxLdNoDVmpGj
 JVdqkFpAdIX7CEewlvsKBADY9cG06IUIQ3wh1wYQBKwQ62DcvxM884TmCjHrZmdDW1xG
 SVvw==
X-Gm-Message-State: AOJu0YwTyIAZfP4dNs5JxLE/sAqmtxptIpfZ0ba4hGf40FIupK8iTT1d
 Uue/wontva0InH2kKTasrivdj6m2mEykTYc6c2m6tun7FGBEHUEm3HEbn/Q6NDhF6dhQ3NPFPo7
 mlpd9bvQL/d3+nrhLKoo9RWjLIQPoNCEiEd3G8aT+nMkYZyY1GenRI2qM53UFGD8iL2gpVwNZIr
 4/ITLPlebT3f8ZWeIkHF4SIm1TbUU41DZlAw23FJuwgTFwMnqDMlCRDrYrI3KXuxkDzMzm3w==
X-Gm-Gg: ASbGncu7QC2kdOGRZ5tFtFiqXOGGdBzs7upLBXETYe0LlTgUw4fq+cB04SlvGamvo86
 9/3dVs9TMEnK7298qoinVhQLLMd694Ruf+JSKNtzpvu0iGpK6910dGSAx4m5j9Z+ULeyLGAAIoJ
 twq+h9ZPd3fVi9mU5VmKUHM58J4yeOH+iIcCG9J+M3SVAfOBrHMJnHvLpfn9z7xbF1RhwWGmI8D
 SEpGKVg5jpeDfvCVqb6jk31LUhpQKweherWXxSXZFLNJC02qBvonskm2TpaSe2KcP6anjHKBPxV
 CKIOq2ctyAGdOqSe8zjKZ+nMoVxFkkrR9O9ea05I9FbcFTjSXYlzrGT4n8V7eAnUncJ+cXO9OoJ
 /E/peNzUEUoqOqv6v4RZru528qyj9tdZ5HJYzFONzLgEaUn632VubJbjGfKcQ93BoXfli1GYUXX
 Y=
X-Google-Smtp-Source: AGHT+IE+2kHBtISlW7rTcXzUzcodOs4v+6KgTWO3BvtbWoaf+aUYoTF6lynDIVGRnmpXs6nz07Bc6YqBtVBQ
X-Received: by 2002:a17:903:2d0:b0:271:45c0:9ec8 with SMTP id
 d9443c01a7336-290273ecac2mr337042825ad.37.1760519099714; 
 Wed, 15 Oct 2025 02:04:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034df1257sm14273435ad.4.2025.10.15.02.04.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7a153ba0009so1616200b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519098; x=1761123898; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=So25vlcL09DGxJiNqvrS+7j+LPpBrLOrVwFGB8hcZbHSlFwL3VHk7tHwru9pwwKjOc
 1MXHRWahkGyQlIZu6ByH9wLEtWycNFsbrLYg2mKGMYfm4F+kJlvZ+h4kkgBY6Db69Y6N
 Yo4XPK86KbwVVVt6rtyGWcBqsWVK8krgJmFS8=
X-Received: by 2002:a05:6a00:2443:b0:781:4f6:a409 with SMTP id
 d2e1a72fcca58-793858fb715mr32005981b3a.11.1760519097702; 
 Wed, 15 Oct 2025 02:04:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2443:b0:781:4f6:a409 with SMTP id
 d2e1a72fcca58-793858fb715mr32005939b3a.11.1760519097133; 
 Wed, 15 Oct 2025 02:04:57 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:56 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Ning Wang <ning-nw.wang@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v3 36/54] net/bnxt: avoid iova range check when external
 memory is used
Date: Wed, 15 Oct 2025 05:00:06 -0400
Message-Id: <20251015090024.32250-37-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

