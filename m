Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9916ECA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76DB242E7B;
	Thu,  1 Oct 2026 00:43:58 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 5BCE242E15
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:55 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49896dd9dso750476a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808234;
 x=1791413034; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=nPTdUEWegId3jNV0ACjMDOxy3iwBkF13T1YbO90NMDw+1DSNs9sRUbTq8GuIMvkNkn
 OlFFr23yMujy73fcsu4+EIaeU4pzGzvmu0SzJ7QylGFAkzDxU6Axfm4XSit5zx+LWGuQ
 e4qwZuKE6tqYkJOWr3aLsf0+f3CjtvxVcqZlATCBFkIUkSrgHed93neXLFN2I2/isChj
 i7Gpx8MixKZ+uUJfphzNL4HBSDttoc82L/a9bV8xUTxO4rMbqtO3FmgcocgCDtu7K6kZ
 GIGtd7iMHG5Xa+VKlBRPbKYT0HSBfXLtkJD/HEMRhbLuy0itpf9DyCMzVm3OfdCenn8a
 Racg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808234; x=1791413034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=KE7JwIBBQcP8m8sJ2NYuXwT8dZeEeZLR+4jbM+at2MGdJMpLXyYEkF7h6alS5Ooxeb
 WAIq7rpxBWHTrRW6fFFx3XVSCrg3gc2VdqYOFdbllu0k2QuzUbe83GJbY+nrmFm6WX0T
 76cguzKHW1nJa9sXTJT8BTvILXKTCD7qGPjZ7nGq+ps/WrcZE5yyzpclNdepPHqT3vCZ
 Vb1f3K2aWiayUxIlIapXQP1Zb29BEDbmOCiLVowkN8bi2iUv+5GolW5RJhjKBsh27x6r
 1fSAOKxeAgIA8Gl748E1WpzV/GA2m268jilg8FGtkViHJNj9cnPAJFG4OtVSnLCGItzJ
 pB7w==
X-Gm-Message-State: AFq9FYLBlK5rwC5GJ4K7abmVaBI6w10FjZC7Vz+vSS6D7iGuyqzz62ur
 EKHjWy48ZgOEcgAZ9I4MC0rFhVl/hHSPd4o0fvdf6HCkTP3mdtazfyrVxk2uDJIydouolNQRene
 q9rsNohw=
X-Gm-Gg: AYBFou0VxbrqkY3RyiWie2wYqASiEe4H4x1EkRXEKV/T4eIRHyZPXfJUEg57mXlGBgd
 /D5XFFJduWLd0kNUWi/3IqUYPz8knfZNXElmwg0IhQhPCK0LOi+AbCYYbZOG7VWtclXXySNn2Zd
 EJInL609MdNx9gllSSrE4y9MGp8HbE+QCTh5F4FZrZV+sW/9RuP1kFZGq+oSNgeZpPBRJ/k+sUr
 ZsdluSZ0773+xWNwsE0AQa2oO0RpP6Z6DtvtmJAUhw1EJj9UBDvTDTGVIQGZBxDWGaBL5GeZv+6
 ssbtPfg3OBxmf25+Ey2G5WYIuExQbyu2utFrTAUSXd0BDK6Han/vAUkLbzQb349G2d0Q7VgTnHa
 5LSxr2qqvO8rZWztHbCkTIrWYnNb5IjA0z0Ag5RmMy/C2f/qvPLQB0x2HZ4LKr00rrgLBCuJDcw
 cSF4ISr/3W2lo2x4MxQgS0/5O/Yp1m63mMhk7NwDX95qA90qdurW+4bPNuCv5YlHkWeSfCA21m7
 5LykF7WBmW33kQZKbbXrfznOmXxGhs5bmmBRA==
X-Received: by 2002:a17:90b:54c4:b0:3a4:b3a4:e7a6 with SMTP id
 98e67ed59e1d1-3a4f2d2f534mr570261a91.11.1790808234380; 
 Wed, 30 Sep 2026 15:43:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v3 11/65] raw/skeleton: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:29 -0700
Message-ID: <20260930224340.58580-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

