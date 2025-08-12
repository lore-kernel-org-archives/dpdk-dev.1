Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50321C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 07:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B4B24026A;
	Tue, 12 Aug 2025 09:36:12 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0AF4340264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 09:36:10 +0200 (CEST)
Received: from debian (unknown [78.109.69.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 60905E097E;
 Tue, 12 Aug 2025 11:36:09 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 60905E097E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754984169;
 bh=fcM0V3rxzrd0cAP/Z3y7hSyRQaQpXqUwRAs5eMxm1c0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=IshggyGgrzCGuFrvSHNmbplTwEt3imTdDOfPI2TRgWbflxB5LFG2j8spDKkZllF3k
 hwa6FhJ6jnKhn9CLG5o/qTy9C2rYB4wUFzv5KaK65NiVryaqfckCnSgyMHid3FI4e8
 3lK6DQrlQ7TbVmFl9SjJs2YTmMHx+FyIiorHrUwxSM3U0/o9u5KpLsptS7fsH4ERWi
 LV5maDXwEOerhXMX8UZFxKzXmbg5kWGO9d65Ia/8uCJpd3z/gTmGm+hdQMXrb5swGQ
 T2VV9P9Bqh36SMksctJyAXtM5HspTZpNeeubGiKPLBfGlcp98UKLwr+6pmpGllY3NX
 jfY2Ugddh7eNQ==
Date: Tue, 12 Aug 2025 11:36:07 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Junlong Wang <wang.junlong1@zte.com.cn>
cc: stephen@networkplumber.org, chen.bingbin@zte.com.cn, dev@dpdk.org
Subject: Re: [v4,2/2] net/zxdh: add support flow director ops
In-Reply-To: <20250812071904.2104777-1-wang.junlong1@zte.com.cn>
Message-ID: <5f681ac0-24d2-ea14-93a2-f78f22c494ac@arknetworks.am>
References: <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
 <20250812071904.2104777-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-815484647-1754984169=:9407"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-815484647-1754984169=:9407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 12 Aug 2025, Junlong Wang wrote:

> 
> > > 1) If both 'spec' and 'mask' are 'NULL', shouldn't the code set some broader
> > > match on the sole presence of a Ethernet header?
> > > 2) If 'mask' is 'NULL' and 'spec' is not (or vice versa), isn't this an error?
> 
> > >> +            break;
> > >> +        case RTE_FLOW_ITEM_TYPE_VLAN:
> > >> +            vlan_spec = item->spec;
> > >> +            vlan_mask = item->mask;
> > >> +            if (vlan_spec && vlan_mask) {
> > >> +                key->vlan_tci  = vlan_spec->tci;
> > >> +                key_mask->vlan_tci = vlan_mask->tci;
> > >> +            }
> > > 
> > >  In my opinion, The values of 'spec' and 'mask' will not be null.
> > >  If the user does not set 'spec' and 'mask', the passed-in values will be set to 00 and ff by default,
> > >  which is ensured by the upper-layer interface of dpdk.
> 
> > Wait a minute.. does this mean that if the user passes, say, ETH / IPV4 / UDP
> > pattern and the 'spec' and 'mask' of ETH are both 'null', the actual key/mask
> > values in the HW rule will be, say, for the EtherType, '0000' and 'ffff'?
> > Is this correct? And which part of DPDK interface envisages that?
> 
> > Again, may be it's just my misunderstanding.
> 
>  Sorry, I misunderstood and caused you inconvenience.
>  If the user does not set 'spec' and 'mask', we will set 'spec' '0000' and mask 'ffff' write fd table to HW,
>  not set by DPDK interface.
>  If the user set one of 'spec' and 'mask', we will also set 'spec' '0000' and mask 'ffff' write fd table to HW.
>  This is how we handle it.

Understood. But is this the best course of action? Say, what happens if the user
passes ETH / IPV4 / UDP pattern items, where 'spec' and 'mask' are 'null' in all
the items? Theoretically, the driver could translate this to set the key to have
EtherType 0x0800/0xffff and IP protocol to be 0x11/0xff . Or am I wrong?

Thank you.
> 
> 
>
--8323328-815484647-1754984169=:9407--
