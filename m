Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8246C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C13FF4065A;
	Thu, 20 Feb 2025 17:42:14 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id BF5384064C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:10 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2210d92292eso33183565ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069730;
 x=1740674530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhNKU7vZcxq5FB0scX4PLj+Qg9WKGbFWsm6xVFz3F8s=;
 b=ocLtpurSsHLDAZzlkPLWijJKUgW8tje5XVri9Sb901fHXh+13Ka4oMsw7TqFD3SCvB
 +bcpuM9rzn42hXW4Dq9jNLiVQalUEIVXBomvjY4sZR2sQnn9qftihPKfmNsAhoSpUkfo
 FFJipmOAmDPj+LBagFszN5lFVyOYQDnYYKqtvoTV6M96dYgwKRePVy68Ute0kX7hhu+R
 /1nCKpyDTW3x7hmRB2vh2rwKtE0u7myTOv4ijkGF3sUR36upWCOXWGZ7lhMZEg+FmEtM
 36Bd49hP40iLoq0TnkYFaVBp6DA0DBvhic+SNWL80VIV/09VT3+xFNtDV9hZjslGPi0G
 DMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069730; x=1740674530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhNKU7vZcxq5FB0scX4PLj+Qg9WKGbFWsm6xVFz3F8s=;
 b=YRSnvehpfA7uE5M6X2uk/MHsH/ujQYxH9Zsv3qsidn4bee65RjqupUtzkChq4s4BHd
 tE5rjcphY+i4XvUFxLcJU5P59/0A4E1wrVTMofO3vI1u3Q1Z/CxPliyb9vLMkuBSrCzf
 hUgO+TM1Q4XspxKic23QaZ+hFxKxFS4LRPYDiR0Llx2xDq7QBmMs7X8nrMQYZdf+cREq
 aNVRAMd6KFPT0mr1VxHyogET32d6REnGfrlCRnQzzY0/uNhly+Iw+gQFjpFumT5i2YZY
 Kby+ITh7TbNjFtYbMLnGwCGSo75Zgm2WQUfBnuw6xDjRZpaJn0MQgII94rvy9ZcRC+US
 j5yA==
X-Gm-Message-State: AOJu0Yyr58hIZEI7l+15Zo7324wTt5vMql70L+X0B7oLck2HnUWEFEGj
 LK8ysVmWIANwZoO1zILi3DXoDC995yh/U7TN14TPGDE7H5lwhe0W9gRXKD0oJclQCAsHQ4dNXmk
 H
X-Gm-Gg: ASbGncv3q6Vmf/WXWVxuhnHO0SOeyL90egwM6iZSL8Hx7CCbwtsO+9YHS7F0ns3xSMD
 /QtvnOh1ERq5xke2orzzaHJ7H6p5EYd7KlRCdTfu8y87z/Le2RluFEP3/t2PuORbP/7w8f+a6Vc
 /+V7hrKowC5MuxC8EMV9JT6gHpdAh1z6HlNbA8Fd9Fs0XoriUyQmIAHE9Xa8+Cwk1nxIyTIlY2f
 38dmPsf2BMr8jObXTNhHtEOhCflarrRcSUD0NLVIGehufV+06E3shFKldq63keCtkhBMck5Y4xH
 3GZ+vp6ZZbD2xAyCQOB6TIIn0JtT2Rog+kDodgbeRJ+yWyFwb+JuX/XdfUA7IbMT40Sk
X-Google-Smtp-Source: AGHT+IGIT2ytitcUV0/aTlgLuzz7nAP8VGQ4GVvxHuwgNFY88mRWQnA5kYpwD5p4vfGOdzwiLJHc9g==
X-Received: by 2002:a17:902:e892:b0:216:3e87:c9fc with SMTP id
 d9443c01a7336-2217055f573mr133805835ad.5.1740069730033; 
 Thu, 20 Feb 2025 08:42:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v9 09/15] crypto/qat: use secure free for keys
Date: Thu, 20 Feb 2025 08:27:15 -0800
Message-ID: <20250220164151.9606-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

