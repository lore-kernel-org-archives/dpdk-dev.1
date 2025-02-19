Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0AC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 01:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A723440B94;
	Wed, 19 Feb 2025 02:40:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6998C40659
 for <dev@dpdk.org>; Wed, 19 Feb 2025 02:40:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 6BE5E20376F1; Tue, 18 Feb 2025 17:40:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BE5E20376F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739929207;
 bh=lbEnwr8ib0/Z9UySJ8e01mvwuaSZgRUNkqA/bSBXhPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P9ZaFP1w5eD0YMtoJN3qLZG8UwLL/CcNOjspwKcUuU688/xoTCIYa8+29bnx+z9bN
 DDk0MkcNqYJ/WTZ0s8HDyCuJby1eTHltl6HtPCM5ynJpMa+syF2dPNgWTdhzj+ulNO
 OrLb2Egc1lyLiT3kSpm318ddg6RTwZICX3D1ezis=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 2/5] buildtools: update map_to_win.py to use optional map
 file
Date: Tue, 18 Feb 2025 17:39:55 -0800
Message-Id: <1739929198-28432-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling with MSVC the error below shows up due to function
versioning:

../lib/net/rte_net_crc.c(418): error C2061: syntax error:
    identifier '__attribute__'

MSVC allows alias function names to be exported, but the mechanism is
different than the one used by gcc. It was considered to enhance the logic
in the existing version.map files but that file is also passed to other
tools on Linux, making this challenging. A simpler approach is to have an
optional version.map file to be used only when Microsoft's linker is to be
used. This optional map file is only necessary for libraries that have
versioned code.

Script map_to_win.py was updated to look for this optional file and use it
when available.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/map_to_win.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/buildtools/map_to_win.py b/buildtools/map_to_win.py
index aa1752cacd..f75db3842b 100644
--- a/buildtools/map_to_win.py
+++ b/buildtools/map_to_win.py
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
+import os
 import sys
 
 
@@ -27,7 +28,20 @@ def main(args):
 # This works taking indented lines only which end with a ";" and which don't
 # have a colon in them, i.e. the lines defining functions only.
     else:
-        with open(args[1]) as f_in:
+        input_map = args[1]
+
+        # When an optional map file for Microsoft's linker exists, use it. Function aliases can
+        # be used in these optional files. They end up in the exports.def file:
+        # EXPORTS
+        #     rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
+        # More details about the export file syntax accepted by Microsoft's linker can be found
+        # here:
+        # https://learn.microsoft.com/en-us/cpp/build/reference/exports?view=msvc-170
+        optional_input_map = input_map.removesuffix('.map') + '_ms_linker.map'
+        if os.path.exists(optional_input_map):
+            input_map = optional_input_map
+
+        with open(input_map) as f_in:
             functions = [ln[:-2] + '\n' for ln in sorted(f_in.readlines())
                          if is_function_line(ln)]
             functions = ["EXPORTS\n"] + functions
-- 
2.48.1.vfs.0.0

