Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F69C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A15A040664;
	Wed, 26 Aug 2026 04:01:53 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id CA9984065A
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:51 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc149372c14so309162a12.1
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709711;
 x=1788314511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvHXwg8BE8T12HztHIGK1nG9UKOimgeRyHue6SUXaHQ=;
 b=wv4nv/o8BNnex+s8uaMG2kmQBq+1BampDQ6oZricbVPh5+LSdI5vy7TNc8TsnQSnvU
 FrpfQgQCmOUv5DLcLfP4RCFGvYFIl/UhjxYmwdDWWmnCGYmFkdxpvOrhWYRse0ZCyc/o
 F+xezzHxBLKcSlRzqOesiTd+M+Dwm0BqslN78Qn38tBnFIsjAaxt4qX0LKNI+LLExjNg
 Lktl74S9gr9FR4xWhBF5ki5jAG5vLQ1wDVTzneNEodW4RaVOoMauiDjIxp1DinKl7fAJ
 oNrNigdqeXKJw00Z3wepYkomPAgP31dG73P2zs6xivGgS9E7lB29Nh3auV2ZP5M8jZLg
 H81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709711; x=1788314511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvHXwg8BE8T12HztHIGK1nG9UKOimgeRyHue6SUXaHQ=;
 b=HEzDTSxMftgtJlplLtJG40lxesjp9AWz+WH2MZr16aXSvOP0+mSD2y7GUuRGtITAX9
 3XYuPo5QUrf0atGeh6yvmP/E38iUUYWbd7/U9amrVi1hPsqW10X1x/e7gwtpGq4aCr9c
 RfWyr9LRbp2A/oO/X6OBvaKBym+3gc3E0m1wodS+pyUY2X4OOysbKJ0U4TxKuusNF16t
 5sxSjxu8pJK/vJAjq/C5SWJJUR1Kh7k9ovrjPC/p+8tOffOwzyt+QffXiSJVzPHyUeXD
 3JjVad5QOX41LNOYP0cf4U1fRsWVU1PSp07gEUxn2POhubSfKLcL9yzywg6cfkd27E/D
 XHwQ==
X-Gm-Message-State: AFuF++lLuCQyI7QXZz22eQdGoqS5r7rOkudThdvJXxLvJ9PRrQYbdhyo
 lHxXzgCXfvaWRkHbt+waXXk8AtcCsz7ioHVrTvIvFc9zDJBiuLhoETWjYMRdB7w67euQ6m1bRzh
 EqfrR+0g=
X-Gm-Gg: AR+sD134fjr2cBQZsWwytidrlKrgG+G7A5NHKTYJrOCs1i2hmDEBkfcp4JT1x9JMeAU
 DCfVIrVF9GzUDjz7Ec0zVy+XJw88Jg3wO9osZCXdiFaijrUVeBjrNNJgvjghZFYmLVuNz0Stguk
 cSuwRH11hLgaP+rfEI1mlaY2Mxl6jz8Ulw1iGwGTc/PM+GAYPxKBt2AT3tQiaLOWMecwLLfU6VT
 PY39RFviXX5vKVFsN5irg/SFvoHBmd9RuPCEekmS4vDfCUJIp/RDeF1qHRKF/ZPNZk7PtCM7X3G
 XOkdoswMluF2x4GiwiaAyl9JEXEHoOEdkeCMNiuREzEDVfU6sl+X+1n2OTCHfPcxFyh5oRHSwL9
 VxwjF9Ex+yRY9iEbJoqF4zj6VES+eieG1OfTxdSlQhhGpIo6QxMtxGhrIg4D8HwC29KXxuv+Nej
 eorZs/GAUaozFtJbQ52c+2qP/0IKBQCaJRpbbvGq7dfa9KWCQLb8Z83868EKX2HegksZx6mOhZ1
 g9t682Osn1MxI38jn3zpeVfRxEwsAulMR4BSA==
X-Received: by 2002:a17:90b:1dce:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-3966d13eb80mr6893537a91.1.1787709709775; 
 Tue, 25 Aug 2026 19:01:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/5] app/test/test_rcu_qsbr_perf: call quiescent more often
Date: Tue, 25 Aug 2026 18:56:45 -0700
Message-ID: <20260826020133.2644805-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826020133.2644805-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
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

The performance test would generate large backlog of quiescent
actions which caused test to take excessively long time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_rcu_qsbr_perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test/test_rcu_qsbr_perf.c b/app/test/test_rcu_qsbr_perf.c
index bdffd64e60..8768a9ce1a 100644
--- a/app/test/test_rcu_qsbr_perf.c
+++ b/app/test/test_rcu_qsbr_perf.c
@@ -313,9 +313,8 @@ test_rcu_qsbr_hash_reader(void *arg)
 					pdata[thread_id]++;
 			}
 			rte_rcu_qsbr_unlock(temp, thread_id);
+			rte_rcu_qsbr_quiescent(temp, thread_id);
 		}
-		/* Update quiescent state counter */
-		rte_rcu_qsbr_quiescent(temp, thread_id);
 		rte_rcu_qsbr_thread_offline(temp, thread_id);
 		loop_cnt++;
 	} while (!writer_done);
-- 
2.53.0

