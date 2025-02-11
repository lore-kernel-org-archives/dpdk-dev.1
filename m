Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81605C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF7A40DF5;
	Tue, 11 Feb 2025 18:37:41 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id C1D3A406A2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:37 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fa2eb7eb45so6621043a91.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295457;
 x=1739900257; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=yJubrkNLUBDFbW8tjdm3GShYnqXbKv4JmbKz0mt3+DyDIE2QNGtcrWXrMGuzK3mgg5
 fl4hN5pkFPRVrS9gCXSpA8QyoSkk/NwpkXwNvul2WcPKgIBzv4xuOgOlBYisF0zzqJaW
 /xGaYlGVL7tIFb9UK1yEafkbzjSLAvJvmNMYORcPzOGeyTIp1GWkQgFrtqATnrBaeqAT
 N1TavsJPPWutOIoWgTRC7l+iPQXD1nu95YilhUa/Cs8QkEmbnZAVOll8OLna5PWUJqt1
 1eizXHlupTMGnB0LF809maQ1Ox67CXGvnXgwC5i8ZgkHYwMsiaLirAHA0XJhkk2Fw+xd
 EwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295457; x=1739900257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=kOLkX/4teWq7RNag3GYjHSKSHyRJAYLyEoYlWIo/lLs2l5ZHSfj9sF6fMVw0uYYqzJ
 ZuVr6htX99ynSo+UWJo5Mn+10aX0Y4YWBpHWc+U+CsUAnAqxyfdnTvv9ABX4E/sKV2vA
 vDngfKxnbTpgrVLjwoORqSVhwfFN36qLZ68PfWWJuj63mYWNQSMOkJBDH6LKJW8BMtNn
 7GlVbMYEPyNbJuQ7hZM3XlvJwNDlWLoMVNt/E2we9KmLio1gL7YN777/srjo8/5XB0eX
 rYixxwQAEZRyR/LpkhT838XV1GV9wb+QgLIjluhlP40ftG1XoDB8lseaHYhtrxcflgtM
 +zcA==
X-Gm-Message-State: AOJu0Ywo83d1UFAcJIQsx8v66sZFuz0+fKck73LAxDzfAaZDHbcBg+kB
 0PV3iNg7Ss5ScJ3yS1KiEHQbO8WpHucoQcJeWBLOJ7a1k7UXJkenoltQ5MBCZukE1sF7SZ1oRgy
 u
X-Gm-Gg: ASbGncubrqCkiPsROe8u/RO5nnt/tlrkBP/C+4TPbQbG+dE5e9l8Qk2dUhb2x6RIwVA
 ufPK21X8mu0V2wUCrDLgQoopRocZZgjmtcVvH3xtp45JSx6cg8Jk6ICDIwMFVUuEpmmH1PgN+zd
 YAVoXtXPmm8aLrcr9jhpDg9QmhsvFi/gcVf0s+lS+WqmtbphkR1V7IvLblTRLFfDRTb5ZWNrrHh
 O/7OoJFAWzPFqB3HIxVQHiLTdvslcWks5KWSBzoppEqJFLhm2f9ClHLkj6J9QHIyfM5VgtZKXfb
 RGyqjZMYXBhFql/hG4tvyE8/fyyaKUe+C5aO5CPGe3897jVi/dBPaYTqaYb34EB3+QaO
X-Google-Smtp-Source: AGHT+IEl7GJ0b9Q227TSGzcgj31qwQdfDASKwwiRXY+LhSWmxoAJ/vRLlV/73lZ/0jnzw+CFcnzRsw==
X-Received: by 2002:a17:90b:2b45:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-2faa0913acemr6288150a91.9.1739295456913; 
 Tue, 11 Feb 2025 09:37:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v5 05/11] crypto/qat: use secure memset
Date: Tue, 11 Feb 2025 09:35:25 -0800
Message-ID: <20250211173720.1188517-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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
 drivers/crypto/qat/qat_asym.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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
-- 
2.47.2

