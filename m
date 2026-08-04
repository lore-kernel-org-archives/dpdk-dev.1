Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D93BC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 004ED40B92;
	Tue,  4 Aug 2026 17:46:10 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id EE340406A2
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:08 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so4175390a12.3
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858368;
 x=1786463168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=rzQNYTfBZsL5SfztiEeXfjrTXNZQpuIQHFSai2HTJGhCUhURsABgNxSXFYnT1zb2C5
 fbo31REFEor5gniF4P60rFpNvXCTPGOxUfiN545u4doC4x4+uOoGp39CaBfvdiKJXo+c
 n7jHOSTuVKiGsufw3fLfxBcuWQW2dG7ODxW3zDoc2MHzXfnI1sPjfBXZZL/l4c+UU/sQ
 n3KVTVNU/hI9+YigXdHDu0QqjMqbXo43q31y2pTXztwrh0kkT6rnd8VCEkwFzeT0NbuO
 dCAE2Dsoqa3uyrKmYwcLRufyoz4i2IrsVIGkdTnMEZOZJ1JRUqXonaz5Brfal+KoIg2j
 Umig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858368; x=1786463168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=BjiYkXCmVf/cRHrAsiXoaeQloSkdVKz0I/lH5FpnMVI7wZUCNzLT2t1AW58tUTsUXw
 /5sg8LrlJrhXOHSoFVg9klybumMVcuGksVonDh8Sj5O4E2bj9zOmRzZnsZmKLxeIcJQ7
 KibSpNpvrXb+obkuXM55o75rvZoN90aUgitCcL93zf3V01Oiu9ApTVaRzhB2CG11jtPI
 9wDYFmtFVRb1KPyIzsLYwxhEVu54a3PtxP7FHSdxEIx8ABnAN2zrrWXVA7b1HcgbFqGv
 bdZ7e8eiB/ivpO2xx8HBQx2nRPVdsS7ni2dRS6Ph869hEbZNGbISBvkMItZB8Dcxuf3B
 yt9g==
X-Gm-Message-State: AOJu0Yxf83dWDOlUIy3S86egjiG/vMlTwZlqo6AmKPobLEJUi23obNnd
 kptmzjbKt6opndV85bwGxqidNOgTmn6OKVe8BGV2xqYh9wFNFYBl2nYLtIzESv+Yf3rYvZnff+x
 Jp8j6
X-Gm-Gg: AR+sD13eeQkO4+35WkBsQDGxCuLEwxyk+IAU7RVhgcQRuTdYmEjSK5/Vdt1U+oPfCd0
 F8m5PZq3tHLgZ/3WCSBtbLqObC8Ft+yUtigIRpmppy5a9AOCf9eXFQDC9ljVFyUjVpBAJn5Cukl
 o4D4lP7Txnfsoolli5hA9MN9G1j8pOQILsJI5pJuuvI/Fbp45v3is2GnhD3c0E3ffT0zDWDEAwd
 R5W0TC5Q1INAeOofHPTwuNP2oRnvEykuVuucUNKMonnXFvsxF6D0Ixninjn+H469nJ/5v49CDz1
 kVPIdtV2uWe2zGy8DJDX4AvKakoijNDc8z1xNMVuoPzktFX0R+IC2cauLRIBtJ6b7cHfIpIXPRa
 QcphI1O0Ctui69bxYsd6S+cY5PnyU/kXqMoe4i2q3d1oSzEv5UDRnvafpJoofjbvVxnrCxch51e
 CIIS0D+1HUVxWJYfc/l79XeSTaNfa+kAh2kITskTOVCu9eUsMPYXzuFw8NUFVM2XWDaOu7UqX8P
 wksOfb5qjr804j7APy5ABTDYLY=
X-Received: by 2002:a17:902:e945:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d0521eac85mr152871905ad.18.1785858366423; 
 Tue, 04 Aug 2026 08:46:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v3 09/23] crypto/dpaa_sec: include UDP header
Date: Tue,  4 Aug 2026 08:44:57 -0700
Message-ID: <20260804154549.148691-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

The driver was getting the UDP header definition indirectly via
rte_ethdev.h. That will change, so include the header directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa_sec/dpaa_sec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.h b/drivers/crypto/dpaa_sec/dpaa_sec.h
index d78cad818a..bce60d9cb8 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.h
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.h
@@ -7,6 +7,8 @@
 #ifndef _DPAA_SEC_H_
 #define _DPAA_SEC_H_
 
+#include <rte_udp.h>
+
 #define CRYPTODEV_NAME_DPAA_SEC_PMD	crypto_dpaa_sec
 /**< NXP DPAA - SEC PMD device name */
 
-- 
2.53.0

