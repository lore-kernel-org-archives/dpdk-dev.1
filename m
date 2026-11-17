Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD59606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M+ACL8KD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6617E402E4;
	Tue, 17 Nov 2026 17:07:38 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTPS id B058440682
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:07:36 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so2837352b3a.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794931655;
 x=1795536455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ewwq5x2CdLU/XKtvO+M7IxX5YnFmzAe3eNYeQlPM13Q=;
 b=M+ACL8KDTnWwBmUh9nU8vYd9mwuKN9svl+mo0/+YtyXjy/iQx8udgKgN/YZqWMIiaB
 iKUK0OQtJD6PkiCviNOL2cKRq5D3DFrIUtax77C87wQRrCwG2yoTQBD7RHMconODgxRy
 mRwPZSk8Orv/sJfIVspziKlf8jcu8f8L488fbLD7Sb3KxotMXtmCPIvcYgIQFs3C+7uh
 a/mUB2dLn27rhe4KZUtVCjjyLADz/7L7Uo8Mwrk3HPJ/KqVPYmilaA6TEsMZrA170xY0
 1v6MxwDUfQnr8yiFod11lxJXw8DMbm+B84MfS84y9S/J+nx6xdmawTLPR2RHV+2pjg3O
 7vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931655; x=1795536455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ewwq5x2CdLU/XKtvO+M7IxX5YnFmzAe3eNYeQlPM13Q=;
 b=y7DsPLCC/4obmJJXxheJL7HNIbdWZEux7V42Nd5QYsrt4ptlCyF/JnXY4UkFzBls8s
 aM2pWHtyuTpWhSs5usJwl+0vO4CTgLpi9r74TfKVVf97mlUDv93+ryRSxV5yNi9cHal2
 qNEvaZxevLr2ECh1/A3TuOMjxMGvL1zzL9hKgTrDafPs34/j0+Hfdt+ZmarxQdxRt/ta
 icht4JFQGNs3RsuByWRoAYq7etMi3DFbXEaOFk7TGiiY1coSn/mFkBYOwyke92NIWQ0H
 tjNIkR68bLSTJSwVaQZCl+kp1XCJUb8d2UiaBFfZSutVGBpw11P4j83feWmP7d44YWxH
 iciw==
X-Gm-Message-State: APuU4Z/ND9TwayS4pvmmtM6ropD4yVcFk5G0GJbvktPUhoS79qXWa1bS
 Gc7lBqc+Udv/dchDCdOW5Wll8+aTyxAYsSZj98NRbyUgBf3dlRCZFJNWZknS2k6WSanxLe982SY
 gwrMHr98=
X-Gm-Gg: AYBFou33UvLf/0cAS4KSft/+c/Fo+MsIYRlQYKeAKLU4zqIKtqH1TKkbPynb6welscO
 H2T3XSUYwNTuJxqDezXAA3zlq4TwZOcmCkyqaXiApsazZf28waHGekSp2GLpIHeolHI47DU+hUX
 FMNnSELe4sSx6QxM1rcDtohixjTK276OqS5gMv6R/LfJ05SCVEfC7oEt7ZwjikJ8nWIRx2urVH6
 VsiFv/Tv+jAy2DLjcvYOQXIT40KhXtQdh9KjH0Vmk0WMMghKuFSmVGh697u/YYssBzpxSWx9XzF
 c7G0Ey5+Jg+rKJj4sPbdOxSjtYkXF4uCtirBwDDCZ8a9yjuGTPtaHnocKDvydCPwcfFsQlLweA4
 d4obC7oWXQH6yHaBI3B2E4QuoT2y3XTQIQHZ0qrrRDGHOxnKMBbjD4qKTzdgpDjdapS4QGL5wwO
 km0X9mZQoCcVPeuDVWCAQxIL2h1sVo4klundMZH8XK8B0vjYM/QevcUdcZ7fX5Ug2yP9rwByEk+
 ZUfDNmQ3gXH/r3BbOdIOKEyL3gFb9yld2fA1wjKSMHBQE8OeHg6xt4ixJIo2eiEJ8E7U0GlWRkU
 G/nSxIQExXJt4R3B9po2bX2WHZr+7CWDC4TTur+QRImYFaUKbHsa9gpFFC0kWFVlsoARnPg=
X-Received: by 2002:aa7:888a:0:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-8beb7055db4mr12879083b3a.17.1794931655172; 
 Tue, 17 Nov 2026 08:07:35 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5b40c3d33sm9403b3a.49.2026.11.17.08.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:07:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 3/4] app/dumpcap: fix pcap timestamps
Date: Tue, 17 Nov 2026 08:06:21 -0800
Message-ID: <20261117160727.388470-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117160727.388470-1-stephen@networkplumber.org>
References: <20261117160727.388470-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pcap output file is opened with nanosecond timestamp
precision, but the timestamp was set with gettimeofday()
which gives microseconds. This caused the fractional part
of the timestamps to be 1000 times too small.

Use clock_gettime() to get the timestamp in nanoseconds.

Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 2808f77add..1f9f03c7a3 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -916,10 +916,18 @@ pcap_write_packets(pcap_dumper_t *dumper,
 {
 	uint8_t temp_data[RTE_ETHER_MAX_JUMBO_FRAME_LEN];
 	struct pcap_pkthdr header;
+	struct timespec ts;
 	uint16_t i;
 	size_t total = 0;
 
-	gettimeofday(&header.ts, NULL);
+	/*
+	 * The use of tv_usec as nanoseconds is not a bug here.
+	 * Output is opened with PCAP_TSTAMP_PRECISION_NANO in create_output(),
+	 * and that is how the pcap API bodged in nanosecond support.
+	 */
+	clock_gettime(CLOCK_REALTIME, &ts);
+	header.ts.tv_sec = ts.tv_sec;
+	header.ts.tv_usec = ts.tv_nsec;
 
 	for (i = 0; i < n; i++) {
 		struct rte_mbuf *m = pkts[i];
-- 
2.53.0

