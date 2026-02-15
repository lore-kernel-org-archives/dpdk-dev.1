Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D4E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0E0740687;
	Sun, 15 Feb 2026 20:54:15 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id D554D40679
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:13 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso30617985e9.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185253;
 x=1771790053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=1BczqE7Emaoqdc35nIn+xEABLuif3DkbsGkGKnVr4b8YL1MrHZgvJhZUO1gjAKWWmC
 8QISsLQWMpxr2QPvJNQOkV48SkEfmImb0E/enZgmFXW2Hj4xnkQEcOzXrkDcae0ZLCfT
 YQLT5k6HwjQ+adWEQOIXUj+f17wmld5mFoZq6vqUVSWjiCG4ZIFqkhDFoNxVMdBSjoyT
 9flD9F3qECbjJInDVhmAg9v9Yu8h0IeNI7nLbM/ar08ltqxVjobMLdi8qrgeZhiBH8cG
 qH2+H1+Uj8LrcmuTaJWPSoxP0YtcSX+BPcdOpivUmSUFxwvKY8uzhhmlG4e/a4dNn3Bq
 mrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185253; x=1771790053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=j2BBxqZRd9CvAMFVglQ6hEEs+1IExCSC/JS6aXbSxeAz9ajWPj+SOADcnYfTauQ+PR
 8uvUCDDFleOb62cd2qr8+DXlorZqDcz4tnToySKdlTNGCCqEVzZBx0+EQk/M8QlyASpO
 mBwcm/qmVKIcI/T/4ngu9OsMKiQPSR7fggFgmjh0cWsUODTV83g+gMsdedjc1rY/y4Vc
 BtHITP33vnmvscBtiupSjxmPpOeFqtj9p29/Vws1A/NiJgkcrTpfxcWGCt9Cr+fJnK2p
 8T/dKpgo4sUMFoAsUu4RZrPkkHj5KWLtDfRTe1ZNy3vj6+IA5H/7Itu3av0QHtvJq6lM
 ZxbA==
X-Gm-Message-State: AOJu0Ywngo0/ypN0Heuqoa2oySPEh0TaJqVjBK7OAFGN/wQD1dTPzSv/
 JgDxEUr4vhGJ02zwvmMZ3vglx3PdfEQrEjj1csz+d/0xoXabKlpXxcxzF0OoZX81GUM2fRTKdnM
 sbfDtLDk=
X-Gm-Gg: AZuq6aK/+Hs9+UlttjhaDWlVKNDH37UKbQkIUlP6dcK5BQTA7uy9L424DynDVIxcJ0y
 8T6I1lnNywM/RTdEdNfRdb32Ssj8mvzGzmnyTF9byJh7atTLAYo9FYvIVRyX16rjDiWUTAWTH7q
 yt1oISVofTMVMLzXzvrXIuxVZ6+TaiM9WCFA0ndXIY3MzSY+HuwFHsy9Di7bFfBOi73BEHnl7x2
 3p4tPqLe6ajZyK+vaF0xPMvIUSV9ujfYg5Vek60sz+AMJ2nQ21131dZnIirECxbwR4tdIaCcEVY
 M3JAVwQI9KZJqPpK6Ygo7pLYW9xgotJ6G2EKRsXnBUtgyKApHvsXdT6SpvNrU7GH1PwuHYyTdbY
 ZLWoObtqRhKwX/cfgNMuSlZUIszjk5ikJRpS3iiufrANT3LeX53FakX/nsO7Iu0urhid1yVDUf/
 gxVutgpk6L5sk7va//XXr3U3Rcy+12rBmQj609vWmBGJmcDgh0vsRjenAv6oqWDuAS7NucAURN
X-Received: by 2002:a05:600c:310e:b0:483:a21:7744 with SMTP id
 5b1f17b1804b1-48379bf6c82mr109195695e9.26.1771185253408; 
 Sun, 15 Feb 2026 11:54:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ophir Munk <ophirmu@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Keith Wiles <keith.wiles@intel.com>
Subject: [PATCH 10/10] net/tap: free remote flow when implicit rule already
 exists
Date: Sun, 15 Feb 2026 11:52:28 -0800
Message-ID: <20260215195348.557945-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

When tap_flow_implicit_create() gets EEXIST from the kernel, the
allocated remote_flow is never freed. Add rte_free() on that path.

Bugzilla ID: 1880
Fixes: 2ef1c0da894a ("net/tap: fix isolation mode toggling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 427faf75d5..da1e70019a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1625,8 +1625,10 @@ int tap_flow_implicit_create(struct pmd_internals *pmd,
 	err = tap_nl_recv_ack(pmd->nlsk_fd);
 	if (err < 0) {
 		/* Silently ignore re-entering existing rule */
-		if (errno == EEXIST)
+		if (errno == EEXIST) {
+			rte_free(remote_flow);
 			goto success;
+		}
 		TAP_LOG(ERR,
 			"Kernel refused TC filter rule creation (%d): %s",
 			errno, strerror(errno));
-- 
2.51.0

