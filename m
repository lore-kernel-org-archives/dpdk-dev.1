Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1237C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 15:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5B4B40269;
	Tue, 22 Jul 2025 17:53:24 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 21CA24003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 17:53:23 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-75ab31c426dso3096450b3a.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753199602;
 x=1753804402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hi7hPGk9UQ3817C+h7ZljZAN9awp/CinM9kIJJnm0YQ=;
 b=mSPOmikrMztnKE8sOENoKTwl+tX72G/jr6hYiENSlEvvRw2SD4Ew2OB4qSFD3C1U6I
 u5eY5PAdvN9+989e8w4PD81Jr++0x0ZJJs4kQhFlcd/rUmLXBiWl8oa2RwvQM6KPhI+T
 xQ05n42eMDg8ZyT7u2SdZpo5Sp3Bh8F5eja8s/CFPvBn0YbIOw3FNL+0iiSFu9w++FU7
 jqeOd2HI+SW2SlPiSyuSZ6sPOsYKrxmCysd9J/1fFVxUFyZy81vHImZOp6HNoNqRehT5
 KL/eiDVhypHi6vzk4+z2XhUSjVzde4b2ZdUNOrcjW302IlKNug47XpAUqHPIylEUzAj4
 9c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753199602; x=1753804402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hi7hPGk9UQ3817C+h7ZljZAN9awp/CinM9kIJJnm0YQ=;
 b=npeZVc6eT8rEn+Hc9K+MarVdIWppkTVC93037Cje0GMceb5iqJu+AY1zqAu9O/60dH
 1hkuKooPcK+ax1C79aEUd/Sm2t6OZ8ln0d7EL/pE3fK+zQmNEFGtiCn3z1LqCL3LCGIu
 gDJ3wWlLRm7NmQ6wrxyFlMeA9bkiV5WhQcoUwO3XANd/xgzJ6VOb8TtmtFZwyYm0qopw
 JCNxm+pcQS+CVWnLoYgjP4Qeo3wP+yW060+cNVx7026EVbMnjw7Nes947GgjkdBz+4wi
 fVEEHxjOBVu5esojRAtnoeb5g3HP3pcsIRxfxupbZCCN5jzqFHicAIdTBqhIorJcuyS8
 nEig==
X-Gm-Message-State: AOJu0YxYZAyEQqpPrpWx1D9T6wOtVLfgyVltkJDTje2A0uFjz+K6FUbV
 zk6ndfpXjXkchaD4bufXte2NP9se6FGWh2IlLAY9WrhPOAjYoMtj2gl/N8mDbPHhqk34rwXAmhF
 Bqhab
X-Gm-Gg: ASbGnctHvJI8MpZQeB2LdhPfJSQ8U40GDA6GK7CiNBAQpXvcB5v3mKCAf9HJ5m7Uo12
 s/ueBPnnIzDis2839W81rlwcbcity+oPc7QS96oyph4hKF5x1c9GbrWPO92FrNczWvpFHe7g1oi
 RZCd767zWis881jvVvlkJay5ewxMK/lOJYeL83HSlRdaUsDU0n6tiDQJMMNyd9cwpmI73mX/pxj
 t2OSpy0G2f4MLTzJJ80DNi/LtEqCXuGU3xDHnWm6l1uK9mM+m0AL/N+5IfMMuKfHDRDq8jUdSq2
 LwhH+p271Wc9FRUdyplDcQh1dEypskAxIvhnHWHHppBx/QS82Rx7mrMXrj6J8dKJhPQ+XcnLSUa
 v+xOjxg8srwfEdMGV/HFmQVD6iLP7QsYK7kkdaK4xLPtUPfDovd5nQmLYgBm28CJdYrv3ppIwZc
 B2lecQDIU=
X-Google-Smtp-Source: AGHT+IFeF9md/DXC1X8oh4XfZJ/I/dRhEHVGUVlQC+rNPAHDlZtP4AuzqNOQGvzaHUXi7u0UNvlR+Q==
X-Received: by 2002:a05:6a00:1407:b0:748:2ff7:5e22 with SMTP id
 d2e1a72fcca58-7572316d8bemr31383747b3a.10.1753199601904; 
 Tue, 22 Jul 2025 08:53:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc67a87sm8010662b3a.145.2025.07.22.08.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:53:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] dumpcap: fix warnings when primary exits
Date: Tue, 22 Jul 2025 08:53:19 -0700
Message-ID: <20250722155319.168601-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

If primary process exits, there is no point in calling
pdump to release resources.

Bugzilla ID: 1760
Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..df649722ec 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -541,7 +541,7 @@ monitor_primary(void *arg __rte_unused)
 		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	} else {
 		fprintf(stderr,
-			"Primary process is no longer active, exiting...\n");
+			"\nPrimary process is no longer active, exiting...\n");
 		rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
 	}
 }
@@ -1058,10 +1058,11 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
-	cleanup_pdump_resources();
-
-	rte_ring_free(r);
-	rte_mempool_free(mp);
+	if (rte_eal_primary_proc_alive(NULL)) {
+	    cleanup_pdump_resources();
+	    rte_ring_free(r);
+	    rte_mempool_free(mp);
+	}
 
 	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.47.2

