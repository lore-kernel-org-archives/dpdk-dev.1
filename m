Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD1C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 13:21:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D625340689;
	Mon,  7 Sep 2026 15:21:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 553F84064C
 for <dev@dpdk.org>; Mon,  7 Sep 2026 15:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788787302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhF/KV7/RmTtEM1NR5QyQMK7vLer6BBl2nh0WuZk2Do=;
 b=c9l9abYpOtaNnVPwhbxE5AxHrlsARrlxHbjfUGVND5cOu7ooSnjWVUHuhjCAS65d66UjQg
 En2NdR6CbVrPSKCQsPptcnW5SiQOuDn9QNdC6E252Jn5Pxg8xoPv2PtWe2Vn1/KgFheCHQ
 QjnLXToPDNikWH2FozARO/9fe2KYSu0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-L7QVj-QvMAemyuHmfp6Rsw-1; Mon, 07 Sep 2026 09:21:41 -0400
X-MC-Unique: L7QVj-QvMAemyuHmfp6Rsw-1
X-Mimecast-MFC-AGG-ID: L7QVj-QvMAemyuHmfp6Rsw_1788787300
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a1f73fb2easo17170951fa.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 06:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787300; x=1789392100;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DhF/KV7/RmTtEM1NR5QyQMK7vLer6BBl2nh0WuZk2Do=;
 b=keWA7dLbqJD44SH4W4bHUudt3N8FGoanc3mS1eOVDiMFnFcicH8uNCincA4Jr+CiL4
 NHi3OUfyXaavulvmUBiR9l7KjhGmPZfMyhJJhlPLhyWmK7fy9BUG6qIDrru/SyGSxT/v
 VotGG4hCSRegZAnxfa9M5TFlIYGZwseLj+7aRQeeyhO6AuPz7kv8btPnkCwab2R4aU2K
 kCisjGsnsHMmNpkmqaTl5GEfb5OCA1JVrR8It2zu2k/rgKeHOyY88XLyxusR6Qkp21yL
 ZXNOd4pp0OgT1RsmUxBlZFfxcMV0rLHDChNhF+GcvbIor7Go1iWwK+xV4CBsMGEeRUDy
 ImGw==
X-Gm-Message-State: AFuF++mjDEnMJ8pikU3k8MRLZeJW2ujVzFF3vUptQmRJK1h0nKOaT8fA
 Pl5gQ2fNiw44VHV9/93tGsXB2sNQ856TMDh1MD88GjVyzUYOYTMaMXUAQoQA2+TQ1KlKRVqDRr2
 ka47Iz1Xd5wk9DilVYStQtlynf/fNlcXggC/W8vk+3BFlhfno7FyNr9u8igF/nUwKJBnDlRn921
 4d1NpvnQYMC23Oqk5tts4=
X-Gm-Gg: AYBFou0+8bu6ANtLzBMNM9e+9EGYPgOCV1xz1E5zTNjrjWgwHTig2bLAcfCCM6xc3lz
 6186kx0CZl42qyDfIOoMLvWTx6TZZOHT8XOAaLndjc0ZVCpcKdkwA9fTbhi2RydQJ2FNeQI0P7D
 r7T29cqg96XJqRtoM8ANxjMJN9b7ndVtxpFqAMU85o0qY8/b2WgLvPhhkZmTRp1HlbX4vgMMWMX
 gzXdvhwh1IJUkkJ5EJVLnW3LsJXuOqMSfQBoFmkMhf1ndpS
X-Received: by 2002:a2e:bea3:0:b0:3a2:74a:6fcf with SMTP id
 38308e7fff4ca-3a371ae8322mr25845621fa.4.1788787300021; 
 Mon, 07 Sep 2026 06:21:40 -0700 (PDT)
X-Received: by 2002:a2e:bea3:0:b0:3a2:74a:6fcf with SMTP id
 38308e7fff4ca-3a371ae8322mr25845491fa.4.1788787299457; Mon, 07 Sep 2026
 06:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260907111724.3043887-1-david.marchand@redhat.com>
 <ap60ylEX-xAuROSN@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ap60ylEX-xAuROSN@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Sep 2026 15:21:27 +0200
X-Gm-Features: AcwNN1VB4HfwYMZ-3mEab0phZfz95CzFZoJzp_1N5TW_bmaqAwZnAVGPtKUVUP4
Message-ID: <CAJFAV8x3QpkJxa3_crRLLHHKHscdceadDX2GEqEyN3sHU2DEYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net/i40e: fix MAC address removal
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zI7lF85KaCnTWWM8SmCxrXd7vVhCcSUNYj43cMknEOY_1788787300
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

On Mon, 7 Sept 2026 at 14:57, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Sep 07, 2026 at 01:17:23PM +0200, David Marchand wrote:
> > MAC addresses removal was tied with VMDq pools even when not used.
> > So if VMDq is not enabled, no address would be ever removed.
> >
> > Fixes: 9de506a6c781 ("ethdev: skip VMDq pools unless configured")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > I could not test the change as my setups are KO atm.
> >
> > Probably worth squashing in 9de506a6c781 before pulling to main
> >
> > Changes since v1:
> > - fixed compilation,
> >
> > ---
> >  drivers/net/intel/i40e/i40e_ethdev.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > index b6b2d291ee..3c01354c39 100644
> > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > @@ -4509,11 +4509,16 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
> >       struct rte_ether_addr *macaddr;
> >       int ret;
> >       uint32_t i;
> > +     bool vmdq;
> >       uint64_t pool_sel;
> >
> >       macaddr = &(data->mac_addrs[index]);
> >
> > -     pool_sel = dev->data->mac_pool_sel[index];
> > +     vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
> > +     if (!vmdq)
> > +             pool_sel = 1;
> > +     else
> > +             pool_sel = dev->data->mac_pool_sel[index];
> >
> The explanation makes sense, but do we really need the new temporary
> variable, rather than just checking the flag directly in the "if"?
>
> Also, the rest of the code in this function, and the add function about it,
> uses "pf->flags & I40E_FLAG_VMDQ" as a check for vmdq support. Is there a
> reason we can't use that flag also here, rather than checking the rx
> mq_mode flags?

No, I just did not notice this internal flag and I simply used the
ethdev level config.

What do you think of:

$ git diff next-net/for-main -- drivers/net/intel/i40e
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..0d914d86ea 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4513,6 +4513,12 @@ i40e_macaddr_remove(struct rte_eth_dev *dev,
uint32_t index)

        macaddr = &(data->mac_addrs[index]);

+       if (!(pf->flags & I40E_FLAG_VMDQ)) {
+               if (i40e_vsi_delete_mac(pf->main_vsi, macaddr) != 0)
+                       PMD_DRV_LOG(ERR, "Failed to remove MACVLAN filter");
+               return;
+       }
+
        pool_sel = dev->data->mac_pool_sel[index];

        for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
@@ -4521,8 +4527,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev,
uint32_t index)
                                vsi = pf->main_vsi;
                        else {
                                /* No VMDQ pool enabled or configured */
-                               if (!(pf->flags & I40E_FLAG_VMDQ) ||
-                                       (i > pf->nb_cfg_vmdq_vsi)) {
+                               if (i > pf->nb_cfg_vmdq_vsi) {
                                        PMD_DRV_LOG(ERR,
                                                "No VMDQ pool
enabled/configured");
                                        return;



-- 
David Marchand

