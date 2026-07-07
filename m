Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E12C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A9E40679;
	Tue,  7 Jul 2026 13:22:14 +0200 (CEST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54]) by mails.dpdk.org (Postfix) with ESMTP id ABDD140264
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:22:12 +0200 (CEST)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5aebc8cb5bcso2698727e87.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783423332; x=1784028132; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LZnwyjM2SQ9q3472mCqdqMQH5cJuvSikxhts4nuQyx8=;
 b=eEA1YI+gyKq7zV4ksfZ0tV94wlEZQQcMHxunY2UAa819eTq7ICD+ZamHEEtBPYhTnT
 Q+QeuCllRpImcchHqqPlk73RwCXFKVgCC9MJHWZCQIUxw4M1GBTmWGGt1NO2gVaZ3+hq
 mdGk9b86Ub4gejHlY3oy6vMrTWrA0CdC54sE7g9csjRkNQeHkmPEGk52anKxScb0Uczt
 jBJXqrCHItX2hCNZDN5ysCqLm4EAHsVP0vf7/XRXRMlUrx9icn8mxRScgOnwCVuAiMBJ
 tnEHE/24xX9MHdU7ZLNhk82z/Tpz2wxTJCztAUFeCbRRSD5xvGNEQxEbXYs+AMIExl0L
 QSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783423332; x=1784028132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZnwyjM2SQ9q3472mCqdqMQH5cJuvSikxhts4nuQyx8=;
 b=H0qxe+68BuLURm8N0LdRP+YWfbR0Y9ihKzmyOJ0/j0tp28rrlQ/dPxe71wXeOXLVSy
 K7aBRRs8G4mhnzlwhjMVI1sTzmwPvSml/Kjv+ApBCHoqtlliIGe33xkCNpYcUg4n9ZtZ
 /DN+OTsBb5YIMIrZTEDRtGey9idShEBjdXerzbfC8ap46vFBE8PUF0LY1lywYZ11o2fK
 wntsYpItdX3+2RDi2PKgifIluC9Tr57vOgLVcp0LTWzdzod8XTuo3VP28nGOt6SBV9Uv
 noky2EMvVIXMCwgYyZs6963tU3K9cLGMolnnBTswi7rkPRfZr5+SGGdk7H4x2Zn9Pr2l
 Vg1A==
X-Gm-Message-State: AOJu0YwTV5t+089pBESxkBHtIuBxNuR9JIRShACKHQwSiz4j/9WJkVzk
 zDbADigk1skuQFivw5wi9bmwre8KDN4Ooub0qSqEl98HVqzNphUld0ow
X-Gm-Gg: AfdE7clnZG1cLkeuCcr21wUJMaz+qAv+r48VOLbjaQTG509IUw2fdUGY8pC2pc9Jhk6
 sjhhdpCZmdkohdZaJJnb3PpsIivlKWoitCuoLPW/nPSMojZQFLfdJLIC1Maq/9OdeHsJHgcN6Yw
 dWXUPmU7u7rxUyFxyDfYAJfN8KdkEoi1Y1RzWn5P7fPOUQuU5TIkFuWhfkUqWTPvjB9ySX03y2/
 jZEXYkvAhJ5LY7eFaB7JMFxQuIi/zMLPXdIkpv5IwdNeAVygi2MdNRcwsiK0ophlNFoBv7rypXz
 k3blPLMCt6RBun5RH1YBnr7H8xbp1geYaL7CKXZOa7/GjYElZuWo5zOUvFRCTyHdNXHSSEpbifw
 PpT+ZrIn5r+ucbnil8oJeqGWtdNpoa/sf2ikdK5tpfzRXukQOOPbVXjCXRD4B/9puIZ7TQUiVpV
 TMlzXk3HJDNAYEnH90wj+M9C7jo/3b8FAXguVnD5pjrZ0u7FBM
X-Received: by 2002:ac2:5b0d:0:b0:5ae:be88:6db3 with SMTP id
 2adb3069b0e04-5b007c133d2mr773582e87.29.1783423331659; 
 Tue, 07 Jul 2026 04:22:11 -0700 (PDT)
Received: from home-server.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed136f8dcsm3605062e87.11.2026.07.07.04.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:22:10 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Sujith Sankar <ssujith@cisco.com>,
 David Marchand <david.marchand@redhat.com>,
 Neil Horman <nhorman@tuxdriver.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/enic: fix possible null dereference in notify set
Date: Tue,  7 Jul 2026 14:20:14 +0300
Message-Id: <20260707112014.82821-1-bigalex934@gmail.com>
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

The memset of notify_addr in vnic_dev_notify_setcmd() was performed
unconditionally before the device reset check. When the device is in
reset, vnic_dev_notify_set() skips the notification buffer allocation,
leaving notify_addr as NULL. The subsequent call to
vnic_dev_notify_setcmd() would then dereference the NULL pointer via
memset.

Move the memset inside the existing !vnic_dev_in_reset() guard where
notify_addr is guaranteed to be valid.

Fixes: 9913fbb91df0 ("enic/base: common code")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/net/enic/base/vnic_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/enic/base/vnic_dev.c b/drivers/net/enic/base/vnic_dev.c
index ba8ecc16f2..e6d34622af 100644
--- a/drivers/net/enic/base/vnic_dev.c
+++ b/drivers/net/enic/base/vnic_dev.c
@@ -964,8 +964,8 @@ int vnic_dev_notify_setcmd(struct vnic_dev *vdev,
 	int wait = 1000;
 	int r;
 
-	memset(notify_addr, 0, sizeof(struct vnic_devcmd_notify));
 	if (!vnic_dev_in_reset(vdev)) {
+		memset(notify_addr, 0, sizeof(struct vnic_devcmd_notify));
 		vdev->notify = notify_addr;
 		vdev->notify_pa = notify_pa;
 	}
-- 
2.34.1

