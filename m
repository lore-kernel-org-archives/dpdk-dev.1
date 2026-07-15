Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E65EC44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 10:31:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C068B402D3;
	Wed, 15 Jul 2026 12:31:10 +0200 (CEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41]) by mails.dpdk.org (Postfix) with ESMTP id 927EF4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 12:31:09 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b013084dc2so1643207e87.0
 for <dev@dpdk.org>; Wed, 15 Jul 2026 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784111469; x=1784716269; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2PVmGHSdm8MGODsX4R91eYH5gkP8ETKh2Fe+HJfhCqo=;
 b=Z/uEAv3zvQKFCzqBX5gH+S1kZ+zOcrXwNyfr/tuIVzxA6nVVTHcuNee7rrSGHNM49C
 3U6MXMjnoUQgWKDlFFD+WnyyInh+r6/IG0MblCE78GKYdHSfh+nnQDEpTG1P8mZrE7xf
 j+tTzUV+icNgT1D8/xdz6KZv+JWW9iumGrzvw7VoSGdOrRuZ0Q1Q/+sBahDkD9wHD46p
 +UzQvA9v+pQ3GgPZrDAtAXTZutBEQYjqUm3pqOsZMoirlZdtIBcvpRUjnqMkdFcMdMN6
 Uc6J36Pi6xQpUduPCkJSAhzsqAkyvLapaansruVlouyj/yuNcwczLWMpdTZNQxcOe6UC
 VHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111469; x=1784716269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2PVmGHSdm8MGODsX4R91eYH5gkP8ETKh2Fe+HJfhCqo=;
 b=qZZQqVEkVU6enQgcg4MEMYQKtxhyg2hrLrO0YMuXzdTdOZX0fTGJU37jrjM6I8puky
 3lHa6hTI+z8s+R+evuL8MGaqb6fQJOvle9B7A06QSgB4PUNy3gYick8AEMbp2BwTWIzB
 9SOTOvxX3xrZAMxCjF5FEZFvn8miccktxq11eFNul9Ukgjp2wTZkv7EKpc1Y1NYfz2cg
 L8j6DkEFNZV51duZBOhmNpTkJxUKDFN6Md0y1CEuH9MoDwCwBIjuolQDvj5hdPp/Wff0
 x16n27o0TlSo+2H4ne1e5te/+oXvypm49wpkQJ8zBbSZVOxVVaNJ3Hwfmlxf9NQsj+5a
 ckGw==
X-Gm-Message-State: AOJu0Yxkap/1L7pZT6Bz+xHq45pbHxCxTjUH9mJ0h6guCLVk/8UhfI4a
 5QEUM5ii6iMTKD048SKZYHFpQohdvbo+p2huyECFM2VrCCBffLe9yJmM
X-Gm-Gg: AfdE7cnCsxJNmsyE7qtL4Qo2gMIRoSCHsDbTmkI4mJwdbmqMgqdVmbl0T4pDkoix8ln
 fWjZvpuOtaxJ0ESMv556lGM+ggKlgntK1/1CAx0SCum3egtvzAywGwHSkIShmTNsS6jrLoR07Ii
 dJ5WOUo4gDkcy5CAd5E1iy0Ci2RFjFr0cL5A8Uuq81IEZugb/qZMSM6YMx4fA5V3bdYz/6A5eaH
 Fv/g3UMPp7kHCuDBEklGvdxOaO+DNAgv69hRFrbk+/d2eTcO53rAdIwqI57UjT5GujG5LmfDQ/W
 TaqbZyG2IAiomSHhjle8vsItPc2PZXT1h1vLWLGh54dF+Xv8PgKKZfaRVWYISelmoFob2LqMlcJ
 iez70zwSRzxmLtPh6Q6rmJVJu7aB73pEkETrsDGGaTYCmcCr+GCAt74nd569rxFPWk8h1tsWZ02
 qyXJeCklYWIeXu4B8qz76L+xlEw7B5yLrUtcqg3e9qXt6ycNpI
X-Received: by 2002:a05:6512:3c88:b0:5ae:b7ca:33ec with SMTP id
 2adb3069b0e04-5b0235613f8mr3710111e87.9.1784111468644; 
 Wed, 15 Jul 2026 03:31:08 -0700 (PDT)
Received: from home-server.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01cab1486sm4062210e87.81.2026.07.15.03.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:31:08 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Neil Horman <nhorman@tuxdriver.com>, Sujith Sankar <ssujith@cisco.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH v2] net/enic: check notify set return value during init
Date: Wed, 15 Jul 2026 13:31:05 +0300
Message-Id: <20260715103105.39417-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The return value of vnic_dev_notify_set() is silently ignored in
enic_dev_init(), so a memory allocation failure or hardware command
error goes unnoticed and the driver continues with uninitialized
notification state.

Check the return value and propagate the error to abort probe when
notification setup fails.

Fixes: fefed3d1e62c ("enic: new driver")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
v2 changes: validate return code of vnic_dev_notify_set()
in driver init section
v1 link:
https://patches.dpdk.org/project/dpdk/patch/20260707112014.82821-1-bigalex934@gmail.com/

 drivers/net/enic/enic_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 2696fa77d4..f46f429135 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -1887,7 +1887,9 @@ static int enic_dev_init(struct enic *enic)
 	LIST_INIT(&enic->flows);
 
 	/* set up link status checking */
-	vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
+	err = vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
+	if (err)
+		return err;
 
 	enic->overlay_offload = false;
 	/*
-- 
2.34.1

