Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D504C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9F140B8F;
	Mon,  7 Sep 2026 20:26:20 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id C1B4C40B8F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:26:19 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso2940382b3a.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805579;
 x=1789410379; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJg/K7dL1n3ywcTtMrBmfqPDA5hCEroatIG0w+enXAw=;
 b=Z+sftoxOgUa32KLyQCYJGWOVaZul7fsD90jkO11oycz+lA5ChHfxy/M9unbhiFmKK1
 tyVxCoCVLuMayHrYBULmv2YS8D+O2IwIZEgMaQAaM3eqrfBGw66r1S/U2tCnf6x+veuJ
 6TA0gB6s717pukM1oGzpDdfCST3jk4uEgGhlaEhsQj07+zHVb4YeSG9F6GPQz0xLcdX+
 Ml6gWe5nW312BBhlGMvyoeebUHm5G8C0w4dgHBo85jABa3uD4O9TrmEnMxza0aIl1gNk
 COg/w7cEcHynOgAjpNTr0EKHpYgGTWXtTrYaG4Z4WQxV6ZCNNLfX9qOEETo0ymhgb4ar
 TZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805579; x=1789410379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJg/K7dL1n3ywcTtMrBmfqPDA5hCEroatIG0w+enXAw=;
 b=ZeUttHaGPb4+TY9c2i1yDHeOsrN86IgqmYdQCMkALmZhkhaToC8bz9mf2QTAjCpK3/
 0ahjQDLpIh25q2fE2b58Dx8f4S6+XZhRdOQZL94Q1q6sHOvYnsTUCBIpNbha2PJbYpGX
 WH2cJj9I+7fOAN6Qip2bXtKtYTj8LxBlPj5NThcHaNm+ZDyT6y6sK6Z8uE1z31imom1h
 jAn6xIdsP1aS4mDJvI78LYTRZSOjZriDdnsvZuV9CR0Covf2RG+rQ4B1SUZWHmWMIwPp
 MMWr+aFen2ywCzDY+uANOZ3H7pLaMvmhP2k/IshFp2ERMpBwx0pUdTkYBwg59z0QOLLR
 mAhA==
X-Gm-Message-State: AFuF++lPbKjaQ0JBuwQcRHRoLkty/FZDcwnlKbNbrN//IPYeQxe1Ehf5
 t41t6PuZw5vH5f0nBAT7NeiRKOAnr7VEgwQBeLiCICD8K7B9uub0QdMvELslsuvqYGdGrK0mj28
 nCqia
X-Gm-Gg: AYBFou2VU+QpbiBnItQblWGx0EvOSA64cZJOOxVPFbRNQTehEXD6End1EE6yIj5i18+
 HeMlwQ9QVY3sR2LiLqqWX4GniI3H+1ocXpzgHsIUksGfm7zJpocWQZhIcXx/uAn1i9BOvpG+6ET
 oYihj5V13RwrnOdG/Xk48s1csJSfak10Aaqw84fPxo1U5rMm1rsVnvugay2XWZ2xy3EQ1pxHzuR
 08SfN4MEsvKL5ZLFtjnp9KN9RC15/cAdqEuAdnkf0N9uAFfYrNkee3SnB2apIoQNwnnJzTWxpuB
 uy4K+aq/MYbi9//I0tFnkJmCLeUPQGz2oQCtKpCfhscMg6DWf2x4fI6IG26Ru3x8DV7Xszy6THn
 xGKUhFwOmkuzp9kr7mxxJm7MyPmsfeiHokvsxVmWKj8olsQqRWPd4A2qnd7TA1oTA522BAO0YtU
 76v5n5tNefY0NguCYyCeuHorpTg2oCbGUC+LSrOOB7MusHE4n0Bji96jerWlPDR+OPGl+GW4D+o
 BzpJ9amm7QgkV8zPaX2Ai5UYB9KVcVC4VnXVg==
X-Received: by 2002:a05:6a00:13aa:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-86168e88261mr30189390b3a.17.1788805578889; 
 Mon, 07 Sep 2026 11:26:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm4553302b3a.38.2026.09.07.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:26:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Gregory Etelson <getelson@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH 2/3] app/testpmd: fix flex item allocation overlap
Date: Mon,  7 Sep 2026 11:22:03 -0700
Message-ID: <20260907182317.570481-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907182317.570481-1-stephen@networkplumber.org>
References: <20260907182317.570481-1-stephen@networkplumber.org>
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

flex_item_init() allocates struct flex_item together with the arrays it
points at, and places the first of them at base_size from the start of
the allocation.  base_size is the size of the embedded flex_conf rather
than the size of the whole struct, so sample_data starts inside struct
flex_item itself.  On x86-64 flex_conf is 112 bytes and struct flex_item
is 128, so sample_data[0] aliases flex_handle and flex_id.

Nothing reads flex_id and flex_handle is assigned after the config has
been consumed, so this is currently harmless, but any new member added
to the struct would be silently overwritten during parsing.

Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmd_flex_item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index e62afe3cb5..f4560d2cec 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -305,7 +305,7 @@ flex_item_init(void)
 	uint8_t (*pattern)[FLEX_MAX_FLOW_PATTERN_LENGTH];
 	int i;
 
-	base_size = RTE_ALIGN(sizeof(*conf), sizeof(uintptr_t));
+	base_size = RTE_ALIGN(sizeof(*fp), sizeof(uintptr_t));
 	samples_size = RTE_ALIGN(FLEX_ITEM_MAX_SAMPLES_NUM *
 				 sizeof(conf->sample_data[0]),
 				 sizeof(uintptr_t));
-- 
2.53.0

