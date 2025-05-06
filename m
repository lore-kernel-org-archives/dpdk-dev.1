Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45436C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AAFF40261;
	Tue,  6 May 2025 19:49:52 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 975EB4025D
 for <dev@dpdk.org>; Tue,  6 May 2025 19:49:51 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQrt4jKvz3Xxg;
 Tue, 06 May 2025 17:49:50 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQrt32J0z42pQ;
 Tue, 06 May 2025 17:49:50 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=59JAfcNRcxkpjiJT40YeK5cC4WJje/gZLCFXpB8g9UA=;
 b=QIkIvtlEHHPez3DWBe7hPShEW6pAQLeUS32y79bjyoRxKfFqycjblv6u1GEMCugwpBwMuF
 QDuLAvGNSqyA3bI/mfbYKIoPQ9j7pVifZ4lokF8xvv5yuZRU/3JXbGoSYwJbcHHpSu8hjh
 cSQZnLa8z/FzN8MKx0ZtRAacOUQn61ixNVNSFv9XKs2mx88wrTVg8OVfkGkUG3IcuVbN8H
 xpBdoPGdVu1n2kiJpU+h9V6AWLICboc//DoUhhbcXdI0aF6bu1uQtEKdedia8Q3IRHBFoU
 kt5XPG779sMfcpRxa56RzzR82SWhH0e4TURA+wxF0Fjl3icmaOw5CtvvcaNH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=59JAfcNRcxkpjiJT40YeK5cC4WJje/gZLCFXpB8g9UA=;
 b=Tlgf0GnRG1xjY2CUgjafL2Ua9vaQSI4ZPkmeLEBPIJUoeAx7WVM90wq8DFE5iwvBzeE33B
 NJJS171RNyqN5OGU6bd8G62KkitlUYLkyq1az1vHsK4zLYTHMQytc7DOQghq4WXncmoB3D
 rncxTjA0p3SxXZjv6Min0vQFv+bDRlwlcYfiyZ490JC8cGeHMVgvz0AfHOWJGQoEJeoZRg
 3mNz/Q32xqEzg7wcei+7nxWJoYmKryyYFWJ0Tj3eVPEOfYUf/lBH2rPREvVJd4wZP5YfPB
 LUunZDbMpRO1+nKyjfXAHD+Z7hmL+Hkvp7RJLDi4ttE1XlwVeh7Q6uqUCnfQNQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553790; a=rsa-sha256; cv=none;
 b=vvh99d/L+4HmO7WbNlMpPHce2+aYOBSCi22VqYyTRn4NQZbenajFeyjzSxyttCcNhDg/MW
 Vu/fdac8cgiojLCxTHEcfz+vgT2imo/7sGOCUI1KP6EwZPtXZWGSA7wNF6qbYcR6Nlitrj
 ksHjtlzUO9fwcLnJFEDlYou/naw8imz0wUWGrr3qtCmpWsmcAvtoMOac+lpphJeRNk9slF
 zvxuQPWp+olstWnsQJiV/PbOKXF1lrFVUmNGlsliCc1+VvQmJCAKQp6Gsuh/sQJd5bAk6W
 s1GNSKyKKE2TATRN5bj4BJZDYEDTp5nb5A8ic/l+bUu+IiRmrLwcv+Pplad4dg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQrt0mxbztvB;
 Tue, 06 May 2025 17:49:50 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH] kernel/freebsd: Allow contigmem allocation in NUMA domains
Date: Tue,  6 May 2025 12:48:38 -0500
Message-ID: <20250506174941.1141140-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
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

Allow the user to specify a list of comma separated NUMA domains in
`hw.contigmem.domains` to allocate memory from. All contigmem will be
allocated in an interleaved fashion across the specified domains using
the DOMAINSET_POLICY_INTERLEAVE policy from domainset(9).

If `hw.contigmem.domains` is unset, memory will be interleaved across
all NUMA domains on the system.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 kernel/freebsd/contigmem/contigmem.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/kernel/freebsd/contigmem/contigmem.c b/kernel/freebsd/contigmem/contigmem.c
index 591e46dded..01234567df 100644
--- a/kernel/freebsd/contigmem/contigmem.c
+++ b/kernel/freebsd/contigmem/contigmem.c
@@ -9,6 +9,8 @@ __FBSDID("$FreeBSD$");
 #include <sys/bio.h>
 #include <sys/bus.h>
 #include <sys/conf.h>
+#include <sys/ctype.h>
+#include <sys/domainset.h>
 #include <sys/kernel.h>
 #include <sys/malloc.h>
 #include <sys/module.h>
@@ -53,6 +55,12 @@ static int              contigmem_num_buffers = RTE_CONTIGMEM_DEFAULT_NUM_BUFS;
 static int64_t          contigmem_buffer_size = RTE_CONTIGMEM_DEFAULT_BUF_SIZE;
 static bool             contigmem_coredump_enable;

+static char		contigmem_domainstr[DOMAINSET_SETSIZE * 2];
+static struct domainset contigmem_domainset = {
+	.ds_policy = DOMAINSET_POLICY_INTERLEAVE,
+	.ds_prefer = -1,
+};
+
 static eventhandler_tag contigmem_eh_tag;
 static struct contigmem_buffer contigmem_buffers[RTE_CONTIGMEM_MAX_NUM_BUFS];
 static struct cdev     *contigmem_cdev = NULL;
@@ -61,6 +69,8 @@ static int              contigmem_refcnt;
 TUNABLE_INT("hw.contigmem.num_buffers", &contigmem_num_buffers);
 TUNABLE_QUAD("hw.contigmem.buffer_size", &contigmem_buffer_size);
 TUNABLE_BOOL("hw.contigmem.coredump_enable", &contigmem_coredump_enable);
+TUNABLE_STR("hw.contigmem.domains", contigmem_domainstr,
+	sizeof(contigmem_domainstr));

 static SYSCTL_NODE(_hw, OID_AUTO, contigmem, CTLFLAG_RD, 0, "contigmem");

@@ -75,6 +85,8 @@ SYSCTL_BOOL(_hw_contigmem, OID_AUTO, coredump_enable, CTLFLAG_RD,

 static SYSCTL_NODE(_hw_contigmem, OID_AUTO, physaddr, CTLFLAG_RD, 0,
 	"physaddr");
+static SYSCTL_NODE(_hw_contigmem, OID_AUTO, domain, CTLFLAG_RD, 0,
+	"domain");

 MALLOC_DEFINE(M_CONTIGMEM, "contigmem", "contigmem(4) allocations");

@@ -114,9 +126,50 @@ static struct cdevsw contigmem_ops = {
 	.d_close        = contigmem_close,
 };

+static void
+contigmem_domains_parse(void)
+{
+	domainid_t did;
+	char *dstr;
+
+	int i = 0;
+	char name[12];
+
+	/*
+	 * If hw.contigmem.domains is not set, then evenly
+	 * distribute memory across all domains.
+	 */
+	if (*contigmem_domainstr == '\0') {
+		DOMAINSET_COPY(&all_domains, &contigmem_domainset.ds_mask);
+		return;
+	}
+
+	dstr = contigmem_domainstr;
+	while (*dstr != '\0') {
+		if (!isdigit(*dstr)) {
+			++dstr;
+			continue;
+		}
+		did = strtoul(dstr, &dstr, 0);
+		DOMAINSET_SET(did, &contigmem_domainset.ds_mask);
+
+		snprintf(name, sizeof(name), "%d", i++);
+		/* We should be adding ds_mask as a bitset. */
+		SYSCTL_ADD_INT(NULL,
+			&SYSCTL_NODE_CHILDREN(_hw_contigmem, domain), OID_AUTO,
+			name, CTLTYPE_INT | CTLFLAG_RD, SYSCTL_NULL_INT_PTR,
+			did, "Contiguous memory NUMA domain");
+	}
+	SYSCTL_ADD_INT(NULL,
+		&SYSCTL_NODE_CHILDREN(_hw, contigmem), OID_AUTO,
+		"num_domains", CTLTYPE_INT | CTLFLAG_RD, SYSCTL_NULL_INT_PTR,
+		i, "Number of contiguous memory NUMA domains");
+}
+
 static int
 contigmem_load(void)
 {
+	struct domainset *ds;
 	char index_string[8], description[32];
 	int  i, error = 0;
 	void *addr;
@@ -136,9 +189,18 @@ contigmem_load(void)
 		goto error;
 	}

+	contigmem_domains_parse();
+	ds = domainset_create(&contigmem_domainset);
+	if (ds == NULL) {
+		printf("invalid domain string: %s\n", contigmem_domainstr);
+		error = EINVAL;
+		goto error;
+	}
+
 	for (i = 0; i < contigmem_num_buffers; i++) {
-		addr = contigmalloc(contigmem_buffer_size, M_CONTIGMEM, M_ZERO,
-			0, BUS_SPACE_MAXADDR, contigmem_buffer_size, 0);
+		addr = contigmalloc_domainset(contigmem_buffer_size,
+			M_CONTIGMEM, ds, M_ZERO, 0, BUS_SPACE_MAXADDR,
+			contigmem_buffer_size, 0);
 		if (addr == NULL) {
 			printf("contigmalloc failed for buffer %d\n", i);
 			error = ENOMEM;
--
2.47.2

