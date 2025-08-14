Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C420CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5B844060F;
	Thu, 14 Aug 2025 23:32:59 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1AD43400EF
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:32:56 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c2z475tbtz3TWt;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c2z473C4yz49q8;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755207175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6SNZ/I3BnryEPtvFKCyvuhFsyNOw3QQLj9QRUfzWQg=;
 b=yg4NeTlmnIhgC84+k+fgn/tt/Q/20P5Uj/lDzVWQ3jvSI28gM3I3bYe57mqolyu16TbeNr
 3TGTLnNzPj7tj31m/p0r0vktTju+7z4S59E9jYiQ3vHkWvX2s6FwDXLFBlnPj6l0iWL9pC
 u3V7C9sSh6vUvc13KvatqWNscIKFlDg/s5TOnHkbJpuM8dnBqAQrFf4CSjfEY346s/fcgn
 PwSb9VptMlxYHAOtJLi9P+WDFcek84nmrpTiSXpWlNhhF35m1Xso3mgCcnbWMYJejx+rjh
 s7tSpa9XzOXMh4yhWDF7Q7sRnnxuiyGS62ulLlriJWBLZPG0+j3Z1AXvj96VMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755207175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6SNZ/I3BnryEPtvFKCyvuhFsyNOw3QQLj9QRUfzWQg=;
 b=kpTynDsAsPsjIJppgaRk40ful3jg9GoeWk8pqkt5seoMsKvoT0O9XJwRF9QuEt6SLnTxlH
 G26WVtCutB0ct9rqZp81hcU6I7N2AFJZLt5BPWAD/VJgQlXN9cZf9PN8AKI6i7VQybQTlo
 C4bItCQza/kRPdeWkgiO2zd7h0QF0UHULqeSRDaKqwitNKFAeOcERoMqd31XXol1GMEqgu
 aLVcBAC9KjSLR7vZguuirIpYmJwcv0GRZzxxc19JHc1YfvwHFiDJAmCg4lfzCopF6Ngzg4
 kwEVWRM/aGzaB3o7Y5USKvtKesxqzBujK/VSmZro2rUUVZCURQ+OONjk/z0vEA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755207175; a=rsa-sha256; cv=none;
 b=vyYBlAVzU+fD7fsRYi368NkS1owJJHhDlQY0Tby64RI1bev06LxXqqEbgkeKvewEVHnmRR
 fNV7+jiuKtHcHrnOrPEV31vHerdnQRu1PGbdECsGvwsAODZpjsEzQbG9UTd+nljJpkQ5CO
 tFDtoJcU05hqwo19A3xT98S+NBqvc7VAHKLBU5DVU7bLhKPax7GLXJ2R69G+tkvbmzTSiM
 mEhDozQ+zmJ3USa5EHnfgjLa/ykmGRB53SvFxZ7t0qmuot5cPa0J8/CNJwO75feBF0pWv8
 0l3bUbR7YjqnGro1CEY4txfvZfNvZ6ZsxLN76xSmAkGF9heHzCTEWtOa8qbY3A==
Received: from s1.pct.niksun.com (70-59-118-59.mpls.qwest.net [70.59.118.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c2z4711jWzQnq;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v2 3/3] eal/linux: Check hugepage access permissions
Date: Thu, 14 Aug 2025 16:32:45 -0500
Message-ID: <20250814213246.4141803-4-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

Currently, hugepage mountpoints will be used irrespective of permissions,
leading to potential EACCES errors during memory allocation. Fix this by
not using a mountpoint if we do not have read/write permissions on it.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/linux/eal_hugepage_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..e2ddd6218b 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -260,6 +260,13 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 				continue;
 		}
 
+		if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
+			EAL_LOG(NOTICE,
+				"Skipping hugepage dir '%s': missing r/w perms",
+				splitstr[MOUNTPT]);
+			continue;
+		}
+
 		/*
 		 * If no --huge-dir option has been given, we're done.
 		 */
-- 
2.47.2

