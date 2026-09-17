Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC3C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3698642FC7;
	Thu, 17 Sep 2026 22:11:29 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 198FF42F9F
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:27 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db18fe433fso218145ad.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675886;
 x=1790280686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=N798RqbJc7brUkk7BN7yZ0Rv/PtGF4YsXn6to8L6ShrB+9zYPq6u8maiotEUGeg5rn
 LkyEP8znVAWgG4AbD8ZamBbw9Ej5pktpeS1ukUYhLu2JyW3NklkLl+VKSc9YxWo75Eqt
 03UFF66bwr/kZ285pOORcS6ODoPkRqSXpBMsK7txLrhjNFLUashPiTZzCS59BOXB/+vV
 udTQ6VF3AHsYVCyugWn8WT3QJYypJvzk395iHqJEyAerCaVUaM/R1BYSY3cSqxxdZfRn
 d1ji0rks7wYF6VFMc80EXI28uB2fklhzz9nA70enubt5suwM5E6VstFjpXQod7ljhUNO
 WZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675886; x=1790280686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=T7NwxCAaqksC9RJAXY7NoIr5euQuj1ZKNsoIv/h/ibO4FCFIOg8FGGhLtGM3Ee2q1O
 g4Gpemqq4dfKu1BUhWYR7c2rn3BdGRKk46Gophzu3CKqXhqaW3XpZ87f8nfRMAlQ/fbX
 X8CTCUPdxocIhPMzYt4mowVRRn279TZxtOKj3ZcLFzUL7GN9dbRTw+kERg6ssPTVIBLA
 9Yu6ETKbjLO9++s1HHLdwHJJ+Pu1wZ8qHBtsRwrkdc0CuhG0Xe2gJRjpzFIWUKT1ij24
 nuO1Jx37YZ/mVp/jgAJfNwYsUWETp+GMxNRDon0wCNq/SLuCRyh/WSjZIur1abacLVtM
 7lyQ==
X-Gm-Message-State: AFuF++mKL4WdCmeHFMHT6qILW3gkezEBYJpQpmXx2G5pyEHbttEyV5v5
 mGpqFBZHYeYBlsNu8/+pC1I0mm1IfB7aNuW2SWMT0hwQKgkGd1jgL6oT/N3xG6zEwZ/VgBuAhua
 b7Fuu
X-Gm-Gg: AYBFou3kKJK/4h5Bv8zj4G/LvHf0KvKDIvx5XmTZhVt07pd+y7BFHl51ngkz1+e9s/V
 YYPzH3PIU4vdMwtex2KQW3/dt3R2/UnJCc0W/j2uRgNO9J5wyXkozHXSV3sHqFOfX5ooDtkIC+i
 2YEClsqU22YD2czvNOjcySol2A8GjXg/scm5l/G55taELfw/ZFh2rDUSoPV32IJiG+VRNy8X1VE
 jKX/SycXA+i9Go0b5oLJsnanpqAnPbALDzJeuFMHNSY+UZmdHxN0B/fzoZh01CXj+YkFFO4KblX
 Tf5KnQtZ5MPoZ9ZyfHGBmAQPd6NpgrNSOSdzD5g/QXoR/EyWlDgzjdIeoAiGBYAhAeIhouF95qJ
 w0GdDhL8I4nTd+76RS4JwYlH0reeuZn00ivcZHFR8c79X7DN68O+IoXWEBhuC5RhK2v5EizZB/H
 RfUDR/ODCW/7a90uv7x470hcTiMcRjvkWPFOSnCBH4jRQhtyfmJnlf8jNH64wq+UDK9EZgi+olr
 U68G7RTYLrMZKSWlmFFLRj2f0vYjGTsTdj6wA==
X-Received: by 2002:a17:902:d589:b0:2db:5c0a:f18c with SMTP id
 d9443c01a7336-2ddb1ab3c26mr7063785ad.6.1789675885403; 
 Thu, 17 Sep 2026 13:11:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v8 03/25] net/nbl: remove unused rte_atomic16 field
Date: Thu, 17 Sep 2026 13:10:07 -0700
Message-ID: <20260917201119.2168234-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

