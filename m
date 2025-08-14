Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABD3F427B5;
	Thu, 14 Aug 2025 18:53:24 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 2237D427C5
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:23 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9e413a219so899032f8f.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190403;
 x=1755795203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOXgNgYjowDSirKcLph07+FECQ4lcDSBMGLHnhZoaT4=;
 b=HL5PXf5XW8XEHfuY12debWI491hLfV6ROQy8z3CDGDbjuvgIZjpn3Hf9pRmjGPmzjo
 AHBeNSf3SBJiu1poCFjELyqFmh3Jh35O1cGd8H5DrOfSon1VrkxvuVHhC8WkbfFj+99U
 byQsDeR9gK+uwPI0t8RXm3YitU2QabvValhKlgIDogfbKwzC1V7InHOj1TXTJiY675FY
 SpwD7Evte/e9g1Urzio2Pc1Ri11ybUzd+Rs69IVVFB51Rb5lqzYMEu+bLWxkf9K8ZhVG
 Lf1ij1mbt21UwPS3TcwVOKPyP1YkWSqbJ60xSXCqx1ooA5Exj8af1HXCZbxxDgGzaXbP
 Ldtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190403; x=1755795203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOXgNgYjowDSirKcLph07+FECQ4lcDSBMGLHnhZoaT4=;
 b=VsUIdtnO4n5F9Xh6eLPFNGxDqmwMuIql/tQK2rfQmJahIQcLwl0yUi533846v1kPtx
 ngP0skINvI8fkgUr4xAyjFqHRau2DhwAvv2yqZG7vtvrXPlJYW3zByHgwTO4s1Injy+u
 7116OIj4C0TndQXFjoih0ii9pdZzsph42xVGaLx7iTZ3IMDNaZKvWDOgo7u5xwxXxC6D
 TH0kJXkWtpbpP9WAzzMm5i3oSewnXYUbbAj6klrOzHiZOBcTDHT7m2W+wr+KaBCNGlbQ
 w8iBPAGuW8oB2miQsR8PzpBUQGKedTEiudWTgB5oy5e6/gBmk+c187UnNUQfeHb53uy+
 QmDQ==
X-Gm-Message-State: AOJu0YzawjfFV0QHCuotfFD8Tmuv+cY9kQEo0HJxJWI+lwyIlbSbp/cq
 Kbz8w2/8Ec0EjTSZVzIUYfHmZrmk52Bz18tU8VyI20R/fprLLlv6Uwht7zpeqMYBSWKe6QEGK9W
 F599Y
X-Gm-Gg: ASbGncuI4QuGCt92R53iL8GB59d6DHVAq0h1EBBkyiYMyWqH7MtFXE1rXn+/xRL0ade
 oY4Y56SOUOsi/ypdlSCBXUWNFaQrQMTsD5P4T2ZOat7+gUTAl0/e8gZbEExJ5BpSoqw/xpdZu9m
 kUwU6KHFdlUtPAr4SCtASfZoSNXjbzmDfydysIeiQuYPPu+OkVhGhvQxLwiHzcKRCrJgZ+hYUd4
 nbO66JB5gxOQ5PToe1cE60jh/ZFl3IbDu/4jU1Nr/NZBHv7Dpi11icdlAx9zpA2EbzyKRU2Cpo8
 aZU+WHWyQdphTutFEizjCQ0OQgGRJdSfkL+kzz8T7M1tmqmfEA23aQ19E+8JaGfGAX91VhY5LeZ
 DhwHZq75TC3eLuXM4OjPGPj5OI8diSDsnfcg5Po1s8bhPYlyBdsNd4PtN7xFPMDgjpZ/s9ZpV6x
 0j+2Edop8=
X-Google-Smtp-Source: AGHT+IHv8FEBS+wXTDP2GeS4+50kiplpXQkns4MXDq+dGdMrVDOMeRQ9dx8q//yWxT+RW1DwtVjzVA==
X-Received: by 2002:a05:6000:420f:b0:3b7:9617:c9d6 with SMTP id
 ffacd0b85a97d-3b9edf6634fmr3510280f8f.45.1755190402702; 
 Thu, 14 Aug 2025 09:53:22 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 5/8] pdump: handle pdump requests from primary
Date: Thu, 14 Aug 2025 09:53:01 -0700
Message-ID: <20250814165307.12786-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.47.2

