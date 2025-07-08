Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F4C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 11:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 886244068A;
	Tue,  8 Jul 2025 13:49:31 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 7F31A402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 13:49:30 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-313cde344d4so4090005a91.0
 for <dev@dpdk.org>; Tue, 08 Jul 2025 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1751975369;
 x=1752580169; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBUAlr520GEIaF43eeHj5UpS+kiJScniCzzyNQYgw7E=;
 b=h3cDre+lTTkthWe1IN+/scsi6ZKdSLcAHytYn7I7/D1EefL0GYUuqF9qxgMxJVtn1M
 Yx8G0FW3TS42wIZGMg5Zr2nMOKrX4jgtTuKIkninLYG+xXMf7LqXBlpZOx8/vD56BtEc
 IQV1x111W8xz2tF9azjOjgvjtG1GJ8TWE2aUA6VGDWPno5fOL+mYvFZc0/U1NuGDKU0a
 AlVwsVsrf84l4qHYqXUO/8grnztSsfRrTZ0Yi4in9u2TGK0MvD8QxNK0pm56phEDUaUc
 ytYMeRQe5Cs79k22bhW1Coo2jxyvs39qTua+wozs2QDYu1BbZz10xPA6IIVGX02q+a//
 jdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751975369; x=1752580169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBUAlr520GEIaF43eeHj5UpS+kiJScniCzzyNQYgw7E=;
 b=fkSWBTCce8u/+U7VDZIgzRYc5cNLA8BGRUaAFuxMqW5o2twUPsD0YMrJWGVrJ3ONyH
 dqWXIX4IfKvqNTyC/3wCng7P17dHTxleuK1Sev3dOiqV3l5JojWkx33eX0nhRbIXoKIn
 JfnB96L5cZHFnge6j0uJkQi8UptpeRrGbxiCeC4agFcJRpyvvqihe9u4qasLHE15h6y+
 hoKoTtWF2Alamw1qhOvGBRNjWLLQHcMt0oBv5rGLDO2Vp6eYaPLY69lObjEeXJakfr74
 LSwXCjbg19ASggeCoOizZwiH9cNsUB4oF/w392oxjwtjS9i24wbPsE1LhV9Muu3Qe/ui
 bK7g==
X-Gm-Message-State: AOJu0YwKsAyFGpr9/ySeg1KEuBfABu/VOOgikc1dP1j1sItW8ShPWXPD
 ooJ72Xe9tcxOal4Om4cZmHBwMBvdT3v2hH+SoIBUFqNRi6h1Qw06LBZNDnFyeD+xtMYZBDo4BAM
 7d0p5
X-Gm-Gg: ASbGncsQp+eWL9ba4Nd+DMdkrxADFAEaz3OQYtEzXMgO+xfCrFKXpbMXDmpDbfMBa/4
 0EfX3iVRBcbdz2Eg94MYBxULh/oLzADHhh1gmtmJZPMTPsw5/3VZAG2n2ut+V35olYgJYxK2MSt
 8lEi86JW2WBVdKPK+H7ttcy6bWYRUkMfHfaI4tDBXam0Rlv4Ew/0GPyyo1nLgrVwMHiqv6rT8Zu
 uG2Xnx6MbZppWKWfW2v7AWcv1ybUGYZXO2teQIw1HaRkvWFPUkJtf4oR8+lnsMnVR5dNP+liAn7
 VQJZGBz93gt0uof9DBjIfbCAcO6tgXo6SHlPX5eFQP539KIJGumalW0UW1SRWE8YpY3/x4TQI7K
 X4Ik=
X-Google-Smtp-Source: AGHT+IEEIgRZWW+6onKhuu+8JatyTbuaWDLiYQVaerGvdxPIOL6UncQPihhhK/5UZxUyEgt90Hn3mA==
X-Received: by 2002:a17:90b:52cc:b0:311:ffe8:20e2 with SMTP id
 98e67ed59e1d1-31aadcf47f3mr23276597a91.4.1751975369398; 
 Tue, 08 Jul 2025 04:49:29 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c21d67c46sm2147192a91.19.2025.07.08.04.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:49:29 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
X-Google-Original-From: Khadem Ullah <khadem@dreambigsemi.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com, stable@dpdk.org,
 Khadem Ullah <khadem@dreambigsemi.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] doc/mlx5: document firmware requirement for flex item
Date: Tue,  8 Jul 2025 07:49:21 -0400
Message-ID: <20250708114921.1031027-1-khadem@dreambigsemi.com>
X-Mailer: git-send-email 2.43.0
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

Some BlueField firmware versions (e.g. 24.30.1004) do not support flex item
definitions using FIELD_MODE_FIXED with size set to 0, such as in 'next_header'.
Attempting to use this configuration may result in the following error:

  'unsupported header length field mode (FIXED)'

This is resolved starting from firmware version 24.38.1002.

The patch adds a note to the mlx5 guide explaining the firmware requirement
for such flex item configurations.

Fixes: 16508bfd0816 ('net/mlx5: doc: add flex item specifications in mlx5 guide')
Cc: stable@dpdk.org
Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 doc/guides/nics/mlx5.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c3a350d24e..1b0e3efc41 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -476,6 +476,10 @@ Limitations
   - In flex item configuration, ``next_header.field_base`` value
     must be byte aligned (multiple of 8).
   - Modify field with flex item, the offset must be byte aligned (multiple of 8).
+    .. note::
+     Some firmware versions (e.g. 24.30.1004) do not support
+     ``next_header`` with ``field_mode = FIELD_MODE_FIXED`` and zero size.
+     A newer firmware (e.g. >= 24.38.1002) is required to support this configuration.
 
 - Match on random value:
 
-- 
2.43.0

