Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10812CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 162CD40E25;
	Fri, 19 Jun 2026 12:39:15 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8D4B740B9D;
 Fri, 19 Jun 2026 12:39:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 71ED41A022C;
 Fri, 19 Jun 2026 12:39:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B57D1A0243;
 Fri, 19 Jun 2026 12:39:12 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E479180004C;
 Fri, 19 Jun 2026 18:39:10 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v3 05/18] net/dpaa/fmlib: add null check in scheme delete
Date: Fri, 19 Jun 2026 16:08:48 +0530
Message-Id: <20260619103901.2274740-6-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Prashant Gupta <prashant.gupta_3@nxp.com>

Add a null pointer check at the entry of fm_pcd_kg_scheme_delete().
Since p_dev is assigned directly from h_scheme via a cast
(t_device *)h_scheme, checking p_dev == NULL is equivalent to
checking h_scheme == NULL. This matches the defensive pattern used
in all sibling functions in fm_lib.c and returns E_NO_DEVICE on a
null handle.

Fixes: 663ff698e38f ("net/dpaa: support VSP in fmlib")
Cc: stable@dpdk.org

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/net/dpaa/fmlib/fm_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dpaa/fmlib/fm_lib.c b/drivers/net/dpaa/fmlib/fm_lib.c
index b35feba004..65a818372e 100644
--- a/drivers/net/dpaa/fmlib/fm_lib.c
+++ b/drivers/net/dpaa/fmlib/fm_lib.c
@@ -305,6 +305,9 @@ fm_pcd_kg_scheme_delete(t_handle h_scheme)
 
 	_fml_dbg("Calling...");
 
+	if (p_dev == NULL)
+		return E_NO_DEVICE;
+
 	p_pcd_dev =  (t_device *)p_dev->h_user_priv;
 	id.obj = UINT_TO_PTR(p_dev->id);
 
-- 
2.43.0

