Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD57C88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 11:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0BE34028B;
	Fri, 11 Sep 2026 13:52:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 48E4440264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 13:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789127553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwZGzGuiDIVkmU5cdeX63R7qL75yaAi6wZt+rMWoUHI=;
 b=Zxg1EjtWbedNv6t338f06UeujTX9ujnK6Th2mFsWUxqW0SKOx9dqns8qCwck5wzlPcP+vx
 I9HY/HL4wdxlwkJVr9C13SZ89x5BnDaO35gi2RH1BX1KGuXXYklZt8PsVwGiZLdkF3AZyj
 zOVXn2knL+IXMtTLgO64TGN4THPVLnA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-5lgg7OmaNgyzYob0cUgktg-1; Fri, 11 Sep 2026 07:52:27 -0400
X-MC-Unique: 5lgg7OmaNgyzYob0cUgktg-1
X-Mimecast-MFC-AGG-ID: 5lgg7OmaNgyzYob0cUgktg_1789127546
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a49dcb2b24so14510801fa.1
 for <dev@dpdk.org>; Fri, 11 Sep 2026 04:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127546; x=1789732346;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BwZGzGuiDIVkmU5cdeX63R7qL75yaAi6wZt+rMWoUHI=;
 b=TFNiR4DOquPsizMIcGMcfibtpn5rSHeVeZsmK5LH5HNcRZRDknC9qw6y4fN1Dk8coN
 7IG7E/qsvatSXgT41P0c2O8v+H0JOX5aGaXaTGEEI8z2SqqDR6/apfbbKo4zS00nqLI7
 nqqx/qP6YICvPfg+7rHANH0NtvWHDFTLjuZoVFIHW0xq3yPiLrakshf+xdpHngWsl7xG
 YSRazIXzV20zUtahAhu3iqk+3d03mIvYTR6KgAESVDWGsvowSTWTP85KdWPmdcOx6AFx
 R42/0WLtNzHxIDy8uf0pR/oC3h8g8D6BiXn+tDeC4/oXvaHw+o6pbUBTOZV3x75eWhL+
 P5WQ==
X-Gm-Message-State: AFuF++nVwmrPih2fpeOP5zODnR23TF9KaTe+qcYFI1wnX/CIkKKoH/Nf
 XINNn3nAdtY8hpN8OQtYtw85PpQSJN2CWvsyuJXvl7im8krcoK8U3B8Ouu+LdzzehtUy/NJWByB
 JpqGrz17x7MpcWVHXMN1fhcEvacwu8ZrJDrUBqQFcP6dYYDguUr1UpWg3nc4i7K7eLiPfYjwQ8c
 lGvhqGn5ay/IEBsGSoBVI=
X-Gm-Gg: AYBFou3yHBfaUbrxk5k1w77Yq7VQPySJbFEXSh5UhrHm+IcZLM0nU0Y+BFDJ+tb4CSy
 E2us1BmlJjQyIT+Ikf3EFR8Czj0Nqr7UAtvyTaxBkar1HFE+NJQTPZoM5gGfOw9Gc2QDLEaG0hW
 c2scEpgyh/40czbbFUxJ31yL7kfGvmSChr1/LOz7C4ou1zHdqE8IN4nr9mZFpFrvq2oe7KUmryD
 cbR1RTriJKtjV6+0TTLPntcNihjiI1mfBd1oHkofrdPRIf2
X-Received: by 2002:a05:6512:6c8:b0:5b7:f0b4:de57 with SMTP id
 2adb3069b0e04-5b8a02dcd5fmr800022e87.6.1789127545728; 
 Fri, 11 Sep 2026 04:52:25 -0700 (PDT)
X-Received: by 2002:a05:6512:6c8:b0:5b7:f0b4:de57 with SMTP id
 2adb3069b0e04-5b8a02dcd5fmr800009e87.6.1789127545196; Fri, 11 Sep 2026
 04:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <fa883da6-5491-4b9f-8382-9102045427c8@intel.com>
 <67d60d81-2424-4666-b05f-127647157bc4@intel.com>
In-Reply-To: <67d60d81-2424-4666-b05f-127647157bc4@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Sep 2026 13:52:12 +0200
X-Gm-Features: AcwNN1Vvv-J1ne8jR3gVPNoFpMFigU7rQGmnWUJZ35rgjwv1Q2PljwirBO2Of4E
Message-ID: <CAJFAV8xfgJQpa2OedL+aDmaLyEHk8DVr=hVVf-muH-za0UOw+w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nrjzyX13mggpAiVU7xjrKrY6xq0taEORec9VeHJSA-0_1789127546
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

On Fri, 11 Sept 2026 at 11:37, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
> > I would have preferred it if the caller managed the chunking, not the
> > "add_del_addr_bulk" function. There is precedent for this style of
> > refactor already [1], and I would like to keep things consistent - keep
> > the loop simple (without memsets etc.), and make the caller manage how
> > many addresses are being sent at once.
> >
> > [1] https://patches.dpdk.org/project/dpdk/
> > patch/5e6a55afa2b45e3ee5ec17af7a6c548c96e9698b.1771945933.git.anatoly.burakov@intel.com/
> >
> > This specific refactor is more about removing rte_malloc, but it does
> > also reorganize the loop in a way that I find to be more readable.
> >
>
> I tried prototyping a loop, and realized that the fact that MAC address
> list has holes in it is making things a little difficult, but here's
> what I came up with as an alternative implementation, I think it's a
> little clearer:
>
> ```
> #define IAVF_ETH_ADDR_PER_REQ \
>         ((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
>          sizeof(struct virtchnl_ether_addr))
>
> struct iavf_eth_addr_cmd {
>         struct virtchnl_ether_addr_list list;
>         struct virtchnl_ether_addr extra[IAVF_ETH_ADDR_PER_REQ];
> };
>
> static int
> iavf_send_uc_addr_list(struct iavf_adapter *adapter,
>                        struct virtchnl_ether_addr_list *list, bool add)

Passing the list object means the function *assumes* that the mac
addresses array follows right after.
Idem, the sending function now assumes the size of the passed object.

If the filling happens at the caller, then I'd rather pass the full
object and its size.


> {
>         const char *opname = add ? "VIRTCHNL_OP_ADD_ETH_ADDR" :
> "VIRTCHNL_OP_DEL_ETH_ADDR";
>         uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>         struct iavf_cmd_info args = {0};
>         int err;
>
>         args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
>         args.in_args = (uint8_t *)list;
>         args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
>                 sizeof(struct virtchnl_ether_addr) * list->num_elements;
>         args.out_buffer = msg_buf;
>         args.out_size = IAVF_AQ_BUF_SZ;
>
>         err = iavf_execute_vf_cmd_safe(adapter, &args);
>         if (err != 0)
>                 PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
>                         opname, list->num_elements);
>         else
>                 PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
>                         opname, list->num_elements);
>
>         return err;
> }
>
> void
> iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> {
>         struct rte_ether_addr *addrs = adapter->dev_data->mac_addrs;
>         struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>         uint32_t idx = 1;
>
>         /* Handle primary address (index 0) separately */
>         if (!rte_is_zero_ether_addr(&addrs[0]))
>                 iavf_add_del_eth_addr(adapter, &addrs[0], add,
>                         VIRTCHNL_ETHER_ADDR_PRIMARY);
>
>         /* the secondary address list is sparse, so gather it into full batches */
>         while (idx < IAVF_UC_MACADDR_MAX) {
>                 struct iavf_eth_addr_cmd cmd = {0};
>                 uint16_t nb_addrs = 0;
>
>                 for (; idx < IAVF_UC_MACADDR_MAX && nb_addrs < IAVF_ETH_ADDR_PER_REQ;
> idx++) {
>                         if (rte_is_zero_ether_addr(&addrs[idx]))
>                                 continue;
>
>                         memcpy(cmd.list.list[nb_addrs].addr, addrs[idx].addr_bytes,
>                                 sizeof(cmd.list.list[nb_addrs].addr));
>                         cmd.list.list[nb_addrs].type = VIRTCHNL_ETHER_ADDR_EXTRA;
>                         nb_addrs++;
>                 }
>
>                 if (nb_addrs == 0)
>                         break;
>
>                 cmd.list.vsi_id = vf->vsi_res->vsi_id;
>                 cmd.list.num_elements = nb_addrs;
>                 if (iavf_send_uc_addr_list(adapter, &cmd.list, add) != 0)
>                         break;
>         }
> }
> ```

Well, if we go with such a refactoring, I am not a fan of the nested
loops, but I get the idea.
I'll have a try.


-- 
David Marchand

