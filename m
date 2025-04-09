Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A43C369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 22:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BFE4066D;
	Thu, 10 Apr 2025 00:42:38 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6412540288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 00:42:36 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7c56321b22cso23830385a.1
 for <dev@dpdk.org>; Wed, 09 Apr 2025 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744238556; x=1744843356; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaQFHWKIIskiUQFn3BAS/NAKm1+4wFIuh4ejY5o2N/Y=;
 b=MsMbEfeb3exnvKEkZS0L/KN68Hw6F8GQC8zoV7uq4OX4a5QU7QRv2JPhiieqEcA7Ol
 9dnUvH1iN9vkivvbrzFAR5i6r+olJqAlCiR0TZ/Gqu7h0tfU57jyC6lJ/7wmJ7PUyjc8
 THcLlqtsLIqb2Lk77M2QXVEUAv4P2LyuRgvCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744238556; x=1744843356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaQFHWKIIskiUQFn3BAS/NAKm1+4wFIuh4ejY5o2N/Y=;
 b=hsq0MW7sWhDa87d4vW2mYhhcHvWNFY5s7Sri/7LJAN0jpc8wuCLSgq37vAhr8niuyP
 B3GIELC9LdC1PdLxKlrTh7A4Rnycgalq1z6MmBhvIR4kZOSHYEt/DGQGuqg2Agbg0ZGW
 jxLO6blB/DNpLLm6gjeRJOBOBU+w9JKgF1IEiTkE4gzcYK5CRMf7qJXI7DNISxMAivOx
 yhwYmUodAOF+OV+r0+pyTfQ2TwBo1nw16ly8zUlg/etPzy6x7hAPfrtfWa/bjFdjoS9C
 /qaGNrPcYNWmFzozXI0wgj5ULsgjULVHMR13gOMEwiYh+h9PAQ0+Sef/LaBqp+WFy7u5
 SU7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE9D3aVXvy82xztrbfyIN0GUN3RN3jvoa/tDy2d7LP+gmeESOOIXeYmV0WyuQPkRv8rI8=@dpdk.org
X-Gm-Message-State: AOJu0YzmVDZM4PLH4ACp36qS9+gq4DT8A60IyYcPCnw9h0lyQhYwXekp
 SBBOK0LRj9u/QrTmr8nQUfbEpf2cM4iTrU33tAEIv2cDgj4xYm6jEf1Yy6ZzG0s=
X-Gm-Gg: ASbGnctPmNWwCrb28MrjjsvJAVh/9ngXlJQ8TxUNZz4vQEiyzZ8tKthGhXF4jbZ1Ldo
 Y8jLxY5WHdbKmIanSwRFw2dzFdgDUKKO/UhacK0KzAKHzn5rIHuSBHJgmpycng55fdYFDaLLhti
 mq/cQwFSA26ecgPX42tZKDUAMXswgrWT35UsYvhjwvufQQ+EALWPYWAXVyMJozM4n7XPw3Ne492
 sPaEGx8tXeDYsGa57fnDOyYgoSdUCmBZejgW59qnTuiF4Fy2akKd38ZkyuvF2g+KU7IsxrJjITg
 Ul1ozLy1fWdoQm5WKVIizGMu52sgGgfhTkCtvZ1GRIwC6ehOqlffEX19l8+KkQ+azG0elveM8qF
 hRaQQkgVN7BLklQ==
X-Google-Smtp-Source: AGHT+IH64mTHavKPa6T990MtHOy5ay3yTZ6DqvDHWvCRwQH1WfSDLoarH4/fqhOBb1p9XYNBv3cdBg==
X-Received: by 2002:a05:620a:408c:b0:7c0:a58a:cc9e with SMTP id
 af79cd13be357-7c7a76c6fd2mr74195585a.25.1744238555818; 
 Wed, 09 Apr 2025 15:42:35 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a11ca015sm125949985a.82.2025.04.09.15.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 15:42:35 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: probb@iol.unh.edu, Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 npratte@iol.unh.edu, Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH 2/4] dts: update dpdk-devbind script regex
Date: Wed,  9 Apr 2025 18:38:23 -0400
Message-ID: <20250409223825.1579256-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409223825.1579256-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250409223825.1579256-1-probb@iol.unh.edu>
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
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
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

