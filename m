Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5172CCD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 17:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5553E40268;
	Fri,  8 May 2026 19:41:30 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 938C240150
 for <dev@dpdk.org>; Fri,  8 May 2026 19:41:28 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso2505031eec.1
 for <dev@dpdk.org>; Fri, 08 May 2026 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778262087;
 x=1778866887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5Tb8EWuede6cptzRhgU2TC77NDKl7Q7SMA2XGUfR/Y=;
 b=k2piqtU8IED4w/DzyghQjfC7+00fQ8VelOk9+WdtDn9oz7cyRHp5CvTBA066+VrVFe
 oPnh7MBcZ+A9Jtl3duQY+CcrcvttC589pG4nN9vjcUwd03PVLD33fnINmhol9HAgtZoF
 JjoA3ZBvPeE/9F9ePk+6lJ6WkiAnDdSgbnnF6lgu8uMjRFWSpHrdH0Khvs2x0ld3cs+e
 WDqgTQsKFT8emQm4dAEzGBBUc6WWlHkQ5UP5xk7+gqeY/R9AtB2y/g2OBBwUylNieRrn
 zjalmTL9HfCzCEM0wXNo1yzHVC+Rs0+hunxqZA3axt72KUHyKGB3BxYtzGXi74t4CqTK
 LeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262087; x=1778866887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n5Tb8EWuede6cptzRhgU2TC77NDKl7Q7SMA2XGUfR/Y=;
 b=hEiLA5QwjhfbZyAs1FSqXxLmu87I8AmgEEj5/3etLrHZ3MmfLQ7ulxYL3AVSaFVf5O
 MtSgWLk3lsvQaTURo8HRhyzkX7T6kL/4hI+WCEw8psDnO9Czz7pidb7zsc6r1THqlpBC
 d74j44JnbnPXaABZ/YWlCtWCxBQPl1qQ4qtflQxgy5IOXwY96K3zKdqFxMy3UV4Z/KWB
 BVOQKb90pysqDRhuN3Mion5lrb2bN+4kBnIeddGrbFuXt5NyCAkNjexbFzDIlnqbapW7
 1YkSGJvmAyfS6U8N+kWFU6H7+rmgoVVC3x3ML6egUG4qIwNcrAngpaFsSm4ws0B03t4/
 PaAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X2/l67Cqb7iE2mHcNyd59VwdOt1cG8kmgeTrl2j9dVzy27WUAANkRsiJFelFYnVoRmcQ=@dpdk.org
X-Gm-Message-State: AOJu0Yx5y6HbCDJGa+pnLJVI9oWG3x7TAUY2iLMadEfFE0rcFNmwv4wc
 FdCAP5IoqRO5zqBaApXFJOcb467lAwgzCaTcKlZvgScJafZ4xRUHkiO48yASb6/Cx/o=
X-Gm-Gg: Acq92OF56l2GlLDPRETAielv2gu8x/pvp6rx4dJ1W1r59T29SOa6wVw0kgDDjlVfMCd
 TaoHGAIbSIT3nwJcddmU4juCVDA4k0aaICA+VMWaCzlVCxBhsuUvAaOjFdWX1LZUBpScF1TuxGO
 VPnUbtvUcSnB/08HQKI0C1aMWe+Q1P1t+eKy4n+C7wtRhIcQa2nejMPHWK7AoISTL8Pxtaq0AUy
 JXHudBgTKG/+x+RtctrF9KBYDXXIn4ih6QDNwcw1DmGeem2WNNMUfUYNswhJ3+DcOGKwOu3tHql
 /T8/IQylVhjYYacQs8JHFO1vaMMZADDd47IBnIVoUJDoXNQMYfjMPiaDr+thee+adA7r3Q0tqJr
 Wz4zvuSg1JFcgoCP5I5XE9nKh6mra9uNCjOHs3uUXBkapK5hDaf6LZ1Chvxb0rgdLiA8xn399+t
 fEe5Y3fY1a9vmyDv0Z0yl7CDThxRzDwEQiA4c=
X-Received: by 2002:a05:693c:2c01:b0:2d9:db50:c6d6 with SMTP id
 5a478bee46e88-2f54d79b988mr6810624eec.21.1778262087148; 
 Fri, 08 May 2026 10:41:27 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm3891259eec.6.2026.05.08.10.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:41:26 -0700 (PDT)
Date: Fri, 8 May 2026 10:41:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH 25/25] doc: add BPF validate debug to programmer's guide
Message-ID: <20260508104123.07784d2c@phoenix.local>
In-Reply-To: <20260506173846.64914-26-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
 <20260506173846.64914-26-marat.khalili@huawei.com>
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

On Wed, 6 May 2026 18:38:43 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> Document the new gdb-like validation debugger API, outlining how it can
> be used to set breakpoints and inspect register states during
> validation.
>=20
> Highlight its primary use case: writing robust tests for the eBPF
> verifier using the harness in app/test/test_bpf_validate.c.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Regular AI review doesn't dig deep enough on this; so redid it with
stronger model and prompt.

Reviewed the series. It cannot be applied as-is for two compounding
reasons; once those are resolved, the individual fixes look correct
and well-tested.

Series-level: the patches reference rte_bpf_prm_ex, enum rte_bpf_origin
(RTE_BPF_ORIGIN_RAW), rte_bpf_load_ex, and rte_bpf_get_jit_ex. None of
these exist in upstream master, and none are introduced by this 25-patch
series =E2=80=94 diff context in patch 5 (struct rte_bpf_prm_ex { hunk head=
er)
and patch 2 (rte_bpf_get_jit_ex near the insertion point) confirms the
prerequisite must already be in the base. Please declare the dependency
in a 0/25 cover letter so reviewers can apply on the right base.

Patches 03, 05, 10: Build break. RTE_BPF_LOG_FUNC_LINE is used (replacing
RTE_BPF_LOG_LINE) but never defined =E2=80=94 not in bpf_impl.h, not elsewh=
ere in
DPDK, not in any of the 25 patches (verified by grep). Either add the
macro to bpf_impl.h, e.g.

    #define RTE_BPF_LOG_FUNC_LINE(lvl, ...) \
        RTE_LOG_LINE_PREFIX(lvl, BPF, "%s(): ", \
            __func__ RTE_LOG_COMMA __VA_ARGS__)

following the pattern in lib/eal/common/eal_trace.h, or revert the call
sites to RTE_BPF_LOG_LINE(... "%s: ...", __func__, ...).

Patch 05: __rte_bpf_validate_state_is_valid and
__rte_bpf_validate_can_access return int but mix tri-state (true / false
/ -errno) with bool semantics; the caller does `if (rc =3D=3D false)`
against an int. Works, but consider splitting the bool case from the
tri-state case for clarity.

Patch 08: Test file uses rte_bpf_load_ex, struct rte_bpf_prm_ex, and
RTE_BPF_ORIGIN_RAW (see series-level note). Two minor items in the test
helpers: load_constant / compare_and_jump assign int64_t to .imm
(int32_t) =E2=80=94 fits_in_imm32() guards the value but an explicit (int32=
_t)
cast would document intent; and `value >> 32` on int64_t is
implementation-defined for negative values, a (uint64_t) cast before
the shift would be portable.

Patch 17: RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE is inserted in
the middle of the enum, shifting BRANCH_RETURN and the _END sentinel.
Fine for an unreleased experimental API in the same series. Once the API
stabilizes, additions should go at the end before the sentinel.

Patches 01, 02, 04, 06, 07, 09, 11=E2=80=9316, 18, 19: no comments. The bug
descriptions with reproducer programs, expected-vs-actual output, and
UBSan diagnostics are very useful and the fixes are well-targeted.

I did not get to patches 20=E2=80=9325 in this pass.
