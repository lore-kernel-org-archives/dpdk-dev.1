Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77325109C024
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 750CB402CE;
	Wed, 25 Mar 2026 15:34:38 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 995B44028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:34:37 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 24C9B1D0020F;
 Wed, 25 Mar 2026 10:34:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 10:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774449276;
 x=1774535676; bh=kLoqUyloMrJzjNDS9aDnx+BjonJ+oVsnPAAbrCe5/KQ=; b=
 Z/lYbM/6tKPhQclB/Wme6EKFCprZy1NIz/Vd/dsAIjViJAUwv2EBd6s5pK+/R4xa
 2afGQYfBJ/y4Wqw6gvLgbDeSQOmsdln90FLF6FPalof5UEa3Awt7KTqM9Q31nzzo
 5Jb4EwBl8Cjlo2Wh4qjBk7O9mAhYD9bviNN/RPPSAyZUOc8D9adJQShAybQ99Y5I
 8RZgQgVhoZxf7LHHmrFNraRAgNV23XYFDzFXAqLYEIskzHAhBFrxrOaqOiQeBttJ
 XdgK362OZSj6KcpEfMqcPulG8CugLdL9gAfe0P5lHeuGEMH7ANTgnjMD0jETNWiX
 zYf7MJX1fCxrjFbiJbI7QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774449276; x=
 1774535676; bh=kLoqUyloMrJzjNDS9aDnx+BjonJ+oVsnPAAbrCe5/KQ=; b=k
 N0TiaLnp6Z+BYUocJ2WgMwZb0NHTOUjEEXyJBbQbWdQZ0echnnnm4QFKF+Pr90FO
 tfSml4p2CCngu2hFLmijmKIbqSHYN2iTFupplrxHECcXsYSYAEowKHFQ2Y7NIyE3
 hZFFXIxhxiqiaaq4SrEoF7/wVYtkjkrNXdxCv+UxsTG5Vsbh+7t8bvFaMbA9A7os
 6UwpdLN+8EGhX8AbQ94dwgJj8EEDuo+P4F4fR+yxMPy8AVm2emMbDSWwx+siAlgy
 BuwpE59a6Stx7SfAhl9d6qtSqosploixuCzhMjKNDs8IhJ2kLVsxSgKcSI88JZ90
 XFxGwt6HwKpQo0VhFD/tA==
X-ME-Sender: <xms:fPLDaUDQifOC5sPSR577EdefKN2hkFazYRkMhWymsC2zU5uDsx3h6Q>
 <xme:fPLDaS0Ycr_bJ6t1TCaRk88K5oVl8QAZmMs3xRcHNwsTIO2IwfO4nqTZpAd9a-0K9
 4pDGvfZT6gmLVstvNQiDZHVuImtDQhiVEI5Ep2aACVO-axGD4r4Uw>
X-ME-Received: <xmr:fPLDaaXCx2OS2rONVzDlMsUMcOcXWHyEryTGNWADQXjCp2A9p3sZvcUXmcy1Ot1ZUHBU8awbJ9WUHyG0cdMkKsDpQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:fPLDacm9nVPbYWR3ihuRrte6CU1W8InnNxxIOmG_isXGQwVk6A2aqw>
 <xmx:fPLDacBaQcoM0f3ai0ZxPkm0atXHUyDOz8DVVjeH23EzU0yrLe6xIw>
 <xmx:fPLDacdsNiYaNC1rJVCPaMDySIQ4PG6nNO2KjcCPUcvutnKX5aIUpw>
 <xmx:fPLDaXKYIe5EwZkB3qNA1X08tVaIjvVzDTqCARPat3tQwBl3bjP2WA>
 <xmx:fPLDaZicMJT5A4YleW3hfYz5Omtf8PIFsXkZ1uXz2Ts8iJlehYbVlo0I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 10:34:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: namespace pollution
Date: Wed, 25 Mar 2026 15:34:34 +0100
Message-ID: <4702328.jE0xQCEvom@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657C4@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F657C4@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

25/03/2026 13:11, Morten Br=C3=B8rup:
> Still plenty of namespace pollution in #define'd names...

Yes, patches are welcome.
Sometimes we need to maintain compatibility, at least for some time,
like we did in mempool.
Some are OK like likely or vhost features.
Those which are not expected to be used by the applications should be dropp=
ed.


> (And I haven't looked at enum values.)
>=20
> egrep -r --include=3D'rte_*.h' '#define\s+' lib/ | egrep -v '#define\s+(_=
*RTE_|_*rte_|__INCLUDE_RTE)'
>=20
> lib/security/rte_security_driver.h:#define SECURITY_GET_SESS_PRIV(s) \
> lib/security/rte_security_driver.h:#define SECURITY_GET_SESS_PRIV_IOVA(s)=
 \
> lib/graph/rte_graph_feature_arc_worker.h:#define GRAPH_FEATURE_ARC_PTR_IN=
ITIALIZER  ((uintptr_t)UINTPTR_MAX)
> lib/eventdev/rte_event_timer_adapter.h:#define ADAPTER_VALID_OR_ERR_RET(a=
dapter, retval) do {          \
> lib/eventdev/rte_event_timer_adapter.h:#define FUNC_PTR_OR_ERR_RET(func, =
errval) do {                  \
> lib/eventdev/rte_event_timer_adapter.h:#define FUNC_PTR_OR_NULL_RET_WITH_=
ERRNO(func, errval) do {      \
> lib/timer/rte_timer.h:#define MAX_SKIPLIST_DEPTH 10
> lib/ip_frag/rte_ip_frag.h:#define IP_FRAG_DEATH_ROW_LEN         RTE_IP_FR=
AG_DEATH_ROW_LEN
> lib/ip_frag/rte_ip_frag.h:#define IP_FRAG_DEATH_ROW_MBUF_LEN    RTE_IP_FR=
AG_DEATH_ROW_MBUF_LEN
> lib/ip_frag/rte_ip_frag.h:#define ipv6_extension_fragment               r=
te_ipv6_fragment_ext
> lib/member/rte_member_sketch.h:#define NUM_ROW_SCALAR 5
> lib/member/rte_member_sketch.h:#define INTERVAL (1 << 15)
> lib/member/rte_member_heap.h:#define LCHILD(x) (2 * x + 1)
> lib/member/rte_member_heap.h:#define RCHILD(x) (2 * x + 2)
> lib/member/rte_member_heap.h:#define PARENT(x) ((x - 1) / 2)
> lib/member/rte_member_heap.h:#define HASH_BKT_SIZE 16
> lib/member/rte_member_heap.h:#define HASH_HP_MULTI 4
> lib/member/rte_member_heap.h:#define HASH_RESIZE_MULTI 2
> lib/member/rte_member_sketch_avx512.h:#define NUM_ROW_VEC 8
> lib/hash/rte_jhash.h:#define rot(x, k) (((x) << (k)) | ((x) >> (32-(k))))
> lib/hash/rte_jhash.h:#define BIT_SHIFT(x, y, k) (((x) >> (k)) | ((uint64_=
t)(y) << (32-(k))))
> lib/hash/rte_jhash.h:#define BIT_SHIFT(x, y, k) (((uint64_t)(x) << (k)) |=
 ((y) >> (32-(k))))
> lib/hash/rte_jhash.h:#define LOWER8b_MASK rte_le_to_cpu_32(0xff)
> lib/hash/rte_jhash.h:#define LOWER16b_MASK rte_le_to_cpu_32(0xffff)
> lib/hash/rte_jhash.h:#define LOWER24b_MASK rte_le_to_cpu_32(0xffffff)
> lib/hash/rte_crc_sw.h:#define CRC32_UPD(crc, n)                          =
                            \
> lib/hash/rte_hash_crc.h:#define CRC32_SW            (1U << 0)
> lib/hash/rte_hash_crc.h:#define CRC32_SSE42         (1U << 1)
> lib/hash/rte_hash_crc.h:#define CRC32_x64           (1U << 2)
> lib/hash/rte_hash_crc.h:#define CRC32_SSE42_x64     (CRC32_x64|CRC32_SSE4=
2)
> lib/hash/rte_hash_crc.h:#define CRC32_ARM64         (1U << 3)
> lib/hash/rte_cuckoo_hash.h:#define RETURN_IF_TRUE(cond, retval) do { \
> lib/hash/rte_cuckoo_hash.h:#define RETURN_IF_TRUE(cond, retval)
> lib/hash/rte_cuckoo_hash.h:#define NULL_SIGNATURE                       0
> lib/hash/rte_cuckoo_hash.h:#define EMPTY_SLOT                   0
> lib/hash/rte_cuckoo_hash.h:#define KEY_ALIGNMENT                        16
> lib/hash/rte_cuckoo_hash.h:#define LCORE_CACHE_SIZE             64
> lib/table/rte_lru_arm64.h:#define lru_init(bucket)                       =
                       \
> lib/table/rte_lru_arm64.h:#define lru_pos(bucket) f_lru_pos(bucket->lru_l=
ist)
> lib/table/rte_lru_arm64.h:#define lru_update(bucket, mru_val)            =
                       \
> lib/table/rte_table_hash_func_arm64.h:#define _CRC32CX(crc, val)        \
> lib/table/rte_lru_x86.h:#define lru_init(bucket)                         =
                       \
> lib/table/rte_lru_x86.h:#define lru_pos(bucket) (bucket->lru_list & 0xFFF=
=46LLU)
> lib/table/rte_lru_x86.h:#define lru_update(bucket, mru_val)              =
                       \
> lib/table/rte_lru_x86.h:#define lru_init(bucket)                         =
                       \
> lib/table/rte_lru_x86.h:#define lru_pos(bucket) f_lru_pos(bucket->lru_lis=
t)
> lib/table/rte_lru_x86.h:#define lru_update(bucket, mru_val)              =
                       \
> lib/table/rte_lru.h:#define lru_init(bucket)                             =
               \
> lib/table/rte_lru.h:#define lru_pos(bucket) (bucket->lru_list & 0xFFFFLLU)
> lib/table/rte_lru.h:#define lru_update(bucket, mru_val)                  =
               \
> lib/table/rte_lru.h:#define lru_init(bucket)                             =
               \
> lib/table/rte_lru.h:#define lru_pos(bucket) (bucket->lru_list & 0xFFFFLLU)
> lib/table/rte_lru.h:#define lru_update(bucket, mru_val)                  =
               \
> lib/argparse/rte_argparse.h:#define ARGPARSE_ARG_END() { NULL }
> lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_ERR(...) \
> lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_INFO(...) \
> lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_DEBUG(...) \
> lib/cryptodev/rte_cryptodev.h:#define CDEV_PMD_TRACE(...) \
> lib/cryptodev/rte_cryptodev.h:#define CRYPTO_SESS_OPAQUE_DATA_OFF 0
> lib/cfgfile/rte_cfgfile.h:#define CFG_NAME_LEN 64
> lib/cfgfile/rte_cfgfile.h:#define CFG_VALUE_LEN 256
> lib/cfgfile/rte_cfgfile.h:#define CFG_DEFAULT_COMMENT_CHARACTER ';'
> lib/ethdev/rte_eth_ctrl.h:#define UINT64_BIT (CHAR_BIT * sizeof(uint64_t))
> lib/metrics/rte_metrics_telemetry.h:#define json_t void *
> lib/sched/rte_sched_log.h:#define SCHED_LOG(level, ...) \
> lib/pci/rte_pci.h:#define PCI_PRI_FMT "%.4" PRIx32 ":%.2" PRIx8 ":%.2" PR=
Ix8 ".%" PRIx8
> lib/pci/rte_pci.h:#define PCI_PRI_STR_SIZE sizeof("XXXXXXXX:XX:XX.X")
> lib/pci/rte_pci.h:#define PCI_SHORT_PRI_FMT "%.2" PRIx8 ":%.2" PRIx8 ".%"=
 PRIx8
> lib/pci/rte_pci.h:#define PCI_FMT_NVAL 4
> lib/pci/rte_pci.h:#define PCI_RESOURCE_FMT_NVAL 3
> lib/pci/rte_pci.h:#define PCI_MAX_RESOURCE 6
> lib/pci/rte_pci.h:#define PCI_ANY_ID RTE_DEPRECATED(PCI_ANY_ID) RTE_PCI_A=
NY_ID
> lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_SPREAD           RTE_MEMPO=
OL_F_NO_SPREAD
> lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_CACHE_ALIGN      RTE_MEMPO=
OL_F_NO_CACHE_ALIGN
> lib/mempool/rte_mempool.h:#define MEMPOOL_F_SP_PUT              RTE_MEMPO=
OL_F_SP_PUT
> lib/mempool/rte_mempool.h:#define MEMPOOL_F_SC_GET              RTE_MEMPO=
OL_F_SC_GET
> lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_IOVA_CONTIG      RTE_MEMPO=
OL_F_NO_IOVA_CONTIG
> lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE_LEVEL 0
> lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE(...) printf(__VA_A=
RGS__)
> lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE(...)
> lib/pipeline/rte_swx_pipeline_internal.h:#define ntoh64(x) rte_be_to_cpu_=
64(x)
> lib/pipeline/rte_swx_pipeline_internal.h:#define hton64(x) rte_cpu_to_be_=
64(x)
> lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_GET(mask, pos=
) ((mask) & (1LLU << (pos)))
> lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_SET(mask, pos=
) ((mask) | (1LLU << (pos)))
> lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_CLR(mask, pos=
) ((mask) & ~(1LLU << (pos)))
> lib/pipeline/rte_swx_pipeline_internal.h:#define HEADER_VALID(thread, hea=
der_id) \
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_operand_nbo instr_=
operand_hbo
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU(thread, ip, operator=
)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MH(thread, ip, opera=
tor)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM(thread, ip, opera=
tor)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM_FAST(thread, ip, =
operator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH(thread, ip, opera=
tor)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH_FAST(thread, ip, =
operator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MH ALU
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM ALU
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM_FAST ALU
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH ALU
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH_FAST ALU
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_I(thread, ip, operat=
or)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MI ALU_I
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HI(thread, ip, opera=
tor)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HI ALU_I
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV(thread, ip)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_MH(thread, ip)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HM(thread, ip)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HH(thread, ip)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_MH MOV
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HM MOV
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HH MOV
> lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_I(thread, ip)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP(thread, ip, oper=
ator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MH(thread, ip, o=
perator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HM(thread, ip, o=
perator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH(thread, ip, o=
perator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH_FAST(thread, =
ip, operator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MH JMP_CMP
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HM JMP_CMP
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH JMP_CMP
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH_FAST JMP_CMP
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_I(thread, ip, op=
erator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MI JMP_CMP_I
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HI(thread, ip, o=
perator)  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HI JMP_CMP_I
> lib/pipeline/rte_swx_pipeline_internal.h:#define METADATA_READ(thread, of=
fset, n_bits)                                  \
> lib/pipeline/rte_swx_pipeline_internal.h:#define METADATA_WRITE(thread, o=
ffset, n_bits, value)                          \
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_regarray_idx_nbo i=
nstr_regarray_idx_hbo
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_regarray_src_nbo i=
nstr_regarray_src_hbo
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_regarray_dst_nbo_s=
rc_hbo_set instr_regarray_dst_hbo_src_hbo_set
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_meter_idx_nbo inst=
r_meter_idx_hbo
> lib/pipeline/rte_swx_pipeline_internal.h:#define instr_meter_length_nbo i=
nstr_meter_length_hbo
> lib/ring/rte_ring_core.h:#define RING_F_SP_ENQ 0x0001 /**< The default en=
queue is "single-producer". */
> lib/ring/rte_ring_core.h:#define RING_F_SC_DEQ 0x0002 /**< The default de=
queue is "single-consumer". */
> lib/ring/rte_ring_core.h:#define RING_F_EXACT_SZ 0x0004
> lib/ring/rte_ring_core.h:#define RING_F_MP_RTS_ENQ 0x0008 /**< The defaul=
t enqueue is "MP RTS". */
> lib/ring/rte_ring_core.h:#define RING_F_MC_RTS_DEQ 0x0010 /**< The defaul=
t dequeue is "MC RTS". */
> lib/ring/rte_ring_core.h:#define RING_F_MP_HTS_ENQ 0x0020 /**< The defaul=
t enqueue is "MP HTS". */
> lib/ring/rte_ring_core.h:#define RING_F_MC_HTS_DEQ 0x0040 /**< The defaul=
t dequeue is "MC HTS". */
> lib/efd/rte_efd_x86.h:#define EFD_LOAD_SI128(val) _mm_load_si128(val)
> lib/efd/rte_efd_x86.h:#define EFD_LOAD_SI128(val) _mm_lddqu_si128(val)
> lib/efd/rte_efd.h:#define EFD_TARGET_GROUP_NUM_RULES (22)
> lib/efd/rte_efd.h:#define EFD_MAX_GROUP_NUM_RULES (28LU)
> lib/efd/rte_efd.h:#define EFD_MIN_BALANCED_NUM_RULES      5
> lib/efd/rte_efd.h:#define EFD_LOOKUPTBL_SHIFT (32 - 4)
> lib/pcapng/rte_pcapng.h:#define DLT_EN10MB 1
> lib/mldev/rte_mldev_core.h:#define ML_DEV_DETACHED (0)
> lib/mldev/rte_mldev_core.h:#define ML_DEV_ATTACHED (1)
> lib/acl/rte_acl_osdep.h:#define DIM(x) RTE_DIM(x)
> lib/eal/loongarch/include/rte_vect.h:#define XMM_SIZE        (sizeof(xmm_=
t))
> lib/eal/loongarch/include/rte_vect.h:#define XMM_MASK        (XMM_SIZE - =
1)
> lib/eal/arm/include/rte_atomic_64.h:#define __ATOMIC128_CAS_OP(cas_op_nam=
e, op_string)                          \
> lib/eal/arm/include/rte_atomic_64.h:#define __ATOMIC128_CAS_OP(cas_op_nam=
e, op_string)                          \
> lib/eal/arm/include/rte_atomic_64.h:#define __HAS_ACQ(mo) ((mo) !=3D rte_=
memory_order_relaxed && (mo) !=3D rte_memory_order_release)
> lib/eal/arm/include/rte_atomic_64.h:#define __HAS_RLS(mo) ((mo) =3D=3D rt=
e_memory_order_release || (mo) =3D=3D rte_memory_order_acq_rel || \
> lib/eal/arm/include/rte_atomic_64.h:#define __LOAD_128(op_string, src, ds=
t) { \
> lib/eal/arm/include/rte_atomic_64.h:#define __STORE_128(op_string, dst, s=
rc, ret) { \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_ALIGNED_RTE_MEMCPY(dst, s=
rc, n) \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_ALIGNED_RTE_MEMCPY(dst, s=
rc, n) \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_UNALIGNED_RTE_MEMCPY(dst,=
 src, n) \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_UNALIGNED_RTE_MEMCPY(dst,=
 src, n) \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_RTE_MEMCPY(dst, src, n) \
> lib/eal/arm/include/rte_memcpy_64.h:#define USE_RTE_MEMCPY(dst, src, n) (=
1)
> lib/eal/arm/include/rte_vect.h:#define  XMM_SIZE        (sizeof(xmm_t))
> lib/eal/arm/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
> lib/eal/windows/include/rte_os.h:#define __SIZEOF_LONG__ (sizeof(long))
> lib/eal/windows/include/rte_os.h:#define __SIZEOF_LONG_LONG__ (sizeof(lon=
g long))
> lib/eal/windows/include/rte_windows.h:#define WIN32_LEAN_AND_MEAN
> lib/eal/windows/include/rte_windows.h:#define _m_prefetchw __m_prefetchw
> lib/eal/windows/include/rte_windows.h:#define INITGUID
> lib/eal/windows/include/rte_os_shim.h:#define PATH_MAX _MAX_PATH
> lib/eal/windows/include/rte_os_shim.h:#define strdup(str) _strdup(str)
> lib/eal/windows/include/rte_os_shim.h:#define strtok_r(str, delim, savept=
r) strtok_s(str, delim, saveptr)
> lib/eal/windows/include/rte_os_shim.h:#define strcasecmp(s1, s2) _stricmp=
(s1, s2)
> lib/eal/windows/include/rte_os_shim.h:#define strncasecmp(s1, s2, count) =
_strnicmp(s1, s2, count)
> lib/eal/windows/include/rte_os_shim.h:#define open(...) _open(__VA_ARGS__)
> lib/eal/windows/include/rte_os_shim.h:#define read(fd, buf, n) _read(fd, =
buf, n)
> lib/eal/windows/include/rte_os_shim.h:#define write(fd, buf, n) _write(fd=
, buf, n)
> lib/eal/windows/include/rte_os_shim.h:#define close(fd) _close(fd)
> lib/eal/windows/include/rte_os_shim.h:#define unlink(path) _unlink(path)
> lib/eal/windows/include/rte_os_shim.h:#define fileno(f) _fileno(f)
> lib/eal/windows/include/rte_os_shim.h:#define isatty(fd) _isatty(fd)
> lib/eal/windows/include/rte_os_shim.h:#define IPVERSION 4
> lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_IPIP      4
> lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_GRE       47
> lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_SCTP      132
> lib/eal/windows/include/rte_os_shim.h:#define IPDEFTTL 64
> lib/eal/windows/include/rte_os_shim.h:#define S_ISREG(mode)  (((mode) & S=
_IFMT) =3D=3D S_IFREG)
> lib/eal/windows/include/rte_os_shim.h:#define TIME_UTC 1
> lib/eal/windows/include/rte_os_shim.h:#define timespec_get(ts, base) rte_=
timespec_get(ts, base)
> lib/eal/windows/include/rte_os_shim.h:#define CLOCK_REALTIME             =
     0
> lib/eal/windows/include/rte_os_shim.h:#define CLOCK_MONOTONIC            =
     1
> lib/eal/windows/include/rte_os_shim.h:#define clock_gettime(clock_id, tp)=
 rte_clock_gettime(clock_id, tp)
> lib/eal/windows/include/rte_os_shim.h:#define localtime_r(timep, result) =
rte_localtime_r(timep, result)
> lib/eal/windows/include/rte_virt2phys.h:#define VIRT2PHYS_DEVTYPE 0x8000
> lib/eal/windows/include/rte_virt2phys.h:#define IOCTL_VIRT2PHYS_TRANSLATE=
 CTL_CODE( \
> lib/eal/x86/include/rte_atomic.h:#define MPLOCKED                        =
/**< No need to insert MP lock prefix. */
> lib/eal/x86/include/rte_atomic.h:#define MPLOCKED        "lock ; "       =
/**< Insert MP lock prefix. */
> lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x3F
> lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x1F
> lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x0F
> lib/eal/x86/include/rte_memcpy.h:#define MOVEUNALIGNED_LEFT47_IMM(dst, sr=
c, len, offset)                                                     \
> lib/eal/x86/include/rte_memcpy.h:#define MOVEUNALIGNED_LEFT47(dst, src, l=
en, offset)                   \
> lib/eal/x86/include/rte_vect.h:#define  XMM_SIZE        16
> lib/eal/x86/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
> lib/eal/x86/include/rte_vect.h:#define  YMM_SIZE        (sizeof(ymm_t))
> lib/eal/x86/include/rte_vect.h:#define  YMM_MASK        (YMM_SIZE - 1)
> lib/eal/x86/include/rte_vect.h:#define _mm_cvtsi128_si64(a)    \
> lib/eal/freebsd/include/rte_os_shim.h:#define TIME_UTC 1
> lib/eal/freebsd/include/rte_os_shim.h:#define timespec_get(ts, base) rte_=
timespec_get(ts, base)
> lib/eal/ppc/include/rte_altivec.h:#define bool _Bool
> lib/eal/ppc/include/rte_vect.h:#define  XMM_SIZE        (sizeof(xmm_t))
> lib/eal/ppc/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
> lib/eal/include/rte_tailq.h:#define EAL_REGISTER_TAILQ(t) \
> lib/eal/include/rte_string_fns.h:#define strlcpy(dst, src, size) rte_strl=
cpy(dst, src, size)
> lib/eal/include/rte_string_fns.h:#define strlcat(dst, src, size) rte_strl=
cat(dst, src, size)
> lib/eal/include/rte_string_fns.h:#define strlcpy(dst, src, size) rte_strl=
cpy(dst, src, size)
> lib/eal/include/rte_string_fns.h:#define strlcat(dst, src, size) rte_strl=
cat(dst, src, size)
> lib/eal/include/rte_time.h:#define NSEC_PER_SEC             1000000000L
> lib/eal/include/rte_common.h:#define typeof __typeof__
> lib/eal/include/rte_common.h:#define asm __asm__
> lib/eal/include/rte_common.h:#define __extension__
> lib/eal/include/rte_common.h:#define GCC_VERSION (__GNUC__ * 10000 + __GN=
UC_MINOR__ * 100 +     \
> lib/eal/include/rte_common.h:#define CTOR_SECTION_LOG ".CRT$XIB"
> lib/eal/include/rte_common.h:#define CTOR_SECTION_BUS ".CRT$XIC"
> lib/eal/include/rte_common.h:#define CTOR_SECTION_CLASS ".CRT$XID"
> lib/eal/include/rte_common.h:#define CTOR_SECTION_LAST ".CRT$XIY"
> lib/eal/include/rte_common.h:#define CTOR_PRIORITY_TO_SECTION(priority) C=
TOR_SECTION_ ## priority
> lib/eal/include/rte_common.h:#define DTOR_SECTION_LOG "mydtor$B"
> lib/eal/include/rte_common.h:#define DTOR_SECTION_BUS "mydtor$C"
> lib/eal/include/rte_common.h:#define DTOR_SECTION_CLASS "mydtor$D"
> lib/eal/include/rte_common.h:#define DTOR_SECTION_LAST "mydtor$Y"
> lib/eal/include/rte_common.h:#define DTOR_PRIORITY_TO_SECTION(priority) D=
TOR_SECTION_ ## priority
> lib/eal/include/rte_common.h:#define    static_assert   _Static_assert
> lib/eal/include/rte_common.h:#define offsetof(TYPE, MEMBER)  __builtin_of=
fsetof (TYPE, MEMBER)
> lib/eal/include/rte_common.h:#define container_of(ptr, type, member) \
> lib/eal/include/rte_common.h:#define container_of(ptr, type, member)    _=
_extension__ ({               \
> lib/eal/include/rte_lcore.h:#define LCORE_ID_ANY     UINT32_MAX       /**=
< Any lcore. */
> lib/eal/include/rte_memory.h:#define SOCKET_ID_ANY -1                    =
/**< Any NUMA socket. */
> lib/eal/include/rte_ticketlock.h:#define TICKET_LOCK_INVALID_ID -1
> lib/eal/include/rte_compat.h:#define __has_attribute(x) 0
> lib/eal/include/rte_errno.h:#define __ELASTERROR 1000
> lib/eal/include/rte_seqlock.h: * #define MAX_Y_LEN 16
> lib/eal/include/rte_service_component.h:#define _SERVICE_PRIVATE_H_
> lib/eal/include/generic/rte_cycles.h:#define MS_PER_S 1000
> lib/eal/include/generic/rte_cycles.h:#define US_PER_S 1000000
> lib/eal/include/generic/rte_cycles.h:#define NS_PER_S 1000000000
> lib/eal/include/rte_branch_prediction.h:#define likely(x)       (!!(x))
> lib/eal/include/rte_branch_prediction.h:#define likely(x)       __builtin=
_expect(!!(x), 1)
> lib/eal/include/rte_branch_prediction.h:#define unlikely(x)     (!!(x))
> lib/eal/include/rte_branch_prediction.h:#define unlikely(x)     __builtin=
_expect(!!(x), 0)
> lib/eal/riscv/include/rte_vect.h:#define XMM_SIZE       (sizeof(xmm_t))
> lib/eal/riscv/include/rte_vect.h:#define XMM_MASK       (XMM_SIZE - 1)
> lib/compressdev/rte_compressdev_internal.h:#define COMPRESSDEV_LOG(level,=
 ...) \
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MBUF_POOL_SIZE         =
       (8192)
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_BURST_SIZE         =
       (64)
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_DATA_SIZE         (=
4096)
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_SESSION_MAP_ENTRIES   (=
1024) /**< Max nb sessions */
> lib/vhost/rte_vhost_crypto.h:#define VIRTIO_CRYPTO_MAX_NUM_BURST_VQS     =
       (64)
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_IV_LEN             =
       (32)
> lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_N_DESC             =
       (32)
> lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_GUEST_ANNOUNCE 21
> lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_MQ          22
> lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_MTU 3
> lib/vhost/rte_vhost.h: #define VIRTIO_F_ANY_LAYOUT              27
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_MQ  0
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_LOG_SHMFD   1
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_RARP        2
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_REPLY_ACK   3
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_NET_MTU     4
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_BACKEND_REQ 5
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_PAGEFAULT 8
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_CONFIG 9
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD 10
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER 11
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_STATUS 16
> lib/vhost/rte_vhost.h:#define VHOST_USER_F_PROTOCOL_FEATURES    30
> lib/mbuf/rte_mbuf.h:#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_sanity=
_check_mp(m, NULL)
> lib/mbuf/rte_mbuf_core.h:#define MBUF_INVALID_PORT RTE_MBUF_PORT_INVALID
>=20
>=20





