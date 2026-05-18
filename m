Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE88CD4F4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 18:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43626402D9;
	Mon, 18 May 2026 20:00:00 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 82A7A40041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:59:58 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-135200bc7d2so6783608c88.0
 for <dev@dpdk.org>; Mon, 18 May 2026 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779127197;
 x=1779731997; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kJK5T2UB4Bj8QHU9amu+dqIqiONXFCZH36w3bpoL5U=;
 b=wkQud1xQ35zciA5HUtop7ANCt7UN+l4ecK9EC06ET1vVVk9sFBuSmEhpS7TmheWFjB
 sIe1Hj4PMXx5i/hvghwzyLjdwhYqKhC/1aHmXYDSAofsOmT8sBWgT1W/6plZV/IAK2HI
 B6gXsj6Cfy7KYl5unKE/1qUm7hWX61QaT9oGnDR9U0EClkrkF+fZ06L4BUm18JBxhc77
 qXNkNTXaYgAkon2pnMbKwD2VDS8HmpHnjmQvecqL0BXoyZ3ZFfFXCM9AuYSPm2VWQjKw
 mVVvm5OlFtX3OrZ7nTpppzxviTz/5Bsvrq9IEUYipaOlLroxZGHdCq6xbjn5IcoHMsqc
 kpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127197; x=1779731997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8kJK5T2UB4Bj8QHU9amu+dqIqiONXFCZH36w3bpoL5U=;
 b=g+XlvKhj4cueideQheYjlGP2J+wltxjDt5rfD4lEHCUaWoPZ5Gl/YyHHplNqRzTD6R
 HupvlQXn2jPzD2CcDqXdU/+zzNt4bH/semgtlPXaZo4J6MpaWlg9Y+cor3sMG/EhxJuP
 8mnu8O30q+D5V7Fz3J83kKULWu2zJnMVpY+WYbnIIuKcQ5X6T2WolnlgNOr+u9J4cAjR
 y0rFafZskQC7dDWaurtDaSLmaJF90yJO6Rk2zDo0/vDxeyxHg+QEwV7MTYQC5/ST4MQH
 VVxiFo7lu6+aXotri9YpKBuh0kin7xFRWge+30wZxvlfLHBVuILybqglGscYXvTb+jDx
 g/eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zDQxqSsrJZRNG6aH+rKRrfHy9Da8jQ7PlR6gg9lH6iIkDYJpJwxMZDetmMpMT1E1JSMM=@dpdk.org
X-Gm-Message-State: AOJu0YzBEpi9CJXqecMAAhiW+YVu3i5NPP2JvntjUqdPxnSCOo9l/ns4
 2OwIogDu05utO2lubOt4drF8be5HB9kFEMehnmYFbNmnxjfu3lXNXMXP5JfqxyMBII8=
X-Gm-Gg: Acq92OHjyVIpddEeA9XRwQyRPy0PexlPHiQdhtJX5t1qVq9wWlDXGBRIVxAKNHiMQU+
 F/WvbBPUavSrXcxm3IayePUctNYd+2bznjQR6IN6qwjBAeWUxdpihATR2HqgA8TMhs6bXMRTqac
 t2ITkZXfos3kOuCoPt6/ac+5tOeHC8Vq0XhVZCbD2HpGp65Ky0Pn0nIlhrx6HyBRgTsMXEC7065
 pLv/jKiNOjwJSL5fn+uXzNKfzIe2564DfQoItKc189nYD6WBkiC2k6fFKH4QFcs/sorWik/7Nn5
 jgOBCt0d8/AUMltdW5PRvI0HOnot2Jk+qDvV1PBfKhU5gMGshgAR07kklq+1yPkZwjm2rIOPyLP
 UNjoUJM7TxcuFEXdG1gTBh236GUlG44Be8HHYTHvsrGOfdyg36emxjr5VxCdXSUlIm9P2OAcmBT
 usDI38tpvTQpFlMnG9dgfFWN5T2SHsDZ+1wSk=
X-Received: by 2002:a05:7022:fd08:b0:135:3f86:9075 with SMTP id
 a92af1059eb24-1353f86926dmr5050368c88.21.1779127197353; 
 Mon, 18 May 2026 10:59:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2351d9sm22034168c88.9.2026.05.18.10.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:59:57 -0700 (PDT)
Date: Mon, 18 May 2026 10:59:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH V2 00/15] power: unify and improve lcore ID verification
Message-ID: <20260518105954.2309f802@phoenix.local>
In-Reply-To: <20260507024230.1198111-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
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

On Thu, 7 May 2026 10:42:15 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> This patch series reworks the lcore ID verification logic within the
> power library to ensure consistency and improve maintainability.
> 
> Currently, various cpufreq drivers implement their own lcore ID checks,
> which are limited to simple range validation and involve significant
> code duplication. Moreover, these checks do not account for whether the
> core is actually managed by the application.
> 
> For the verification in cpufreq-related APIs and power QoS APIs, although
> service cores do not typically invoke these APIs, they may operate in
> polling modes where power management is required. To maintain compatibility
> with applications using service cores, the validation logic now explicitly
> allows both ROLE_RTE and ROLE_SERVICE.
> 
> But the lcore ID in the pmd_mgmt library must be ROLE_RTE because it is
> mainly used together with the data plane of ethdev PMD. So use
> rte_lcore_is_enabled to verify.
> 
> Key Changes:
> 1. Add lcore role verification to individual cpufreq drivers.
> 2. Introduces a unified macro in the power library to standardize lcore ID
>    checks.
> 3. Moves verification logic from individualdrivers to the framework level.
>    This reduces code duplication.
> 4. Allow the service cores to configure power QoS.
> 5. Use rte_lcore_is_enabled to verfify the lcore ID in pmd_mgmt.
> 
> ---
> v2:
>  - Allow the service cores to set power API.
> 
> ---
> 
> Huisong Li (15):
>   eal: add interface to check if lcore is EAL managed
>   power/kvm_vm: validate lcore role in cpufreq API
>   power/acpi_cpufreq: validate lcore role in cpufreq API
>   power/amd_pstate: validate lcore role in cpufreq API
>   power/cppc_cpufreq: validate lcore role in cpufreq API
>   power/intel_pstate: validate lcore role in cpufreq API
>   power: add a common macro to verify lcore ID
>   power/cpufreq: add the lcore ID verification to framework
>   power/acpi_cpufreq: remove the verification of lcore ID
>   power/amd_pstate: remove the verification of lcore ID
>   power/cppc_cpufreq: remove the verification of lcore ID
>   power/intel_pstate: remove the verification of lcore ID
>   power/kvm_vm: remove the verification of lcore ID
>   power: allow the service core to config power QoS
>   power: add lcore ID check for PMD mgmt
> 
>  drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
>  drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
>  drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
>  .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
>  drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
>  lib/eal/common/eal_common_lcore.c             | 11 ++++
>  lib/eal/include/rte_lcore.h                   | 11 ++++
>  lib/power/power_common.h                      |  7 ++
>  lib/power/rte_power_cpufreq.c                 | 14 +++-
>  lib/power/rte_power_pmd_mgmt.c                | 21 +++---
>  lib/power/rte_power_qos.c                     | 10 +--
>  11 files changed, 55 insertions(+), 289 deletions(-)
> 

Lots of AI review feedback on this one:

Patch 01/15: eal: add interface to check if lcore is EAL managed
=================================================================

Warning: New public API rte_lcore_is_eal_managed() is exported as
a stable ABI symbol (RTE_EXPORT_SYMBOL), but DPDK policy requires
new public APIs to be introduced as experimental:

    +RTE_EXPORT_SYMBOL(rte_lcore_is_eal_managed)
    +int rte_lcore_is_eal_managed(unsigned int lcore_id)

The declaration in rte_lcore.h is also missing the __rte_experimental
attribute. The export should be:

    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_is_eal_managed, 26.07)
    int rte_lcore_is_eal_managed(unsigned int lcore_id)

and the prototype in lib/eal/include/rte_lcore.h should carry
__rte_experimental.

Warning: This series adds a new public API but does not update the
release notes in doc/guides/rel_notes/release_26_07.rst (or whatever
the current target release is). New API additions must be documented
in the release notes under the "New Features" section.


Patch 07/15: power: add a common macro to verify lcore ID
=========================================================

Info: The macro evaluates lcore_id twice (once in
rte_lcore_is_eal_managed() and once in POWER_LOG). All current
call-sites pass a plain variable so there is no observable bug, but
a side-effecting argument would be evaluated twice. Same caveat
applies to the existing RTE_ETH_VALID_PORTID_OR_ERR_RET pattern, so
this is consistent with existing DPDK convention.


Patch 14/15: power: allow the service core to config power QoS
==============================================================

Info: The check changes from rte_lcore_is_enabled() (ROLE_RTE only)
to rte_lcore_is_eal_managed() (ROLE_RTE + ROLE_SERVICE), so the log
message wording changes from "is not enabled" to the macro's "is
invalid" text. For a service core that was previously rejected, the
new "invalid" wording is less informative than the prior message,
but this is minor.


Patch 15/15: power: add lcore ID check for PMD mgmt
====================================================

Info: This patch tightens the validation from "lcore_id within
RTE_MAX_LCORE range" to "lcore_id is ROLE_RTE". Combined with the
Fixes: tag and Cc: stable, this is a behavioural change in stable
branches: callers that previously passed a non-enabled lcore_id
(ROLE_OFF / ROLE_SERVICE / ROLE_NON_EAL) will now receive -EINVAL
where they previously succeeded into the function body. The commit
message correctly justifies the data-plane (ROLE_RTE) requirement,
but the behaviour change should be called out explicitly in the
commit log so stable maintainers and downstream users are aware.


Series-level observation
========================

Info: Patches 02-06 add per-driver lcore role checks, and patches
09-13 remove the same checks once patch 08 lifts validation into
the framework. The net effect is that each driver's lcore check is
modified and then deleted within the same series. The series could
be reorganized to:

  1. Patch 01: add rte_lcore_is_eal_managed()
  2. Patch 07: add the RTE_POWER_VALID_LCOREID_OR_ERR_RET macro
  3. Patch 08: add validation to the framework (rte_power_cpufreq.c)
  4. Patches 14, 15: pmd_mgmt and QoS adjustments

skipping patches 02-06 and 09-13 entirely. This would reduce review
load and avoid intermediate states where the same check exists in
two places. If the current structure is intentional for incremental
bisection, that rationale would be worth mentioning in a cover
letter.
