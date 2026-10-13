Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31457CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BCE84067A;
	Wed, 14 Oct 2026 00:35:01 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 577E54060A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:34:58 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso13336755ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930897;
 x=1792535697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Syes63RKmMSLDj+fIOGXC3kUF92ZJLik0mU+IxkGk/Q=;
 b=T7lgsy51BMf/M4fIeJZq/YMsnHdrXualPNyUFvI6sQ8JQqBAfPLpFOtydHUBLHoH9N
 A599xyYvt+S8Oou/IJw9UYGfAqAZLcl8lDEQarIvXsa8NT3sIreDHefFzZWcDFxHdLL0
 +DO3g++ETgZdqAt8t2ZxVu0jsAN2xB8ozKYBmwSOHFTzbYc5vdMPCgmRljGQh4hlJ6Lw
 CUqHsicJ3M2HnE5JDJr1jXKiyqPbBBjKUz0chsJGlLODjar121Xwfb260NacwXo52d6H
 KOMn/BccF0wHhBqpoHY3lTK84p7DxQvsXLDTuJNuU0obTRYjc2dU5n7k35Xh+HG0uvpJ
 unVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930897; x=1792535697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Syes63RKmMSLDj+fIOGXC3kUF92ZJLik0mU+IxkGk/Q=;
 b=nMtm/OXh+NumWfY8EFkBzCRf30PPdsLTUx/8McHqzH3+me0UHxZQw0fGc/qhfETkGU
 hJF/Sj4P7UWnDNImdLEcNqj5JG1R8WndkILWbwf39ZGbytHYfHljJFmy96aEsZjK1+/l
 zXOHWt7U1jbcWRfXnGhMQFk7qm+HTSeemvToB8hF6vB+Wtk/XpiOo444fvGoJoLgjyIv
 nsM2lOMdb4EAvPesVzLn+NF5OgyVD/Q0n0vGXGnp6wjCw2LHhR4QjZq/oXZdU+DFXlai
 mKLksis1R0yz34OmbF72sZidP5g5E/z7e62nn7i6GTQ8JSWRvPYpFtWenEIMkO4C6Jk3
 rMVA==
X-Gm-Message-State: AFq9FYKNXxKHkfmdSoJDjmLnFN1L1868UVmYb8R/mvFh2oGE/mVySa2o
 dLsRn5+KgKGzuFU1TBuJ/ZJwOfWDpQ/z2OmZ6mz83wuSH41+kc2ZZ0lcUFE4kxSSYRXVmX7kBLq
 FF3KUBc0=
X-Gm-Gg: AYBFou3ZixVn7XtSF8qfHkPSVrlbLT5TpRsZ6efm0AtBnfCJEW8Xd90mGH+Y6UM4vFj
 gwwOp24/sqdFKe3O0ZGnNFRtDXYmaAi7TiMqkx0kXwW7Hk9tWZoCJToyI1UBbEbupm4jMDxPaHJ
 1pZmjyBOf81ftn2qP8IQC6k3UYnfETrYMxf8kkrr6XhppEZ0/qtaPpclMeNAiBGpe7zi8E24viM
 v1Xr9IAX+q1a20kQ2XpBcvWGE2/D3HjQ3AJ6Ntsqb3PcTwnMEOidW6pk09JCuwNSmpMoBBKIaeW
 5QBa3gFN/8fe9DedsTz34iOAvpfUXezBOL3xNXxrj602tUz2InAEd3fDwYITYFPodBBU1bEGAWK
 54vZKQ+IQZuCAi/3sauEMeStx4M5r9p6ApUD+dc4cSS1dqPa74gg/YECDAjbDAQgPyEXiu9m+lD
 JMyMScgrVuf5/7EV7POL+tKSMOrEgdNJcoRZKGJreY8eMP/rLgiZiu8TWdEs1NcUoRPZgX0Ru1V
 qExr80KD9FQijC3kccK4gQIPbiLh6XgAf3Yygo8kmkbHYOlrg==
X-Received: by 2002:a17:902:cccc:b0:2e2:c8a1:ab63 with SMTP id
 d9443c01a7336-2e8429a96cdmr118777445ad.17.1791930897444; 
 Tue, 13 Oct 2026 15:34:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 03/29] bus/vmbus: fix ring buffer ordering on weakly
 ordered CPUs
Date: Tue, 13 Oct 2026 15:22:16 -0700
Message-ID: <20261013222410.2257622-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The read index update in vmbus_rxbr_read() was only protected by a
compiler barrier. On a weakly ordered architecture the store of rindex
can become visible to the host before the data copy completes, allowing
the host to reuse and overwrite ring data still being read. Use a
release store for the read index.

On x86 no barrier instruction is added, only a different instruction
schedule; on arm64 the store becomes stlr.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/bus/vmbus/vmbus_bufring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index b49725da3e..86dc446786 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -238,10 +238,13 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t skip)
 	 */
 	rindex = vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
 
-	/* Update the read index _after_ the channel packet is fetched.	 */
-	rte_compiler_barrier();
-
-	vbr->rindex = rindex;
+	/*
+	 * Update the read index after the channel packet is fetched.
+	 * Release store ensures the host can not observe the new read
+	 * index before the data copy is complete.
+	 */
+	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr->rindex,
+				  rindex, rte_memory_order_release);
 
 	return 0;
 }
-- 
2.53.0

