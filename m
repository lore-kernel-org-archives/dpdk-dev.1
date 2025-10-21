Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C009CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 046CA410D2;
	Tue, 21 Oct 2025 20:58:11 +0200 (CEST)
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97]) by mails.dpdk.org (Postfix) with ESMTP id 0EA1140ED1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:10 +0200 (CEST)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-7c27a099d61so2344585a34.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073089; x=1761677889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=UDaeMnwFv8bHrf2BtxvUyPxzGGw0fr/yIx9N5Omj4rer1BR5a248OUBmOZ/ARkyupH
 izLG9qEwXrexso065rSVSWw4VssqhGeHobJU0hoHDodYNKPlV+MekQymx+bJA8BzDvH9
 Ah5Q4dOeppRmBxhdo1/+GmfVxLu3LJaRI6yr38zuJRqGGXMWG9OoyYES7OcCg73z7heh
 DH/VTVvJwthiWfiO/ZdW2LE+OHWrxqAUh0IiYrdYOLU8FdwUo59d4zlRcYkMXI1mNF+J
 lO6yR90BGO+uju0/q7HpcsgMNpSdXh+SUbKcj5pRBBjIkhe//Yp380S6lhaIFNxx+rZ+
 3nSQ==
X-Gm-Message-State: AOJu0YwGvhDfOklL9Or4Fdq20wDSG9eYwpWTgLTRbjII95PJnWlC4Z5k
 lU0RI911aOY9xaHYcFZCMkZ3JVWV+6SzVTjavDXEiqt6tqIW1Etl7XEjMvghWG8kTLuNbXo/oB3
 cCtiHM8lce8lmP2ArOy3vh+2h2ZswGfbllFou2u5yb0GBYzG7VClm5pJGnvft2f/3CUXyygdyth
 XSj7WG4sEePg5P7UW2ERyXMH7B6rpoQPlVGw9kvZTP6Btwdcq87L2qIszNlXK7wDBDnaEwZQ==
X-Gm-Gg: ASbGnctjRDj2BD1gjYxF/ExUQnDdRfwWTFSDpFZK8WsE8MFSlTznmt0PMUVxjbZAwXz
 a3R9cPMXDG7+MveXyYpHWsnsv3JrXJ2WF5IVgGr/TUKpcKZVuQYMxjO1C2qiHqUHZOC86zs5BqO
 RjjYvU9pJ3vVhi9z79AHNJ2rkBCfA7QLUUEUM0H+TJnYyztzWFhPiiCO0N6awcyurvxu0YDrueL
 iKZvKHgQXEOiddb8YfKCd+yZqXVVb1ThOOIm49bADUrdQc+w9rSXm0eWM1U31tHPdkX1SdH6kJp
 doQ+o2xWXKq9jFHS1D8bX8sbMDnzoWCUe1vOyTrIgqq3+lBdUIGqNeEuGOyuM8DC9V3D6www0KE
 rG9AzKy8KS0Dgn9Zeitqp+lbg4CPIgtDCMLPbsiegBKIPFk7bTHag2V2E/eFTyDhIX6MaCHTeXz
 rGIRTALPivCQkpvywt0pHlPusiEuoOUeOKCRKI
X-Google-Smtp-Source: AGHT+IEZG05rqh+uYs8zgKi1UpaXyOL7QEKZ9YNLcbKzxnZWsSqobIomtA7xsJG1jaHMOs/DjLKy7XrwgNQF
X-Received: by 2002:a05:6830:6585:b0:7b4:1768:ff31 with SMTP id
 46e09a7af769-7c27cca6758mr9357319a34.25.1761073089216; 
 Tue, 21 Oct 2025 11:58:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c2888b1d14sm1621208a34.8.2025.10.21.11.58.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-27ee41e062cso75714505ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073087; x=1761677887; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=FI8tqD3Urhgb410AJmMA6GPAc6RxI0cu4wBw5v3S9ql9APuPVwvbYfxhUFXjtsl6+U
 HiQf6JZXtEZqM59riuUtKVh54/Bo8yJ2FFmf9Tr5iD9R1k4Un827nkOHVUDJ7ibNa20f
 xi1ooHjrb8hV0AAxjZVtNAdRrMN9ytYl4UBok=
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id
 d9443c01a7336-290c9c8968cmr247460155ad.7.1761073087295; 
 Tue, 21 Oct 2025 11:58:07 -0700 (PDT)
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id
 d9443c01a7336-290c9c8968cmr247459765ad.7.1761073086764; 
 Tue, 21 Oct 2025 11:58:06 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 44/57] net/bnxt: fix rss configuration when set to none
Date: Tue, 21 Oct 2025 14:56:48 -0400
Message-Id: <20251021185701.71881-13-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

If the rss hash type is set to none and the ports are stopped and
started again, the check for rss hash type was not allowing the
bnxt driver to populate the correct rx rings in the vnic rss list.
This causes the subsequent calls to rss configuration fail since
the rss list is not configured and have stale data causing the
firmware to reject the rss configuration.

The rss hash type of none should not be ignored during configuration,
it is a valid configuration and should be applied. When rss hash
type is none, the rss context is disabled and there should be no
rss algorithm applied to the incoming traffic.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 00b02821c9..939f35e3da 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6331,7 +6331,7 @@ int bnxt_vnic_rss_configure(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
 		return 0;
 
-	if (!(vnic->rss_table && vnic->hash_type))
+	if (vnic->rss_table == NULL)
 		return 0;
 
 	if (BNXT_CHIP_P5_P7(bp))
-- 
2.39.5 (Apple Git-154)

