Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BE607233D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HUVxR4JL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783EC427CB;
	Fri, 13 Nov 2026 17:05:52 +0100 (CET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTPS id ACF994028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:07:55 +0100 (CET)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3ae25c9f857so15311411fa.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794578875; x=1795183675; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ty+upszSz179cWEvaljxwCTv/Pz9czQrD/ChDg4gS7c=;
 b=HUVxR4JLuBh7KgMrucSYoACMxoRiSq3FPgEWTDMu3suT5L+FOxEn+7+hKeby15oDvr
 YEDQYw0+xldsQCg+TzaEPJkev5qEuID5PIsjEHt+IPIHgjG9fPesDpeueeudvB5pheMm
 +zVX/Iq0DG1nzOqdAeXBFcsIOi9P5OQDueoSoXBj992R+KMaCh6wTJpavd456lf/Y1LV
 7J3pTGyXPAWFnmhrvCRHSMk+lDKFL+VjsmbQMllSd/Fi7RwtjlNG7h4hXoflEg7cX9bE
 lan8SqPdTeDkbR5XRa9G9CfrNG1sS+Qs2dd6lejTHXAckhAjAYu46NCMkXMdG+AW0DsK
 xnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794578875; x=1795183675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ty+upszSz179cWEvaljxwCTv/Pz9czQrD/ChDg4gS7c=;
 b=qnSALocnZ3JbF37zwcuuoTAe9JkAvqF4dvVHCqIEOIJH8KAbCMRSKx+/60Wdp3SSax
 SV2PVZti6C4C44C+1XzVpHuS7BXRc+17zlYmMNTICl6dEZlhlTrRIRnJ4It000T8WvE4
 OdNzM/dblTDlhoNvRLVxKCAr1w0U5RpGwjxBLo1Yh6Y/kpYBn8dZBPg2wlnCIy38QLEI
 8GHgqvAfrhZcmEiNNINgQUIt4yetFAiqTIBYLIvmK9UHViN2vUm1TLSmS0+BZwMdW95D
 ryDSxlzl9c4lixt0Xt97bCrdx5DBPNLtlfIFZwHAEgq+Tu0XhEDJXpdTFubkIK103uRh
 Qqeg==
X-Gm-Message-State: APuU4Z9jhSAR7MHy5KDdeoPna4F104tYDTSto1TT7TCeVSUKjz/Y9iZR
 t+k1tjYhJdH1O4sJStG+9Lx4zbjm13GG+DaZDaX02btUu/XDvmdnT1s8
X-Gm-Gg: AYBFou3dLLfCvfGRkBgetKqSKEMwejWnTIds6OWHFwbHfQ166C96nMae0FRafdlFNPW
 kWeeO3J0WqnKH0szrTbPUin32vv7rF/JCERwi7+ywGU8bG68UnnXIlD8zsZca5aFVNXtSw6fZtA
 0pFwz3hQxqMlInYanoDy7AXvUkLmjnq2F4OhOQ2BpnXLMpUg+r/p/IAQmfVXo4+pn8GRZnNMzq6
 2l7ZjMK0L0nZjg5yu9yjLABO9zjxHS4kdfQruEHZNvYU16UtoFEqmy+8T+NAWCIKQzccIKFmFw/
 cBRAlz/74TUldOBNTD/1ft24EPw+RRjFsRhALjmBEHGMurjPsBwai85qn7NKJe1HpDeSidUMCgJ
 Pmw4gYMD+PpM1LinTn99+LHWVS8Wo49XdpwS6SuhvxpfBQZAIJx9Q6c9UCSDa0haY0VlDKgsSNc
 +zNludgRAwRfsSW1uRKGCXteBzc8drsVFGKq8lrm2pNfD/C4+CcW+7mMl0W5xjo4sjBsmmimWoL
 Mq8hq4C4RcMHOkOLpkquf8ijgg67oWaSXCtWzuEP9nIah1a4HTJD27hiK/6IbAToMCJfL5pafsp
 fxShpFTU4LYKvjDy47rhbSkhZPJnJ90E1AH7E59lsgY3zKWK
X-Received: by 2002:a05:651c:a1b1:b0:3ab:a27a:882b with SMTP id
 38308e7fff4ca-3ae2b53b584mr8061211fa.14.1794578874459; 
 Fri, 13 Nov 2026 06:07:54 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b7aeb67sm8957761fa.27.2026.11.13.06.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:07:54 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Sony Chacko <sony.chacko@qlogic.com>,
 Rasesh Mody <rmody@marvell.com>, Harish Patil <harish.patil@cavium.com>
Cc: dev@dpdk.org, stable@dpdk.org, Mark Bulatov <ms.bulatov7@gmail.com>,
 Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/qede/base: fix division by zero
Date: Fri, 13 Nov 2026 17:07:02 +0300
Message-Id: <20261113140702.4485-1-ms.bulatov7@gmail.com>
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

In the ecore_init_wfq_param() function, calculating left_rate_per_vp will
result in a division by zero if num_vports and req_count are configured
to have equal values.

Fix this by adding an extra check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ec94dbc573 ("qede: add base driver")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 drivers/net/qede/base/ecore_dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/qede/base/ecore_dev.c b/drivers/net/qede/base/ecore_dev.c
index e895dee405..2082971b0b 100644
--- a/drivers/net/qede/base/ecore_dev.c
+++ b/drivers/net/qede/base/ecore_dev.c
@@ -6481,6 +6481,13 @@ static enum _ecore_status_t ecore_init_wfq_param(struct ecore_hwfn *p_hwfn,
 		return ECORE_INVAL;
 	}
 
+	/* Validate non_requested_count is non-zero */
+	if (non_requested_count == 0) {
+		DP_VERBOSE(p_hwfn, ECORE_MSG_LINK,
+			   "The number of vports is equal to the number of requests\n");
+		return ECORE_INVAL;
+	}
+
 	/* Data left for non requested vports */
 	total_left_rate = min_pf_rate - total_req_min_rate;
 	left_rate_per_vp = total_left_rate / non_requested_count;
-- 
2.39.5

