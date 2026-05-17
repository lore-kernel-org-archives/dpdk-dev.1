Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D61CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA2E440661;
	Mon, 18 May 2026 01:56:27 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id CBBD24065B
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:26 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ff5472f263so1462955eec.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062186;
 x=1779666986; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me3ZxegVjcd1L+v5SRnJqQZs86tfYDd1iCYtW9P13wg=;
 b=jetu3SJ+r3c/bfV7v5wIZCY1GLG/QQtZ6R5rtIDtHLXL1HBtgNG+r3QxQOZ8g9syrW
 YGJ3OEQPwqd7F/HlLe4AMTFTOwllo49VJXLscEJ7clQE34tFx2pXXlRhUXM+5PCdDb8X
 BtFrlXbCnQzHQA9KKCV1n6ed1OKW3jNGtoA0PLOS/CfotA2/LhH1d1c3WfoFSy/N1xvN
 KrOkGVgtomuQ2ZfRptUBs7R1zNkYJuOdMvcwInJcuUPfyOzXLW0lkguw95L9FRNzekf5
 kueUA0rcAxCIkhdw842BtIutIXDxVlv+EowCrdoDCdLxV7DBJaa7UDD2Fm4H7q5zNNw4
 Tlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062186; x=1779666986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=me3ZxegVjcd1L+v5SRnJqQZs86tfYDd1iCYtW9P13wg=;
 b=jLy4oYeE48EQHoQpRI459ue3au3X4u1S84Js1RBVRa9Qn8Qm9YfkcH3g8n0C1z0AyV
 6VFkAbZwd94121rcwKWq3rglfKal/tWOwi99qWVoay5YsimrhqphW7KIEXOCy+SGxkeb
 7uJ+TiHN3TH0TQjnV5l+rvq4qo9ovcRNB+6Y/Wxx3cgoMdJE5ckg/6wICnMnNUprE5iD
 ciOtarIDTmDLUIcYW9tM4Vx45umPujDrrO8NQvGvW7T/Y1x7xjbonmAw5sH/cR/LJNji
 OPz+uJ6MMoWFNE1Z1yDgn1cD3V40/6RHPIVe6TK9uto61smbQfWiDDcq12evVO3PGbZ+
 7wig==
X-Gm-Message-State: AOJu0YxzUkJ0K9L8XV1K6paogTvKpRTsdD3M7HiqrIHcc6t2NgbDZvZ0
 wkZx76Sfv+k58q0sJo1sszPaxwaleGXl42FLUrQ1NJDQqpaQ61E+yoLyX3DOlHnkavs=
X-Gm-Gg: Acq92OG3Zs4vo8PkXis885p2WvRaCAWIK1Rn+IctADxRxigTIlhyWCzusc9oz8nFbTd
 OsscIDYnC1ou4aSJ8ZqwaKKL0t4J4SrHY+nghWi28huT9qbruYMNC2Q7JxWcSjCh1XbctdxVaHf
 DEuOXu2awqALxU7u1QOPDMUq57QDanAictLq4Bj8JYeZza0qmJdzEzYEecC/tPLvkHjyerWWgoK
 hwmwCce0GhWwheMv6gq7nH5lMuQ8AifS98KYtJJhffFa6bT03nyjUpk6J9B0vVhEcBx43d41mEN
 /B4Gb/3BU2ut3FwDeHPaE1LIrf1q2bAxt9AMmB1pt4Z8VVCRxrpNEb/7LV/sitahCwMy8xxMLr0
 w55Q8/yfmRF2lVxPNg5oe4KN9I3JwyPl8gzsNtu0IE+uBs2vmA3apNRQiJxaGiTVDhWpdHm5QKb
 NIIKK+BbHUaUuHORXKsi4cj7Ra8/Bw0Yr6LuzsAEB8fjoFmw==
X-Received: by 2002:a05:7301:608c:b0:2ed:e14:42e7 with SMTP id
 5a478bee46e88-303986bbed2mr5470889eec.32.1779062185850; 
 Sun, 17 May 2026 16:56:25 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:25 -0700 (PDT)
Date: Sun, 17 May 2026 16:37:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 03/20] net/ngbe: add missing CDR config for YT PHY
Message-ID: <20260517163740.52739478@phoenix.local>
In-Reply-To: <20260511103604.19724-4-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-4-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:45 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> According to the PHY vendor, when YT8531S operates in UTP-to-Fiber or
> RGMII-to-Fiber mode with auto-negotiation disabled (Force mode),
> additional CDR (Clock Data Recovery) configuration is required to
> improve link connectivity. Without this config, link may be unstable
> or fail to establish.
> 
> Fixes: f1268369403d ("net/ngbe: support autoneg on/off for external PHY SFI mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Semi-automated AI review feedback.

# DPDK Patch Review - net/ngbe: add missing CDR config for YT PHY

## Summary
This patch adds Clock Data Recovery (CDR) configuration for YT8531S PHY in Force mode (auto-negotiation disabled). No errors found.

---

## CORRECTNESS BUGS
None identified.

---

## WARNINGS

### 1. Missing error checks on PHY register writes
**File:** `drivers/net/ngbe/base/ngbe_phy_yt.c`  
**Lines:** 267-268

The two `ngbe_write_phy_reg_sds_ext_yt()` calls do not check return values. If these PHY register writes fail, the link may be unstable (the exact problem this patch aims to fix), but the function will silently continue.

**Current code:**
```c
/* force mode need to config cdr */
ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, 0x1434);
ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, 0x163);
value = YT_BCR_RESET | YT_BCR_DUPLEX;
```

**Suggested fix:**
```c
/* force mode need to config cdr */
s32 ret;
ret = ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, 0x1434);
if (ret != 0)
	return ret;
ret = ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, 0x163);
if (ret != 0)
	return ret;
value = YT_BCR_RESET | YT_BCR_DUPLEX;
```

Note: This assumes `ngbe_write_phy_reg_sds_ext_yt()` returns 0 on success, negative on failure (standard DPDK convention). The existing code pattern in the function does not check errors on PHY writes in the auto-negotiation path either (lines 264-265), so this may be intentional design. However, for a fix addressing link stability, propagating write failures would be more robust.

---

## INFO

### 1. Magic numbers in PHY register writes
**File:** `drivers/net/ngbe/base/ngbe_phy_yt.c`  
**Lines:** 267-268

The CDR configuration uses literal hex values `0x1434` and `0x163` without named constants or comments explaining their meaning. This is vendor-specific configuration. Consider adding a comment referencing the PHY vendor documentation or datasheet section, or defining named constants if these values are used elsewhere.

Example:
```c
/* CDR config per YT8531S datasheet section X.Y for Force mode */
#define YT_CDR_CONFIG_REG3  0x1434
#define YT_CDR_CONFIG_REGE  0x163
ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, YT_CDR_CONFIG_REG3);
ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, YT_CDR_CONFIG_REGE);
```

This is a style suggestion, not a requirement, and may be deferred if the vendor documentation is not publicly available or these values are unique to this use case.
