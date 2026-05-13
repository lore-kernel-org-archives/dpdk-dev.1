Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C29CD4F25
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 09:20:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AADEE40651;
	Sat, 16 May 2026 11:20:22 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48]) by mails.dpdk.org (Postfix) with ESMTP id 7BEAD402D0
 for <dev@dpdk.org>; Wed, 13 May 2026 22:37:32 +0200 (CEST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a8fbe18b1dso857205e87.2
 for <dev@dpdk.org>; Wed, 13 May 2026 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778704652; x=1779309452; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvpVPwVl9TqEAYzoEWcCFDuwRXK4GSA6QZRF7TVVjr0=;
 b=aemxhGAvcm6q+xtS/Yls0/mgoh4iIBCPmDrgpvavheVEzOQXF+35Xiq7XMsHh3aq22
 PSXin4go/p4qbJmKIV6K0RnlCN2qqT63I+YbM51uJzpEcm+SbhtU0a1pfoXmmMgzoubQ
 kStzFT+fLGkbR2d1ESJAOLNHqOkzVE/PKbt1oBX2awdjxL7VA5rch5Tffs1V6+yqk3Pd
 ocLrjOzWKA+CBg8VDX7QcvEAjQwtTnMSUFzBG9dMloGa0V76VIGvqwjTSdN+2dDMwZUu
 pxrJf8/bmbnI+dww4DO1RgwtKblnl+GLAMAKgUd4vpv9raJWwcOVJ6oPoUp+wl//h6BR
 9atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704652; x=1779309452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UvpVPwVl9TqEAYzoEWcCFDuwRXK4GSA6QZRF7TVVjr0=;
 b=G7FxX68ZyxzV8AIuGT8f+yZSJ2zR0EDgjiwtDN3bdeWwNt1Yd8+BIvwyOWcf1bNbDX
 3W2sKgnHyIcVuZoFNG+8fQ4pMFz105DhapbIjduUahQlMxRmSp/UdoKBOTROSJ+pgaru
 sDRScwMPBUsJgxRfCoyx3wPaSpkJLOMUrnHuAdDwoQhNUHLrdh5Q1Ffgua+oSLitvAcF
 R3rO33n/L3JI1ZmZZbKgaKO1NuGNDPDiAU340Sl0Scf2IIJqG6dkbY87kKoz6LHsmQOx
 D0DWpMFnrWOjwpkP04uxxKOfuiiAjfhTgPJsCpXHxDP52ntXsVwZgux60df1HunQBqE6
 1fzQ==
X-Gm-Message-State: AOJu0YytadKaW3Tt4oYsvq1uwDkAyTgTQcrL1Erd2dmLoFye11FcrQSw
 t8nPHzAHdQkzqD1x+jN9ZUsAevGvVeKeih0Nt3y7iiECVIENeAAaaKnVHdE/xUk/
X-Gm-Gg: Acq92OGeWuoPf8d97pMnD7Oq05DShmITONP8FDHvnLa3MXHpccQHI6Z78iqq6lBcSbM
 FKU9lDKcG7E5xjuIFiSToTghSl/GFZSk87nb6lzHjjZtuDmR8CPLeOFmD3s60rGR3eeos5KhVjR
 B7mnOxIT49729jc3BiIySFT5ORo2HImE5E3HZDrKWWGh8t3JtQTKXbie0tHaQHz5xMAE3i9uQ/U
 +zCBESfi60Xtj+KNgJM95le7jcG8ZVJdaOmObwe/Lq/+01MAe0o+GIXycBQQFwhInh0Dx6VFOwJ
 1k1qDkvjrc2rmT+5iLKx2b4z71UB0hQ7vSdRc4ADG+Q9cPyovwl2GvqhD83GPbG8i9JD3rHm0Tz
 t3ZvMQMBNn3qcPR5YOJw7iB731W1xX+BlltK/vMHV3alWulpxyP3FOO4GXNFFw75Uc5OcZpJpXZ
 eHKEjP2VsSFfCbEaLpbZjDrtAOycmJaw8ThURP/c+noaCbTGAQ2r5xqzpsKVSxyiplTqdPZhfX7
 6I=
X-Received: by 2002:a05:6512:33c5:b0:5a8:d3a3:598b with SMTP id
 2adb3069b0e04-5a8ef99be0amr1590627e87.28.1778704651656; 
 Wed, 13 May 2026 13:37:31 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164ccd16sm31765e87.66.2026.05.13.13.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:37:30 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@oss.nxp.com, g.singh@nxp.com,
 stable@dpdk.org
Subject: [PATCH 2/2] dma/dpaa2: fix dpaa2_qdma_remove always returning success
Date: Wed, 13 May 2026 23:37:25 +0300
Message-ID: <20260513203725.1905-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260513203725.1905-1-shofiqtest@gmail.com>
References: <20260513203725.1905-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 May 2026 11:20:19 +0200
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

dpaa2_qdma_remove() checked the return value of rte_dma_pmd_release()
and logged an error on failure, but then unconditionally returned 0,
hiding the failure from fslmc_bus_unplug() and any higher-level
caller.  A device-cleanup failure was silently swallowed.

Return the actual error code so that callers can detect and handle
removal failures correctly.

Fixes: 8caf8427f85a ("dma/dpaa2: introduce driver skeleton")
Bugzilla ID: 1914
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index beca464c72..f7d94bb799 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1739,7 +1739,7 @@ dpaa2_qdma_remove(struct rte_dpaa2_device *dpaa2_dev)
 	if (ret)
 		DPAA2_QDMA_ERR("Device cleanup failed");
 
-	return 0;
+	return ret;
 }
 
 static struct rte_dpaa2_driver rte_dpaa2_qdma_pmd;
-- 
2.54.0.windows.1

