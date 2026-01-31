Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA9DD73EB5
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 18:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3645D402AF;
	Sat, 31 Jan 2026 19:18:01 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 8337540274
 for <dev@dpdk.org>; Sat, 31 Jan 2026 19:17:59 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso26280135e9.1
 for <dev@dpdk.org>; Sat, 31 Jan 2026 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769883479;
 x=1770488279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtyHmSzRvpZj2x2ymVm/qq9p7ENRZj4fqdvq3vuyb44=;
 b=AA1HgyY8wXfBwYeZFNu702SYkXxGJLXWrLmP8XmEOW3/AW+gnv/QCGIwKFmu1QGs6I
 XAywI2/ai0m53m0YMpgKU3irF2vJkK2iqWObhBGu9HmGMX5Q2fafBK8qHmEdyr3dM2nx
 yjCeon2zkspsgz8PIKo22EAXEwIxo5Kby9dVW24XGDyM7NzuZxoG0HZqgfeRzvKp56BQ
 lIMzs2YZ3YMfC+v+qnRKKjPDOrlJqA518ZeeFzx/GJlPbsmp6VgHKC5hMBfwwPIrSR0Z
 f5tda08eUJ30mQ8iX68XZvBVt6pyH6QUKKKVHXE1M/XoGpi835+kmgj/2xsqM/CVHkSx
 ZMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769883479; x=1770488279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtyHmSzRvpZj2x2ymVm/qq9p7ENRZj4fqdvq3vuyb44=;
 b=koMDRv+fI8fZH3SXm4maH3aiVafNjLPrNEw5OGoxN3962lx6KXtbGFCjZ/XrF+LnB6
 xRHmg7KlXqMxv7f+xJAkTL1SUTLiFt2x8RqbQbhmidKtHmVq6YyYoefjofa2Yla/OJ2s
 Da5czQpFsTP4+fE/bgIFufbC4dTjJJ/D8MF/FiHVB3IAN5bWHkxUj1GIQJ8Wq8irSk/L
 JyaVn+J1TKr1sCYyItUMDemz63UrwFmLobQdx//WShRias83iz7d7L4SYkl/kr7hUmUq
 miKjhcgqQhsKenEEZ3/odNfb4qYgIcbVYnwDy9g3AV0EuItF8ZCe7DN8cRSWHVR+q0NF
 UlZQ==
X-Gm-Message-State: AOJu0YyCXPL6to8k/5pG+fnvBlEVt+SOsDwjf98+LG/WkgUn3gpaet9R
 hmfMMBRR1BujGXdLpeIAqAR49wfSAmea48lVtZnHQsF5nn/TUowAUnYKh7gPVPYilzlamiJrYlP
 bsdoY
X-Gm-Gg: AZuq6aLOjXvY2T0eNseIUp738k35RToymMUBPvojkGIlPfHzWpaQShOjigfcVyxYoiU
 LoYcXdASm2Nuj2oohAEP862fysiKccGKRRR4vlmqMgFZapDEv1OSYFkVSEog2Zvkk+TZx+F8nSP
 qz09OCdPAQmwI8lXNIpYWu39950TNpg21WdW2QPypHuyF8rK81215jI+O79ZcFBzGgmiAVDhcw7
 erMg9HN1MS4BRg6GbcbZuEgeJP0VgghYNucbrptJmZQ+MqJlanAnFnwqfDsV9KzykK70qHKZkrz
 7MRczvk9q6mnZbLgsqYPI/aVyFrrL6RYjZFsxfmaHrelszAYkYsr73Q9DbdW9ePALBKqPDDRX0y
 QYhLk16+ZiwEiKTbnM9WdgIJ5L/eE64ymDddoQhMwg1t1ttHMycJMKZaqOdYj2GvGJDy7fVWS8D
 K1kO0+48WHbNAbfErwI1zW8SUovbwvPGHlAVXCs2yU9pAne+ac4Q==
X-Received: by 2002:a05:600c:3586:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-482db45237cmr98261815e9.4.1769883478974; 
 Sat, 31 Jan 2026 10:17:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm358320345e9.12.2026.01.31.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 10:17:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [REVIEW] net/hinic3: use different callback func to support htnfdir
Date: Sat, 31 Jan 2026 10:17:54 -0800
Message-ID: <20260131181754.6753-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131100608.12429-8-wff_light@vip.163.com>
References: <20260131100608.12429-8-wff_light@vip.163.com>
Content-Type: text/plain; charset="utf-8"
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

AI-generated review of hinic3.mbox
Reviewed using Claude (claude-opus-4-5-20251101) on 2026-01-31

This is an automated review. Please verify all suggestions.

---

# DPDK Patch Review: net/hinic3 Series

This is a review of a 7-patch series adding support for new SPx series NICs to the hinic3 driver.

---

## Overall Series Issues

### Errors

1. **Multiple patches have compilation issues** - Several patches introduce syntax errors, missing semicolons, and undefined symbols that would prevent compilation.

2. **Missing meson.build updates** - Patches 3-7 add new source directories (`htn_adapt/`, `stn_adapt/`) with their own `meson.build` files, but the main `drivers/net/hinic3/meson.build` is not updated to include these subdirectories.

3. **Inconsistent function naming** - The series introduces functions with inconsistent naming between patches (e.g., `hinic3_cmdq_get_stn_ops()` vs `hinic3_nic_cmdq_get_stn_ops()`).

---

## Patch 1/7: net/hinic3: add support for new SPx series NIC

### Errors

1. **Line 38 (hinic3_csr.h)**: Uppercase `X` in hex literal:
   ```c
   #define HINIC3_DEV_ID_SP230    0X0229
   ```
   Should be lowercase `0x0229`.

2. **Line 48 (hinic3_ethdev.c)**: Undefined symbol `HINIC3_DEV_ID_VF_SP920` - this macro is not defined in the header file, only `HINIC3_DEV_ID_920` is defined.

### Warnings

1. **Commit message**: "suuport" should be "support" (typo).

2. **Alignment inconsistencies** in `hinic3_cmd.h` - the alignment changes are inconsistent (some use tabs, some use spaces to different column positions).

---

## Patch 2/7: net/hinic3: add enhance cmdq support for new SPx series NIC

### Errors

1. **Line 85 (hinic3_cmdq_enhance.c)**: Missing `RTE_UNUSED` or parameter `nic_dev` is unused in `prepare_rss_indir_table_cmd_header`.

2. **Line 169 (hinic3_cmdq_enhance.h)**: Missing space before closing comment:
   ```c
   #endif /*_HINIC3_CMDQ_ENHANCE_H_ */
   ```
   Should be `/* _HINIC3_CMDQ_ENHANCE_H_ */`.

3. **Line 1 (meson.build)**: Missing comma in sources list:
   ```python
   base_sources = files(
           'hinic3_cmdq_enhance.c'
           'hinic3_cmdq.c',
   ```
   Should have comma after first file.

4. **Multiple typedef changes** - Using `u8`, `u16`, `u32`, `u64` instead of standard `uint8_t`, `uint16_t`, etc. DPDK uses standard C types.

### Warnings

1. **Inconsistent indentation** in `cmdq_sync_cmd()` function - some blocks have incorrect indentation levels.

2. **Missing Doxygen documentation** for new public functions in `hinic3_cmdq_enhance.h`.

---

## Patch 3/7: net/hinic3: use different callback func to split new/old cmdq operations

### Errors

1. **Line 55-60 (hinic3_nic_io.h)**: Missing semicolons in struct definition:
   ```c
   struct hinic3_nic_cmdq_ops {
       prepare_cmd_buf_clean_tso_lro_space_t       prepare_cmd_buf_clean_tso_lro_space
       prepare_cmd_buf_qp_context_multi_store_t    prepare_cmd_buf_qp_context_multi_store
   ```
   Each line needs a semicolon.

2. **Line 80-81 (hinic3_htn_cmdq.c)**: Function `prepare_rss_indir_table_cmd_header` is called before it's defined (defined at line 93).

3. **Line 38 (hinic3_stn_cmdq.h)**: Missing closing brace or semicolon at end of struct.

4. **Undefined types** - `u32`, `u16`, `u8` used instead of `uint32_t`, `uint16_t`, `uint8_t`.

### Warnings

1. **Missing header guards** check - `hinic3_htn_cmdq.h` and `hinic3_stn_cmdq.h` header guards don't match standard format.

---

## Patch 4/7: net/hinic3: add fun init ops to support Compact CQE

### Errors

1. **Line 614 (hinic3_nic_io.c)**: Unterminated string literal:
   ```c
   PMD_DRV_LOG(ERR, "Set rq cqe context failed,
               qid: %d, err: %d, status: 0x%x, out_size: 0x%x",
   ```
   String cannot span lines like this.

2. **Line 666 (hinic3_nic_io.c)**: Redefinition of `nic_dev`:
   ```c
   hinic3_set_rq_enable(struct hinic3_nic_dev *nic_dev, uint16_t q_id, bool enable)
   {
       struct hinic3_nic_dev *nic_dev = NULL;
   ```

3. **Line 669 (hinic3_nic_io.c)**: Undefined variable `dev` used:
   ```c
   if (!dev)
       return -EINVAL;
   ```

4. **Missing function declaration** - `hinic3_nic_tx_rx_ops_init` is called but not declared.

### Warnings

1. **Commit message**: "fun init" should be "func init" or "function init".

2. **Signed-off-by has leading space** in commit message.

---

## Patch 5/7: net/hinic3: add rx ops to support Compact CQE

### Errors

1. **Line 476 (hinic3_rx.h)**: Missing comma in function declaration:
   ```c
   hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe
                                  struct hinic3_cqe_info *cqe_info);
   ```

2. **Line 790 (hinic3_rx.c)**: `if` statement without space:
   ```c
   if(err) {
   ```
   Should be `if (err)`.

3. **Undefined macro** `HINIC3_PKT_TX_TUNNEL_GENEVE` and `HINIC3_PKT_TX_TUNNEL_IPIP` used but not defined.

### Warnings

1. **Inconsistent brace style** - some functions use opening brace on same line, others on new line.

---

## Patch 6/7: net/hinic3: add tx ops to support Compact CQE

### Errors

1. **Line 379 (hinic3_tx.c)**: Undefined variable `wqe`:
   ```c
   wqe->task->pkt_info0 =
   ```
   Should be `task->pkt_info0`.

2. **Line 606 (hinic3_tx.c)**: Typo in function name:
   ```c
   return inic3_non_tso_pkt_pre_process(mbuf, wqe_info);
   ```
   Should be `hinic3_non_tso_pkt_pre_process`.

3. **Line 328 (hinic3_tx.h)**: Duplicate enum value:
   ```c
   enum sq_wqe_data_format {
       SQ_NORMAL_WQE = 0,
   ```
   `SQ_NORMAL_WQE` is already defined in `enum sq_wqe_type`.

### Warnings

1. **Missing `RTE_MBUF_F_TX_OUTER_UDP_CKSUM`** - `HINIC3_PKT_TX_OUTER_UDP_CKSUM` is used but the corresponding RTE flag mapping is missing.

---

## Patch 7/7: net/hinic3: use different callback func to support htn fdir

### Errors

1. **Line 926 (hinic3_fdir.c)**: Wrong parameter type:
   ```c
   hinic3_tcam_alloc_index(struct hinic3_nic_dev nic_dev, uint16_t *block_id)
   ```
   Should be `struct hinic3_nic_dev *nic_dev` (pointer).

2. **Line 942 (hinic3_fdir.c)**: Same issue - missing pointer for `nic_dev` parameter.

3. **Line 656 (hinic3_fdir.h)**: Missing semicolon at end of function declaration:
   ```c
   void hinic3_tcam_index_free(struct hinic3_nic_dev nic_dev, uint16_t index, uint16_t *block_id)
   ```

4. **Line 750 (hinic3_fdir.c)**: Missing closing brace:
   ```c
   if (index == HINIC3_TCAM_INVALID_INDEX) {
       return -ENOMEM;
   }
   ```
   The outer `if` block is not closed properly.

### Warnings

1. **Inconsistent parameter types** - Some functions use `struct hinic3_nic_dev` while others use `struct hinic3_nic_dev *`.

---

## Summary

This patch series has significant issues that need to be addressed before it can be accepted:

1. **Compilation errors** - Multiple syntax errors prevent building
2. **Undefined symbols** - References to macros and functions that don't exist
3. **Type inconsistencies** - Mix of kernel-style types (`u32`) and standard types (`uint32_t`)
4. **Missing build system updates** - New directories not integrated into meson build
5. **Documentation gaps** - New APIs lack Doxygen comments

The patches should be thoroughly tested for compilation before resubmission.
