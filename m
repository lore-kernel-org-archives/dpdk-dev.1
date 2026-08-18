Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337EFC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 14:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE0E4027C;
	Tue, 18 Aug 2026 16:22:52 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id C7B4D40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 16:22:51 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so3622670a91.3
 for <dev@dpdk.org>; Tue, 18 Aug 2026 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787062971;
 x=1787667771; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oDZyZQqxaZDDyRW4pjfOyBNDSX8rFO1EhnWy1IzVkf0=;
 b=s5+Ztcj5GCeefYqmHwUG0jclXb0AAsqFvEvhwNP8zGSc3kXTx62emccXB+GQZzeyRd
 yI6Lmkxyksej46E+IdhSw09xg8x3m++IIuqBIB9GvZVBeUTU2VgmZAYoVI7DVJO1C/08
 p8Q6JY2Gcr7/OkMK8H4NG2ZHXJhdATWar7UOfWbjrZj30Mvdb9KjgpNKMD7G17WDnOe6
 i5kxMS7nMO59lByyhML39LXlnQqLaX9CLt2Ve0fcmHm0vCuAAJY71ZmuH/jRZtVz37Na
 Qa8WtuTeo2MuaKXpS8qIQah9BRW6RYUcev2KgK+3Rgz7Rx9J14YhKY4Y5IBEEmBN5gWU
 8lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062971; x=1787667771;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oDZyZQqxaZDDyRW4pjfOyBNDSX8rFO1EhnWy1IzVkf0=;
 b=JEFFoxyEtq8DlyxLxqOL7DkjNrQz2gtk70MIsyGjrqnCzstU+VqSKtvoTBKeHPfenH
 PoeYZYVmPwj7vGP2VUc26URvcAFST/AbIlQKy4b40DfbDe0lTreDnyYYq6q39eDpG1/e
 E5n0+9rkt4y3i5eJhnsYn/9r71ZwxrHHyYe/CCQWJ8oKyRtOHUADnkKFT4OcWHaQ5GsW
 2woojKGsLzGZmklmOUkpyIK1rHk+2fZItsUKAsiU1whzK4AuFiEgdirXgLhwjNFiQjnK
 2YRILVlUpPVoMDMRcl12orLwDlRFIch5WPCFEDT/mUtUQ0XAdQgqxlvr6VWL8pKXvkgB
 YhvA==
X-Gm-Message-State: AOJu0Yyjnz8/w3x7DJJi+vu82YZ8jYEMWBDBy7pG3xJEgs/ivFecCg0r
 9zY3BHd3fZzKg8gzXw6rP8B5DMIbVm6tp9JFyQa+kWNtFqiXT/vLeuaXvrL85NMlI87wciDIZ0c
 W7QqL
X-Gm-Gg: AR+sD11yjCXUEe/NE5yyH5jVrjWRLWqFRxl6IjXBd0MgnNPnbwpf4xNOYJawxGwPTIQ
 7mHD5C8+ENqAFt92p07au769aqKrCpowFUNww9MjeZT/cWYc/NYlDNvPcJ9pRUnOB11Hmu1ALTJ
 9778jJ0w8EMR0u/1k+BQvYdqGT+UYCC0SQMwblBu5AoWjf6q1Q6J/jv/ygAJS7sPrW9WOHgAwwR
 iXqUM50Dmt/jbzZV1yOBO+feOJ3PHctSM55q38j1fEyWOIOTVLMvmL2Rvh/3Q4+queZ1Yvy4zVZ
 ujouQAf3bpcq9tkwr/yVCYug+oJa0mDnOwLQoDMTwy1giMtMjhBgzi/UYhM1jyBaaeyIYMHQXbj
 wXoImlqgDX7Z4CO0mEl6SrdJDCuCtGbJ6yaelSQr7mOHS/UzfZdA++dUTBvTktmPlxVgGLMRwE2
 pgryCS+BcDqWYHjppJeHLFNdS16i8ACi11T9OhUN34jooDJST/dVztp6P2xvBBkWFDIgp4rnooN
 btMjLL2hNFt6F3154mO2gaCR1pDP36aMmPvYDCP
X-Received: by 2002:a17:90a:6c96:b0:395:4de4:92c8 with SMTP id
 98e67ed59e1d1-3954de49a7bmr10147355a91.15.1787062970390; 
 Tue, 18 Aug 2026 07:22:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415305e48esm18555894c88.5.2026.08.18.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:22:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:22:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/13] net/sxe2: fix bugs
Message-ID: <20260818072241.76f604a2@phoenix.local>
In-Reply-To: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 18 Aug 2026 10:15:05 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Jie Liu (13):
>   net/sxe2: add Rx queue buffer split fill support
>   net/sxe2: update switchdev repr VSI ID display format
>   net/sxe2: add ACL engine event statistics support
>   net/sxe2: enhance device cap and res management
>   net/sxe2: improve representor device initialization
>   net/sxe2: refactor flow tunnel port handling
>   net/sxe2: validate IPsec key length against maximum limit
>   net/sxe2: enhance repr event handling and  MP code
>   net/sxe2: optimize vectorized Tx/Rx path
>   common/sxe2: allow munmap during kernel reset
>   net/sxe2: clean up duplicate function declarations
>   net/sxe2: clean up structure definitions
>   doc/sxe2: add acl-stat-type parameter documentation

Still see lots of errors in AI review. Please fix and resubmit.
In this case, since sxe2 is not in a previous stable release
it is correct to not put stable@dpdk.org in. But it would help
future developers if you added Fixes: tag if you know which
commit introduced the problem.

You should be sending each submission with a different version.
(i.e next should be v3).


# net/sxe2 v1 (13 patches) review notes

## Series-level

1. **Bug fixes buried in feature patches.** There are at least eight of them
   (list below). Each should be its own patch. A `Fixes:` tag would help even
   though sxe2 is not in 25.11, so nothing here is stable material.

   Fixes hiding in feature patches:
   - 03: `SXE2_PCI_DEVICE_ID_VF_1` 0x10b -> 0x10b2 (VF never binds today)
   - 04: `reg_width` 10 -> 0x10 for `SXE2_PCI_MAP_RES_IRQ_MSIX`
   - 04: duplicate `sxe2_switchdev_uninit()` / `sxe2_dev_pci_map_uinit()` in `dev_close`
   - 06: `sxe2_flow_check_rss_action_attr()` fell through and returned 0 after
     setting an error, so unsupported RSS attrs were silently accepted
   - 07: `dev->security_ctx` left dangling after free
   - 09: `rx_free_thresh == 0` not defaulted
   - 09: `other_vsi_list` not TAILQ_INIT'd before `sxe2_main_vsi_create()`
   - 09: NEON Rx DD count used `popcount` instead of "count up to first hole"

2. **Commit messages.** Patches 03, 04, 05, 06, 08, 09, 10 have a bulleted list
   of unrelated changes as the message. That is the signal the patch should be
   several patches. One logical change per patch, and the message says what the
   symptom was and what the fix is, not a changelog of every hunk.

3. **Message/diff mismatches:**
   - 08 says "Change error return from EINVAL to ENODATA"; the code returns `-ENOENT`.
   - 08 describes removing the `qstats` parameter from `sxe2_mp_req_get_stats`;
     no such change is in the diff.
   - 11 lists `sxe2_drv_mac_link_status_get` as removed; the diff keeps it.
   - 13 says it adds `acl-stat-type` docs; it also deletes the entire
     `drv-sw-stats` section (see below).

4. No cover letter in the bundle. Please send a 00/13 describing the series
   intent, since it mixes new features (ACL stats, buffer split), refactors and
   fixes.

---

## 01/13 net/sxe2: add Rx queue buffer split fill support

The subject covers roughly 20 lines of the diff. The rest is log message
typo fixes, an unrelated `sxe2_link_update()` call, `{}` -> `{0}`, error path
changes in `sxe2_drv_udp_tunnel_get()` and `sxe2_drv_flow_filter_add()`.
Split.

- Removing the `opc_str` argument drops the only debug print of the command
  opcode. If that log is unwanted, say so; do not delete it as a side effect
  of adding buffer split.

- `sxe2_rxq_buf_split_fill()` re-tests
  `rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT`, which the caller already
  tested. The `else` branch is dead. Drop the test in the helper and keep the
  zeroing in the caller.

- `ret = -1` on failure. Use a negative errno (`-ENOTSUP` for the unsupported
  protocol case, `-EINVAL` for unconfigured).

- L3 matching only accepts `RTE_PTYPE_L3_IPV4_EXT_UNKNOWN` /
  `RTE_PTYPE_L3_IPV6_EXT_UNKNOWN`. An application that sets plain
  `RTE_PTYPE_L3_IPV4` falls through to the L2 test and then errors out.
  Is that intended? `sxe2_buffer_split_supported_hdr_ptypes_get()` should
  agree with what this function accepts.

- `ctxt->hdr_len = SXE2_RX_HDR_SIZE;` is repeated in every case. Set it once
  after the switch chain. Also, why is the header length fixed at 256 bytes
  regardless of which layer the split is at?

- Only `rx_seg[0].proto_hdr` is examined. What happens with `nseg > 1`?

- `goto l_end` is being used as a `break` out of a switch. Restructure so the
  helper computes `split_type_mask` and returns.

- `(void)sxe2_link_update(dev, 0)` inside `sxe2_drv_mac_link_status_get()`:
  this puts an ethdev-layer call inside the command channel layer, gives every
  caller (including the interrupt handler) the side effect of publishing link
  state, and reaches into `rte_eth_devices[]` directly. It is also only correct
  in combination with 08/13, which removes the now duplicate call in
  `sxe2_link_update_init()`. Those two hunks belong in one patch, and the
  layering should be the other way round: the caller calls `sxe2_link_update()`.

## 02/13 net/sxe2: update switchdev repr VSI ID display

This is a struct field rename across four files, not a display change. Subject
should say so.

The new names lose information. `repr_vf_k_vsi_id` is fed from `kernel_vsi_id`
and `repr_vf_u_vsi_id` from `dpdk_vsi_id`; calling them "primary" and "backup"
hides that, and `sxe2_flow_src_split_proc()` still indexes them by
`SXE2_MAX_DRV_TYPE_KERNEL` / `_DPDK`. Either keep kernel/dpdk in the names or
explain what primary/backup means at the hardware level.

The local buffers in `sxe2_dump_switchdev_info()` are still `k_vsi_buf` /
`u_vsi_buf`.

## 03/13 net/sxe2: add ACL engine event statistics support

Split at minimum into: (a) the `sxe2_fnav_cid_mgr` -> `sxe2_flow_cid_mgr`
rename, (b) ACL stat support, (c) the VF device ID fix, (d) the sxe2_queue.c
change.

- **`SXE2_PCI_DEVICE_ID_VF_1` 0x10b -> 0x10b2** has nothing to do with ACL
  stats and is a user visible bug. Own patch, ideally with a `Fixes:` tag.

- **`sxe2_flow_free_mgr()` can free a list member without removing it.**
  When `engine_type` is neither ACL nor FNAV, both branches are skipped, so
  `TAILQ_REMOVE()` never runs, but the code below still does `rte_free(mgr)`.
  That leaves a freed pointer on whichever list the mgr came from. Add an
  `else` that errors out, or derive `cid_mgr_list` once and remove
  unconditionally.

- Same shape in `sxe2_flow_get_filter_cid()` and `sxe2_flow_query_mgr()`: the
  unknown engine case in `get_filter_cid` does `goto l_end` with `ret == 0`, so
  the caller sees success and no counter was allocated. `query_mgr` at least
  returns `-ENOTSUP`. Be consistent.

- ```
  SXE2_DRV_CMD_FLOW_ACL_STAT_QUERY = SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 1),
  SXE2_DRV_CMD_FLOW_ACL_STAT_ALLOC,
  SXE2_DRV_CMD_FLOW_ACL_STAT_FREE,
  ```
  Every other entry in this enum is written with an explicit `SXE2_MK_DRV_CMD()`.
  Relying on implicit `+1` over an encoded value is fragile. Write
  `SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 2)` and `(..., 3)`.

- `sxe2_drv_flow_acl_get_stat_id()` and `_free_stat()` send
  `sxe2_drv_flow_fnav_*` request structures. If the ACL and FNAV messages are
  the same on the wire, add a comment; otherwise define ACL types.

- `req.is_clear = 1` is hardcoded, so every `rte_flow_query()` clears the
  hardware counter. `struct rte_flow_query_count` has a `reset` field. What
  happens with two readers, or with `reset == 0`? `mgr->hits`/`mgr->bytes`
  accumulate but nothing ever resets them.

- `struct sxe2_drv_acl_query_stat_resp.stat_index` is never read.

- `mgr->stat_index` is `uint16_t` but the firmware returns and consumes
  `uint32_t`. Silent truncation.

- `int32_t ret = -1;` in all three new functions is immediately overwritten.

- The ACL counter default uses `SXE2_FNAV_STAT_ENA_ALL` and
  `sxe2_parse_stat_type()` still range-checks against the FNAV enum. If the
  values are shared, rename the enum; if not, this is a bug.

- `adapter->flow_ctxt.fnav_inited` now gates ACL too, and the sxe2_queue.c hunk
  (`rxq->fnav_enable = true`) is unrelated to ACL statistics. It also introduces
  an ordering dependency on `sxe2_flow_init()` running before
  `sxe2_queues_init()`. Please justify or drop.

- `rte_zmalloc("sxe2_fnav_cid_mgr", ...)`, the "sxe2vf_fnav_cid_mgr" error
  string and "fnav get stats id failed" in `sxe2_flow_create()` are now on the
  shared path.

## 04/13 net/sxe2: enhance device cap and res management

Seven unrelated changes in one patch. This one has to be split before it can
be reviewed properly. Specific problems:

- **`init_rss_err` label moved past `sxe2_security_uinit()`.** After the
  reorder, a failure in RSS init unwinds to `sxe2_intr_uninit()` and never
  calls `sxe2_security_uinit()`, so the security context leaks. The label has
  to stay above the `security_uinit` call.

- **`*no_of_elements = RTE_DIM(ptypes)`** counts the trailing
  `RTE_PTYPE_UNKNOWN` terminator, so callers see one bogus element. Either
  report `RTE_DIM(ptypes) - 1` or drop the terminator from the array.

- **`sxe2_switchdev_repr_match()` PF loop is inverted.** It returns false if
  *any* requested port differs from `pf_num`. With `nb_ports > 1` it can never
  succeed, which contradicts the new multi-port loop in `sxe2_eth_pmd_probe()`
  in this same patch. It should match if the adapter's `pf_num` is among the
  requested ports.

- `port_idx = UINT16_MAX` is dead; the loop overwrites it immediately.

- **`SXE2_PCI_REG_WRITE_WC` -> `SXE2_PCI_REG_WRITE`** in
  `sxe2_pci_map_write_reg()` changes MMIO write semantics with no explanation.
  Why is write combining no longer wanted, and does anything depend on the
  ordering difference?

- `dev_info->nb_rx_queues` / `nb_tx_queues`: `rte_eth_dev_info_get()` already
  fills these from `dev->data` after calling the PMD op. Drop.

- `RTE_ETH_RX_OFFLOAD_RSS_HASH` is added unconditionally while the rest of the
  RSS capability is gated on `SXE2_DEV_CAPS_OFFLOAD_RSS` a few lines below.

- QINQ_STRIP / QINQ_INSERT / VLAN_FILTER are now advertised conditionally on
  `sxe2_dev_port_vlan_check()`. `dev_infos_get()` is supposed to report static
  hardware capability. Making it vary with runtime port VLAN state means an
  application that configured an offload can later see it as unsupported.
  What is the actual constraint here?

- `sxe2_dev_infos_get()` returning `-EINVAL` when `main_vsi == NULL`: how can
  that happen? This looks like it is papering over an init ordering bug.

- `sxe2_dev_pci_map_uinit()` silently drops the `map_ctxt != NULL` test. If
  that test was never needed, remove it in a separate cleanup and say so.

- `sxe2_eth_pmd_probe()` calls `sxe2_eth_pmd_remove(cdev)` on failure. The bus
  layer also calls remove when probe fails. Confirm that is not a double
  teardown.

- `SXE2_PCI_REG_WRITE` / `SXE2_PCI_REG_READ` moved to sxe2_ethdev.h while
  `SXE2_PCI_REG_WRITE_WC*` stays in sxe2_queue.h. Keep the family together.

- `reg_width` 10 -> 0x10: separate fix, `Fixes:`.

- The duplicate `sxe2_switchdev_uninit()` and `sxe2_dev_pci_map_uinit()` calls
  removed from `sxe2_dev_close()` are a double free fix. Separate patch,
  a `Fixes:` tag, and describe the crash.

- `sxe2_dev_close()` and the `sxe2_dev_init()` unwind path are still not
  mirror images of each other (switchdev/eth ordering differs). Worth making
  them match.

## 05/13 net/sxe2: improve representor device initialization

- `sxe2_stats_init()` is added with no matching uninit anywhere in the
  representor teardown path. If it allocates, that is a leak on port close.

- The struct member realignment is unrelated churn. Drop it or make it its own
  patch.

- `l_init_irq_ctxt_err` is entered when `sxe2_stats_init()` fails, but
  `l_init_sw_err` / `l_init_eth_err` are named after the step that failed.
  Rename to `l_init_stats_err` for consistency.

- `snprintf(name, sizeof(name), "%s_representor_%s%u", ..., "vf", ...)`:
  put `vf` in the format string. Also, `cdev->dev->name` is variable length and
  truncation is not detected; check the return against `sizeof(name)`.

## 06/13 net/sxe2: refactor flow tunnel port handling

- **The new PF_BOND block is dead code.** The two pre-existing lines
  immediately after it unconditionally overwrite index 0:

  ```
  flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] = adapter->vsi_ctxt.dpdk_vsi_id;
  flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] = adapter->vsi_ctxt.kernel_vsi_id;
  ```

  so bond member 0 is clobbered and the new `else` branch is redundant with
  them. Delete those two lines.

- **`bond_member_cnt` is never assigned anywhere in the series.** It is zero,
  so `flow_bond_num = 0` and the loop body never executes. Either the
  assignment is missing from the series or the whole PF_BOND block should be
  dropped until it is complete.

- No bound check on `flow_bond_num` against the `flow_src_vsi` array
  dimensions. That value comes from the device.

- **`sxe2_flow_check_rss_action_attr()`**: adding the `goto l_end` after each
  `rte_flow_error_set()` is a real bug fix. Today the function sets an error
  and then returns 0, so an unsupported `level`, `key_len` or `queue_num` is
  accepted. Separate patch, ideally with a `Fixes:` tag. Also fix the doubled space
  and grammar in "RSS  level is could not be greater than 2".

- The `sxe2_flow_meta_proc()` restructure (`else if` -> nested `if/else`) is
  identical in behaviour and adds a level of indentation. Drop it.

- The function moves from sxe2_flow_parse_pattern.c to sxe2_flow.c are a pure
  code move. Put them in their own patch so the diff can be verified as a move.

## 07/13 net/sxe2: validate IPsec key length against maximum

- The sxe2_security.c hunk (`dev->security_ctx = NULL`) is a separate use
  after free fix and is not mentioned in the commit message. Own patch,
  `Fixes:`. While there, the `sctx = NULL;` on the local is dead.

- `sxe2_security_valid_key()` already takes `max_key`. What is the relationship
  between `max_key` and `SXE2_IPSEC_MAX_KEY_LEN`, and can `max_key` exceed it?
  If yes, the bug is in the caller and that is where it should be fixed.

- The message claims this "prevents potential buffer overflows". If the
  overflow is reachable, this needs a `Fixes:` tag and a note to
  security@dpdk.org before posting. If it is defensive hardening, do not
  describe it as an overflow fix.

- `>` vs `>=`: which is correct depends on whether the destination is
  `key[SXE2_IPSEC_MAX_KEY_LEN]`. Please confirm.

## 08/13 net/sxe2: enhance repr event handling and MP code

Double space in the subject line.

- **Caching `sxe2_mp_mz`.** The lookup is now done once and the result kept
  forever. If the memzone is freed and recreated across a device close/open,
  the cached pointer is stale. What guarantees its lifetime?

- `uint8_t vf_id` against `nb_repr_vf`: if `nb_repr_vf` is wider and can exceed
  255 this loops forever. Use the same type as the counter.

- The new representor LSC loop calls `sxe2_drv_mac_link_status_get()` per
  representor from interrupt context, and with 01/13 applied each of those also
  runs `sxe2_link_update()`. That is N command channel round trips inside the
  interrupt handler on every link change. Consider reading the PF link state
  once and pushing it to the representors.

- `sxe2_rxq_intr_unregister()`: moving `rte_free(irq_ctxt->rxq_event_fd)` inside
  the enclosing `if` leaks the allocation whenever that condition is false,
  unless the condition is exactly `rxq_event_fd != NULL`. Not mentioned in the
  commit message at all.

- `sxe2_mp_do_primary_work()` takes a copy of the message parameter to "avoid
  side effects", but the original was already `const`. Just return `ret` and
  drop `param_copy`.

- 08 removing `(void)sxe2_link_update(dev, 0)` from `sxe2_link_update_init()`
  is only correct with 01/13 applied. Squash the two hunks.

## 09/13 net/sxe2: optimize vectorized Tx/Rx path

This patch is doing at least six things, several of which are correctness
changes to the vector data path that are not mentioned in the commit message.
It needs to be broken up, and the correctness changes need to say what was
broken. Blocking issues:

- **`sxe2_tx_queue_mbufs_release_vec()` now calls `rte_pktmbuf_free_seg()`
  without a NULL check.** `rte_pktmbuf_free_seg()` dereferences its argument;
  it does not tolerate NULL. The only "validation" added is a check on the
  ring pointer, not on individual entries, and `sxe2_tx_queue_reset_vec()`
  memsets the whole ring to zero. Any stop/start cycle, or any hole in
  [next_dd - (rs_thresh-1), next_use), is a NULL dereference. Restore the
  checks.

- **`SXE2_RX_DESC_STATUS_DD_MASK` -> `SXE2_RX_DESC_STATUS_DD_SHIFT`** in
  `sxe2_monitor_callback()`. A shift count is not a mask. This looks like a
  regression, it is unrelated to the vector path, and it is unexplained.

- **Acquire fences removed from the NEON Rx descriptor loads.** The three
  `rte_atomic_thread_fence(rte_memory_order_acquire)` calls between the
  `descs[3]`..`descs[0]` loads are gone. Those barriers are what stops arm64
  from observing a partially DMA written descriptor. If they really are
  redundant given the single remaining fence before the lane reloads, spell
  out the argument in the commit message. Otherwise this is descriptor tearing
  under load.

- **`repr_vf_vsi_id` fallback dropped.** In sxe2_switchdev.c the
  `kernel_vsi_id != SXE2_INVALID_VSI_ID ? kernel : dpdk` selection is replaced
  by an unconditional assignment from the primary (kernel) VSI, so
  `repr_vf_vsi_id` can now be `SXE2_INVALID_VSI_ID`. Functional regression, in
  a patch about vector Tx/Rx, with no mention in the message.

- **NEON Rx ptype lane mapping changed.** Old:
  pkt0<-lane5, pkt1<-lane1, pkt2<-lane7, pkt3<-lane3. New:
  pkt0<-lane1, pkt1<-lane3, pkt2<-lane5, pkt3<-lane7. One of the two is wrong.
  Same for the ptype mask (`0x3FF` -> `SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16`),
  the `umbcast`/`eop` shuffle masks, `rxe_mask` `0x2080` -> `0x20802080`, and
  `eop_mask` gaining the +16 bit. These are correctness fixes to Rx flag and
  ptype parsing. They belong in their own patch with `Fixes:` and a
  description of the wrong behaviour they produce.

- **The DD count rewrite is a real bug fix.** The old `popcount` counted every
  set DD bit in the group, so a pattern like DD,not-DD,DD,DD reported 4 and the
  driver consumed descriptors the hardware had not written. The new
  `rte_ctz64(stat) / 16` stops at the first hole, which is correct. Own patch,
  ideally with a `Fixes:` tag.

- **`vst1q_lane_u32(...)` -> `*(uint32_t *)umbcast_flags = vgetq_lane_u32(...)`.**
  The intrinsic does not require 4 byte alignment; the direct store does. If
  `umbcast_flags` can be unaligned this is undefined behaviour.

- **`sxe2_tx_desc_fill_4_neon_simple()` disagrees with the tail loop.** The
  4-wide body always encodes `MACLEN` from `pkt->l2_len`, but the scalar tail
  calls `sxe2_tx_desc_fill_one_neon(..., false)`. Within one burst, packets get
  different descriptor contents depending on their position in the ring. Also,
  in simple mode the application is not required to set `l2_len`.

- `vst1q_u64_x4()` is not available on all arm64 toolchains DPDK supports.
  Check the minimum GCC/clang requirement.

- **`sxe2_tx_queue_reset_vec()`** memsets `sizeof(struct sxe2_tx_buffer) *
  ring_depth` while every other line in the vec path now uses
  `struct sxe2_tx_buffer_vec`. Which type owns the allocation? State it, and
  use that type consistently, otherwise the next person who shrinks the vec
  allocation gets a heap overflow here.

- `sxe2_tx_queues_vec_prepare()` used to override only `mbufs_release`; it now
  replaces the whole ops table and calls `queue_reset()`. Resetting the
  descriptor ring here is a behaviour change that is not described.

- `sxe2_tx_vec_ops_get()` returns a `struct` by value. Return
  `const struct sxe2_txq_ops *` like `sxe2_default_txq_ops`.

- Deleting `sxe2_tx_bufs_free_vec_avx512()` removes the mempool cache bulk
  free fast path. That is a performance regression in a patch titled
  "optimize". If it was removed because it was wrong (the
  `rte_mempool_ops_enqueue_bulk(mp, (void *)buffer, rs_thresh)` call assumes
  `struct sxe2_tx_buffer_vec` is exactly one pointer, and the `goto normal`
  jumps into scope), say that.

- `dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy` instead of `NULL`:
  is that symbol available to out of tree and in tree PMDs, and what does it
  buy over the NULL fast path in `rte_eth_tx_prepare()`?

- Removing `#ifndef SXE2_TEST` from sxe2_txrx_vec_avx512.c is unexplained.

- `PMD_LOG_DEBUG(TX, "Tx mode flags:0x%016x ...")`: `%016x` on a 32 bit value
  pads to 16 digits. Use `%#010x`.

- Unrelated but welcome fixes to pull out of here: `rx_free_thresh` defaulting,
  `TAILQ_INIT(&other_vsi_list)` before `sxe2_main_vsi_create()`,
  `main_vsi = NULL` after destroy, `sxe2_tx_buffer_ring_free()` NULLing the
  pointer, and the duplicate `sxe2_rx_pkts_scattered` declaration (that last
  one belongs in 11/13).

- `if (ret && ret != -EPERM)` in `sxe2_vsi_uninit()`: why is `-EPERM` expected?
  Add a comment. Note the code then proceeds to drop the VSI list even though
  the firmware side destroy failed.

## 10/13 common/sxe2: allow munmap during kernel reset

Two unrelated changes; the subject only covers one.

- Removing the `kernel_reset` guard from `sxe2_drv_dev_munmap()`: what was the
  guard protecting against, and why is it safe now? "Enable cleanup operations"
  is not an explanation of why unmapping after a kernel reset is safe.

- `cdev` becomes unused. Check whether the `l_end:` label still has a `goto`
  reaching it; if not, that is `-Wunused-label`.

- `sxe2_classes_driver_remove()` returning 0 when `cdrv == NULL` hides a
  probe/remove asymmetry. A NULL `cdrv->remove` is legitimately optional; a
  NULL `cdrv` on a device that was probed is a bug worth logging.

## 11/13 net/sxe2: clean up duplicate function declarations

Fine, with two notes: the commit message lists
`sxe2_drv_mac_link_status_get` but the diff keeps it, and the duplicate
`sxe2_rx_pkts_scattered` declaration removed in 09/13 belongs in this patch.

## 12/13 net/sxe2: clean up structure definitions

These are firmware message structures. Removing `__rte_packed_begin` /
`__rte_packed_end` and `__rte_aligned(4)` changes their size and alignment, and
therefore the wire format:

- `sxe2_tm_res`: dropping `rsv[2]` takes `sizeof()` from 4 to 2.
- `sxe2_rxq_map_info`: alignment goes from 4 to 8, which changes the offset of
  the embedded arrays in `sxe2_queue_map_info` and possibly the size of any
  parent message.
- `sxe2_drv_sfp_req` / `_resp` have flexible array members and are presumably
  sized as `sizeof(req) + data_len` at the call site. Tail padding changes the
  length sent to firmware.

I am not going to take this without either a firmware ABI document confirming
the new layouts, or `static_assert(sizeof(...) == N)` on every message
structure so a future change cannot silently break it. Note that someone
deliberately converted these to the `__rte_packed_begin/_end` form recently;
please explain what is wrong with them now.

## 13/13 doc/sxe2: add acl-stat-type parameter documentation

**This deletes the entire `drv-sw-stats` section** (23 lines removed, 10
added) while the commit message only describes adding `acl-stat-type`. Nothing
in this series removes the `drv-sw-stats` devarg from the driver, so this looks
like a rebase accident that drops documentation for a supported parameter.
Please restore it.

Minor: the new block says both "- 3: Count both packets and bytes (default)."
and "Default value is 3 (count both packets and bytes)." Pick one.

Also, the documentation should land in the same patch as the devarg it
documents (03/13), not eleven patches later.
