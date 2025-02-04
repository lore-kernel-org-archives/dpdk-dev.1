Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E7C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 01:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 517BC40289;
	Tue,  4 Feb 2025 02:23:57 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DDB9C4003C;
 Tue,  4 Feb 2025 02:23:55 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E5A8420BCAF2; Mon,  3 Feb 2025 17:23:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5A8420BCAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738632234;
 bh=sWOpls/sr+uYz7ZR++7Tnj2i7h/RsCeESv0DuJ9iUiE=;
 h=From:To:Cc:Subject:Date:From;
 b=m9POEtawP9vX7KxsxEPqTW6FuAY8u/UqqP64e2MRFxe74tBzqwdLTlvH31xsGXeqL
 gv32rA/csJ5LmfTaDpkhHzPuYs5E8hfs7f8ChIoKN7Kbac9t6abAB0/LQd2m9l359v
 TDMRRdv8tWVoOeeG8sBlb3BySnuVrzYEaMBRJFjQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Olivier Matz <olivier.matz@6wind.com>, Gage Eads <gage.eads@intel.com>
Cc: dev@dpdk.org, Andre Muezerie <andremue@linux.microsoft.com>,
 stable@dpdk.org
Subject: [PATCH] stack: occasional crash due to uninitialized variable
Date: Mon,  3 Feb 2025 17:23:37 -0800
Message-Id: <1738632218-5796-1-git-send-email-andremue@linux.microsoft.com>
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

Variable "success" was not being initialized and there was a code
path where the last do/while loop in __rte_stack_lf_pop_elems
looked at the value of this variable before it was set to any.

Compiling with msvc resulted in stack_lf_autotest sometimes crashing.

The fix is to initialize the variable. This same fix was applied to
stack\rte_stack_lf_generic.h in the past but was missed here.

Fixes: 7e6e609939a8 ("stack: add C11 atomic implementation")
Cc: stable@dpdk.org

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/stack/rte_stack_lf_c11.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
index 60d46e963b..ee1c79c095 100644
--- a/lib/stack/rte_stack_lf_c11.h
+++ b/lib/stack/rte_stack_lf_c11.h
@@ -77,7 +77,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 {
 	struct rte_stack_lf_head old_head;
 	uint64_t len;
-	int success;
+	int success = 0;
 
 	/* Reserve num elements, if available */
 	len = rte_atomic_load_explicit(&list->len, rte_memory_order_relaxed);
-- 
2.47.2.vfs.0.1

