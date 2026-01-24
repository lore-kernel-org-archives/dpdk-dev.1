Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219AED715E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 19:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F8A1402B0;
	Sat, 24 Jan 2026 20:10:51 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 89CC640278
 for <dev@dpdk.org>; Sat, 24 Jan 2026 20:10:49 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so32607525e9.3
 for <dev@dpdk.org>; Sat, 24 Jan 2026 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769281849;
 x=1769886649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O66hcqMGTE0ZNxAR73SBkzXw8IM/4dERtM21GgEz4JE=;
 b=0Gdy1yksfxbmGbNRQHmcQWEiieFisj2yzoJQe3Ah5OyPlfHkvbqLqCr9m/8rGlcfXS
 GjnnlDUPBRDnNdMuiXuLQS5TUdE5ueBvGYies5D8rgHIKyGxB+Yy0xuekOp1A3WMq6Ru
 7hOyOHnXiZf5LvMQgMZzygqThLNGpfxbikSGgMlz2EnZpq6Fmr5hILDsOE2bUChx/EpJ
 I2Z1dtpWeYRUiW5nuWyXm4WhoG9fTBJLY7OmZB736DrZ/S3Wy1HnQJq3uPvJViGFzaRJ
 8oa+/YyY4GTjIvepjK6jEhwHGIJpUQZ1xTGZcB8F2uCtFqn7ya791RE9Ocae+JpWcts+
 Zndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769281849; x=1769886649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O66hcqMGTE0ZNxAR73SBkzXw8IM/4dERtM21GgEz4JE=;
 b=lREvNvzQIh9LVNdgmKXopjpO4TJz+2cnqTsNQ5QCMuQXYfspZ19W4EyoEfT0Ngre0+
 beSABbvIQDQwbBBzd6R8lef3SUO5YJMbm61ZpgB6dgnuwuvlYxcNQvTr6aD9hWH4bwAG
 mKxZG8Kp3WShla5Zap1n0Bq8G/ggL6yM15dDEluzzu+bODDQbsFHqMGzJaF/qHg6H0y6
 XoJ3zyAPUj2kvWrI6CcidRPF2Uz1Dokm8np3TWaqhPrupeOngJwnNzdQV+MXUDTbnNn1
 kD4T+9HHyYpXF4QYgVAf4Y/Ne1NksMzsBHz6jMp/VY0QcV6z8k8AVlxWZq4+qDrE4VKp
 j26Q==
X-Gm-Message-State: AOJu0YwHlIO3ONp/LiDkdkhudGu0lpm1Iji2m2tQY6UPaGeJ7DLmxR9C
 lTBJbYBDG9OihxfI7FvQW6NlIMDpnuM3aIY0X+vhUCfNkqogyblO61quxqEPFdd0QH5w8HinKCR
 rl9vi
X-Gm-Gg: AZuq6aJ0EVZFS0tOR81MfMkQoXN4WxEwmFkOKzkU2e0DVoql/toPY6ZmnMNzEl/ybMi
 MzVYZ72GxImLffqFoQn5TTFFO8hh9lhkvEVkG4TtkAq1Py68MrDb1leK3ilP32gJrsD246Dzze5
 t4T5ckY0dRn7nQ24n8wiyVSLQlWv/CkS0jAvA0nRzMmgrHNURss4+Vc+tctvRQGnGY/aHM4KfV+
 C38sWNBWO1MOlbEEBGMVzyX+pPHTuJrkgFK6WiQsdz6fyKmqocJ4uNVaWaEtFsaKs3vCxalzuHl
 AbYQTM+iQu1APflXN0wyRHpShL9iQyI7zCOq7kTfZhDEuh5vwnTc1XkbwRIlwhNDlN7PWqdxwqk
 wS79NrU6K5A6E7LG4cNn4ln0GnE9EP3R668H0hWE8Sxhnt/CjnRu4frDC01Hlszz9EqGKWtHrog
 QqxER6e6iZOdWbjV94CQ6ugGVFB90tOxs67EuTrYX2ke6+Mp1Lr0Nq9CXUWntc
X-Received: by 2002:a05:600c:1d20:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-4804c94c44amr118068415e9.5.1769281849020; 
 Sat, 24 Jan 2026 11:10:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm169482125e9.14.2026.01.24.11.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 11:10:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [REVIEW] doc/nfb: cleanup and update guide
Date: Sat, 24 Jan 2026 11:10:45 -0800
Message-ID: <20260124191045.217143-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123172224.1567362-9-spinler@cesnet.cz>
References: <20260123172224.1567362-9-spinler@cesnet.cz>
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

AI-generated review of bundle-1688-nfb-multiport.mbox
Reviewed using Claude (claude-opus-4-5-20251101)

This is an automated review. Please verify all suggestions.

---

# DPDK Patch Review: bundle-1688-nfb-multiport.mbox

This patch series (8 patches) enhances the NFB driver to create one ethdev per physical Ethernet port instead of one ethdev per PCI device.

---

## Patch 1/8: net/nfb: prepare for indirect queue mapping scheme

### Commit Message
- **Subject**: `net/nfb: prepare for indirect queue mapping scheme` (49 chars) ✓
- **Format**: Correct prefix, lowercase, imperative mood ✓
- **Signed-off-by**: Present ✓

### Code Review

**Warning: Unnecessary cast of void * (rte_calloc returns void *)**
```c
priv->queue_map_rx = rte_calloc("NFB queue map", (max_rx_queues + max_tx_queues),
        sizeof(*priv->queue_map_rx), 0);
```
This is actually fine - no cast is present. ✓

**Info: Variable declaration style**
```c
int i;
int ret;
```
The declaration at the top of the function is acceptable.

**Warning: Inconsistent loop variable types**
```c
for (i = 0; i < max_rx_queues; i++)
```
`i` is `int` but `max_rx_queues` is `uint16_t`. This works but could be cleaner with matching types.

---

## Patch 2/8: net/nfb: create one ethdev per ethernet port

### Commit Message
- **Subject**: `net/nfb: create one ethdev per ethernet port` (46 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review

**Error: `__rte_internal` must be alone on the line preceding the return type**

In `drivers/net/nfb/nfb.h`:
```c
__rte_internal
int nfb_eth_common_probe(struct nfb_probe_params *params);
__rte_internal
int nfb_eth_common_remove(struct rte_device *dev);
```
These should be:
```c
__rte_internal
int
nfb_eth_common_probe(struct nfb_probe_params *params);

__rte_internal
int
nfb_eth_common_remove(struct rte_device *dev);
```

**Warning: Use of `snprintf` return value check pattern**
```c
ret = snprintf(pp->name + cp->basename_len, sizeof(pp->name) - cp->basename_len,
        "_eth%d", ifc->id);
if (ret < 0 || ret >= (signed int)sizeof(pp->name) - cp->basename_len)
```
The cast to `(signed int)` is unnecessary and the calculation on the right side could overflow. Consider using a clearer pattern.

**Warning: Empty line before new struct member**
```c
struct pmd_internals {
    ...
    struct nfb_device *nfb;

    TAILQ_ENTRY(pmd_internals) eth_dev_list;  /**< Item in list of all devices */
```
Inconsistent blank line usage within struct definition.

**Info: Static global initialization**
```c
static struct nfb_pmd_internals_head nfb_eth_dev_list =
    TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
```
This is acceptable.

---

## Patch 3/8: net/nfb: add vdev as alternative device probe method

### Commit Message
- **Subject**: `net/nfb: add vdev as alternative device probe method` (50 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review

**Error: Missing SPDX on line 1 - actually present and correct** ✓

**Warning: Use of standard library `strdup` instead of DPDK equivalent**
```c
dev_params = strdup(vdev_args);
```
Consider using `rte_strdup()` or documenting why standard `strdup` is appropriate here.

**Warning: Use of standard library `free` instead of DPDK equivalent**
```c
free(dev_params);
```
Should use `rte_free()` if `rte_malloc()` family was used, but since `strdup` was used, `free` is correct.

**Info: Consistent error handling pattern** ✓

---

## Patch 4/8: net/nfb: add device argument "port" to limit used ports

### Commit Message
- **Subject**: `net/nfb: add device argument "port" to limit used ports` (53 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review

**Warning: Missing include for `isdigit`**
```c
if (value == NULL || strlen(value) == 0 || !isdigit(*value))
```
Needs `#include <ctype.h>` for `isdigit()`.

**Warning: Implicit integer conversion**
```c
if (*end != '\0' || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
```
The cast to `unsigned long` is explicit, which is good.

---

## Patch 5/8: net/nfb: init only MACs associated with device

### Commit Message
- **Subject**: `net/nfb: init only MACs associated with device` (46 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review

**Warning: Use of standard library `calloc` and `free`**
```c
intl->rxmac = calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
...
free(intl->txmac);
free(intl->rxmac);
```
Should consider using `rte_calloc()` and `rte_free()` for consistency with DPDK memory management, especially if these structures may be accessed in data path or shared between processes.

**Info: Loop variable type consistency**
```c
int i, rxm, txm;
...
for (i = 0; i < mi->eth_cnt; i++) {
```
Types are consistent within the function.

---

## Patch 6/8: net/nfb: add compatible cards to driver PCI ID table

### Commit Message
- **Subject**: `net/nfb: add compatible cards to driver PCI ID table` (52 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review
No issues found. Simple addition of PCI IDs. ✓

---

## Patch 7/8: net/nfb: report firmware version

### Commit Message
- **Subject**: `net/nfb: report firmware version` (33 chars) ✓
- **Signed-off-by**: Present ✓

### Code Review

**Info: Good error handling pattern**
```c
if (proj_name == NULL)
    proj_name = "";
if (proj_vers == NULL)
    proj_vers = "";
```
Proper NULL pointer handling. ✓

**Info: Return value calculation**
```c
if (ret >= (signed int)fw_size)
    return strlen(proj_name) + 1 + strlen(proj_vers) + 1;
```
Returns required buffer size when buffer is too small - follows DPDK convention. ✓

---

## Patch 8/8: doc/nfb: cleanup and update guide

### Commit Message
- **Subject**: `doc/nfb: cleanup and update guide` (35 chars) ✓
- **Signed-off-by**: Present ✓

### Documentation Review

**Info: Good documentation update**
- Added features to `features/nfb.ini` ✓
- Updated `nfb.rst` with current information ✓
- Added release notes entry ✓

**Warning: Release notes mention "timestamp value has been updated" but no timestamp changes in this series**
The release notes state:
```
* The timestamp value has been updated to make it usable.
```
But there are no timestamp-related code changes in this patch series. This may be referring to changes in a previous version or should be removed.

---

## Summary

### Errors (Must Fix)
1. **Patch 2**: `__rte_internal` functions in header file must have return type on separate line

### Warnings (Should Fix)
1. **Patch 2**: Empty line inconsistency in struct definition
2. **Patch 3**: Consider documenting use of standard `strdup`/`free`
3. **Patch 4**: Missing `#include <ctype.h>` for `isdigit()`
4. **Patch 5**: Consider using `rte_calloc()`/`rte_free()` instead of standard library functions
5. **Patch 8**: Release notes mention timestamp changes not present in this series

### Info (Consider)
1. Loop variable type consistency could be improved in some places
2. Overall code organization and error handling patterns are good
3. Documentation updates are comprehensive

### Overall Assessment
The patch series is well-structured and addresses a clear functional enhancement. The main blocking issue is the `__rte_internal` formatting in patch 2. Other warnings should be addressed for better code quality and DPDK consistency.
