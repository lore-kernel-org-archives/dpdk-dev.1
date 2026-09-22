Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD28C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 07:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ED4E4026C;
	Tue, 22 Sep 2026 09:50:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A01C8400D6
 for <dev@dpdk.org>; Tue, 22 Sep 2026 09:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790063451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ll+uoMKRGtFPgjotH+Dmo8VC3/iiuBt0/QiEydGWKUQ=;
 b=EoptyJwpuevR5rJrrlCaG2pXFGy0P9pyg5MGiGM4MNof+vOkfSxfs44kbMRgg/VwET1NZh
 T50ECnbPOSU60BVqYImS+F3lVXPdnJ1jxpOxdPedTbM02rotxVM2ufNAN2PcvKuNG3x1uu
 ZS1J18VNFq5hotXRJYDbA7kp7+c1HZ0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-AraAiFR2PVipLtkUG--Pfw-1; Tue, 22 Sep 2026 03:50:50 -0400
X-MC-Unique: AraAiFR2PVipLtkUG--Pfw-1
X-Mimecast-MFC-AGG-ID: AraAiFR2PVipLtkUG--Pfw_1790063449
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b8b53dbb3eso2192438e87.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 00:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790063449; x=1790668249;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ll+uoMKRGtFPgjotH+Dmo8VC3/iiuBt0/QiEydGWKUQ=;
 b=tX/wlEMmKpFJ+F+4+rWMjWBIzUomC/W39Nzep1e5LGaET2v0fwsPrKlHaLNYWXImKc
 AxZqvKPmFnPnnTDirPX68GFtTHtsNaMxzjFEqKK3CrvXs6GkDa9FlcNilKtUv/jzx6GC
 6Y3gqrq35zE/2d9JNTEtGuXG3j8WoxKyP7edxcZuP4Sdu8uRLeJH9awrN4/2mwto9VHf
 wlnb7FQc88U6aZWzT8Go1TNlC3cOvjssXWZnOSDjPz+i3PxaJoB7jpGCgyWNplQMF7aZ
 jrqllIt2m+MpA/319iinKtzAxVmQptMK1SjeYFM73xU/2dMRTdFD8Xc0NWp+YRPmUbgd
 jZoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlhMzF2XHRh9qw6Nk9WyqNArhcwkGeqmEQ+uiuztP4nW3GzUaeaAQKImhf1ussXGd4jFw=@dpdk.org
X-Gm-Message-State: AFuF++k7XlfyvpyBf2jVcDSorFAMjERR9iV9H0BE2bc59QwSvz3nLtib
 grmDrQDCR8GELZyslYkgZLjFlWSBj+67y7czQOsGipw06e/Z5uV8j6E/6ok1jRIKkfqK2/Z4slQ
 9rhj4yrTib8lB2eQ42MHNu7MVdfqLm6e3MAkbjANv7g3yql0YBHo43V7fqMafH4PdDmrd/UBOUc
 BkDcjQjk2uOzlbpEGP2DU=
X-Gm-Gg: AYBFou0wESBRzTzez72NUGcHZ5h3PI/vKCffryfEe/aMFAeimzDd702zWMaWXPnAjrh
 Nkmr2FyXMuFE/GtttoQoioFTCdqIOp03Zsr1zdpd/9kqHXb2Q6hOaljdGgvT83ADDSEfuQGac1W
 3WPaFJWa4K7zEaifo27qIDrC7RIT8Z/J/b3xwBKOOIKX5cTzV6AO+fnz3oGsIHl6AikZqklIbwZ
 qqb7xbFPSaXbxWzfdzoSYX7dNLuyxLVgWLYLV2zanXVHxsM
X-Received: by 2002:a05:6512:1394:b0:5b8:afd2:c17b with SMTP id
 2adb3069b0e04-5b8c181f5c9mr4191615e87.11.1790063448780; 
 Tue, 22 Sep 2026 00:50:48 -0700 (PDT)
X-Received: by 2002:a05:6512:1394:b0:5b8:afd2:c17b with SMTP id
 2adb3069b0e04-5b8c181f5c9mr4191599e87.11.1790063448346; Tue, 22 Sep 2026
 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921091932.39fa0013@phoenix.local>
In-Reply-To: <20260921091932.39fa0013@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 22 Sep 2026 09:50:36 +0200
X-Gm-Features: AclHuK_VoLnzOLDBERjsTe3rC_LAV5C-5LQleRQlmDzPAWMowvV2X9T_3JPeg0M
Message-ID: <CAJFAV8y=YSgqdt+gtXn37VYZagnMzMCaRg+VQZbmjfQ974vW7w@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove VMDq support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 dev@dpdk.org, 
 kishore.padmanabha@broadcom.com, Keegan Freyhof <keegan.freyhof@broadcom.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a_-lm0zASs5mZAMLusGxFOmlENcGXUw3TtBkhu44wgc_1790063449
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

On Mon, 21 Sept 2026 at 18:21, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 20 Sep 2026 21:08:11 -0600
> Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:
>
> > From: Keegan Freyhof <keegan.freyhof@broadcom.com>
> >
> > Remove support for the VMDq feature from the driver: the multi-pool
> > Rx-queue configuration path in bnxt_mq_rx_configure(), the VMDQ VLAN
> > pool wiring in the L2 filter alloc path, and the max_vmdq_pools/
> > vmdq_queue_num reporting in dev_info (now always reported as 0).
> >
> > Preserved two pieces of logic that live in the same
> > function/switch statement but are not VMDq-pool-specific: the
> > RTE_ETH_MQ_RX_RSS pools=rx_cosq_cnt case and the
> > per-non-default-VNIC skip_filter_allocation guard in
> > bnxt_mq_rx_configure(), both used by the plain multi-COS RSS path.
> > Also kept the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST ->
> > l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(): despite the
> > name, those bits are the standard DPDK VF-rxmode API used regardless
> > of hardware VMDq pool support, not a VMDq-pool-specific control.
> >
> > Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> > Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> > ---
>
> [PATCH] net/bnxt: remove VMDq support
>
> Warning: mq_mode validation is lost. Before, VMDq, DCB and DCB_RSS
> modes hit the default case and returned -EINVAL. Now any mode other
> than NONE or RSS silently configures a single pool and succeeds.
> Reject every other mq_mode explicitly in bnxt_mq_rx_configure() or
> dev_configure.

mq_mode should be validated in ethdev now, in next-net.
93b017ff2ffa ("ethdev: check VMDq availability")

Is there something missing?

-- 
David Marchand

