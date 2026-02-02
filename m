Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D5E7DF13
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118E14027D;
	Mon,  2 Feb 2026 18:42:42 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0DF8C4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:42:40 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so23347695e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054160;
 x=1770658960; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8zmCzXZWVEzqrjGdqHLJk1gn0PWya+b5A5plyJbi7M=;
 b=28mULyh3c/RWRWExJaRlPz5mvVghpt5dcO5S0ZTCymVP3sbBVLjwB3tWK1b3+OKSTk
 tFpvm8HU5ma5bTRYHJpTxp7AHxF8SUBn4Szb9NpIJVGhfB5t0zKW3QQlGEtZ5Qp0NZWE
 9JHuZjT+vowYqr07TiOAUCCaH7RlXB0KYl3uGVCoClfPBBcyS09vmTiLMwFjJmh+SqNL
 7AKR29YBn/CA9N7vlknpqIltTCOkBtvPB6xS/GmCZljxCtU4m68HoNZKa/cCav4Nk9uG
 QgB+R5cJifvSiQfIONks1Oe+df04pppth3Meoi0JNCqLx5Al6L0ba9SnsotxL0SKaxSM
 84qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054160; x=1770658960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d8zmCzXZWVEzqrjGdqHLJk1gn0PWya+b5A5plyJbi7M=;
 b=rjGyeo3JCMsvBuU6SHbp1iV5pBrYfmsOYJDAj3cctwdMkdlHSmMrKvXNMCJqBIPWZd
 x738RO83V11fFHKJA5fAE5ZrRoC7am2wt8Qv1yMrZx6O5dYN6FZtjOvzOy3ixeQ+5UMn
 LTY7qKk5tJSoq4XW+CRjHjTun3p9BspwfF5zOg14yXS5EgfP9nbu/4I+ZJ2ZqeXQBdzR
 J8IuJlBUWCQJHj5fm+lBlFNpMww14daHVPtPm33qng4MbCYEALI1IJug7WLb/x1nxmmh
 j/JbGlCCjYTElGK6buPrI1lWHnxuNf4L/ptpPbehylG11hcp/sM8337unzPu74W16+gh
 Mm4A==
X-Gm-Message-State: AOJu0Yx8SzhDqnFtBOD/Q96rW+c6J21Uk7xXPg5Ou6KD71MpsZ4+G1a0
 CG6A7NLJT42+uWeMn8zmo0X/o5cKu7/Ijgzf1b02DnFVuAMHBRZJGlfP4GPDZKx1j7Stysr2qv6
 Wk9Fs
X-Gm-Gg: AZuq6aIn3+AB9lJytpmBXSJ+CSlSGJfZO4oWKLVq5WGd7h6+oHY0lRKFcc8Bm9RqWD7
 Phy46xz5ZSgm7/9Nbk7YStFZoFHD1vXfobqmMlurkQDtinFqXdqMmaMb5mAn7kjxfJG12E5QZbZ
 PXEf0hZWkkPI8GZ3nRc64g3VCnNAYgDT1VDpUNnUglYtOApP2m5zdm5JAE1pxrvi0H8OAwf4lna
 2rs8YG8K8wpyWInSplCj+Q00wqL84wi31N+MVc3gTpj1GVkGVx/b77BFDn+IDykqXeKNa4VdtcS
 +s6TomlOY/y+xJKKj9vQ3VvPpieRzoTl8Xi3IUECjcyK5cIITqV0JTVuga9ZbzTl8E9dX7tk01T
 kYGEFauy+JPb3PyM8fvQ/SOw0YpnqN3ZSYMWOQ0mmVDBQkri2RUv8UVzpnTziuhmsj+9Yn/q+fo
 iMUQubI/q8g11aqouTkzUFhLAQtUXc7X/CVC45f3qUe1mQaGnkG/CeQXSOIEEr
X-Received: by 2002:a05:600c:3b96:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-482db49978emr157095055e9.26.1770054159580; 
 Mon, 02 Feb 2026 09:42:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483002955dbsm19212575e9.5.2026.02.02.09.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:42:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [REVIEW] doc/nfb: cleanup and update guide
Date: Mon,  2 Feb 2026 09:42:35 -0800
Message-ID: <20260202174235.20628-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202153449.3295979-9-spinler@cesnet.cz>
References: <20260202153449.3295979-9-spinler@cesnet.cz>
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

AI-generated review of bundle-1720-nfb-multiport.mbox
Reviewed using Claude (claude-opus-4-5-20251101) on 2026-02-02

This is an automated review. Please verify all suggestions.

---

# DPDK Patch Review: net/nfb Multi-port Series (v6)

## Overview
This is an 8-patch series that enhances the NFB driver to create one ethdev per physical Ethernet port instead of one ethdev per PCI device.

---

## Patch 1/8: net/nfb: prepare for indirect queue mapping scheme

### Errors
None.

### Warnings

1. **Line length exceeds 100 characters** (nfb_ethdev.c)
   - Line 580: `priv->queue_map_rx = rte_calloc("NFB queue map", (max_rx_queues + max_tx_queues),`
   - Split across multiple lines to stay within 100 characters.

### Info
- Clean preparation patch that adds queue mapping infrastructure for the multi-port implementation.

---

## Patch 2/8: net/nfb: create one ethdev per ethernet port

### Errors

1. **`__rte_internal` functions in header file without the tag appearing alone on its own line** (nfb.h:89-92)
   ```c
   __rte_internal
   int nfb_eth_common_probe(struct nfb_probe_params *params);
   __rte_internal
   int nfb_eth_common_remove(struct rte_device *dev);
   ```
   The `__rte_internal` tag should be alone on its line, but the function signature should have the return type on a separate line per DPDK style:
   ```c
   __rte_internal
   int
   nfb_eth_common_probe(struct nfb_probe_params *params);
   ```

### Warnings

1. **Extra blank line** (nfb.h:93)
   - There are two blank lines before the `__rte_internal` declaration; one is sufficient.

2. **Line exceeds 100 characters** (nfb_ethdev.c:704)
   ```c
   ret = snprintf(pp->name + cp->basename_len, sizeof(pp->name) - cp->basename_len,
   ```
   This line is approximately 101 characters.

### Info
- Good refactoring to support multi-port architecture.

---

## Patch 3/8: net/nfb: add vdev as alternative device probe method

### Errors
None.

### Warnings

1. **Unnecessary cast of void pointer** (nfb_vdev.c:62)
   ```c
   ret = rte_kvargs_process(kvlist, NFB_ARG_PORT,
           nfb_eth_dev_create_for_ifc_by_port, (void *)&ifc_params);
   ```
   The cast `(void *)` is unnecessary in C.

2. **Missing newline at end of file** (nfb_vdev.c)
   - The file appears to end without a trailing newline after line 108.

### Info
- Useful addition for virtual/simulated NFB devices.

---

## Patch 4/8: net/nfb: add device argument "port" to limit used ports

### Errors
None.

### Warnings

1. **Unnecessary cast of void pointer** (nfb_ethdev.c:774)
   ```c
   nfb_eth_dev_create_for_ifc_by_port, (void *)&ifc_params);
   ```
   The cast is unnecessary.

### Info
- Good feature addition for selecting specific ports.

---

## Patch 5/8: net/nfb: init only MACs associated with device

### Errors
None.

### Warnings

1. **Using `calloc()` instead of `rte_calloc()`** (nfb_ethdev.c:74-78)
   ```c
   intl->rxmac = calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
   ...
   intl->txmac = calloc(ifc->eth_cnt, sizeof(*intl->txmac));
   ```
   For consistency within the driver and proper NUMA-aware allocation, consider using `rte_calloc()` or `rte_zmalloc()`. However, since these are control structures (not DMA-accessible), standard `calloc()` is acceptable.

2. **Using `free()` instead of `rte_free()`** (nfb_ethdev.c:114-115)
   ```c
   free(intl->txmac);
   free(intl->rxmac);
   ```
   Should match the allocation function. If using `calloc()`, then `free()` is correct.

### Info
- Properly scopes MAC initialization to the associated device.

---

## Patch 6/8: net/nfb: add compatible cards to driver PCI ID table

### Errors
None.

### Warnings
None.

### Info
- Straightforward addition of PCI IDs for additional compatible cards.

---

## Patch 7/8: net/nfb: report firmware version

### Errors
None.

### Warnings
None.

### Info
- Clean implementation of firmware version reporting.

---

## Patch 8/8: doc/nfb: cleanup and update guide

### Errors
None.

### Warnings

1. **HTTP link instead of HTTPS** (nfb.rst:20)
   ```rst
   `historical cards <https://www.liberouter.org/technologies/cards/>`_
   ```
   This appears to be HTTPS, which is correct. No issue.

### Info
- Documentation updates align well with the code changes.
- Release notes properly document the new features.

---

## Summary

### Errors (Must Fix)
1. **Patch 2**: `__rte_internal` function declarations should have return type on separate line per DPDK style.

### Warnings (Should Fix)
1. **Patch 1**: Line exceeds 100 characters in nfb_ethdev.c.
2. **Patch 2**: Extra blank line in nfb.h; line exceeds 100 characters.
3. **Patches 3, 4**: Unnecessary `(void *)` cast.
4. **Patch 3**: Verify file ends with newline.

### General Observations
- The patch series is well-structured with clear separation of concerns.
- Commit messages are well-written and follow DPDK conventions.
- The code changes are logical and the multi-port architecture is cleanly implemented.
- Documentation is updated appropriately with release notes.
