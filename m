Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA2CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D2B34279E;
	Tue,  6 Oct 2026 17:10:22 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id C04B74113D
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:10:18 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so370205a91.0
 for <dev@dpdk.org>; Tue, 06 Oct 2026 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791299418;
 x=1791904218; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kIFpvHQr+Q3xHwsiDcEcGiVlNsZHoLV+dOwjpOz8oWs=;
 b=T9OxOyMgrgsvAgWfxJH0z90fPyXC232Nc74dbZu7n/4A5Wpzbf3ZNEmSgXmY+MhD+q
 4pSuOg1qdZPXYXyzx34EEArhyfMcp0z56529Ek0bIVb9bGOi/uh+kHMPu2E2+JaAEZ0g
 CRyAU0VfGZPyLhHDHF8DkOu3ROdEENq1fcSmmTgj2u3sMm3Amn4zfBwlTIwOM8J03/CI
 72wLLklvjmpcRDIzmiDDa1+4lW4pZY1xLzDJjNXLQRwoCBQJj+t5wSAstBYvo/4nZtZ7
 a3CuBCr5gFQ1BaeDhM5WdO+bbTEJHeuzEDJN/BjKZNdUXS4h9WJM2nuUJ6wu6NgkdH1F
 fvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791299418; x=1791904218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kIFpvHQr+Q3xHwsiDcEcGiVlNsZHoLV+dOwjpOz8oWs=;
 b=c4TnvtRrDGxda1eR+aeBrfSljYRZQdjjp2aZ+PJCahinVNc8kA2wDbJtgTrmSTWdZF
 sjvQnm8ZFgcHh1QjEIGBTc9Y9vjjw50jZ+TwrY0MQCm6T0wX6qqgerCIYGOFjah95vBB
 2z3ICGXSJZpVp2ZCQ0ezjYhVPCKYMGG0SY7ggTqXSNA4a3D2Yowu+VjugzNkkDbcviQn
 5LBKt9b7jYh+PGmTXJwXQhs2mN7iSzn2EqMs+4EXvV8w5KhvRB/9TTJQhILRBGZJVA5M
 GPqzdQw0VVzS4112yiOoecnZvaZzx4uZnjOtl5fvZTy0OzMlbXbtq9wcdjeYXyHCsFZt
 NEhg==
X-Gm-Message-State: AFq9FYKfMBo6YkVa8QiOihzK9HTLO9kRLp6Oqu2yr8OdGwmZyDZwO+rq
 GpwawwQbwgiPQzjuCjQ9Qvtsb+ovA6YqQwR0zQBHbQ4VhziEEsWOHrUi0VV+glZE0t4lCQeWxXE
 3AISd+58=
X-Gm-Gg: AYBFou1VEG9maTXW9tXVQ76Xhc8az1oq0FU7W39/2SZpM7EN/X8serquBDqGm8tDQEl
 03sm/ANckiqUjljlXoDVQYa2iHDYenqq3tNcMAz23BR6uZEngMoL2+NRWxBzbmwbbA3MBsVF+CY
 KzFrOzp2P0xS7LOk7ad6XHEgx3bgXQDq6e0YhKb76F+nSyVliUZxL9VOebKRV9Ba4N6b38EJvbz
 k24IerkLU/hyaUc1FtkqxOoGUyQUjOyXx9cUgLEL9AKZ0zQwzGxuG4y5ozWXptEMjN4dnwdS3x/
 sNEs92rVz4sfMdaqsyACt8/GywuUBueSkm2HEC5C38q10Zt5Zqi2c9JyjV+DoGjiK38O5wlfXVf
 94eo+pMJxmeWDPj9FfTftXKR9H7P3WHhG2uyUxKkDsXw3SR4/mIAd0UiptqU7ok5JE+FhF+CvWP
 /iUJNpPWbJWb7ufHjHk++kuZ2sQH7COxtaappfIc8QhrYfxcxOJhl4qmgMkL9xsK1/5ZXO3ue8h
 AgL9+cgN4KNWjTWOTNLU+8ys1agdq3OXDlj63i1
X-Received: by 2002:a17:90b:1a82:b0:3a8:de1:db07 with SMTP id
 98e67ed59e1d1-3a8726c1d93mr1260169a91.5.1791299417343; 
 Tue, 06 Oct 2026 08:10:17 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853cac663sm5454097a91.9.2026.10.06.08.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:10:17 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:10:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/8] gve: precursor control plane changes before
 bare-metal support
Message-ID: <20261006081014.22ee1b01@phoenix.local>
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
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

On Mon,  5 Oct 2026 12:39:31 -0700
Joshua Washington <joshwash@google.com> wrote:

> This patch series includes a number of precursor changes to the GVE
> ethdev driver layer in preparation for introducing support for a new
> GVE Mailbox control plane (an alternative to the existing AdminQ control
> plane).
> 
> The most major change in this series is the introduction of a new
> control_ops struct that will be used by both AQ and Mailbox for various
> operations which may need to communicate with the device. There are also
> some changes to how RSS and timestamping are handled in ethdev due to
> slight feature differences between the control planes.
> 
> ---

Lots of issues found with manual run of AI review.

Review: [PATCH v2 0/8] net/gve control ops rework (bundle 2148)

Series summary

Patches 1 and 6 add the query_rss op and NULL handling for "optional"
ops, but no op table in this series sets query_rss and the only table
fills every optional op. None of that code can run until the mailbox
backend lands. The abstraction is easier to judge posted together with
its second user.

Errors

[PATCH v2 1/8] net/gve: refactor ethdev for control ops interface

1. Driver compatibility is no longer sent to the device after reset.

   gve_verify_driver_compatibility() moved into
   gve_adminq_get_device_properties(), which is skipped on reset:

       if (skip_describe_device)
           goto setup_device;
       ...
       err = priv->ctrl_ops->get_device_properties(priv);

   Before this patch it ran right after gve_adminq_alloc() on every
   gve_init_priv() call, including gve_dev_reset() ->
   gve_init_priv(priv, true). Functional change in a refactor patch,
   not mentioned in the commit message. Keep it on the path that runs
   on reset, e.g. an AdminQ init_ctrl_plane op that does
   gve_adminq_alloc() followed by the compatibility check.

2. Function pointer table stored in shared memory.

       priv->ctrl_ops = &gve_adminq_ops;

   priv is dev->data->dev_private, shared with secondary processes, and
   holds the primary's address of gve_adminq_ops. A secondary installs
   dev_ops in gve_dev_init() and returns; gve_link_update() has no
   process type check:

       err = priv->ctrl_ops->report_link_speed(priv);

   GVE has no LSC interrupt, so rte_eth_link_get() from a secondary on
   a started port calls link_update and jumps through the primary's
   address. That crashes whenever the driver is mapped at a different
   address (shared build, PIE with ASLR). Same for read_clock, mtu_set,
   RSS and flow ops. Before this patch the secondary called the AdminQ
   functions directly. Keep the table process local: store a control
   plane mode enum in priv and resolve the ops with an inline helper,
   or keep the pointer in eth_dev->process_private and set it in both
   primary and secondary init.

[PATCH v2 6/8] net/gve: add RSS cache boolean flag

3. One failed AdminQ RSS command locks out RSS configuration for the
   life of the port.

       err = gve_adminq_execute_cmd(priv, &cmd);
       priv->rss_cache_dirty = true;
       if (err == 0)
           gve_update_priv_rss_config(priv, rss_config);

   On error the flag stays set. gve_adminq_ops has no query_rss, so
   gve_rss_update_cache() returns -ENOENT from gve_rss_hash_update(),
   gve_rss_hash_conf_get(), gve_rss_reta_update() and
   gve_rss_reta_query(), and gve_dev_configure() skips the RETA reset
   for the new queue count. Only gve_update_priv_rss_config() clears
   the flag, and it is reached only through configure_rss, which every
   caller gates on gve_rss_update_cache(). gve_dev_reset() does not
   recover: gve_init_priv() touches the flag only when query_rss is
   set. The same lockout follows a successful command when
   gve_update_priv_rss_config() fails with -ENOMEM; its return value
   is ignored since patch 5.

   Before this patch a failed AdminQ command left the cached config in
   place. AdminQ has no query, so its cache is authoritative. Drop the
   dirty write from gve_adminq_configure_rss(), leave it to a backend
   that implements query_rss, and propagate the update result:

       err = gve_adminq_execute_cmd(priv, &cmd);
       if (err == 0)
           err = gve_update_priv_rss_config(priv, rss_config);

Warnings

[PATCH v2 6/8] net/gve: add RSS cache boolean flag

4. priv->rss_config is read before the cache is refreshed.

   The commit message says the config must not be read while dirty,
   but gve_rss_hash_update() checks priv->rss_config.key_size, copies
   it into rss_conf->rss_key_len, and sizes the new table from the
   cache before refreshing it:

       rss_reta_size = priv->rss_config.indir ?
               priv->rss_config.indir_size :
               GVE_RSS_INDIR_SIZE;
       err = gve_init_rss_config(&gve_rss_conf, rss_conf->rss_key_len,
           rss_reta_size);
       ...
       err = gve_rss_update_cache(priv);

   The later copy then takes its length from the pre-refresh cache and
   its source from the post-refresh one:

       memcpy(gve_rss_conf.indir, priv->rss_config.indir,
           gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));

   gve_dev_configure() likewise tests priv->rss_config.indir before
   refreshing. Call gve_rss_update_cache() before the first
   priv->rss_config access in both functions.

[PATCH v2 7/8] net/gve: fix RSS config memory leak on close

5. Wrong Fixes tag. priv->rss_config has been allocated by
   gve_update_priv_rss_config() since RSS support was added and was
   never freed, on close or on remove, before or after 7ba84453bacf.
   Use:

       Fixes: 63ef54569760 ("net/gve: support RSS configuration update")

6. Stable fix sits behind six refactor patches. It applies to main on
   its own; move it to the front of the series.

[PATCH v2 8/8] net/gve: refactor timestamp support to clock read type

7. RTE_ETH_RX_OFFLOAD_TIMESTAMP is now advertised when timestamp setup
   failed.

       -   if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
       +   if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED)

   gve_setup_nic_timestamp() leaves nic_ts_report_mz NULL when the
   memzone reservation fails and frees it when the sync thread cannot
   be created; clk_read_type stays GVE_DEV_CLK_CMD in both cases.
   nic_ts_stale stays set, so the Rx path never stamps packets. Before
   this patch rte_eth_dev_configure() rejected the offload in that
   state. Keep the nic_ts_report_mz test, or set clk_read_type to
   GVE_DEV_CLK_UNSUPPORTED on setup failure.

Info

[PATCH v2 1/8] net/gve: refactor ethdev for control ops interface

8. The comment marks free_db_resources, setup_stats_report,
   report_nic_timestamp and the page list ops optional, but only the
   set_mtu caller checks for NULL. gve_teardown_device_resources()
   calls free_db_resources unconditionally. Either check at each call
   site or drop the "optional" claim until a backend omits them.

[PATCH v2 6/8] net/gve: add RSS cache boolean flag

9. Pre-existing, not introduced by this patch, but the lines are
   re-indented here: gve_dev_configure() ignores the return of
   gve_init_rss_config_from_priv(). If the key allocation fails,
   update_reta_config.indir is uninitialized stack and
   gve_generate_rss_reta() writes through it. If the indir allocation
   fails, gve_init_rss_config() frees key without clearing it and
   gve_free_rss_config() frees it again.

10. Pre-existing: gve_update_priv_rss_config() assigns rte_realloc()
    straight back to the pointer, leaking the old buffer on failure:

        priv_config->key = rte_realloc(priv_config->key, key_bytes,
            RTE_CACHE_LINE_SIZE);

    Same for indir.

[PATCH v2 7/8] net/gve: fix RSS config memory leak on close

11. gve_teardown_device_resources() also runs on gve_dev_reset(). After
    a reset key and indir are NULL but key_size, indir_size and
    hash_types survive, so gve_rss_hash_conf_get() reports the old
    rss_key_len and rss_hf. Zero priv->rss_config after freeing.

[PATCH v2 8/8] net/gve: refactor timestamp support to clock read type

12. The GVE_DEV_CLK_UNSUPPORTED check added to
    gve_alloc_nic_ts_report() is dead: its only caller,
    gve_setup_nic_timestamp(), already returns on that value.

Review-Result: ERROR
