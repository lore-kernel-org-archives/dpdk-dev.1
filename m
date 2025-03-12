Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881AC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73F6D40E28;
	Thu, 13 Mar 2025 00:27:54 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8E22940144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:51 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22435603572so6781565ad.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822071;
 x=1742426871; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yk1U95FtyLamwaEXGLA+dWGe7eHTmFO45ejQyYTkjKU=;
 b=EIUVwYkqvzFJBzVg/XyiOpiSRj70bWe5/HGwHFDlCDTMBUAoKj7/ZSVIDOgQdN2zIz
 wqhqgqhBonQY4VwJBP1ZBr/M3gGQ/rPIR18vAXZMMPyN8Ry+O1+tZMnP5ntOX5rTuFFX
 FSw0E7gC6M+Inp99CxE/6ytwxI3XI6Azu3t3AMtWDddyks60DMs27g7R2aFNGr+WC1/l
 r01VXzoZdcbOqOksWLhWCcXLpTIgHNt8lhCGVDaqsp0tePmW18eyhNI12oKhTAlSHGVN
 nKjT0dreuNgTwet4E+6ES3kABTpQ+8pubha41icBAXZSiyOpzs2VeJNchC2MqmmLW3s9
 5P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822071; x=1742426871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yk1U95FtyLamwaEXGLA+dWGe7eHTmFO45ejQyYTkjKU=;
 b=I3awwv3zo8ye5oL6T2c3S3t2XA57xK6gUD1m4VdfygE9gv2048Vq3lywmCpD18Rpq1
 oFqKcGuO+8f23Dhi5p7BSJpmlv2CcP+9MKoPsseysx4M8kTGA+svZhkKBl/egWwm1cTY
 UD9yPqKTrbpns9ZnylTjBcfJo3m631QjDzS+wAQfpFn+83TniBIYeNRKsO5EcQoNZRVX
 ZGQ3za7XpOrvcHKYxyR+97kEQrxY4wtcxICL4sTwv8bnreUcBT9Nc5i1ivch7kdJL39Q
 tefHPUrJOJm4vGx/1nzAGKs8nk6f0Z5vCzxs4StsRSgsN1cF+Fx9wzZ11TbadCYmNYhJ
 3lIQ==
X-Gm-Message-State: AOJu0YzFNK75oKZIoyO3RrVBKTgLnZ0Ppz7KNBIIj5fmmZhOxa7liEcq
 lCM2lAR6ulTGV8CiT6kLjde+2pHf/MVOoyDKWeXhF9LzkbCJBkfTUU+Vhv+QJuplZLeYuEaxwFd
 T
X-Gm-Gg: ASbGncuj9PhgBhw80ShK+txSU5zmcTTVkNHUPn0dcSH81x5jioRbyUQ4To1bjim/LS5
 GnXViCrNgraQJnlSwb2IEdY6rkxeMIhL/PjqiPNrbMAJ6x7ZGDq+fZauMytvVRY1D+TplLuhEpA
 e6Ucrompz4fhlDX0aJAN83XVK6uxkgC2a+TvapJnTYx5RwcpLBMpVO8nzCG6zEAozeM8zmW0W4h
 Lmf2Z7GYEKYBz1tvxGNK2T6oqMBZeQzzT7JQneDF9U5rFe8sQi24NM8pissYP9gsaC5FDG7UCSX
 xP6fO27z4cbWNtxwV2HPGwKCYxwWnYjNn2msKRDFQuA0ardppxSqfoEVN88QafZN63wwrXbCQzx
 HSA2G4EBTffV0KxX6GiMBYQ==
X-Google-Smtp-Source: AGHT+IGQJuNYk18bcRzdZxT72iG59ArmYm/u+Z/v7dJie4ScHmDrccy5vMI3qxDoUbPtrQrbUXwPdw==
X-Received: by 2002:a05:6a20:2d14:b0:1f5:80eb:846d with SMTP id
 adf61e73a8af0-1f580eb8d82mr19124283637.10.1741822070783; 
 Wed, 12 Mar 2025 16:27:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 2/7] ipsec: replace unnecessary comma operator
Date: Wed, 12 Mar 2025 16:26:59 -0700
Message-ID: <20250312232739.228295-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ipsec/misc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
index fd4d3f5256..54dc5c2d4d 100644
--- a/lib/ipsec/misc.h
+++ b/lib/ipsec/misc.h
@@ -126,7 +126,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
 
 	const uint32_t vnum = RTE_DIM(vec);
 
-	j = 0, n = 0;
+	j = 0;
+	n = 0;
 	vofs = 0;
 	for (i = 0; i != num; i++) {
 
-- 
2.47.2

