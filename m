Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF1CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9A040647;
	Fri, 16 Oct 2026 15:06:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D245C4060A
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792155980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1GDQ4jIEqfjBC3l4/nMYUL+U51CXetNEjQ7TWpA87g=;
 b=BXbUbQF7duUhuGGXuH7kr2XaXe5SoB6+2SwwWOqKS2cvQ82PzLMQyTYFtqnI6Gx25gKp2W
 0a8LeleYSgH7HjE0CBbgg30JWNXb1EDDCCQi7oU4WMuLAaBqzQf5o/kZGeD0MPIZANCLdN
 g8iW60oZZYUoCiqihF8HuPR5QQyvnb0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-jpHet8H4M7G1iofWLDxeDA-1; Fri,
 16 Oct 2026 13:06:19 +0000
X-MC-Unique: jpHet8H4M7G1iofWLDxeDA-1
X-Mimecast-MFC-AGG-ID: jpHet8H4M7G1iofWLDxeDA_1792155978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01BAF18011D6; Fri, 16 Oct 2026 13:06:18 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0735F1800257; Fri, 16 Oct 2026 13:06:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 4/8] devtools: check VMDq capability
Date: Fri, 16 Oct 2026 15:05:50 +0200
Message-ID: <20261016130555.1685102-5-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a-dgJsOO2SJcQfjNXOWviCK6Q1FlR4m_nY2ODgmozk4_1792155978
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Let's check that the code and the documentation are aligned for VMDq
capability.

Note: some driver directory hosts multiple drivers that have multiple
corresponding entry in doc/guides/features/. For this case, only try to
detect a discrepancy if all docs agree.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-doc-vs-code.sh | 46 ++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index c58c239c87..7936f8b69f 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -28,7 +28,7 @@ changed_files()
 
 has_code_change() # <pattern>
 {
-	test -n "$(git log --format='%h' -S"$1" $trusted_commit..)"
+	test -n "$(git log --format='%h' -G"$1" $trusted_commit..)"
 }
 
 has_file_change() # <pattern>
@@ -53,6 +53,43 @@ all_net_drivers()
 	sort
 }
 
+has_doc_feature() # <ini_file> <feature>
+{
+	grep -q "^$2[[:space:]]*=[[:space:]]*[YP]" "$1"
+}
+
+all_docs_agree() # <driver> <feature>
+{
+	first=""
+	for d in "$rootdir/doc/guides/nics/features/${1}"*.ini; do
+		[ -f "$d" ] || return 1
+		has_doc_feature "$d" "$2" && val=true || val=false
+		[ -n "$first" ] || first=$val
+		[ "$first" = "$val" ] || return 1
+	done
+	return 0
+}
+
+check_mq_caps() # <driver>
+{
+	code=$rootdir/drivers/net/$1
+	doc=$rootdir/doc/guides/nics/features/$1.ini
+	[ -d $code ] || return 0
+	[ -f $doc ] || return 0
+
+	if all_docs_agree $1 "VMDq"; then
+		if has_doc_feature "$doc" "VMDq"; then
+			git grep -qE 'max_vmdq_pools[[:space:]]*=' -- "$code" ||
+				error "VMDq documented but max_vmdq_pools not set for $1"
+		else
+			! git grep -qE 'max_vmdq_pools[[:space:]]*=' -- "$code" ||
+				error "max_vmdq_pools set but VMDq not documented for $1"
+			! git grep -qE 'RTE_ETH_MQ_(RX|TX).*VMDQ' -- "$code" ||
+				error "VMDq mq_mode referenced but VMDq not documented for $1"
+		fi
+	fi
+}
+
 check_rte_flow() # <driver>
 {
 	code=$rootdir/drivers/net/$1
@@ -70,6 +107,7 @@ if [ -z "$trusted_commit" ]; then
 	# check all
 	for driver in $(all_net_drivers); do
 		check_rte_flow $driver
+		check_mq_caps $driver
 	done
 	exit $result
 fi
@@ -81,4 +119,10 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
+if has_code_change 'max_vmdq_pools\|RTE_ETH_MQ_.*VMDQ' ||
+		has_file_change 'doc/guides/nics/features'; then
+	for driver in $(changed_net_drivers); do
+		check_mq_caps $driver
+	done
+fi
 exit $result
-- 
2.54.0

