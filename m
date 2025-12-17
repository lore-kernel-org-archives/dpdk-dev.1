Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4753D66B81
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 18:46:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A91144029A;
	Wed, 17 Dec 2025 19:46:52 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 73BE34025A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 19:46:51 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4f1b4bb40aaso36399941cf.3
 for <dev@dpdk.org>; Wed, 17 Dec 2025 10:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765997211; x=1766602011; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lnPO4VotKqnLIlTZxwkJ30bIaAzefnilDJVi6N5dr4I=;
 b=KDB6sSlDcxJLTjt/LhZihF1TWn2tTz2/U20YyzOVA/lSClU4pcsK+muG9mHBvHN/cb
 7XwODJ2EfS1Zh69kMmm6uxAcLcatunkOg/+q7RILOflRF9876D+jaUX3K56zzB/SaEbi
 yDSxxqfi8dPIveWYtmOM2qNVRQvEbBReU4Zks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765997211; x=1766602011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnPO4VotKqnLIlTZxwkJ30bIaAzefnilDJVi6N5dr4I=;
 b=FGYlIM+4WZVdi58sKqvF3MkZrypC3t0KfdhykAl0xytAv/fB2cm23Jqp+l3RQAkmpS
 QQPRSwOmTrsNUlNje7yuC11/P03z9zaB7ukCcJG5aGjXIi89EC5pUPCzW8uoyNPQpixc
 6s57/95LuqJrsp5tm10D/H1aKoS1grNSdaecrCC6vcG/kMMFx9Fe49a/hhZGTuKzE4od
 xkXvAZx4iDpPxovXq9+IM6Xz/F7sQXF+AFFqBu7gCgVDnYXvXDk0vAuOhCaIHqcchO/S
 0hbuP93rjWq3HTlJifHFiqTwORNqqjd9ujKK54EmUwhIUnuVow/qY2ren98ySuvVnq4F
 oz4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvxHO5gaj04YB0f9LWd6aRbvhH3ZDP6N4x5HwHK9Bgx6fl06Vzb/ieP45c0pzgMCVtSMY=@dpdk.org
X-Gm-Message-State: AOJu0YyvbJKrmpBsO9rcSvecX2xu3EW4tFwRILEs+j8mcolMblW3UX8x
 JcJ+cliRi9n5RrrHr6rh9yX9b0q1Iyc+32RI51o54EASzBdnig7d1ftjVpjsoIywKcI=
X-Gm-Gg: AY/fxX59v76fd1OW0lP6IuVkggPKVwEjNrcgHZ/JJatwZsQRsXuyUQ7Jsq5gYYyagr4
 fItWYPf3iIFGsWV4hfXzZa5lOohziuN8RgEBj80SVk5V3qg+Fq6Abp8LLzBN0jdO0HZieQUOytd
 t3rY0KjCGhL2KBDprzBcDRuLlC/fNFGJzoIHUaA5yrOXEuk2LnGKdazX/GMFDLHkIjatVTb0Q3w
 S67VcZWjs16rfXNJ+KLgzUolGtmVWJBkKlq5vxO2x9/7DdHFgQaafETm4jBxf4a69l0iKkNcLjZ
 6FTN/cYklSXvOEdLxWMSIBg6os6xN+vYNFLDffjPD/lhmbCKT68mEJrepP4YMZ40EADfge99MIl
 kqZLomtamNRvc0HuXjblRQC5aIpU6v3M0D9HjLbJV2T+Wr6SxMEk9K3uf+aErfwh2uff9oXUQxD
 Bp++aMgizvWrhtx23+at8lJbw=
X-Google-Smtp-Source: AGHT+IGomxl11jp66yEB8R8viJl2xS2IFgFY/eBa/hUNqrcZjjb3Uc6jbFTdYd+LxXMAaNvpwEzrRQ==
X-Received: by 2002:ac8:7f03:0:b0:4ed:e337:2e68 with SMTP id
 d75a77b69052e-4f1d066fd5bmr239053431cf.81.1765997210625; 
 Wed, 17 Dec 2025 10:46:50 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f35fd621cfsm363661cf.16.2025.12.17.10.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:46:50 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dmarx@iol.unh.edu, thomas.wilks@arm.com, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] doc: add missing rst file
Date: Wed, 17 Dec 2025 13:46:37 -0500
Message-ID: <20251217184637.719487-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

The RSS test suite was added to DTS without an RST file. This patch adds
the missing RST file to the doc directory.

Bugzilla ID: 1850
Fixes: 367e950f6d24 (dts: add RSS test suite)

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_pmd_rss.rst | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_pmd_rss.rst

diff --git a/doc/api/dts/tests.TestSuite_pmd_rss.rst b/doc/api/dts/tests.TestSuite_pmd_rss.rst
new file mode 100644
index 0000000000..942fa5ebdc
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_pmd_rss.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+pmd_rss Test Suite
+==================
+
+.. automodule:: tests.TestSuite_pmd_rss
+   :members:
+   :show-inheritance:
-- 
2.50.1

