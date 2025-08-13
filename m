Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D4CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 12:16:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D9E640E27;
	Wed, 13 Aug 2025 14:16:33 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6DDE3402F1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 14:16:31 +0200 (CEST)
Received: from debian (unknown [78.109.79.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8C3ACE0996;
 Wed, 13 Aug 2025 16:16:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8C3ACE0996
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755087391;
 bh=7RGMYFYi3qteoW6SAMdutiVMihX/YVv0BacUaopQ7WM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ZSWWThUNWHK94KIvm2t1yjl/yO1xDxh+KhDUX0lOQYwKSgAJFSBzXQktmRAtJ5WWj
 wJe61YMvH28tEt/15VJnixPhcpoflZ+tYqSj1qHtscRzRYYwceG40fVNC3Z6JmLqxs
 VCBHj/ib/xsesNWhQsbOdv/UGoOHU+yc/Eox+EkszNWG+b7XKkrziihXtNaUpG6zX/
 SWypAqIA1pwhiplFTPEfWJsFHRim1xRio335c4gHt1gi0Go+tjOp00rI+M5DS9ZLAN
 /xapzoKQHS3cKSB6DTsXZtgbEZN9HJ6cvFMk0bQ0srbgj+DARpyavOYSck6ZNXhun6
 J/CqFtoXynStw==
Date: Wed, 13 Aug 2025 16:16:29 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Thomas Monjalon <thomas@monjalon.net>
cc: Sunil Kumar Kori <skori@marvell.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 1/1] ethdev: add support to provide link type
In-Reply-To: <1975832.6tgchFWduM@thomas>
Message-ID: <165f84cf-1fd7-527b-bda6-8b2823ac85e9@arknetworks.am>
References: <20250606092904.3145608-1-skori@marvell.com>
 <20250813084508.1446318-1-skori@marvell.com> <1975832.6tgchFWduM@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Thomas,

On Wed, 13 Aug 2025, Thomas Monjalon wrote:

> 13/08/2025 10:43, skori@marvell.com:
>> + * Ethernet port type
>
> You mean "link port type"
>
>> + */
>> +#define RTE_ETH_LINK_TYPE_NONE     0  /**< Not defined */
>> +#define RTE_ETH_LINK_TYPE_TP       1  /**< Twisted Pair */
>> +#define RTE_ETH_LINK_TYPE_AUI      2  /**< Attachment Unit Interface */
>> +#define RTE_ETH_LINK_TYPE_MII      3  /**< Media Independent Interface */
>> +#define RTE_ETH_LINK_TYPE_FIBRE    4  /**< Fibre */
>
> In general we use the US word "fiber",
> but we are not very consistent, so it is not a strong opinion.

To me, "fibre" reads more natural. Not a strong opinion either.

>
>> +#define RTE_ETH_LINK_TYPE_BNC      5  /**< BNC */
>> +#define RTE_ETH_LINK_TYPE_DA       6  /**< Direct Attach copper */
>> +#define RTE_ETH_LINK_TYPE_SGMII    7  /**< SGMII */
>> +#define RTE_ETH_LINK_TYPE_QSGMII   8  /**< QSGMII */
>> +#define RTE_ETH_LINK_TYPE_XFI      9  /**< XFI */
>> +#define RTE_ETH_LINK_TYPE_SFI     10  /**< SFI */
>> +#define RTE_ETH_LINK_TYPE_XLAUI   11  /**< XLAUI */
>> +#define RTE_ETH_LINK_TYPE_GAUI    12  /**< GAUI */
>> +#define RTE_ETH_LINK_TYPE_XAUI    13  /**< XAUI */
>> +#define RTE_ETH_LINK_TYPE_GBASE   14  /**< GBASE */
>> +#define RTE_ETH_LINK_TYPE_CAUI    15  /**< CAUI */
>> +#define RTE_ETH_LINK_TYPE_LAUI    16  /**< LAUI */
>> +#define RTE_ETH_LINK_TYPE_SFP     17  /**< SFP */
>> +#define RTE_ETH_LINK_TYPE_SFP_DD  18  /**< SFP_DD */
>
> You should use more full words in comments, at least for DD.

+1

>
>> +#define RTE_ETH_LINK_TYPE_SFP_PLUS 19  /**< SFP_PLUS */
>
> Please add more spaces to allow a correct alignment.
>
>> +#define RTE_ETH_LINK_TYPE_SFP28   20  /**< SFP28 */
>> +#define RTE_ETH_LINK_TYPE_QSFP    21  /**< QSFP */
>> +#define RTE_ETH_LINK_TYPE_QSFP_PLUS 22  /**< QSFP_PLUS */
>> +#define RTE_ETH_LINK_TYPE_QSFP28  23  /**< QSFP28 */
>> +#define RTE_ETH_LINK_TYPE_QSFP56  24  /**< QSFP56 */
>> +#define RTE_ETH_LINK_TYPE_QSFP_DD 25  /**< QSFP_DD */
>> +#define RTE_ETH_LINK_TYPE_OTHER  0x1F /**< Other type */
>
> Why the last one is in hexadecimal? and why 1F?

I take it this is just maximum value for 'uint16_t link_type    : 5;'.

>
> Is there a logic in the order and numbering for this list?
>
> Why not using an enum?

May be RTE_LEN2MASK() or something?

Thank you.

>
> Thanks
>
>
>
>
>
>
