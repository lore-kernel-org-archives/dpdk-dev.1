Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA78C531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 08:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CE4B402A7;
	Fri, 24 Jul 2026 10:27:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F39894029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 10:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784881629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyOi1rDII1cDjIOR7tRvBjwkn9n33kAk67TIE+q2UEA=;
 b=gSrNObmxuU/Oi5/eV2XxklhEM+OI37EvnSG5Z774ZEIe/q7BNe7zMsjN9kdrqqTd/S0Rf6
 mE2/iYgfD6xenw0hc6Tr1M5GFGmYNPhAhOzwwqDViXc3O/pgAJsjRq6B8iEzq0hh2e2yUc
 H71pSf44VWt/p6EKw9xJURNk6om+VwQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-qWwP7YRQNWuXII3l00yPOQ-1; Fri, 24 Jul 2026 04:27:05 -0400
X-MC-Unique: qWwP7YRQNWuXII3l00yPOQ-1
X-Mimecast-MFC-AGG-ID: qWwP7YRQNWuXII3l00yPOQ_1784881624
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39ad467f184so1112781fa.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 01:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881624; x=1785486424;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyOi1rDII1cDjIOR7tRvBjwkn9n33kAk67TIE+q2UEA=;
 b=nzRugcZ91VtOofqFw8S6geVVcAtTl+DDF8MA86UjaW+b+d+OYCHi33/Hn1m1bjIi9z
 V7WoIElVmucTT9ytkvCPxNbHS2pKZFVlHxOiv+IrxSlztINHKPEwOBp0ist3rpJ4g6cc
 EyWntiAg513OR/Qhjt9TTFyUh/0SjamqSck07UexFaDkuclMYrXDPKUw4znXhfBYBfhm
 I2Wzk/V2rSF9EslaqAgXT+pKFRZ0Iy+JArLyPWWKUgqeefhIpkv9aIgwGLIsWSQ24tVL
 l67nEgeBXf3NfWS812IgN/6wHvNKU8IebZ1Frq8ALpR0YZt0q/UwOeI9HvsotzGRuFGV
 daSw==
X-Gm-Message-State: AOJu0YwXXdOS7av7y74+Qu4e9Q5Ch+Z05aGbOCJJt6ADl85kSO3tb8xI
 1d2sSwYZivyy7gn0d+Jtv7q9Wb7DU/I/LFq49gTFwdbmeMdD8BUPhYJdrWxb598wF+w3DDDL6r2
 ekrw5qCv1CEA7iRjb8iXrKAh8Fk5aH8GNJj+kjack9UyxJ3uAlMlSuVSuLyi925I07B0hVrvMM9
 4aJ1zqveKvAOfwhR16/+8=
X-Gm-Gg: AR+sD12ZRqflhv1qZgF70NMOZwEJOKSb9ILylyDJuQtasE/G/1T+GptGw47CXr/Sz1C
 VcxeXqTK7S412juk/Nh3wdOZhcoEK9ovKQf+Xmm7qHVUi0o4t6gMdw9vZxuqADZJwlkioLm8Vfr
 x5Dm9gcXB+nFGaKOwRTGBBcQ2llB+9ds0IINHfIb8EUepgO7hwYut+chv7sqRr6OGxgacENgxU4
 XKIxh75IyLf18/0TbUJ+tPZ2oxafw44+LG3K6LBd6D22RDn
X-Received: by 2002:a2e:bcc1:0:b0:39c:8f36:8104 with SMTP id
 38308e7fff4ca-39f07eca7b4mr14401791fa.19.1784881624323; 
 Fri, 24 Jul 2026 01:27:04 -0700 (PDT)
X-Received: by 2002:a2e:bcc1:0:b0:39c:8f36:8104 with SMTP id
 38308e7fff4ca-39f07eca7b4mr14401701fa.19.1784881623863; Fri, 24 Jul 2026
 01:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240726085157.197651-1-gavinl@nvidia.com>
 <3264319.aV6nBDHxoP@thomas>
 <CACZ4nhvELz7E4SggH0=QezmF9iTDbyft4eR=WJKaBGiAxDb_Rg@mail.gmail.com>
 <17056179.Ash8RoxBsO@thomas>
In-Reply-To: <17056179.Ash8RoxBsO@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 10:26:52 +0200
X-Gm-Features: AUfX_mzy7RdD0IZefnYBT1akrURB5BQsuXYsfUI-nMESAKkIiJtadYeQOkrwqtg
Message-ID: <CAJFAV8w59KhVUnXb4+yEA_DM=MYOrrkfNTevN+oYOcVBQSHeDw@mail.gmail.com>
Subject: Re: [V1] doc: announce deprecation of flow item VXLAN-GPE
To: Thomas Monjalon <thomas@monjalon.net>, Gavin Li <gavinl@nvidia.com>
Cc: dev@dpdk.org, matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com, 
 rasland@nvidia.com, Ferruh Yigit <ferruh.yigit@amd.com>,
 bruce.richardson@intel.com, 
 jerinj@marvell.com, maxime.coquelin@redhat.com, stephen@networkplumber.org, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1xcwJbZzY8IBHGZufTsJpB7WtECA5JHs_o_tWYX3Cl8_1784881624
X-Mimecast-Originator: redhat.com
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

On Wed, 31 Jul 2024 at 12:38, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 29/07/2024 15:47, Ajit Khaparde:
> > On Mon, Jul 29, 2024 at 1:48=E2=80=AFAM Thomas Monjalon <thomas@monjalo=
n.net> wrote:
> > >
> > > 26/07/2024 13:31, Ferruh Yigit:
> > > > On 7/26/2024 9:51 AM, Gavin Li wrote:
> > > > > Adding the deprecation notice as reminder for removing
> > > > > RTE_FLOW_ITEM_TYPE_VXLAN_GPE and its related structures,
> > > > > eg. rte_vxlan_gpe_hdr, rte_flow_item_vxlan_gpe, etc.
> > > > >
> > > > > The proposed time of the removal is DPDK release 25.11.
> > > > >
> > > > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > > > ---
> > > > > --- a/doc/guides/rel_notes/deprecation.rst
> > > > > +++ b/doc/guides/rel_notes/deprecation.rst
> > > > > + * ethdev,net: The flow item ``RTE_FLOW_ITEM_TYPE_VXLAN_GPE`` is=
 replaced with ``RTE_FLOW_ITEM_TYPE_VXLAN``.
> > > > > +   The struct ``rte_flow_item_vxlan_gpe``, its mask ``rte_flow_i=
tem_vxlan_gpe_mask`` are replaced with
> > > > > +   ``rte_flow_item_vxlan and its mask`` and its mask ``rte_flow_=
item_vxlan_mask``.
> > > > > +   The item ``RTE_FLOW_ITEM_TYPE_VXLAN_GPE``, the struct ``rte_f=
low_item_vxlan_gpe``, its mask ``rte_flow_item_vxlan_gpe_mask``,
> > > > > +   and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``=
RTE_ETHER_VXLAN_GPE_HLEN``
> > > > > +   will be removed in DPDK 25.11.
> > > >
> > > > Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>
> > >
> > > Acked-by: Thomas Monjalon <thomas@monjalon.net>
> > Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>

Who can work on this cleanup?
Thanks.

--=20
David Marchand

