Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF0FC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4846B40DDC;
	Tue, 15 Sep 2026 15:02:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B54AE406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:02:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789477371; x=1821013371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uVXryzq1lMM3ail3OWaM8Ruaewbw0z1KL1DLkFrqLvc=;
 b=aOvnjeEC+do36gYBaIwT9ThGEynYnKhneGlKAAEOfyyz5vJw7bbZko3s
 q4dq2T+M5oL1o6lr55vszBfwoWAEllFuhieGviIpqfQf5HfoGTDxLjI+w
 Tk+gwEsMJ+qMUcdKV6+vs7XQA5LbkIzjkMEX/oxoKxpfLISLsQLwCBbil
 BGAprGVYueiGTsX28jAFSHM8VklBmVjbd3UvruHcG9Askwcx1ctuFzJ7x
 yCiuTa3mCt4mTqGM/arHA15U24qLFetKDYlAMzkJo+OV3RRHavsbOjvTt
 NaDfRTxsZ3ocWvHDTZgx9V4pMiJ/dcPnJFpPqlJhcoR2YE/lZdrBzltcT g==;
X-CSE-ConnectionGUID: 6Oldp3LtSoarnwdFQdlSog==
X-CSE-MsgGUID: sd3lN7ZsS/62BG62cXvYwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607585"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:02:50 -0700
X-CSE-ConnectionGUID: 7aQwVlWYTNKVpAWZCtkC2g==
X-CSE-MsgGUID: tOy0mXclQKu+JT6I/2CczA==
X-ExtLoop1: 1
Received: from icx008-fc43.iind.intel.com ([10.190.212.196])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 06:02:48 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: anurag.mandal@intel.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] net/iavf: support reading PHC time
Date: Tue, 15 Sep 2026 18:32:20 +0530
Message-ID: <20260915130220.1535861-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902055401.36342-1-anurag.mandal@intel.com>
References: <20260902055401.36342-1-anurag.mandal@intel.com>
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

The new iavf_timesync_read_time() callback converts every error returned by
iavf_phc_get_time() to -EIO. The underlying AdminQ path can return more
specific errors, including -ENOTSUP and -EINVAL, so this prevents callers
from distinguishing an unsupported operation from an actual I/O failure.

Could the original error be propagated instead?

    ret = iavf_phc_get_time(adapter, &time);
    if (ret != 0)
        return ret;
