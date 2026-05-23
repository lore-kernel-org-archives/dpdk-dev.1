Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE7CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D36E40A4B;
	Sat, 23 May 2026 21:58:54 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 52C46402D4
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:49 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so3667066eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566328;
 x=1780171128; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=YwzH6dTUu1aQaVuBRvyK6epw7T5wQyNDu1d0oPEu+RhBa2qxQTYBrPyIE7nRWCYCL4
 1k8a4pOGaBYhUGMeHaHZgIdUzSzEBFsIvVI23bmAbuRzm7wNSKnAIuam9wH3xcBAQ3Ob
 ZYxlOhNJGEd/KHPqj8K7Weo8p0EQSfgB6vE3lgUFAcgIWjb4+zWYBKsRDl7noGPQlWFQ
 nLYDdu70VCzyRr5zryEZzg/87VnDKnji9Pzz5HGW/dYyY7VGol+J7+ggLwv5uAFxFwWR
 tACl7Ues79+iVCwZ2poD7rZXG1PcUw2rDTOC4zKTchmn1+P+eqv5LHRTRQ2WMXFcx6pT
 Modg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566328; x=1780171128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=GJzPjcXvfHu94WFONYnuvG4H60OXhOTBh0Uo+h7YWA2+qExahup3fRJL/kI45qYDQq
 r9J/nl9WMXYzgm6JgvQpU23xSJowiCMAw/jHVtjRwsaRWmcwVxmxNEc1cPA2dMrcftKe
 /ouIwT6kqMJ3HhUPs7l/DJ6fsOAQ4YBlKbPUVPpvouW83JmR2xxrh4hGMDmTFRWltVe2
 tWyn8T1bq4AElPpSw/O105KPfbwjffZdcQI8/vLdtHI+XbBRAKQX7uh7zmDnxjXpyXyL
 Dv1bjA9bsmOSDsmWLR48moTIkOS47fCZEkAOfTe0ou1YwFlWgEF4FpscpLyMfSrNF+wy
 04og==
X-Gm-Message-State: AOJu0YwYYAJQFY12v/XrMrMJ55M7A36qcfv72fYhAnFhvHPnfWF7aVL3
 QNzG17eOgWtL3BZk44ZeMjdzKnmLygNSom2mypaHMegcMVdgW5bxbO5P5r73e2Fw0WWgrTknt49
 v5qbO
X-Gm-Gg: Acq92OFKYWU0o1T/dIXzocU5H2nYni+tOwtqt/7kW29t/fKtSPbUJNL9Qr18oT1LyJW
 jdrcTlnF4BVv5muR/Rvzy7c4DB05PnepEqthATA1Bz3qSgdO8Q6/iRc2XqZy9tEQqhMnjAB8btR
 Fyr2Ce2WE2pdXbA4ceYLYmx3/Aj8olRuD5h7Svr3dcZQN23p7PYgsWGRyLDQ8EF8gu4AMGNN31l
 mPQBq9lfe8Ecam8qg5mpv4ltxd9yEjKiAHOvzM5GdLpwc74ijKpn0Y0d6+4yXcwy3Qw+l3lAhyk
 UUMk8Aevg48yCATcv3xXn+oedNl2VbFlNjgh8Nal3QAOjj1GBv+NJbU7ikfSXBohtzVpYmi15kE
 QXToEZ5pR4g1YiD3xrZY7a9uZ4WCrWRPficMBoR1O+fWATsUtICrzgwbndRlcPy9S3BgIjLqHTd
 h+Uh0DGuxqiez+/JNVZiWvlZvt0VKAKMDMB/tJdK/xlI6TsIhdRR22Bo7aMcWT8w==
X-Received: by 2002:a05:693c:20cb:20b0:304:4f23:4826 with SMTP id
 5a478bee46e88-3044f23c4f2mr2051091eec.28.1779566328380; 
 Sat, 23 May 2026 12:58:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v3 06/27] net/nbl: remove unused rte_atomic16 field
Date: Sat, 23 May 2026 12:56:20 -0700
Message-ID: <20260523195839.454952-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

