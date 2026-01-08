Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EE1D1D495
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 20:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7964C402A7;
	Thu,  8 Jan 2026 21:44:54 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 16EEF4027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 21:44:54 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso600691066b.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767905093;
 x=1768509893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pz25hza01McXqvop3z+tNO9MTRzB6KnJEoiONHSD60c=;
 b=haXfAv15/gYQm89wmu4D6X3hvwVGwpVhrneU2qn0x7M0dgEsySUsifNqMXDVROV+nn
 3UR8ew8OTQX0uizbQeC9bEGNo5BAmjgoeSiPMgx2Woom4UAxl2A2uKdj7xqBMuNK6haZ
 /s3xUTJW4cZj6pb04qGeUqxyZJnQwBS8pm0jQ+qT29/lxSNZtfqMsSJy/77q8K0EHCWQ
 eMpZvDpHArmixVCPww9gG8ncSk7A5xC2dJCgoJlS55lbe+gRMnW4HGH2C0lVc698sMg9
 lHZhQql5Kj/bjrNF2R2mg4sW1aPDsA1B3fl+oMdQP9tKZo3yn5IJwNZ3fVeKIxZE88qW
 NgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905094; x=1768509894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pz25hza01McXqvop3z+tNO9MTRzB6KnJEoiONHSD60c=;
 b=b2m5NO90KeZ3tXXQnk7onmdy+uzzmN51nhVttyt8n0SfU+aCcBAnyD+bJxNTm3f6wf
 9xq1f1roXf/hnlxpqbO4gD2oNc5uT+0HzlPae3EP+LbfZSmA/aB8pCesSga9fUgjl1PV
 E+dz+Ylv3PnYGnXtJnx8wvKPAUo1tqEfRNSdRS3687Qk5fTPO4CKgIp7MhU4CCh9OA54
 QdxHhMlyL9B5Qx+C6D4voGaBKhPkEm2WTjeys8sLX1p+N1HPoFaZNfNsQl5ljwizpyOm
 bWieNH7pZjO7Jw7bMn+uiwtTFbMKi+EiJyqIKwnR5UYSkRN7/8ItHNyE/77O7L32OBJk
 QiTg==
X-Gm-Message-State: AOJu0Yy2936d46i1sisNSsiFucGXMiTG1ILDXhWE0rchQzZPsCjRjAyH
 kPONP51fbUjBhp+ZBJd3KtBRzmafImFQKEfaMtE+v2OnMPSVnp0eYt9sFn6OjvR7M+dJDPL/8Z9
 nCf26
X-Gm-Gg: AY/fxX4C4B3v7uSoEjacWUspAAgia6e46r6e1SIBUTVEBmpgRTfIw14Kw+t8o4Mhud0
 RHYy1Dkti0KbL+H8m4rmth/BDfnGsh2w5Bz5ongGEDcv+1hL9Gc8gJdFZzyHcz6vYYnF2Z8LupK
 oGoN7R3cl/bv1d3QUR8Ia78Qq0lTyzIYSG8TDoXyR/EZ5CmEygSEMD/kmcd2QZtjAR/J0BRtst/
 lU3M/wKopVp9r4FkLeO8vIoBbor65O0oanvpBYz9iki2KYGE883+pG9cd9Z//GgTEUzBcBIk5zw
 igIX1TiyECd85n2SN4yekt/E/dhdcnxYxruhKS307O9K1CQgTFxH3lzITOJE0JlSaL7vur0hhDw
 rsYmoE86w29KVi2vRZ48ZFbj3FjvuJK1U2JUdYQgguUDJGzdC6wHeNuMBRJYXRTz2RDcHNIDaJG
 UmfpTFxOaDyldaWmUk9rQkbdEaI8D6xIJZ2E7XJoW07o6SIPWuNA==
X-Google-Smtp-Source: AGHT+IFj1WBiUPkVgrFG1SSoyISXyoeS4GGyyHw+wwC38suy1jM+JWdkEyRKJJXPGZlBejkYKxi8pA==
X-Received: by 2002:a17:906:f5a9:b0:b84:1fcb:ff84 with SMTP id
 a640c23a62f3a-b844517a23fmr775230166b.59.1767905093588; 
 Thu, 08 Jan 2026 12:44:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56962esm921348766b.66.2026.01.08.12.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:44:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/3] test: new test for null PMD
Date: Thu,  8 Jan 2026 12:40:45 -0800
Message-ID: <20260108204449.176087-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series adds small optimization to net/null and
adds a unit test for null PMD

v3 - review feedback
   - generalize packet generator to handle bigger frames
   - add test for lockless Tx

Stephen Hemminger (3):
  net/null: cleanup info_get
  test: allow larger packet sizes
  test: add a test for null PMD

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  30 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 968 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   |   9 +-
 5 files changed, 993 insertions(+), 19 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

