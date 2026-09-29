Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8870ACA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53AE642EF2;
	Tue, 29 Sep 2026 18:39:31 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 6B27342E8B
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:38 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so1872115b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699917;
 x=1791304717; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=Cot6VgDFSwlgpDksvowkcAkzSZI5xyuxQOhFayzveIEmiW/AIw6XbCTkRHl4OCPBOL
 gJoF9l4u4x8/c/Bp6TQiAnIkIZI66vsUyz52A0fR4PTY0uAxwfNaCT7Q8hixAKKfuyNV
 iGMFOKv2jsArNLB6kskZKlVxBq7kULfPdC6a3aQTSSMsueYSsuVTCQrXjwMnlZ40Vv3B
 qeNXgH7yJXpwN7KBshY0nvrnJZeWdXn3nHhtb1MyO45XrfaYVf4x98WMJfG6+Gq8tyAT
 cSh6Mf8SmkvTBpH8yJsUiQvIX7RZKJ+pyIhcDqrm6394o89tJMS2PGVOrQC7y7XzDygj
 mylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699917; x=1791304717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=TBrOJl3wLTi8ZC0m0sffxgC3ue1+oCGsMGEvtwzzEI1Gc/VXaY0Ak9ni0Zi01BNfvk
 uBAZljz3VV7DSva/tNK5D5qeaUM/4VjS04YY0YHh2L/SuuVgbpLyWYW88MstUDSjFhyo
 Kr72zVDuh4qkluQtdPr9GmM8iCiv77/IyR7a2sSAX7DhNL+HfM2dVN+ITjMN1r5EysAr
 E4tEBqmUtrUAmkCSE0Bb77wG9QG7FBw/zVWbVmYeOiUq+Tjnlx11Zgky9FHFb4dO/vyu
 dZqYe0I0/tmAd32M4eOd4eULsTBfWl7FxfmvbuKwZ/PQTWwzWjvN9o0o7rs6Ed7bJg1H
 Sluw==
X-Gm-Message-State: AFuF++khYxaG+ceZQ+zMVg6L6+ocZ0hLNQOf0zTPkr9kXt3i41tEKRZH
 UXLhKJwAFdZWJVGC56a0BozaSCHNoI33+wxRil1vzyq5pGE1NpZ4p1Fp/Kjj0TSfK4+ZXzBK6Kf
 oEbgRkVI=
X-Gm-Gg: AYBFou28JObsc72Owfwo/AWr2GLI46PrvELhEH4r93n71kWO37ZRoAl5WVADQHh3JWK
 1lPuTrYpMGbz+7oJvEUc9KKK7Q1qGx7TV6o9tnnbpzZ3vOkzCM0MfO9rP4TySyl5Vkra3uw8nxG
 5Qx9C2QJopmEXAEPDEtP1lhZ0L+M8f3XhK35wv/57ivIOIOTgYxXUJGrwZyMCIQ5V+OYd8RWICn
 8OIlP/C3yJ2Lum+LiuGhQqdjMySjOI/0Op+Pn8/wVouWDM7OWqiWltI2MmesT9e31td+I0RXYxa
 sC8BsG3SpJ932dUNwO5qwZxB7iYWWIu62sQ+rz5j5/kmtXPKAFZMgovL3iUBe5uNn09fToTc83p
 HBk7mP2hkZccxibod6gBBaWVZ9D/4zNJj1r7KJzhPiDgVErkrPNcpbG2EySjh6e7+TF0Gu4zOCM
 5KXeu8r1Ltq1ip4MHrfXmOC28Q0vS/JILQUjfGhHot0dF6Gnma9yCn1Wh/a36T3Mt5HMNaXx5FX
 BMa67ktBsWBlzG64Y+ZE9Te40EFLsB7+pDlqA==
X-Received: by 2002:a05:6a00:9291:b0:878:3507:8d5d with SMTP id
 d2e1a72fcca58-87e9d8da5f7mr12885507b3a.36.1790699917471; 
 Tue, 29 Sep 2026 09:38:37 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 33/61] net/nfb: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:36 -0700
Message-ID: <20260929163800.1108305-34-stephen@networkplumber.org>
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

Replace the open coded isdigit(), errno and end pointer checks in
nfb_eth_dev_create_for_ifc_by_port() with a range checked conversion.

The "port >= LONG_MAX" test was redundant with the interface count
check that follows it, since ifc_cnt is far below LONG_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfb/nfb_ethdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index ba7c849a4b..f2ad831c08 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -965,19 +965,14 @@ static int nfb_eth_dev_create_for_ifc_by_port(const char *key __rte_unused,
 		const char *value, void *opaque)
 {
 	int ret = -EINVAL;
-	char *end;
-	unsigned long port;
+	uint64_t port;
 	struct nfb_ifc_create_params *ifc_params = opaque;
 
-	if (value == NULL || strlen(value) == 0 || !isdigit(*value))
+	if (ifc_params->map_info.ifc_cnt == 0)
 		goto out;
 
-	errno = 0;
-	port = strtoul(value, &end, 10);
-	if (errno != 0 || *end != '\0')
-		goto out;
-
-	if (port >= LONG_MAX || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
+	if (rte_kvargs_to_uint(value, 0, ifc_params->map_info.ifc_cnt - 1,
+			       &port) < 0)
 		goto out;
 
 	ifc_params->ifc_info = &ifc_params->map_info.ifc[port];
-- 
2.53.0

