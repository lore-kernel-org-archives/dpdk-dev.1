Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB569CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 025B94060A;
	Wed, 14 Oct 2026 14:23:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 235C1402E9
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791980612; x=1823516612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZBlQZ+lzg69ZPPwYt87f1br8HMqL0DBlK7G+1+JWBFY=;
 b=CT1ViiCzlTzCFQL9KTtPZI4orszWXHgtXfH2d0Pz/1XhDeCpTu9v1c4z
 ww+ORuj3L0759brQ/n9YdnvqH480GS0Plbmd3LVXlIq29QWr6b5dIu1gM
 vDIO/hvih85/0lYep+YJ+7SEoAX9HX0X+owO2S514B8mlXV5dMyyk2LFP
 /iYBcxz0qfJZ8RY3SO6sRSMTvTIdaomMWg5IdrV6jdIF4rLQpY3ih2dfx
 emej1x5PxXdZAVi2bmyZ969m8mqHyxh7451yjWFhYLIgKFD4kP53WlD50
 XkjhglQgZOsJj7zR3i2btMMb1qZ7z/sdPkXwK/SN9s/CQnjWnWnkWRT6r A==;
X-CSE-ConnectionGUID: ap9LNbjkSv2xlrXY3EyIPg==
X-CSE-MsgGUID: dUpV96xFRTy2Sz3hZ2BMZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="717296"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="717296"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:23:31 -0700
X-CSE-ConnectionGUID: H7XzwhXYSkayI7NfZXwjHg==
X-CSE-MsgGUID: SEVF8cIgTvKrNQw1y7PAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1524773"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2026 05:23:30 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com
Subject: [PATCH 1/3] net/iavf: fix invalid free of queue TC map
Date: Wed, 14 Oct 2026 12:24:16 +0000
Message-ID: <20261014122419.631288-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014122419.631288-1-dawid.wesierski@intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

iavf_hierarchy_commit() allocates the queue TC map with calloc(), and
it frees the previous map with free(old_qtc_map) after a successful
commit. A later change added rte_free(vf->qtc_map) in front of that
free(), because it was written for a tree that still leaked the map.

After the first commit, rte_free() gets a pointer from the libc
heap, and free() then releases the same pointer a second time.
rte_free() reads a malloc_elem header in the bytes in front of the
pointer. It usually logs "Invalid memory" and returns, but the result
depends on the contents of the libc heap.

Remove the rte_free() call. free(old_qtc_map) releases the old map.

Fixes: f6e33f09f766 ("net/iavf: disable runtime queue setup when rate limiting")

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_tm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index fc84bf7e6b..603da09bb5 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -913,7 +913,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* replace the previously committed mapping, if any */
-	rte_free(vf->qtc_map);
 	vf->qtc_map = qtc_map;
 	free(old_qtc_map);
 	if (adapter->stopped == 1)
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

