Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADDEA719D
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 19:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B66B1402B5;
	Sun, 19 Apr 2026 21:48:55 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 64AFA40291
 for <dev@dpdk.org>; Sun, 19 Apr 2026 21:48:54 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8a210c813f8so17063496d6.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776628133; x=1777232933; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Rml9317n0p2iAlkA+bKluoRn9tOb29z66GsnIViX+0=;
 b=EgZIURydw9Wa5JKcbG1kHNK5vREGhZ+Gglv2pO/ixOuY1dX84xEssWwUnIMBd7DeI1
 9z5zsRCnwlTS70tjb1VBvyqxVAaqubF4fjNC+LUzfdB+n/Ox5PfEl8Tduh37TX8TR0JS
 5IQK9KaYFoIhU8AcKyf+LcH6rKDUOHLDOZpbYyFmpyCtyVVPYJoy8E6IDCk1yOcDrbD6
 SNJudlUvO+ZcpvptRGXU0G3MPo06yW2qBPkHYXsEOKdZ6XnWU6xBiIGHjPKDQJO7/mIZ
 4WqV+ZURbBOFSRVNNts8mvCp8C0OCPsEV5Cb4TyjJrMOl7xVIYFEA2WJ7OiD23UV16Hi
 SSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776628133; x=1777232933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Rml9317n0p2iAlkA+bKluoRn9tOb29z66GsnIViX+0=;
 b=MkpLFM6Yhc4J9tLt0Fk793TOLtHE9mjqYC3MY2qeNOg4t32nkbrctFtI6+HffPLDeT
 27/SLIjkhvJlA4ATOSt/jDN4rYptUUoYG69EkgbHxFKM/yySAysM5tWWUULYhTHp6g1H
 ijXhK86lgs5H3mtBEiqWuFBwKkpRPHZA0f0GJp2bjZGeeydrX/F2OGgsjVL6YgYWJokw
 W8gxh7xkKfJFY2FX2qn4xlxbO+pasxLvli3+GhSAxuvz+CwW0NqpfueBBxSQem16hFQ9
 D1+/cL/m/5c4yxM24YzciA5CQSX3Dl2hO/cg4N8wIsPtqqJCzBYSxCexR0P7NdLvwuaM
 Bm2g==
X-Gm-Message-State: AOJu0Yx5WyvbCiHGG6OFyzkJsKai/RGxVO9T5zHJNzdnOKPoH0px6obj
 YcZMsphnExMMPLd60hN7mC7FjW6ExCXCE/JbJu5K9voUOrHU0NHOOLip
X-Gm-Gg: AeBDieuOG7rguHICP/uxwQNASTmPW/6mDMYf8U7F3L+l48gjnZIJeRbEXf6o3UDioSH
 1AA+Kkk0QxIwcVwkxEIiA5I4lPjWmkc2q5L36un68T6DxaLsLcfh/LmH62+jRhT5AVsZHw9xvZ8
 I9+d9BmK9gnk9ot0OyDPbQZA1qmQwqeHltmCSIdcuEXSd/UgYTTGFHMTTH/71Ho5xIvqrzB5/K4
 /yo8dgA/Ggk/79kaXxpclxWigQ7seZ4wjRp1YamM4wIYqTCh5dx5RRBlWuGdBk2A6bWj/rNcjYR
 kFwntIrOzKzPzkV6vNm7KNY/eSRt7vNNBT5rgpfmBXUdoxEBI4ThHcWzhP0khpXvrEbI9su13WD
 vw4eGxydOsp+UJh/jQMwGhImLWIo6qylB8Kizc9AkRB5F05CPpDHNs02qWKHX/oFRBXgvyCFMBU
 zARtzxoftrZIYQUIsykfSYjNylqOythwoPtuHW+w23ZO2ife/nJ/O0jllCI9Npb+/kBzzH6QuIl
 mv/opObGA09ZujtfdvFXYbzgLTUXq7c8eKwh5aFPgR1aGBsJ/LdsDxxit9atkg=
X-Received: by 2002:a05:6214:20e7:b0:8ae:6460:c550 with SMTP id
 6a1803df08f44-8b02812caf6mr173735256d6.36.1776628133475; 
 Sun, 19 Apr 2026 12:48:53 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net
 (c-75-69-100-91.hsd1.nh.comcast.net. [75.69.100.91])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aeb04e0sm58793726d6.46.2026.04.19.12.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 12:48:52 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 abailey@iol.unh.edu, dmarx@iol.unh.edu, knimoji@iol.unh.edu,
 luca.vizzarro@arm.com, Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH] maintainers: update dts maintainer email
Date: Sun, 19 Apr 2026 15:48:36 -0400
Message-ID: <20260419194836.27602-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Patrick Robb will now make contributions to DTS
as an individual in his personal capcity. So,
updating his email in the MAINTAINERS file to
be his personal email.

Signed-off-by: Patrick Robb <patrickrobb1997@gmail.com>
---
 .mailmap    | 2 +-
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..0ce0cfc1a8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1232,7 +1232,7 @@ Patrick Fu <patrick.fu@intel.com>
 Patrick Kutch <patrick.g.kutch@intel.com>
 Patrick Lu <patrick.lu@intel.com>
 Patrick MacArthur <patrick@patrickmacarthur.net>
-Patrick Robb <probb@iol.unh.edu>
+Patrick Robb <patrickrobb1997@gmail.com>
 Patrik Andersson <patrik.r.andersson@ericsson.com>
 Paul Atkins <paul.atkins@intl.att.com>
 Paul E. McKenney <paulmck@linux.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..b61eba8761 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -66,7 +66,7 @@ T: git://dpdk.org/next/dpdk-next-baseband
 
 Next-dts Tree
 M: Luca Vizzarro <luca.vizzarro@arm.com>
-M: Patrick Robb <probb@iol.unh.edu>
+M: Patrick Robb <patrickrobb1997@gmail.com>
 T: git://dpdk.org/next/dpdk-next-dts
 
 Stable Branches
@@ -2001,7 +2001,7 @@ F: doc/guides/tools/proc_info.rst
 
 DTS
 M: Luca Vizzarro <luca.vizzarro@arm.com>
-M: Patrick Robb <probb@iol.unh.edu>
+M: Patrick Robb <patrickrobb1997@gmail.com>
 T: git://dpdk.org/next/dpdk-next-dts
 F: dts/
 F: buildtools/check-dts-requirements.py
-- 
2.53.0

