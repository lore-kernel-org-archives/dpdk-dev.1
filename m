Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF92C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42D9C410D5;
	Tue, 17 Jun 2025 17:03:01 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 2B44A40BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:02:59 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6fb1be9ba89so48451006d6.2
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750172578;
 x=1750777378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2EJVln2E8uMq4Y3hvnMeWInH41TTq1obJ/Fap02dwc=;
 b=M4jPQpLXOYx9VJRpNApVNhP9B0h9s8BRYWZgbdLf7pZL0vbdhA7iLi0Ic98lccX/9t
 iQ525Vw8Q+oFq5EPbT1kfL1Dr1li0jor0++JNtkOSqUtfdjOYucQ+W73bad3KuU6WUgi
 7/F9fgWuR0AWC8di1dnpWM1VtRCZhw1Y66cHjBIO4Y+qSaoMKsb7GrQ3xlug2uK4vCpU
 xb1Gii7Sbyyjt68NFfTGC/G3UCWqwTXZwCSWOz0GhdamRB1PcSnEuXFn/FgPa8+Nk7Q2
 Ey80g0kfkjmaMAXrZ7O5Bm8XUHcC9zlM4IAU/tWBw1Ml6ZfNVSQ4cH0Uo9I6isnKTfy+
 WcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172578; x=1750777378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2EJVln2E8uMq4Y3hvnMeWInH41TTq1obJ/Fap02dwc=;
 b=bIuX2CmkM622hTT6fCguaem7DD208E6FbqjdbL7k582hPJ5E1JFLulYtt6Bk3t8nUu
 rG9uGusg6cfcBpLx4jdmzqvRVRblxYxG1HftfkAOFCCxfS2xzOa0mN71lX0U+jeCOH7D
 Hc+kNdaKtKoCuMsohLXYUqvPOGgtJwMwKQVOTMHHmS69BYqNqX78HdAmoE6ditTl+8ff
 hdtV8NtheIaHVOza77Eo4/Wkxk3f19YR3Kx72E9mNJcoz6IDTaKzbMb8ZUb6zBU2hU9Z
 KhCe9lpocHNpqywL5SkNwrjIjqMxDmfvuhefJn8Qm9Vt7ELIQz/n31CoxyQfRVzCBm+T
 D3Ww==
X-Gm-Message-State: AOJu0YyyWdTTYrzVmJqhG1xTMwgPL0Uhx1re9AC1ti8NjfE/uPL1C+Y8
 CqIFS6ZbppxSF+hK+CujRp/AGEI2kq/Z4D59a/hdI28Nf18LX/eEXeuL6UZI7jPn0onGPy3Mbb3
 E+5ib
X-Gm-Gg: ASbGncueXTDJ/o1PXk0OBq3W2ahCIbwwG9lF0y9sC99RsbXUbebdx6INsVopTNkKYmd
 x9ecHKjGSURN5gZilM3Tab7EAjS51zqBOs969frP3u9B2oWnqowoRgcWVgALCfC7JKQKnso5cHN
 ailgrFmnCkECYMsBucqn576KmdsXT/rOUAZMb9digzPXC7G5qHhuA5xXmuGeJk9qQYehSvgYiO8
 30v2eHm08Je0fKp1LAcVGdeX1xXhYByaC5ZFkNAPB2WMzRCy6Zy3T/SJ5FQQhI2pyGtLxwvSsU7
 h/FjSZn/5km4lN7UtylrhQgkvzEdj+cv04V7K1V5YEMpH54gyKbl7nIDsRIFX0laz+g7Zy177iq
 yZbLaSaHOiWShCWoWWU/jIaUsd8ar/cRAbZFl
X-Google-Smtp-Source: AGHT+IE/SKPBURgTRrCBTVrijFH4uszXWjiB2R+ltCptBNdD1uudhP6sD1ErywxVS/klVNtukfP7Qw==
X-Received: by 2002:a05:6214:238c:b0:6fb:66f7:643a with SMTP id
 6a1803df08f44-6fb66f76482mr3866696d6.23.1750172578086; 
 Tue, 17 Jun 2025 08:02:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb5a9dbf8csm13051046d6.106.2025.06.17.08.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 08:02:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/2] latencystats: optimize locking on transmit
Date: Tue, 17 Jun 2025 08:00:17 -0700
Message-ID: <20250617150252.814215-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617150252.814215-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
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

If transmit callback is called, and there are no packets
in the burst with timestamp set, then the expensive operations
of locking and accessing TSC can be skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 72a58d78d1..f61d5a273f 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -194,10 +194,17 @@ calc_latency(uint16_t pid __rte_unused,
 {
 	unsigned int i;
 	uint64_t now, latency;
+	uint64_t ts_flags = 0;
 	static uint64_t prev_latency;
 
-	now = rte_rdtsc();
+	for (i = 0; i < nb_pkts; i++)
+		ts_flags |= (pkts[i]->ol_flags & timestamp_dynflag);
+
+	/* no samples in this burst, skip locking */
+	if (likely(ts_flags == 0))
+		return nb_pkts;
 
+	now = rte_rdtsc();
 	rte_spinlock_lock(&glob_stats->lock);
 	for (i = 0; i < nb_pkts; i++) {
 		if (!(pkts[i]->ol_flags & timestamp_dynflag))
-- 
2.47.2

