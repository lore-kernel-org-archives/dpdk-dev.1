Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52787CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CDAD406BA;
	Tue, 19 May 2026 18:08:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A201040667
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206923; x=1810742923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5brJxq3eVcS+77fvglFdUAbrkltyjgjOOG2+xiXNMb4=;
 b=Wa30Y5Jx1wUZXgJimzjEgKkpRzeBpZnoH9nUUFOYIzodjU2E0ayl115P
 bqWkoQcJ0kF8bSjn5/8xsubS0+eGKdjXbRcOj7kSexqFHHBtP+An7/Y4M
 WJGQqmdfOrZX4MlSytixl7zdt1+1cDtCC0qoePwNkHCrdHIOERzCnNe9y
 mdS4WrRJDOaEk8dN7jYdI0Q9LUOktn0t9dF6AbH+HpDalaTd/t/Pw5G7B
 ybNFBHY/66vYQc+NVKxseCiC2M7cNFIvc7Nu+6grSrqu0Dr+ABrCy83EN
 ZxBF5CyVedTnWbQBfAEGkFYFCp+1RDkaAmKEdGVf0iJZWOBZgIvMySsYg w==;
X-CSE-ConnectionGUID: OEig9wMeT+Sn2CI4YV+lYw==
X-CSE-MsgGUID: 4qBqF5uERZuv6SSwNHKkmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070067"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:43 -0700
X-CSE-ConnectionGUID: bNZ2JUD5Qaa2gkRWtPVx1g==
X-CSE-MsgGUID: L2Tu9ICOR+K8TgaFKw6Xgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784795"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 7/8] net/cpfl: replace use of DPDK-specific memcpy function
Date: Tue, 19 May 2026 16:06:04 +0000
Message-ID: <20260519160823.1004973-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, and so is fine using
the standard libc memcpy function in place of the DPDK-specific
rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 4 ++--
 drivers/net/intel/cpfl/cpfl_vchnl.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 617b823f5a..552d1feb27 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2112,7 +2112,7 @@ int vcpf_save_chunk_in_cfgq(struct cpfl_adapter_ext *adapter)
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for add_q");
 		return -ENOMEM;
 	}
-	rte_memcpy(adapter->cfgq_in.cfgq_add, add_q, struct_size);
+	memcpy(adapter->cfgq_in.cfgq_add, add_q, struct_size);
 
 	num_chunks = add_q->chunks.num_chunks;
 	for (u16 i = 0; i < num_chunks; i++) {
@@ -2536,7 +2536,7 @@ cpfl_adapter_ext_init(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *a
 
 	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
 
-	rte_memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
+	memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
 
 	ret = idpf_adapter_init(base);
 	if (ret != 0) {
diff --git a/drivers/net/intel/cpfl/cpfl_vchnl.c b/drivers/net/intel/cpfl/cpfl_vchnl.c
index 9c842b60df..c9d122d2c3 100644
--- a/drivers/net/intel/cpfl/cpfl_vchnl.c
+++ b/drivers/net/intel/cpfl/cpfl_vchnl.c
@@ -32,7 +32,7 @@ cpfl_cc_vport_list_get(struct cpfl_adapter_ext *adapter,
 		return err;
 	}
 
-	rte_memcpy(response, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+	memcpy(response, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
 
 	return 0;
 }
@@ -66,7 +66,7 @@ cpfl_cc_vport_info_get(struct cpfl_adapter_ext *adapter,
 		return err;
 	}
 
-	rte_memcpy(response, args.out_buffer, sizeof(*response));
+	memcpy(response, args.out_buffer, sizeof(*response));
 
 	return 0;
 }
@@ -139,7 +139,7 @@ vcpf_add_queues(struct cpfl_adapter_ext *adapter)
 		return err;
 	}
 
-	rte_memcpy(adapter->addq_recv_info, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+	memcpy(adapter->addq_recv_info, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
 
 	return err;
 }
-- 
2.51.0

