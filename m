Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41608C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 915DA402E9;
	Sat,  8 Feb 2025 21:31:57 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 24359402C9
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:31:56 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so28181505ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046715;
 x=1739651515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkBhSy0h4ES6aAexc3N5WwCGlqzptrFZxlS0DDRmmeU=;
 b=1pGVzB7x47HnmSsmRGPK36w3mGLM7QrI4il2qAcGeqD0FPPUqJBI2obsInAq88XCOi
 WFNhC3H4hasJEvuOaJ2o1ON+rksdCB69LAoZUq3CVmvUSdTzqElRYnFZtm1psh1k6Ke1
 /dFqr9pJ5YXqaMgo58UFF23QplfPHDbF2JiMhyp0IZD1Ar1wFPli9+VD89e7cv9lCNZi
 jjf4ekGgbzXtFqXSGok7Uk3Hb4KqUKuSXV4KNDyAQOAMHeNwQtTzrcqz3Ad1zeAdRTJB
 /SCkN+PNXhhelc7wMbAt0fbKyGbodA3KNJawKINo7ZQUh5+LHKpB/vuz/PnoC985/Zrw
 OHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046715; x=1739651515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkBhSy0h4ES6aAexc3N5WwCGlqzptrFZxlS0DDRmmeU=;
 b=YRpfKtxWBKoNs8PSG28h66WN+4ZIOb/cYwre6WeJ6pfdoCImT/l7GzdMwhOHNStj7P
 XOaalhuKQ/CKDSrckgcOs/5JQG5DXZo0tSPIpVHFLtW72jp/RN31EdN6IY91VcBCwL7C
 BMaRKxuqAd/OKBUgzCpFw061r7sA164klAPfD+mgMGcJZ1ABOoO4RWFGkrrddk7YXOk9
 M1iVKRu1gPDhaT4j8ZJ/WLDsqy6vapoLTRb3HSj/H8P1NH5b7m71tXbvdPz0qOzWfs+x
 12rX0+uabnZLho+B9KENckwerLm1IekiQvuBZcKoR6F7QdgZVOl5bZ9zWTDCCjscLoQI
 smIg==
X-Gm-Message-State: AOJu0YxwpAbrqAjYaN5y3TbfvFt5sdoiiGTm6TE1CvbhQfs8c4znyzJM
 vC+ScJHxFp8lIfRVDrGhz5z3fdfe18zLjGefDhbTT086jPYBV7s4GhkEtG5G6xZWWjYJ1vm+C8P
 Vnow=
X-Gm-Gg: ASbGncudJq+9Qu6gINIkf02LqSM6/SFNxeTI3WPfs0pqsPXIoNhWiT91Bkv8oRZUCdI
 1QPX7HQOoWIHyV6sH5YfVmSEe9hzQsv2bAXLLeRdPI+ZXouLXQTJvjzEt7Aagk/f9yg9pqqqahC
 rDurVBe56urY+Dar5qgudO/SrVGmVm/OUbiTH5P1tUxIJAcBf3D9bl4NOgCAWmrmCN7bGpnL5bo
 aUqYDhAXMGInHXTuAi4/8cqXOMLSUl4YDmg6mShfHuNMouHNznpRZ6IIGVYIsg+LniltiLh1aoJ
 7/Yk4PwJlieMDt0NX7s4jqJo+gVil6HK0zW8iab6NC/llti+/pqkTCF+YT8QdVQoCzES
X-Google-Smtp-Source: AGHT+IE01daW9YfEjFwrvq0/DSuB79Hvk5mJk7DoCQKvNRGJ7U/aKLciIHbHrQusyIa6Hwef5Of9sQ==
X-Received: by 2002:a05:6a00:c86:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-7305d44a459mr12907946b3a.6.1739046715264; 
 Sat, 08 Feb 2025 12:31:55 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 02/32] app/testpmd: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:21:54 -0800
Message-ID: <20250208203142.242284-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index e1720e54d7..9a2cd86821 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13934,7 +13934,7 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 			fprintf(stderr, "Error - Not supported action\n");
 			return;
 		}
-		rte_memcpy(data, action, sizeof(struct rte_flow_action));
+		*data = *action;
 		data++;
 	}
 }
-- 
2.47.2

