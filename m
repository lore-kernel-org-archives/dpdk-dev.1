Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD16CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2D342E79;
	Tue, 29 Sep 2026 18:38:37 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3496F42E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:18 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-880cb967dffso573643b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699897;
 x=1791304697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=jxHkLUxQDiEeNyEpNM2sCru1xiFfLL0dlkWq0RsmoklfeGFQf1g+BkTYY+rOVaU8bd
 0fYym8bkEnPaSGzyCxY8UwMFPGdv4OgLSl6TJ2kTuRfFYC78CYfli38DXYZIAeuBV9ez
 JFKTHrJdfwOum+F2MQN8IqX8nOYreSGYhG4Q4vqQJHxrFVjGd+9tdnCeLJB7TBkkLyUi
 Rf/fFC0Ah16Shq5hvLwj65OTr6lxWybipDgbZyv7P+ISKjBwCU5R95An3UHVY/+7nVg5
 +zSOI0HKLoSyXJZzgsbgKNIqZTM/iMYPz9kgb68wdFTqZuLcwgXG1P7S1xNrydCul/5i
 sUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699897; x=1791304697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=WFxt2NB4Nfj7zS2hjXgZlNxNH9xvZEwb1hd1/OerlztfSyrjts+5Mm+BNzDxQeKZSq
 ySqt2fZQt1VFgqyEWg+orbb8GrV6TQhCyundWWVZXb29Qo6gxai4N39kkkJH4dn5Pg9c
 JOyXcuF+XmNcCsiI35tnLnmg4gydzjUL+JdGQtmVmHArBLIDAY31Vuqz74K73F1d/IoR
 xvHuRs39XxE2Pa38Ngv0HNOeXzZRYmnUCOkZFqex340ixJ/QDL7ytZg1IC/TOO/wa1EE
 YxsKYqkU9ju5bQuDNqvLL5hif/HdvUg/1kXSw1Rt3hDbR2K5Us5hnXPYigwOAT6pJavD
 ZL1Q==
X-Gm-Message-State: AFuF++nN5vUDgViOPrKWl9IM1A0OIlVlDzXxKGzSVNyDgl20Gn44Wtt8
 qEcIEARcl7zWIg4eLg8cy+zgLRiL+dKQXhCDeEM3+hLX+y8NxT/Ad4AkJaLJDwikQQ4PaxTqU9y
 d7hJqNwU=
X-Gm-Gg: AYBFou3Bj0kfgIk3nNmsJ9rTud9OWmbkiAWXNL1e0YRsJUg6A4DxTaUadu01RhBqQrT
 d+HlR2bCxYA8gHcpeyBjKPHTu5KOAfV3/haOVVBhMHQSTePCmjh+tCIPlRek9Por2hVxqVQoOTo
 yTxjiK1zQsW9gDTv5bd8k5FiqcfTDKI+9k6A6goVVuLi2kd9AnEzHrvoGOEtYjueqyS7/R0vDza
 aWADO0w7dwHjgi8lWhr50iAXUf/KJ2lH2Pz3VAoknRr+gnT2aYcyQHwr0VOItSEuNBBthY/MutT
 V1/Qc2/FmKv8xP9a2i2sT3pLSODTqkACEqVjzxqnYNDcyqdLMVclt880/PRfAA3I5RjTzWafBm7
 fA0FBGE8yt1OrnEQiIfT3NZBkf25CGV9a/eq0BGbs/EEm0lvVZE+gzeLwGuUsv+tdSSrU2CLeWm
 B7MLgMdFygPMJI3YhvUcD1QTOXcFMnDkh4j5vTb6JdlErhbAo8y3QJ5GVw6DthbfqZslqUk0BhV
 PR5VbXTQQTIGt9z7VhpFXHErkrAsgB8AjwRGA==
X-Received: by 2002:a05:6a00:2d20:b0:885:57dd:165f with SMTP id
 d2e1a72fcca58-88561926a9emr1820782b3a.19.1790699897312; 
 Tue, 29 Sep 2026 09:38:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 10/61] raw/skeleton: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:13 -0700
Message-ID: <20260929163800.1108305-11-stephen@networkplumber.org>
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

The selftest argument is converted with atoi(), so a malformed value is
silently taken as zero. Make it a bool and use rte_kvargs_handle_bool,
which rejects anything which is not a recognized boolean and removes
the need for the separate range check on the result.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/skeleton/skeleton_rawdev.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/raw/skeleton/skeleton_rawdev.c b/drivers/raw/skeleton/skeleton_rawdev.c
index 6e99d35536..4e20952e47 100644
--- a/drivers/raw/skeleton/skeleton_rawdev.c
+++ b/drivers/raw/skeleton/skeleton_rawdev.c
@@ -658,22 +658,10 @@ skeleton_rawdev_destroy(const char *name)
 	return 0;
 }
 
-static int
-skeldev_get_selftest(const char *key __rte_unused,
-		     const char *value,
-		     void *opaque)
-{
-	int *flag = opaque;
-	if (value == NULL || opaque == NULL)
-		return -EINVAL;
-	*flag = atoi(value);
-	return 0;
-}
-
 static int
 skeldev_parse_vdev_args(struct rte_vdev_device *vdev)
 {
-	int selftest = 0;
+	bool selftest = false;
 	const char *name;
 	const char *params;
 
@@ -693,10 +681,10 @@ skeldev_parse_vdev_args(struct rte_vdev_device *vdev)
 				"Ignoring unsupported params supplied '%s'",
 				name);
 		} else {
-			int ret = rte_kvargs_process(kvlist,
+			int ret = rte_kvargs_process_opt(kvlist,
 					SKELETON_SELFTEST_ARG,
-					skeldev_get_selftest, &selftest);
-			if (ret != 0 || (selftest < 0 || selftest > 1)) {
+					rte_kvargs_handle_bool, &selftest);
+			if (ret != 0) {
 				SKELETON_PMD_ERR("%s: Error in parsing args",
 						 name);
 				rte_kvargs_free(kvlist);
-- 
2.53.0

