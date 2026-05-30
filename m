Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C98CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F381F4029F;
	Sat, 30 May 2026 18:34:17 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id E3E5D4028C
 for <dev@dpdk.org>; Sat, 30 May 2026 18:34:16 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-914db83362aso700924285a.1
 for <dev@dpdk.org>; Sat, 30 May 2026 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780158856;
 x=1780763656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJk7AugxG7RNpDIZFeGJkRFWMg4PAkVW39F5zukwztM=;
 b=N2bHxm6sZgvy/NBbbMv0GpGJV74IxyPMbduWpMX9O4epKqUIgFMx+ofyCJLh1RWENd
 UCaox42ZJulW7g6aGL3aSalWGw+AcDABCRYKTGYth2yiiB2aMODTrDaF3D1guJIjy9wJ
 jhOkPf4WnvvEvtZT9XgvYP+ngw9QTfS4MXsrwHexL2E4/CGGl0Ql0whV80PcJFaYu03D
 c5b0x5bKPXmnTrYB4XAp6aNhJxUKWfV6GqvyNtel/4EiOAy7GSPoKjO36wIfIuvDuZgK
 aRE0uHKcD07Ct48TW+Dmsw0074Pn7M4ylf0mRX9l/K5/DFYDmNVQfZGPWrHwV01aZqCu
 q21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780158856; x=1780763656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJk7AugxG7RNpDIZFeGJkRFWMg4PAkVW39F5zukwztM=;
 b=p3UvsaawTWvCRYfYanXeVAYEYLPyB0ua2QK0/h7c70oPfy+v4mghJQZqnZgFY/HXDS
 JcnRkgPo9IrswghyyCOo+Nh094xfRx8FovkosytySw6meJY7LohsUBASKgfTVjXfy+GZ
 ii+0aGNmlT39jSVndxQ33FnUrCKtrROuDZ7LROtKFUK3OPK13Qzks9WTiZTvHhrjwJb+
 wP2EU1vamisC/WbjMxRY54llmoqu3J0SkneqlZoFR87gBopiKq6ci9dWD9rmq9SjGxbH
 Qq/Wszv7lfUcTQcJ2Y/5nWNMGAHt475UsqCzRAITZhiD4dMht2wvE8nDckh0ahz2kiB5
 SGgQ==
X-Gm-Message-State: AOJu0YxieG74Sh9PYq4Xp3nuCouPue8r2F9q5iTLPimhK8XEdfExlBM9
 xYHusHzy+CZLgVoNYyO5NzF6r9PnQgx6dhz0PCyNr3DsxfF0MAmVFkjqMCTQys2zpLAGja+VGBR
 xKcJZ
X-Gm-Gg: Acq92OE8WM/I7vAgaf2Vj1OApcHJeO0vCOEbYCouMEmzl6ikG7PFRE6I5kvNFa6NKub
 lhKMRp/QMy39+3+nhpwcB/5jF5D9W+MYknj/1SOLeOXJV71yQsvSTGiaro/jB/SHodkD4occAA1
 jYsvnh27gApZnGWZ1siruENW7duMVlRQm3imfHuP4lNX3EOx3e1YCEysShmf8C2pnw7zeKgpmEW
 qZd8UJklV8X7ecqxEicNRULW3YbjcX7vploOrgdqjXQXWVlVeO39lztzF11dkINdSk5fRsD0Ys5
 pY6Up+lGsNHSYdDeGp/1B41kNkE9nCI5fnvkpAShe/5G8oaXbOl7LoBCjVPUcyqrRKulzO/miot
 feng0Gul9sk08moAoNk7PQT+R504Pdgfkklbk5oolGTWfNNFqwZJlO2L3VZmxFE6fZVrlVm0be6
 vDzuiWhtE8m+tgihuWn7SN7wU2JYKAKU6MutS8hJyzSfUE2AXRljg66iGhzOgH8GVu0wrA0JP5R
 3O/4zLWmnJ9RQ==
X-Received: by 2002:a05:620a:1714:b0:8f2:8bb8:cb6d with SMTP id
 af79cd13be357-9152f91d22cmr913178985a.12.1780158855998; 
 Sat, 30 May 2026 09:34:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm49560636d6.24.2026.05.30.09.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:34:15 -0700 (PDT)
Date: Sat, 30 May 2026 09:34:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/23] net/sxe: added Linkdata sxe ethernet driver
Message-ID: <20260530093412.0ab41540@phoenix.local>
In-Reply-To: <20260530140904.157099-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-21-liujie5@linkdatatechnology.com>
 <20260530140904.157099-1-liujie5@linkdatatechnology.com>
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

On Sat, 30 May 2026 22:08:41 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS, DCB, PTP etc.).

Did AI review with smarter model and extra effort since this is a largish
patch series and simple models had lots of false positives.

Reviewed patches 01-20 of 23 (21-23 not present in this bundle).

[PATCH v2 07/23] net/sxe2: support IPsec inline protocol offload

Info: In sxe2_security_valid_key(), the buffer-size guard

    if (src_key > SXE2_IPSEC_MAX_KEY_LEN)
        is_valid = false;

is placed *after* the `if (increment == 0) { is_valid = true; goto l_end; }`
early return, so it is dead code for every fixed-size algorithm (all of the
advertised ciphers/auths use increment 0). This is currently safe only because
every advertised key_size.max equals the 32-byte SXE2_IPSEC_MAX_KEY_LEN buffer,
so capability validation already bounds the copy. If any *_KEY_MAX is later
raised above 32 (e.g. an HMAC key up to the SHA-256 block size) the
memcpy() into tx_sa->enc_key/auth_key[SXE2_IPSEC_MAX_KEY_LEN] would overflow
with no guard firing. Move the SXE2_IPSEC_MAX_KEY_LEN check above the
increment==0 return so it protects all paths.

[PATCH v2 09/23] drivers: interrupt handling

Error: event_thread_run is a plain `volatile int32_t` shared between threads -
written by the control thread (sxe2_event_intr_handler_init/uinit) and read in
the event thread loop `while (event_thread_run)`. volatile provides no
atomicity or inter-thread ordering and is not a substitute for atomics. The
same handler struct already uses RTE_ATOMIC(uint16_t) ndev with
rte_atomic_fetch_add/sub_explicit(), so the fix is consistent: declare the flag
RTE_ATOMIC(uint32_t) and use rte_atomic_store_explicit()/
rte_atomic_load_explicit() (relaxed is sufficient here).

Info: sxe2_event_intr_post() allocates the per-event element with rte_malloc()
in the LSC interrupt path. This is a small control-path structure, not a DMA or
queue buffer, so plain malloc() is preferred - it avoids taking the hugepage
heap lock from interrupt context. Impact is minor since link-change events are
rare.

[PATCH v2 14/23] net/sxe2: implement get monitor address

Info: sxe2_monitor_callback() open-codes the DD mask as
`rte_cpu_to_le_64(1 << SXE2_RX_DESC_STATUS_DD_SHIFT)`. The driver already
defines SXE2_RX_DESC_STATUS_DD_MASK as `(0x1ULL << SXE2_RX_DESC_STATUS_DD_SHIFT)`
for exactly this. Reuse the macro - it keeps the 64-bit form and avoids a bare
`1 <<` should the shift ever move off bit 0.

[PATCH v2 20/23] net/sxe2: add private devargs parsing

Error: `#include <asm-generic/errno-base.h>` is a Linux kernel-internal header.
It does not exist on FreeBSD (the driver's meson.build only disables Windows,
so FreeBSD is still a build target), and it does not define the `errno` lvalue
that the new parse callbacks rely on - only the E* constants. No other DPDK
source includes it. Use `#include <errno.h>`.

Warning: sxe2_parse_u8() is missing the trailing-character check that all four
sibling parsers (fnav_stat_type, sched_layer_mode, high_performance_mode, bool)
perform:

    u8_val = strtoul(value, &end, 10);
    if (errno) { ... }
    *num = u8_val;          /* *end != '\0' never checked */

so it silently accepts inputs like "5abc". It also assigns strtoul()'s unsigned
long straight into a uint8_t with no `(uint8_t)` cast and no range check, so a
value such as "300" is truncated to 44 and accepted. Add the
`*end != '\0'` check and a range/cast guard to match the siblings.


