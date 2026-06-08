Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F0CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 20:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4819A4067D;
	Mon,  8 Jun 2026 22:33:29 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 3D5F740666
 for <dev@dpdk.org>; Mon,  8 Jun 2026 22:33:28 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-138188a7dccso4929166c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780950807;
 x=1781555607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpomH5xEo1IVmoZUHGsj4pBSAgglM2zOVzI3WrU/n+E=;
 b=a/mKsSyfO3tXRufE9QeviGmfXaozMnDlMHykRW2lvav3/fA4FMV9CLuQfXVFRD1rsE
 pkr/ZSkStFwN0d17Nl923vJ9JXiUD0nJOqlXxmW7jLWLNmCtaPbnt5Epn4tTQTjtZQLO
 ORWsSN8VM9x7zw9XLveIgHkE8y7FTMHduxqZ42tHsrgFCN2NhJnQBvthhoAGB3rz8+Y6
 646Tx042dt6NNXAx8IlCMVI6ZRl1fR6qJ8mC67TzXB3pmuPOmcdyIcLOr5GGoDPbGAld
 LCD+R1gBvlCxH+KKKn2NFQrkQ1zp74T3MLoGAovqWhGvxHu9RF9NdFoNGTqAXBRCCjzF
 HXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780950807; x=1781555607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpomH5xEo1IVmoZUHGsj4pBSAgglM2zOVzI3WrU/n+E=;
 b=SEfycjev1JLhO9VtOjwNHNOV6vxzzjNVAlRI56hAd10Q7OxSckwkhl4IFLzWzOaI80
 0sUK+Ao7a4/yCmcIcZJxTDv94z4a6Y/krMF5xdAiXVgEn6HVeWgfAU6i0/T0GauN2S1S
 qRSmx8LHuvxvd9meO5NBNn8sCi0fwgvkFjA4Avbu6IH5wMcbc6WTlkr/ejL3T7dWQn0/
 Vv+WDMU68AOm5lyE0+lv4EIUhlT4In2OLZv9G4nYxEyIm0yvPRYXiezaZxbwXwvUcTk5
 aC78sFOBpvkDbtMNbgRzI8b1dKrMVP1wqkU5YQzLG2ObDvXl+BocTWf25Nh6E9YWuUgj
 9rrg==
X-Gm-Message-State: AOJu0YyyeFpwDyOx1ywpzaLD/mC6p6Njqu4c770UGL9+5uRi0/Y6RBxO
 s86WuJppAYAxx1mpSj4MPgaX3aayNMO7CKobWamPcA/fCRnSkEWcCj5VJb+Ke7QBQXWRsRS8he6
 81YeV
X-Gm-Gg: Acq92OFiln28bkQDrhF3BGoywidxTdeamHzZ30vOd27WfUFRUzIbKkDN870xTFqWD12
 7V0OxbNTB+/xB5px+CjjpKiKQuJOWkIbQf0m7Bl0r/AHpFmEhNahzpB6F64YTaawR0uyCOUjslX
 nPcV3MwBfoItmPnzQ7g2C4lwDBxdRRleILVItv3zbabd0LDzKr7CuDev9N8aBnFRBQEbH4kM7wQ
 QMFXf+zAjCaUSNDQAX8swD7MSVvZKe7eq4GQ4TQEF9GWD9YIfW3/aAC1ZQqp4jIKzzLLSQBXvJm
 RAYu93zF4cXKZdHMhrxF6lodOw1yv+uTA73rQbGvoeZQ5eu4Z8IcCe0JCE/SOB6KwcHOpxHt80L
 ZxqYVUuifPH1sM8BK2fkW++QjmKpAZxt2qOLofm+IwJX7xeB3KCNG1wpnanxmHvk53DzYjun9Br
 ZAZH+y56MeA64CX0PuQmZJ4OvHAFpLEbajL/W8rm0dTl7TqlMennixNn7ijL0f3mhTuUYTV3PEe
 AF0i0dztXg=
X-Received: by 2002:a05:7301:4342:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-3077b08e49fmr8955379eec.14.1780950807167; 
 Mon, 08 Jun 2026 13:33:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm25804178eec.5.2026.06.08.13.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:33:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 2/4] test: bpf check that JIT was generated
Date: Mon,  8 Jun 2026 13:28:48 -0700
Message-ID: <20260608203322.1116296-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
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
---
 app/test/test_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index dd24722450..79d547dc82 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3508,6 +3508,14 @@ run_test(const struct bpf_test *tst)
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

