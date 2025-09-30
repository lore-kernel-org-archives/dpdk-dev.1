Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CEDCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0020141104;
	Tue, 30 Sep 2025 09:06:28 +0200 (CEST)
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com
 [209.85.222.226])
 by mails.dpdk.org (Postfix) with ESMTP id DCC61402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:26 +0200 (CEST)
Received: by mail-qk1-f226.google.com with SMTP id
 af79cd13be357-856328df6e1so522378185a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192646; x=1759797446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=sSkHTHHmK3DKaeMQBUxh/xbip78VO2ItlODDrd68sE51uF33vF2ETXXrcCRP5JrblL
 kBevWggzza109xYD6E13XBgwpwLtzJ+JHfO4nxaXa6i5swOVnn6z9pZ2LFu9zGvuPfAA
 uFPA4/54EhFGoRY1xTvge9EpAKXgPU1tx4+OnHp8gNnm92zFhevTM78AiQ8stknS6pDS
 mQxZRBpwDLwzVZkKBNVTIXIvee9Pcd2ZYvFEDtGXlmAKvl1hnKZ9GR21MRxP0jQDmlOZ
 IENBVWcvVuv123LIl18TFspQdxA9BGPhHMIIETXhKbKWYJMF1lfTGozLxKu6JXniV0RY
 K10Q==
X-Gm-Message-State: AOJu0YxzouuH3suM+PuuISVlWhjfmXsG3UhULxq1JtiIYJIf608eDhHX
 Uu7smKnj1IrbhUeJ2hzn2bhQ7Fin1Aq4+DwAz0aKoaV/bS41wXFfWnLg0tZ5PhnM3wfPq62TGsG
 u1YRcN5Y3frAEj/Q0OrjromKXCgqpM62z9IOb3MipahbEqcjwiAtZMfzUOMK+asaZ2kFWCCkmTh
 CkRBJGpY9wAykS6OD7TwLb6N9ZsC0XLF9eI2TaZJz3VejHeeHpVP8xQwisoe45QgW8uJzIrA==
X-Gm-Gg: ASbGncsFu+xwErNKaAX2Sg+3a9fOeMxW/OFL/NukA4O0tBwN+ZdqVdhQi8lbAGIv5Wy
 aMAK64hVKJbZYLKq0rznhwFOKIg6QUuubytndDVAQHkWQNO6snKkWzYOMRoBpfS73OcWgV+Npck
 InBDexwgFZTxTwMJoSk9664JhqgX3WOs3zwa5uDRypshh8/H5lMhsfAE8reT9LbIQpyABNPH91s
 fVe40sEu2kd0KoPZirOwdyWvPBUu5p82R99LcTvH+G3fhsa7s914pCWOMK+hj6AyMIkkakvi9eG
 77/IR+ZaWA4ePUgkdKIJIirPHOAZw3eDh7VPIILQN72LxHmHfbC13SbEfk6mgepd5DPre36eCEE
 /R04Q0eitA39NNQ+W2Cv3gJrwbDDus1zogsIq+yYa/lIQ9uwEk/3Mo/HwUItfwERLYTSr6qg6Qw
 zvvQ==
X-Google-Smtp-Source: AGHT+IFE0LQLnGBpFyUTdjDAx/FP3z4wDnC+wBiXXMpyv5ed8UknJucbprRUT2lCROW2twuP32Dymmc/m/dR
X-Received: by 2002:a05:620a:a203:b0:85c:d089:41d8 with SMTP id
 af79cd13be357-85cd08944a4mr2347393185a.23.1759192646168; 
 Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-4db09b250dfsm3631801cf.5.2025.09.29.17.37.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b522037281bso3373814a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192644; x=1759797444; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=fWtEcvruczSzIqT5T4R4RihllLM4frd8xSEWxxf7Bk+m59Wgz7KdTK5QZv/4FRLvqo
 sN71eQcqXytEKhGz3OOIbL7UTtXmvsqR4dGCwqyczqbqa1DmZeR6DBYlEGbgsB7HR7HB
 a2UPrGBaiyIfGR0KqL3zFJ6dSz7+s7Xp1IK2U=
X-Received: by 2002:a05:6a20:12c7:b0:2fb:62bb:e0e with SMTP id
 adf61e73a8af0-2fb62bb0f25mr14519034637.32.1759192644590; 
 Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c7:b0:2fb:62bb:e0e with SMTP id
 adf61e73a8af0-2fb62bb0f25mr14518998637.32.1759192644037; 
 Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:23 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Ning Wang <ning-nw.wang@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH 36/54] net/bnxt: avoid iova range check when external memory
 is used
Date: Mon, 29 Sep 2025 20:35:46 -0400
Message-Id: <20250930003604.87108-37-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

