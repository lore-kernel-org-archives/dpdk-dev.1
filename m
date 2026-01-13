Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E0D29DE5
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F29AA402DE;
	Tue, 13 Jan 2026 20:52:28 +0100 (CET)
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66]) by mails.dpdk.org (Postfix) with ESMTP id 7CF764028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:52:27 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so12312688a12.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768333947;
 x=1768938747; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91/ptWEqYo2U1p0S4Szxg+yu1em9/9YkNKZuWYTPTI0=;
 b=FznXCCno6MmvUmoTdxx3Go9zkitTqQAY53o+f/AJKhBiMMJF7iD0AGlixI5Dgk/RvM
 gATdlU0U3nFUXNqEKyE1nr1fmiC64QXMdAuMdw7Uulq+5l2hfmgmYR8afRiaqIkUFvUQ
 yVa0sao9vqfqWWkJO+pxDGnMVMnosHaeJUcecelBnhNOfdAN2Obi8q65dOxhwf044wZ6
 v1B/G9AUKeZVFT79AYIfnllnOm4vt0rTNcibDeVoB/8lZrcP0jPhjJnsUmc5h37A7cvz
 +HPJeQK0mpF6pAMS/FmMK2hRFRjbvANRzA7YDW4yJsfxteimqLDtP+bqXsEpEajmeqPF
 HamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333947; x=1768938747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91/ptWEqYo2U1p0S4Szxg+yu1em9/9YkNKZuWYTPTI0=;
 b=MYx2JDwEm4iX9DoYZnCA9HH+I5Y8GVfpoRal0u/5zm6Q2/2rpB9N2zjSQrx3JhH4jf
 MwP23oe3bhE4y+rcO93JGkLW1oqn+myT5TcDSmqH/iZoT4MtmJ3XOaKhsvJfThh2avKC
 PYVpUbY8R7NtypT+6BI/O8mnXmjG68g50LSQlKdgvb5CuxrqfknP1bPW/1A4UKa9ScSk
 xjdtD1s7rvfM9CoQHGdq9zFMzL7XJmi07W+5nFJaDRJm94LkHMM8gguW//weV5tcTVAs
 dSSyzgv5a6bdgt0777qrfTP7xSOOeJrLknykRpiuXV1IujstgrHYoWOmy4RXX2Kicjoa
 CFAg==
X-Gm-Message-State: AOJu0YzUH6QVXuET7ZtjsipBAG5/YZAdDHlxcG9sIcxHScg+edXXT4p2
 7IXjBsoXoFHox8oWw2J/yJApEMZqnSKY2km0sj67PE26qevwtpkWhIep3Bl6U6khh8I=
X-Gm-Gg: AY/fxX7UsFqcBo3fwul2hOrNKuAtlqfBUhBCXWPajazRX9FQOXcPL2AgkQ+wxQi3J6L
 YV/WAcW3TCdAWhe052uchZKASnJHvI72vQ4PNU71SkWRtBWFDppLKVJoj8CIed7vREGQ9x3LSH0
 qdoWCkjihl+FfNFF/3RIY0OS+J9M6600uHTBACilharNwWMc7wuWrzTQeQY+VhbyqVgzeYE7mOf
 8+1v4g8GV4rlzRrH6Ar638tzviB17OEYVmbJtVT1V/5RQ7zAajbSb0wJB7SYjEpHuXMVcaWE1fA
 ZviVKDA2nI3DVXCkqpIxfQltze9VAmjbg9rMcIW/9KmZOlms+jqBRNZraMaymubcNXCDONuR9CW
 mABh2mwPD9TIjLlOlLU60ljatLYlFvWklMotXIUSpg1DhMoAeJ8oGIgEM/0xw/OeLNiru14B5xH
 KBqbhnB6oJfuqoKSwyuk0K3SCJCfB+kd4u7K4CChO6IVlOTHBLshjz
X-Received: by 2002:a17:907:7b84:b0:b7d:3728:7d11 with SMTP id
 a640c23a62f3a-b87612c5bc7mr21433366b.50.1768333946886; 
 Tue, 13 Jan 2026 11:52:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87023a8a33sm909261366b.18.2026.01.13.11.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:52:26 -0800 (PST)
Date: Tue, 13 Jan 2026 11:52:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru
Subject: Re: [RFC PATCH 1/6] ethdev: extend and refactor DCB configuration
Message-ID: <20260113115221.5e5fdd54@phoenix.local>
In-Reply-To: <20250830171706.428977-2-vladimir.medvedkin@intel.com>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-2-vladimir.medvedkin@intel.com>
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

On Sat, 30 Aug 2025 17:17:01 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> Currently there are two structutes defined for DCB configuration, one for
> RX and one for TX. They do have slight semantic difference, but in terms
> of their structure they are identical. Refactor DCB configuration API to
> use common structute for both TX and RX.
>=20
> Additionally, current structure do not reflect everything that is
> required by the DCB specification, such as per Traffic Class bandwidth
> allocation and Traffic Selection Algorithm (TSA). Extend rte_eth_dcb_conf
> with additional DCB settings
>=20
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---

This is a good idea, but requires a longer term workflow because of the
API and ABI changes.  Suggest as a first step making a deprecation notice.

The AI review feedback also spotted some things. I would not blindly follow
the recommendations on how to handle field changes.


## DPDK DCB Patch Review (RFC PATCH 1-6/6)

**Series:** DCB configuration refactoring and extension =20
**Author:** Vladimir Medvedkin <vladimir.medvedkin@intel.com> =20
**Status:** RFC

---

### Overall Assessment

This is a significant API/ABI-breaking RFC series that modernizes the DCB (=
Data Center Bridging) configuration API. The changes are architecturally so=
und but require attention to several issues before leaving RFC status.

---

### Patch 1/6: `ethdev: extend and refactor DCB configuration`

**Errors:**
- None

**Warnings:**
1. **Missing release notes** =E2=80=93 This patch makes significant API cha=
nges (unifying `rte_eth_dcb_rx_conf` and `rte_eth_dcb_tx_conf` into `rte_et=
h_dcb_conf`, adding `dcb_tsa[]` and `dcb_tc_bw[]` fields). Per AGENTS.md, A=
PI changes require release notes in `doc/guides/rel_notes/`.

2. **ABI break without documentation** =E2=80=93 Removing the separate Rx/T=
x DCB structures is an ABI break. Needs to follow ABI versioning guidelines.

3. **New API fields not marked experimental** =E2=80=93 The new `dcb_tsa` a=
nd `dcb_tc_bw` arrays should arguably be marked experimental, or the change=
 documented in release notes.

**Info:**
- Line 71 commit body: "structutes" =E2=86=92 "structures" (typo)
- Line 74: "structute" =E2=86=92 "structure" (typo)
- Good that testpmd is updated in the same patch

---

### Patch 2/6: `ethdev: remove nb_tcs from rte_eth_dcb_conf structure`

**Errors:**
- None

**Warnings:**
1. **Missing release notes** =E2=80=93 Removing `enum rte_eth_nb_tcs` and t=
he `nb_tcs` field is an API/ABI break requiring documentation.

2. **Missing Cc: stable@dpdk.org** =E2=80=93 If this is considered a cleanu=
p/fix for hardware abstraction issues, consider tagging for stable.

**Info:**
- Good rationale explaining why `nb_tcs` was a hardware-specific artifact f=
rom ixgbe
- The driver correctly infers TC count from `dcb_tc[]` via popcount

---

### Patch 3/6: `ethdev: decouple VMDq and DCB cofiguration`

**Errors:**
1. **Subject line typo** =E2=80=93 "cofiguration" should be "configuration"

**Warnings:**
1. **Missing release notes** =E2=80=93 Removes `rte_eth_vmdq_dcb_conf` and =
`rte_eth_vmdq_dcb_tx_conf` structures, changes `tx_adv_conf` from union to =
struct.

2. **ABI break** =E2=80=93 Changing `tx_adv_conf` from union to struct chan=
ges memory layout.

**Info:**
- Architecturally sound =E2=80=93 VMDq and DCB should be independently conf=
igurable

---

### Patch 4/6: `ethdev: extend VMDq/DCB configuration with queue mapping`

**Errors:**
- None

**Warnings:**
1. **Missing release notes** =E2=80=93 Moving `q_map` into `rte_eth_conf` a=
nd making it a configuration input (not just output) is a semantic API chan=
ge.

2. **Duplicate macro definition** =E2=80=93 Line 1095-1096 redefines `RTE_E=
TH_DCB_NUM_TCS` and `RTE_ETH_MAX_VMDQ_POOL` which were already defined earl=
ier (lines 1144-1145 in original). The patch moves them but the mbox shows =
both locations =E2=80=93 verify no duplication in final code.

**Info:**
- Line 1107-1108: Comment says "Rx queues" twice =E2=80=93 second should be=
 "Tx queues":
  ```c
  /** Rx queues assigned to tc per Pool */  // line 1103
  ...
  /** Rx queues assigned to tc per Pool */  // line 1108 - should be Tx
  ```

---

### Patch 5/6: `ethdev: remove unused dcb_capability_en field`

**Errors:**
- None

**Warnings:**
1. **Missing release notes** =E2=80=93 Removes `RTE_ETH_DCB_PG_SUPPORT`, `R=
TE_ETH_DCB_PFC_SUPPORT` macros and `dcb_capability_en` field.

2. **Subject line case** =E2=80=93 "dcb_capability_en" contains underscore =
after colon. Per AGENTS.md line 78: "Underscores after the colon (indicates=
 code in subject)". Consider: `ethdev: remove unused DCB capability field`

**Info:**
- Good cleanup =E2=80=93 PFC is now handled via the standard API

---

### Patch 6/6: `ethdev: move mq_mode to [r,t]x_adv_conf`

**Errors:**
- None

**Warnings:**
1. **Missing release notes** =E2=80=93 This is a major ABI break affecting =
virtually all DPDK applications that configure Rx/Tx modes.

2. **Type change from enum to uint32_t** =E2=80=93 Changes `enum rte_eth_rx=
_mq_mode` and `enum rte_eth_tx_mq_mode` to `uint32_t`. While the rationale =
is sound (flags vs enum), this affects type safety.

3. **Deprecation of old enums** =E2=80=93 The enums are converted to `#defi=
ne` macros. Should document that applications using the enum types need upd=
ating.

**Info:**
- Wide-reaching change touching 19 files
- `RTE_ETH_MQ_TX_VMDQ_ONLY` appears to be removed =E2=80=93 verify this is =
intentional

---

### Global Issues (All Patches)

**Errors:**
- None

**Warnings:**
1. **No deprecation notices** =E2=80=93 For this magnitude of ABI change, t=
he DPDK process typically requires deprecation notices in a prior release. =
Since this is RFC, that's acceptable, but should be addressed before final =
submission.

2. **No documentation updates** =E2=80=93 The `doc/guides/` programmers gui=
de sections on DCB configuration will need updating.

3. **Driver coverage** =E2=80=93 Only the ice driver is updated. Other DCB-=
capable drivers (ixgbe, i40e, etc.) will need updates or the series is inco=
mplete.

4. **Missing tests** =E2=80=93 No updates to functional test suite for the =
new TSA/bandwidth configuration fields.

**Info:**
- Good that all patches have proper `Signed-off-by` tags
- Subject lines are within 60 character limit (except for typo in 3/6)
- Commit bodies are well-written and explain the rationale

---

### Summary Table

| Patch | Subject OK | S-o-b | Release Notes | Tests | Verdict |
|-------|-----------|-------|---------------|-------|---------|
| 1/6 | =E2=9C=93 | =E2=9C=93 | Missing | Partial | Needs Work |
| 2/6 | =E2=9C=93 | =E2=9C=93 | Missing | =E2=9C=93 | Needs Work |
| 3/6 | Typo | =E2=9C=93 | Missing | =E2=9C=93 | Needs Work |
| 4/6 | =E2=9C=93 | =E2=9C=93 | Missing | =E2=9C=93 | Needs Work |
| 5/6 | Warning | =E2=9C=93 | Missing | =E2=9C=93 | Needs Work |
| 6/6 | =E2=9C=93 | =E2=9C=93 | Missing | N/A | Needs Work |

---

### Recommendations

1. Fix typo in patch 3/6 subject: "cofiguration" =E2=86=92 "configuration"
2. Add release notes documenting all API/ABI changes
3. Add deprecation notice for the removed enums and structures
4. Update DCB documentation in programmer's guide
5. Consider adding functional tests for new TSA/bandwidth fields
6. Address comment typo in patch 4/6 (Rx vs Tx queues)
7. Verify all DCB-capable drivers are updated or document which drivers sup=
port the new API
8. Consider experimental marking for new fields if uncertain about final AP=
I shape
