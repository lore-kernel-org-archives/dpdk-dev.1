Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF60FC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 19:37:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A27C42DE4;
	Wed, 21 May 2025 21:37:37 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id E2632402CD
 for <dev@dpdk.org>; Wed, 21 May 2025 21:37:34 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6023cf146d3so2163317a12.3
 for <dev@dpdk.org>; Wed, 21 May 2025 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747856254;
 x=1748461054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rR3JzN6IjN+a2ChYdQ7DkiEKIctrp6AJZv03tt52GzU=;
 b=eT/BSzX/esGPpq5niJnK6THWicfNIO29j199NPlbwb8NjagErVDmRLhHtkaQDyHHsn
 jl38/QHl8f6sOQ3w7YmO2tG337FngGBQNFjTGZV+LNxGKik+V6PATRPt3HI7LlO0ar4Q
 UesQPJ1fVSutsNlmLWZqO912HuuAxukGzzyPmCQJQwIqkaL8Q+DmD/EmEyjA8H8YbmWD
 65Szh5IczFt/5igZRmIC1AIU2wzESFne1BuAR0ok3cySgAhiHnCGYQwM6ugQ0v35aKYA
 d3Rbvgu7u0/lDR/mG8orXFRVCs6A2D8YIoweA7/jH0IGfoe7kmXHg1ZeZT1aZyWWwCef
 n10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747856254; x=1748461054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rR3JzN6IjN+a2ChYdQ7DkiEKIctrp6AJZv03tt52GzU=;
 b=Z1uYuVrXYd96zrINgSLe3kvz6qKE0+IFLFOjixkkezVwBm3hmJjszbqEBX68r0HY1n
 3EVXBnlrSjSm79l4divFbkW15uHpifvw2GFPxfLQzMb1tgi+uZyOF71f/s7CrSE/nFpw
 VT7V8wFkz7Omf009I6ljlpL1AzQwZ1BdZ4uYKDu+tXAaafIL84zRqO8Jnz5MdkjUGWr4
 BGmCwh3n/qiixP2cCjaTXjsabWb0i9L5NzyBjFDDV23I9PE0xmKD+xkNTDLuR0cPw3nO
 udPeUFxpYi2vlQMKzXjkqSEsQhWmlXSb/CzIrsEoBO1B2gXP0w6TWp+wVD6A1dMM5FNJ
 7MSQ==
X-Gm-Message-State: AOJu0YxOjG5IrFaxcrxSho9Kj5fscYZr77ctVW4+4qWRA5k1JVmIbzh6
 N7D9teoGOSYPE/kgrNDZdeVNWAQXYnpdZHPD4WZlAckzJte8qn/Pd8RA5ntR49GL1LUZ1rF2EtX
 etyP7
X-Gm-Gg: ASbGncu1w2R3xRz2MLK8D5Yh2KTT2Utj/n4HFXkN1iHCET9U6W9DWVoHb9QaIASldcd
 lFIXttAtfMqQchyU3hjZF6atCt95GlMNeHNYJotTqBAUq3w2EPdlX8kYH+6HGnGmPcI9DpVAn+G
 itAl/4hDrw0Ghru+C6ypkgh5jH/nBLUlfiauI4L6QCprNgptdlsZ+5d1W/T9YBKJ5FeNptPcXa4
 +LCLi0ig8oXGp1LwAYPkSx62Z1SfYFPIZlmXQrpb2+NmDkCQGC0DgKaVtDV9olNH2EdkBbpLSnk
 raxT5leebo5HuM/hmeSeYCj+9x/TImvEmGCAB4jfbowz7FZyLYOjk1xjN2NRZd+nXKsdut2Ev1B
 A+cdurJc2818XHG8lMskL25rdpg==
X-Google-Smtp-Source: AGHT+IHIXjEIqa+9U3fF5WMnjkmwEnfsgmc8LHpQ3mtcFaX1kHs5sB9O9+dIEZjcBedYdkb/afZ6WQ==
X-Received: by 2002:a05:6402:2789:b0:602:29e0:5e2f with SMTP id
 4fb4d7f45d1cf-60229e061e6mr5094129a12.10.1747856254177; 
 Wed, 21 May 2025 12:37:34 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d4f2cd8sm9339438a12.15.2025.05.21.12.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 12:37:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>, Jay Ding <jay.ding@broadcom.com>,
 Shahaji Bhosle <sbhosle@broadcom.com>
Subject: [PATCH] net/bnxt: fix free of not allocated object
Date: Wed, 21 May 2025 12:37:27 -0700
Message-ID: <20250521193727.382342-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This was found as error when compiling with LTO.
The function allocates new data with rte_zmalloc and then
stores pointer in the pointer-to-pointer passed as argument.
In the unwind case, it would call rte_free() with wrong one.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_core/v3/tfo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index bee813ebf6..c888dd1e4e 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -74,9 +74,7 @@ void tfo_open(void **tfo, bool is_pf)
 	rc = cfa_bld_mpc_bind(CFA_P70, &tfco->mpc_info);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR, "MPC bind failed");
-		rte_free(tfco);
-		*tfo = NULL;
-		return;
+		goto cleanup;
 	}
 	if (is_pf) {
 		/* Allocate TIM */
@@ -104,8 +102,8 @@ void tfo_open(void **tfo, bool is_pf)
 	return;
 
  cleanup:
-	if (tfco != NULL)
-		rte_free(tfo);
+	rte_free(tfco);
+	*tfo = NULL;
 }
 
 void tfo_close(void **tfo)
-- 
2.47.2

