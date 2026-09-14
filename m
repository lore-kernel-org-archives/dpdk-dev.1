Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD3C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C96410D0;
	Mon, 14 Sep 2026 07:51:52 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id EBF9440F16
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:49 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc4d64bcea5so1496860a12.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365109;
 x=1789969909; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=adHnJSkx8TUyRAaMu1JFJpEmzsl7vd+RMK18TdgGUJodLh7dFIR1gP2IXjZMRzK+9a
 JaqE/dRet2YokwXP/CDyRQPXCc0T8UtWJVJACYG9bGXxAMkLjsF0LPrCSEpVxRPqdJT9
 SYfCDG6i/Ui35ku2GuuVg2EDTPvfz5Sg7wWJSCS1FHvsKLCpZvVww8Pv8I5Y+7ZW0Pay
 TMtQ09xRvgwjiLCoIncW1APITfwENBcovDw/Pk5lzD3XwhZQoftRIDL2TIm5rLF7BS34
 e3Dylw2rZstwuAz2V8++fS7SFTwA2rREIj1fKiJJ0MVfXIRnTSiv5ncEdaW/YWNZmZIU
 SSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365109; x=1789969909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=VL2MGquf3w+T+h5pPTorO/ojQGMkJyK8YR8ay6AbBSBzWwqRCHxtgDVaNtFjCn35Ss
 uBQ2J9u/QyvTXUVJvACexWs8xamNP0ByUH81R9BUM0OVpbJCqFGpuuHTdq6SrUrg0YUa
 t8FTtiMPlX+sgdLyIcUrJVfuoBjft/F75355deEDoOFCmgjG4oiGy/1Ovj1YugxFL7M5
 ed/n4w9+cJLpw0KHWSXZBf2+c0JINEpArIGVq+dY0WHEAWjt+8n2bHNJX4ZH4REDUARI
 NML8xvqXC9vD6UrC9Mf0J4no1ifmRHSzibCpJgcC1sq1BbKDamUuiZxPIBRzifCIaz4I
 JTAQ==
X-Gm-Message-State: AFuF++no7PesdASo4On3WNdKlgPDb/eM267uHjkj9DcOScuUf+DOnCGQ
 MAcp/95mvkD2jshujNrGa2aRovbzjhTrZmFLUkFMIxMg0ZAF1LLEejXgtJ1dLAc2PnslhlTFxpr
 JhKRf
X-Gm-Gg: AYBFou0mvbOKxaGDbNkKQK9KbxBQT3dMEhWqdShjkzRGaOkxU9jRLZ2LWktdyekoqjC
 80vBfEE5+DIlBeH8UdnJswOONjUli0mmPsCj098E1asbKXqE455b66kduAQNqpm99Rc6TqZ4RVR
 3GAai2YmW14Zy9PWeIpAyHUeVCcfdzGBQm2PNfIHTx5cn1EqO8Qjo8yXWPyznUiBOC818n2IImF
 uvL0ZS3XuxExVMPpuhZsMMBIr4BYTUhwrb8hgzWFK3vKkqVrs1PJFFFFWB/plQ+A4mKFknRf6C1
 QQNdQc27nxK9VG1CpXNzciOaSkpvON6pqFFeRI0/+AgtLytdBI+ZlDwmHw2vu1v29W5VLpSaG82
 CGRQrWQD/8IrstqkcFXcbFaw6A2SFH4houcp4v1ww0u1BfSdCLTS9FPZhQSIngUyoUcyHEgU/am
 j9Hzw31uQ7zrevuJT3stVZWWIbBu99/UQLIK4Gd/PKotbsBcl3BmcCyHEzaBLjlE95/s+xoarFM
 AfqbxodV2CE6cjnY2Gmby3swetB1BE3VDDh+A==
X-Received: by 2002:a17:90a:d2cf:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-39debf6ccffmr2867919a91.1.1789365109057; 
 Sun, 13 Sep 2026 22:51:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 43/62] drivers/crypto: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:14 -0700
Message-ID: <20260914054912.755403-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

The dump mode handlers use atoi(), which cannot report an error, so a
malformed value is silently taken as zero, which disables dumping
entirely rather than being rejected.

Out of range values keep being clamped to the full dump level, as
before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 15 ++++++++++++---
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..93e92af6a7 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4342,13 +4342,22 @@ check_devargs_handler(const char *key, const char *value,
 	if (!strcmp(key, "drv_strict_order")) {
 		priv->en_loose_ordered = false;
 	} else if (!strcmp(key, "drv_dump_mode")) {
-		dpaa2_sec_dp_dump = atoi(value);
-		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP) {
+		uint64_t val;
+
+		if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+			DPAA2_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+				       value, key);
+			return -EINVAL;
+		}
+
+		if (val > DPAA2_SEC_DP_FULL_DUMP) {
 			DPAA2_SEC_WARN("WARN: DPAA2_SEC_DP_DUMP_LEVEL is not "
 				      "supported, changing to FULL error"
 				      " prints");
-			dpaa2_sec_dp_dump = DPAA2_SEC_DP_FULL_DUMP;
+			val = DPAA2_SEC_DP_FULL_DUMP;
 		}
+
+		dpaa2_sec_dp_dump = val;
 	} else
 		return -1;
 
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..3feb752bcd 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3625,16 +3625,25 @@ dpaa_sec_uninit(struct rte_cryptodev *dev)
 }
 
 static int
-check_devargs_handler(__rte_unused const char *key, const char *value,
+check_devargs_handler(const char *key, const char *value,
 		      __rte_unused void *opaque)
 {
-	dpaa_sec_dp_dump = atoi(value);
-	if (dpaa_sec_dp_dump > DPAA_SEC_DP_FULL_DUMP) {
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+		DPAA_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+			      value, key);
+		return -EINVAL;
+	}
+
+	if (val > DPAA_SEC_DP_FULL_DUMP) {
 		DPAA_SEC_WARN("WARN: DPAA_SEC_DP_DUMP_LEVEL is not "
 			      "supported, changing to FULL error prints");
-		dpaa_sec_dp_dump = DPAA_SEC_DP_FULL_DUMP;
+		val = DPAA_SEC_DP_FULL_DUMP;
 	}
 
+	dpaa_sec_dp_dump = val;
+
 	return 0;
 }
 
-- 
2.53.0

