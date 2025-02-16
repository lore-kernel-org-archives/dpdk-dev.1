Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3393C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFE5E40ED9;
	Sun, 16 Feb 2025 18:01:37 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id BD2B340E3E
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:30 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2211cd4463cso8993645ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725290;
 x=1740330090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhNKU7vZcxq5FB0scX4PLj+Qg9WKGbFWsm6xVFz3F8s=;
 b=f3q+1tBla7/GADgZf1BP2jn4yxSzaXjNJX4UEC8WP8uEDiEjohmhAsDLIz6n0N3+LP
 4Jx6Vgk0sdP61v4Wvq2Ce0PUzx0kpQbLyTCj6u22sv2xTwQC6SfFTK3FWK7RCFgJ8LAk
 Bt77LmkiLa+i/fQ+xQLJSXYJarhLRRPcocMUmjBeL6B4iC5zDuakhP8ExlMdHJvCLGZb
 6jF/weBafOep4dgM2eUfJAF7+i81AhsPYhmyTnDQ7d+8R9ytm4PMXEXKyea80Q31FOIe
 Btr0l8IoSOroLZ0Ib2+3eHmNIj3jEQh/kRmcB90O1JFBrPN/U76z1A9Wt982nVzzEsIW
 qqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725290; x=1740330090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhNKU7vZcxq5FB0scX4PLj+Qg9WKGbFWsm6xVFz3F8s=;
 b=P4q0LFQ5v6/jdmEbyc8iK8pg7JVaOz85OdaWoSRJpO/pYwJBpZaBqLBfKZsRx/4WR8
 f4ds8x73tqo8H0T/X1yqHTkP0nD4iMZQ/lYBz7JSjNf6uHV2k03o0yTg1aFjo5t4/6Jp
 y4zf16F5h/cUYU9OeyCTW81pWNnt6dUJYviGAEVlioIAMSAjzLAhoJ/pSLyEv49SaPPk
 AyQnSxWfRA4L+SFSRMk+GpW2TQfzsXOBgt3Q3nU639QZy5ym9SO+2nC0+Ig9a+wCvot/
 i05LbHRkg5WYOB3HB4ctzkpsy8dUxCk6GWeesDKldEBrvNIbz6CFsKFjPm6Ec7uj6von
 MvTg==
X-Gm-Message-State: AOJu0YyNQVerBMXJSnpX06mfmwtIOkqfyKy41CGL3LCnpYu2jO65JZQi
 S6/ybonLX+rfurgWhp48vXdBrq55SexuuoZybWP+3vC34QYXMea/6acpw8r+N3ZLkGkHRtLlFZR
 o
X-Gm-Gg: ASbGnct2zhjn/DJujLBOEhNhtStuBk4tr826udf4IKfODPXmjB5th5GVAw6wWJdZOw5
 2QbW6wlT7XWUzd/2oYyPyzQjcnWWAA5VZJCFCotJ6vqWteqvX+5P72f3BlG7g3RJxwT/RHrBYSG
 HA1pbhkiOc+JODbrrWcuT5qfalfuwddvyS+qY46BbZgIhLemo6CrOt68uTeiTNm27ixIfOFtmBa
 eWehxAFX7Ed1JHawrwZ+K2XJ/Uxx4klgytMVuOi7DsgpDBuNo/y+nAY3Fv+n4jYz7No6404ervu
 7tqldlp3MqEezOUnBFtWNR47fK2hwUhzxQ1leOtszjzYcE19JxbpHXb6EEDXiP4FYv8T
X-Google-Smtp-Source: AGHT+IGPycg8FBW6tHsyefN++7Yht48E1Y1LAzzROr03c9gNWaGJoieD8vHSKQ5nm433ngfahNi2dQ==
X-Received: by 2002:a17:902:ce0d:b0:215:9894:5679 with SMTP id
 d9443c01a7336-22103c5f5e4mr116565245ad.0.1739725289962; 
 Sun, 16 Feb 2025 09:01:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v8 11/17] crypto/qat: use secure free for keys
Date: Sun, 16 Feb 2025 08:53:10 -0800
Message-ID: <20250216170110.7230-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Regular memset maybe removed by compiler if done before a free
function. Use new rte_free_sensitive instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_asym.c        | 5 +----
 drivers/crypto/qat/qat_sym_session.c | 8 ++++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index f5b56b2f71..d8a1406819 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -102,10 +102,7 @@ static const struct rte_driver cryptodev_qat_asym_driver = {
 		curve.p.data, curve.bytesize)
 
 #define PARAM_CLR(what) \
-	do { \
-		memset(what.data, 0, what.length); \
-		rte_free(what.data);	\
-	} while (0)
+	rte_free_sensitive(what.data)
 
 static void
 request_init(struct icp_qat_fw_pke_request *qat_req)
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 7836c95064..fd2cc94418 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -1739,8 +1739,8 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 
 	/* do partial hash of ipad and copy to state1 */
 	if (partial_hash_compute(hash_alg, ipad, p_state_buf)) {
-		memset(ipad, 0, block_size);
-		memset(opad, 0, block_size);
+		rte_memzero_explicit(ipad, block_size);
+		rte_memzero_explicit(opad, block_size);
 		QAT_LOG(ERR, "ipad precompute failed");
 		return -EFAULT;
 	}
@@ -1751,8 +1751,8 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 	 */
 	*p_state_len = qat_hash_get_state1_size(hash_alg);
 	if (partial_hash_compute(hash_alg, opad, p_state_buf + *p_state_len)) {
-		memset(ipad, 0, block_size);
-		memset(opad, 0, block_size);
+		rte_memzero_explicit(ipad, block_size);
+		rte_memzero_explicit(opad, block_size);
 		QAT_LOG(ERR, "opad precompute failed");
 		return -EFAULT;
 	}
-- 
2.47.2

