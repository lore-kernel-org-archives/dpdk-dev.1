Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F59CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 23:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74EB40E30;
	Thu, 16 Oct 2025 01:09:42 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 371EA40B9C
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:09:39 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-290a3a4c7ecso1447865ad.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760569778;
 x=1761174578; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZixP/lPBaW0y2bg92DdTv8IK9WqufSl/Uxn4oslfLfs=;
 b=OqFxusG75/qPGPwBAWwk7Hram6rwkxjaaGirKviej3pRC1fjO2jHdRIaT7aunJN+yu
 RJn8FTD27QVr+HZLa7obf3tVYm0CZpOimGyAkFaFy2bgjeVAGgqRRNrY+I0DkgjWEsJN
 KY1MPf8Gj49FLkhl9tmzopjuGVT+qvEXGnRbH/0EZ+KC0H3BOdhCbFXD4v8ATWnr7icj
 nO1llsouxRFIO52PgkJRNapDIf1o8ZFi00FZCp7Sua5rw65TyUq8/DcRhtrprBvGbbIr
 s1tFfa7LjWZuBXgxhTCUU4/cTpTNNPwlWPH6hyvX8qVspzsun5PKqaUtVkuK1Z/oYhoJ
 hkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569778; x=1761174578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZixP/lPBaW0y2bg92DdTv8IK9WqufSl/Uxn4oslfLfs=;
 b=YmiBdCfmMlFlCvPeNivBHeLwCSNnenN+XD6uQoXv4/iMNy02El7koPqe14c9737bXo
 aTcFMPuLS4NhjhfK8eJ+ab+SmcNw48Qq0YcbkTKXCCyhJAQBZdwmYckebi/Gj/EP1zn2
 WlKzYxjXdRKnMw4YuX/SuYh/s5KReYG2XTS23Gt1t5/ezATRI7EXIDLg9j+LIsbPLzrX
 lLc0Ae6JEid6MVXKmUOALssxpkW6DH/Z1SS+hDeUJ4L2/3ncyXXjIwmXZhPOy92/H67D
 UTwd2KojH52nTKq3Xqoh56e7k8gjEcHGci95iHitKbd3QL53LotQvJwBvLMih7wFjjYX
 HJjA==
X-Gm-Message-State: AOJu0YzCI+hv4ym/OZpSiNa9j/jc/ZWUFKlADRl9zvR2DlmlSQ5zxQam
 ZfdTQy2EXgHlmeEJMpMG8vsAk51QAedQZTscBmfdkz2ruiKEB1kwVDRhwOxoF/mU3bYcmvqNESs
 1fqaygf4=
X-Gm-Gg: ASbGncuu4fsftz+QC6O/5kWCtY4VrCAEkHnPz8cub2LasIahKY+oqRkoSy8WOSIcTRy
 cx35Pj8NDO56c73/q3a+0PZdvn7i6GoY9KxbIC3CvoPbzZGlE1yR1JQvvKxAVhtgAYvgCT0ZpWP
 CyB5o2v+es1lC4n7v3yE6odvjx7J518JjVj/Y2f0mRx3JHvZouyZhFB41KMVUErLAvs0/J5I2Nx
 eQvnr/5a8zTzHAra2vNIM0uRJoDFNVdFHBV3V5MCZdlf5PwlDPQdxC9QSXbuZawkc5mHBG50pdX
 JQdjpWYwa6ksPr1hUh/zEqsz9R/qSCuWAFtD/tr04i5NuGrLOcGuVGP3kBvR8CAtHxJmyCduA5B
 /SShjkP10tt+7Nz/T0xlHLcKLH06k1Vz8EW7/E4NYPExvw37CorboFkxJisveZctj6OTnOPp0//
 hb4QVgVoUvC+OED9uZxgCYpHqKhLqexGGJVtrq/cBdw8DPEtLTtg==
X-Google-Smtp-Source: AGHT+IFkaX8tZcONhup6rFuI9PSot1Sq1xdRQYdWPVJx5xwh67MmMQEFC4g8/jhjcxGkK6jRe5omcA==
X-Received: by 2002:a17:903:2f45:b0:27e:f1d1:74e0 with SMTP id
 d9443c01a7336-290272b2bd5mr391546825ad.17.1760569778262; 
 Wed, 15 Oct 2025 16:09:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7de45sm7600155ad.54.2025.10.15.16.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:09:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFT 2/3] net/dpaa2: make local array static
Date: Wed, 15 Oct 2025 16:07:38 -0700
Message-ID: <20251015230933.875860-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015230933.875860-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
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

The table wriop_bytecode can be static to avoid name conflicts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_sparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
index 0b3e9f1920..6c3e6eb573 100644
--- a/drivers/net/dpaa2/dpaa2_sparser.c
+++ b/drivers/net/dpaa2/dpaa2_sparser.c
@@ -23,7 +23,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
-uint8_t wriop_bytecode[] = {
+static uint8_t wriop_bytecode[] = {
 	0x00, 0x04, 0x29, 0x42, 0x03, 0xe0, 0x12, 0x00, 0x29, 0x02,
 	0x18, 0x00, 0x87, 0x3c, 0x00, 0x02, 0x18, 0x00, 0x00, 0x00
 };
-- 
2.47.3

