Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98CC79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D3C40C35;
	Wed,  9 Sep 2026 17:05:12 +0200 (CEST)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by mails.dpdk.org (Postfix) with ESMTP id 2FEE14067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:05:11 +0200 (CEST)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso8033695e9.0
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966311; x=1789571111; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sinh8HhXR6AGECtnTUNnc0XB3pw43ejYji0KNNVR0kk=;
 b=K1U/EqIEAVZHwe5jQ3ikSWP7HgO+JThqQMY8FRbH3FixXjhv/uvYRYNj1RvVK0dkSe
 EDK3OaR/kSX/4JG9YncitZQ12HVF1ho95Ni6iyt+NzbM3N3tqw280tG+nnwOyztXYEnE
 MPfBA6BkqtXmXyzeVjiOtOOVBuLVh47pLmbQDnfGlcUe8BftW/rP/otYeM7VPZc9EjuY
 e3Z374Fv1PhM7PoHpepVrJ0pZZNLGau4evyO6lRgTrW0jYnjYCoyBtfCPo3stEv7YTvS
 ieCmXT2slxV3TskMt9jTBPXUOFrUCB3R5OIzRJH8rQceWMhb7In4DPybmM4R3MmIx4fy
 YuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966311; x=1789571111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sinh8HhXR6AGECtnTUNnc0XB3pw43ejYji0KNNVR0kk=;
 b=ZXQc6cQSfs3cILHf9oOnnc5lfToVrI3RIxwLb/skdu5mcHBj21v9VbCUP02sK0xlgd
 VokNKtawDO8dulqU9I9HNsV3dGPzzQFy4O6wrMDM8zd4LWZJrDi5xlrpyACCpThpBqqp
 KCbOz48u+owDJUi4k3Ox7Ayb+xx2zvI3f2/3GCW0eDywVld5ZjUqmLk/4Mezc6AFQ+zV
 Lkp7oxgbAbRPxuhFxCj+4XWL9+2dvOV+U1LTVjVmsSgcmib6PLNxX98HBV8lJISgbyhb
 IOYGKBNtRJgd7p2zupHp/YhfgOSgW4WmOBUz+JAi1oqbUN2de+ANNoQ5mgnIn2iLv/zi
 b0dw==
X-Gm-Message-State: AFuF++nCP5SVsUnhohkqLGas1Adf3r6Lf2mKOOtywWZiw8gmZR2ksB/C
 Czn2NdSQtTKxnt7Yxrc7YWCCp6aKaHxNSa2Ti5SLTPKo6nuGBvuNgj80b30XGw==
X-Gm-Gg: AYBFou1rKy1y8j7Zo5nLAo5yqi6n807KsgQnBqKLtbhCeRiJuzjaffC5yPW9jZuocQF
 SVtn1z09oaElTbyA0jeEVwnR0kfDMuUBWSTRJlaWx24ED/FdHYJy5i2X5hv+HlAfHttSro8EzXC
 x2RzIwqDFVu5x9AuVuqdB9Jw3jDFqC8zEO9MiNsazzBh+zdOfc5j4q/p7WG+owfvWW8fShbw8Pi
 cc2o5HWnL+g0MHIJcYbo35HRl0T26bP+GOdkSHg2SAyoBmSMb73gQUJEdA4tk/aDqAx2uCcktli
 RsBD0iuKe+I9Zxx84VJha6b+iFfcYeM+9IVq6YWjHsufvnP70yFkCm2oEv+L8jYQ/BDqDgN826F
 sZXerevvMCUxGiQ6hEtpgxLJOKHa0UdpK5FG8DuE9inLpkQLhLP5OXsfTjqPyd8+K1O2G7DOLNg
 yIR4aiqcRfjV4jqsFMg0az3jpR9LaQ/0uxsT6soWNfUVc4GpM7yB2fOhq5inun8QPVjopGXgKmw
 zrtS/CKeLTXlzz+x7QZOZk+9LDksABbADjt8twIKYOlQTuL4yXDLPrnmrtF
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49d1916215amr117540705e9.8.1788966301035; 
 Wed, 09 Sep 2026 08:05:01 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm379358735e9.0.2026.09.09.08.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:05:00 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 4/6] examples/l3fwd-power: accept shared Rx interrupt FD
Date: Wed,  9 Sep 2026 17:04:47 +0200
Message-ID: <20260909150449.856295-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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

Some PMDs deliver the Rx interrupts of several queues through a single
shared fd; dpaa2, for instance, uses one QBMan portal per lcore.
Registering the fd a second time then returns -EEXIST, which
event_register() treated as fatal and disabled interrupt mode for the
whole lcore.

Accept -EEXIST as success. NICs with a dedicated fd per queue never
return it, so their behaviour is unchanged.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 43a0509bd5..5638d43826 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -938,7 +938,12 @@ static int event_register(struct lcore_conf *qconf)
 						RTE_EPOLL_PER_THREAD,
 						RTE_INTR_EVENT_ADD,
 						(void *)((uintptr_t)data));
-		if (ret)
+		/*
+		 * Queues polled on the same lcore may share one interrupt fd,
+		 * so registering the second onward returns -EEXIST; treat it
+		 * as success.
+		 */
+		if (ret && ret != -EEXIST)
 			return ret;
 	}
 
-- 
2.43.0

