Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD7C636BA
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 22:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0D82402B8;
	Sun, 22 Feb 2026 23:15:48 +0100 (CET)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48]) by mails.dpdk.org (Postfix) with ESMTP id A86F04027B
 for <dev@dpdk.org>; Sun, 22 Feb 2026 23:15:47 +0100 (CET)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6786b13984fso2512427eaf.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771798547;
 x=1772403347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ac4G2voK1zAofTTlpkSi1MYsCTbvU7eOIIwPSTmjeY4=;
 b=WxI0TNP65/7T370pUUVVMDBZyzebQigv5SjiQvlTX94PELVyq2RVhaRk+Y3zj8R3Vc
 Tm3DVXEMFmb+JDzjv4Zml0j1soksz3Nz/I1LaHh8M0cZPCDsMg0MryvUjLz7ynV7gW6m
 CQYkmFCJj7M1ra6to6Axow9ZvaxsrcnWJ0Ve1CxPliDyPeak7BnyMdghK83phN6brMR7
 GU6NRlEuN7CbqH6j58WJQ34rUn7OLBWYxI/G1KJLtvuy37JcRB8oSgOP1Y163ZbGJIbS
 Z/G8jKO17omtiPBtecuXruAuRdmzWVHdeyXwgNFKR5LlcCtuDaIWG8hVQ327HNLPZzMb
 rp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771798547; x=1772403347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac4G2voK1zAofTTlpkSi1MYsCTbvU7eOIIwPSTmjeY4=;
 b=Y42oAclKF3281SYf/PkkoaTr4Pjiv80TUOthFLF5vWcLflPmTp8jcEHBvqjxJdrCPX
 ZcN3pV3Wq5WXPgMpTd1qzFS7bMhJ/0fPi6wSNHY04osYaCATFMNT2heVCQn9BrZmYSnX
 6ySikl+3B8PZzngCzEVYYnfJgaMj1CLitpJlTMlnbWap3IUaAtEgRBfdLmSWzTMkfxyg
 vhMqMPiJf7wb4y6hTPZT1UFs/3Jj34Uhz8sHUF5oyVrVQdMO6NMsmpFITgNIZghfoJpD
 7DpcjpowUfXmthhQqETS6Uik6OiFXSAr4srkmiMu0H2nQwcJ0SxUxfbua/g/eRA70xmc
 d7jA==
X-Gm-Message-State: AOJu0YzxIpqhMOzYNjAcIpVCGMXIr+L0FaoBnOcSTfij0aMtgekgUa/y
 CVkPe+icih0Ik/yahU9xFWOMYl6rOZ4zaSPWm9KS2YxUFFm48p7uMoqW9hsu3dM9X1D7aOW+q1O
 BPBgp
X-Gm-Gg: AZuq6aIeBSA4bYOnWWlE6+TNdPsbCYEJVNHqj5cjvPT7m58C7Y/6hlIaCs4QYyTqitt
 UcxFHBiw+13u4tdo7R/BJ3NKt1FtEIaWL2OqViVEa84d9gC7n28fuXzNCg11MWAinXaeZjXZts/
 bcnBUT7FXUbbHfjBCjzNbY5Y5W21pw34usgszDk9oSTKs2ErK7j2aO1tacsvF7IrYjr730ow7+a
 cDMvYigukVvVYMZSH11kqN/4tKL3Bx3fVGqgWZUhxKsCS10UFZZCfHGj3U2rx/d0hnhsUmDuzCu
 QznwqpGtAQ5Mf6lre6gqTH0h4rEMl/2gfw1pN6PPB38g7LEbNVAo0epstR4FOhhun9I0JD8ciF1
 ViFzDe5Mf2eU8roCGxXiU9qP4Rqm2HXs8YTOZ7+JbIRyRlxx/+U7lIoxNefhRuwNX8wp7TDJsgV
 icxEwhOD0vaVkRlxLX8EfG39Y/fhWkIOqe6GJ+6OxaFhZScEuokrXUXSZwBvjoag==
X-Received: by 2002:a05:6820:150e:b0:663:11b2:d61d with SMTP id
 006d021491bc7-679c466b431mr4369992eaf.25.1771798546732; 
 Sun, 22 Feb 2026 14:15:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56574ddsm4843548eaf.7.2026.02.22.14.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 14:15:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [RFC] test/eal_flags: suppress vdev_netvsc auto-probe
Date: Sun, 22 Feb 2026 14:15:42 -0800
Message-ID: <20260222221542.804546-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
driver auto-injects itself during vdev bus scan. This interferes
with the vdev flag test causing the nodeaction subprocess to fail.

Suppress by passing net_vdev_netvsc,ignore=1 in the valid vdev
test cases. The scan callback sees it already in devargs and
skips injection; the probe honours ignore and does nothing.

Fixes: 0d684a783088 ("app/test: fix and separate --vdev unit test")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_flags.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index bebddf1c98..1c0d8e040a 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -426,13 +426,16 @@ test_invalid_vdev_flag(void)
 
 	/* Test with valid vdev option */
 	const char *vdevval1[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs,	vdev, "net_ring0"};
+				bus_debug_logs,	vdev, "net_ring0",
+				vdev, "net_vdev_netvsc,ignore=1"};
 
 	const char *vdevval2[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs, vdev, "net_ring0,args=test"};
+				bus_debug_logs, vdev, "net_ring0,args=test",
+				vdev, "net_vdev_netvsc,ignore=1"};
 
 	const char *vdevval3[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
+				bus_debug_logs, vdev, "net_ring0,nodeaction=r1:0:CREATE",
+				vdev, "net_vdev_netvsc,ignore=1"};
 
 	if (launch_proc(vdevinval) == 0) {
 		printf("Error (line %d) - process did run ok with invalid vdev parameter\n",
-- 
2.51.0

