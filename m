Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A3606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dW4QJEG9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5508740695;
	Thu, 22 Oct 2026 19:45:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7189B40695
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHIQFSeB1QRZ1/bTuclhGDDISGlxh7TAm6fVSgUaxyw=;
 b=dW4QJEG9B9KctwLbeLRkQEDX0ecM4iOCLy/qJjFApzITWVl2TXVv3t5WqypBZQ8jp93laO
 apepH5g36NrOjirNlgEB3s5UPhcv4ZZ4PLvn8caC8AOQLv311D0gkvJIsujkd/C1pX8vWE
 ePt1FImaiq1pCNuTKJgzjdcdfucYWhc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-rd_CejJtNCyeab-ym6ldlg-1; Thu,
 22 Oct 2026 13:45:30 -0400
X-MC-Unique: rd_CejJtNCyeab-ym6ldlg-1
X-Mimecast-MFC-AGG-ID: rd_CejJtNCyeab-ym6ldlg_1792691129
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9061800659; Thu, 22 Oct 2026 17:45:28 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A5641954117; Thu, 22 Oct 2026 17:45:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Igor Russkikh <irusskikh@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v3 08/13] devtools: check VMDq capability
Date: Thu, 22 Oct 2026 19:44:35 +0200
Message-ID: <20261022174447.412638-9-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0t0jlIb7JOExa553_yePZX8lD3dkTNiVxZzmxs7nEJQ_1792691129
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let's check that the code and the documentation are aligned for VMDq
capability.

Some driver directory hosts multiple drivers that have multiple
corresponding entry in doc/guides/features/.
For this case, only try to detect a discrepancy if any doc announce a
feature but no code can be found.

Note: net/atlantic and net/cxgbe were forcibly setting some fields in
dev_info to 0, which is unneeded since ethdev already clears the structure.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- inverted logic: 

Changes since v1:
- added helper for checking mq capabilities,
- added handling of multi drivers,
- moved net/atlantic and net/cxgbe cleanups here,

---
 devtools/check-doc-vs-code.sh     | 50 +++++++++++++++++++++++++++++++
 drivers/net/atlantic/atl_ethdev.c |  2 --
 drivers/net/cxgbe/cxgbe_ethdev.c  |  1 -
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 7afc18d153..e84b003a51 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -161,10 +161,54 @@ check_rte_flow() # <driver>
 	fi
 }
 
+has_doc_feature() # <ini_file> <feature>
+{
+	grep -q "^$2[[:space:]]*=[[:space:]]*[YP]" "$1"
+}
+
+# check if any doc for a code directory has a feature
+any_doc_has_feature() # <code_dir> <feature>
+{
+	for drv in $(docs_for_code $1); do
+		d=$rootdir/doc/guides/nics/features/$drv.ini
+		if has_doc_feature "$d" "$2"; then
+			return 0
+		fi
+	done
+	return 1
+}
+
+check_mq_cap() # <driver> <feature> <indicator> <code_pattern> <mq_pattern>
+{
+	if has_doc_feature "$doc" "$2"; then
+		# doc claims feature, code must have it
+		git grep -qE "$4" -- "$code" ||
+			error "$2 documented but $3 not set for $1"
+	elif ! any_doc_has_feature "$code" "$2"; then
+		# check code->doc only if no doc for the code directory has the feature
+		! git grep -qE "$4" -- "$code" ||
+			error "$3 set but $2 not documented for $1"
+		! git grep -qE "$5" -- "$code" ||
+			error "$2 mq_mode referenced but $2 not documented for $1"
+	fi
+}
+
+check_mq_caps() # <driver>
+{
+	code=$(driver_code_dir $1)
+	doc=$rootdir/doc/guides/nics/features/$1.ini
+	[ -d $code ] || return 0
+	[ -f $doc ] || return 0
+
+	check_mq_cap $1 "VMDq" "max_vmdq_pools" 'max_vmdq_pools[[:space:]]*=' \
+		'RTE_ETH_MQ_(RX|TX).*VMDQ'
+}
+
 if [ -z "$trusted_commit" ]; then
 	# check all
 	for driver in $(all_net_drivers); do
 		check_rte_flow $driver
+		check_mq_caps $driver
 	done
 	exit $result
 fi
@@ -176,4 +220,10 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
+if has_code_change 'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ' ||
+		has_file_change 'doc/guides/nics/features'; then
+	for driver in $(changed_net_drivers); do
+		check_mq_caps $driver
+	done
+fi
 exit $result
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 24184bdb18..44a65d7557 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -1106,8 +1106,6 @@ atl_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_vfs = pci_dev->max_vfs;
 
 	dev_info->max_hash_mac_addrs = 0;
-	dev_info->max_vmdq_pools = 0;
-	dev_info->vmdq_queue_num = 0;
 
 	dev_info->rx_offload_capa = ATL_RX_OFFLOADS;
 
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 82e67eeff1..93554f354c 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -129,7 +129,6 @@ int cxgbe_dev_info_get(struct rte_eth_dev *eth_dev,
 	device_info->max_mac_addrs = 1;
 	/* XXX: For now we support one MAC/port */
 	device_info->max_vfs = adapter->params.arch.vfcount;
-	device_info->max_vmdq_pools = 0; /* XXX: For now no support for VMDQ */
 
 	device_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
-- 
2.54.0

