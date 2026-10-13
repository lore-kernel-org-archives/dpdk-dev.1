Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562FDCC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48C0C40279;
	Tue, 13 Oct 2026 15:36:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D2EA740272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:36:10 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB251169C;
 Tue, 13 Oct 2026 06:36:06 -0700 (PDT)
Received: from KDFJ2LQKPJ.cambridge.arm.com (KDFJ2LQKPJ.cambridge.arm.com
 [10.2.197.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46E7E3F66F;
 Tue, 13 Oct 2026 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1791898570; bh=kvW0Yh5Tvp9tQrwu1W5d/cVq8HlRjHh559tXnpsxp4E=;
 h=From:To:Cc:Subject:Date:From;
 b=Q9EHsygQ99UesmaPXBEiagUX5BDKKCwDecdkeNRIRxjuZyEpcyfuvDzhlGlyq6i30
 s6zZ/v1eGDN0Ysw+Dr9a1v0ulpwlopgT1nMorcw+JflUurhSv2qi8DfS1cw4vsmio9
 22SkFQW5pbEI2T4fwuOzDn7Ai09exOMf6+YLpWbw=
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: Akhil Goyal <gakhil@marvell.com>
Cc: dev@dpdk.org, pengpeng <pengpeng@iscas.ac.cn>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] crypto/armv8: validate xform auth key length
Date: Tue, 13 Oct 2026 14:35:59 +0100
Message-ID: <20261013133559.65758-1-jack.bond-preston@foss.arm.com>
X-Mailer: git-send-email 2.54.0
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

Validate that the provided rte_crypto_auth_xform's key length is not
too large, and that the provided data pointer is not NULL.

Previously, providing a key which has a size > SHA_BLOCK_MAX will cause
the key memcpy to write out of bounds. Since the rte_crypto_auth_xform
documentation states that it is the user's responsibility to validate
the authentication key length, this is not a bug in DPDK. However,
other PMDs are validating this, and it is more user-friendly to do so -
with negligible performance impact.

Reported-by: pengpeng <pengpeng@iscas.ac.cn>
Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 drivers/crypto/armv8/rte_armv8_pmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index a7caac186d..f4ddfb6395 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -262,6 +262,13 @@ auth_set_prerequisites(struct armv8_crypto_session *sess,
 	uint8_t partial[64] = { 0 };
 	int error;
 
+	/* Validate key */
+	if (xform->auth.key.data == NULL ||
+			xform->auth.key.length > SHA_BLOCK_MAX) {
+		ARMV8_CRYPTO_LOG_ERR("Invalid authentication key provided.");
+		return -1;
+	}
+
 	switch (xform->auth.algo) {
 	case RTE_CRYPTO_AUTH_SHA1_HMAC:
 		/*
-- 
2.43.0

