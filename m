Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6468CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 17:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF5E042789;
	Wed, 10 Jun 2026 19:57:06 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 9B425402B0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 19:57:05 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304c520fe9aso2662031eec.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781114224;
 x=1781719024; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8d/H3S8fSEyJ/ikwfUCAXoJdtoQN6PgaM4C/gD88brw=;
 b=NyhbjGtmzAp6Pr4CH3lWFugCnnWEaXVBUU6pXEhXy17T3TZkCP9CW4P+Te33uVDhVz
 2gadHxt+Ukg5iRBqeeOczi8ZARkVFGGk2/zXAw6hPdFc7A3Fh6rfkN2EIkGv6agmaUJW
 I31nZdnDUEwJwrA1v3DQzA3aTQkdQ/qfHxdRTEL3+loTCVpSpGjqEx/mWIIo5Md31MtD
 FrW/YPLbcQK6xe25Ms+3Tgr5FPeNfC9QtV2EgearVFyzbW1A3knW12uQhpEXvzZWTaPZ
 aFeDrswjp+h4tCpxFH/4HjSnyMKf/js3QB3mEk1OhpQGgBi3rWue8Sqz2ksIRodCzWZg
 GpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781114224; x=1781719024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8d/H3S8fSEyJ/ikwfUCAXoJdtoQN6PgaM4C/gD88brw=;
 b=JAOYRfQXiHv2EgECRv4FfGXeVGjfCqfqcd769M967902p3/rhAijUkCDQXa9HSXuDu
 dVoo5JZWMgv/uBmHMlp8wJyXLRNnfBHuaaaaCWlfZ0Qh0E3iVMYsfJs4mAREqE9tdq4F
 kfIYc6HlkzrTQZGxfpx/nNzmKcQaipQGVF7vVOvnzbhznyfWAjSHO1n61AeCsIi/+jsH
 5FzUi84znuTxEslCNp9SGRthP5J4bt8tNcJVd4x0y3ex6kqR30FQa+PKWKSvQ3xOVznR
 +NX1+n1PWWuwkQt0i8LqMJ7XTBNszUTTjffUFATuix1XZuTceA4/kFplJsX1HY4SYVYY
 MgXA==
X-Gm-Message-State: AOJu0YxxrA3WVKuku4orbz4xf6016yDsQBobX/zG5JF3djP9OARldRp6
 /xhPvc2Mlv36vEqiWOjM/+F+PjiUlTVprXCS1IjR48oxy72pwJDJiw4Db3r25BQ6trGcINgSlNk
 6OXxd
X-Gm-Gg: Acq92OELpNEP53xrj8/H5e8BHIX1XenSYehuE9qXVN9gdHXOJxvkHT3cwU6SM3vAOl2
 LGqbFx7QbutdjL2PB/LmCKfTzxppvX65iIuRrx6dAOXWpaXVEc793Xh+7jRQNnaOS6CnKibVlV3
 HCAz7LF/rse0iSDkWgQL2ADyGEtB8CDhkGFn4TrpTJh/J3F+3krMwEi4j5vAmW5rVURaXT/Jq06
 oHFwuZRWGIJxPORld+3y6l2Gi7M9Ob10A267YwOElUN0QtQssTs6WjVBgscoNexX9xOcmeDCs91
 esrAoWzU06HjN4O/vtTcvto096J0/jv1IqR/7ln/uAktgQ27foVc8wD5q/wZoRV4ufiiBzvWBDA
 v6X+htS3Lc1lS0SjSEwoSExzQ1GsdqzR0wPTsFkVACRRsaHRhpn8ABC1TaZocWMzs7n6IxmYaJW
 dTNCA+nazpY/7dk9VL5IxBW+d+vA2dZkbRWgs0W/t0SIRoVAqfNT70Dy7OvMQXUm6nQkkVlihH/
 rrsGGVvn0mlqA==
X-Received: by 2002:a05:693c:69db:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-3077b7595c7mr10690622eec.21.1781114224291; 
 Wed, 10 Jun 2026 10:57:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db5610esm26601334eec.4.2026.06.10.10.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:57:03 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:22:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 19/20] drivers: add testpmd commands for private
 features
Message-ID: <20260610102228.72882490@phoenix.local>
In-Reply-To: <20260610013936.3634968-20-liujie5@linkdatatechnology.com>
References: <20260609013951.3359199-21-liujie5@linkdatatechnology.com>
 <20260610013936.3634968-1-liujie5@linkdatatechnology.com>
 <20260610013936.3634968-20-liujie5@linkdatatechnology.com>
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

On Wed, 10 Jun 2026 09:39:35 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Introduce private testpmd commands and implementation files to enable
> debugging and testing of sxe2-specific hardware features (such as
> packet scheduling reset, UDP tunnel configuration, and IPsec ingress/
> egress offloads) directly within the testpmd application.
> 
> The parameters are parsed using the standard 'rte_kvargs' library during
> the PCI/vdev probing phase. Documentation for these parameters is also
> updated.
> 
> During memory hotplug events, the SXE2 driver needs to track memory
> segment layout changes to maintain internal DMA mappings. However,
> existing memseg walk functions (rte_memseg_walk) acquire memory locks
> and cannot be called from within memory event callbacks, leading to
> potential deadlocks.
> 
> This commit introduces sxe2_memseg_walk_cb() as a helper that walks
> memory segments using the thread-unsafe variant
> rte_memseg_walk_thread_unsafe(), which is safe to call from
> memory-related callbacks [citation:1][citation:3][citation:5].
> 
> The implementation follows the standard rte_memseg_walk_t prototype,
> processing each memseg to update driver-specific data structures.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

This memory stuff looks problematic and needs more review.
At a minimum I see a pattern of not handling values from strtoul()
that are out of range.


I asked AI for a more detailed review and it saw.
[PATCH 19/20] drivers: add testpmd commands for private features

There is concern about the amount of driver-private testpmd plumbing and
devargs this patch adds. The raw command count (7) is within precedent
(i40e has 29, mlx5 13, ixgbe 11), but the mechanism and content are not.

Error: the command logic is placed in sxe2_testpmd_lib.c, compiled into the
driver library, and exposed through 14 new RTE_EXPORT_EXPERIMENTAL_SYMBOL
entries (sxe2_ipsec_egress_create, sxe2_ipsec_conf_set, sxe2_flow_rule_dump,
sxe2_udp_tunnel_operations, sxe2_stats_info_show, sxe2_testpmd_sched_reset,
etc). No upstream driver exports symbols for its testpmd commands; all six
existing drivers with testpmd integration compile their *_testpmd.c into
testpmd via testpmd_sources and use internal access. These exports are
vendor public API that any application can link against. The driver .so also
gains application state for the commands: g_tx_session[][], g_rx_session[][],
g_esp_header_offset[], g_sess_pool. SA-manager bookkeeping does not belong
in a PMD. Move the logic into sxe2_testpmd.c and drop all 14 exports; at
most RTE_EXPORT_INTERNAL_SYMBOL is appropriate here.

Error: three commands duplicate standard testpmd functionality the driver
already supports. "sxe2 flow rule dump" exists because the driver does not
implement the rte_flow dev_dump op; implement the op and the standard
"flow dump <port> all" works for every application. "sxe2 <port>
udp_tunnel_port add|rm" duplicates "port config <port> udp_tunnel_port
add|rm", which calls the udp_tunnel ops added in patch 12. "sxe2 show stats"
duplicates "show port xstats"; the driver already implements xstats, and
anything missing from xstats should be added there, not shown by a private
formatter.

Warning: the 9-subcommand ipsec suite (egress/ingress add/rm/show,
session-id and esp-hdr-offset set/get, flush, stats) is an SA management
application embedded in the driver. Inline crypto is exercised with
examples/ipsec-secgw, as done for other inline-crypto PMDs. If interactive
SA management in testpmd is needed, propose it as generic testpmd commands
over rte_security so all drivers benefit.

Warning: seven private devargs are added (flow-duplicate-pattern,
function-flow-direct, fnav-stat-type, drv-sw-stats, high-performance-mode,
sched-layer-mode, rx-low-latency) with no documentation: no Runtime
Configuration section in sxe2.rst and no RTE_PMD_REGISTER_PARAM_STRING, so
they are undiscoverable. Beyond documentation: flow-duplicate-pattern makes
rte_flow duplicate-rule semantics vary per boot option, which is not
acceptable for a standard API; fnav-stat-type and drv-sw-stats select stats
sources and belong in xstats; sched-layer-mode configures TM topology that
the rte_tm hierarchy built by the application should determine;
high-performance-mode accepts only the value 1 and is undocumented - if the
mode is safe make it the default, otherwise document the trade-off. Each
surviving devarg needs documentation and a rationale for why no standard
API covers it.

