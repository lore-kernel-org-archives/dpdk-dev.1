Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A4C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:27:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8017240A84;
	Wed,  5 Feb 2025 17:25:52 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7ACB440A80
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:49 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21644aca3a0so10867545ad.3
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772749;
 x=1739377549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQRYIizkrRLYVmn/OQ7uW2ePgUly/NZ+Cx3EFIrhBxc=;
 b=P6Y4RzRa08kremGRQBGfoK7Xz3gaGpmVFT4HGQVoX33Ay0SDYYgHogKiPdOrqrrcC4
 YEZvFNKAkyb7XUFctITTYbADUIXGlZpsFuESD9fb6k8obHyhATrNNrxwnDTRdYXjeFlA
 JOO8UAZho9OpBRV5n223q9xrgMKZkEFmTRYId2O7rAsf5YU82h5mGnGjGZfcH4c+r2X/
 MkH2EykZ5Z3ibXkPvllyEEw0gGkNJTx0JL12JyqfvZv35ZYvlMSEUlUVftvueWR+vgKS
 PiTpkFV88LsiJOvhkXZDqmGXEMJqFPTW/eDzOPmu4TuoxIWCTbtkxDZpXKVzOBUNufjE
 Ek8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772749; x=1739377549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQRYIizkrRLYVmn/OQ7uW2ePgUly/NZ+Cx3EFIrhBxc=;
 b=BVJ5xvLnmpUuBGMErRJ6zPQVlQqpCcVDYVxwltkqxijprY5JSatNf8kE3bNDUKmQta
 Os96dQqcvuvsbPDxhWRyTYvplcjg/JVwfd/h0QdqKABjYO9eczp7F1KfdcAvLsBSwI7n
 ZR60Gx2pF8oP/PuwMdcK11SLMcqO3Zr9EFVDBOJXDzWpyz8Ji/9HVnvxV/GkKSC0Dzgy
 nxSkr4KIJZ1UYyagcBYQVN1TDM85+orBusN5n/ARKo+3uv/s8x8k0jTBwB11xDmqoamG
 yEB8D7H5MMncd8XACkZy257Kdc6w0mfT2njLzkUgE6j3tsXkVxQbz6h1C0zziKhCELkL
 RW0Q==
X-Gm-Message-State: AOJu0Yzg9DodVMjiOa+4xU89HmOGWoG21BqjeRbLtL7LxJSikIszineM
 +bRlSkNXf25jAGpTRd+dIu12H7jEblhPMsdFGvheaKIBCHJLptxyoeA34jZkh5hipCbCcFfc09f
 g
X-Gm-Gg: ASbGncs4pLxVlb7tfNE60x2KcyQmrimMAkNuaTr6NTt7KsqswPhVJo3dsqXOFpsMSJI
 nmRWLfT0aaH4JN1XaAQ0nmqHXHPV4PR6q5PLNmmukVN7pArIbYvJNJ4loWJICHKusib3ovmOw/8
 6xeMRO0HOqVbjEHsXJni0q+b8IT3G9bXNITLZ4PdCERQsPFeptZmxBaFDPDxw6I/fI9uu8DBCCc
 MFUr+M6IGFH+wvP/kacipeaxtHFM+3sXD/A0EbWnUIpAJqMd6Ico8ZtUhs12iRxFFhmF62c8MW4
 bYvxood5GpXCTFRnsAazkMVb07AQZFf0YafvZ/0sgm34RBwU185OWpPa7o2oLMYOX+4p
X-Google-Smtp-Source: AGHT+IHCp9NM+QtO/lmIIIXf2MsCj2fkSPxlowXeVqTX/m8RACuZ5K/gD7Lew7ZUufQ5sQkWYIh7TQ==
X-Received: by 2002:a17:902:e892:b0:215:4f3b:cb20 with SMTP id
 d9443c01a7336-21f17e2725dmr60438405ad.23.1738772748729; 
 Wed, 05 Feb 2025 08:25:48 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v3 18/19] examples/l3fwd: fix operator precedence bugs
Date: Wed,  5 Feb 2025 08:23:19 -0800
Message-ID: <20250205162448.161161-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The expression:

  if ((socketid = rte_lcore_to_socket_id(lcore) != 0) &&

gets evaluated as sockeid = (rte_lcore_to_socket_id(lcore) != 0)
which is not what was intended. This is goes all the way back
to first release.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l3fwd-power/main.c | 4 ++--
 examples/l3fwd/main.c       | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index d279e664b3..e27b8531b5 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -1412,8 +1412,8 @@ check_lcore_params(void)
 							"mask\n", lcore);
 			return -1;
 		}
-		if ((socketid = rte_lcore_to_socket_id(lcore) != 0) &&
-							(numa_on == 0)) {
+		socketid = rte_lcore_to_socket_id(lcore);
+		if (socketid != 0 && numa_on == 0) {
 			printf("warning: lcore %u is on socket %d with numa "
 						"off\n", lcore, socketid);
 		}
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 994b7dd8e5..ae3b4f6439 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -311,8 +311,9 @@ check_lcore_params(void)
 			printf("error: lcore %u is not enabled in lcore mask\n", lcore);
 			return -1;
 		}
-		if ((socketid = rte_lcore_to_socket_id(lcore) != 0) &&
-			(numa_on == 0)) {
+
+		socketid = rte_lcore_to_socket_id(lcore);
+		if (socketid != 0 && numa_on == 0) {
 			printf("warning: lcore %u is on socket %d with numa off\n",
 				lcore, socketid);
 		}
-- 
2.47.2

