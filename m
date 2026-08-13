Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33C1C5AC67
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 03:37:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE1EF40281;
	Thu, 13 Aug 2026 05:37:36 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 248BB4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 05:37:35 +0200 (CEST)
Received: from debian (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 4FF27E0BA6;
 Thu, 13 Aug 2026 07:37:33 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 4FF27E0BA6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786592253;
 bh=+rJNTZXeByYmQ5jpNlD228xK2n6WszHckCqcUqECsCE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=XhXTbbYYRSoZC5v3uTl48raAyI2QY+IR3a/mLzJaEeJ1+Ga6NjYXCWyBIkGDsqoP2
 mxZWRd9MD04ngltf8Zg+2/pWPLmHqNnJnP4FTJ+GdRWhc9TVNowD14AOklyL6aw1aF
 Rw2oAYx5Hgd4CSetAZNYUJGwfWG5ZgnC9y8jaG56H4qLsXMpwAoLdWrrnHAKQ4Obi7
 DfB5HaqV4h2DXxuSAoGBoN0hHK4IGJX1t0UrHFo+4q8o5cF7B6hQynoAtttNCyQqul
 XhLj9DFUoPqq2JagARxtFM2qWry9pkQ9HBZb+UBk2YvyJFna4lye64cGG67cUhBWjK
 vA23EEjI4XMQw==
Date: Thu, 13 Aug 2026 07:37:31 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, 
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>, 
 Roman Zhukov <Roman.Zhukov@arknetworks.am>, 
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 00/14] common/sfc_efx/base: fix code analysis issues
In-Reply-To: <20260812193503.46521753@phoenix.local>
Message-ID: <321130e3-7247-0b91-4f87-76ee7ac0b7cf@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260812170834.8443-1-ivan.malov@arknetworks.am>
 <20260812193503.46521753@phoenix.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1505296835-1786592253=:7384"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1505296835-1786592253=:7384
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Dear Stephen,

If I may, I should like to point out the following:

- Patch 11/14:
   The classification of the issue as an 'error' does not hold water. First of all, no real operability issue is observed in practice; hence, this warrants, at most, the status of a warning, not an error. Secondly, the 'count' and 'stride' are fields of the firmware's own response. A successful MCDI response is self-consistent and shall not be treated as adversarial. Furthermore, the MCDI layer explicitly clamps 'emr_out_length_used' to 'emr_out_length', the allocated output buffer size, so a buffer overrun should not be possible. The note thus does not meet the threshold of an actual defect.

- Patch 13/14:
   The default of 'TECH_AUTO' when 'flags_seen == 0' is deliberate: it is the correct instruction to the firmware when the capability map yields no technology preference, and 'TECH_NONE' would be semantically incorrect in a fixed-link context. The commit message describes the refactoring; exhaustive documentation of an edge-case path does not belong in such changes. Therefore, the review note does not meet the threshold of an actual defect.

- Patches 01–04:
   The comment on 'EFX_MCDI_BUF_SIZE' [1] explains in no uncertain terms that the rounding requirement exists to accommodate Siena on-chip buffers. The note does not apply to the modern adapters currently supported by the DPDK driver. No actual defect.

- Patch 05/14:
   In production builds, 'EFSYS_ASSERT' is elided. A NULL check is the correct defensive posture for upstream code and accurately reflects the '__in_opt' semantics at the call site.

- Patches 09/14 and 13/14:
   The convention cited applies to 'boolean_t'-returning functions carrying '__checkReturn', where '__success', '__checkReturn', and the return type all annotate the return value and naturally share a line. The functions in question, however, return 'void', carry no '__checkReturn', and express the success condition on an output parameter. The note is thus not valid at all; the placement stands.

On these premises, I respectfully suggest that the series be put forward for reconsideration and integration.

[1] https://github.com/DPDK/dpdk/blob/c1a46b9d9243e922428e8a5f87fa3c6ac177dc5a/drivers/common/sfc_efx/base/efx_mcdi.h#L582

Thank you.

On Wed, 12 Aug 2026, Stephen Hemminger wrote:

> On Wed, 12 Aug 2026 21:08:20 +0400
> Ivan Malov <ivan.malov@arknetworks.am> wrote:
>
>> This series addresses code analysis defects in the
>> common/sfc_efx/base library.
>>
>> The first four patches fix excessive stack consumption in
>> MCDI helper functions, each exceeding 1 KB on-stack, by
>> switching to heap-allocated payload buffers.
>>
>> The remaining ten patches correct SAL annotations, add NULL
>> checks across netport and filter helpers, resolving
>> uninitialised memory, buffer overrun, and potential
>> dereference issues. The final patch widens loop
>> variable types to address a CodeQL warning.
>>
>>
>> v2:
>>
>> - note for the future AI reviews: apply this on top of
>>   the 'next-net-main' branch
>
>
> Still has AI review issues.
>
> Reviewed v2 applied on c1a46b9 ("doc: remove unreferenced KNI and
> examples figures"). All 14 apply cleanly. Comparing commit contents
> against v1, only patches 11 and 13 have real changes; 12 differs only
> in hunk offsets.
>
> Addressed since v1, all correct as far as I can tell:
>
> - 11/14 now reads MORE_ENTRIES with MCDI_OUT_DWORD_FIELD against
>   MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS, so only LBN 0 is tested.
> - 13/14 adds matched_mask so *enum_hwp is written only on the first
>   match per SW flag. That restores the original selection order that
>   the removed "mask_sw &= ~(flag_sw)" used to provide, including the
>   case where several distinct SW flags are set.
> - 13/14 passes cap_enum_hw rather than MC_CMD_FEC_AUTO as the default,
>   so a request with no FEC bits keeps MC_CMD_FEC_NONE.
> - __success() placement is now consistent between 09/14 and 13/14.
>
> Patch 11/14: common/sfc_efx/base: fix flex array in netport stat describe
>
> Error: count and stride are still used to index the response buffer with
> no bound derived from the response length. This was the main finding on
> v1 and is unchanged:
>
> 	stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
> 	count = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT);
> 	...
> 		for (i = 0; i < count; ++i) {
> 			efx_np_stat_describe(entries + i * stride,
>
> Both fields come from firmware. entries points at payload + 20 in a
> 1020-byte allocation and efx_np_stat_describe() reads 8 bytes per entry,
> so any count above (out_sz - 20) / stride reads bytes that were never
> written, and count * stride above 1000 reads past the end of the
> allocation. The old ENTRIES_NUM(out_sz) expression was wrong for
> stride > 8, as the commit message says, but it did bound the loop by the
> data actually received; nothing replaces that bound.
>
> 	if (stride < MC_CMD_STAT_DESC_LEN ||
> 	    count > (out_sz -
> 		     MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_OFST) /
> 		    stride) {
> 		rc = EMSGSIZE;
> 		goto fail4;
> 	}
>
> The stride test has to come first, otherwise stride == 0 divides by
> zero.
>
> Patch 13/14: common/sfc_efx/base: rework SW mask to HW enum converter
>
> Warning: In the fixed-link branch the programmed technology still
> changes. link_tech is initialised to MC_CMD_ETH_TECH_NONE and previously
> stayed NONE when no requested tech bit was present in the map; passing
> MC_CMD_ETH_TECH_AUTO as enum_hw_def now overwrites it. Unlike the FEC
> call, which v2 changed to pass the pre-computed value, this one keeps
> the hardcoded default. That may well be the intent, but the commit
> message is unchanged from v1 and still describes the patch only as a
> refactor plus annotation fix; it does not mention the new enum_hw_def
> parameter or this behaviour change. Please say so in the commit message,
> or pass link_tech to keep the old value.
>
> Patch 01-04: common/sfc_efx/base: reduce stack in ...
>
> Info: Unchanged from v1, repeating for the record. The four conversions
> open-code MAX(IN_LEN, OUT_LEN) where EFX_MCDI_BUF_SIZE() exists and also
> rounds up to a dword multiple and enforces a two-dword minimum. The
> rounding matters because ef10_mcdi_send_request() reads the payload a
> full dword at a time. All four current lengths are dword multiples so
> there is no defect today, but the property is lost for future length
> changes.
>
> Patch 05/14: common/sfc_efx/base: fix filter saved spec handling
>
> Info: Unchanged from v1. Both added NULL checks are unreachable:
> saved_spec == NULL forces EF10_FILTER_ADD_NEW in
> ef10_filter_add_select_action(), so ADD_STORE and ADD_REPLACE both imply
> a non-NULL saved_spec. The __in_opt annotations are right; the STORE
> branch already asserts its sibling invariant one line above, so
> EFSYS_ASSERT(saved_spec != NULL) would match local style rather than
> silently skipping the efs_overridden_spec assignment.
>
> Patch 09/14 and 13/14
>
> Info: The two are consistent with each other now, but both put
> __success() on its own line above "static". Existing uses in the tree
> put it on the return type line, e.g. ef10_nvram.c:941
>
> 	__checkReturn	__success(return != B_FALSE)	boolean_t
> 	ef10_nvram_buffer_find_item(
>
>
--8323328-1505296835-1786592253=:7384--
