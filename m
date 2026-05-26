Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0ACD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B15F4066E;
	Wed, 27 May 2026 01:25:57 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 2929A40658
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:53 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so36365259eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837952;
 x=1780442752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=Z1O2MBGaQjdFvPm7XsQeDFYgIWBtGp9Q2SDyDHC/yCeuKA+G0tflPkAo8SbU9uNwo+
 4LfsWHPBQEeVgMXVN6DXu/pxhuklzsuIQMOSffon+fM6+N4Ufj4YsbzarZrhUaKKX+MC
 Mez/IEqGZ+8/c5J1cjiLX5bZIbmgezRBQHfxuzlgr9khYvnyIohqZkip56gRC4sxm9JM
 IYZ/VU2QYBtLskNg6s13M2Q2LV2dYmmaKRYZFUaVLcNq4zNid2/zIT8uTAAFVwKx9p2x
 dOidn9djHvjIZzYIs3BlABTZ1muyg8W0UfaSrpLrm0Fy0QdFokgLKL8kXtdI7BrZoM2W
 1ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837952; x=1780442752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=B0CIb3/8JuWs+l32QiaIq0zYBUMKiDtxoO5m7/4ExOa0Q+6UEFmSdzl/cAH+KVaqjg
 5cGTmd8MliuTWR2bCQefAGGF4LnyOOPqm+4z7F+qSHVXlz3/Oy51kKPlaPlXez6fSbk9
 pGVdGaOnddxZ2rIloVC6eN2C/Tc+oe/6ZtXXB1SJOtj3cwxe+XyBbNHGSt06P3y7sv2T
 /1MWV3KTIymLjl3bzwjtGMKC+hPMQqEObM0DpUnBR9rujpxf1GD37lTqbH+jZD5juDEi
 jFP+QBNe1EY6HlqA2x7CseAbS5oT6LURLwV9t+ivHWSsgq4cOFjjFTlxXPfMHYkqwxA+
 AX8g==
X-Gm-Message-State: AOJu0Yz84hui7SySPrHf38QtwMRReI0VSthApSRG7NMeAkdIzu8w2Ta4
 js0xWBZWmdTlNumHXkM/TJK3JEFhi/vhazl0YSvo1W+Iw6irYnt5luPt+dl7+2nSHkskSm72+IU
 2rYpI
X-Gm-Gg: Acq92OENBsR+JLanqWiEw124BUf065YoBcB/ZTJ16EqWv2z0QpbJK75/dcyjeLxbCpP
 KyYCUHjTvePrbaKPtQ/7PBx8kw4JTweUe8LNOcHU0hzroA9s9VHrsfCYtrLA+Jd97AyhtpKSVCZ
 VTIPChSl9GZgHdlHmLs3OCYDxNj/uVGvRbEfs4T6IAAQUKVjzmtx/RjXQbvy7Z8r3NYUPr48vaq
 Q9hg54EJV4EUaaZgnAO0Ltp3IRGvQhsPLZDJQ2pHrjcj2c9jCZOfh6gh93+bClhy8yvgL92/nzN
 Ck6quYerltBGjzjaWqlaBnHZmcTW+hRbtbEMjpPOJxw4m0yx0UvM23aP+X22PYY4+UvSpERzysy
 eWlvhUX22kT8UjGUEn0JHMXG/v99OIrbzCxojAsn2+M5Y5PVzrq/klqDs6nb9ZKGdKUTdxNo1FM
 NtIKfoeSUgBEPC+9ID5GyYkaidvj6692KuaGbIuSVoZD1PpdxEMy45vvdcPZvDMfG6SLLNEE++q
 DY5fg8GgWs=
X-Received: by 2002:a05:7300:aa8c:b0:2e7:5737:8364 with SMTP id
 5a478bee46e88-304490264f3mr9578246eec.15.1779837952288; 
 Tue, 26 May 2026 16:25:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 06/27] net/nbl: remove unused rte_atomic16 field
Date: Tue, 26 May 2026 16:23:56 -0700
Message-ID: <20260526232542.620966-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

