Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514EED3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2889940DD3;
	Tue,  9 Dec 2025 12:27:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 81F4D40B9D;
 Tue,  9 Dec 2025 12:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279637; x=1796815637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=en3ll4bI+kvVKp1BPlZQIgBp46nxouT3XPqg4D2+n+I=;
 b=SlqRK4sIPD8umGbA9v5OFhCHfMaPoOP5shfNaMPInBIo17aV7Ypgc3RW
 CRGZIYLLi9Db1NOG6iHjBJdX/wRi85MG8zT2paXanQ1NdBdwCf4OvSMdt
 5T+fdPmPAd4kQs0mCdb5u3FuSvPbaqZndQRQPRq9Qws6Cg45ASSBfcqQA
 ad7R1Kr9/Cz0EABJWlJ14SGEnbo29IuEUw5I27zCRGU0VWCIx1BH6Bz/k
 m0xiZLUbfDrOlzaDmq/vpq4ud2kECY8qHHpwfFB5Q3P6DhwlH+8t/rV1O
 IXJo2xl3CB0Bx534uJgHrLdoMNO0x/5cST9kl2fa6jvSLgc3OKp1Hw9R+ w==;
X-CSE-ConnectionGUID: 4CZFgAzyQ2uJOkZ1Cy4JWw==
X-CSE-MsgGUID: Z7SVO/QWQFOzCbmaj7FzIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117049"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117049"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:16 -0800
X-CSE-ConnectionGUID: xFv03YzNQamYwibSo1HbIw==
X-CSE-MsgGUID: HAok4YBdThCBXHPM0eLEqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270236"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:15 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 10/13] docs: fix TSO and checksum offload feature status in
 ice doc
Date: Tue,  9 Dec 2025 11:26:49 +0000
Message-ID: <20251209112652.963981-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change its status to
partially supported. L3 and L4 checksum offload are enabled on scalar
and vector paths so change their statuses from partial to supported.

Fixes: f88de4694d94 ("net/ice: support Tx SSE vector")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/ice.ini | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index e9796c1eab..893d09e9ec 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -21,7 +21,7 @@ Power mgmt address monitor = Y
 MTU update           = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 DCB                  = Y
@@ -34,8 +34,8 @@ Traffic manager      = Y
 CRC offload          = Y
 VLAN offload         = Y
 QinQ offload         = P
-L3 checksum offload  = P
-L4 checksum offload  = P
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Timestamp offload    = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
-- 
2.43.0

