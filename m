Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF0CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA2C40B95;
	Thu, 18 Jun 2026 23:00:41 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 2178C406BC
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:38 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13721dfd471so2239071c88.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816437;
 x=1782421237; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KOgxyli6O9JO8XdG8BI2XIhKsOnRnrPhud3ul5XgO4=;
 b=Z0sjCaW73KxKMza5NZ509akG3js9q/SulgJAxD7UqNzHHxEFGGg83Rm5m16Q/v16M9
 SnmtaUXx7szMH5nCD5VNfpQe6JErKAW0Fv7U0EIVIilmdIwSKMu6Lu+GftqLtcwzUgL8
 +KShIWnOhHmpJu0auTc+bOkBHF4/eADBrgGm6uIv2+Q//leWvSLqpVsTcOcma9tZVsaT
 eFjQX/XLBHEUXhB00uChjLa1T7ad78Zusa3fWPp3K8Ycm9AXBw6a1eXG3Nkoo2m9N0Dj
 c5ZT+4HKEMyue/Y/CYqjKydN+v+TQaufb+z+lXcayotLj2+LSd/whpYUP2iiyIqg7L7a
 YcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816437; x=1782421237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KOgxyli6O9JO8XdG8BI2XIhKsOnRnrPhud3ul5XgO4=;
 b=gg2mirq2Xd4Tl9sySEg8kBom52Nk792Eb2GHJoJBU10vtTBfnDtE+K19D3dkZlKvzv
 Q2/Vd76z6lmQ9RjhGNfnEa84se8t6tODie4Vg5qXRSQpPFiWSDMKXJVdBx8zWCGm/oFB
 bL66M63HMcg+eqBpZZ46MuFFEtUyV6aEGu/hyG61AztnbH2AukJueots9Th/niDpsukn
 WluRUM/U9GYK+Ls+Bz5eXPfhh+Nbgu0JiwUx7jJyuKNcmtW2t6wXJaA5KFjTWXy0/UEU
 mhJSHE5NplLksCFIHKG2Qe3TPMqpnclfJZR0ca8zlH6DAYuKuS9m7VAy0oz3hfYIcBIT
 a/Iw==
X-Gm-Message-State: AOJu0YzdvYRRbhTO8Dh4rKzcX5ZLJYOZoinTEBc387jr5v4LPIf8rxIk
 M3xqlDnNX+hJufPHjRglDav2EvCwWNYsAb9V+XV9bH/MHXbSheDcQw9OGsFGgnNEp0wAilRFcue
 5LAqc
X-Gm-Gg: AfdE7ck/v9HwETNkW3CYXLaisSD9RJB8z2qPkuUqCRv7TWNQIYOoSx1hC2FW+Lhu65r
 BJtqI8sUzt7ggSNNLpLKwJ3nQwqAQYAFdVY1lrgv3aeq/dsTIGzkvUL+3LvnJ4bF8+HVaIeF7js
 2Dt4asVJbMkezWDUOPKzAuWMOsygWOVyYm0L46umoxLZ1JW5G0QA2JS6prrycZWLc1XZprMshu8
 SGradM9++Cqp60PrUmTelFofA1dnXekCcZKvmejPT1hDRdubBdmidSaAXhtOuiJ5zLMIBEbyc8c
 b2gUho7FlfJ3tnYacRdpMUmB8uXhqnuxCHnQlg8VEBJS8b91dsawXtQ/+zx9W7wykXroZACSSUM
 jmFNdnYWsuA09Zasmvhw1hV+1fRExwOe4zM2/+eqAAEeScqB8553d3T7m17iQFIFqVPmNQO8j6Y
 qvvICHLnDmV7BykCw5102Wc9zEiZn02g2pwRvEWTdQODpFO50IYbk=
X-Received: by 2002:a05:7300:80c6:b0:30b:e4a6:1ab4 with SMTP id
 5a478bee46e88-30c0702bd62mr897622eec.8.1781816437037; 
 Thu, 18 Jun 2026 14:00:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 4/6] test/bpf: check that JIT was generated
Date: Thu, 18 Jun 2026 13:47:08 -0700
Message-ID: <20260618210026.430288-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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

Avoid silently ignoring JIT failures. The test cases should
all succeed JIT compilation; if not it is a bug in the JIT
implementation and should be reported.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index e70dea736f..3a88434c3c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3590,6 +3590,14 @@ run_test(const struct bpf_test *tst)
 				rv, strerror(rv));
 		}
 	}
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
+	else {
+		/* a JIT backend exists for this arch, so it must compile */
+		printf("%s@%d: %s: no JIT code generated;\n",
+			__func__, __LINE__, tst->name);
+		ret = -1;
+	}
+#endif
 
 	rte_bpf_destroy(bpf);
 	return ret;
-- 
2.53.0

