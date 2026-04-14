Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BECF9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A5C40669;
	Tue, 14 Apr 2026 18:10:20 +0200 (CEST)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53]) by mails.dpdk.org (Postfix) with ESMTP id 21D9240653
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:19 +0200 (CEST)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso4058948fac.2
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183018;
 x=1776787818; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=Qli64/eeGjtEu0Nb2O7qwBiqqw6Wvmk+QTh0mAQ5+HiOITJl8gi+UiS0FTJCPABy4V
 WAIKy1fYInB6zoYn10Vh29be/9f0CzPNge6HHmOgzf0eQ78wkiyHDlQ0a4iCxHLPlE8L
 l8SfIflbDR+sooD5fNxTzQkQStMCMA0A1vsmQAXq8xe+/8HOX+9g2Jw3NVFDKvlsxQm0
 YvF0VSoIvC9Fcuax1V9ZAc1w1aFDuabAvQtan+CSjYV7tvT9pfvq7Z/5gmGuQkv6W6Ll
 JP1cdXPw5iVVan7kn/vCj7HH7YWo7rYfCL8MlWyH8iGLe4S0astbsBtjvwL4GRgquyv6
 GxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183018; x=1776787818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=GU9jLeY2KbU24iWqSqOBF75R18tzr+LYyCG0X3iM4LneU+bNBx4oYKSRvtgKytYpyt
 Kp79K+jKf/jvaS0O2Vqlo7oKvMuEHJeKTi6MsVd2oN6WDoOOFDCqxutJ7Jb2MGydRRgt
 isaWPkebj47H/aXS4l15VOuQ6jRiaHCeNdKiBTC/TqqzfZk326FPkubhRHD14ChWm/oB
 WtC+GrTLoz8+MsNUvxuTtEIPtfy6TtrRLIbh/DFSl2j1U2aJVzeLov3q3gtSkbd+43Hh
 ur98qytbb29am6G9QgyLKss8Die7YIHLrsO4Ef/2iCcztLeHdTU2S3opfhAaVQg5kmNc
 WJwQ==
X-Gm-Message-State: AOJu0YweRBRJLRT5kVlG/Lxvsp5IG6zWxBbRxEi0lTvOoKXvYJXNN5sY
 9vLCJmkL3ZEAQ+4vp/uyiFbbhsR1h8bUMvQ1HfSuoTQRC2XDnrw5U1AofVOgyP8SxWOOgpRvW5Q
 bajkN
X-Gm-Gg: AeBDievoNEYfrorc5JodjKU5qVeN/NpVF9ZIqDc8G0lt0XAvIvnvAautIUvxBtA/AiM
 ko/TGSPH096D+3q7JZfNL+bqtgLMSma+vNyPbQXLE4RF18CPlQCtq0x8AkOJqNGZR5cu3xU4MD+
 3vSTmmaUSe35WzZfxZqAca/dEXO2eSVX7PQnALIfNWAQmGa5Rl5+p5nKo9fj7xrssfFaTps/e8c
 1TB4P4yWmOib5bfY6iNt+5+x47uj9Yg8CrOBZS+l+hnLM5eHYi12Jwrg9HqZPDUd2xPyVPS6H8U
 4rxpS77NyNWZ/Q6tfJjn67fmhuOCr31CdxOa7hsBBj/KuGxM2Ekt1DczQsVQicNYWgWynjRfY84
 UierA963ZbHo2v4hmLqZBAHUJiLJv6BB94Mvo4ufTapqgclqhJO0Dq5BmUrjBjx3RQlTJajPEYl
 huygsTeJFGJeWt5/KAyXSLhvQOgGmyTRuhtUz5cnHO3W8=
X-Received: by 2002:a05:6871:5209:b0:424:6bb7:7c71 with SMTP id
 586e51a60fabf-4246bb78b0fmr478337fac.25.1776183018108; 
 Tue, 14 Apr 2026 09:10:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 03/24] doc: update features for PCAP PMD
Date: Tue, 14 Apr 2026 09:07:54 -0700
Message-ID: <20260414161011.756101-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

