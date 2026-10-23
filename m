Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875E606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=GWCaRJCk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46CE3402D8;
	Fri, 23 Oct 2026 08:05:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B07AB40268;
 Fri, 23 Oct 2026 08:05:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1F4oP2235127; Thu, 22 Oct 2026 23:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=jhlgWAyWgvvHVQqbmTm5NrI
 Lh6wxpIwTQk0ve6wFPZc=; b=GWCaRJCka/sj1tFWzEon40hDpLcj62Ko0Xbj3yn
 UMVJc3DtttPCfZwgRx2fz3CubqXLsgtSRbWSYuuq+BIMwFwcERosv+7cF7S84TEt
 C+huotHzxobbVFy20RjEwwIHXFS12kW95Kzy/Ody8aCZCv3lcHUKLOntw8d8K/oE
 d0Rsk/eMoVKR/KUjSLbWIbmpNSgug2vBuSDDR+qXj6dSl2rL1DO4b++yvs4zKl26
 51NVjS50apo5xayLosbwTdbUoNnZadmun1OWGUZHYYe9ViDLGBwl/VEH0JxR7gxS
 KvARmp4e9we9HUbIsqC8DgBM4kIpgP+lg/LN6TcAxvYTytg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hf94b8b1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 23:05:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Oct 2026 23:05:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Oct 2026 23:05:38 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 27A1E3F709F;
 Thu, 22 Oct 2026 23:05:35 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] mem: fix fbarray placement colliding with PCI BARs
Date: Fri, 23 Oct 2026 11:35:23 +0530
Message-ID: <20261023060523.978899-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NHBv2zxWqhXf23PILK6ZosprevWD1Fxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyMyBTYWx0ZWRfX5wQ/wxLt2F9o
 kZs0uOsEU5kO60pAFxH8lBksolWtf+WWAvHPHgtAOBElV5wbupTcC7XLmVB3cYWkHTMExr1/uOo
 kYqFsBa0dOqqIVvS7rMxFT/hidFe4Cs+VjhXJZZdsz0ViEeUqt2A2/nBc6GXMDk5a+udaiSgm1p
 vBhWnAo10LSQLEHcStc/xuwzQyRhMlfFsjZyY1pQfD8C5ZiYtkMROV2uEO54pCBZU5N9VAJ4T9Z
 XeihI1LRZUTC/v8tomES/zuUjyoFI25gUyL6wXA1V4KIk1drrXi7C29qkgOUl6IszfMpzJGh088
 S0fYjKmIL6mvyAYzkpAVmf8+APnuvgT4P6bMDlAyltqgCOOdP0XuvG7NGPqGWFvSeMhDUoTk7eb
 etDMXzZMqH359pHF8Ry5SM84X/nQ+/3RDpYgZCwlZGQxZ/hUlv/RlAMYxVJa5AII3Tz8hHPMrl+
 5Kl0Qksc4hZQHHKRyPA==
X-Proofpoint-ORIG-GUID: NHBv2zxWqhXf23PILK6ZosprevWD1Fxi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyMyBTYWx0ZWRfX8zxzH5CLEKlO
 cJB5Tc7/Csw4FcRWfg/gokp8ZKhjM3ZDVeInEXGOTufF53GeH2PEeXMBriV5YHC2gFDiAeJA+SG
 p6xu5svkPMioETNqahtFCG5kL0MVkJ0=
X-Authority-Analysis: v=2.4 cv=OrDaWC/t c=1 sm=1 tr=0 ts=6adaf933 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=0MzUoWtyLn_NhArxV_UA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the VA space of all memseg lists is reserved in one go, it is
reserved before the memseg lists are created. The fbarray of each list
is allocated from the same VA allocator, so the first fbarray now ends
up right after the end of the memseg lists.

On Linux, the PCI bus maps device BARs in the primary process starting
at the end of the memseg lists (pci_find_max_end_va()), using it as an
address hint. This address is now taken by the fbarray, so the hint is
not honored and the kernel places the first BAR elsewhere in the mmap
area, among the shared libraries and thread stacks.

With VFIO, secondary processes map BARs at the addresses chosen by the
primary process, using MAP_FIXED, which replaces any existing mapping.
As the mmap area layout is randomized for each process (ASLR), the BAR
can overlap the secondary process' own libraries or stacks, which are
then replaced. This intermittently crashes secondary processes during
EAL init, for example dpdk-proc-info. On arm64 with 64K pages, this
was seen in about one in ten secondary process starts.

Create the memseg lists before reserving the VA space, so that, as
before that change, nothing is mapped right after the memseg lists and
the BARs can be placed there again. The VA space is still reserved in
one go.

Also destroy the memseg lists created so far if a later step fails,
since their fbarrays now exist before the VA space is reserved.

Fixes: 3368bc8600e8 ("mem: allocate all VA space in one go")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 lib/eal/common/eal_common_dynmem.c | 46 +++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 868d274dc0..800f1c63c6 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -29,7 +29,7 @@ eal_dynmem_memseg_lists_init(void)
 		size_t mem_sz;
 		size_t va_offset;
 	} memtypes[RTE_MAX_MEMSEG_LISTS] = {0};
-	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
+	int i, hpi_idx, msl_idx, n_msl = 0, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
 	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
@@ -132,6 +132,31 @@ eal_dynmem_memseg_lists_init(void)
 		goto out;
 	}
 
+	/*
+	 * Create the segment lists (and their fbarrays) before reserving the
+	 * VA space, so that nothing is mapped right after the VA space. PCI
+	 * BAR mapping uses the end of the VA space as its address hint.
+	 */
+	msl_idx = 0;
+	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
+		struct memtype *type = &memtypes[cur_type];
+
+		/* skip page sizes with zero memory limit */
+		if (type->n_segs == 0)
+			continue;
+
+		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
+			type->n_segs, type->socket_id, type->page_sz);
+
+		msl = &mcfg->memsegs[msl_idx];
+
+		if (eal_memseg_list_init(msl, type->page_sz, type->n_segs,
+				type->socket_id, msl_idx, true))
+			goto out;
+		msl_idx++;
+		n_msl = msl_idx;
+	}
+
 	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
 			mem_va_page_sz, 0, 0);
 	if (mem_va_addr == NULL) {
@@ -139,28 +164,17 @@ eal_dynmem_memseg_lists_init(void)
 		goto out;
 	}
 
-	/* go through all mem types and create segment lists */
+	/* go through all mem types and assign VA space to segment lists */
 	msl_idx = 0;
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
 		struct memtype *type = &memtypes[cur_type];
-		uint64_t pagesz;
-		int socket_id;
 
 		/* skip page sizes with zero memory limit */
 		if (type->n_segs == 0)
 			continue;
 
-		pagesz = type->page_sz;
-		socket_id = type->socket_id;
-
-		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
-			type->n_segs, socket_id, pagesz);
-
 		msl = &mcfg->memsegs[msl_idx];
 
-		if (eal_memseg_list_init(msl, pagesz, type->n_segs, socket_id, msl_idx, true))
-			goto out;
-
 		if (eal_memseg_list_assign(msl,
 				RTE_PTR_ADD(mem_va_addr, type->va_offset))) {
 			EAL_LOG(ERR, "Cannot assign VA space for memseg list");
@@ -172,6 +186,12 @@ eal_dynmem_memseg_lists_init(void)
 	ret = 0;
 out:
 	if (ret != 0) {
+		/* destroy the segment lists created so far */
+		for (i = 0; i < n_msl; i++) {
+			msl = &mcfg->memsegs[i];
+			rte_fbarray_destroy(&msl->memseg_arr);
+			memset(msl, 0, sizeof(*msl));
+		}
 		if (mem_va_addr != NULL)
 			eal_mem_free(mem_va_addr, mem_va_len);
 	} else {
-- 
2.43.0

