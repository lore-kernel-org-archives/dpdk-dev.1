Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD030CD8C85
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D1B1402AD;
	Tue,  9 Jun 2026 06:32:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4B6A3400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:32:24 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659428mi3916132; Mon, 8 Jun 2026 21:32:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=MpmDoqp4WcBTw2OWBeWaCn2
 8G/0pc7gyCDDcRRFoyzw=; b=HD3dx5yXl/dF+WxI/0zN9EKXlzsZ5vRlvK4bFWm
 JFEnlUBXD8YHqr0479FQ1h+GEX2FM04nF5rt0QQGm6gnrlBSMEW0OUlgajR3C+qo
 N12d+BGtn8MOZp8fQyOWMy9eEAdKstre9X17DpQY7PgUGZHwf2nBz3HaHM5bLDWm
 2nZYP23akUCJ7C6YAYHLPNAw6DvEKbLyCCO8WncqQIc2MaZwP6R1YHLL0lF3Oi9b
 vgleBdkcSWXw0LiwtvNjkWxV1ZyxU3yqdRElYE4V54SeJlwKzjIjH1O9bEnJmV/b
 MBfkTB19iwFKgk9KnfZDF44RuzHz8Hlc5RHlUMUagHS24wg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5qfep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 21:32:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:32:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:32:22 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 6F7913F704E;
 Mon,  8 Jun 2026 21:32:22 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 1/1] buildtools: remove absolute paths from pc file
Date: Tue, 9 Jun 2026 10:02:20 +0530
Message-ID: <20260609043220.930405-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a279757 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8
 a=d0kbQRtfWK43Mve3rKcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: htrehe5xfpiSy_nUL8Wrv9Z8rXymYLIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzOSBTYWx0ZWRfXwjSsYJHj8hPc
 u+y2gjdYeiy6zze6U4cNUWLstnPOsN4kV6th9TI1LJernG039f9N/eVvKJrmjHF0CNu524JW3nH
 Lg75MwEanF/wWfRx9Td5nl/FW9LpUIfCFXdUJ9dIfwwMOsN7uDeY2fdtZfwO5no2ffQjIKSYxw8
 UBeaAV2z91a/F9kfWBWo+nFbvnNWnB5udUcEQsr+CBNR8EpxW7vwqKchVi6j29/8cstcWLpgdYq
 CwSwrlSAQznFjQ8QeVSXCjE9Wk7G9ySAFATbM6VR6H/s/BGfX+xxwQNwnX2oef/m3QLWznp0zft
 io5kteo7vyyku4ZsRU7jJ4w92OfL8tHwwVICEgqm2GjXOgEg7KcVyVJ70Q9zngPGTePPeQz86yf
 zyxLxm/AxyanV3aPjeaZbuHIYpRbxohzLMod7mMpbJwm0V09fcr8rEVLEO/SV5MSck26p8hsjYA
 1Z5UqkX7jdp/Fz9bLZA==
X-Proofpoint-GUID: htrehe5xfpiSy_nUL8Wrv9Z8rXymYLIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
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

When linking with non-versioned libraries, absolute paths
of the libraries are added to libdpdk.pc. This patch replaces
the absolute path with correct linker flags, -l<libname>.

https://github.com/mesonbuild/meson/issues/7766

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 buildtools/pkg-config/set-static-linker-flags.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/buildtools/pkg-config/set-static-linker-flags.py b/buildtools/pkg-config/set-static-linker-flags.py
index 2745db34c29..bd217b07fc8 100644
--- a/buildtools/pkg-config/set-static-linker-flags.py
+++ b/buildtools/pkg-config/set-static-linker-flags.py
@@ -6,9 +6,16 @@
 # Should be called from meson build itself
 import os
 import sys
+import re
 
 
 def fix_ldflag(f):
+    if f.startswith('/'):
+        libfile = os.path.basename(f)
+        m = re.match(r'^lib(.+?)\.(a|so(?:\..*)?)$', libfile)
+        if m:
+            return '-l' + m.group(1)
+
     if not f.startswith('-lrte_'):
         return f
     return '-l:lib' + f[2:] + '.a'
-- 
2.34.1

