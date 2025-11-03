Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7BCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D100640E68;
	Mon,  3 Nov 2025 17:50:11 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 59C0A40DD8
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:07 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso5781580b3a.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188606;
 x=1762793406; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hma9XyYxhWd3zZwMuErT/fgDQB1zNPKLT5R/6xe1Owg=;
 b=Nbh60ilsDmpnN2Nkno+7lBsYu76ahipJLpvlXMwbpzEJvY3uD3VHgMfEheC7bqI81p
 aKeAgedttggWT8fI/P7E2E/hpiaR8pb2QNj9+gkflGpDHNh15maZMkpYn1FSTk8Z6p13
 Rebe2kDCLgvUuEWgsUokGqvcePfS+A5TbKoDppqab5RDHibyvXb0ad0a/0rwCLJxPEw5
 HrLupW033F39kA6Bk7kzXvyGWulbsstAfNWYqXzceiGTbfxkBcl05l7PpksttgEq1SrF
 ac7kMXK0QEMwjsIoAI/tBxDeztpp6ttX2nKma057ukhPJZ4S5SciX/jLCbsZLcDQl+mN
 rWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188606; x=1762793406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hma9XyYxhWd3zZwMuErT/fgDQB1zNPKLT5R/6xe1Owg=;
 b=h1xgh5LDCYkc/ANupLDTB3mG3JqliJ3whhyxZI0Qvsbx+DynIAs1lp3b8ZJJRYGzZW
 reYxXOGkvHXeriaVz96Xjp68//bF2ic9ifLiqkXueIF9A6TWsUU2KJrixNWljboXgZ8J
 CmQ5K5OVK50C+VG5FG/m/S8sNhgrhPkfR1+odxqbAhqKdpc5fw9WZ2i++H+KQ8FC5jsK
 rNGNN3ZT3jLoiY2zOdHYYJxbzp1M2OEomiSDrM7IyijZ2XQJNo9jh/QxUH1k4vZ5aJxS
 FRB2WjjTK4q9uSKuVx+KOVNSIQwPdo+3lZi57nX7Y7Ko6BPN3g1SotUEkpU0w2n+9M5p
 UzxQ==
X-Gm-Message-State: AOJu0Yx+8FsAe7JgFVA39BZq6DClyktKc2OgKeAmJYG3/VXVSBpnfDaf
 j9IjWhYqqf1BEhVeLYG62j4WiET3uwCFUqh8TMOt3MtVNd9SB8V6oc/MsRasjwrf953EKyFAGt0
 rMuNJ
X-Gm-Gg: ASbGncuGCzsgGlWppgjxXqm+j7hYKVVFQxDKLx0ecVViNt2UtsDa0zTBJ0vKkZx2Xm4
 iQK5TeVfxJh8aYuUIP/69EYBa9lZ81WCcRjg72ASbM3uM5ymJCOldXYNkAdDmC0RaUA+7K8Q7tW
 qidBEzEoU8xnVeV27ljbWc25HowizGv/HglMhRLxV2kLZfK66Y/SrICJV7Z3CLZZLjmee+mCquE
 YU/T7SS9mbnKKJKYlcZlj6w982i0f6MncJxyLKNq2YKGMW3ZWIh8MBObnz/AdbdMSXqMr/ROZb2
 ZnHKMcR9yTEFydcrqn9zs7gADfGRS0ex+BZm5A574d8t5Xt33dpXHXZlIm8VU9pIyFw74aKUKbn
 wGAK5W9/uN0g1cOgKU3i67DLS0IwbIIP5H0RyxtBSnrT88MOK6yNPZP4O0ltcbHIFjcsAOs0kFE
 4UQWPIYIg8HK+VRRsNLmghRX9efOrg4KO2wmQDYSk=
X-Google-Smtp-Source: AGHT+IHs0b676jhm+n9gJK3lY06EWHzLxJTseCGxVyVUhahgPFFfESj+IuVJWWVWDT4ORUBmv/Epog==
X-Received: by 2002:a17:90b:53c3:b0:33e:1acc:1799 with SMTP id
 98e67ed59e1d1-34082fc7919mr16451160a91.14.1762188606342; 
 Mon, 03 Nov 2025 08:50:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liron Himi <lironh@marvell.com>
Subject: [PATCH v3 37/44] net/mvpp2: replace local definition of FOREACH_SAFE
Date: Mon,  3 Nov 2025 08:47:42 -0800
Message-ID: <20251103164915.101713-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

There is now a standard macro for this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_mtr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mvpp2/mrvl_mtr.c b/drivers/net/mvpp2/mrvl_mtr.c
index c07ac95ddc..27596b8c99 100644
--- a/drivers/net/mvpp2/mrvl_mtr.c
+++ b/drivers/net/mvpp2/mrvl_mtr.c
@@ -505,13 +505,9 @@ mrvl_mtr_deinit(struct rte_eth_dev *dev)
 	struct mrvl_mtr_profile *profile, *tmp_profile;
 	struct mrvl_mtr *mtr, *tmp_mtr;
 
-	for (mtr = LIST_FIRST(&priv->mtrs);
-	     mtr && (tmp_mtr = LIST_NEXT(mtr, next), 1);
-	     mtr = tmp_mtr)
+	LIST_FOREACH_SAFE(mtr, &priv->mtrs, next, tmp_mtr)
 		mrvl_destroy(dev, mtr->mtr_id, NULL);
 
-	for (profile = LIST_FIRST(&priv->profiles);
-	     profile && (tmp_profile = LIST_NEXT(profile, next), 1);
-	     profile = tmp_profile)
+	LIST_FOREACH_SAFE(profile, &priv_profiles, next, tmp_profile)
 		mrvl_meter_profile_delete(dev, profile->profile_id, NULL);
 }
-- 
2.51.0

