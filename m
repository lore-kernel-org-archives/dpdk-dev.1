Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C9C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D79406B8;
	Thu, 20 Aug 2026 07:23:37 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 46DC6402BA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:36 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso601113a91.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203415;
 x=1787808215; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+epHBW1bC2XIkz4PgfHnxjvw7Mqz5efyojRyBM8ijyA=;
 b=ngtDY58npm15btxSyaXLgDRN8Y6afgELEDOqCYCtkw04nZvrfpR20EExBgx1RVGyDp
 2+hvWZavYHoUXDTyB2NU3/+ZjLeh65aTi0Eedmk4XhTTHA/llqGkHtXnxUq6G/aLKdhe
 texku6IAdlafThCjouhkNIW0h+7fKB5qml9GEMvzsYmNIFiOm8AMSI7HL67UX/4Fr/Ke
 MgUn30lCdDH5JWAcv6/wGpuU4qRzfbAz+YNvXtnF6d1HftbJ69M0OK08nh+fmqWQNWe/
 RnxVbbKID9SCOejvL7tBPHvShRJmMHGkc0sOK6ixxkYsE5wkVokt61M4t4QhhoLHPKXA
 WLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203415; x=1787808215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+epHBW1bC2XIkz4PgfHnxjvw7Mqz5efyojRyBM8ijyA=;
 b=L45tLnqusLwqH3qzuenZl9htL4bIsyTS50UU0q4fPWHHrCBBDxENewQdTovlRiZDOl
 SxIf02Pi6tZTqNLsMYVUFYWmuVJAu2YBxh+AqXvPj9bIUlOnviZMsvnb+qKbikGm/OMQ
 Mve3miKk/ZzLJKitTnVWC2scA+uogGLz6TvxNOypDFOx25JiYS3URnUDaciBABmQ8PfV
 6er+GBrvy1u/PgPY7ltYR5PP1RTq/arSRA9uXTW3xn22+V4wFlHuKcMjjURj1aSWezBr
 IpH/ulyeDsn4kZmuVF/tLr44Ch2UFi6DKrM2tp8ox26SxkWEhV1zXEsLk9Z/o/rKWESS
 RhQw==
X-Gm-Message-State: AFuF++mAveAPrdnqkiRx3rsT/GZ35bc8Kr77VZg1r0NgfO4vO9xhxApH
 JAyw+W0tKWCsp91hbrS/R2iBKe9utCe9ZlO8ECfru4d7rS9+Um2m+565XjIXoQ8hnob0sHRi9kl
 1e3gO
X-Gm-Gg: AR+sD11/V+ms2KoTsn1N1CBQ/u5YRagDlCY9aTyD2cocHxk8Eg8kO3287DUWtVcKG3D
 5YEucGvxarcVmtOF3V6wGDztcL1wd0K30Jk5zgQbpBd2dE8se9t2KKqVpYCxR65dVwm9D+O+0Ln
 2rlBUzoEpjIMylpFsT0VKqkXC8DHVrryN7qW1qErBdHN+YA5ZNMr5Ah0I++NsrF2oQ497OfXfgB
 FGXqfC5170ZudA1mHwMKV4u/Ms2TFnHnIwOMnUWjSdWPkRIkNgBlojreUYApyCuFvDyN0ZIDxS2
 rK68AeZR4J8R7QUWNIbvAJ/sW1NmnbHPJh676JkDeTABnGUsgFYj30sQJeItOXiYThG/mywqcAH
 /A3hM2QaujsAoP9Hu9o2uzcyPoWpyPU9WnGxMUT4EzkYPgJ4BEyrj27kBO/iBVOAdkvIVbSSkJt
 rsyTDtnWMSveWzmcw2UtJQecLCbiMA3rUhW++0QzsQPPWIp27wHzChFlsHZI8uQHrt8CtkJ/1ex
 YeU2v8rFA7HREqBElHJ8eT5dGc=
X-Received: by 2002:a17:90b:3851:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-395a06ac272mr5320482a91.14.1787203415380; 
 Wed, 19 Aug 2026 22:23:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 08/61] security: replace fixed size rte_memcpy
Date: Wed, 19 Aug 2026 22:11:58 -0700
Message-ID: <20260820052251.1453273-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Use memcpy for better compiler checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/security/rte_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index 0d89f8af3f..2e60b9ec64 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -406,7 +406,7 @@ crypto_caps_array(struct rte_tel_data *d,
 	while ((dev_caps = &capabilities[i++])->op !=
 	   RTE_CRYPTO_OP_TYPE_UNDEFINED) {
 		memset(&caps_val, 0, CRYPTO_CAPS_SZ * sizeof(caps_val[0]));
-		rte_memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
+		memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
 		for (j = 0; j < CRYPTO_CAPS_SZ; j++)
 			rte_tel_data_add_array_uint(d, caps_val[j]);
 	}
@@ -431,7 +431,7 @@ sec_caps_array(struct rte_tel_data *d,
 	while ((dev_caps = &capabilities[i++])->action !=
 	   RTE_SECURITY_ACTION_TYPE_NONE) {
 		memset(&caps_val, 0, SEC_CAPS_SZ * sizeof(caps_val[0]));
-		rte_memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
+		memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
 		for (j = 0; j < SEC_CAPS_SZ; j++)
 			rte_tel_data_add_array_uint(d, caps_val[j]);
 	}
-- 
2.53.0

