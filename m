Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A45CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BDA942E6A;
	Tue, 29 Sep 2026 18:38:45 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id DAD9F42E77
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:24 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88103e47f72so3064346b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699904;
 x=1791304704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=j7l3VjN/H+IzyxJaMPhx5q9fZ3GrRph8PpCrlYubcbILX0KG8hBpPWgZPBWPGYA7er
 EGdE3Vr9NY1D3rQsCDZp3j+T90OhcDV05nwOvMW6mRftz1VFqQkMg9qw6GaykBcN+3B2
 c+C5Gl1dL1k3RSNTOSGvSN5Qf2RaQi/EeRUe92qrvwtoaPMJjLmGGssQZOa/5ZDoytCd
 KMpRDckx25jQZ/bNtpHjGjSHocTgMHn8nRwyO/CZXaYg/Rs1s6IBJ1X50q9cBSNe4Y29
 OUmWi+A0Sw1yT7clmKUaOQ6Nh9tr/V/J20pm3QGXKRY1OFdC0OJ9y6E6qi09KGMem+ZY
 NetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699904; x=1791304704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=cTO3I6C08faCLmD4TiPzOlWzCshAhqLg4RyH2/IoZCWC/DbS1PnKzdozQ0JTN5SWQ3
 eGPyOz4U1LDNbQJNry43cu42Gb/RoyS4N9OKLKVpkapDQFY0u7S2RUiEP3Ff0vTSn3rc
 w5Gt505ibkytbin/ReRZBuX3K74uekLV8lXWbUwo2RWx+dra7LOtYh16YJzFmndqgEwD
 YJHhM8Yq/ekxKmnNcXq2ZNrnJ9TpDzk9UXrntrbcOUS8NbNpB2rkdq8kIhmn7Kmod714
 g/6+/I+IHqhLcNPPRMIdJUUMrYWgUoQ+xeav767jNdgAufSuJXytx54+6ZVIvG05PnGF
 QcIA==
X-Gm-Message-State: AFq9FYJ01x+E19+OAiH03ffTErwtgXYRE5FRuTVFxibxVrzI34qJEyb8
 8PUK7oKpq4ADO88Oa07J/pW8ci5BJcjznWu9Dd6iTXsk/47f+7TRmcddlyB4aGwG+ORoDylrkbp
 HmRnxhgw=
X-Gm-Gg: AYBFou3fO1lqcDnsb5ei+enCXAU47iK3OoAQZY2RtzAYYAGnPyLmMnTfkgcL7fJfi3q
 VZYAgPeeS2iXIk9EuJxxt7VciFBEMsjrIoJ2szxpvEm7UnsMFc8JAWngT8Z6mIvZKwKoGXFrmg5
 JpES3J9W0VQEG/y5OLIQ5+wqCo2vUvDspC7LmaUuwSnuzFE2Lnzy63CpWrH5yVJ8EJmWcphseMo
 XNUU9klTIyni3iaKsUf95J4V9nlOJogkarT0vI18yVKrNgQbhjxLznMOo6NoFvz7HrL4joWwaIe
 IUxt5XBUeKlxK9rkXU7BaX1N7EBC0ytCb4l5K7ygeEzO6jDEncbRO5MKz4T/W8uxX+jfEfxVTSX
 l2EJvwuexNfT/zDBPEzKrOPaPz2F/SSh5zXpHX29G1MCcJA/CiSyzwHFrl7gju7McRS/Nbfh506
 n2PGLzENPzzTirgXOqVoStZzTckYvlXt/KqJYWapUCLPX9ONTfcJLIogEmjbmOZFGStqbPlcgQo
 RnBnt12kzkbzuzu8Rs63l5rQdNfQGYlCNywfvJveZqwn2lU
X-Received: by 2002:a05:6a00:c591:20b0:880:74b9:dd07 with SMTP id
 d2e1a72fcca58-88074b9e075mr6768333b3a.57.1790699904017; 
 Tue, 29 Sep 2026 09:38:24 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v2 18/61] net/failsafe: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:21 -0700
Message-ID: <20260929163800.1108305-19-stephen@networkplumber.org>
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

fs_get_u64_arg() returns -errno on failure, but errno is not reset
before strtoull(), so an unrelated earlier failure is reported. It also
accepts a value with trailing garbage, and base 0 means a leading zero
selects octal.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_args.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_args.c b/drivers/net/failsafe/failsafe_args.c
index 1b8f1d3050..f256a9f6a0 100644
--- a/drivers/net/failsafe/failsafe_args.c
+++ b/drivers/net/failsafe/failsafe_args.c
@@ -345,24 +345,6 @@ fs_remove_sub_devices_definition(char params[DEVARGS_MAXLEN])
 	return 0;
 }
 
-static int
-fs_get_u64_arg(const char *key __rte_unused,
-		const char *value, void *out)
-{
-	uint64_t *u64 = out;
-	char *endptr = NULL;
-
-	if ((value == NULL) || (out == NULL))
-		return -EINVAL;
-	errno = 0;
-	*u64 = strtoull(value, &endptr, 0);
-	if (errno != 0)
-		return -errno;
-	if (endptr == value)
-		return -1;
-	return 0;
-}
-
 static int
 fs_get_mac_addr_arg(const char *key __rte_unused,
 		const char *value, void *out)
@@ -416,7 +398,7 @@ failsafe_args_parse(struct rte_eth_dev *dev, const char *params)
 		if (arg_count == 1) {
 			ret = rte_kvargs_process(kvlist,
 					PMD_FAILSAFE_HOTPLUG_POLL_KVARG,
-					&fs_get_u64_arg, &failsafe_hotplug_poll);
+					rte_kvargs_handle_u64, &failsafe_hotplug_poll);
 			if (ret < 0)
 				goto free_kvlist;
 		}
-- 
2.53.0

