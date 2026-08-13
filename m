Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADDC5AD5A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0069D402B8;
	Thu, 13 Aug 2026 04:35:19 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id B9A8A4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:35:17 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2727265a91.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786588516;
 x=1787193316; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n2JjjNBMFI6CklhCQ52rleQkiFyEdwu+R72OS8cJNOg=;
 b=isimkU6InQVNhHljdGspb6ptHKmQ8KE93o9MHk1fMNTH6HfKnbsrdq7/IKIlV4TFxv
 UwW6cyE9CNZMLt+FFLmpuH6NGBO/dMYnpSvF1PqnvPu2kK3m2LVru/uSUphMiKmX3Cru
 yJOTd3QW2Hqvo4202c+8PloMRN7t8cYR1qGIJ33R8tdQ/wvvy1vZKsyZspB0jL1zZ+4M
 wRvo1CUOi5rLbmfSc1ev5WTuimvbj4Y7ye9r51v+brnksEW9ZPLpIGvwvUh5euSxwtfT
 kMm/wAyod8bG0gSFwrKkSdKZjXVqHqqK1SILWai7xVPb6FPTGBZlJWXlz/MmK7A6uMh+
 Xiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588516; x=1787193316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n2JjjNBMFI6CklhCQ52rleQkiFyEdwu+R72OS8cJNOg=;
 b=q6ehetFn41qaU9NM31tyPfTAaJJ3KWiMHgAhR1QbSqwJyZGCaKZZab9CafqoCLQVHR
 bgeNlT+7Oyxjeht2CTQtM2zQu1he+N5ORnwZYWnMVuo3EeyVgDhXdHkxBxzzsVCGYiAi
 uLLKTcMTXJRiJ9fokTg4abpcGGXjy7SriOKYyHqrqIKfZgNsZDPkE5SYCzCE1UF+9+bM
 MBiApbGoY8Z7G15be8dIottPewst1Yt4WYjtxVevN6VbJQNsHXHxCg202V/ok+rZDWUd
 snSqUchGCGFDc2j2hR8RfrQvJKnNnzBrZ8NcINHkTy93p3hW0hMzGqh3I6jZfkU1vqWG
 Sfsw==
X-Gm-Message-State: AOJu0YyK0KfQCjupWMpjG9GmUpd2N3R779FIN824Kna13tPvpnRXwALJ
 WyHB0e+zzuvtV/aOs9SROYHw7c1DmEpT2mpaG3r9xsp3t/DDIDit7AynfLOHpuqVIgM=
X-Gm-Gg: AR+sD11DK1pspKPhUu0+27pGS+bzamRqCuMFBxi14E8xsOIKc7rScWtckJ9+2KLmJ+n
 3BkEb3u+r2KIc6cZxer4lmiWqjtoa+RoumcsTPRx6J7YrFw8WrpAozXfw0RrIF6LDxcl6Rz2PaD
 RfoJpbfCzGGviwhFP18WMX8/saN/uaYAB/YVZ28OgrDTywQgD3f9MrQ7F8gozTrU5LlS79F4Wzy
 7v80ROsK5nG/tk6QfDFozVu9I8dOQb5IVprRgGmKS5WjauRM05uQh8dxGy44b8XV+EBdihwhmkc
 /Ytey4rg6s7/ffPNLmEA9oq7jT9xhPTn6NWrgEFJEBjQrQHNzueNSBiQXCDpvFOmvphg66wDcek
 Sj2KFkTAg6mWhwAHLWHsUOS/M9COcEABmgwjj0b9gXWeVfR7dJZL+qTlRvnSSrVc3srraK44QHQ
 SM87pogI2zHROpxTV0EGUNJZITmH3scIiYkXe2QN1SOx1ILLLbUyCygxA7WPVMFqITsVSkriY+s
 ZunbfZkdoKYbZzDwDTo9yIzqYfWUQ==
X-Received: by 2002:a05:6a21:7117:b0:3b4:8f57:3205 with SMTP id
 adf61e73a8af0-3cc55432ae4mr3815985637.36.1786588516365; 
 Wed, 12 Aug 2026 19:35:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec002e857sm2138236eec.23.2026.08.12.19.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:35:16 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:35:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 00/14] common/sfc_efx/base: fix code analysis issues
Message-ID: <20260812193503.46521753@phoenix.local>
In-Reply-To: <20260812170834.8443-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260812170834.8443-1-ivan.malov@arknetworks.am>
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

On Wed, 12 Aug 2026 21:08:20 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series addresses code analysis defects in the
> common/sfc_efx/base library.
> 
> The first four patches fix excessive stack consumption in
> MCDI helper functions, each exceeding 1 KB on-stack, by
> switching to heap-allocated payload buffers.
> 
> The remaining ten patches correct SAL annotations, add NULL
> checks across netport and filter helpers, resolving
> uninitialised memory, buffer overrun, and potential
> dereference issues. The final patch widens loop
> variable types to address a CodeQL warning.
> 
> 
> v2:
> 
> - note for the future AI reviews: apply this on top of
>   the 'next-net-main' branch


Still has AI review issues.

Reviewed v2 applied on c1a46b9 ("doc: remove unreferenced KNI and
examples figures"). All 14 apply cleanly. Comparing commit contents
against v1, only patches 11 and 13 have real changes; 12 differs only
in hunk offsets.

Addressed since v1, all correct as far as I can tell:

 - 11/14 now reads MORE_ENTRIES with MCDI_OUT_DWORD_FIELD against
   MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS, so only LBN 0 is tested.
 - 13/14 adds matched_mask so *enum_hwp is written only on the first
   match per SW flag. That restores the original selection order that
   the removed "mask_sw &= ~(flag_sw)" used to provide, including the
   case where several distinct SW flags are set.
 - 13/14 passes cap_enum_hw rather than MC_CMD_FEC_AUTO as the default,
   so a request with no FEC bits keeps MC_CMD_FEC_NONE.
 - __success() placement is now consistent between 09/14 and 13/14.

Patch 11/14: common/sfc_efx/base: fix flex array in netport stat describe

Error: count and stride are still used to index the response buffer with
no bound derived from the response length. This was the main finding on
v1 and is unchanged:

	stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
	count = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT);
	...
		for (i = 0; i < count; ++i) {
			efx_np_stat_describe(entries + i * stride,

Both fields come from firmware. entries points at payload + 20 in a
1020-byte allocation and efx_np_stat_describe() reads 8 bytes per entry,
so any count above (out_sz - 20) / stride reads bytes that were never
written, and count * stride above 1000 reads past the end of the
allocation. The old ENTRIES_NUM(out_sz) expression was wrong for
stride > 8, as the commit message says, but it did bound the loop by the
data actually received; nothing replaces that bound.

	if (stride < MC_CMD_STAT_DESC_LEN ||
	    count > (out_sz -
		     MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_OFST) /
		    stride) {
		rc = EMSGSIZE;
		goto fail4;
	}

The stride test has to come first, otherwise stride == 0 divides by
zero.

Patch 13/14: common/sfc_efx/base: rework SW mask to HW enum converter

Warning: In the fixed-link branch the programmed technology still
changes. link_tech is initialised to MC_CMD_ETH_TECH_NONE and previously
stayed NONE when no requested tech bit was present in the map; passing
MC_CMD_ETH_TECH_AUTO as enum_hw_def now overwrites it. Unlike the FEC
call, which v2 changed to pass the pre-computed value, this one keeps
the hardcoded default. That may well be the intent, but the commit
message is unchanged from v1 and still describes the patch only as a
refactor plus annotation fix; it does not mention the new enum_hw_def
parameter or this behaviour change. Please say so in the commit message,
or pass link_tech to keep the old value.

Patch 01-04: common/sfc_efx/base: reduce stack in ...

Info: Unchanged from v1, repeating for the record. The four conversions
open-code MAX(IN_LEN, OUT_LEN) where EFX_MCDI_BUF_SIZE() exists and also
rounds up to a dword multiple and enforces a two-dword minimum. The
rounding matters because ef10_mcdi_send_request() reads the payload a
full dword at a time. All four current lengths are dword multiples so
there is no defect today, but the property is lost for future length
changes.

Patch 05/14: common/sfc_efx/base: fix filter saved spec handling

Info: Unchanged from v1. Both added NULL checks are unreachable:
saved_spec == NULL forces EF10_FILTER_ADD_NEW in
ef10_filter_add_select_action(), so ADD_STORE and ADD_REPLACE both imply
a non-NULL saved_spec. The __in_opt annotations are right; the STORE
branch already asserts its sibling invariant one line above, so
EFSYS_ASSERT(saved_spec != NULL) would match local style rather than
silently skipping the efs_overridden_spec assignment.

Patch 09/14 and 13/14

Info: The two are consistent with each other now, but both put
__success() on its own line above "static". Existing uses in the tree
put it on the return type line, e.g. ef10_nvram.c:941

	__checkReturn	__success(return != B_FALSE)	boolean_t
	ef10_nvram_buffer_find_item(

