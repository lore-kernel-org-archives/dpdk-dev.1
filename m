Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD4ECD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 20:36:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26CB54064E;
	Fri,  8 May 2026 22:36:13 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 2CB0140150
 for <dev@dpdk.org>; Fri,  8 May 2026 22:36:12 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13298f7e84eso836057c88.0
 for <dev@dpdk.org>; Fri, 08 May 2026 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778272571;
 x=1778877371; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isrm6uI+iS6goJfVRAsABe59yGdu8wgX+OSP9y5Nzv0=;
 b=Ju4RqGpCYoZSbrOHutFcqh201YHzOk965YTaankVuA1s5W3vWuhwUcpEOyRETW3bvZ
 gkbafISgU/i9uYxWx1K3DdnWkI3JA+VWow9ci27yt03JBvN2dDJcKtcm1i4bca1kI3pE
 IwWKlaPa/XcEkoZc9bjeqjFnMO3XUlgNo8wyMX77z7wwaJBhY8kHROTZhj7Ka/jYN64v
 qQZBMwox08Ekr9fmTPlB511QlQ5LKjTR8wT/ePoNMMvPKPpvrRNWyvLgcTA6RTvis76F
 0O3CmXTZJLI/EWNoail/rwtg/oZpuLo+vJVGvPUq9Fwtg3tdYGpqIEGaHBLfe/KeQ3Iy
 m+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272571; x=1778877371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=isrm6uI+iS6goJfVRAsABe59yGdu8wgX+OSP9y5Nzv0=;
 b=Q25g1DuodMV2hTTBiqLQPW/Ju0bvQbCnp5sY02DgUfmkkZbRWK6+nsBaMy/AEuq1CB
 r4KHeOS3fivgXfu+l0Y4vf277aJw0Nq6yoFQHtJn7KR3xNANiXepiNfo3KNEImSXNIcd
 A8J6VWvAwClyaGB0eKF2wCKrL2bFxHwp5CiJPbTcpI4bsFLYq8QxHTV5eaM6ncPTZWeb
 r9ptHjOvp0MRJ7AE4eZLf4WEAZ4nEYaVKnAaipAoMb6ueR6fl1w6YSVR6Xk+ETcwhwkg
 YyeTRxVk3Mw/3IRiyiPdzdEdoGalW78iOj8SxFJfuW1F04Fq9RG9KNPQk22Wyy/2i9pF
 C7Vg==
X-Gm-Message-State: AOJu0YyfR7B8alrpzl0qkhzsgCJmjC7oQH3hCsT3flruSwDMx9SV/0OU
 GiN7EYvz0NscLZWxqRvk0jWc6u+3n8VDat2CVGwZm19h+E2UBUX2335YjuEZ3kJCZ/7fXNEZjp/
 HSKsy
X-Gm-Gg: Acq92OF0kmkumUhpdhb7m0wJ1MuvnO4d/dMsk56U9p536uUkgY2LKIAycja4mDMpcWf
 JPJGndzYtLlwReoS1t8MZaiA23lSw5gcengzIDrp7FSn2QTLlqKTnCFf8jTV1mqnLgNkHJUMM3q
 Rdz4NhMavn/zC+6Qoppw0TByYjh1pOcCfaG3qwRHUN/bIN1TeNaZ38CjzPeJRtzuf6wCssDTbfM
 0ZohMSNOD/9f8r5XdqzpS24s/NU1WT30k/APfgeoHNKKTFNEDv7T1ItpEBXCTTCJsYltHDjKCZK
 F6mISC51K/fxn8EGJ3igarAMFQhG/N29PhQ5vosyZaEaJX7u2Er20PuQtw+dJArRVI0w2O8wURR
 HXbJtS0LAUtCP85bDDivA2ZI/30u8WNb+GWV5Wb6wYg50mQs/oSjmanF25INEsPCBpN3dW/IMDi
 tj+nNMtjMIlxO9TLStK/714BOJvmIU1AXG
X-Received: by 2002:a05:7300:b919:b0:2e7:120:137b with SMTP id
 5a478bee46e88-2f547f6f1a0mr7718504eec.0.1778272571046; 
 Fri, 08 May 2026 13:36:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm4715146eec.6.2026.05.08.13.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 13:36:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/20] devtools/cocci: add transform for rte_pktmbuf_free_bulk
Date: Fri,  8 May 2026 13:33:22 -0700
Message-ID: <20260508203607.1003036-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508203607.1003036-1-stephen@networkplumber.org>
References: <20260508203607.1003036-1-stephen@networkplumber.org>
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

Convert simple loops freeing mbufs one at a time into a
single rte_pktmbuf_free_bulk() call.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/free_bulk.cocci | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 devtools/cocci/free_bulk.cocci

diff --git a/devtools/cocci/free_bulk.cocci b/devtools/cocci/free_bulk.cocci
new file mode 100644
index 0000000000..51ce58400a
--- /dev/null
+++ b/devtools/cocci/free_bulk.cocci
@@ -0,0 +1,57 @@
+//
+// Replace simple loops freeing mbufs one-by-one with rte_pktmbuf_free_bulk().
+//
+// rte_pktmbuf_free_bulk() handles NULL entries internally, so per-element
+// NULL guards are folded in as well.  Loops whose body does more than the
+// free (clearing the slot, bookkeeping, etc.) are not matched.
+//
+@@
+expression A, N;
+identifier i;
+@@
+
+(
+- for (i = 0; i < N; i++)
+-     rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (i = 0; i < N; ++i)
+-     rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (i = 0; i < N; i++)
+-     if (A[i] != NULL)
+-         rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (i = 0; i < N; i++)
+-     if (A[i])
+-         rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+)
+
+@@
+expression A, N;
+identifier i;
+type T;
+@@
+
+(
+- for (T i = 0; i < N; i++)
+-     rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (T i = 0; i < N; ++i)
+-     rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (T i = 0; i < N; i++)
+-     if (A[i] != NULL)
+-         rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+|
+- for (T i = 0; i < N; i++)
+-     if (A[i])
+-         rte_pktmbuf_free(A[i]);
++ rte_pktmbuf_free_bulk(A, N);
+)
-- 
2.53.0

