Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9441D6CFAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 01:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D91D44021F;
	Fri, 23 Jan 2026 02:00:38 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id A8FE4400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 02:00:37 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43596062728so1790693f8f.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769130037;
 x=1769734837; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HksoeIVet3FaINOvLJND41P4wNNSSmxBQGTfzLEhUDY=;
 b=OcJ+r8IWHcFOodM+sjWv3+4csHH4ut+G9YcnZeIkPHlCEvMVEmjPx6IwIOao7IH3D/
 dy2hR7NND8O7pLWMrRupFA4iNgIJTwfY8eTZHNXM5SJH0uVHHlX6hOYtnUitG5hw9fZf
 E5p0rbY8gdAlXCiXPacub3fXkyoaPa9iqjLLnwcPAPGialZnHHHHWNdLU+ZkPnkMgaWX
 ihI2txgqAxJlaiEoeulpDGcf1KeaASZVFFY6pFtIaa86SkRMxO4DFyhUCdc6MO+pLviS
 9vDgClMmWBjstRykCgieS+HNuURRjWjHTn6s4ieW5cxVlDFCh3TS0s4Z3zhHN17HxX8k
 g12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769130037; x=1769734837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HksoeIVet3FaINOvLJND41P4wNNSSmxBQGTfzLEhUDY=;
 b=Xv5NCkBYwfaSONY41oKcexldoNOorh6f5SdrcRQptpX5hV3yeOsMB5DhR4jk2o3AOk
 9TEZGoCfn5Ed7w02wskOCLzrliQnVdU7iaWiFkRBxA8+gKtuoCBHjsmY7sXnEeGGfNg5
 1r45lhRWmIqzO6X0QHmX0urqeJaXPsIVOaLqTXl5v7gespZ5rRF1apP+GDE9aKGNGZTk
 v4lIhsidyzF8lVw3wUlCdqC3wVQB4eDcHCFJWwd7juc9q3MS5ZuuPlesCwzFG18yhoTn
 P4lSj5yEt3TdBZwb6BOOovRc75nAKTV48jF7kMGyovj7H6D8bPrkm8cUi/krWGYfVq1o
 Wavw==
X-Gm-Message-State: AOJu0Yy1YAj8no9QStF8SejzsL0FV01vNIyV1MFulaPBG2+aqG7lDSWJ
 78fEVuvjQTXqq3uMF505JpgmSrgNrsQYO8v6s33DEapER5/h9/h13SkX5Bdbv31eJ2L3sVRMwQq
 QocND
X-Gm-Gg: AZuq6aJMH85O/zYcryzsOYAl/Wdq6YoWfonw4mcN8T6FoWrvEXfdEV15VJKaDkIYXy5
 cFbke58Wk5MFLaZwQCKL6qWfbSwxCxQiDOiQ/JqBA/1opAwfw0dscdSSJvKF1QF35Og191PDYzt
 q78DcaI9Xk5njTva0Mku1AYArBKoNqlDiC+KA8AlOFnZid0av/27rdE2wk1DF9r/MGdHQMCMVpO
 y//Ucr4AeAKTjdSVXbLBwFfTRv6elMxzFGs2DO1Tpd05mzQa8pCGXZf4NyW+jI4aeSRsVieFIBO
 sMHXdAhO/AxVrz5URRuoqWZPZQMoMNs07ugGLRWSMPAw4UW4K/Hye6vPrhvQ+xGAm1acBFNL8dg
 ovreXS9JhQ7kzEykMBpt9Y0/4T4vS+oCau9ptUgvxwGRNDS8de5LY+P5406W8lm6DG5sR3PZERm
 B1qRdkhIZVnfbuPdnQAYNms1U/LE9TV/W76/2nObUCmSeyq3snKnIW
X-Received: by 2002:adf:f788:0:b0:435:aaba:b904 with SMTP id
 ffacd0b85a97d-435aababa42mr5423552f8f.8.1769130036874; 
 Thu, 22 Jan 2026 17:00:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm2609032f8f.9.2026.01.22.17.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 17:00:36 -0800 (PST)
Date: Thu, 22 Jan 2026 17:00:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/8] net/nfb: rework to real multiport
Message-ID: <20260122170031.1301d16f@phoenix.local>
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 22 Jan 2026 08:27:11 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
>=20
> ---
> v4:
> * Cleaned usage of sprintf
> * Updated commit message for doc cleanup

=3D=3D=3D Patch Review: bundle-1675-nfb-multiport.mbox (via Claude) =3D=3D=
=3D
# DPDK Patch Review: NFB Multi-port Support

## ERRORS

### 1. Commit Message - Missing Fixes Tag (Patch 1/8)
**File:** Patch 1/8 - "net/nfb: prepare for indirect queue mapping scheme" =
=20
**Issue:** The commit body states "This prepares queue mapping for port-awa=
re driver implementation" which suggests this is fixing or preparing for so=
mething, but there's no explanation of what problem this solves. While not =
strictly a bug fix requiring a `Fixes:` tag, the commit message should bett=
er explain the rationale.

**Recommendation:** Expand the commit body to explain why the indirect mapp=
ing is needed before implementing multi-port support.

---

### 2. Forbidden Token - RTE_EXPORT_INTERNAL_SYMBOL (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c (Line after nfb_eth_common_probe def=
inition) =20
**Location:** Lines 667, 780

```c
RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_probe)
int
nfb_eth_common_probe(struct rte_device *device,
...

RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_remove)
int
nfb_eth_common_remove(struct rte_device *dev)
```

**Issue:** According to AGENTS.md, `__rte_internal` must appear **alone on =
the line** immediately preceding the return type, and only in header files.=
 `RTE_EXPORT_INTERNAL_SYMBOL` is the wrong way to mark internal APIs.

**Required Fix:** Move the `__rte_internal` attribute to the function decla=
rations in `nfb.h`:

```c
// In nfb.h
__rte_internal
int nfb_eth_common_probe(struct rte_device *device,
		ethdev_bus_specific_init specific_init, void *specific_device,
		struct nfb_init_params *params, int ep_index);

__rte_internal
int nfb_eth_common_remove(struct rte_device *dev);
```

And remove the `RTE_EXPORT_INTERNAL_SYMBOL` macros from the .c file.

---

### 3. Memory Leak on Error Path (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Function:** nfb_eth_common_probe =20
**Location:** Lines 713-735

```c
nc_ifc_map_info_create_ordinary(nfb_dev, &params->map_info);

if (params->args !=3D NULL && strlen(params->args) > 0) {
    kvlist =3D rte_kvargs_parse(params->args, VALID_KEYS);
    if (kvlist =3D=3D NULL) {
        NFB_LOG(ERR, "Failed to parse device arguments %s", params->args);
        return -EINVAL;  // =E2=86=90 Leaks map_info and nfb_dev
    }
    // ... more code ...
    if (port_mask =3D=3D 0) {
        NFB_LOG(ERR, "Failed to parse device port argument");
        return -EINVAL;  // =E2=86=90 Leaks map_info and nfb_dev
    }
}
```

**Issue:** Early returns leak `params->map_info` (allocated by `nc_ifc_map_=
info_create_ordinary`) and don't close `nfb_dev`.

**Required Fix:**
```c
if (kvlist =3D=3D NULL) {
    NFB_LOG(ERR, "Failed to parse device arguments %s", params->args);
    ret =3D -EINVAL;
    goto err_parse_args;
}
// ...=20
if (port_mask =3D=3D 0) {
    NFB_LOG(ERR, "Failed to parse device port argument");
    ret =3D -EINVAL;
    goto err_parse_args;
}

// At end of function, before existing cleanup:
err_parse_args:
    nc_map_info_destroy(&params->map_info);
    nfb_close(nfb_dev);
    return ret;
```

---

### 4. Incorrect Line Length (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Line 802

```c
			return nfb_eth_common_probe(&pci_dev->device, eth_dev_pci_specific_init,=
 pci_dev, &params,
```

**Issue:** This line exceeds 100 characters (appears to be ~105 characters =
based on context). C code lines must not exceed 100 characters.

**Required Fix:** Break the line appropriately:
```c
	return nfb_eth_common_probe(&pci_dev->device,
			eth_dev_pci_specific_init, pci_dev, &params,
			comp_dev_info.ep_index);
```

---

### 5. Missing Release Notes for API Changes (Patches 2-8)
**File:** doc/guides/rel_notes/release_26_03.rst =20
**Location:** Only appears in Patch 8/8

**Issue:** Per AGENTS.md: "Changes to existing APIs require release notes" =
and "New drivers or subsystems must have release notes." The release notes =
are added in patch 8/8, but significant driver behavior changes occur in pa=
tches 2-5. According to AGENTS.md, "Code and documentation must be updated =
atomically in same patch."

**Required Fix:** Move relevant portions of the release notes update to the=
 patches where the changes actually occur:
- Patch 2/8: Note about one ethdev per port
- Patch 4/8: Note about the `port` argument
- Patch 7/8: Note about firmware version reporting

---

## WARNINGS

### 1. Commit Message Body - Starts with "It" (Patch 1/8)
**Issue:** Per AGENTS.md, commit message bodies must not start with "It". W=
hile this patch doesn't explicitly start with "It", the body is minimal and=
 doesn't provide sufficient context.

**Current:**
```
This prepares queue mapping for port-aware driver implementation.
```

**Recommendation:**
```
Introduce indirect queue mapping to support multiple ethdev ports.

The NFB driver is being enhanced to create one ethdev per physical
Ethernet port instead of one ethdev per PCI device. This requires
an indirect mapping layer because DPDK queue indices no longer
directly correspond to firmware queue indices.

This change adds queue_map_rx and queue_map_tx arrays to track the
mapping between DPDK queue indices and firmware queue IDs, preparing
for the multi-port implementation in subsequent patches.
```

---

### 2. Subject Line Length (Patch 2/8)
**File:** Patch 2/8 subject =20
**Current:** "net/nfb: create ethdev for every eth port/channel" (50 chars)

**Issue:** While under the 60-character limit, the subject could be more de=
scriptive about the impact.

**Recommendation:** Consider:
```
net/nfb: create one ethdev per ethernet port
```
(More clear about the 1:1 relationship)

---

### 3. Inappropriate Use of rte_zmalloc (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Line 585

```c
priv->queue_map_rx =3D rte_calloc("NFB queue map", (max_rx_queues + max_tx_=
queues),
        sizeof(*priv->queue_map_rx), 0);
```

**Issue:** Per AGENTS.md "Appropriate Use of rte_malloc()": Use `rte_malloc=
()` only for DMA-accessible memory or memory shared between processes. Cont=
rol structures should use standard `malloc()`.

**Reasoning:** Queue mapping arrays are control plane data structures that =
don't require hugepage memory. Using `rte_calloc` wastes limited hugepage r=
esources.

**Recommendation:**
```c
priv->queue_map_rx =3D calloc((max_rx_queues + max_tx_queues),
        sizeof(*priv->queue_map_rx));
```

And use `free()` in cleanup path instead of `rte_free()`.

---

### 4. Unnecessary NULL Check Before free (Patches 1/8, 5/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Multiple locations

**Patch 1/8, Line 655:**
```c
if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY)
    rte_free(priv->queue_map_rx);
```

**Issue:** The `rte_eal_process_type()` check is appropriate (different pro=
cess model), but similar patterns elsewhere may be checking for NULL unnece=
ssarily.

**Patch 5/8, Lines 118-122:**
```c
for (i =3D 0; i < priv->max_rxmac; i++)
    nc_rxmac_close(priv->rxmac[i]);
rte_free(priv->rxmac);
```

**Potential Issue:** If any `priv->rxmac[i]` could be NULL, the code should=
 check before calling `nc_rxmac_close`, but this depends on `nc_rxmac_close=
` behavior (not visible in patch).

**Recommendation:** Verify that `nc_rxmac_close` and `nc_txmac_close` handl=
e NULL pointers safely, or add NULL checks:
```c
for (i =3D 0; i < priv->max_rxmac; i++) {
    if (priv->rxmac[i] !=3D NULL)
        nc_rxmac_close(priv->rxmac[i]);
}
```

---

### 5. Missing Documentation for New Struct Member (Patch 1/8)
**File:** drivers/net/nfb/nfb.h =20
**Location:** Lines 68-69

```c
struct pmd_priv {
	uint16_t max_rx_queues;
	uint16_t max_tx_queues;

	int             *queue_map_rx;
	int             *queue_map_tx;
};
```

**Issue:** New fields lack Doxygen-style comments explaining their purpose,=
 while the file shows other structures are documented.

**Recommendation:**
```c
struct pmd_priv {
	uint16_t max_rx_queues;
	uint16_t max_tx_queues;

	/** Mapping from DPDK RX queue index to firmware queue ID */
	int             *queue_map_rx;
	/** Mapping from DPDK TX queue index to firmware queue ID */
	int             *queue_map_tx;
};
```

---

### 6. Global Variable Without Unique Prefix (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Lines 28-29

```c
TAILQ_HEAD(pmd_internals_head, pmd_internals);
static struct pmd_internals_head nfb_eth_dev_list =3D
	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
```

**Issue:** Per AGENTS.md "Symbol Naming for Static Linking": While this is =
a `static` variable (file scope) and doesn't strictly violate the guideline=
, the type name `pmd_internals_head` is generic and could clash if the stat=
ic is removed in the future.

**Recommendation:** Use more specific names:
```c
TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);
static struct nfb_pmd_internals_head nfb_eth_dev_list =3D
	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
```

---

### 7. Inconsistent Error Handling Pattern (Patch 4/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Function:** fill_port_mask =20
**Location:** Lines 672-686

```c
static int fill_port_mask(const char *key __rte_unused, const char *value, =
void *opaque)
{
	char *end;
	uint64_t *port_mask =3D opaque;
	unsigned long port;

	if (value =3D=3D NULL || strlen(value) =3D=3D 0 || !isdigit(*value))
		return -1;

	port =3D strtoul(value, &end, 0);
	if (*end !=3D '\0' || port >=3D ULONG_WIDTH)
		return -1;
```

**Issue:** Function returns generic `-1` instead of standard error codes li=
ke `-EINVAL`. This is inconsistent with DPDK style where functions typicall=
y return `-errno` values.

**Recommendation:**
```c
if (value =3D=3D NULL || strlen(value) =3D=3D 0 || !isdigit(*value))
    return -EINVAL;

port =3D strtoul(value, &end, 0);
if (*end !=3D '\0' || port >=3D ULONG_WIDTH)
    return -EINVAL;
```

---

### 8. Potential Integer Overflow (Patch 4/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Line 728

```c
if (ret || port_mask >=3D RTE_BIT64(params->map_info.ifc_cnt))
    port_mask =3D 0;
```

**Issue:** If `params->map_info.ifc_cnt >=3D 64`, then `RTE_BIT64(params->m=
ap_info.ifc_cnt)` will overflow (undefined behavior for shift >=3D 64).

**Recommendation:**
```c
if (ret || params->map_info.ifc_cnt > 64 ||
        (params->map_info.ifc_cnt < 64 && port_mask >=3D RTE_BIT64(params->=
map_info.ifc_cnt)))
    port_mask =3D 0;
```

Or add a check earlier:
```c
if (params->map_info.ifc_cnt > 64) {
    NFB_LOG(ERR, "Too many interfaces: %u", params->map_info.ifc_cnt);
    return -EINVAL;
}
```

---

### 9. Documentation Not Matching Code (Patch 8/8)
**File:** doc/guides/nics/nfb.rst =20
**Location:** Lines 58-60

```rst
.. note::

   Normally, one port corresponds to one channel, but ports can often be co=
nfigured in a separate
   manner. For example one 100G port can be used as 4x25G or 4x10G independ=
ent Ethernet channels.
```

**Issue:** The documentation states "Normally, one port corresponds to one =
channel" but doesn't explain what a "channel" is in the context of the firm=
ware vs DPDK ports, which could confuse users.

**Recommendation:** Clarify the terminology:
```rst
.. note::

   The driver creates one DPDK port for each firmware Ethernet interface. S=
ome cards support
   port breakout, where a physical port can be reconfigured (e.g., 1x100G t=
o 4x25G). Each
   resulting channel appears as a separate DPDK port.
```

---

### 10. Missing NULL Checks After rte_zmalloc (Patch 2/8)
**File:** drivers/net/nfb/nfb_ethdev.c =20
**Location:** Line 537

```c
internals =3D rte_zmalloc_socket("nfb_internals",
        sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
        rte_socket_id());

if (internals =3D=3D NULL) {
    NFB_LOG(ERR, "Failed to allocate private data");
    ret =3D -ENOMEM;
    goto err_nfb_open;
}
```

**Issue:** The error path `err_nfb_open` doesn't check if `internals` is NU=
LL before potentially dereferencing it in cleanup. While this specific code=
 path is safe, it's worth noting for consistency.

**Status:** Currently safe, but should be verified if cleanup code changes.

---

## INFO

### 1. Code Style - Variable Declaration at Point of Use (Multiple Patches)
**Observation:** The patches use both C89-style (declarations at start of b=
lock) and C99-style (declarations at point of use) variable declarations.

**Example (Patch 1/8):**
```c
int ret;
int qid;
struct ndp_rx_queue *rxq;
```

vs.

**Example (Patch 5/8):**
```c
for (i =3D 0, j =3D 0
