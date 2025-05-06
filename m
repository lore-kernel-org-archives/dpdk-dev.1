Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422AC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA01E40652;
	Tue,  6 May 2025 19:50:19 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 066A24025D
 for <dev@dpdk.org>; Tue,  6 May 2025 19:50:17 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQsN5DBZz3Y5V;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQsN4M4wz432r;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzvU+ies2fsQ6mxqSYtfsJAVEligpAeSYA68sbedHzI=;
 b=XzSL4F+T0CtHjfpBh64aEZx8qI5uZEA30S3Gcp9jk/2zt3IGO6V3fTGhRA8if94eT3JZza
 NdNquXJB76Iy3gzgRKZ3XOKjCVXGSjM2xzWkEAuG/Vb2uglhH+xeupkPfl6XOwy2tpb8/g
 qkq7vkbsCuwdCwKsvs1oFATYOrJ6ivxKF4h5RJ2N4imoVSHyMBVQoX42gRMms7CTHn8CGg
 +/TtC9hHtlxV5H2AXqTWxssf0XSajCQYUtdslJqb8K4dYbOgbrFG1xCganovZRT4dWFK/k
 /HaD/N73XL9UwnYzObwCXzdpE/RYZ5aQC4YYx6xnzfryQ7f7pIzLTBPJp7pXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzvU+ies2fsQ6mxqSYtfsJAVEligpAeSYA68sbedHzI=;
 b=tbrWmhzPIHMuccYuXJbscdvcwq2S/05lMOCJHvatFwPpG+HAjRSQUiEZbzGmMgqt6RTE+t
 h7ykIp8fGtkRK2PtZLe6b4s3PszbRWcg1S4sJnG7Q8XFSIA5w5hkk8mfiDJ8H5OIq6CIDe
 mLg2MqTaKpGrSnOSeEJJZrnaVDUBsEJJ5xUvXxticQZMYr8XIEoQbkAqqZeg0tqEdGqJtC
 yUhd8t4lQuByUgTcQSFSuT/Ia68CA0M1VQZlolodmHuaQOY36LkfctuFRy/KTRBCfiVXaa
 cJpqE9VDkPyVs9YtDUzId6QhWUfzao+o/aygeLUevPCFDxGmEhJ4TL5UmIMG3Q==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553816; a=rsa-sha256; cv=none;
 b=iIKfKgG7pl6VJvdr/xnb9U5vVU+PFX1s7BeXphU7SfPBjpY0ANBLOtiTtJsZdhucjiOZTC
 iStP5iOT+1ilSwRztOZRCoo510DjrVv4qOnm0sccu3UbW8aOLDEKdRX9iJk3C5VbU0jJpV
 WeqqLRvgkfcBtuHDTi6K39vluKJbZ9F1eZ9r4wxpebSdvd7PViR5yfDGJOt9RNMDJqrKyy
 9fVn2IMQi1qddrO1Ii97HewXkxQq8Jp71BzbQ/3wd7645kaMyFo1f6ZcWgXpjvndoaVF2k
 rbCcbE79FjI+i3+zHYs/DPFjZjkljwe1kTqTKq1mDARtXtKZNbuxaO4gBV44Qw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQsN2M11zvmw;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 2/3] eal/freebsd: Do not index out of bounds in memseg list
Date: Tue,  6 May 2025 12:50:08 -0500
Message-ID: <20250506175010.1141585-3-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506175010.1141585-1-jfree@FreeBSD.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
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

It is possible for rte_fbarray_find_next_n_free() to misreport that there
are n contiguous open spots. If we need two contiguous entries for a
hole, make sure that we're not indexing out-of-bounds in the fbarray.

The `arr->len - arr->count < n` condition in fbarray_find_n() is meant to
safeguard against this, but we are not updating arr->count when inserting
holes, so an undesired index may be returned.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/freebsd/eal_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index bcf5a6f986..bdbac0c3f3 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -171,6 +171,9 @@ rte_eal_hugepage_init(void)
 				    rte_fbarray_is_used(arr, ms_idx - 1))
 					ms_idx++;
 
+				if (ms_idx == (int)arr->len)
+					continue;
+
 				break;
 			}
 			if (msl_idx == RTE_MAX_MEMSEG_LISTS) {
-- 
2.47.2

