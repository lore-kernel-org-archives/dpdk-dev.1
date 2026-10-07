Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96ECA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 20:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802D540268;
	Wed,  7 Oct 2026 22:11:16 +0200 (CEST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id CE92740265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 22:11:15 +0200 (CEST)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so1617266b.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 13:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791403875; cv=none;
 d=google.com; s=arc-20260327;
 b=G7w1Mm7sZoS0dapqU+BsKyH4pWMvjTL+ICW8YNvLtf01FTgUJ6rslc0w/WW/tnB8ip
 eiuhjQI71WuwFn3aVBHGO+oonHEgtn6/HdzPEHx5DOoleH+zMoxLOG1mFZlN21x838CL
 nG2L9vvuCivQRSqTXi5793Z16WCwx7k2QohULdQXMrEz3DevLAPi5iR/PVSppawEZfxz
 0wxbb5n5GFT6eg7T4WFIigskUnMDdp3+zDn+RtBHb3Nnzk6Fsh4/Ztp6BBBWTP0TCoQY
 aDHbfbgU9PsoOFuNCOwMIGKMcpwgcumbuz2t2zurv0Qka62Vq56KIb390UMiFYRVKcq4
 ufkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LsScEQJzKsIFY6X6OikZEIIUczoJc8I5hHlK0SLOP5c=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=hpTazXIVeWOVgm1zVMM0sJuXTEj0I1XP6lUEneteEk7/MUisaKsWjD0jPFsznhnPiC
 FRLA+uREnpdfoAM2+BDwT9OoWF3IASmf7ea60+HK9U1SBwsuA/ddgRFm0QEAxUbekwzn
 hbc/9Y5MZaXodX8iFAy1uowyrRY/+F7pnAPqDyzQf/xw2in66Nc/eOz0U7eR7FtR0G9H
 E1+fSDVxz8hYMjd+faf3NV6ImCxoCDLFfbJEX9s6CEyz+hGD6BPYgyjH/0yUn6h9q65C
 Vq3rmsG6HpPqlUlQNsbFI1cQjRWhSl7SXmqHAqDmEH5bo+sM8zieURgYuBuLBOLMpYTz
 T8wg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791403875; x=1792008675; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LsScEQJzKsIFY6X6OikZEIIUczoJc8I5hHlK0SLOP5c=;
 b=hoi8fVH0CrGDbgHTVrJBuok0KLimm4fUotdqF7CvKb1cjdtuO9x0DcDdgbSMXihvIG
 TJCThHvGo1lGx2PT8rNPuZnTnX8+CZnWshJPpS0+dO1b+xBhkfWTfKLGPFGFvTj2dDBV
 LMngwZtVxm7Yu4gESDuA/SOXhtAakfVMN2jz+if341xa6GXGvvKDpT9CD6z+Nhkjcz7h
 uPBKwLeM4+b27IeR5j7iT5rRU/MQrJRLQ2pvvL4+WEW1C3vDISijd8UG9cX5CoOCfhhJ
 gq53P13PuK7ekAl2d22MdECy6tji2IRyfJZZGSGIbpVvFqdVmUgGUnwk8Tl1YJZrCenk
 KoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403875; x=1792008675;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LsScEQJzKsIFY6X6OikZEIIUczoJc8I5hHlK0SLOP5c=;
 b=AGEzRudiwgZ9HaC93l3QLPJUzEdGOx3Ql3qajp82z2DbuvRTc6WDD67fI1tBIedk67
 MP3TH3PlFyJrsX9bGs7VSJqLVIuKLg5obbIJRRbjiP8FBYGrpIMCXxaqCGKlOlIC5r6v
 FONktSp9AK1dBZBQX+NaYXok1qUzXLSoIs/qHadIZbg9yqPA/ToLat4Lnda+JiwE7DQc
 i4VEved1o+dGaYQvXgVnnNaHRJGx+4LEWaclWnET5jMS2XsuAIV6c9b5J+0lg9MX3Xl6
 /cSkpRdtq2tb0UOcX+ONnlcoejn31VoCyWfvHLZ1qvDwGe/+VLOUDHpKxcXhWJdef2aw
 Ch8A==
X-Gm-Message-State: AFq9FYJDoHC26NgKqBahA8hzLLoZ9sEc1tPDWBcoPVO9smSehkJVSZmF
 Rou0AloEKmyCLmLC1xiMMGH2DZvafVGu7OHsxwWK8OPwPu2roFXb9teazbCxBl7PRwAbHmoGM4C
 opV5zsJvi9wwGR8011lfbKwSRGDHoHLtr9dTgqmKKGuhHZyvLnn+n0oUN
X-Gm-Gg: AYBFou1M69vfcHEEt3Ph6b+PzW4ZEh8ExiAPwGGSKS1rMpdii/0x9IY17vYrQs8JUrM
 HSDr0QYYDhksTVpajwP0tLmFwW1J3/4/LH3jwr5gbcU6koKzyNHK0LCHGCcyfPsD6l1WMUtBg2Y
 3qPCp/BIT4BQpfSNGt0HtyF88J7fJ9w9E7lTDUCwacDWYGFnQWbKZ9QDcA4aIhSyHChiFeB+MSg
 j2HEq2xNdeZqPmsVviU60/dcFY/Glt0ToDKRyU4o+fFdspDdRDVHh/FOBIX3QCASxALGQssnM4/
 aLo5sbB/txkE+C/quOx3TsTF/2fQvCEVEubpyOLDn8Vywy6X7YMl2MVOAHMSm+wWYtU03oXU0TO
 E5bp+/NzT
X-Received: by 2002:a17:907:9282:b0:c2e:616b:6763 with SMTP id
 a640c23a62f3a-c319198032amr23591966b.3.1791403874673; Wed, 07 Oct 2026
 13:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
 <20261006081014.22ee1b01@phoenix.local>
In-Reply-To: <20261006081014.22ee1b01@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 7 Oct 2026 13:11:02 -0700
X-Gm-Features: AclHuK9jGrEERoj_AJ0dwe7n87bCG27dD7qdAzDabUTkJuUrhfBgfMHmFjiJhhw
Message-ID: <CALuQH+XH9ChutY5OMa1tsY1naj7EwqYKCtJfxgtULU5+0r-GxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] gve: precursor control plane changes before
 bare-metal support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 6, 2026 at 8:10=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon,  5 Oct 2026 12:39:31 -0700
> Joshua Washington <joshwash@google.com> wrote:
>
> > This patch series includes a number of precursor changes to the GVE
> > ethdev driver layer in preparation for introducing support for a new
> > GVE Mailbox control plane (an alternative to the existing AdminQ contro=
l
> > plane).
> >
> > The most major change in this series is the introduction of a new
> > control_ops struct that will be used by both AQ and Mailbox for various
> > operations which may need to communicate with the device. There are als=
o
> > some changes to how RSS and timestamping are handled in ethdev due to
> > slight feature differences between the control planes.
> >
> > ---
>
> Lots of issues found with manual run of AI review.

For now, I've addressed issues marked as Warning or Error. If I see
any "Info" issues that can be trivially fixed, I'll include changes
for those as well, but have not commented on them explicitly.

>
> Review: [PATCH v2 0/8] net/gve control ops rework (bundle 2148)
>
> Series summary
>
> Patches 1 and 6 add the query_rss op and NULL handling for "optional"
> ops, but no op table in this series sets query_rss and the only table
> fills every optional op. None of that code can run until the mailbox
> backend lands. The abstraction is easier to judge posted together with
> its second user.
>
> Errors
>
> [PATCH v2 1/8] net/gve: refactor ethdev for control ops interface
>
> 1. Driver compatibility is no longer sent to the device after reset.
>
>    gve_verify_driver_compatibility() moved into
>    gve_adminq_get_device_properties(), which is skipped on reset:
>
>        if (skip_describe_device)
>            goto setup_device;
>        ...
>        err =3D priv->ctrl_ops->get_device_properties(priv);
>
>    Before this patch it ran right after gve_adminq_alloc() on every
>    gve_init_priv() call, including gve_dev_reset() ->
>    gve_init_priv(priv, true). Functional change in a refactor patch,
>    not mentioned in the commit message. Keep it on the path that runs
>    on reset, e.g. an AdminQ init_ctrl_plane op that does
>    gve_adminq_alloc() followed by the compatibility check.

This change was intentional. Foregoing
gve_verify_driver_compatibility() on reset should have no negative
effect.

>
> 2. Function pointer table stored in shared memory.
>
>        priv->ctrl_ops =3D &gve_adminq_ops;
>
>    priv is dev->data->dev_private, shared with secondary processes, and
>    holds the primary's address of gve_adminq_ops. A secondary installs
>    dev_ops in gve_dev_init() and returns; gve_link_update() has no
>    process type check:
>
>        err =3D priv->ctrl_ops->report_link_speed(priv);
>
>    GVE has no LSC interrupt, so rte_eth_link_get() from a secondary on
>    a started port calls link_update and jumps through the primary's
>    address. That crashes whenever the driver is mapped at a different
>    address (shared build, PIE with ASLR). Same for read_clock, mtu_set,
>    RSS and flow ops. Before this patch the secondary called the AdminQ
>    functions directly. Keep the table process local: store a control
>    plane mode enum in priv and resolve the ops with an inline helper,
>    or keep the pointer in eth_dev->process_private and set it in both
>    primary and secondary init.

Will fix in v3.

>
> [PATCH v2 6/8] net/gve: add RSS cache boolean flag
>
> 3. One failed AdminQ RSS command locks out RSS configuration for the
>    life of the port.
>
>        err =3D gve_adminq_execute_cmd(priv, &cmd);
>        priv->rss_cache_dirty =3D true;
>        if (err =3D=3D 0)
>            gve_update_priv_rss_config(priv, rss_config);
>
>    On error the flag stays set. gve_adminq_ops has no query_rss, so
>    gve_rss_update_cache() returns -ENOENT from gve_rss_hash_update(),
>    gve_rss_hash_conf_get(), gve_rss_reta_update() and
>    gve_rss_reta_query(), and gve_dev_configure() skips the RETA reset
>    for the new queue count. Only gve_update_priv_rss_config() clears
>    the flag, and it is reached only through configure_rss, which every
>    caller gates on gve_rss_update_cache(). gve_dev_reset() does not
>    recover: gve_init_priv() touches the flag only when query_rss is
>    set. The same lockout follows a successful command when
>    gve_update_priv_rss_config() fails with -ENOMEM; its return value
>    is ignored since patch 5.
>
>    Before this patch a failed AdminQ command left the cached config in
>    place. AdminQ has no query, so its cache is authoritative. Drop the
>    dirty write from gve_adminq_configure_rss(), leave it to a backend
>    that implements query_rss, and propagate the update result:
>
>        err =3D gve_adminq_execute_cmd(priv, &cmd);
>        if (err =3D=3D 0)
>            err =3D gve_update_priv_rss_config(priv, rss_config);

This is a good point. To keep the behavior the same as before the
patch, I will avoid clearing the cache altogether.

>
> Warnings
>
> [PATCH v2 6/8] net/gve: add RSS cache boolean flag
>
> 4. priv->rss_config is read before the cache is refreshed.
>
>    The commit message says the config must not be read while dirty,
>    but gve_rss_hash_update() checks priv->rss_config.key_size, copies
>    it into rss_conf->rss_key_len, and sizes the new table from the
>    cache before refreshing it:
>
>        rss_reta_size =3D priv->rss_config.indir ?
>                priv->rss_config.indir_size :
>                GVE_RSS_INDIR_SIZE;
>        err =3D gve_init_rss_config(&gve_rss_conf, rss_conf->rss_key_len,
>            rss_reta_size);
>        ...
>        err =3D gve_rss_update_cache(priv);
>
>    The later copy then takes its length from the pre-refresh cache and
>    its source from the post-refresh one:
>
>        memcpy(gve_rss_conf.indir, priv->rss_config.indir,
>            gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));
>
>    gve_dev_configure() likewise tests priv->rss_config.indir before
>    refreshing. Call gve_rss_update_cache() before the first
>    priv->rss_config access in both functions.

GVE only supports RSS reta size of 128 and hash key size of 40. The
important part of priv->rss_config to refresh is the actual data,
which is barred behind a cache update. As for the dev_configure: if
the indirection table is NULL, then RSS was never configured by the
driver. This would mean that device defaults are being used. In that
case, the device automatically scales the RSS reta for the number of
queues, and there is no reason to attempt to update the cache.

>
> [PATCH v2 7/8] net/gve: fix RSS config memory leak on close
>
> 5. Wrong Fixes tag. priv->rss_config has been allocated by
>    gve_update_priv_rss_config() since RSS support was added and was
>    never freed, on close or on remove, before or after 7ba84453bacf.
>    Use:
>
>        Fixes: 63ef54569760 ("net/gve: support RSS configuration update")

Will update the Fixes tag.

>
> 6. Stable fix sits behind six refactor patches. It applies to main on
>    its own; move it to the front of the series.

Will reorder the patches to have this fix first.


>
> [PATCH v2 8/8] net/gve: refactor timestamp support to clock read type
>
> 7. RTE_ETH_RX_OFFLOAD_TIMESTAMP is now advertised when timestamp setup
>    failed.
>
>        -   if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
>        +   if (priv->clk_read_type !=3D GVE_DEV_CLK_UNSUPPORTED)
>
>    gve_setup_nic_timestamp() leaves nic_ts_report_mz NULL when the
>    memzone reservation fails and frees it when the sync thread cannot
>    be created; clk_read_type stays GVE_DEV_CLK_CMD in both cases.
>    nic_ts_stale stays set, so the Rx path never stamps packets. Before
>    this patch rte_eth_dev_configure() rejected the offload in that
>    state. Keep the nic_ts_report_mz test, or set clk_read_type to
>    GVE_DEV_CLK_UNSUPPORTED on setup failure.

This was due to a resbase error. Will revert.

>
> Info
>
> [PATCH v2 1/8] net/gve: refactor ethdev for control ops interface
>
> 8. The comment marks free_db_resources, setup_stats_report,
>    report_nic_timestamp and the page list ops optional, but only the
>    set_mtu caller checks for NULL. gve_teardown_device_resources()
>    calls free_db_resources unconditionally. Either check at each call
>    site or drop the "optional" claim until a backend omits them.
>
> [PATCH v2 6/8] net/gve: add RSS cache boolean flag
>
> 9. Pre-existing, not introduced by this patch, but the lines are
>    re-indented here: gve_dev_configure() ignores the return of
>    gve_init_rss_config_from_priv(). If the key allocation fails,
>    update_reta_config.indir is uninitialized stack and
>    gve_generate_rss_reta() writes through it. If the indir allocation
>    fails, gve_init_rss_config() frees key without clearing it and
>    gve_free_rss_config() frees it again.
>
> 10. Pre-existing: gve_update_priv_rss_config() assigns rte_realloc()
>     straight back to the pointer, leaking the old buffer on failure:
>
>         priv_config->key =3D rte_realloc(priv_config->key, key_bytes,
>             RTE_CACHE_LINE_SIZE);
>
>     Same for indir.
>
> [PATCH v2 7/8] net/gve: fix RSS config memory leak on close
>
> 11. gve_teardown_device_resources() also runs on gve_dev_reset(). After
>     a reset key and indir are NULL but key_size, indir_size and
>     hash_types survive, so gve_rss_hash_conf_get() reports the old
>     rss_key_len and rss_hf. Zero priv->rss_config after freeing.
>
> [PATCH v2 8/8] net/gve: refactor timestamp support to clock read type
>
> 12. The GVE_DEV_CLK_UNSUPPORTED check added to
>     gve_alloc_nic_ts_report() is dead: its only caller,
>     gve_setup_nic_timestamp(), already returns on that value.
>
> Review-Result: ERROR



--

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
