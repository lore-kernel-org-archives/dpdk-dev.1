Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18F606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ex4o4RhE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FA8240B98;
	Wed, 21 Oct 2026 12:31:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03A3340B92
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxNNdyU6cE+JhBrE6VW457J1EL4lFqNtGPFmNgCS87Q=;
 b=ex4o4RhE1Vi6rVP7nZbjJT+tjQDSnvock7gQlpk4wopDJO7+kIp7Jv9jGDyz/LdV0Oxm4u
 YsupfT0z+snly/paj6++nf7eGZUlv6ctODi3I5X40X4WPBYZ1UcAgDnC75VNc0rdfiny9u
 NBdUhEc6S65pu7h5eH2QmU8DGYSWZD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-bZJoFF8iMKmG2eKoFgy_Mw-1; Wed,
 21 Oct 2026 06:31:02 -0400
X-MC-Unique: bZJoFF8iMKmG2eKoFgy_Mw-1
X-Mimecast-MFC-AGG-ID: bZJoFF8iMKmG2eKoFgy_Mw_1792578661
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20EE61800749; Wed, 21 Oct 2026 10:31:01 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1F6C41B; Wed, 21 Oct 2026 10:30:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Igor Russkikh <irusskikh@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v2 07/12] devtools: check VMDq capability
Date: Wed, 21 Oct 2026 12:30:21 +0200
Message-ID: <20261021103027.2050351-8-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zMC9gGh-8U4TeGHfxW8Z5fBftOjgkxmE_BCEq1r4uHE_1792578661
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let's check that the code and the documentation are aligned for VMDq
capability.

Some driver directory hosts multiple drivers that have multiple
corresponding entry in doc/guides/features/. For this case, only try to
detect a discrepancy if all docs agree.

Note: net/atlantic and net/cxgbe were forcibly setting some fields in
dev_info to 0, which is unneeded since ethdev already clears the structure.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- added helper for checking mq capabilities,
- added handling of multi drivers,
- moved net/atlantic and net/cxgbe cleanups here,

---
 devtools/check-doc-vs-code.sh     | 73 +++++++++++++++++++++++++++++++
 drivers/net/atlantic/atl_ethdev.c |  2 -
 drivers/net/cxgbe/cxgbe_ethdev.c  |  1 -
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 4dacb78b2e..eeb235ae61 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -78,6 +78,28 @@ driver_code_dir() # <driver>
 	esac
 }
 
+doc_code_map=","
+for d in $rootdir/doc/guides/nics/features/*.ini; do
+	drv=$(basename "$d" .ini)
+	code=$(driver_code_dir $drv)
+	case $doc_code_map in
+	*,$code:*)
+		before=${doc_code_map%,$code:*}
+		after=${doc_code_map#*,$code:}
+		drivers=${after%%,*}
+		rest=${after#*,}
+		doc_code_map="$before,$code:$drivers $drv,$rest" ;;
+	*)
+		doc_code_map="$doc_code_map$code: $drv," ;;
+	esac
+done
+
+docs_for_code() # <code_dir>
+{
+	tmp=${doc_code_map#*,$1:}
+	echo ${tmp%%,*}
+}
+
 # compare doc vs code items:
 # - if driver matches code dir: report differences in both directions
 # - otherwise: only report doc items not in code (shared code directory)
@@ -119,10 +141,55 @@ check_rte_flow() # <driver>
 	fi
 }
 
+has_doc_feature() # <ini_file> <feature>
+{
+	grep -q "^$2[[:space:]]*=[[:space:]]*[YP]" "$1"
+}
+
+all_docs_agree() # <driver> <feature>
+{
+	code=$(driver_code_dir $1)
+	first=""
+	for drv in $(docs_for_code $code); do
+		d=$rootdir/doc/guides/nics/features/$drv.ini
+		has_doc_feature "$d" "$2" && val=true || val=false
+		[ -n "$first" ] || first=$val
+		[ "$first" = "$val" ] || return 1
+	done
+	return 0
+}
+
+check_mq_cap() # <driver> <feature> <indicator> <code_pattern> <mq_pattern>
+{
+	if all_docs_agree "$1" "$2"; then
+		if has_doc_feature "$doc" "$2"; then
+			git grep -qE "$4" -- "$code" ||
+				error "$2 documented but $3 not set for $1"
+		else
+			! git grep -qE "$4" -- "$code" ||
+				error "$3 set but $2 not documented for $1"
+			! git grep -qE "$5" -- "$code" ||
+				error "$2 mq_mode referenced but $2 not documented for $1"
+		fi
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
@@ -134,4 +201,10 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
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

