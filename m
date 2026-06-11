Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF2CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E9BF42F51;
	Thu, 11 Jun 2026 11:10:45 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id DF90D4026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:10:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 57F2914000EE;
 Thu, 11 Jun 2026 05:10:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 05:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781169043;
 x=1781255443; bh=G3ifHnsocaZKvQ2/+l7xaWJ/zNsk3V6+BTr/HkMnNZI=; b=
 E48qFKccxOLnf0IjQBKyklyl0eowi5f9GE+7YhQZfSbwXX0amho53qjmDPO7LCkL
 tdbU4pOZXMrinUcZ599oZQLiL/5oKAIp7H/SvXXO1cL0XEEK5zyMSMiR+khde+V3
 ZefzS2ftVv44LRcNTEQJHZ2klkRbBiNnQQQMgckh13A/2wOc6IPNcevVd5aPEd6c
 4rXOkQOnucU3S7wPdGOc8PoVeRa4GQDYvCG+1eDWH4/F++CHJS2TfrJ5NxeNWI4k
 NXtb2BEdI0S0TsDsnSy5JlDZfRH13VEQKTrNgfOArxX6lH1hunqC2egGIoT6w9qo
 kbLRdazkRUsIP+d6cZ1lBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781169043; x=
 1781255443; bh=G3ifHnsocaZKvQ2/+l7xaWJ/zNsk3V6+BTr/HkMnNZI=; b=G
 BXO2Aw1jggOMQbKM+NloAiyCpbVxf7lAPUm/xd77DQTCxAJ2UeoNLj4ItqW03vRW
 hX+MMnVLUGgHtj+rtHhxLYs5nbVZm63mEYxotT49bn7kaRqNI3TsxfZEvV+/Csxw
 B65fqAYx7jttVekI/hKZ3zaxodC2t28vl4KSsNGfRJMCyFcHhcxxGSSuQU2h/5zi
 awKU4gEo4uQ+iuWiPdcxZfaAlarUNvv1UoUWcUbNS/4Fp4cHgAG9EPjFQqqd4uey
 NugMQqK9Bu2zDfYsDvLH8n8YEObtXNFEr5mJObLgbjhKW9pEcxU7asxyO7Np9lop
 am/5cJCM6ZfUJb1j/fYaw==
X-ME-Sender: <xms:knsqagZCjhViQwLUFF4YEYLd5CTd0il2KPQkqGUUw_ZyJFyfwsJldQ>
 <xme:knsqalfguGC3JHPSEPrtjLhH4EeifA_Cr6_dr44Z8CEd4SrdRTAsUso8jge69Bs7H
 HRZnmAxH8qahY1sMcBMP_syHOx5aMwZQ5aIqh-bFtTCk8F4-S4NiA>
X-ME-Received: <xmr:knsqaq0KVP4v7vVw-E9fNGyYdYKbekm_feDCZIHNdwXlnS8QvMIcLO7kHLwGItH0y1W8MvyCkePJitGwRQ3iWfGiqg>
X-ME-Proxy-Cause: dmFkZTEEd9AQJAMI8q28vwg8u5WuCs3aB3A0Xd+B28qQdYm07XEuCORFMwsysg+Z5Td2sS
 ftBS+IOfhc2d7Bf7EGP65TeciYU3pZk/12XFDnkYSsi8ijVP62UOXOTNRAlPxVSliQSW3/
 J2cdBdvPtz+AcynZ8dLL76OHoDgmvZL62CY+Dt8QJmDe9XlpZq8hk77JB9i5vQXfUR53m7
 xcem9y1CFDBSaMaskcVxKWBuBlxJ5j2k232G1Rb9pdkYn99bEcFYmu6NozSGZwAsgCU850
 LXf7vO2Wxt1+Eautw0Ri+mpUn9iI3KiDnBlUmrDKvIjDfmWFgi4UfSgZRaZYNKVpdkmKFA
 pWUZSpDKtQTqSZzHGjg4KCls8iOMwhTK23RHD0zKnZUBc/2oWAVDUQbRSD2H2SvuXO5fEm
 LfBF+4THSwU7u4e3y1XRlO+e0ga4twC2eZMK0tuXreNGnclthbmhsCa2UjNb79vdgw/kJX
 Y040Hr9JvLy68OfNBWBhbB8BqIb/LyGJs6kKitjFyeaZTHGMvwa0q3ghudnI4YwQTNanrr
 UFzjsI2i4cPKTtE3FuBV1sMFNVip44PmSfL9Dqs79i05C5Eua/a9tKXQfbGViRTVBWtLkN
 +w1+ModINHXzDLwtFj9VEPgbSTrJ3x4g60ECOageU7XYfGe+TcSdoCisD7vA
X-ME-Proxy: <xmx:knsqasL0RDfJ_UjE3qDPNlAiRuSFYT1NaydMyaLbhKphWv82bexwSQ>
 <xmx:knsqapFAp-6dhTLpLBooUqOxYZxS-J1keGG2rcc2eZeAc3A26V4AUw>
 <xmx:knsqaoXhzZkTYG7D40TROkUcCsR3ghQL1ta7up8ZwzuotTbCEzYB-g>
 <xmx:knsqahwSIdqYkYFjS5vCYQ7tMpoATKhpkROzRzys6rbajzw5KlOZZw>
 <xmx:k3sqarZOZ5RJJYrHE7vfALxISOnvDIEEistwX6aSSJ4Sd5Pg7RpP6cDM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 05:10:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, fengchengwen@huawei.com, yangxingui@huawei.com,
 zhanjie9@hisilicon.com
Subject: Re: [PATCH v3 01/10] eal: add interface to check if lcore is EAL
 managed
Date: Thu, 11 Jun 2026 11:10:39 +0200
Message-ID: <JJjyblymSgmJdG-9r0OlIA@monjalon.net>
In-Reply-To: <e616b775-d447-47c3-bc79-e67b2efad636@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
 <vMlZoeDqTD6UrHS2wuWBKw@monjalon.net>
 <e616b775-d447-47c3-bc79-e67b2efad636@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

11/06/2026 08:16, lihuisong (C):
> On 6/11/2026 7:28 AM, Thomas Monjalon wrote:
> > 22/05/2026 06:11, Huisong Li:
> >> Add a new helper function rte_lcore_is_eal_managed() to determine
> >> if a logical core is managed by EAL.
> >>
> >> This interface returns true if the lcore role is either ROLE_RTE
> >> (standard worker/main cores) or ROLE_SERVICE (service cores).
> > [...]
> >> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_is_eal_managed, 26.07)
> >> +int rte_lcore_is_eal_managed(unsigned int lcore_id)
> >> +{
> >> +	struct rte_config *cfg = rte_eal_get_configuration();
> >> +
> >> +	if (lcore_id >= RTE_MAX_LCORE)
> >> +		return 0;
> >> +	return cfg->lcore_role[lcore_id] == ROLE_RTE ||
> >> +		cfg->lcore_role[lcore_id] == ROLE_SERVICE;
> >> +}
> > I'm not sure about adding this function in the API.
> > We already have rte_eal_lcore_role()
> > and I feel having this explicit ROLE_RTE || ROLE_SERVICE
> > in the code where needed may be less confusing.
> 
> Ack.
> 
> >
> > Note: we should prefix these constants with RTE_LCORE_
> 
> Yeah, it's good.
> 
> This will break API. And we can do this in 26.11.

We can keep the old names as aliases.
Better to not break the API, even in 26.11.
We could decide later, after some time, to remove the aliases.


