Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A7FD172CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 05:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8FB40689;
	Mon,  2 Feb 2026 06:24:50 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id CF23740285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 06:24:48 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b71515d8adso3981295eec.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 21:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770009888; x=1770614688; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=cvqaEkEYZydLY/a2aqY2+F79682af3+8ZRv+1gCAk+RXqBHM3sQ1KsELus89LvMe60
 Ub45wHt2dacm9DyKW818wWU+fKGjIGv3eNhJcXcTKLm3y9r3tzGo59H/yYC1a+Nw/R+s
 goEVqAmdaO9DKE/EsjOWjXd00IzaEgPQUw7nO4mO6PY0j2ozQ3SM77mjZmvgIFtwYsgB
 CsDpuMW986etkPZV2a15WdQqnjwAPdh+yYaX/lQbksYncby84Pg252Yq6rB2X2JkG89P
 TfX03vMnAs92+ezPZTBjZX8bWdCuSPunj64BC9oz43pHyBPg5iYqNduukPxJLjt3bILC
 39Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770009888; x=1770614688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=a6D835UnY85YdNQGvpA7CLivARb/TPrzxMIwHyTkAZcZdVg1Ec9uGPaAfw9Qn2xE5r
 RFIKwZ7lAeI0w9w9sqEsT4Hf3s1xzqnwNCrSyta92Nw68Ycgh5CiIp302reFN3RZMktT
 4b/9aTAegEgKL/n8RUt9cw2I+Zq1BVHHHcBoZWaWEcS6in/kEaGdJ5S0d/o1m89k6QvK
 ssP4Yj/Mdm09H8IWMiBhi+dNZrcdBXS9fsRwLugihhAO68JFBeS1S5zHYKvV/fSHXEpq
 CAXWRNb0alah1PQOXsaiyer3rwIJ/6DncYY/P+oWXYsuV63EJMSLPGhhGwNQG6MqYNd8
 rw7w==
X-Gm-Message-State: AOJu0YzDmnAQxYDva2On6jaHsdceRViMp4mj7hZCQRyJGUvERIJ37Lem
 A0LUrcJtKSorM2I4SacP2/ydoZIBx1WiJRLxJsf/fgKWJws6ueCGpRe6Aj0ilw==
X-Gm-Gg: AZuq6aLa9ydJLtuKBIOEpN16UUIomSyKMBsTpiIqPQeUE6paDzRZ1WjV97z1w1MHEQ/
 jOFCL24Zk1yF8KeXQnsC0zqfyhC9YHmBmTTMHUYEa25HjxJP379+r7kVN7UsfSUJFqqA45+HTqz
 pPsPArmRt3+oT7a3GK4jNXnVaPbiN5IF4/9CkfAt/rhUof6qv9EOFVX9aSpkIMCoW3RKzG+wu/G
 qqjrFDx+Pue8cv2I7bSIWFQNN7bBv20saxmNNB9wn9hODJesuz59LPHaudkGsW8FiwOkLHaYcBN
 K0i03FVmqj2M51aMrVGz0DfgzfTApHrop3eRrKqCF7ElP5iAq7j8lbuWby4Ezo6s3qnCHNhFRjR
 g5c+fMZDVZafLPZx44bxuYTZwGgZK/qee+Kpo5PdJJq4395bN3n4x8L/+cye+1SEeYmrCxuxc6D
 AyHZMfC1qwesyFCQfiRjoBkg==
X-Received: by 2002:a05:7300:ca2:b0:2b7:a27f:3a6a with SMTP id
 5a478bee46e88-2b7c862636emr4529048eec.4.1770009887604; 
 Sun, 01 Feb 2026 21:24:47 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1abe714sm19350499eec.20.2026.02.01.21.24.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 21:24:47 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>,
 mattias.ronnblom@ericsson.com, stable@dpdk.org
Subject: [PATCH v17 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Date: Sun,  1 Feb 2026 21:24:41 -0800
Message-Id: <20260202052442.92192-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202052442.92192-1-scott.k.mitch1@gmail.com>
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
semantically incorrect and causes false positives with FORTIFY_SOURCE
runtime checks.

The attribute tells the compiler that the function returns a pointer
to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
actually returns a handle to a per-lcore variable scheme. The
allocator internally allocates 'size' bytes per lcore
(size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
The handle points to lcore 0's copy, and accessed via
RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
beyond 'size' bytes beyond the returned pointer when 'lcore_id != 0'
but FORTIFY_SOURCE may terminate the program due to out of bounds
access.

This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
'*** buffer overflow detected ***: terminated' if pointer provenance
is preserved (e.g. if offsets avoid casting to uintptr_t).

Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation facility")
Cc: mattias.ronnblom@ericsson.com
Cc: stable@dpdk.org

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_lcore_var.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
index ca31dff6fd..48b022e84e 100644
--- a/lib/eal/include/rte_lcore_var.h
+++ b/lib/eal/include/rte_lcore_var.h
@@ -202,7 +202,7 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
 __rte_experimental
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
-	__rte_alloc_size(1) __rte_alloc_align(2);
+	__rte_alloc_align(2);
 
 #ifdef __cplusplus
 }
-- 
2.39.5 (Apple Git-154)

