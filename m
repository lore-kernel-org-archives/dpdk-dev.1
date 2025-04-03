Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4601BC36018
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 02:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB36E406A2;
	Thu,  3 Apr 2025 04:35:00 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 584C840676
 for <dev@dpdk.org>; Thu,  3 Apr 2025 04:34:59 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c5ba363f1aso53805285a.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743647699; x=1744252499; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFXHsyFOANS4/7xiq0UJEHoCHEkax4Fev8yP9zuMmF8=;
 b=EYlhVnhfra7H+ttFQVwkbD6NX/g+O3BBjnukFFMxRFNjjvnpxBTYQNX0iLjNgJer9K
 xoKoM4hMtqaPv8pLno+rE3RCTK2onnl2V44k/fuJn1tjDk6wQRGNkaQvi+vB0yxc+27a
 8lDdU6V99p9f18pt2nhyQFGPZEWzAABg/iEOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743647699; x=1744252499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFXHsyFOANS4/7xiq0UJEHoCHEkax4Fev8yP9zuMmF8=;
 b=lOfHKPV8eVKEUUB7S2FC0A613iOGOEZqsn9LW29kxUZFEBLv4YTktEDdeEgJrCGpEg
 uoEoR+J5G2G+mhtOMyQxzvxxG30ivmryzcxuPFaiNEpWkF76jcy1x0h4kRj9b+TWdMU9
 Uu/w5PV0/hAW9kLS2XqQVrS4cPZ/rYHZjN5l6DX37du5YA9DjNvYdmq4+ZwRuAwQ8+sH
 /x4604g5cP+9KImE9YEdY5DHeqAIq1JdkYn8MUCVZ+s/o1gSp5qS3TiZrysnEjUUV2Z3
 8epu6ww+FxKYit+ec4QyxDk5+RTlcXipKFX3U27kNDAgH7CuoMoFnqQKG+ZSSAnhDz8N
 nZeA==
X-Gm-Message-State: AOJu0Yy9Rpiw1nzKVMGQGZuiBZoL+wpQfjmtoFQkZlBiE4bPbyGjOYTH
 fMvfyqOtrsby6xI37vWyT+cfVZjXT0g2bBcyaMzqIEpxnepogflPloBwBkmijLI=
X-Gm-Gg: ASbGnctXgPhOorXzEdf5lVdI2sg4TkpD0KMUdIXDC/i4jI+fp189rai8xqqcEbzeBkJ
 +hnoPFcqZt2V0TnJEBqoAwjm78yFD8t5lSORGJnZjXI8zQomxixMpDSoIAJsWf4lSZo1x0r1JPG
 kJ3qoVbMCqAtLH4eqaX0eN2ZWYhgGr2xdBiyd5p7al8aUnA5obWg+N/7BmVodUlPXkN6/TQFRDe
 RksohXD8NkMvudAC93Im4t0fVg85+cjXJPMaUdoZIonWjdQoGwH5zcKFagEt00arAhv0OKi3UWf
 Namw6hadr9VhvMNlC9j+wfDx+xscpVyixg6NroT5RYzcJK70yFAFgeRPcyy9jrdarUilHRpcbjY
 =
X-Google-Smtp-Source: AGHT+IFRZKdjsJMV7Zo/jjcfTi5vvduHLNpAV93IPXcKBC7SQg13gNLfmaBfKaRsNs8eAAQZ2us2Dg==
X-Received: by 2002:a05:620a:390a:b0:7c5:5296:55be with SMTP id
 af79cd13be357-7c76df77f99mr129872185a.27.1743647698818; 
 Wed, 02 Apr 2025 19:34:58 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea7efebsm23764585a.91.2025.04.02.19.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 19:34:58 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, dmarx@iol.unh.edu,
 npratte@iol.unh.edu, thomas.wilks@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 2/2] dts: update dpdk-devbind script regex
Date: Wed,  2 Apr 2025 22:30:59 -0400
Message-ID: <20250403023059.1762841-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250403023059.1762841-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
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

The current regex used for matching against the
dpdk-devbind status output is no longer matching
correctly. This commit introduces a more permissive
pattern which will yield the device driver in use.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_smoke_tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 352b92ce6c..9e4d06a1c4 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -135,7 +135,7 @@ def test_device_bound_to_driver(self) -> None:
             # with the address for the nic we are on in the loop and then captures the
             # name of the driver in a group
             devbind_info_for_nic = re.search(
-                rf"{nic.pci}[^\\n]*drv=([\\d\\w-]*) [^\\n]*",
+                rf"{nic.pci}.*drv=(\S+) [^\\n]*",
                 all_nics_in_dpdk_devbind,
             )
             self.verify(
-- 
2.48.1

