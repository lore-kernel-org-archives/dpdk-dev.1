Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BBCF3185
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 10:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443F3402C3;
	Wed, 19 Nov 2025 11:35:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B677D40262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 11:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763548542; x=1795084542;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Fl9VMwE7JJ2UoKvugj+28maXo/JLxtvQyWyYm3mo7Tk=;
 b=XrzUmST9bhVdf+WC1yMlqIGJF+IuyFaxdwQk4ruNdqsNkdowKaRiT+Dv
 E+cX8gIbmTQ7GrDfTIHtF2jmN+Is4j0ZpN6Y8cwOkhUrYb94v9h64t1+5
 UGK6UoqqizoiJQm5oyNZwTbHvZHlPNYlxg8ES9M76I7WTcmjzrU4mp2cv
 HLOuQzqqXAqcs1ZVzazjz2/exUb0GQYeKTYli8uNWGMg2v47GFCWFZ1l6
 QwT809ZFgNb+fZ8g0YMSaUm1Ia855gKlz+3ukdd4gd+LuII864TIsIbpq
 OObtw4h/7TmzsqWghajCNHmqHgYJTQkVoQaxU+58C9YVierp3REN96L8i g==;
X-CSE-ConnectionGUID: 3KASg238SQidZ+RCCM4XAg==
X-CSE-MsgGUID: BVgkn3pvQ+W9bErmQH/cnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91060575"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="91060575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 02:35:41 -0800
X-CSE-ConnectionGUID: 32UvtoRcRB+BOJoK8XqHbw==
X-CSE-MsgGUID: sgirZnM/SCK7AeJTfxSBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190816840"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 02:35:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/2] Deprecation notices for VFIO
Date: Wed, 19 Nov 2025 10:35:36 +0000
Message-ID: <cover.1763548356.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

There's ongoing work to rework VFIO in DPDK [1]. These deprecation
notices originally were part of that patchset, but were split off
to easy review and acceptance.

[1] https://patches.dpdk.org/project/dpdk/list/?series=36746

Anatoly Burakov (2):
  doc: add deprecation notice for VFIO API
  doc: add deprecation notice for vDPA driver API

 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.47.3

