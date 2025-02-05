Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65813C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B5584060B;
	Wed,  5 Feb 2025 17:25:05 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 67332402E1
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:02 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2f9cb23d22cso2915767a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772701;
 x=1739377501; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W95WOP/8RCXxUi+KRMAjzCq/I0S+IPBFDVd0PU8v19E=;
 b=YVjF5+rM45W3wKNxQRbQiK+Dj5SJHRSFFRdt/iuC94o2VEykt3B+GXm/FZmX6f7zql
 p9X8cbmcwW20kc1/CSOJZ2XaF7HogBAuTEziEaZ6NzzEKllMfIkUhcU+i85buTPhCkKp
 YWo5eJZsnxsat+3eYfmS/E6Vr+tgqx3eBeePm1cm3tWJ5QYoB/nG+FQ89Ok0GL3c675Q
 CnBHJ02EOxneInmLJBUCA0J0ObTmm60NTy7CWsFtodfhHH2a6AZ4n1h5dI9t9qTTeymU
 xVhR+zGwd51i60uUiz7rvp4MhK8YAoDGXulByQMoyMIJ6LpzSnamsJmwQfX1hvfWlZPn
 fzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772701; x=1739377501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W95WOP/8RCXxUi+KRMAjzCq/I0S+IPBFDVd0PU8v19E=;
 b=eDu8Yc+X2hmF85/NO10t3e+jcDLQf4qN2iGkLcffFzFcWhtAj5nEbFL4shIZRIR+iU
 7yRVYkLhERGVAUztXBgizQ2+alQw9v5w5jZy6DFntwWAx452EoBPo0xVIAS6MBnhmE3X
 2Mc620vKnXZwkKWNjaTyak4FJFO4zWcIb0MqS5p4H7Xg62U5bqQ6/cKQoZPOz0F1jKEt
 mAQTwXfchaZf8x6+9VgsEqzJItx/SGiiwO2qT5FGwQ+143C63L31eywHJG3LbE2KaJ4D
 K6qDRxxe4FlyqV5OTYSRNOjfFfrKNc0FrjY+0mlCd88qy5Undd2wmTvzkk6mC5FQ0BHZ
 EQuQ==
X-Gm-Message-State: AOJu0Yy4abBACI33hKPOZl4kUfWXM6LfiuFvJoQYCuGPsW7QBxXVbDQy
 jwdN5mRQ56VTx7rfaj1ywctf2w301QIKT15uvymJbr5RYmZlSwe7FoVRsE0g28DEuHvS2hhSWBk
 4
X-Gm-Gg: ASbGncs8WjB0GMGXXpVCB3I9XVDsCdO2DgNx9UHhzjuGPv2KN2EpgIFk92z24BGvv6o
 lXTNQPaYKxjDuW7kCsKLEUEaYUIfngdxPTxUnFjN6toiMpfszvR7kB4/yB7OIu8OXZ8O/zRhLv7
 mEL6hjYfHQbi6oyjIE2VoorugnQp9ByMnMbriffFlgHDCksRJCEQfDT8ORx4ipIts11kNwGasfI
 cOvgNpI2A5S9FaLDkHBxhlPYc/VssN81QOqfbEBeJtQI9hnzKuGBZR9wLcknBIfq3p09q0A9+FM
 pbC5hGIElWQM8trPINfgCHK8VYR+M0T4FddnI26IjsJ+1KAHSn2utg1Ouf3G05RPo98H
X-Google-Smtp-Source: AGHT+IFaxEFfdxoB+NhJWY6Xjw8ISMTtUGfHpgU9GFwGkwmORKfGmIuhKqeQzS066wOADy8uUGvHIQ==
X-Received: by 2002:a17:90b:1d87:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2f9e077b9fbmr5796134a91.15.1738772701637; 
 Wed, 05 Feb 2025 08:25:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v3 02/19] net/cpfl: avoid calling log (printf) with null
Date: Wed,  5 Feb 2025 08:23:03 -0800
Message-ID: <20250205162448.161161-3-stephen@networkplumber.org>
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

The log message would always refer to str variable which
is NULL here. Looks like author intended to print original
parameter.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 6f6707a0bd..1817221652 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1580,7 +1580,7 @@ parse_repr(const char *key __rte_unused, const char *value, void *args)
 		RTE_DIM(eth_da->representor_ports));
 done:
 	if (str == NULL) {
-		PMD_DRV_LOG(ERR, "wrong representor format: %s", str);
+		PMD_DRV_LOG(ERR, "wrong representor format: %s", value);
 		return -1;
 	}
 
-- 
2.47.2

