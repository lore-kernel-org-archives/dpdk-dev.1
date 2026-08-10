Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D328C5B56A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 16:25:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 229DC40272;
	Mon, 10 Aug 2026 18:25:23 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id EC72F40144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 18:25:21 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so1094134a12.3
 for <dev@dpdk.org>; Mon, 10 Aug 2026 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786379121;
 x=1786983921; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JGfaU0wazUpZrOBxV5hvcV3X7orIoRnkuEm7PUYqGWo=;
 b=sQ6I9jiOA/JOSNG9VARW+8hHRVdr5lSBxaGquP5jSlNIkZXXmCGQRMWLskimmtkj/V
 6stQFLP9PvO+21A9KFUqCg3Zyd5Z4iqGMGhkxqw67Nd81D/WpXjzZBPeE6I4GwEYLjfz
 sRDoZxeH0z28EMY1uAkpzaDWQozIaML9rc+eG6c4fkQIrS9YOyXominzETHkIMHwtBJt
 io/bsMAXcQGwDdVG97vSUQAhZBTlx+60WwXo9lEBjn5O+tkCPbHcoDFuZeQnigVQ9hrd
 JSdJuwSjG0SlcV7Qn93LrlSRhOljkmgTk+5nsWztBKjnErAkGzW4+4mPdUx49GosuF6f
 8WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786379121; x=1786983921;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGfaU0wazUpZrOBxV5hvcV3X7orIoRnkuEm7PUYqGWo=;
 b=bWuUlurXtPm+2UhaGu4rzToEOMKCyspOmsaGI5juKw8Eali7FakUd0/+k3kYVtnYv9
 /nzoTv3zdPIA7yDMJabbmPl69Efg2bcQaIi3Oy3uW9z94xqqu+fcASOcdOLP4reLlIUE
 XPhBMpzWMTp4dmHwWvpcw2oLiGHSSnp3+0fd5/ssWffntLxD/QEVdyZWfKhJODSdnyzP
 v/MDgE4zOl61dD74df0reGQ9OJ7QFQ2+cONF+opdgvD8Rz7RqZhb2uksphB6PT+1q28S
 KgSwkHFKlD/Fz4sbf3Wl8JLLwdzShJENnPraRJ9oL3zPOYbM+D9KnJ+gOGjiv1rHKE6O
 lqqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTr1a1VhxBespYL1zH64QrRPzi6KSX7Ie3vfxPvpEVWN/zmB5WEjhD8NP8Ck7lx5M4Wrw=@dpdk.org
X-Gm-Message-State: AOJu0YznQjD7MoEmScYofZeqiLMS9NbDoA4yOXswh5vfjzCEicIKOy4p
 2YKnMIMcLnCeQ4tCmuAdLEnNKJWnBCtuLXmaEaNAUYE/dxwFcxpGtph8HoWeOmjw0f8=
X-Gm-Gg: AR+sD12O+fIi8TPkZewRd7A/JLf/xW8hCei1NGmgOILXlgS3GqlR6eMBJoSW+cSkTBn
 26MviFhkU2jBGJNEv/o6ErJoUc/e2Ws7f0NrxTF3srVP54llq8mBM6K0OwUAJF9cfLDpB4JRtY0
 sZVl2d8vGY6WKIg/NMOmO6rLjhOvQV2yC9EnU8PSa4BpI/iWbLE5mJ1gjHmFJGeSuDXKDscdIRp
 BbVgHtXqFYiOqdtKfae2Ii90RqVpr3IMuiE9vCorIOgcVVn3kVvDzYNyFoqpg6QymcCqAWCwFPN
 Ed7TQs18Prqg4CwE75f5JVINmga7A2n/YaFsfXemUiOpublfS+7yCDC9XzYI7/vyY0Wymogcx3n
 2vAC5JdWrSKAGCLmFGPs3z6PWf47UEZ7v8EJzST9ij2a3273teYayDTQfmLHIYvOlglC6JgUISD
 YnVHkGHffvX2XiWTCQDqUkcg73lNogx4WdmJ17q9PfOTTgK2ZfN6yAQhm2lItq2f+9H4WI+/qWC
 8Z30asp9BSlsXKZ1OIaioMBUgbKngdHzf0zI3azLA==
X-Received: by 2002:a05:6a21:b95:b0:3c3:875d:c531 with SMTP id
 adf61e73a8af0-3cbce6f1862mr25295271637.6.1786379120556; 
 Mon, 10 Aug 2026 09:25:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019b4eabsm35831124c88.6.2026.08.10.09.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:25:20 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:21:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v4 0/6] power: uncore power improvements and auto-detection
Message-ID: <20260810092148.24aafd71@phoenix.local>
In-Reply-To: <20260729025149.2158868-1-lihuisong@huawei.com>
References: <20260729025149.2158868-1-lihuisong@huawei.com>
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

On Wed, 29 Jul 2026 10:51:43 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> This series improves the uncore power management in l3fwd-power
> and adds automatic detection of uncore drivers in the power library.
> 
> - Fix uncore deinitialization for non-legacy modes.
> - Enable power QoS for all modes (not just legacy).
> - Fix uncore help text and log messages.
> - Relocate uncore initialization from arg parsing to init_power_library().
> - Support automatic probing of uncore drivers in AUTO_DETECT and delete
>   useless code for auto-detection uncore environment.
> 
> ---
>  v4:
>  - Fix '!global_uncore_ops' to 'global_uncore_ops == NULL' from AI review.
>  v3 link:
>   https://inbox.dpdk.org/dev/20260728120208.1858832-1-lihuisong@huawei.com/
> 
>  v3:
>  - update feature to release_26_11.rst.
>  - add a new patch to delte useless for automatic detection environment.
>  v2 link:
>   https://inbox.dpdk.org/dev/20260526081138.1434947-1-lihuisong@huawei.com/
> 
>  v2:
>  - Remove the patch which add global uncore init and deinit interface.
>  - Remove the last patch in l3fwd-power about these new interface.
>    Will send them after this series.
>  v1 link:
>   https://inbox.dpdk.org/dev/20260512023513.460169-1-lihuisong@huawei.com/
> 
> Huisong Li (6):
>   examples/l3fwd-power: fix uncore deinit for non-legacy
>   examples/l3fwd-power: enable power QoS for all modes
>   examples/l3fwd-power: fix uncore help and log info
>   examples/l3fwd-power: relocate uncore initialization
>   power: support automatic detection of uncore driver
>   power: remove unused auto-detection uncore
> 
>  doc/guides/rel_notes/release_26_11.rst        |   6 +
>  .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
>  examples/l3fwd-power/main.c                   | 256 +++++++++---------
>  lib/power/rte_power_uncore.c                  |  78 +++---
>  4 files changed, 185 insertions(+), 157 deletions(-)
> 

Most of the developers are off enjoying summer vacation.
But AI is still around and finds some things here:
Note: some of what it complains about is noise.


Applied to main (26.11-rc0) and reviewed against source. Applies cleanly.

Note on check-git-log: it reports "Wrong 'Fixes' reference" for both
tags. That is a shallow-clone artifact. Both references are correct
against full history:
  10db2a5b8724 ("examples/l3fwd-power: add options for uncore frequency")
  3b3af56d3c9c ("power: fix uncore configuration")


Patch 4/6 examples/l3fwd-power: relocate uncore initialization

Warning: new file-scope variable g_uncore_cfg is neither static nor
prefixed. It is used only in main.c. Make it static and drop the g_
prefix, which is not DPDK style.

  static struct uncore_cfg {
          enum uncore_choice uncore_choice;
          uint32_t freq_idx;
  } uncore_cfg;

Info: the out-of-range message carries over an off-by-one. The test
rejects freq_idx > freq_array_len - 1 but the message says "choose a
value from 0 to %d" with freq_array_len. Since the line is being
rewritten anyway, print freq_array_len - 1.


Patch 5/6 power: support automatic detection of uncore driver

Error: resource leak in power_uncore_probe_driver().

          ret = ops->init(0, 0);
          if (ret == 0) {
                  uint32_t env = power_uncore_driver_name2env(ops->name);
                  if (env == UINT32_MAX)
                          continue;
                  ...
                  ops->exit(0, 0);

On the env == UINT32_MAX path the driver has already been initialized
successfully but ops->exit(0, 0) is never called before moving to the
next driver. For intel_uncore that leaves f_cur_min and f_cur_max open
and the original min/max frequencies never written back. Restructure so
exit() runs on every successful init:

          ret = ops->init(0, 0);
          if (ret != 0)
                  continue;
          env = power_uncore_driver_name2env(ops->name);
          ops->exit(0, 0);
          if (env == UINT32_MAX)
                  continue;
          global_uncore_env = env;
          global_uncore_ops = ops;
          break;

Not reachable with the two in-tree drivers, since both "intel-uncore"
and "amd-hsmp" are in uncore_env_str, but the branch is deliberate and
is wrong as written.

Error: function return type must be on its own line.

  static uint32_t power_uncore_driver_name2env(char *name)
  static int power_uncore_probe_driver(void)

should be

  static uint32_t
  power_uncore_driver_name2env(const char *name)

  static int
  power_uncore_probe_driver(void)

The parameter should also be const char *; ops->name is only read.

Warning: the release note is filed under "New Features" but the commit
carries Fixes: and Cc: stable@dpdk.org. Pick one. Either this is a
backportable fix, in which case drop the New Features entry, or it is a
feature, in which case drop Fixes and Cc: stable. As written the stable
maintainers receive a patch that advertises itself as a new feature.

Info: the AUTO_DETECT path now returns -ENODEV while every other error
path in rte_power_set_uncore_env() returns -1. Not wrong, but the error
convention is now inconsistent within one function.


Patch 6/6 power: remove unused auto-detection uncore

Warning: behaviour change to an exported stable symbol with no release
note. Previously rte_power_uncore_init() fell back to auto-detection
when no environment had been set; it now returns -1 with "Please set
uncore environment first." Applications relying on the implicit
fallback break at runtime with no build-time signal. Add a release note
describing the new requirement.
