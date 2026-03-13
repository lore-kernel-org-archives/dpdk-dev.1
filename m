Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432CA103E305
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 15:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40F0B40279;
	Fri, 13 Mar 2026 16:56:06 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 14E0F4026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 16:56:05 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-506a6cf8242so21734951cf.1
 for <dev@dpdk.org>; Fri, 13 Mar 2026 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773417364; x=1774022164; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/H2yYljIvoLTut1SsU1ZJKdXgvGslDNGgqGXejv55aU=;
 b=XA5WnCHiQT+rqBjjjQWg8yGVNXKKdArzqp7imsSqcFw4ZRoabfiKqSuMajTnms2P4/
 kA+NNSFQduI/Z0SE9qoonTzRSbNXG2inkuv2/6GnbKHXzj4+TuLZlsaijBDksasn7YtJ
 /i/SLNkU6CUuLmkFrjNDbYCMf0HvoJhXUuT9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773417364; x=1774022164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/H2yYljIvoLTut1SsU1ZJKdXgvGslDNGgqGXejv55aU=;
 b=jpjpjZ5kuPlQSTl5m/0SGQQgWJaX4Z4H9J4+4thblADEVLemhRJjZA0pWtGJH31R8H
 bmlY2SgNpQ4JZosJgvVqEB6jSJPTl0lX22v1YKWSbLHFjwd5yzd0k0mLvo9RxVjz0KJ/
 bJgrspD8/kbBWK3XG4Py2LcVG4oSp+it8o7BD28g4caNvgJB9C4y7Vp7BQOe1VKYPiPj
 WK8P4jESy+n9zaO6nBYLCoRaahkO6r778hJddogimfzKDmzMcYyFDN6G+CJQIUkHtyNN
 IGF7lQ/mBJgW5A2WDBGQfFRN2TCKnK2wzJ39afGeYCRRGaUArF2aJYnME0sWdeiy55l5
 6Dlw==
X-Gm-Message-State: AOJu0YymcmR1clICG9CdUA+urICGlvdgbSMQtcxDz4V3RjcUtLhSrNvy
 XCMygjcAWGDymqsRNaoiNZbSLYqjI8Oh3taR3wLCKtbrBSDLJh9Qqgr//oKk8hAFxvw=
X-Gm-Gg: ATEYQzw2J7Yh7dKW+Sn17zEL0+fd3wO9UFzGD0N9Sg/pP4hnxBsgBIRxvbRiTv01zDz
 d9N4bmMWKR6nPGAxEj7+iw7ABdid6gFT2unCZoYBuITWvoF4Nky6MuEMsk7zriFqO2zamX+E+a6
 gpzSnndWNEI8cQRdVMxvI2/M4nr3XnV3eYtKl+/BnUx8mqGADll17ZNWqne9KjUDCbOhS6fE9jg
 nfCvrMu1mQU037SqAAfgnsWKD4rtccMx6Dbxd854ovFICbYMiDPiLUuawepU3xolJwzXSeNHs7H
 V+f6muuo8LEyRRG2YY5QoRZ076EZRF8kGG5HpE1mgzYEwJCXktydeN049VHod4Zbkdjxhuu7cG8
 b6m5GEEYrGKZ/UBBG2ZztLK7H8WDXKfMUzRQ0hL8wxrCGVolh4rofSJr/cw0+iWYEK5xhqlK8VX
 kVzxYsKc/nS0AypalYMMUfq75SUzeM3T1GpleM5tXoPBfHML8sL8NrnBoB3Q9PoA==
X-Received: by 2002:a05:622a:15ca:b0:509:3d06:96a with SMTP id
 d75a77b69052e-50957df51c3mr49932321cf.53.1773417364155; 
 Fri, 13 Mar 2026 08:56:04 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a11cc4esm65948321cf.27.2026.03.13.08.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:56:03 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: update overall result pass/skip logic
Date: Fri, 13 Mar 2026 11:56:01 -0400
Message-ID: <20260313155601.112819-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
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

Update overall result of test suites such that
when some cases skip and at least one passes,
the result is a pass instead of a skip. Only
when all cases skip is the result a skip.

Bugzilla ID: 1899

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/test_result.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index c6bddc55a9..0a43c23c04 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -195,10 +195,11 @@ def extract_result(value: ResultNode | ResultLeaf) -> ResultLeaf:
                 case ResultLeaf():
                     return value
 
-        return max(
-            (extract_result(child) for child in self.children),
-            default=ResultLeaf(result=Result.PASS),
-        )
+        results = [extract_result(child) for child in self.children]
+        max_result = max(results, default=ResultLeaf(result=Result.PASS))
+        if max_result.result == Result.SKIP and any(r.result == Result.PASS for r in results):
+            return ResultLeaf(result=Result.PASS)
+        return max_result
 
     def make_summary(self) -> Counter[Result]:
         """Make the summary of the underlying results while ignoring special nodes."""
-- 
2.52.0

