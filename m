Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FDA106ACC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B285402AC;
	Thu, 12 Mar 2026 17:43:50 +0100 (CET)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id C0FBB40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:43:48 +0100 (CET)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-466f1c3c627so897338b6e.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773333828;
 x=1773938628; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dO91Iyem3VTaCroq+jkIF77zyPw1/QtukP3O3F6YO9U=;
 b=UneSfL8ipL7eQaamKYybOac5FL44VV38/c9186SvoqldlPon3W3ksfOn6HtsrbGiVy
 5nbDFNf25uyie2e7I8Gp+3PCPKtJf8/zijZ51lBhmeJtE43N+g86Z1NqE5ZiHX586/PJ
 9mmMLBxxBWqWsLVmYVp5mdaJOWqpGgjxEyCx1ESJLW5z8kmlZEU4VSYOSBt+iUfbuzYy
 ypLLzSxqTdSCArHSr6KVofZeh3NZuy/9C8YpId0FNHqIOv40gqD+58EJHzyhlhC+ryZI
 fshbJ4rOAiPsR3Y4tCx0de/rWHdgJ52pmKBKPxjAMT/M2D0P6SHtAeDB81Pg4LQz1Fp0
 xYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773333828; x=1773938628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dO91Iyem3VTaCroq+jkIF77zyPw1/QtukP3O3F6YO9U=;
 b=a+4P7vpltr7JrlOmvb2z5z3zDXLFTqo35a0C3VT/qrgah3ZtPeDQru0hTonH8cart2
 sOaBJ1rKpZk708Oar0AIX8dcBsS4f22Y2wPy6IEBKHBq9N4iZy937uVJp5D1xQ8SJmhA
 3/CG7EJwRMaDbHncLs2KsVWWWnHRocaw6vZ6d/aKzDd5Ru1UBKqzbdM6lbHyvWhN8M1M
 jbAqN9cE35f6mGpwnvTWFUM9YBX2P3C1QzYCq2z+eXIyeeq/PJtV+xITD0S5TiJ2Y2Vm
 CesPg4xKzrJtGVXxfJe2MY0WUtpZ9cGBexeHNPGu5jSxRmoctAd44pfRoz3dPsg4ZBgv
 5Oqw==
X-Gm-Message-State: AOJu0YxRbctxCAqJQ8gikoUDcRjroFPTVfDcs7PZZHHT8nG8EDbb4RxK
 41a7Y+tdEx0YHpu1l7bscMglywsYndJtsP/ug/3pDDChjF9CaTXNzYVUOTk4E7EjlRSb2xj/BvT
 DUvMc
X-Gm-Gg: ATEYQzynNSVNIVxsgwKQkLKXtMu0k1tdIBkjzUQI72ZD5CqrLwcuE1Q6WrD6iZZ/szo
 BatIiq0ugGMg0qUqL5wogknG1Rdv1x2WcTde9Q2n167XgWdtX3KkuX1gmQ+Y1+I+u6c0n0xhg02
 +2nIAJxw4cfy/2lPU4KMFWw0WE6bi8Ht26P3RLKvklLfqTMg2v2siyDOIX+vfihYvIAMYesRYGK
 iCQARLdAU5SF4tldXrN7c7pGicEC5jcoeLwZjM7ia5EVvOyAXh35b2yjryJ8ZLz68QZaWwgQ9n1
 YrUbiuXTCEtocRPl2Rd0z/PfiLJM7Mc65n3AKdPFwulrRldOGz73D+hMRHlUdRgkmManKfWyJm9
 LWBMjFikLugWYT845vWrEIBi9NTE03cXh24gyW8Mmuvs9A+Qeo5/dNNGinhHpAuXyKqAZVD3rup
 QtOHB7BK2kDfAdP2HnJ7ybMevrQPyIhe0T
X-Received: by 2002:a05:6808:4f6a:b0:467:bfa:bd9d with SMTP id
 5614622812f47-467333dd969mr3910607b6e.18.1773333827886; 
 Thu, 12 Mar 2026 09:43:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46744873a6asm1700340b6e.9.2026.03.12.09.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:43:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Shaiq Wani <shaiq.wani@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/idpf: fix comma operator warning
Date: Thu, 12 Mar 2026 09:43:44 -0700
Message-ID: <20260312164344.957967-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Fix comma operator misuse warnings with clang compiler in idpf that
was missed in previous change. Shows up  when -Wcomma enabled.

Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 4e1062f22d..db7728afad 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -842,7 +842,7 @@ idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
 	/* align if needed */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 
 	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP; txdp += IDPF_VPMD_DESCS_PER_LOOP,
-- 
2.51.0

