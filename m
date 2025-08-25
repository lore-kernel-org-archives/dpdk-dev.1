Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7176CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0B7140A84;
	Mon, 25 Aug 2025 05:43:07 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 3080A40E1C
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:06 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3c7ba6c2b2cso702361f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093386;
 x=1756698186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktZjdMskytau1nlXtSANM1bBHwDHBOtVDH2jpdJhIwY=;
 b=YIvSTa4J08wuglAPiShWUCwOB+CYMISTMdchj9kHJtEudVW7TaUO6D4+FarS/8B8Nj
 E9sGYR7az/q0xzjDDkEu0gyhxmQb8l3v+xHQQD+jU0qiyheVM1djzdYUd+ia89g03KcY
 iICNmOl78bU2dpxbr8Vn3oBvWBMPg7H5Jqu9aefi+j+hEToMUkfUzNnMIQGQCYw4WC8y
 MuiSo94ZIUYh8UsrUoEWi4CwHq0Fsgj9FBnruBZBkdQ9Ty9mnH4BeaujajVi11/H4Org
 eZWGSqYkPrIEm+1+gFrjYuW4eVVs8VnXSQ3k3HiVo1ir/YjEHxyXxw8Fjg15r1PvNX11
 tSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093386; x=1756698186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktZjdMskytau1nlXtSANM1bBHwDHBOtVDH2jpdJhIwY=;
 b=MwjvH2QkxieJJK37RURKgUy3NXJUBAN7Zr3szBkwy7PtKlU97dE9+ji+f39rnrrfhn
 fYgM//aFX9xXbnISj9H0oYVGWpmwz8a/nxgBoqzxV3scSCuakD0hqQ6khWfAKO/nZRuE
 EJt0NcwuNuK/64RPCa4tEsVHQd8bteryuaKRwVbUfmO6FicjXuWG+aSSqQYy30IDW5Tm
 GWo35KNLLUk2uQYXuaf8iOcc5R7GAGgQcYHuWgzY5lX3+D8lICBcjZKYJ5DaGn3U6Lju
 cq8vskWlN+sWVnKroaDKJtthdjM3mq3v7TbPYKKdfihyE/MZ+GsoPFWpAIAKoh3M6dK5
 BNng==
X-Gm-Message-State: AOJu0YzyHsfwiQBEyAkAFOOvpI3f/gpTaDZquRuR2TXgsPdURMOZcQ8u
 UeSaAmR8lYg+aPpssVL9TBnzbB2uaaf/DFvxqtDHQZKFdlsmyLsLWLjHFrGalYj+b7wSbxMcK4z
 x4Soz
X-Gm-Gg: ASbGncskxB20uadj6pFMm1Brm57iQaNW/1gWAPbAr680ms/R478olMEmokWD8wveGVN
 Ll+xx7cUvqWSMixQpnTz4IuC/tywD4FM6XVNj1/IIaTApZgcDXVLePd2MDNm/pVdK7nrotr0ST+
 ehsK+p5j/RwpPMwwHi4Oo6vMNyh6/ns1S7K6zUx1Dy7OthoPCGeKN7nzK7PCWERaM/QtVKnRlyi
 e8istuM0AzjFqkG/VgzSRWsEONDjhAzPpo4Ut0zModGuWMpggzFrgoUNqgq2LU4ZdaLaGPCE+pR
 4TC98e14/yGiXojWSQmptFyDErQX06unDrr+r2/B0d0t9EcqHc5eZx1BAi+mS98+5UEP3pwNFTt
 0LIoJ4syRN08S2i1SjQxV0vjcC/VASNdVf/dHsuMEUDajks7TF5IdWLEg6BDjJ0s7292OuoCG
X-Google-Smtp-Source: AGHT+IFU5JIhI1CoPTsbIB49CARYxyqJwoT+9oDE/oomF6PT0wm8R/pC4Rti2oWUJtrOLEhumKQmrQ==
X-Received: by 2002:a05:6000:2891:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3c5da73f498mr7126263f8f.3.1756093385826; 
 Sun, 24 Aug 2025 20:43:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liron Himi <lironh@marvell.com>
Subject: [PATCH v2 37/43] net/mvpp2: replace local definition of FOREACH_SAFE
Date: Sun, 24 Aug 2025 20:38:50 -0700
Message-ID: <20250825034126.12046-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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
2.47.2

