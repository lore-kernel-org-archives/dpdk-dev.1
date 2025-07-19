Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E48C83F34
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 15:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 211CD4013F;
	Sat, 19 Jul 2025 17:00:21 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 46DCE402B5
 for <dev@dpdk.org>; Sat, 19 Jul 2025 06:19:13 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ab3fb340e7so48659681cf.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 21:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752898752; x=1753503552; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO8Ovs5+YjakMDVolgvlDCfnIJHocIWRr9Sz4th0d24=;
 b=NMhtEszK6HW2toIyKtvZMNvgq8ixyt3kMS3TwAaygtBuKEY7vlGINqwWgQGgIYMqLK
 emm4ikA/AmPOZHg/94pzGHiNN6UPT6FAHc8JY4iHf0HOQ81xCPHCHBOArOBLmUPLXVRG
 SLUhrBhCjvLeSj23ANDqDaIwat++aobV72I0tkk8A1ha3jmB3seZ6+Tgh4SlWJPH1lqC
 MtNwBxLd5pOSTecyBWao9Z2QNtvjNZ2/asp7M3dLqNIW9g90FAcjZaRHeyg4xSOGR4Ie
 /YcmC1nFkCvJ/QnDCAnmmKvBoe4E5eUirTpqfwUKIgRZD9aDTAO7kI1ukmhEhn7Kw29W
 21+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752898752; x=1753503552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MO8Ovs5+YjakMDVolgvlDCfnIJHocIWRr9Sz4th0d24=;
 b=cK5ffKbvhncbVoC5cmIqf2r6AQHOeufGTNonS+VZkyx/o9fEsyr2T6ZxwGLfJptgjV
 85w9tFbzHrjtBM9cWtO+bEtuOoOMFqiDzV1mEhKaf3v08XIO3g6RzJFPad7JVaeN1ate
 S2Ywa9fDX+qNsMTYIMJuwMgpJIX7fqPXMbCTDn1f58xNlBq0GMIL1yg586kg7AGEObm5
 aQBA7EEFU5o4XYN3CKffMf8a5WR4S4XakIdSx01TM7SX0OpgzFVZVBEc7BP4WDDdOBFg
 nNhHHkfyxm1ox2r6JnnlcvTUgYHY/v9MNft8pTe2opRDGIAZ4OJy02GRWfMDsgokWcfb
 VcxA==
X-Gm-Message-State: AOJu0YwIJznIWM12TX303n2aNMS9oLDsJjX8Z2npNt1QX83DqxtS4A8W
 4iOFM0y3T17dxK/cS1oljA1Ahg0Hd/KIwXrqhoUCkeZhL+VMRt5gm4CbTY4Qpg==
X-Gm-Gg: ASbGncsQ4o4KFPp05418mnmjw9Mwa81G/JUy4OUlcCWWkORwTn2r5AV8YHEmBD2ipNW
 0Tv8uOiqbFf8RwVIl/Cq6SZc5f+qoYpl+v4q7mT2YiQuKwgT0SL17AQORHDWczqitm2IcRCK08D
 625OQX6WfVKN8su74m0nXpK5Vf7DMn8yDqHmqwMNjdiFMXb5IBT/WYFQieD+adBXhs5hPKCLeiX
 cFP7R4AaeJloucqa320YcXb2U5H2si5vmsmZUJb3H4xXDpWcDMHPBCmymjhYFJ4+fMvsNmCFyk0
 CLtqRar41LTSYcM6Gaw0RzrVPTQs4umjVrQQx1jIZkTaQOSkQz6Tz4TsQi9dd8zbE8AqumkKpWF
 Fp+4gJM/9TszffkUShJC3jKWCTRd7Ei43FmcivgL26rOamf0x4S0tRN5cFz+b9r4D+Lh5cg==
X-Google-Smtp-Source: AGHT+IHPJo5J5uA4iBfucCO9r9J1O+Ca5xQbsbgXD6WjnopsyEYVl5JhTwMo2UzLtgSLMALU23zpVA==
X-Received: by 2002:ac8:5acb:0:b0:4ab:722e:3b54 with SMTP id
 d75a77b69052e-4abb2caf206mr72409161cf.18.1752898752289; 
 Fri, 18 Jul 2025 21:19:12 -0700 (PDT)
Received: from pravin-HP-Z840.. (ool-944c2daf.dyn.optonline.net.
 [148.76.45.175]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb49a95c9sm15609061cf.27.2025.07.18.21.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 21:19:12 -0700 (PDT)
From: Pravin Pathak <pravinpathakdev@gmail.com>
X-Google-Original-From: Pravin Pathak <pravin.pathak.dev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1] mailmap: add new email to DPDK
Date: Sat, 19 Jul 2025 00:19:09 -0400
Message-ID: <20250719041909.39192-1-pravin.pathak.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714191141.1243467-1-pravin.pathak@intel.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Jul 2025 17:00:19 +0200
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

Adding new mail for DPDK contribution

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..1c5c367f6c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1240,7 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
-Pravin Pathak <pravin.pathak@intel.com>
+Pravin Pathak <pravin.pathak.dev@gmail.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

