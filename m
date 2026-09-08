Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B3C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF7D40F35;
	Tue,  8 Sep 2026 18:55:12 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id B41E240E31
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:55:10 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-862815e2683so3261095b3a.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788886510;
 x=1789491310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ph/v7DKWYUI91pyTEIRSeilHJknbK0jpE/heJnEsryo=;
 b=LuO8AftAc0xpOIzo9G13MVXZvWr50UD2XTwjw1VDa8tA1x/HbXk7hfF6BUZxylQk2v
 /N9fJDe887X4ZxDqQw+y9MVuZs1PldMV6HB8Ezac0UyG+lHrYb+UMSHENBt2Sz5XFmv3
 U0X2+NT670juCftB6Tbf7LQxNVEcgllIfk1eWm+c8FXHb5iDZIw/eZiL5/p6aZoIcfZ5
 0aOPKFcM0+SufzAtepn35CFnFfSKkogrFJRMoUikIJJ0vY1CtzFvKdsOJ7vwh/MAcTnd
 izwdTw1NTsMruZUv69AaNf2gKtKCth2nD5Tj9JbuxBZ9mpd8o+1yxY+o/IEUsBOC9WlC
 dagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788886510; x=1789491310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ph/v7DKWYUI91pyTEIRSeilHJknbK0jpE/heJnEsryo=;
 b=gg4qssdzk6yDjSRDOZTt0P8XH6S+QL0bIzUXJ9zOSz3GYvmWZwVNwW4/4vMQPzUGhe
 KXnmiosb0AfF7q4Y3nv2Vb8vcwqx+SzAAumu6VVeAqciJrJet0+Yf8zwylBO5y4AW1/b
 RQvybV1/+9Cc7bugGMenu2q93O+A3W3p9pw/dYkdEisbJfYpKs7gZPw6tlAG9AUiFJew
 FDcyikckn95aL07Yt46r+VzeGDmkt/+ifDdCL6yQu+2CMi2XDEq8y75yHxhrBq6F4utQ
 s6xsFnrThvnsWmEeyuSU9SJHDcdENJEn5nf7MZC+Ljwqc15sZGsGLkVxzxOsdfYMJncP
 NT1g==
X-Gm-Message-State: AFuF++lLPXInHXmy2eWI+98ojm36fTY3UG4IVz2CMJU2ojLAweNZsBB/
 XbeCnLmW9+GXsVy/G+g1o6cVfgxivkEHnmt2Hb2NG5R078qrpeEhdRaPuS9IwzbljDxHSMvsD3E
 EyoY1
X-Gm-Gg: AYBFou2Kln/RBbnitqZUi676lYIfz2kT6R/96NEdPdHTLniXBFXfg3IhBVgzR3cxRIg
 fv0G3PPq53sDD0k99CrsCpIOXhdypKov4OWF2xAJFdqmTomKdayC+6mIVQaINtZbbIPyuhogpth
 +ZCnXNilIoYkg7GFcSKPiOEwz9kKAwa6Nf+9x0L9BjcrHu3UPtOf7RDQuTnfsFYyl3blORT2zUx
 3n6PjFicBKtEV2bnEL43brawtt07TKer+NF+zP/rfVKOMNqd1zIZKciBGVw6yyJ+GkZp1HkGWA9
 EMUUDV3y0QDjUmKShIJ2zAmxguEwHyLMa3OL/l71ORCGDy19uHQxO0Y/6HlTS+I2K8KwEq7oAWS
 1l3vV+nRavGfEQoEpCuqIBIGgCctovBKynuPqtlUpLjppQFiFHV1nfJr15rXJzvVBgw83TL4dGi
 dcztPwUjCav/3prR2yTu0uEsygEoSaVnEfPJRSk1guTI71IkoOLKoRv8pnG+GYlHnV94pBnWNdd
 oMse1B0QyJ+PbgCAAGfGs34sDQ=
X-Received: by 2002:a05:6a00:13aa:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-86168e88261mr37847347b3a.17.1788886509844; 
 Tue, 08 Sep 2026 09:55:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86207a4d602sm5096741b3a.22.2026.09.08.09.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:55:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v2 3/3] test/power: fix nominal frequency check with amd-pstate
Date: Tue,  8 Sep 2026 09:52:34 -0700
Message-ID: <20260908165447.450006-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908165447.450006-1-stephen@networkplumber.org>
References: <20260328193419.106100-1-stephen@networkplumber.org>
 <20260908165447.450006-1-stephen@networkplumber.org>
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

The turbo test checks that the core runs at frequency index 1 after
scaling up with turbo disabled. That index is only nominal for
acpi-cpufreq; amd-pstate spreads its buckets between scaling_min_freq
and scaling_max_freq, putting nominal at index 47 on a Ryzen 9 7945HX.
Use the index reported by rte_power_get_freq() instead.

Fixes: 1ed04d33cf19 ("power: support amd-pstate cpufreq driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_power_cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 08bce4c0d1..1f79b80e6f 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -486,8 +486,9 @@ check_power_turbo(void)
 		return -1;
 	}
 
-	/* Check the current frequency */
-	ret = check_cur_freq(TEST_POWER_LCORE_ID, 1, false);
+	/* Nominal frequency is not at a fixed index in the table. */
+	ret = check_cur_freq(TEST_POWER_LCORE_ID,
+			rte_power_get_freq(TEST_POWER_LCORE_ID), false);
 	if (ret < 0)
 		return -1;
 
-- 
2.53.0

