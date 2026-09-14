Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1276BC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2331B40B9A;
	Mon, 14 Sep 2026 07:49:59 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 5593A40A8A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:58 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso17313095ad.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364997;
 x=1789969797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=iuocmdgCSsvR3LtkoLCBUYr019felJzRLSW5nPYcl6bjrrH7nuGqGcOOwx6/E8P2r9
 Ng9HXT8zEiFpGE1znzGQn747CXJVNeGQtshzq5+CwgdVKDn4bIKeA7l16GVC036mAqgf
 luXnxEr1C2DXeokY/bKKzR3HZ9EHSL/5jYW24ol4OLmqwvE3YAk8gePDj1phmLrZ7lxi
 ZZugNcEN+bDdyq6cfF4F8LQqIi6cRdL4JqCeoxLr5J7e3RbFV59ciBTaHD9JtBe2mnXG
 GdwUwVbTULkmn+zDjIflYrkoGTsFfBhtLjAs3/nWUQf/WWQ0n96IM/2fyJl8g2V63Oae
 9W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364997; x=1789969797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xObD9mVxA0J4D2qr87jM0MXMyLavhO5xlNGZQ/CsbYM=;
 b=U3EQQVWLbyRSbBEYEYV129WbkpsNOM9p8STrF+EOc4n1RPcpgjiPijlxjoVjAAR7A/
 Y0Tj8kAB50z0tGhffKiy9DEXizPc4LdnMnMsDVCv6e75rE099OQ0kvFvlxnWs4jcJVaI
 IdMhh/xN1x78WXUyrCCS1+g601YcNA++Kt63eUGJ+c4EDBNtknYmnTh2WRFQOwY3k0Kj
 HAnFxsp+tMdz7IHSeA7RCWJpNXWJ/8CBUl1B24sc+fo6rXy/dWRimfewYwn2k/Bw/doR
 6eluIXqpbScl1j92rGYC3F7YCtlLiOfC/LelyG3yubpN7M7sJl5zeEyflsSuBRsQZV0U
 gvDQ==
X-Gm-Message-State: AFuF++lh92yQt2wXgAulUvM0j8sE8fGkTq0Uh8l0cYMh47YB9u4JQFcA
 MePqY4StzajbLrfs2IPFe1Et8j6bd1+m1RKmKI+WCVlUB77hcMCkEaF8ZeVT/YXe3dZIzBXGmi0
 LtJymNeU=
X-Gm-Gg: AYBFou1po628uMibUA2iYK6E/HrfzgTEM4JNA+NUYY7s2Yd5BAF+avf5N2TLX7n23ME
 CbUySW9zLOFQZsKIdGhGlwCeVV+0nT0T5Cs/KzHUzULd8RVeIu2Mg60Bb6nA2Zla5Ax6OWvOVQg
 BLe6S2UqVhApZ7BiU3+bMAnGMu8kVg5tIjv8OQV6C6zCW3dkd6XWI/VKA3rHix1/FqSIO/OcnXp
 +4qf95x9cLuOQkmU8w8Wk6HE5hKYRQaVZJNKvYlR9cFjZ/C93qFSW9CkNV21Whi99bxTG762hYR
 xqkYT1VjIe/G17PizAjfNzwqgTGMtLaqVzGmVRk9HGqdXo8lQFbXNOPJWF5dgSgreGGIlXhnQXY
 N9K74xu5pJTwtBj+tTIMTrhnn7sTpWdVV4sznMYzhOu+q7QuwNYS0hZELamqMpxCGDC/FSgZYK/
 BE5WSwGRpWlKL/ITO8eBLq5N+WjjE2wp/Xfms0JC9yI1e7xoC8TBQGD6gCnYy3zhxwcB/Fh0LDt
 cfFJJ3fVzv36u2srwKvDH1NM8GsVr2cdV9kVw==
X-Received: by 2002:a17:90a:fc50:b0:39d:83d0:41b2 with SMTP id
 98e67ed59e1d1-39dec05d766mr2634776a91.15.1789364997488; 
 Sun, 13 Sep 2026 22:49:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 11/62] raw/skeleton: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:42 -0700
Message-ID: <20260914054912.755403-12-stephen@networkplumber.org>
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

