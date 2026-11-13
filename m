Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57391607231D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvQ36aCL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A954C427C4;
	Fri, 13 Nov 2026 17:05:51 +0100 (CET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 337454028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:01:46 +0100 (CET)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3ae0eb56ba1so14039081fa.2
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794578505; x=1795183305; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbe1CYDmxe08hLBy3TKTMrglATvyWyxrPegFOvqeXDo=;
 b=hvQ36aCLNBJMs7NnxT20hoHE1KXUb5gYhJzT20YBhEZYI8FaaDSm1ECq9ZEFZbGLiy
 HS8rqF+uVAOslfLLKX/KOCYEXakMBBECiCJdmj9qtvwgv7fxx/EMrLrIBZarb1X8zSka
 7WZBsSMVwhxEdIbptqgfc8XSx+8+/shi+05QHfu4B2h7JghqFDaRc7D3FMkQ88E+Bgo9
 hc2tAkH42HhawECzL5mLqg0m8UV3ZhfWeCJHFg005sPKmYH2gSpa3EzYegaXWK1w6jRk
 84aBO4aeC6VA5hkw7B2ER2i2vee/XEeJr3d//e+pDaJsKkWBI45tG8FUbkeIBqcwlq+/
 2ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794578505; x=1795183305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbe1CYDmxe08hLBy3TKTMrglATvyWyxrPegFOvqeXDo=;
 b=I0oU5d0SiYZomBVnxnNWs90C4QzDjKexzllTce+CZMgxsiQoPnpUGtsscgJnsMphYr
 Z9Eevcojw39U5N37sN8kaXBvjBePkTN1TDwng1SxzZICX94mRk1s6osvQfA1h1K1w0Xy
 qg7Y2I8bsnBaDiAQE61EVs6HD/1uTVF5GpzRbalepRBBUZbYPT+91/Ytci6Qhn+Z5HyO
 lcuf6WB/J46QGkHXZ52kFJ4tSAkph9WphCr8bKHzI5hZQE1zh8WUf0WVw+CEBuxEmmcZ
 nRPBOsYvsIxZYlmz4z9mUh6BEoLlJXltjdpR4IcLDXuyOfBYGrZc/UwMmQ4UPVp0/uAQ
 yZ6Q==
X-Gm-Message-State: APuU4Z8SIEggfwEzzKKPIMCujJWvEm2vT+KlW1B3IIW8SsX9FSL9CyW4
 m9ZrK2z3I8SyAU6vlxoekgJmuodc3nc3XrYNntsxtT2vqp00cWhLB5nH
X-Gm-Gg: AYBFou3tLi1YDE6L4XhHxaEF3WKALRx8dLd0Rx9q80G2lCCSkbW4TNzeIm+bz9OrcmH
 X3c7w2Tn48roACTEzv3rucyDHYdQ2fvtUho6KyaFn9Gry+mPmLe0EKTiq+WA8SeGFYbDvbqFBC3
 Kj7Av5zNTUN5t0efiJjM9nA7LOH1E9dTt7U6dLcwwINDALjf35jLFm9VS6nooC9I+2RmCQ6kyl4
 JsP69fyUTBgglGqc90xxAVHNNpC+KupLNxBSYOfegzITUPyDAkI/gBYBvu09PchqEOg9eHwx0Y2
 rNzH6y6na6VOFsPVl8ZBDjqCIuw2kRaxeKHCeOtQIJi3zzg9eAzKafkTui246uYH5eezaUacUy4
 Jh3SK8egYJZAEFYG9tywM6fpg8RbTjknGrxaMBMxK4hU2YapWsueL2c4WmvMgOatxmujCxC0AJa
 H3NF2ZEHNO/hbr4TqNWzsEC7RD8evQail3du8Bm1pBt+N6bijhCPZuEVXwTQvbzDAdo91xFUFV5
 RVCweUd2HsI5qSW+ZRS0TXS8ldG4kzmlj6gu1XbhMCvMiRy0H8i3te4eIRfqfebUNZZl76way/Y
 FgpCxP0GW2MPvOPDHtrVuolpnoJ+qSRwBwDH84yRYQXU+Mfd
X-Received: by 2002:a05:6512:158c:b0:5bf:be4d:13ac with SMTP id
 2adb3069b0e04-5c1709f7211mr934757e87.50.1794578504908; 
 Fri, 13 Nov 2026 06:01:44 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1712db025sm786526e87.6.2026.11.13.06.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:01:44 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Rasesh Mody <rmody@marvell.com>,
 Sony Chacko <sony.chacko@qlogic.com>,
 Harish Patil <harish.patil@cavium.com>
Cc: dev@dpdk.org, stable@dpdk.org, Mark Bulatov <ms.bulatov7@gmail.com>,
 Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/qede: initialize ptt to prevent derefence
Date: Fri, 13 Nov 2026 17:00:51 +0300
Message-Id: <20261113140051.4300-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mark Bulatov <ms.bulatov7@gmail.com>

In the qed_fill_dev_info() function, ptt is passed as NULL into the else
block, which will lead to a null pointer dereference in
ecore_ptt_get_hw_addr().

Fix this by adding ptt initialization.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 86a2265e59 ("qede: add SRIOV support")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 drivers/net/qede/qede_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/qede/qede_main.c b/drivers/net/qede/qede_main.c
index fd63262f3a..1aa30a0462 100644
--- a/drivers/net/qede/qede_main.c
+++ b/drivers/net/qede/qede_main.c
@@ -415,8 +415,10 @@ qed_fill_dev_info(struct ecore_dev *edev, struct qed_dev_info *dev_info)
 			ecore_ptt_release(ECORE_LEADING_HWFN(edev), ptt);
 		}
 	} else {
-		ecore_mcp_get_mfw_ver(ECORE_LEADING_HWFN(edev), ptt,
-				      &dev_info->mfw_rev, NULL);
+		ptt = ecore_ptt_acquire(ECORE_LEADING_HWFN(edev));
+		if (ptt)
+			ecore_mcp_get_mfw_ver(ECORE_LEADING_HWFN(edev), ptt,
+					      &dev_info->mfw_rev, NULL);
 	}
 
 	return 0;
-- 
2.39.5

