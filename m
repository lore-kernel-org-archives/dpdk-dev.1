Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CEC02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94404066F;
	Wed,  5 Feb 2025 17:25:10 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 1122240649
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:06 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9c97af32eso2835001a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772705;
 x=1739377505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2P5RCKeZRHk7jkRn4otybzGL+FUsq+KHiovxUWGDHec=;
 b=ZMx4qoUtJM54K+Z9ucmdqfC4FNBiOVt8grmdQP6zhPkjGEjavNJgaokUxT89gIsRw7
 1qm+XyFXbCrvy8sbm8akNcKypPFbgPfP+CQVxvekCmScxWWDRhlEvykjNIXBDB3qLI1R
 Mhqi6BFMzy0tGMQ7+m/GoITJJzyU6aboPoxday3Ud472ty52YmzaWByVwhl7+jqe2fgE
 mY6GbdNAL+FAnuPkuFk5s6G9abd+kOmdpc5r48NYWMBSl+v6vp7J+kyA7DZJ9trUGS/C
 PvZuyNlxxDfpDImwPKp0K5OvtbCc+NzBcZ5fjQMv775ObLet+aN25cWUBfSGy+zq73yG
 hA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772705; x=1739377505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2P5RCKeZRHk7jkRn4otybzGL+FUsq+KHiovxUWGDHec=;
 b=KyErsZDpzq33iGXgtCKFHRcDcbR7gOAgzXliztHKRlxOYOrxOJYzODkBbk3+9jerIn
 KJHoeTGyWBGL4g6ROc86pOC9vgj5acKLkco0aiY1Jw3IK8UiraD7zk8xEwLG9vX/j/uR
 n/86vIXqY1/UbvRkwlsAJSvHmjREmC1WL+6B52KPOUCSbvuF9O6MUwoIyXXF19iDZnGi
 9ZQuPUP3flrPOBMst5EShTlWsTmGRkKX4BwkTelnOW4cTY1opfI9mkzyoQiNdl8d/KHz
 2yOqqQkAsOKExcTfKt87YPvSJlkpiFXNx7yMM/9PdnH98EpBjStqeqsglMH9iqC2HqiV
 0i/w==
X-Gm-Message-State: AOJu0Yz9yFWqiL0jDx8aXLy9pcCM67DdP6Enjunw6qPre9NtoMfPCJBF
 /zJ79m7C9kXfUErDu049G26gj/b6BoURnWYnT4V9tbjNK+a06rRXEdO8Ze/ji7unVZyIejhIn0x
 +
X-Gm-Gg: ASbGnctOaSyEL3brVvJb3Q50xO1axioyorQA9m/9GcWhg3Isn3kaVNrJillIqblzzCa
 fMCXzGUV7MQGSKzRLuMp1ACYZ9yGJ+yIgug14rhXtn2kvgCEQbV5UB9uisJUOV/ZeaQuj+B3Yqa
 hvBGDdDtYGF3nVG0bx5JqtVVxzjPY1cjRxiyYWtg3Edu0smWuW6d/3BfkNy+yR5VoSfFkgiu6Lj
 OjWVYzVwwhhIRfY/JIDGUz1eE9omCJ0s2SDAv6Nrv2x4jwWW9Xddi37sZ+GogVsbO8dUPzgpOCi
 er07PiS7o76QGH9eNM4j8lHLRnK2ISZqXOgHXoOS5nGUvvxAyDCBkkBnOpDzPjWXRyPa
X-Google-Smtp-Source: AGHT+IHUBfVgojk05hKsnLKT9TKXICYPb7zP76ukH1Y+FZ7XjR4JKxKyM4/5QSBAw7mFsFMfCttTQw==
X-Received: by 2002:a17:90b:2ec8:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2f9e076c07bmr5047954a91.13.1738772705095; 
 Wed, 05 Feb 2025 08:25:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, xuemingl@nvidia.com,
 stable@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v3 06/19] eal: fix out of bounds access in devargs
Date: Wed,  5 Feb 2025 08:23:07 -0800
Message-ID: <20250205162448.161161-7-stephen@networkplumber.org>
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

The code for parsing layers in devargs could reference past
the end of layers[] array on stack.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: 9a1a9e4a2ddd ("devargs: support path value with global device syntax")
Cc: xuemingl@nvidia.com
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_devargs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index a64805b268..dd857fc839 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -88,7 +88,7 @@ rte_devargs_layers_parse(struct rte_devargs *devargs,
 	s = devargs->data;
 
 	while (s != NULL) {
-		if (nblayer > RTE_DIM(layers)) {
+		if (nblayer >= RTE_DIM(layers)) {
 			ret = -E2BIG;
 			goto get_out;
 		}
-- 
2.47.2

