Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF56CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E700E42F53;
	Tue, 29 Sep 2026 18:40:02 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id CAAA242ECF
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:50 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-881269371acso485464b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699930;
 x=1791304730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=Y87H1YcSTqkueAUbgDzSheoE7qdaI21RSfGNnwV4rsneH/6uad7LjejMD+bVSM4SK4
 pS/k9YAASDY3FZ/B2S7iYOsdBnBw5GngA8Is0KELUk5v8LDCX6CHeMvpiBWwaE/aBecJ
 BRS2/ab4eqJXFrxQ6DCQfGuG/Pz6GGBULX5xTg/eSMv6cbORsIzfgnnz6bWf2I1EdILT
 3f6BPWZ9b62d6tCYEXLOIo/VxL/MamS2ked8nJzjAcO/WbdsfTIKSEITvQYxnZjx2MzY
 4mh3hrA+FVQX0gVr8GnX99FytaXmuS48rdZWAu5uutefldz3TSjuNQzc0Hg+HNCGG+P7
 pN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699930; x=1791304730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=No/SbzGtcQRq/auug6hByQeNAnwGR46rwqW3JXWnZGUOkQIAiFL4/y5oIuiLeyYyd7
 xQun/LfJzKgGTc+8jzUQTJ6hGh5GEaJmG/Wj/B9+8e2tQy6My9Np+YCuBBRJ6M11kemz
 C6ZL+cAtpJUjih5U2mJFXOvKdyxSCH+6WSlN2RtvbsrGOVNQOdpl0dvQEaZ3CXv7Ppb5
 6p2cKZ6BBwI9KMuXORr+L8UMv3EstLfHdXieu/6dWMqRxiDIF4nc7rcjIWjzTgw/Q/r0
 HvzC2rK1ULJHWFIGYL32yb+lRKF/HKDkUtshXfC8CQqiWbEarZLqnoiJFrs2xK43joJ/
 stig==
X-Gm-Message-State: AFuF++l9aGvpLRXJu4Vxwdr6KvKJ0/CbDTj/wcDZrmC/YFsPJVVaAKB7
 ZZTdJGcynU98jDB/+vmal7D9Rug683gTiM9eCUAGPU0lSfXh7nCw6t/BHjw80gm/R3s/HPkdxaD
 lFlHRId4=
X-Gm-Gg: AYBFou2QJwJ9JH/4gUtdoZGLZWbJW4uQZLPGOkoLfwsZAL6xz/gW9zB6xljEuVnUqhZ
 qicCq5yMC7nalZ4BYnnx3pnPNlEK8AAVDzWTVfcSa3Fhd4JeKgpPt56SDhl1dpXa1TIzvnf/5Yb
 iJhXbjkNWM42OXP1U70OxCdfj/wJBJpPWSb37b0AO5BcWcWEYyfpw3y24uTV1Qnv/29k96yWSvv
 647/BX/na0/N/5b8NIF3tIHYW4A15pNAZ7dY0RwGJuUu0lzysm1yc5ZmGiiTgS+rMGjOUk7eCgD
 7jWjyd3rCDpC2jH7UKZuhw4kJTuUUQLVVFX42FOfFzryF0IzMzDDYbjKZE3pnoXpMemav57uBmq
 fE7I1RSszePCGiSAMst0pNO7luVgBb13Y5wkTcW3Z48OorZnfkcQEma2kl5N/GqUk2nHiIerrMe
 Bj1YDrqsakSvkAkYJgm34N0XkAKtvntv5hHuyyePSnIkidxNoq7mEJ9Fp1F9lGuQmB4VzPBsSt0
 HZ3xuzotq0dcRjAHllf/TtEM/dzHDpsIJ9o+A==
X-Received: by 2002:a05:6a00:7097:b0:87d:fc55:c995 with SMTP id
 d2e1a72fcca58-88563259606mr1747318b3a.50.1790699929937; 
 Tue, 29 Sep 2026 09:38:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 47/61] net/sfc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:50 -0700
Message-ID: <20260929163800.1108305-48-stephen@networkplumber.org>
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

sfc_kvarg_long_handler() only checked that strtol() consumed at least one
character, so trailing garbage such as "5abc" was accepted, and errno was
never checked, so an out of range value was silently taken as LONG_MAX or
LONG_MIN.

It did nothing beyond that conversion, so drop it and use the new
rte_kvargs_handle_long(). The callers keep their long variables and their
own range checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc.c        |  2 +-
 drivers/net/sfc/sfc_kvargs.c | 19 -------------------
 drivers/net/sfc/sfc_kvargs.h |  2 --
 drivers/net/sfc/sfc_port.c   |  2 +-
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 39cd8d519a..3d460cc222 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -1213,7 +1213,7 @@ sfc_kvarg_rxd_wait_timeout_ns(struct sfc_adapter *sa)
 	value = SFC_RXD_WAIT_TIMEOUT_NS_DEF;
 
 	rc = sfc_kvargs_process(sa, SFC_KVARG_RXD_WAIT_TIMEOUT_NS,
-				sfc_kvarg_long_handler, &value);
+				rte_kvargs_handle_long, &value);
 	if (rc != 0)
 		return rc;
 
diff --git a/drivers/net/sfc/sfc_kvargs.c b/drivers/net/sfc/sfc_kvargs.c
index eb36fa98ca..d67f822dd2 100644
--- a/drivers/net/sfc/sfc_kvargs.c
+++ b/drivers/net/sfc/sfc_kvargs.c
@@ -107,25 +107,6 @@ sfc_kvarg_bool_handler(__rte_unused const char *key,
 	return 0;
 }
 
-int
-sfc_kvarg_long_handler(__rte_unused const char *key,
-		       const char *value_str, void *opaque)
-{
-	long value;
-	char *endptr;
-
-	if (!opaque)
-		return -EINVAL;
-
-	value = strtol(value_str, &endptr, 0);
-	if (endptr == value_str)
-		return -EINVAL;
-
-	*(long *)opaque = value;
-
-	return 0;
-}
-
 int
 sfc_kvarg_string_handler(__rte_unused const char *key,
 			 const char *value_str, void *opaque)
diff --git a/drivers/net/sfc/sfc_kvargs.h b/drivers/net/sfc/sfc_kvargs.h
index 4dcc61e973..99de772d2d 100644
--- a/drivers/net/sfc/sfc_kvargs.h
+++ b/drivers/net/sfc/sfc_kvargs.h
@@ -88,8 +88,6 @@ int sfc_kvargs_process_opt(struct sfc_adapter *sa, const char *key_match,
 
 int sfc_kvarg_bool_handler(const char *key, const char *value_str,
 			   void *opaque);
-int sfc_kvarg_long_handler(const char *key, const char *value_str,
-			   void *opaque);
 int sfc_kvarg_string_handler(const char *key, const char *value_str,
 			     void *opaque);
 
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index 33b53f7ac8..d0652b612b 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -488,7 +488,7 @@ sfc_port_attach(struct sfc_adapter *sa)
 	kvarg_stats_update_period_ms = SFC_MAC_STATS_UPDATE_PERIOD_MS_DEF;
 
 	rc = sfc_kvargs_process(sa, SFC_KVARG_STATS_UPDATE_PERIOD_MS,
-				sfc_kvarg_long_handler,
+				rte_kvargs_handle_long,
 				&kvarg_stats_update_period_ms);
 	if ((rc == 0) &&
 	    ((kvarg_stats_update_period_ms < 0) ||
-- 
2.53.0

