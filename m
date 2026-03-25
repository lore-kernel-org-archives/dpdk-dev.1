Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643E106B50D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 330F4402CE;
	Wed, 25 Mar 2026 13:11:37 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 95FF74028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:11:35 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5579021353
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:11:35 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: namespace pollution
Date: Wed, 25 Mar 2026 13:11:35 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657C4@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: namespace pollution
Thread-Index: Ady8UIaM0vF7FJPgRqOVYWcBaaMTIA==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

Still plenty of namespace pollution in #define'd names...
(And I haven't looked at enum values.)

egrep -r --include=3D'rte_*.h' '#define\s+' lib/ | egrep -v =
'#define\s+(_*RTE_|_*rte_|__INCLUDE_RTE)'

lib/security/rte_security_driver.h:#define SECURITY_GET_SESS_PRIV(s) \
lib/security/rte_security_driver.h:#define =
SECURITY_GET_SESS_PRIV_IOVA(s) \
lib/graph/rte_graph_feature_arc_worker.h:#define =
GRAPH_FEATURE_ARC_PTR_INITIALIZER  ((uintptr_t)UINTPTR_MAX)
lib/eventdev/rte_event_timer_adapter.h:#define =
ADAPTER_VALID_OR_ERR_RET(adapter, retval) do {          \
lib/eventdev/rte_event_timer_adapter.h:#define FUNC_PTR_OR_ERR_RET(func, =
errval) do {                  \
lib/eventdev/rte_event_timer_adapter.h:#define =
FUNC_PTR_OR_NULL_RET_WITH_ERRNO(func, errval) do {      \
lib/timer/rte_timer.h:#define MAX_SKIPLIST_DEPTH 10
lib/ip_frag/rte_ip_frag.h:#define IP_FRAG_DEATH_ROW_LEN         =
RTE_IP_FRAG_DEATH_ROW_LEN
lib/ip_frag/rte_ip_frag.h:#define IP_FRAG_DEATH_ROW_MBUF_LEN    =
RTE_IP_FRAG_DEATH_ROW_MBUF_LEN
lib/ip_frag/rte_ip_frag.h:#define ipv6_extension_fragment               =
rte_ipv6_fragment_ext
lib/member/rte_member_sketch.h:#define NUM_ROW_SCALAR 5
lib/member/rte_member_sketch.h:#define INTERVAL (1 << 15)
lib/member/rte_member_heap.h:#define LCHILD(x) (2 * x + 1)
lib/member/rte_member_heap.h:#define RCHILD(x) (2 * x + 2)
lib/member/rte_member_heap.h:#define PARENT(x) ((x - 1) / 2)
lib/member/rte_member_heap.h:#define HASH_BKT_SIZE 16
lib/member/rte_member_heap.h:#define HASH_HP_MULTI 4
lib/member/rte_member_heap.h:#define HASH_RESIZE_MULTI 2
lib/member/rte_member_sketch_avx512.h:#define NUM_ROW_VEC 8
lib/hash/rte_jhash.h:#define rot(x, k) (((x) << (k)) | ((x) >> =
(32-(k))))
lib/hash/rte_jhash.h:#define BIT_SHIFT(x, y, k) (((x) >> (k)) | =
((uint64_t)(y) << (32-(k))))
lib/hash/rte_jhash.h:#define BIT_SHIFT(x, y, k) (((uint64_t)(x) << (k)) =
| ((y) >> (32-(k))))
lib/hash/rte_jhash.h:#define LOWER8b_MASK rte_le_to_cpu_32(0xff)
lib/hash/rte_jhash.h:#define LOWER16b_MASK rte_le_to_cpu_32(0xffff)
lib/hash/rte_jhash.h:#define LOWER24b_MASK rte_le_to_cpu_32(0xffffff)
lib/hash/rte_crc_sw.h:#define CRC32_UPD(crc, n)                          =
                            \
lib/hash/rte_hash_crc.h:#define CRC32_SW            (1U << 0)
lib/hash/rte_hash_crc.h:#define CRC32_SSE42         (1U << 1)
lib/hash/rte_hash_crc.h:#define CRC32_x64           (1U << 2)
lib/hash/rte_hash_crc.h:#define CRC32_SSE42_x64     =
(CRC32_x64|CRC32_SSE42)
lib/hash/rte_hash_crc.h:#define CRC32_ARM64         (1U << 3)
lib/hash/rte_cuckoo_hash.h:#define RETURN_IF_TRUE(cond, retval) do { \
lib/hash/rte_cuckoo_hash.h:#define RETURN_IF_TRUE(cond, retval)
lib/hash/rte_cuckoo_hash.h:#define NULL_SIGNATURE                       =
0
lib/hash/rte_cuckoo_hash.h:#define EMPTY_SLOT                   0
lib/hash/rte_cuckoo_hash.h:#define KEY_ALIGNMENT                        =
16
lib/hash/rte_cuckoo_hash.h:#define LCORE_CACHE_SIZE             64
lib/table/rte_lru_arm64.h:#define lru_init(bucket)                       =
                       \
lib/table/rte_lru_arm64.h:#define lru_pos(bucket) =
f_lru_pos(bucket->lru_list)
lib/table/rte_lru_arm64.h:#define lru_update(bucket, mru_val)            =
                       \
lib/table/rte_table_hash_func_arm64.h:#define _CRC32CX(crc, val)        =
\
lib/table/rte_lru_x86.h:#define lru_init(bucket)                         =
                       \
lib/table/rte_lru_x86.h:#define lru_pos(bucket) (bucket->lru_list & =
0xFFFFLLU)
lib/table/rte_lru_x86.h:#define lru_update(bucket, mru_val)              =
                       \
lib/table/rte_lru_x86.h:#define lru_init(bucket)                         =
                       \
lib/table/rte_lru_x86.h:#define lru_pos(bucket) =
f_lru_pos(bucket->lru_list)
lib/table/rte_lru_x86.h:#define lru_update(bucket, mru_val)              =
                       \
lib/table/rte_lru.h:#define lru_init(bucket)                             =
               \
lib/table/rte_lru.h:#define lru_pos(bucket) (bucket->lru_list & =
0xFFFFLLU)
lib/table/rte_lru.h:#define lru_update(bucket, mru_val)                  =
               \
lib/table/rte_lru.h:#define lru_init(bucket)                             =
               \
lib/table/rte_lru.h:#define lru_pos(bucket) (bucket->lru_list & =
0xFFFFLLU)
lib/table/rte_lru.h:#define lru_update(bucket, mru_val)                  =
               \
lib/argparse/rte_argparse.h:#define ARGPARSE_ARG_END() { NULL }
lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_ERR(...) \
lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_INFO(...) \
lib/cryptodev/rte_cryptodev.h:#define CDEV_LOG_DEBUG(...) \
lib/cryptodev/rte_cryptodev.h:#define CDEV_PMD_TRACE(...) \
lib/cryptodev/rte_cryptodev.h:#define CRYPTO_SESS_OPAQUE_DATA_OFF 0
lib/cfgfile/rte_cfgfile.h:#define CFG_NAME_LEN 64
lib/cfgfile/rte_cfgfile.h:#define CFG_VALUE_LEN 256
lib/cfgfile/rte_cfgfile.h:#define CFG_DEFAULT_COMMENT_CHARACTER ';'
lib/ethdev/rte_eth_ctrl.h:#define UINT64_BIT (CHAR_BIT * =
sizeof(uint64_t))
lib/metrics/rte_metrics_telemetry.h:#define json_t void *
lib/sched/rte_sched_log.h:#define SCHED_LOG(level, ...) \
lib/pci/rte_pci.h:#define PCI_PRI_FMT "%.4" PRIx32 ":%.2" PRIx8 ":%.2" =
PRIx8 ".%" PRIx8
lib/pci/rte_pci.h:#define PCI_PRI_STR_SIZE sizeof("XXXXXXXX:XX:XX.X")
lib/pci/rte_pci.h:#define PCI_SHORT_PRI_FMT "%.2" PRIx8 ":%.2" PRIx8 =
".%" PRIx8
lib/pci/rte_pci.h:#define PCI_FMT_NVAL 4
lib/pci/rte_pci.h:#define PCI_RESOURCE_FMT_NVAL 3
lib/pci/rte_pci.h:#define PCI_MAX_RESOURCE 6
lib/pci/rte_pci.h:#define PCI_ANY_ID RTE_DEPRECATED(PCI_ANY_ID) =
RTE_PCI_ANY_ID
lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_SPREAD           =
RTE_MEMPOOL_F_NO_SPREAD
lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_CACHE_ALIGN      =
RTE_MEMPOOL_F_NO_CACHE_ALIGN
lib/mempool/rte_mempool.h:#define MEMPOOL_F_SP_PUT              =
RTE_MEMPOOL_F_SP_PUT
lib/mempool/rte_mempool.h:#define MEMPOOL_F_SC_GET              =
RTE_MEMPOOL_F_SC_GET
lib/mempool/rte_mempool.h:#define MEMPOOL_F_NO_IOVA_CONTIG      =
RTE_MEMPOOL_F_NO_IOVA_CONTIG
lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE_LEVEL 0
lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE(...) =
printf(__VA_ARGS__)
lib/pipeline/rte_swx_pipeline_internal.h:#define TRACE(...)
lib/pipeline/rte_swx_pipeline_internal.h:#define ntoh64(x) =
rte_be_to_cpu_64(x)
lib/pipeline/rte_swx_pipeline_internal.h:#define hton64(x) =
rte_cpu_to_be_64(x)
lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_GET(mask, =
pos) ((mask) & (1LLU << (pos)))
lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_SET(mask, =
pos) ((mask) | (1LLU << (pos)))
lib/pipeline/rte_swx_pipeline_internal.h:#define MASK64_BIT_CLR(mask, =
pos) ((mask) & ~(1LLU << (pos)))
lib/pipeline/rte_swx_pipeline_internal.h:#define HEADER_VALID(thread, =
header_id) \
lib/pipeline/rte_swx_pipeline_internal.h:#define instr_operand_nbo =
instr_operand_hbo
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MH(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM_FAST(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH_FAST(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MH ALU
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM ALU
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HM_FAST ALU
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH ALU
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HH_FAST ALU
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_I(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_MI ALU_I
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HI(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define ALU_HI ALU_I
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV(thread, ip)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_MH(thread, ip)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HM(thread, ip)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HH(thread, ip)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_MH MOV
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HM MOV
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_HH MOV
lib/pipeline/rte_swx_pipeline_internal.h:#define MOV_I(thread, ip)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MH(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HM(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH_FAST(thread, =
ip, operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MH JMP_CMP
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HM JMP_CMP
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH JMP_CMP
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HH_FAST JMP_CMP
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_I(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_MI JMP_CMP_I
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HI(thread, ip, =
operator)  \
lib/pipeline/rte_swx_pipeline_internal.h:#define JMP_CMP_HI JMP_CMP_I
lib/pipeline/rte_swx_pipeline_internal.h:#define METADATA_READ(thread, =
offset, n_bits)                                  \
lib/pipeline/rte_swx_pipeline_internal.h:#define METADATA_WRITE(thread, =
offset, n_bits, value)                          \
lib/pipeline/rte_swx_pipeline_internal.h:#define instr_regarray_idx_nbo =
instr_regarray_idx_hbo
lib/pipeline/rte_swx_pipeline_internal.h:#define instr_regarray_src_nbo =
instr_regarray_src_hbo
lib/pipeline/rte_swx_pipeline_internal.h:#define =
instr_regarray_dst_nbo_src_hbo_set instr_regarray_dst_hbo_src_hbo_set
lib/pipeline/rte_swx_pipeline_internal.h:#define instr_meter_idx_nbo =
instr_meter_idx_hbo
lib/pipeline/rte_swx_pipeline_internal.h:#define instr_meter_length_nbo =
instr_meter_length_hbo
lib/ring/rte_ring_core.h:#define RING_F_SP_ENQ 0x0001 /**< The default =
enqueue is "single-producer". */
lib/ring/rte_ring_core.h:#define RING_F_SC_DEQ 0x0002 /**< The default =
dequeue is "single-consumer". */
lib/ring/rte_ring_core.h:#define RING_F_EXACT_SZ 0x0004
lib/ring/rte_ring_core.h:#define RING_F_MP_RTS_ENQ 0x0008 /**< The =
default enqueue is "MP RTS". */
lib/ring/rte_ring_core.h:#define RING_F_MC_RTS_DEQ 0x0010 /**< The =
default dequeue is "MC RTS". */
lib/ring/rte_ring_core.h:#define RING_F_MP_HTS_ENQ 0x0020 /**< The =
default enqueue is "MP HTS". */
lib/ring/rte_ring_core.h:#define RING_F_MC_HTS_DEQ 0x0040 /**< The =
default dequeue is "MC HTS". */
lib/efd/rte_efd_x86.h:#define EFD_LOAD_SI128(val) _mm_load_si128(val)
lib/efd/rte_efd_x86.h:#define EFD_LOAD_SI128(val) _mm_lddqu_si128(val)
lib/efd/rte_efd.h:#define EFD_TARGET_GROUP_NUM_RULES (22)
lib/efd/rte_efd.h:#define EFD_MAX_GROUP_NUM_RULES (28LU)
lib/efd/rte_efd.h:#define EFD_MIN_BALANCED_NUM_RULES      5
lib/efd/rte_efd.h:#define EFD_LOOKUPTBL_SHIFT (32 - 4)
lib/pcapng/rte_pcapng.h:#define DLT_EN10MB 1
lib/mldev/rte_mldev_core.h:#define ML_DEV_DETACHED (0)
lib/mldev/rte_mldev_core.h:#define ML_DEV_ATTACHED (1)
lib/acl/rte_acl_osdep.h:#define DIM(x) RTE_DIM(x)
lib/eal/loongarch/include/rte_vect.h:#define XMM_SIZE        =
(sizeof(xmm_t))
lib/eal/loongarch/include/rte_vect.h:#define XMM_MASK        (XMM_SIZE - =
1)
lib/eal/arm/include/rte_atomic_64.h:#define =
__ATOMIC128_CAS_OP(cas_op_name, op_string)                          \
lib/eal/arm/include/rte_atomic_64.h:#define =
__ATOMIC128_CAS_OP(cas_op_name, op_string)                          \
lib/eal/arm/include/rte_atomic_64.h:#define __HAS_ACQ(mo) ((mo) !=3D =
rte_memory_order_relaxed && (mo) !=3D rte_memory_order_release)
lib/eal/arm/include/rte_atomic_64.h:#define __HAS_RLS(mo) ((mo) =3D=3D =
rte_memory_order_release || (mo) =3D=3D rte_memory_order_acq_rel || \
lib/eal/arm/include/rte_atomic_64.h:#define __LOAD_128(op_string, src, =
dst) { \
lib/eal/arm/include/rte_atomic_64.h:#define __STORE_128(op_string, dst, =
src, ret) { \
lib/eal/arm/include/rte_memcpy_64.h:#define USE_ALIGNED_RTE_MEMCPY(dst, =
src, n) \
lib/eal/arm/include/rte_memcpy_64.h:#define USE_ALIGNED_RTE_MEMCPY(dst, =
src, n) \
lib/eal/arm/include/rte_memcpy_64.h:#define =
USE_UNALIGNED_RTE_MEMCPY(dst, src, n) \
lib/eal/arm/include/rte_memcpy_64.h:#define =
USE_UNALIGNED_RTE_MEMCPY(dst, src, n) \
lib/eal/arm/include/rte_memcpy_64.h:#define USE_RTE_MEMCPY(dst, src, n) =
\
lib/eal/arm/include/rte_memcpy_64.h:#define USE_RTE_MEMCPY(dst, src, n) =
(1)
lib/eal/arm/include/rte_vect.h:#define  XMM_SIZE        (sizeof(xmm_t))
lib/eal/arm/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
lib/eal/windows/include/rte_os.h:#define __SIZEOF_LONG__ (sizeof(long))
lib/eal/windows/include/rte_os.h:#define __SIZEOF_LONG_LONG__ =
(sizeof(long long))
lib/eal/windows/include/rte_windows.h:#define WIN32_LEAN_AND_MEAN
lib/eal/windows/include/rte_windows.h:#define _m_prefetchw __m_prefetchw
lib/eal/windows/include/rte_windows.h:#define INITGUID
lib/eal/windows/include/rte_os_shim.h:#define PATH_MAX _MAX_PATH
lib/eal/windows/include/rte_os_shim.h:#define strdup(str) _strdup(str)
lib/eal/windows/include/rte_os_shim.h:#define strtok_r(str, delim, =
saveptr) strtok_s(str, delim, saveptr)
lib/eal/windows/include/rte_os_shim.h:#define strcasecmp(s1, s2) =
_stricmp(s1, s2)
lib/eal/windows/include/rte_os_shim.h:#define strncasecmp(s1, s2, count) =
_strnicmp(s1, s2, count)
lib/eal/windows/include/rte_os_shim.h:#define open(...) =
_open(__VA_ARGS__)
lib/eal/windows/include/rte_os_shim.h:#define read(fd, buf, n) _read(fd, =
buf, n)
lib/eal/windows/include/rte_os_shim.h:#define write(fd, buf, n) =
_write(fd, buf, n)
lib/eal/windows/include/rte_os_shim.h:#define close(fd) _close(fd)
lib/eal/windows/include/rte_os_shim.h:#define unlink(path) _unlink(path)
lib/eal/windows/include/rte_os_shim.h:#define fileno(f) _fileno(f)
lib/eal/windows/include/rte_os_shim.h:#define isatty(fd) _isatty(fd)
lib/eal/windows/include/rte_os_shim.h:#define IPVERSION 4
lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_IPIP      4
lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_GRE       47
lib/eal/windows/include/rte_os_shim.h:#define IPPROTO_SCTP      132
lib/eal/windows/include/rte_os_shim.h:#define IPDEFTTL 64
lib/eal/windows/include/rte_os_shim.h:#define S_ISREG(mode)  (((mode) & =
S_IFMT) =3D=3D S_IFREG)
lib/eal/windows/include/rte_os_shim.h:#define TIME_UTC 1
lib/eal/windows/include/rte_os_shim.h:#define timespec_get(ts, base) =
rte_timespec_get(ts, base)
lib/eal/windows/include/rte_os_shim.h:#define CLOCK_REALTIME             =
     0
lib/eal/windows/include/rte_os_shim.h:#define CLOCK_MONOTONIC            =
     1
lib/eal/windows/include/rte_os_shim.h:#define clock_gettime(clock_id, =
tp) rte_clock_gettime(clock_id, tp)
lib/eal/windows/include/rte_os_shim.h:#define localtime_r(timep, result) =
rte_localtime_r(timep, result)
lib/eal/windows/include/rte_virt2phys.h:#define VIRT2PHYS_DEVTYPE 0x8000
lib/eal/windows/include/rte_virt2phys.h:#define =
IOCTL_VIRT2PHYS_TRANSLATE CTL_CODE( \
lib/eal/x86/include/rte_atomic.h:#define MPLOCKED                        =
/**< No need to insert MP lock prefix. */
lib/eal/x86/include/rte_atomic.h:#define MPLOCKED        "lock ; "       =
/**< Insert MP lock prefix. */
lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x3F
lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x1F
lib/eal/x86/include/rte_memcpy.h:#define ALIGNMENT_MASK 0x0F
lib/eal/x86/include/rte_memcpy.h:#define MOVEUNALIGNED_LEFT47_IMM(dst, =
src, len, offset)                                                     \
lib/eal/x86/include/rte_memcpy.h:#define MOVEUNALIGNED_LEFT47(dst, src, =
len, offset)                   \
lib/eal/x86/include/rte_vect.h:#define  XMM_SIZE        16
lib/eal/x86/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
lib/eal/x86/include/rte_vect.h:#define  YMM_SIZE        (sizeof(ymm_t))
lib/eal/x86/include/rte_vect.h:#define  YMM_MASK        (YMM_SIZE - 1)
lib/eal/x86/include/rte_vect.h:#define _mm_cvtsi128_si64(a)    \
lib/eal/freebsd/include/rte_os_shim.h:#define TIME_UTC 1
lib/eal/freebsd/include/rte_os_shim.h:#define timespec_get(ts, base) =
rte_timespec_get(ts, base)
lib/eal/ppc/include/rte_altivec.h:#define bool _Bool
lib/eal/ppc/include/rte_vect.h:#define  XMM_SIZE        (sizeof(xmm_t))
lib/eal/ppc/include/rte_vect.h:#define  XMM_MASK        (XMM_SIZE - 1)
lib/eal/include/rte_tailq.h:#define EAL_REGISTER_TAILQ(t) \
lib/eal/include/rte_string_fns.h:#define strlcpy(dst, src, size) =
rte_strlcpy(dst, src, size)
lib/eal/include/rte_string_fns.h:#define strlcat(dst, src, size) =
rte_strlcat(dst, src, size)
lib/eal/include/rte_string_fns.h:#define strlcpy(dst, src, size) =
rte_strlcpy(dst, src, size)
lib/eal/include/rte_string_fns.h:#define strlcat(dst, src, size) =
rte_strlcat(dst, src, size)
lib/eal/include/rte_time.h:#define NSEC_PER_SEC             1000000000L
lib/eal/include/rte_common.h:#define typeof __typeof__
lib/eal/include/rte_common.h:#define asm __asm__
lib/eal/include/rte_common.h:#define __extension__
lib/eal/include/rte_common.h:#define GCC_VERSION (__GNUC__ * 10000 + =
__GNUC_MINOR__ * 100 +     \
lib/eal/include/rte_common.h:#define CTOR_SECTION_LOG ".CRT$XIB"
lib/eal/include/rte_common.h:#define CTOR_SECTION_BUS ".CRT$XIC"
lib/eal/include/rte_common.h:#define CTOR_SECTION_CLASS ".CRT$XID"
lib/eal/include/rte_common.h:#define CTOR_SECTION_LAST ".CRT$XIY"
lib/eal/include/rte_common.h:#define CTOR_PRIORITY_TO_SECTION(priority) =
CTOR_SECTION_ ## priority
lib/eal/include/rte_common.h:#define DTOR_SECTION_LOG "mydtor$B"
lib/eal/include/rte_common.h:#define DTOR_SECTION_BUS "mydtor$C"
lib/eal/include/rte_common.h:#define DTOR_SECTION_CLASS "mydtor$D"
lib/eal/include/rte_common.h:#define DTOR_SECTION_LAST "mydtor$Y"
lib/eal/include/rte_common.h:#define DTOR_PRIORITY_TO_SECTION(priority) =
DTOR_SECTION_ ## priority
lib/eal/include/rte_common.h:#define    static_assert   _Static_assert
lib/eal/include/rte_common.h:#define offsetof(TYPE, MEMBER)  =
__builtin_offsetof (TYPE, MEMBER)
lib/eal/include/rte_common.h:#define container_of(ptr, type, member) \
lib/eal/include/rte_common.h:#define container_of(ptr, type, member)    =
__extension__ ({               \
lib/eal/include/rte_lcore.h:#define LCORE_ID_ANY     UINT32_MAX       =
/**< Any lcore. */
lib/eal/include/rte_memory.h:#define SOCKET_ID_ANY -1                    =
/**< Any NUMA socket. */
lib/eal/include/rte_ticketlock.h:#define TICKET_LOCK_INVALID_ID -1
lib/eal/include/rte_compat.h:#define __has_attribute(x) 0
lib/eal/include/rte_errno.h:#define __ELASTERROR 1000
lib/eal/include/rte_seqlock.h: * #define MAX_Y_LEN 16
lib/eal/include/rte_service_component.h:#define _SERVICE_PRIVATE_H_
lib/eal/include/generic/rte_cycles.h:#define MS_PER_S 1000
lib/eal/include/generic/rte_cycles.h:#define US_PER_S 1000000
lib/eal/include/generic/rte_cycles.h:#define NS_PER_S 1000000000
lib/eal/include/rte_branch_prediction.h:#define likely(x)       (!!(x))
lib/eal/include/rte_branch_prediction.h:#define likely(x)       =
__builtin_expect(!!(x), 1)
lib/eal/include/rte_branch_prediction.h:#define unlikely(x)     (!!(x))
lib/eal/include/rte_branch_prediction.h:#define unlikely(x)     =
__builtin_expect(!!(x), 0)
lib/eal/riscv/include/rte_vect.h:#define XMM_SIZE       (sizeof(xmm_t))
lib/eal/riscv/include/rte_vect.h:#define XMM_MASK       (XMM_SIZE - 1)
lib/compressdev/rte_compressdev_internal.h:#define =
COMPRESSDEV_LOG(level, ...) \
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MBUF_POOL_SIZE         =
       (8192)
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_BURST_SIZE         =
       (64)
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_DATA_SIZE         =
(4096)
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_SESSION_MAP_ENTRIES   =
(1024) /**< Max nb sessions */
lib/vhost/rte_vhost_crypto.h:#define VIRTIO_CRYPTO_MAX_NUM_BURST_VQS     =
       (64)
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_IV_LEN             =
       (32)
lib/vhost/rte_vhost_crypto.h:#define VHOST_CRYPTO_MAX_N_DESC             =
       (32)
lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_GUEST_ANNOUNCE 21
lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_MQ          22
lib/vhost/rte_vhost.h: #define VIRTIO_NET_F_MTU 3
lib/vhost/rte_vhost.h: #define VIRTIO_F_ANY_LAYOUT              27
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_MQ  0
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_LOG_SHMFD   1
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_RARP        2
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_REPLY_ACK   3
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_NET_MTU     4
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_BACKEND_REQ 5
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_PAGEFAULT 8
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_CONFIG 9
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD 10
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER 11
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
lib/vhost/rte_vhost.h:#define VHOST_USER_PROTOCOL_F_STATUS 16
lib/vhost/rte_vhost.h:#define VHOST_USER_F_PROTOCOL_FEATURES    30
lib/mbuf/rte_mbuf.h:#define MBUF_RAW_ALLOC_CHECK(m) =
__rte_mbuf_raw_sanity_check_mp(m, NULL)
lib/mbuf/rte_mbuf_core.h:#define MBUF_INVALID_PORT RTE_MBUF_PORT_INVALID

