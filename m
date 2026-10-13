Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E0CC6B1E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3D640A7F;
	Wed, 14 Oct 2026 00:35:05 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 51D6E406B7
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:03 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso2150455ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930902;
 x=1792535702; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lpXFXBTNZaFdQ/QEQBzHea5S+oeyB+taHPKkIad/co=;
 b=RbrvZzoyNY8n/KrGfeRu+r4nQ6dlIIRFhhwoX1GeOUyeYK7OmWTzBqrjZBOm3RytLK
 19CQUueNuHZiL90kPM1mfGMIlN/XJLTqJiHet08eOT92GQgU0n1mPkgynZ4f4/gtD7G3
 rfsWeeFVHjHOXf+uJGnN5xYgEnIsTFUNnzNYpUiXdq8Y72LOUwK6vTJtSw8tzTbDE9Wl
 kHVUHwX7mO+g+E4rzYRJEJsyRu0ICGG0r72Y0brwsFcUZINy27DyWxmbJCNXSWRr7mAL
 t9UzhdDlyajhrTd49LVnb7eKhRlt1KyhBqzcrezdevpWWJB5zINFBA9wE75rgFewSbvk
 WO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930902; x=1792535702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2lpXFXBTNZaFdQ/QEQBzHea5S+oeyB+taHPKkIad/co=;
 b=j0sOLiRHVSrVxjYu4XivwHMK//VV8IBlZ6Gl1lufSe+jWPXV0HW9Zra/Tz6HQ4E677
 ip1Ji9DtrrDhxLMCBTKTLgmTB5TDzSxJQ6yTHRri94t7Xjm5FahA8M13u4HddNBGLIEc
 Da7sYTSycLTRbQ7w4A/Ash+61X6F69pG5Cnk6RbbdoQTPxLVJ8HT3bIa/37bCCoLUxpO
 YdrkjMxybKHyd2qNVzvozcOcdB3dvxc4U50j5Jv2IHgUEG0D3P0i8GFoDKrILr2XkR+J
 IqUS6b863Di0PXsL7EAqD0it3RnWsBZtSbMs7CGzu05vnTfJ4+q1svqTJ6NpzBkOEZas
 e2zw==
X-Gm-Message-State: AFq9FYLOqY/XLfsZGyQq+gMLfHd2B/+GradIToDRAOSnqtYZ8qka+xNF
 MCaYtvg0r7GL8zoCTKrfe/PfKesEkhgeNhVzy2tXJNhbL3Pt3WJdq1lgp3yfiP3irct0q0dgplr
 dkiuylVQ=
X-Gm-Gg: AYBFou2oJyaGd6OGQ00sxmsDRGSDrBKC50wvlVoYLbmm2Agms5Scd/NBMgZfYQwEoCo
 GNjXyc7xA4GBWMOl5AwWAbgmSxFRFwAoPUbodsxuWVcPpRApqHBGMyMg24fmTS5lztmFIn5dexr
 l3NNTyWJrtppFJEFYx50j/l6QjsYP/6QBshzT55WRdGalK8egwkpjJUtTvSBLdmIRcHkI9Xd3Vu
 i4sOqcXVVLfGgAELD8qQbKLyQcvOFjrW+Z9fVQPRieT6iwVS1JPn7o/kLlzNDNdw9ZYTGkrhtZa
 7sw4vBrLrj1kGhWU1309B0d1/zpMMxlcNIWBY/ldZo5ClkAGabFDIJ7Jxh5hiSpb0w16HpdotEJ
 5XkJL4Bhdbbn51CfMEI9e9raq71wwoiW7G/BsSHYZlZcpaiKgmQUbbIDAE7FEzXTFHxde0lYHnu
 twvXUBE5sQ2qkJQZJzZhE+XniiXjAXgt+bk+CW1alq8bBIxBZBjRg8fGFLDny1eJN5pgQ8F0fru
 ydb9xt3GXM1QM7lBkHH+4iHH/fAiKhV78lKuw==
X-Received: by 2002:a17:903:19cf:b0:2e5:41dc:9ac7 with SMTP id
 d9443c01a7336-2e842bc7708mr128095195ad.24.1791930902450; 
 Tue, 13 Oct 2026 15:35:02 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 08/29] net/intel: replace rte_smp_rmb
Date: Tue, 13 Oct 2026 15:22:21 -0700
Message-ID: <20261013222410.2257622-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c     | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..d01d869e1b 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1963,7 +1963,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = ICE_LOOK_AHEAD - 1; j >= 0; j--)
 			s[j] = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..ce0a3dde34 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1549,7 +1549,7 @@ ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = 0; j < LOOK_AHEAD; j++)
 			s[j] = rte_le_to_cpu_32(rxdp[j].wb.upper.status_error);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (nb_dd = 0; nb_dd < LOOK_AHEAD &&
-- 
2.53.0

