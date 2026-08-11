Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14995C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 20:24:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 170F44025F;
	Tue, 11 Aug 2026 22:24:08 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id D0E074021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 22:24:05 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38e347638adso396754a91.0
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786479845;
 x=1787084645; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8X32+bjg1zxUfGM2W586gP71//rD4H9l7iS/55HNqEc=;
 b=BvRKG/a1QL3qFmqggI8nZ3mDr7lH8bIzVn2weOY/HNc5uvV6RabM9s51p6r/ovl0Io
 fBzIDNfJLcuRfoEGdwLwjuxUh1V9A3XAnCD5k6laVYeuH0Y2DGPx6FnWpvOLzDY3lY01
 /JXPnB1jaBWW5R11Pyle3kFVcU7Mqn2uzlb10KtXNen/RZpUK+WbwC/Z93qBCgUdkUzY
 uQ930AjGUKH7cyKzhiYIaEhZVOe8AVdaZMQvv8Bz+lDqsTabBWH57HYRvkBBa4Fg/qCK
 XjO1FOSAwW9N9rhLkRgLGj1W592ED7OPyAI4tAb0mJvJU7U//0f18AMr4R0CXacHWcQp
 ERCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786479845; x=1787084645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8X32+bjg1zxUfGM2W586gP71//rD4H9l7iS/55HNqEc=;
 b=UnAsuzdFDY6MALSXzDYrOtCETEUf+8hCmChGw5jqHuesj/iLfR6q6am1vBV0mFvsN6
 10oh1t1PIP4zceqNhh63BUzhDmB/XbNAWIorLylVJF2Wq5RJDpU8UXNJl7QQetkbhdRn
 bREylmesy5fI2mIMHboSgWkJuwx58aez6JJ0eLtyiuelR+pNK9BCuUJ9+yTfAwcuT82Z
 esCNzfaXi7VbI6zyLzy4Q60gf0d4Sl9VGqa/ka1uvcykqSSeZ3G0no5vYk7Xk60VJJrX
 L8ivV4JAc9wp4LwlOU8YAsbEvyPa/XyBZOoqVBuWxSXdaaOvbqkudDeOtLx3dg1ZTzZr
 O7nw==
X-Gm-Message-State: AOJu0YzdvVxpQMSFR/mn/DS4VwruUSktkIouBOxHe52tYfC53bQ5HID0
 G20QgGUlPFTHy+Jysci7WCD4o+2h5lfIS1vxpygfLprY4NhdnivBOKccHyEdsJ97znk=
X-Gm-Gg: AR+sD11Ip/qKmSUCIe83UmTkmVxCO/On+SPSMvZz7IPeZOZpwbD2i9z/fooEmfNx5Js
 mRnIEgoyL13ul2EGovu4H/xlErwRk0BRT5T9sLI6DCyppwWWJbQ7fDeqmC+PiCtbvtE9gDEMaLp
 XkAM95SqxBarIpJnqYVUrjY9xu7GbgJc/iMEdboMRaEfRp0kf8876ySguHR+wKX9+TP/s5Y16XL
 H52nLNLWYNQea8pu7BeHfIgWeXOPvsP8evNHKozLyQ4ZM6sm97Gt7GsIyXSJbI7lHaYlsFDWnOA
 PeQ9g+13PzcvoSYXJVMeMtxcPo1+StvM1mHhI1WVNOtPFpWphQ7g8egzaVsNj79DRL+v/bOgFc3
 7PTgVbtM0Z4GeezSLv2BAjUbIIV1LHIqrDmcvBvbtjjPCO8RMJNUJwWXhT7E6SpJdaj54xAzwvV
 DChpGf3s5DWCkqim5QxG8zriZ77X2tOitWG7JMn8hOSdcZvvPm0NmfJiMzdBDMN9v18jxjvzqJD
 YZ7I+WiS9TXZx04V1FIrpiYWgM8tQ==
X-Received: by 2002:a17:90b:2248:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-392ec662df2mr5921058a91.16.1786479844618; 
 Tue, 11 Aug 2026 13:24:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14124454d3csm2444121c88.2.2026.08.11.13.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 13:24:04 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:24:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 00/14] common/sfc_efx/base: fix code analysis issues
Message-ID: <20260811132401.4ef4391d@phoenix.local>
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

On Tue, 11 Aug 2026 21:48:07 +0400
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
> Andy Moreton (14):
>   common/sfc_efx/base: reduce stack in RSS context table write
>   common/sfc_efx/base: reduce stack in get addr regions MCDI
>   common/sfc_efx/base: reduce stack in set addr regions MCDI
>   common/sfc_efx/base: reduce stack in netport stat describe
>   common/sfc_efx/base: fix filter saved spec handling
>   common/sfc_efx/base: fix annotations in client MAC addr get
>   common/sfc_efx/base: fix annotations in HW-SW mask converter
>   common/sfc_efx/base: fix annotations in get fixed port props
>   common/sfc_efx/base: fix annotations in SW-HW enum converter
>   common/sfc_efx/base: fix annotation in netport stat describe
>   common/sfc_efx/base: fix flex array in netport stat describe
>   common/sfc_efx/base: fix filter in SW-HW mask converter
>   common/sfc_efx/base: rework SW mask to HW enum converter
>   common/sfc_efx/base: cleanup wider type comparisons in loops
> 
>  drivers/common/sfc_efx/base/ef10_filter.c |  11 +-
>  drivers/common/sfc_efx/base/ef10_mcdi.c   |   2 +-
>  drivers/common/sfc_efx/base/ef10_nvram.c  |   4 +-
>  drivers/common/sfc_efx/base/ef10_rx.c     |  22 +++-
>  drivers/common/sfc_efx/base/efx.h         |   3 +-
>  drivers/common/sfc_efx/base/efx_bootcfg.c |   2 +-
>  drivers/common/sfc_efx/base/efx_mcdi.c    |  50 +++++--
>  drivers/common/sfc_efx/base/efx_np.c      | 152 ++++++++++++----------
>  drivers/common/sfc_efx/base/mcdi_mon.c    |   2 +-
>  9 files changed, 155 insertions(+), 93 deletions(-)
> 

Since AI review by CI is limited. Went with more detailed review
and it spotted lots of issues.

Reviewed the series applied on top of c1a46b9 ("doc: remove unreferenced
KNI and examples figures"). All 14 patches apply cleanly.

Patch 01-04: common/sfc_efx/base: reduce stack in ...

Info: All four conversions replace EFX_MCDI_DECLARE_BUF() with a plain
MAX(IN_LEN, OUT_LEN) size for EFSYS_KMEM_ALLOC. That drops the two
guarantees the macro provides:

  #define EFX_MCDI_BUF_SIZE(_in_len, _out_len)                          \
        EFX_P2ROUNDUP(size_t,                                           \
                MAX(MAX(_in_len, _out_len), (2 * sizeof (efx_dword_t))),\
                sizeof (efx_dword_t))

The dword rounding is not cosmetic: ef10_mcdi_send_request() reads the
payload a full dword at a time

        for (pos = 0; pos < sdu_len; pos += sizeof (efx_dword_t))
                dword = *(efx_dword_t *)((uint8_t *)sdup + pos);

so a non-dword-multiple allocation would be read past its end. For these
four call sites the lengths happen to be dword multiples (4+4*n, 992,
8+8*n, 1020), so there is no defect today, but open-coding MAX() removes
the property for future length changes. Suggest

        size = EFX_MCDI_BUF_SIZE(MC_CMD_..._IN_LEN(n), MC_CMD_..._OUT_LEN);

which is a drop-in and keeps the invariant documented in efx_mcdi.h.

Error path handling in all four is correct: the ENOMEM label sits below
the EFSYS_KMEM_FREE so the failed allocation is not freed, and every
later label falls through to it.

Patch 05: common/sfc_efx/base: fix filter saved spec handling

Info: The two added NULL checks are unreachable. In
ef10_filter_add_select_action(), saved_spec == NULL forces
*action = EF10_FILTER_ADD_NEW; every path that yields ADD_STORE,
ADD_REPLACE or ADD_REFRESH is inside the else branch where saved_spec is
non-NULL. So in ef10_filter_add_execute_action() both

        } else if (action == EF10_FILTER_ADD_STORE) {
                EFSYS_ASSERT(overridden_spec != NULL);
                if (saved_spec != NULL)

and

        if ((action == EF10_FILTER_ADD_REPLACE) && (saved_spec != NULL)) {

test an invariant that already holds. The __in_opt annotations are
accurate and worth keeping, but the STORE branch already asserts its
sibling invariant one line above; an EFSYS_ASSERT(saved_spec != NULL)
would match local style and keep the invariant explicit rather than
silently skipping the efs_overridden_spec assignment if it were ever
violated.

Patch 09: common/sfc_efx/base: fix annotations in SW-HW enum converter

Info: __success() is placed above "static void" here, but in patch 13 it
is placed between "static void" and the function name. Every existing
use in the tree puts it on the return type line, e.g. ef10_nvram.c:941

        __checkReturn   __success(return != B_FALSE)    boolean_t
        ef10_nvram_buffer_find_item(

Please pick one placement for both patches, preferably the existing one.

Patch 11: common/sfc_efx/base: fix flex array in netport stat describe

Error: count and stride are firmware-supplied and are now used to index
the response buffer with no bound derived from the response length:

        stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
        count = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT);
        ...
                for (i = 0; i < count; ++i) {
                        efx_np_stat_describe(entries + i * stride,

entries points at payload + 20 in a 1020-byte allocation, and
efx_np_stat_describe() reads 8 bytes at each entry. Any count beyond
(out_sz - 20) / stride reads response bytes that were never written, and
count * stride above 1000 reads past the end of the heap allocation.

The old code derived the iteration count from out_sz via
MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_NUM(out_sz), which was
wrong for stride > 8 as the commit message says, but it did bound the
loop by the data actually received. The replacement needs to validate
both fields, e.g. after reading them:

        if (stride < MC_CMD_STAT_DESC_LEN ||
            count > (out_sz -
                     MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_OFST) /
                    stride) {
                rc = EMSGSIZE;
                goto fail4;
        }

The stride test must come first, since stride == 0 is otherwise a
division by zero.

Warning: MORE_ENTRIES is a one-bit field inside FLAGS:

        MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS_OFST 8
        MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_OFST 8
        MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_LBN 0
        MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_WIDTH 1

but the patch reads the whole 32-bit FLAGS dword and tests it against
zero. Any future flag bit added to FLAGS makes (count == 0 && more != 0)
fail a legitimate final response with EMSGSIZE, which fails
efx_np_stats_assign() and therefore probe. Use the field accessor:

        more = MCDI_OUT_DWORD_FIELD(req,
            MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS,
            MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES);

Patch 13: common/sfc_efx/base: rework SW mask to HW enum converter

Error: The FEC default overwrites the deliberate MC_CMD_FEC_NONE choice.
Just above the call, efx_np_link_ctrl() computes

        if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) == 0)
                cap_enum_hw = MC_CMD_FEC_NONE;
        else
                cap_enum_hw = MC_CMD_FEC_AUTO;

and the comment below it still says "If the mask has got no
'FEC_REQUESTED' bits, use 'NONE' or 'AUTO' from above." Before this
patch that worked because *enum_hwp was left untouched when nothing
matched. Now the flags_seen == 0 path unconditionally assigns the
default, and the call passes a hardcoded MC_CMD_FEC_AUTO:

        EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
            ETH_AN_FIELDS_FEC_MASK, cap_data_raw, cap_mask_sw,
            MC_CMD_FEC_AUTO, NULL, NULL, &supported, &cap_enum_hw);

So a request with no FEC bits at all now programs FEC_MODE = AUTO
instead of NONE, i.e. a user asking for no FEC gets negotiated FEC.
Passing cap_enum_hw itself as the default preserves the intent.

Error: The selection order changes from first supported HW enum to last.
The old loop cleared the matched bit

        mask_sw &= ~(flag_sw);
        if (enum_hwp != NULL)
                *enum_hwp = hw_sw_map->encm_hw;

so later map entries carrying the same encm_sw failed the
(mask_sw & flag_sw) == flag_sw test and could not overwrite *enum_hwp.
The new loop has no clearing, so every match overwrites and the last
entry wins. efx_np_cap_map_tech is one-to-many: EFX_PHY_CAP_100000FDX
maps to fifteen MC_CMD_ETH_TECH_* values, so with the default lane count
(filter returns B_TRUE for everything) a fixed-link 100G request now
programs 100GBASE_CR10 where it previously programmed 100GBASE_KR4.
That is a functional change, not a simplification. If the previous
selection is intended, break out of the loop on the first match.

Warning: In the fixed-link branch the default changes the programmed
technology as well. link_tech is initialised to MC_CMD_ETH_TECH_NONE,
and previously stayed NONE when no requested tech bit was present in the
map; it is now overwritten with MC_CMD_ETH_TECH_AUTO. This may well be
the desired fix, but it is not mentioned in the commit message and
should be.

Info: __success() placement differs from patch 09 and from the rest of
the tree; see the note on patch 09.

Patches 06, 07, 08, 10, 12 and 14 look correct to me.

For 07, the added "*sw_maskp = 0" is safe: efx_np_link_state() memsets
*lsp before the calls, and the AN bit reordering keeps both masks
correct. For 08, MC_CMD_ETH_AN_FIELDS_LEN and
MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_LEN are both 25, and
ep_np_cap_data_raw is declared with the former, so the annotation
matches the memcpy. For 12, both existing callers pass either a non-NULL
filter_arg or NULL for both, so the added check is inert today.

Not build tested on my side.
