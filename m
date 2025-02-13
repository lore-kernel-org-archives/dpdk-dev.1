Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B3C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3B040279;
	Thu, 13 Feb 2025 19:58:33 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id ACC9F40263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 19:58:31 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id A051C203F3C2; Thu, 13 Feb 2025 10:58:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A051C203F3C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739473110;
 bh=YYEFBEHuMDIf0KkuxemlOulHiBg5hO5waDCSvILTcXw=;
 h=From:To:Cc:Subject:Date:From;
 b=rv2xat8KZmwRlSXCLYPS5fFpebrh/37UrRQLlz3vnbYcBJ1Rmr83YzGaAMVjrX7Bx
 tzKIPQNccPjDOyd9UuHqcFUuI3Glm0q47kA14NppZ8BEtj7uVu6/5A6ymTJFV4WUuw
 2h461VlGqmRNwMlAUJeyT/Tm+VlvrcELicXvMbIc=
From: longli@linuxonhyperv.com
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2 0/3] net/netvsc fixes for handling PCI hotplug with
 multiple devices
Date: Thu, 13 Feb 2025 10:58:22 -0800
Message-Id: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

On some systems, one PCI device may have muiltple NET devices. This
patchset fixes issues on those systems when such PCI device is doing hot 
add/remove.

Change in v2: added cover letter, drop the 4th patch that will be implemented in EAL instead for device args caching

Long Li (3):
  net/netvsc: scan all net devices under the PCI device
  net/netvsc: remove RTE device if all its net devices are removed
  net/netvsc: log error on failure to switch data path

 drivers/net/netvsc/hn_ethdev.c | 29 ++++++++++++-----------------
 drivers/net/netvsc/hn_vf.c     | 18 +++++++++++++++---
 2 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.34.1

