Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0E606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W2IovKWh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF99A415D7;
	Thu, 12 Nov 2026 18:49:23 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTPS id E1D1140E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:49:22 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8a39e5161c1so58285b3a.3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794505761;
 x=1795110561; darn=dpdk.org; 
 h=content-type:mime-version:message-id:subject:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DuMUCBD4O74yQHRXxR5VoNkoW7VyxsgDjleg82JZiE4=;
 b=W2IovKWhTlJr/VVKqQgUgU7K22qdPgT1CfURxr/vCzYHJ3MB2OcBlaW6IDhzDoMzbJ
 CaorDK0qjzoPoz3AJP6Om4k10AP/afRI+CWA48spc5TzuNr5wUQ/X/VzaeM09UXSh2kw
 B+59uBqyT4ZouCC0B99xA1qus5oJFWb4LyXFXylNPn9Yc894tUqLSzq0npHON1R+b3OR
 9vYIcxTkyq+ZFn2l5XwKT1eLJvXDBLpfPFCpNh7VoAkKWnXOXwirCAXbklaoZ6ZsRsqR
 J4FGVkEnRRJZX0f5hqm3i0eVM9O+7Kvh509Y4oPMYDQnYPShvVMqHWxLbvwFaFeJNBtk
 KP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505761; x=1795110561;
 h=content-type:mime-version:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DuMUCBD4O74yQHRXxR5VoNkoW7VyxsgDjleg82JZiE4=;
 b=knzV41eo9I38yhViuiuO57dYkaSwLAQLvnkxas5A899YKu8mDRf0SvgS/rF/96YKE5
 WnhZbgLh2ONrytzaE83p9bCME518fOYlxAG+lC2M/wcruY6oEtcEv5YsrPHiMLRzQUiR
 Ijx0J12f230iorBLMvl7SCpHHcGeicUQ9loGk5fH6VyYhRQ7kj037L0BvaoIwrIigOS2
 VrjBQz//P+dKcHWn2ANeY9O6CRs24yfTUrda2qKsxwOO2pjTrA0t+hvxPwhthKBVj763
 nMXFBoabWIMa6V14i09jU5KvEYx+LtDjg3CGnVdKIFpg7r+3H+zPRjNwI6l+4ZA0Sbtc
 159w==
X-Gm-Message-State: APuU4Z+WiWvQVvIRB/EwUI/o2mNPnZmHx7riBU+fVLSEY5Z2mPZEpBAs
 YyMLUuVU5Wd1OhxQL0Q0eapAqhTjkQV4pULHHy6129Swu7tH22nsMSLejJAhx7TnV68uqcPqb46
 nBI2uGYk=
X-Gm-Gg: AYBFou109wZsMGZhIzNYoFGiL6wGLi0JmmzdJylCblvzFVBiUjBT9S9qA/wSY6mXGzp
 uR3Lv4NcPcg3VvBKzgqeCU79AbaHTtmJfpmuloLiRcEGb8wwsCAodnxlFJCxz+sS/EewuHi+Jzb
 oMEVY5d75VsZZ47ieQe9ELE1EnscKYElAgTNOWYZ0RC6FPw7zUssBTl4CvgzcXmI8EtYma6Heol
 xhGyI1Hv7NxngDTpfNaw1EwH9A3D+z8UmIZyDh1UG59/AuwsT29F0qpSAvDGszjFNOVXwAG263l
 h6MSpvxyRx44tWGeHQiNc4GmaiSRfs/IhBnbLyUrS5wxiJvXsIsgScquD2y6Uw5IROJHZMMq4/N
 Ss2oOOY+e3B09HIGBPHnBkO9iLzxwU0bwDuzHKXB5mejUA1IverPqIKH3JGFSGb58lUFoILpDpe
 PUgHo4Be469I5g0nzkkBDLlaG4cgj9uQ+UAVVApKx7JAU5Ndq9ZnLal33axGD67g1XqNRb5wHsl
 0Ic0IbU3zUZUINanpGy/Dm6pN/hjlsvVcqZj4NOo4gThrqDNujl6uiuea5EsQJIG4ojX6QzwWsy
 /ULTyzyGA9g8jT3Sva5eFNsroltFjq/bCwsRxsbZhooEfnnJ9LLDso1jpn/xSRDSLNSE4AqZrw=
 =
X-Received: by 2002:a05:6300:2204:b0:3e1:4527:6350 with SMTP id
 adf61e73a8af0-3f2ff8ce5c8mr6940546637.64.1794505760866; 
 Thu, 12 Nov 2026 09:49:20 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc186f472sm85522a12.6.2026.11.12.09.49.19
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:19 -0800 (PST)
Date: Thu, 12 Nov 2026 09:49:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Bugs detected by GCC analyzer
Message-ID: <20261112094914.37c0bee3@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/lo.Ksc99a5Sv1usFRlA.z8n"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--MP_/lo.Ksc99a5Sv1usFRlA.z8n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

GCC now has a built in code analyzer which is enabled with -fanalyzer.

Building DPDK with that produces lots of warnings.
Given the volume of data AI proved helpful in pulling real bugs out of the noise.
I put first round of them in bugzilla.

Summary:

About a quarter of the reports are valid: of 894 distinct warning rows
(708 unique sites, 1267 log lines), 246 are real, 631 are false
positives and 17 I could not settle. Of the real ones, 88 are in app/
(75 in unit tests), and a further group is harmless. The full list is
in analyzer-triage.md.

Sending results here so that anyone interested can pickup.

--MP_/lo.Ksc99a5Sv1usFRlA.z8n
Content-Type: text/markdown
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=analyzer-bugs.md

# Bug summaries from GCC 16 -fanalyzer run

Line numbers are for commit 2e2f0d720c. Found with `-Dc_args=-fanalyzer`, buildtype=release.
One entry per root cause. Component is a suggestion for the DPDK bugzilla field.
Confidence: "confirmed" = source re-read in a second pass; "single pass" = read once.
None of these were reproduced at runtime.

---

## lib

### 1. pipeline: table entry parser accepts actions not belonging to the table
Component: other | Severity: major | Confidence: confirmed

`rte_swx_ctl_pipeline_table_entry_read()` (lib/pipeline/rte_swx_ctl.c:3131) finds the
action with `action_find(ctl, tokens[1])`, which searches all pipeline actions. It does not
check that the action is one of the table's actions. `entry->action_data` is allocated
from `table->params.action_data_size` (:321), or left NULL when that is 0.
`table_entry_action_argument_read()` (:2896) then copies the arguments into it. An entry
line naming an action with more argument bytes than the table allows writes past the
buffer, or to NULL.

### 2. pdcp: rte_pktmbuf_prepend() result not checked
Component: other | Severity: major | Confidence: confirmed

lib/pdcp/pdcp_process.c:59, :146 and :167 call `rte_pktmbuf_prepend(mb, 8)` and write
through the result with `rte_memcpy()`. With less than 8 bytes of headroom the result is
NULL and the datapath crashes.

### 3. pipeline: pipeline_spec_free() does not free the spec
Component: other | Severity: normal | Confidence: confirmed

`pipeline_spec_parse()` allocates `s` with calloc (lib/pipeline/rte_swx_pipeline_spec.c:2893).
`pipeline_spec_free()` (:2193-2211) frees the members and ends with
`memset(s, 0, sizeof(*s))`; it never frees `s`. Both callers (:3494 and
rte_swx_pipeline.c:14675) rely on it. The struct leaks on every parse.

### 4. pdump: BPF filter leaked on error in set_pdump_rxtx_cbs()
Component: other | Severity: normal | Confidence: confirmed

lib/pdump/rte_pdump.c:403 loads `filter = rte_bpf_load(p->prm)`. The later error returns
(invalid device name, port/queue checks, around :422-:453) return without
`rte_bpf_destroy(filter)`. A request with a filter and an invalid port leaks the program
each time.

### 5. node: kernel_rx_node_init() leaks recv_info when socket() fails
Component: other | Severity: minor | Confidence: confirmed

lib/node/kernel_rx.c:214 allocates `recv_info`; :222-224 returns when
`socket(AF_INET, SOCK_RAW, IPPROTO_RAW)` fails without freeing it.

### 6. eventdev: rxa_sw_vector_limits() does not set log2_sz
Component: eventdev | Severity: minor | Confidence: confirmed

lib/eventdev/rte_event_eth_rx_adapter.c:2961 fills min_sz, max_sz and the two timeouts but
not `log2_sz`. `rte_event_eth_rx_adapter_vector_limits_get()` returns the caller's
uninitialised value for the SW adapter, and the trace point at :3136 reads it.

### 7. graph: cluster_add() loses the array when realloc fails
Component: other | Severity: minor | Confidence: single pass

lib/graph/graph_stats.c:354 does `cluster->graphs = realloc(cluster->graphs, sz)`. On
failure the old block is leaked and the pointer is NULL.

### 8. eal: rte_dev_probe() rollback can call local_dev_remove(NULL)
Component: core | Severity: minor | Confidence: single pass

`local_dev_probe()` sets `*new_dev = NULL` (lib/eal/common/eal_common_dev.c:186) and can
return at :252 without setting it. `rte_dev_probe()` continues on `-EEXIST` (:321); if the
secondary sync then fails it reaches `rollback:` and calls `local_dev_remove(dev)` (:369)
with `dev == NULL`, which dereferences it (:405). Narrow path.

### 9. compressdev: rte_compressdev_capability_get() assumes capabilities is set
Component: other | Severity: minor | Confidence: single pass

`rte_compressdev_info_get()` zeroes `dev_info` and returns early when the PMD has no
`dev_infos_get` (lib/compressdev/rte_compressdev.c:685). `rte_compressdev_capability_get()`
(:59) then dereferences `dev_info.capabilities`. No in-tree PMD triggers it.

---

## drivers/net/bnxt

### 10. net/bnxt: double free in tfc_msg error path
Component: ethdev | Severity: major | Confidence: confirmed

`tfc_msg_alloc_dma_buf()` (drivers/net/bnxt/tf_core/v3/tfc_msg.c:151) frees `buf->va_addr`
at :160 when `rte_mem_virt2iova()` fails and leaves the pointer set. Every caller then goes
to `cleanup:` and calls `tfc_msg_free_dma_buf()` (:176), freeing it again. Callers:
`tfc_msg_idx_tbl_alloc_set`, `tfc_msg_idx_tbl_set`, `tfc_msg_idx_tbl_get`,
`tfc_msg_tcam_alloc_set`, `tfc_msg_tcam_set`.

### 11. net/bnxt: tfc_msg_idx_tbl_set() allocates the DMA buffer twice
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/bnxt/tf_core/v3/tfc_msg.c:647 calls `tfc_msg_alloc_dma_buf(&buf, data_size)`
unconditionally, and :653 calls it again inside `if (req.data_size >= sizeof(req.dev_data))`.
The first buffer is overwritten and leaked on every DMA-sized set.

### 12. net/bnxt: uninitialised rxcmp1 used in compressed CQE SSE Rx
Component: ethdev | Severity: major | Confidence: confirmed

`crx_burst_vec_sse()` declares `__m128i rxcmp1[]` at
drivers/net/bnxt/bnxt_rxtx_vec_sse.c:448 and passes it to `crx_descs_to_mbufs()` (:498)
without ever writing it. `GET_DESC_FIELDS` (:51) blends `rxcmp1` into the `vlan_tci` word
of `rx_descriptor_fields1`, so every mbuf on this path gets stack garbage in `vlan_tci`.

### 13. net/bnxt: leaks in bnxt_alloc_ctx_mem_blk() error paths
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/bnxt/bnxt_ethdev.c: `ctx_pg_arr` (:5043) leaks when the `ctx_dma_arr`
allocation fails (:5050), and `ctx_dma_arr` leaks when `rte_memzone_reserve` fails (:5096).
`bnxt_free_ctx_mem()` does not recover them because `BNXT_CTX_FLAG_INITED` is not set.

### 14. net/bnxt: NULL check after dereference in bnxt_free_ctx_mem()
Component: ethdev | Severity: trivial | Confidence: confirmed

drivers/net/bnxt/bnxt_ethdev.c:5194-5196 dereferences `bp->ctx->tqm_mem[i]` twice and then
tests it for NULL. The check is dead or the dereference is wrong.

---

## drivers/net/intel

### 15. net/cpfl: cfgq leaked in vcpf_save_chunk_in_cfgq()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/cpfl/cpfl_ethdev.c:2201 allocates `cfgq`; :2210-2213 returns -ENOMEM
when the `cfgq_add` allocation fails without freeing it.

### 16. net/cpfl, net/idpf: adapter leaked on probe failure
Component: ethdev | Severity: minor | Confidence: single pass

`cpfl_pci_probe_first()` allocates `adapter` at drivers/net/intel/cpfl/cpfl_ethdev.c:3096
and returns at :3106 (devargs parse) and :3111 (adapter init) without freeing it.
`idpf_pci_probe()` has the same pattern: allocation at
drivers/net/intel/idpf/idpf_ethdev.c:1666, return at :1674.

### 17. net/cpfl: NULL dereference parsing a "parameter" content field without prog action
Component: ethdev | Severity: normal | Confidence: single pass

`cpfl_parse_content()` (drivers/net/intel/cpfl/cpfl_flow_parser.c:1989) reads
`prog->prog`, which is only set at :1881 when the mod rule key has a PROG action. The JSON
loader accepts a content field of type "parameter" for any key, so such a rule crashes
when used.

### 18. net/cpfl: cpfl_repr_create() returns uninitialised value
Component: ethdev | Severity: normal | Confidence: confirmed

`int ret;` (drivers/net/intel/cpfl/cpfl_representor.c:563) is only assigned inside the
allowlist loop. If the hash is empty or every entry is skipped by `if (dev != NULL)
continue;`, the function returns garbage at :662 and the callers may treat it as a probe
failure.

### 19. net/ice: kb leaked in _xlt_kb_get()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/ice/base/ice_xlt_kb.c:135 allocates `kb`; :144-148 returns NULL when
`ice_pkg_enum_section()` finds no section, without freeing it.

### 20. net/ice: DCF VF representor VLAN ops dereference NULL after DCF release
Component: ethdev | Severity: normal | Confidence: confirmed

`ice_dcf_vf_repr_hw()` returns NULL when `!repr->dcf_valid`
(drivers/net/intel/ice/ice_dcf_vf_representor.c:135). `ice_dcf_vlan_offload_ena()` (:233)
dereferences the result unchecked. Reached from the vlan_offload_set, vlan_pvid_set and
vlan_tpid_set ops.

### 21. net/idpf: unchecked allocation in idpf_vc_queue_grps_del()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/idpf/idpf_common_virtchnl.c:439 `rte_zmalloc()` result is dereferenced
at :441.

### 22. net/ixgbe: uninitialised buffers copied in E610 ACI commands
Component: ethdev | Severity: trivial | Confidence: single pass

`ixgbe_read_sr_word_aci()` passes uninitialised `data_local`
(drivers/net/intel/ixgbe/base/ixgbe_e610.c:3162) as a response buffer that
`ixgbe_aci_send_cmd_execute()` copies out at :240. `ixgbe_update_link_info()` passes an
unzeroed malloc that is copied at :395. Also `ixgbe_dev_mtu_set()`
(ixgbe_ethdev.c:5322) passes an uninitialised `dev_info` to `ixgbe_dev_info_get()`, which
does `dev_capa |=` on it (:3922). No functional effect seen.

---

## drivers/net/ntnic

### 23. net/ntnic: FPGA model constructors return unchecked malloc
Component: ethdev | Severity: minor | Confidence: single pass

`nthw_fpga_model_new`, `nthw_module_new`, `nthw_register_new`, `nthw_field_new`,
`nthw_param_new` (drivers/net/ntnic/nthw/model/nthw_fpga_model.c) return `malloc()`
directly and callers pass the result to `*_init()`, which dereferences it (:186, :245,
:296, :317, :418). Same in `nthw_id_table_create()`
(nthw/flow_api/flow_id_table.c:68, calloc dereferenced at :70).

### 24. net/ntnic: p_drv leaked on init failure
Component: ethdev | Severity: minor | Confidence: single pass

`nthw_pci_dev_init()` allocates `p_drv` at drivers/net/ntnic/ntnic_ethdev.c:2326 and
stores it with `store_pdrv()` (:2380). The later `return -1` paths (:2388, :2437, :2456,
...) do not free it or clear the stored pointer.

### 25. net/ntnic: NULL check after dereference in nthw_pci_dev_deinit()
Component: ethdev | Severity: trivial | Confidence: confirmed

drivers/net/ntnic/ntnic_ethdev.c:2680 dereferences `internals`; :2688 then loops on
`while (internals)`.

---

## drivers/net/nfp

### 26. net/nfp: double free on malformed firmware ELF
Component: ethdev | Severity: major | Confidence: confirmed

`nfp_elf_read_section_headers()` frees `ectx->shdrs_host_endian`, `shdrs_data` and `shdrs`
on its error labels (drivers/net/nfp/nfpcore/nfp_elf.c:866-870) without clearing them.
`nfp_elf_mutable_buf()` then goes to `elf_free:` and `nfp_elf_free()` (:275-277) frees the
same pointers again.

### 27. net/nfp: txq leaked on NFDK Tx queue setup failure
Component: ethdev | Severity: minor | Confidence: single pass

`nfp_net_nfdk_tx_queue_setup()` allocates `txq` at drivers/net/nfp/nfdk/nfp_nfdk_dp.c:460.
On memzone (:476) or txbufs (:499) failure it calls `nfp_net_tx_queue_release(dev,
queue_idx)`, which frees `dev->data->tx_queues[queue_idx]`. That slot is only assigned at
:513, so `txq` is not freed.

### 28. net/nfp: hw_priv/pf_dev leaked when firmware reports no ports in secondary
Component: ethdev | Severity: minor | Confidence: single pass

`nfp_pf_secondary_init()` (drivers/net/nfp/nfp_ethdev.c:2847): when
`nfp_net_get_phyports_from_fw()` returns 0, the port loop does not run and the function
returns 0 without attaching or freeing its allocations.

### 29. net/nfp: unchecked allocation in nfp_nsp_command_buf_dma_sg()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/nfp/nfpcore/nfp_nsp.c:551 `rte_zmalloc()` result is dereferenced at :555.

### 30. net/nfp: rte_pktmbuf_prepend() not checked in NFD3 Tx metadata
Component: ethdev | Severity: normal | Confidence: confirmed

`nfp_net_nfd3_set_meta_data()` (drivers/net/nfp/nfd3/nfp_nfd3_dp.c:184) writes through
the result of `rte_pktmbuf_prepend(pkt, meta_data->length)` without a NULL check. A Tx
mbuf with VLAN or IPsec offload and too little headroom crashes.

---

## drivers/net/cnxk

### 31. net/cnxk: process_ack_message() overwrites the buffer pointer it just allocated
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/cnxk/cnxk_rep_msg.c:338 sets `adata->u.data = rte_zmalloc(...)`. For
`msg_len == 8`, :341 does `rte_memcpy(&adata->u.data, buf, msg_len)`, overwriting the
pointer and leaking the allocation. For other sizes :343 copies into the unchecked
allocation.

### 32. net/cnxk: send_ack_message() never frees its buffer
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/cnxk/cnxk_rep_msg.c:552 allocates `buffer` (CTRL_MSG_BUFFER_SZ). No path frees
it; the function ends at `done: return rc;` (:575).

### 33. net/cnxk: unchecked plt_zmalloc() in representor message and flow code
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_rep_msg.c:391, :419, :451, :613 and cnxk_rep_flow.c:213, :223 use
the `plt_zmalloc()` result without a NULL check. At cnxk_rep_msg.c:419 the new `adata`
also replaces the one stored at :394, which is leaked.

### 34. net/cnxk: flow leaked in cnxk_eswitch_pfvf_flow_rules_install()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_eswitch_flow.c:395 allocates `flow`. The `goto free_flow` paths
(:403-429) call `cnxk_eswitch_flow_rules_remove_list()`, which only frees list members;
`flow` is not on the list yet.

### 35. net/cnxk: msg leaked in cnxk_representee_notification()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_rep.c:398 allocates `msg`; when the `notify_msg` allocation fails
(:406-409) it jumps to `done` without freeing `msg`.

### 36. net/cnxk: TM node and shaper profile leaked when roc add fails
Component: ethdev | Severity: normal | Confidence: single pass

`cnxk_nix_tm_shaper_profile_add()` (drivers/net/cnxk/cnxk_tm.c:306-312) and
`cnxk_nix_tm_node_add()` (:394-399) return on a roc error without freeing the profile or
node they allocated. Reachable with invalid user parameters.

---

## drivers/net (others)

### 37. net/r8169: memset on NULL after failed append
Component: ethdev | Severity: normal | Confidence: confirmed

`rtl8125_ptp_patch()` (drivers/net/r8169/r8169_rxtx.c:1568-1571) logs when
`rte_pktmbuf_append()` returns NULL, then calls `memset(padding, 0, pad_len)` anyway.

### 38. net/zxdh: device-supplied length used for memcpy into 1-byte buffer
Component: ethdev | Severity: major | Confidence: confirmed

`zxdh_get_res_info()` (drivers/net/zxdh/zxdh_common.c:230) does `*len = tbl_reps->len;
rte_memcpy(res, ..., *len);`. Callers such as `zxdh_get_res_panel_id()` (:239) pass
`uint8_t reps`. A reply with len > 1 overruns the stack.

### 39. net/zxdh: flow leaked on validate
Component: ethdev | Severity: normal | Confidence: confirmed

`fd_flow_parse_pattern()` (drivers/net/zxdh/zxdh_flow.c:1256) and `fd_flow_parse_action()`
(:1664) allocate `flow` when `dh_flow == NULL` (the validate path). The success returns at
:1494 and :1831 do not free it; only the `free_flow:` error label does.

### 40. net/cxgbe: NULL mbuf dereferenced in set_tcb_field()
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/cxgbe/cxgbe_filter.c:179 allocates an mbuf; `WARN_ON(!mbuf)` only logs and
:182 dereferences it.

### 41. net/cxgbe: pi->rss is never freed
Component: ethdev | Severity: minor | Confidence: single pass

`cxgbe_init_rss()` allocates `pi->rss` (drivers/net/cxgbe/cxgbe_main.c:688). There is no
`rte_free()` of that field in the driver (close or probe failure).

### 42. net/sfc: fields array leaked in sfc_tbl_meta_desc_read()
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/sfc/sfc_tbl_meta_cache.c:137 allocates the temporary `fields` array. The
success path returns 0 at :163 without freeing it.

### 43. net/sfc: id leaked in sfc_hw_switch_id_init()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/sfc/sfc.c:1435 allocates `id`; :1439-1441 returns when
`efx_nic_get_board_info()` fails without freeing it.

### 44. net/vmxnet3: queue structure leaked on setup failure
Component: ethdev | Severity: minor | Confidence: confirmed (Tx), single pass (Rx)

`vmxnet3_dev_tx_queue_setup()` allocates `txq` at drivers/net/vmxnet3/vmxnet3_rxtx.c:1047
and returns at :1070, :1074, :1098, :1122 without freeing it. `vmxnet3_dev_rx_queue_setup()`
does the same with `rxq` (:1151; returns at :1180, :1183, :1214, :1252).

### 45. net/xsc: bad IOVA handling in xsc_rxq_initialize()
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/xsc/xsc_rx.c:231 allocates `jumbo_buffer_pa`. If `rte_malloc_virt2iova()`
returns RTE_BAD_IOVA (:240) the code continues without freeing it, and `jumbo_buffer_va`
keeps the bad value, so later iterations skip the allocation and use it as an address.

### 46. net/xsc: leak and unchecked allocation in init paths
Component: ethdev | Severity: minor | Confidence: single pass

`xsc_dev_init()` (drivers/net/xsc/xsc_dev.c:359) leaks `d` on `return -ENODEV` (:366).
`xsc_ethdev_tx_queue_setup()` (xsc_ethdev.c:546) dereferences the `rte_malloc_socket()`
result at :548 unchecked.

### 47. net/memif: leaks on error paths
Component: ethdev | Severity: minor | Confidence: confirmed (:1774), single pass (others)

drivers/net/memif/rte_eth_memif.c:
- `memif_mp_request_regions()`: `r` (:169) leaked at :176-179.
- `memif_region_init_zc()`: `r` (:1326) leaked at :1336.
- `memif_region_init_shm()`: `error:` (:1416) closes the fd but does not free `r`.
- `memif_tx_queue_setup()` / `memif_rx_queue_setup()`: `mq` (:1774, :1812) leaked when
  `rte_intr_instance_alloc()` or `rte_intr_type_set()` fails.

### 48. net/failsafe: rxq leaked when eventfd() fails
Component: ethdev | Severity: minor | Confidence: confirmed

`fs_rx_queue_setup()` allocates `rxq` at drivers/net/failsafe/failsafe_ops.c:461 and
returns at :478-481 when `eventfd()` fails, before the queue is stored.

### 49. net/gve: txq leaked on bad thresholds in DQO Tx queue setup
Component: ethdev | Severity: minor | Confidence: confirmed

drivers/net/gve/gve_tx_dqo.c:605 allocates `txq`; :618-619 returns -EINVAL from
`check_tx_thresh_dqo()` without going to the free label.

### 50. net/ionic: leak in ionic_qcq_alloc() CMB error path
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/ionic/ionic_lif.c (about :691): "Cannot reserve queue from NIC mem" returns
-ENOMEM directly instead of `goto err_out_free_info`, leaking `new`, `new->q.info` and the
memzone.

### 51. net/mana: priv leaked on secondary process probe
Component: ethdev | Severity: minor | Confidence: confirmed

`mana_probe_port()` allocates `priv` at drivers/net/mana/mana.c:2189. The secondary
process branch returns 0 at :2236 without freeing or storing it.

### 52. net/nbl: leaks on channel setup errors
Component: ethdev | Severity: minor | Confidence: confirmed (pipe), single pass (mailbox)

drivers/net/nbl/nbl_hw/nbl_channel.c: `nbl_chan_task_init()` (:596) does not close the
mailbox pipe fds when thread creation fails (:604-607). `nbl_chan_setup_chan_mgt()` (:943)
leaks `mailbox` when `nbl_chan_init_state_bitmap()` fails (:950).

### 53. net/ring: rings leaked on eth_dev_ring_create() failure
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/ring/rte_eth_ring.c:548, :556, :561 return -1 without freeing the rings
already created in `rxtx[]`.

### 54. net/softnic: msgq_req leaked when msgq_rsp creation fails
Component: ethdev | Severity: minor | Confidence: single pass

`softnic_thread_init()` (drivers/net/softnic/rte_eth_softnic_thread.c:69): the request
ring of the current iteration is not yet stored when `softnic_thread_free()` runs.

### 55. net/dpaa2: lsx_ccsr_map_region() result not checked
Component: ethdev | Severity: minor | Confidence: confirmed

drivers/net/dpaa2/dpaa2_recycle.c:406 and :469 read through `gur_base` without checking
for NULL. The helper returns NULL when /dev/mem cannot be opened or mapped (:186, :192).

### 56. net/ena: uninitialised metrics copied to xstats on admin failure
Component: ethdev | Severity: minor | Confidence: confirmed

`ena_xstats_get()` declares `metrics_stats[]` uninitialised
(drivers/net/ena/ena_ethdev.c:3677). `ena_copy_customer_metrics()` returns without filling
it on a count mismatch (:3454) or admin command failure (:3465). The loop at :3697 then
copies stack contents into the xstats values.

### 57. net/octeon_ep: rsp read after failed mbox send
Component: ethdev | Severity: minor | Confidence: single pass

`otx_ep_mbox_version_check()` (drivers/net/octeon_ep/otx_ep_mbox.c:343) reads
`rsp.s_version.version` when the send returned an error and `rsp` was not written. The
value ends up in `otx_ep->mbox_neg_ver`.

### 58. net: uninitialised values read without effect
Component: ethdev | Severity: trivial | Confidence: single pass

- drivers/net/mlx5/mlx5_rx.c:1252: `skip_cnt` not initialised in the out-of-order burst
  (the other two callers use `= 0`).
- drivers/net/cxgbe/cxgbe_ethdev.c:616: uninitialised `dev_info` passed to
  `cxgbe_dev_info_get()`, which does `dev_capa &=` (:133).
- drivers/net/hinic3/base/hinic3_nic_cfg.c:701: `port_stats` sent to firmware and logged
  with only `port_id` set.

---

## drivers/bus, common, crypto, compress, raw, baseband

### 59. bus/fslmc: double close of VFIO container fd
Component: other | Severity: normal | Confidence: confirmed

`fslmc_vfio_check_extensions()` closes `vfio_container_fd` on ioctl failure
(drivers/bus/fslmc/fslmc_vfio.c:483). The caller closes it again at :544.

### 60. bus/fslmc: ioctl on uninitialised fd in vfio_map_mcp_obj()
Component: other | Severity: normal | Confidence: confirmed

drivers/bus/fslmc/fslmc_vfio.c:1325 ignores the return of `fslmc_vfio_setup_device()`,
which can fail before writing `mc_fd`. :1328 then calls `ioctl(mc_fd, ...)`.

### 61. crypto/ccp: rte_pktmbuf_append() not checked
Component: cryptodev | Severity: major | Confidence: confirmed

`ccp_perform_aes_cmac()` (drivers/crypto/ccp/ccp_crypto.c:2034) appends
`session->auth.ctx_len` bytes and uses the result unchecked; :2120-2124 then write to
`append_ptr + CCP_SB_BYTES`. The appends at :1575, :1744 and :2375 are also unchecked.

### 62. crypto/ccp: memzone reserve result not checked in ccp_add_device()
Component: cryptodev | Severity: minor | Confidence: confirmed

drivers/crypto/ccp/ccp_dev.c:547 `ccp_queue_dma_zone_reserve()` can return NULL; :549-551
dereference `q_mz`.

### 63. crypto/cnxk: memcpy from NULL IV with unaligned offset and no IV
Component: cryptodev | Severity: normal | Confidence: confirmed

In `cpt_sm_prep()` (drivers/crypto/cnxk/cnxk_se.h:1213) `iv_len` is 0 when there is no IV,
so `src` stays NULL (:1259). The SG path passes `iv_len + pad_len` as the IV length
(:1265, :1269), and `sg_inst_prep()`/`sg2_inst_prep()` (:317, :556) memcpy that many bytes
from NULL when `pad_len` is non-zero (SM4-ECB, cipher offset not a multiple of 8).

### 64. crypto/mlx5: GCM qp setup error path releases an unassigned queue pair
Component: cryptodev | Severity: normal | Confidence: confirmed

`mlx5_crypto_gcm_qp_setup()` goes to `err:` and calls `mlx5_crypto_gcm_qp_release(dev,
qp_id)` (drivers/crypto/mlx5/mlx5_crypto_gcm.c:433). That function reads
`dev->data->queue_pairs[qp_id]` (:222), which is only assigned on success (:427). The new
`qp` leaks and the old slot (NULL or stale) is dereferenced.

### 65. crypto/caam_jr: unchecked allocation in init_job_ring()
Component: cryptodev | Severity: minor | Confidence: single pass

drivers/crypto/caam_jr/caam_jr.c:2197 and :2202 pass the `caam_jr_dma_mem_alloc()` result
to `memset()` unchecked (:2199, :2204).

### 66. crypto/cnxk: uninitialised index in tls13_trim_mac
Component: cryptodev | Severity: trivial | Confidence: single pass

drivers/crypto/cnxk/cn10k_cryptodev_ops.c:1041 and cn20k_cryptodev_ops.c:803 compute
`len_to_trim = mbuf->pkt_len - i` with `i` uninitialised when `res->rlen == 0`. The result
is unused in that case.

### 67. compress/octeontx: wrong mempool freed in zip_pmd_config()
Component: other | Severity: normal | Confidence: confirmed

drivers/compress/octeontx/otx_zip_pmd.c:255 calls `rte_mempool_free(vf->zip_mp)` when the
SG pool cannot be created. `vf->zip_mp` is not assigned until :258, so the new
`zip_buf_mp` leaks and a pool from an earlier configure may be freed while in use.

### 68. baseband/la12xx: resources leaked on IPC metadata size mismatch
Component: other | Severity: minor | Confidence: single pass

`setup_la12xx_dev()` (drivers/baseband/la12xx/bbdev_la12xx.c:891) returns
`IPC_MD_SZ_MISS_MATCH` directly, bypassing `err:`; allocations, fds and mappings leak.

### 69. bus/dpaa: fman leaked on _fman_init() failure
Component: other | Severity: minor | Confidence: single pass

drivers/bus/dpaa/base/fman/fman.c:60 allocates `fman`; the early returns (:68-:116) do not
free it or unmap.

### 70. common/qat: session leaked in qat_cq_get_fw_cipher_crc_cap()
Component: cryptodev | Severity: minor | Confidence: single pass

drivers/common/qat/qat_qp.c:844-846 returns -EINVAL without freeing `session`; :879-881
also leaks `src_data_addr`.

### 71. raw/cnxk_gpio: list leaked on invalid allowlist
Component: other | Severity: minor | Confidence: single pass

`cnxk_gpio_parse_allowlist()` (drivers/raw/cnxk_gpio/cnxk_gpio.c:254) allocates `list`;
:266-267 returns -EINVAL without freeing it.

### 72. raw/ifpga: leaks in altera_i2c_probe() and max10_parse_sensor_data()
Component: other | Severity: minor | Confidence: single pass

drivers/raw/ifpga/base/opae_i2c.c:472 `dev` leaked at :478 and :496.
drivers/raw/ifpga/base/opae_intel_max10.c:1358 `sensor` leaked by the `continue` at :1367
and the `break`s at :1378-:1399, all before it is inserted in the list (:1403).

### 73. raw/ifpga: feature address lookups not checked
Component: other | Severity: minor | Confidence: confirmed

`fpga_get_pr_uuid()` (drivers/raw/ifpga/base/ifpga_feature_dev.c:99) and
`port_clear_error()` (:197) read through the result of
`get_*_feature_ioaddr_by_index()` without a NULL check. The helper returns NULL when the
PR_MGMT or port ERROR feature is absent.

### 74. raw/ntb: leak and unchecked allocation in ntb_xstats_get_by_name()
Component: other | Severity: minor | Confidence: confirmed

drivers/raw/ntb/ntb.c:1240 allocates `xstats_names` without a NULL check (used at :1256);
:1270 returns -EINVAL for an unknown name without freeing it.

### 75. bus/platform: resource name leaked when mapping fails
Component: other | Severity: minor | Confidence: single pass

drivers/bus/platform/platform.c:299 stores the name in `pdev->resource[i].name`. If
`device_map_resource_offset()` fails (:301-304) the code jumps out before
`num_resource++`, so the cleanup loop (:178) does not free that name.

### 76. event/opdl: unchecked malloc in opdl_selftest()
Component: eventdev | Severity: trivial | Confidence: single pass

drivers/event/opdl/opdl_test.c:988 `malloc()` result used at :1027 without a check.

---

## app

### 77. app/test-compress-perf: double free of ops in cyclecount test
Component: other | Severity: normal | Confidence: confirmed

`cperf_cyclecount_op_setup()` frees `ops` at its `end:` label
(app/test-compress-perf/comp_perf_test_cyclecount.c:147). The caller `main_loop()` then
frees it again at :460.

### 78. app/test-regex: double free of rules, and uninitialised file names
Component: other | Severity: normal | Confidence: confirmed (double free), single pass (file names)

`read_file()` frees `*buf` on error (app/test-regex/main.c:222) and leaves it set;
`init_port()` frees `rules` again at :310. Separately, `rules_file` (:726) and `data_file`
are only written by their options and are passed to `fopen()` uninitialised if omitted.

### 79. app/proc-info: --collectd-format given twice closes stdout twice
Component: other | Severity: trivial | Confidence: confirmed

`proc_info_preparse_args()` (app/proc-info/main.c:394-396) does `dup(STDOUT_FILENO);
close(STDOUT_FILENO);` each time the option appears.

### 80. app/test-crypto-perf: NULL dereference in outbound IPsec ops setup
Component: other | Severity: minor | Confidence: single pass

`cperf_set_ops_security_ipsec()` (app/test-crypto-perf/cperf_ops.c:412) resets the source
mbuf, which sets `next = NULL`. If tailroom is below `digest_sz`, :425-429 does
`m = m->next; m->next = NULL;`. Depends on `--segment-sz`.

### 81. app/test-eventdev: src/dst never freed in dma_adapter_enq_op_fwd()
Component: other | Severity: minor | Confidence: single pass

app/test-eventdev/test_perf_common.c:592-593 allocate `src` and `dst`; they are only freed
on the allocation-failure branch.

### 82. app/graph: node_patterns and pcap_filename never freed
Component: other | Severity: trivial | Confidence: single pass

app/graph/l2fwd.c:34, :46 and app/graph/l3fwd.c:76, :90 allocate `node_patterns` and
`strdup()` the pcap file name. `rte_graph_create()` copies both; neither is freed.

### 83. app/test-dma-perf: unchecked malloc in parse_lcore()
Component: other | Severity: trivial | Confidence: single pass

app/test-dma-perf/main.c:190 `malloc()` result passed to `strlcpy()` at :191.

### 84. app/test-fib, app/test-flow-perf: allocations not freed
Component: other | Severity: trivial | Confidence: single pass

app/test-fib/main.c `run_v6()`: `lpm` (:1099) and `fib` (:1057) not freed on the error
return at :1131 or at the end (:1193). app/test-flow-perf/main.c:1865 `old` not freed.

### 85. test/cryptodev: mbuf allocations used without NULL check
Component: other | Severity: minor | Confidence: single pass (group judged from sampled sites)

app/test/test_cryptodev.c uses `rte_pktmbuf_alloc()` / `setup_test_string()` results
without a check at about 25 sites, e.g. :3626, :3719, :3808, :3899, :4126, :4588, :4682,
:5143, :5344, :5592, :6009, :6560, :6831, :6971, :9771, :17227, :19987, :20060, and via
`rte_pktmbuf_append()` at :2845, :4904, :4912, :9766. `create_segmented_mbuf()` NULL is
dereferenced in `pktmbuf_write()` (:6691). Also `sessions` (:14798), and
test_cryptodev_blockcipher.c:1344.

### 86. test: unchecked allocations in other unit tests
Component: other | Severity: trivial | Confidence: single pass

app/test/test_dmadev.c:308, test_dmadev_api.c:885, test_graph_perf.c:637,
test_thash_perf.c:96.

### 87. test: objects leaked when a test fails part way
Component: other | Severity: trivial | Confidence: single pass (group judged from sampled sites)

A failing assert or `return -1` skips the free in: test_bitmap.c:215; test_bitset.c:538-575
and `test_shift`; test_bpf.c:2148, :3962, :5155; test_event_eth_rx_adapter.c:922;
test_fib.c:557; test_fib6.c:585, :1179, :1275; test_fib6_perf.c:165; test_hash_perf.c:724;
test_lpm.c:1092, :1343, :1439; test_lpm6.c:157, :332, :370, :1530; test_malloc.c:256, :371,
:789; test_member.c:168; test_pdump.c:123; test_rcu_qsbr.c:928, :1092;
test_rcu_qsbr_perf.c:280, :380.

### 88. test: uninitialised stack data used in unit tests
Component: other | Severity: trivial | Confidence: single pass

- app/test/test_bitset.c:643-661: `bitset_a`/`bitset_b` declared but not initialised
  before `rte_bitset_assign()`.
- app/test/test_event_eth_tx_adapter.c:494: `rte_pktmbuf_reset()` on uninitialised stack
  mbufs.
- app/test/test_stack.c:524: `obj_table[]` pushed uninitialised.

---

## Not written up

Valid by the analyzer's definition but with no effect; listed in analyzer-triage.md section 5:
- `memcpy()` with a NULL pointer and length 0: drivers/crypto/cnxk/cnxk_ae.h:1242, :1381;
  drivers/crypto/caam_jr/caam_jr.c:1564-1613; drivers/net/nbl/nbl_hw/nbl_channel.c:737;
  drivers/net/netvsc/hn_rndis.c:593.
- lib/bpf/bpf_exec.c:487 (all five registers passed to an external function) and
  lib/telemetry/telemetry_json.h:45 (documented in the header).
- lib/eal/linux/eal_dev.c:207 (needs a duplicated uevent key).

--MP_/lo.Ksc99a5Sv1usFRlA.z8n
Content-Type: text/markdown
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=analyzer-triage.md

# GCC 16 -fanalyzer triage (analyzer.log, tree at 2e2f0d720c)

Build: buildtype=release, -O3, RTE_ASSERT compiled out.
1267 warnings in the log = 708 unique sites = 894 site+caller rows.

| Verdict | Rows |
|---|---|
| Real (path is feasible) | 246 |
| False positive | 631 |
| Unverified | 17 |

Of the 246 real rows, 88 are under app/ (75 in app/test unit tests), and a further
group is harmless (zero-length memcpy with NULL, uninitialised bytes copied but never
used, redundant NULL checks). The rest are the lib/driver bugs below. Several rows
share one root cause.

Coverage:
- 47 rows in the small classes (double-free, use-after-free, fd, infinite-loop,
  overlapping-buffers, deref-before-check): event path and source read for each.
- 847 rows in the bulk classes: triaged by seven separate passes. Non-header rows were
  read individually; repeated patterns (ifpga feature lookups, ring n=1 wrap, failsafe
  ETH(), test_cryptodev allocs, test failure-path leaks) were judged as a group from
  2-4 full paths plus a source check of the rest.
- (v) = the decisive source lines were re-read in a second pass. Items without (v)
  rest on one reading.
- Nothing was compiled or run; no source was changed.

## 1. Double free, bad pointer, wrong data

| Where | Problem |
|---|---|
| drivers/net/bnxt/tf_core/v3/tfc_msg.c:160,176 (v) | `tfc_msg_alloc_dma_buf()` frees `buf->va_addr` when virt2iova fails and leaves it set; the caller's cleanup frees it again. 5 callers. `tfc_msg_idx_tbl_set()` also calls the alloc twice (:647 and :653), leaking the first buffer on every DMA-sized set. |
| drivers/net/nfp/nfpcore/nfp_elf.c:870,275 (v) | `nfp_elf_read_section_headers()` frees `shdrs`/`shdrs_data`/`shdrs_host_endian` on error without clearing them; `nfp_elf_mutable_buf()` then calls `nfp_elf_free()`. Double free on a malformed firmware ELF. |
| drivers/bus/fslmc/fslmc_vfio.c:483,544 (v) | `fslmc_vfio_check_extensions()` closes the container fd on ioctl failure; the caller closes it again. |
| drivers/bus/fslmc/fslmc_vfio.c:1325-1328 (v) | return of `fslmc_vfio_setup_device()` ignored; `ioctl()` on uninitialised `mc_fd`. |
| lib/pipeline/rte_swx_ctl.c:3131,2896 (v) | table entry parser looks the action up globally, not per table; `entry->action_data` is sized for the table (or NULL). An action with larger args writes past it. Control-plane input. |
| lib/pdcp/pdcp_process.c:59,146,167 (v) | `rte_pktmbuf_prepend()` result used unchecked; NULL write when headroom < 8. |
| drivers/crypto/ccp/ccp_crypto.c:2034,2121 (v) | `rte_pktmbuf_append()` unchecked in AES-CMAC; NULL+32 write when tailroom < 64. Same at :1575, :1744, :2375. |
| drivers/net/nfp/nfd3/nfp_nfd3_dp.c:184 (v) | `rte_pktmbuf_prepend()` unchecked on Tx metadata. |
| drivers/net/r8169/r8169_rxtx.c:1568-1571 (v) | append failure is logged, then `memset(NULL, 0, pad_len)`. |
| drivers/net/zxdh/zxdh_common.c:230 (v) | `rte_memcpy(res, ..., tbl_reps->len)` with device-supplied length into a 1-byte caller buffer. |
| drivers/crypto/cnxk/cnxk_se.h:1259,317,556 (v) | SM4-ECB (no IV), SG mode, cipher offset not 8-aligned: memcpy of `pad_len` bytes from NULL `iv_buf`. |
| drivers/crypto/mlx5/mlx5_crypto_gcm.c:433,222 (v) | setup error path calls `qp_release()`, which reads `queue_pairs[qp_id]` (not yet assigned): NULL deref, new qp leaked. |
| drivers/net/bnxt/bnxt_rxtx_vec_sse.c:448,498 (v) | `rxcmp1[]` in `crx_burst_vec_sse()` is never written; `GET_DESC_FIELDS` blends it into `vlan_tci` of every mbuf on the compressed-CQE SSE Rx path. |
| drivers/net/intel/ice/ice_dcf_vf_representor.c:233 (v) | `ice_dcf_vf_repr_hw()` returns NULL once `dcf_valid` is cleared; vlan offload/pvid/tpid ops dereference it. |
| drivers/net/cxgbe/cxgbe_filter.c:179-182 (v) | `WARN_ON(!mbuf)` only logs; NULL deref on pool exhaustion. |
| drivers/compress/octeontx/otx_zip_pmd.c:255 (v) | frees `vf->zip_mp` (old or NULL) instead of the just-created `zip_buf_mp`. |
| drivers/net/cnxk/cnxk_rep_msg.c:338-343 (v) | for 8-byte acks the freshly allocated `adata->u.data` is overwritten by the memcpy (leak); allocation unchecked. |
| drivers/net/intel/cpfl/cpfl_flow_parser.c:1989 | `prog->prog` NULL when a JSON mod rule has a "parameter" content field but no prog action. |
| drivers/net/intel/cpfl/cpfl_representor.c:563,662 (v) | `ret` returned uninitialised when the allowlist loop creates nothing. |
| drivers/net/xsc/xsc_rx.c:231-240 (v) | BAD_IOVA path leaks the buffer and later uses the bad pointer. |
| drivers/crypto/ccp/ccp_dev.c:547-549 (v) | memzone reserve result unchecked. |
| drivers/net/dpaa2/dpaa2_recycle.c:406,469 (v) | `lsx_ccsr_map_region()` NULL (no /dev/mem) dereferenced. |
| drivers/raw/ifpga/base/ifpga_feature_dev.c:99,197 (v) | PR_MGMT / port ERROR feature lookup unchecked (hardware without the feature). |

## 2. Leaks in normal operation

| Where | Problem |
|---|---|
| lib/pipeline/rte_swx_pipeline_spec.c:2893,2210 (v) | `pipeline_spec_free()` memsets `s` but never frees it; leaks on every parse, success or failure. |
| drivers/net/cnxk/cnxk_rep_msg.c:552 (v) | `send_ack_message()` never frees `buffer`. |
| drivers/net/sfc/sfc_tbl_meta_cache.c:137 (v) | `fields` not freed on success. |
| drivers/net/zxdh/zxdh_flow.c:1256,1664 (v) | `flow` allocated when `dh_flow == NULL` (validate) is not freed on the `return 0` paths (:1494, :1831). |
| drivers/net/cxgbe/cxgbe_main.c:688 | `pi->rss` has no matching free anywhere in the driver. |
| drivers/net/mana/mana.c:2189,2236 (v) | secondary-process probe leaks `priv`. |
| drivers/raw/ntb/ntb.c:1240,1270 (v) | `xstats_names` leaked for an unknown name; allocation unchecked. |
| app/test-eventdev/test_perf_common.c:592 | `src`/`dst` never freed. |
| app/graph/l2fwd.c:34,46; l3fwd.c:76,90 | `node_patterns`, `pcap_filename` never freed (one-shot). |

## 3. Leaks on error paths (init/setup failure)

lib:
- lib/pdump/rte_pdump.c:403 (v): BPF filter not destroyed on the later error returns.
- lib/node/kernel_rx.c:214,222 (v): `recv_info` when `socket()` fails.
- lib/graph/graph_stats.c:354: `x = realloc(x, ...)`.
- lib/eal/linux/eal_dev.c:207: duplicate `PCI_SLOT_NAME=` key (theoretical).

drivers:
- bnxt/bnxt_ethdev.c:5043-5097 (ctx_pg_arr / ctx_dma_arr)
- intel/cpfl/cpfl_ethdev.c:2201-2213, 3096-3114; intel/idpf/idpf_ethdev.c:1666-1677
- intel/ice/base/ice_xlt_kb.c:135-148
- ntnic/ntnic_ethdev.c:2326 (p_drv)
- cnxk/cnxk_eswitch_flow.c:395, cnxk_rep.c:398, cnxk_tm.c:306, cnxk_tm.c:394
- failsafe/failsafe_ops.c:461-481 (v), gve/gve_tx_dqo.c:605-619 (v), ionic/ionic_lif.c:~691
- memif/rte_eth_memif.c:169, 1326, 1388, 1774 (v), 1812
- nbl/nbl_hw/nbl_channel.c:943; nbl_channel.c:596-607 (v): mailbox pipe fds not closed when thread create fails
- nfp/nfdk/nfp_nfdk_dp.c:460, nfp/nfp_ethdev.c:2847
- ring/rte_eth_ring.c:548-561, sfc/sfc.c:1435, softnic/rte_eth_softnic_thread.c:69
- vmxnet3/vmxnet3_rxtx.c:1047 (v), 1151; xsc/xsc_dev.c:359
- baseband/la12xx/bbdev_la12xx.c:891, bus/dpaa/base/fman/fman.c:60, common/qat/qat_qp.c:844,879
- raw/cnxk_gpio/cnxk_gpio.c:254-267, raw/ifpga/base/opae_i2c.c:472, opae_intel_max10.c:1358
- bus/platform/platform.c:301 (next to the flagged line: `name[i]` not freed)

## 4. Unchecked allocation (crash on malloc failure)

nfp/nfpcore/nfp_nsp.c:551, xsc/xsc_ethdev.c:546, cnxk/cnxk_rep_msg.c:391,419,451,613,
cnxk/cnxk_rep_flow.c:213,223, intel/idpf/idpf_common_virtchnl.c:439,
ntnic/nthw/flow_api/flow_id_table.c:68, ntnic/nthw/model/nthw_fpga_model.c (5 `*_new`),
crypto/caam_jr/caam_jr.c:2197,2202, event/opdl/opdl_test.c:988, app/test-dma-perf/main.c:190

## 5. Real but harmless

- lib/eventdev/rte_event_eth_rx_adapter.c:2961 (v): `rxa_sw_vector_limits()` leaves `log2_sz` unset (returned to the caller and traced).
- lib/compressdev/rte_compressdev.c:59: NULL capabilities if a PMD has no `dev_infos_get` (none in tree).
- lib/eal/common/eal_common_dev.c:405: `local_dev_remove(NULL)` on a narrow rollback path.
- net/ena/ena_ethdev.c:3677 (v): `metrics_stats[]` copied to xstats uninitialised when the admin command fails.
- net/octeon_ep/otx_ep_mbox.c:343: `rsp` read after a failed send.
- net/mlx5/mlx5_rx.c:1252, net/cxgbe/cxgbe_ethdev.c:616, intel/ixgbe/ixgbe_ethdev.c:5322, ixgbe_e610.c:240,395, hinic3_nic_cfg.c:701, cn10k/cn20k tls13_trim_mac: uninitialised value read, result unused.
- memcpy(NULL, x, 0) or memcpy(x, NULL, 0): crypto/cnxk/cnxk_ae.h:1242,1381 (12 rows), caam_jr.c:1564-1613, nbl_channel.c:737, netvsc/hn_rndis.c:593.
- lib/bpf/bpf_exec.c:487 (reg[5] passed to xsym), lib/telemetry/telemetry_json.h:45 (documented).
- net/bnxt/bnxt_ethdev.c:5196, net/ntnic/ntnic_ethdev.c:2688: redundant NULL check after dereference.
- app/proc-info/main.c:395 (v): `--collectd-format` given twice dups/closes a closed fd.

## 6. Test code and tools

- app/test-compress-perf/comp_perf_test_cyclecount.c:147,460 (v): `ops` freed in `cperf_cyclecount_op_setup()` and again in `main_loop()`.
- app/test-regex/main.c:222,310 (v): `read_file()` frees `*buf`, `init_port()` frees it again; :726 `rules_file` used uninitialised without `--rules`.
- app/test-crypto-perf/cperf_ops.c:429: `m->next` NULL after `rte_pktmbuf_reset()` (option dependent).
- app/test-fib/main.c:1131,1193, app/test-flow-perf/main.c:1865: leaks at exit.
- app/test/test_cryptodev.c: ~25 sites with unchecked `rte_pktmbuf_alloc()`; test_dmadev.c:308; 5 other unchecked allocs.
- app/test: 33 leaks on a test's failure-return path (test_bitset, test_lpm, test_lpm6, test_fib6, test_bpf, test_malloc, test_rcu_qsbr, ...).
- app/test: uninitialised reads in test_bitset.c:643, test_event_eth_tx_adapter.c:494, test_stack.c:524 (benign).

## 7. False-positive patterns (634 rows)

| Pattern | Rows (approx.) |
|---|---|
| ifpga: feature ops looking up their own feature, list invariant not visible | 96 |
| Pointer stored in a long-lived struct (`dev->data->mac_addrs`, queue arrays, lists, registries) reported as a leak | ~95 |
| rte_ring: n=1 enqueue/dequeue taking the wrap branch (`idx = head & mask` not related to `size`); rcu_qsbr `alloca(esize)` allocation-size | ~75 |
| Same condition assumed true and false on one path; invariants guarded by other code | ~120 |
| failsafe `ETH(sdev)` NULL (sub-device state guards) | 19 |
| intel common flow engine: `actions[0]` / engine ref non-NULL by construction | 19 |
| cnxk/cpt crypto session-type invariants | ~25 |
| Loop bound clamped at assignment (bnxt num_leds, tfc num_lvl, hugepage sizes, ...) | ~25 |
| LIST/TAILQ remove-then-free loops reported as double-free / use-after-free (eal_alarm, swx_ctl, vdev_netvsc, xsc, mlx5) | 12 |
| Busy-wait loops on hardware/atomic state reported as infinite loops | 10 |
| Negative tests and deliberately dropped handles in app/test | ~20 |
| `rte_flow_error_set()` / external helper assumed to return 0 | ~10 |
| Other one-offs | remainder |

Checked individually among these: lib/eal/linux/eal_alarm.c:110,225, lib/pipeline/rte_swx_ctl.c:292-294,
lib/graph/graph_stats.c:202,211, drivers/bus/pci/linux/pci_uio.c:339, virtio_user/vhost_kernel.c:432,
app/test-pmd/cmdline.c:9614, bonding rte_eth_bond_8023ad.c:358, the three `shuffle_input_keys()` memcpy
warnings (`swap_idx = rand % i` is never `i`), nbl_dev.c:210.

## 8. Unverified (17 rows)

- drivers/net/zxdh/zxdh_np.c:325,4801-4831 (5 rows): SDT parser writes a HASH/ETCAM-sized struct into a 20-byte ERAM struct if the sdt_no type differs; sdt_no sources not traced.
- drivers/net/zxdh/zxdh_ethdev.c:751: `hdr_mz` NULL if a Tx queue has 0 descriptors.
- drivers/net/pfe/pfe_hif_lib.c:445: `first_mbuf` NULL if a call starts mid-packet.
- drivers/net/enetfec/enet_rxtx.c:123: `rte_pktmbuf_adj()` NULL on a very short frame.
- drivers/net/bnxt/bnxt_hwrm.c:6207,6244,6301: `buf` leaked if `HWRM_PREP` returns early; needs `hwrm_cmd_resp_addr == NULL`.
- drivers/net/bnxt/tf_ulp/ulp_mapper.c:4060: cond list NULL for an out-of-range template index.
- drivers/bus/dpaa/base/qbman/qman.c:951: `fq` NULL guarded only by `DPAA_BUG_ON` (compiled out).
- app/test-crypto-perf/cperf_ops.c:491; app/test/test_graph_feature_arc.c:327,1278,1290.

## 9. Noticed in passing (not analyzer findings, not verified)

- lib/vhost/vhost_crypto.c:857: `*cur_desc = desc + 1` can point one past the last descriptor.
- lib/vhost/vduse.c:213-218: two `rte_malloc_socket()` results unchecked.
- drivers/net/softnic/rte_eth_softnic_thread.c: free loop covers workers only, init covers all lcores.
- drivers/net/mlx5/mlx5_hws_cnt.h:346-350: ring reservation size guarded only by MLX5_ASSERT.
- app/test/test_malloc.c:519-522: `ptr3` leaked when the second realloc fails.

--MP_/lo.Ksc99a5Sv1usFRlA.z8n--
