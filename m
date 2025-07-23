Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 22:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ADA940262;
	Thu, 24 Jul 2025 00:34:53 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 79B0940151
 for <dev@dpdk.org>; Thu, 24 Jul 2025 00:34:52 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-7048d8fec46so16399206d6.0
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753310092;
 x=1753914892; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5W37mM9WP1lDFXvM7XPr5g7TxLJdOharqBrJvo7qpug=;
 b=DfrvarsXBEPh6kNddtGQQafGMMTqsOd486utH7lYbbWk3JO1YX/U4O10sluUh03ag+
 hq6hbcBPV9AxrZ837snIvwM+9aO0DNiJfyfM0VxHiFQY3Ltm/zU8Y0/i8PSD6SjwgZ4H
 PuayR2YqGkfr4T4YBOUCezcM9JP2mvJsLWByK9uO38JN7RdiMrGab8/0+9FP5kb0atQg
 Xbmn8Zt8MwVK+vY32oWOsZ0QyYVYgAsSwF3Qo0Cpp1YvpAPAfi8rJKB4EjztldBKFzMh
 MqWfMpREL55WbBDJBpwKV5ANlxNPqvk1O2chxrOB9L4DEJcv0wXE7nYhA6C7Gx8G8BAt
 Ar2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753310092; x=1753914892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5W37mM9WP1lDFXvM7XPr5g7TxLJdOharqBrJvo7qpug=;
 b=ikDxxvr9JQd/HnzSfkq6ZHe3FTRuDeuWcNbJ/i+z9vgLNekEXnOeu59085QFDOWjqC
 HeskCnFyN9BH8ODFTI5untgT4kWeyg3tC3IAFDmFZyfCoLnp8jGVNscCuALE6BCxNovv
 JEQfqyAim+htmwMDuGEPYJyJEfxLOsVNYnrISCCHu203gAfMhs9e1/739vKyjMzBGKNf
 1VP4sOu2YtxLWpX8GlGsvPFwaBxEezzEgZj87g6UYJcG6vsFrYD6AtODGD76SziC7gLq
 EtSAdUaWSeTUO2X6VicEyLLICyBx08JImGVuRZzzQwWaYZx/iQU4Fg3hEi/+UI+N9j7k
 O7lA==
X-Gm-Message-State: AOJu0YxE2OtWV2VHfNZErrl+yqOl4xcqQGaBYriz8Sv9C1cbTfK4mMrC
 r6AlWX3fKIQDaalquLHzAmzcnKIw4Qz0O6cnDJFNjCd4yvn8HtFUzxyJaU97trpLn3MySmJjIY+
 J54Zy
X-Gm-Gg: ASbGncsE+wYo4jd6QMcBU7RloyiiBimeEoPswILWU+yCftbT3Slx9khKws5RPkFQ9fT
 z6YkUWWX4Wd2XqAcIpysJRzzojlguRumUhx2IbDT5uNS7y0m/bsipBG/G4tdDFyxXNU/Ph79sbu
 TUzO+ExcsKsXSamp1C14YPXtb+WLxsD6spjn+liExq6x1WtieSUcEPXq9FE+URqhddRM7xH44YG
 LMxdRJtQMBh+9LTDTtRoA0FV7nayUUIMIpqCof2t8biWECsq8iy0ZAz9vlxCIx3XoBEYOfm3B+g
 H6hkfxgwkLfV8+JadPVYrwKFC53gWnrTrz/EKXGFXh1jWVNhx2/SKgZoieqqWUZiIpZmocW0IRY
 y3VPN68Xrzjb7CQrjpJjFP88HSBD5HaU/226kIbD/pWw3mS6tu33K6mKmdwuP3r6Id80iOL+Ai0
 wXyiQy4C8=
X-Google-Smtp-Source: AGHT+IHH8yhqC7K/ppIzd9cPNuX+BOpqM3G5U7ypXHHle+77SFLL1IkY2ne2fczV6P9SgqNKLxRiyg==
X-Received: by 2002:a05:6214:2a4a:b0:704:a59b:ad21 with SMTP id
 6a1803df08f44-707010153f6mr59416496d6.6.1753310091647; 
 Wed, 23 Jul 2025 15:34:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7070fb629d7sm2728296d6.41.2025.07.23.15.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 15:34:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] dumpcap: fix warnings when primary exits
Date: Wed, 23 Jul 2025 15:34:33 -0700
Message-ID: <20250723223448.322439-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722155319.168601-1-stephen@networkplumber.org>
References: <20250722155319.168601-1-stephen@networkplumber.org>
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
v2 - fix indentation

 app/dumpcap/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..5d1df0ad03 100644
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
+		cleanup_pdump_resources();
+		rte_ring_free(r);
+		rte_mempool_free(mp);
+	}
 
 	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.47.2

