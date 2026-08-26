Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB18C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E86AA4068E;
	Wed, 26 Aug 2026 04:01:55 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5569F4065A
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:53 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d710632717so1204315ad.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709712;
 x=1788314512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0JUrKDVy9AweR6vFrHzR7uEPz74qGBB2DUbvLiNFhc=;
 b=jBqe6zs08CcBQYPYearEd1JVc2Zcgbw+wQ+uuPxIbDGrvXnx27g3Ig683jaJGijE+x
 Nimec6acRiRqY7iyMOiTLabcmBQEi9d/9TIDiBP8v/UIRyZ/OJdsBCfzo1LGnjdd21MO
 bRb1OEL4l6osE/t/TYEIq2Ve9FWJEg0v2ShcL2ywu/32BNeD3xEUOGVPDSEYCzCMZnsb
 golVb9Fwje71m5Z4FJEmhrQrCdku7ckjveKvjR7zZDxLUWpO/5DjwKhaJKvOUP6Capmn
 wweJQqvHOEIiGblMrdLi6sXMY4zZDJpZbV8HJcCJfG+ZmAgHw+ORxcS0DmUhB/rALFs6
 9/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709712; x=1788314512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0JUrKDVy9AweR6vFrHzR7uEPz74qGBB2DUbvLiNFhc=;
 b=Yxz0gq9f6fE+mAHXGrfZhGNsi+MXI4glm70pRJ7H4nwyd+QFuu72ldYq6aeRfqJS6F
 D0P07gpqH0bY7HoGjEn2dKSX7EpmdKxaDw0tsvFpE6P1NCU2Fdqzao/4uFw7CqpnwmLH
 CMen+UHbCtnUdG84QkJsltJySUtxaFTdVG7OVo5/M1J3UGMILb3G9/9ZTcIc159Xq3ha
 P2ZXerbsU3nUMvmXRCx5Z5HtSFCDRi4zUcGxJexu9Xc0OSM4S+3xVqFOPAFKL+AuZj18
 pyJYUd8nsWuZOmK5TY/pHTuGS/0Wxu3954EhtEMtjMPdK+LqE2ISIskYJzY7JAmVEfQZ
 03sg==
X-Gm-Message-State: AFuF++mUKWuuNAg4I6BgJ2FpV1nrQQj2fmukI8rdA4mfWbbMUOl6bXpY
 JFiv4CxTb8VSSxaJAc4htKgg0MSge5+2VNOVx/kzE0UEtElITFhh4UK2DoyZOlMQNUE5GeG9h4S
 XFjPMM6o=
X-Gm-Gg: AR+sD11Sm0a6V7WBxBbCqjDEcPKHN/mucctA7kdR9dwW4c48xIzlyDQG22iHIawek9u
 U4M6dBkTARsT0saN2/du5j8qttrqEylYj2xG8QH9q29wwk7E6vxdNNhywXc9hfiVaucgWJopAFz
 HBspNqPTwfrbx/La7Dlnn45o+YoGLq42QcLHuOOsUn1XkRTNBRa3zeo2U9KFeNOfuGnyQUX3+p0
 hope5Wx1ST2VGaTmS/azaxfqxNDi1yOBbiRybGn9rkmk3sU2X8+GXCa5Z5u8WUjYCmSo2rsHdVl
 W/jE72sfkb0VVUrw7SvaKR3cqmmpUmoyHpO61wRbepi1ko2oahv3kaolMqJACOGJC41nu0G8WWv
 wi+kSN1cA6Zy1HzeRSUnU1/mRuIs2vsZvM9VPO6aTMtv5Gw9ktx6aC+JiE92rbhiPzeLTFtdriT
 rHDSKcwOMCU+s0zupisrsvJL94iIteG8sYAsdBkWnTqQ4mUPUdE3JxMi9XWaSMrmmAUx55SbKiy
 vLoiNfCXJpY2+68G9I5w7w876M=
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-3966d83231cmr7343828a91.13.1787709712300; 
 Tue, 25 Aug 2026 19:01:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 4/5] app/test/test_pmd_perf: skip if no device available
Date: Tue, 25 Aug 2026 18:56:46 -0700
Message-ID: <20260826020133.2644805-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826020133.2644805-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
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

Rather than exiting with FAILURE the test should exit
with SKIPPED status if it can't find a device to attach to.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20..8eff0a1223 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -691,7 +691,7 @@ test_pmd_perf(void)
 	if (nb_ports < NB_ETHPORTS_USED) {
 		printf("At least %u port(s) used for perf. test\n",
 		       NB_ETHPORTS_USED);
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	nb_lcores = rte_lcore_count();
-- 
2.53.0

