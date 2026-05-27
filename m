Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F5CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:25:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6245640395;
	Wed, 27 May 2026 15:25:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1150540650
 for <dev@dpdk.org>; Wed, 27 May 2026 15:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779888321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7lelAn1e/v0tD6rQGaXK+TmIcP3QbGqvz3n0sweLF8=;
 b=Fd2W+qlcMs4e7a1AeZTPinuNu1WbChVBrf9uY0Tisj82fsdGxSRHeRqmphPbzUAJU+fDrd
 8jaMz0fkkVWz24cr//ZageyFNqG3MVxPdONEY1vXuoplW5rt+n26Sgs/Q3kZV8/CubIJ1u
 ix2qiUFB4u74GI2tQj6OxQv0x7gVfok=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-KdSK3UWLPeuSO-lCOgokZg-1; Wed, 27 May 2026 09:25:18 -0400
X-MC-Unique: KdSK3UWLPeuSO-lCOgokZg-1
X-Mimecast-MFC-AGG-ID: KdSK3UWLPeuSO-lCOgokZg_1779888317
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-393a6ee3c75so52297531fa.3
 for <dev@dpdk.org>; Wed, 27 May 2026 06:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779888316; x=1780493116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7lelAn1e/v0tD6rQGaXK+TmIcP3QbGqvz3n0sweLF8=;
 b=ancEuFK8QAVoMjtqMB9Ajusp0U4VqePA29YuoxwEyGeVHfZiS9mVXl9Bs+jsJ2xA1r
 NW8LZDPY88XHPUYMrRlvVwJ+fh6P92CQe4MVl7lsmalo0a3ov0QYOLRucfO/bMT+dFdk
 +UY/L+HwnRxHVEyTBXZh4nQdyuaZs8ngPLGpSjTaM+hzwdy1NunLJiVvNXQHiMf6dIPW
 AOgyTh7HmqKoWHruxz+InfnUXE6gg1ye87OCzE+p3tToDtdmHNWqfuLNeufiJ3jPiVz7
 mnSWDY42K8+bhbwxOb3DQayqsbpR+iVArxu6zAXrWEmhIcThQ9i9TqZRO7Ea11aU0Y/T
 F3kA==
X-Gm-Message-State: AOJu0YwzYvArcbjhUlHsxiSDPzD1c/SGB5led1qij3CDgn5kO3WIP5rH
 zqT1r1gWuq5cyKy9y3uWf3RSEIUF/G+nhJNS2NNxEACpGGeEvym5dqbJH6lSmoc6deHvQpb+N0F
 AOQ0pJv4QKXy7N3RqGQCdKw7i9S7+qAuqyTPJ72Ha9Nuj+b0O7k9v3lkeD//4BemlMmV8rTvVgF
 WvIFISYBL+fuggeueGJo8=
X-Gm-Gg: Acq92OEXPBl0w7P9h4f1RGUOu40YaCJ4vpSKd9RJGEeXXXfc3NXEa6SlLeT9E1YIMuK
 oV1bYvELsvMatL2dYRAfAwdi75DL7QA+Z6BLwsXsVKIhnFvA7nMoVr2SUGSJS7P3LLFPN8vwy15
 rLPtn8UxQ+ewHoXT0eHVKcHFrW72ywAEJvR42r9leHp4Yqjz9WZvtaPO1K/P/BqnWFm/PE909pf
 +30ZR3ffwnHG2ZmbNkba5i0BGj7SyJZs6ybAhNMRy++rcKAl3RthOy0OoLpnyH/cLAk2w==
X-Received: by 2002:a05:651c:154e:b0:394:e5e:f12b with SMTP id
 38308e7fff4ca-395d8d3d99dmr74425051fa.17.1779888316499; 
 Wed, 27 May 2026 06:25:16 -0700 (PDT)
X-Received: by 2002:a05:651c:154e:b0:394:e5e:f12b with SMTP id
 38308e7fff4ca-395d8d3d99dmr74424901fa.17.1779888315917; Wed, 27 May 2026
 06:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
 <20260510170306.3406045-5-david.marchand@redhat.com>
 <20260512164154.00d109c5@stephen-xps.local>
In-Reply-To: <20260512164154.00d109c5@stephen-xps.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 27 May 2026 15:25:02 +0200
X-Gm-Features: AVHnY4KPGygHHqSJbhKjmFNSd4-XLAp_tYefVtr_tQYQOlbpIVpryKEjlA6CRoQ
Message-ID: <CAJFAV8woV=XmP6GyOBsvRW1taT+YzA7s3e0bMRYHr2g0D_YamQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] net/iavf: accept up to 32k unicast MAC addresses
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gsNnUNQtGCPy7DuUi_eOlk_BrkIIIMWJ4u5vlS7V9o4_1779888317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 12 May 2026 at 16:42, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 10 May 2026 19:03:04 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > E810 hardware provides 32k switch lookups.
> > Thanks to this, it is possible to allow a lot more secondary mac
> > addresses than what is possible today.
> >
> > In practice, the maximum number of macs available per port may be lower
> > and depends on usage by other (trusted?) VFs on the same PF.
> > There is no way to figure out this limit but to try adding a mac address
> > and get an error from the PF driver.
> >
> > Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> > accordingly.
> >
> > Signed-off
>
> AI review feedback; nothing major but worth a look

In the first revision, it was interesting, but now, that's a lot of noise.


>
> Series: ethdev: VMDq cleanup and iavf: 32k MACs / duplicate install fix
> Tree: dpdk main (DPDK 26.07)
>
> Patch 2 - ethdev: skip VMDq pools unless configured
>   Info
>     Doxygen of rte_eth_dev_mac_addr_add() is not updated to describe the
>     new constraint that pool must be 0 when VMDq is not configured. The
>     function-level @param documentation and @return list should mention
>     that -EINVAL is now returned when VMDq is disabled and pool != 0.

 * @param pool
 *   VMDq pool index to associate address with (if VMDq is enabled).
If VMDq is
 *   not enabled, this should be set to 0.

It has been documented since the start that a 0 pool should be passed.

I can update the return code EINVAL.

>
>     Subtle behavior change: when VMDq is not configured, mac_pool_sel[index]
>     is no longer set to RTE_BIT64(0) on add. Before this patch every added
>     MAC ended up with bit 0 set; afterwards the array stays at 0. This is
>     consistent with the new restore path (which now uses the VMDq flag
>     rather than walking pool_mask in the !vmdq case), but the change in
>     observable state of dev->data->mac_pool_sel[] could surprise an out-of-
>     tree consumer. Worth a sentence in the API change note.

This is really internal stuff, only drivers would access this, and we
don't care about such out of tree consumer.


>
> Patch 4 - net/iavf: accept up to 32k unicast MAC addresses
>   Info
>     Release notes wording: "secondary MAC addresses from 64 to 32k" is
>     slightly imprecise. IAVF_NUM_MACADDR_MAX (64) was the total cap including
>     the primary MAC; IAVF_UC_MACADDR_MAX (32768) is also a total cap
>     including index 0. Either drop "secondary" or say "secondary MAC
>     addresses from 63 to 32767".
>
>     iavf_add_del_uc_addr_bulk() returns an int but the only caller
>     (iavf_add_del_all_mac_addr) discards it. The pre-existing function was
>     already void so this is no regression, but having the helper return an
>     error code that is unconditionally dropped is misleading. Either
>     propagate the error to the caller (and make iavf_add_del_all_mac_addr
>     return int) or make the helper void.
>
>     eth_dev_mac_restore() now iterates dev_info->max_mac_addrs which for
>     iavf becomes 32768. With patch 5 applied this path is skipped via
>     get_restore_flags, but any driver that increases max_mac_addrs into the
>     thousands without setting RTE_ETH_RESTORE_MAC_ADDR off will pay a 32k
>     rte_is_zero_ether_addr() scan on every dev_start. Not a bug here, but
>     worth keeping in mind.
>
>     sizeof(struct virtchnl_ether_addr_list) already accounts for the
>     embedded list[1] slot, so
>        in_args_size = sizeof(struct virtchnl_ether_addr_list) +
>                       sizeof(struct virtchnl_ether_addr) * list->num_elements
>     overcounts by sizeof(struct virtchnl_ether_addr). This matches what
>     iavf_add_del_eth_addr() already does, and the buffer is sized to hold
>     it, so it's not a bug -- noting it for completeness.

Those points do reflect the pre-existing implementations, but that's
it, I won't fix all bugs in the world... for now.


> Patch 5 - net/iavf: fix duplicate MAC addresses install
>   Info
>     Recovery edge case: if iavf_add_del_eth_addr() for the primary fails
>     during the first iavf_dev_start(), mac_primary_set stays false. On a
>     subsequent VF reset, iavf_dev_start() (called from iavf_handle_hw_reset)
>     will re-attempt the primary add, and the new
>     iavf_add_del_all_mac_addr() call right after will add the primary again
>     via VIRTCHNL_ETHER_ADDR_PRIMARY. This re-introduces a single-MAC
>     double-install in a narrow failure path. Could be avoided by skipping
>     the primary in iavf_add_del_all_mac_addr() when mac_primary_set is
>     already true, or by having iavf_dev_start() skip the primary add when
>     in_reset_recovery is set.
>
>     No release notes entry. With Fixes: + Cc: stable this is acceptable as
>     a bug fix, but the patch also introduces a new dev_op
>     (get_restore_flags) for the driver and changes when MC addresses are
>     re-pushed (only on VF reset, not on every dev_start). A one-line note
>     in the iavf section of the release notes would help users tracking
>     behaviour changes between stop/start cycles.

Mac addresses are installed only once and restored on reset, that's all we need.
IOW, this patch should have no visible impact on an application, and
nothing to write about in the RN.


-- 
David Marchand

