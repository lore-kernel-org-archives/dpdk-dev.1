Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76796CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2078842EB2;
	Tue, 29 Sep 2026 18:38:44 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 0899B42E77
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:24 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso2458889a12.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699903;
 x=1791304703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKvyOzFTCnK5BpQp3U6iWp7DPcr5YGlrqACcXd1UO0U=;
 b=OUaM9dFLhjs868WwHQZmABtEfv8Ne7LnDmA9nM65stC3ujM7o1fLG4ibjc8CwyE6vw
 M8Z1UHlouCd9Q+XxI0RWo8ByCLdbde/D++UOJxM4I39PLzj6Kop8bysHBtGF0uhFUQQt
 NxeWpvCt9WCW2Z7R4xk8VjamUrhrbA1yWHU8IqjZMqF+X2YIwMF7tGh/WajjVbQx9+Zt
 CGppFILYL05G5a1ye/y+pEsMDrvmX1Pv0AeZeq6uqjS5KHhf+VIz2c7mUNTRXnVcD1Lm
 VlxfveTYjxLcPiQ4PiLDN2uwEwiVwDKgQrCfkXz9lTaedii02iu0xssKNOFVYlTih0JH
 HjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699903; x=1791304703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKvyOzFTCnK5BpQp3U6iWp7DPcr5YGlrqACcXd1UO0U=;
 b=U2lWix/ORZ919Fi1cNx/igtT3oeibU5LKit8eYzdYxauIbdiH5PZRbpkp3ROewBZeC
 kuo2RN3iEpebP5gt7OKvdh9OB5245mOYMC835TF2VbWRG7tv6qv4n54LRWkd29GLblUT
 n3CrmFdDd3Tx/iUUjMzrqKMGgqW2jsWL9ckmHhsDW/MCcGGzI7NwVuY6cxXZFmO1lIMM
 09WHslvAIN8LxotN28M2ahEdHRG1vgjgnDL7Q+nSH3KtqN+UsU3QSuGQFdPXpxW6mZxl
 ZyDAzDvg40+z0dHHTusK1ha+ClwxLqQ1sVIdAE3g/6xCFO2CrvHKDL1W69yBA0tCowPY
 OhwA==
X-Gm-Message-State: AFuF++kMHDT9w6KTyUOAWoQ3B8eZRBZoczQ5poZDA+zZnrHrQFwS2vcl
 +Hqzo0+hzruC3P7FRBx/2+M3CClGOhh12DodX9Z1xSO9U9lRrtQuaXxReuoc9FFJmaySn/0aFkI
 u+TR3mNk=
X-Gm-Gg: AYBFou2iSR8MPlctUwKmDp0UCVOz42/6pkRon8uTZdMxvesF49skIS8/8gBz0B+ubYZ
 oJCsny+7BHWw3WQFTcgCmeZlCVupLNsfEU8VIVIVe0A5XETtmYuWRFiS4Gm851+Rgd0FeskxrkZ
 qWdbnHZRT2gGhoYCPmGbfcN5jNKgqW/0vHjmfyngW0KmwNx5o4fvllDb9mYKxMKtCjQIREvW/jw
 07/HMYpNmFXNvUh/O8E9C6v1+/Txb5vDp4ntTZGHQPNq/twiCT3WoS01H7UVfMU39UXxJiCcNjF
 CPWOAYjkVAGW9zprYHcfChQXQFgye1C11eqBL8Or7LAx/3jVSCcSvDHZR+jDNi+hon8e59E3ULq
 Y4A5RwdKZg2VsYurGJN6BQ5FkuPXmKft4++q7Oy4Ky+ySbQe34Bj28b6GJGk2cuea+3o2TBPSG7
 5TUbcFK+shSt2j/et+W3CwCyv6PA19YnOA0dTFTclrppMU0EpYYet8J6fJM0qXfdl9Qeg9qCZMl
 J0quP5IUZWsljOjwmZNKYZtAAvXFKGVEi3r5jlkOrV16U2o
X-Received: by 2002:a05:6300:279a:20b0:3de:5a00:e24e with SMTP id
 adf61e73a8af0-3de5a00efdcmr4007032637.35.1790699903217; 
 Tue, 29 Sep 2026 09:38:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 17/61] net/ark: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:20 -0700
Message-ID: <20260929163800.1108305-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

The packet director argument is stored in a uint32_t but converted with
strtol() with no validation, so a malformed value is silently taken as
zero and a negative one wraps around. It is also converted through a
signed long, so on a 32-bit build a value above INT32_MAX saturates at
LONG_MAX rather than being stored.

It is documented as "Pkt_dir=0x00110F10" and read as base 16, so use
rte_kvargs_handle_hex32(), which keeps hexadecimal with or without the
0x prefix and validates the whole string. Both the documented form and a
bare "00110F10" are unchanged.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ark/ark_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index d6b1abf383..c6784b64a3 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -896,7 +896,9 @@ process_pktdir_arg(const char *key, const char *value,
 	struct ark_adapter *ark =
 		(struct ark_adapter *)extra_args;
 
-	ark->pkt_dir_v = strtol(value, NULL, 16);
+	if (rte_kvargs_handle_hex32(key, value, &ark->pkt_dir_v) < 0)
+		return -EINVAL;
+
 	ARK_PMD_LOG(DEBUG, "pkt_dir_v = 0x%x\n", ark->pkt_dir_v);
 	return 0;
 }
-- 
2.53.0

