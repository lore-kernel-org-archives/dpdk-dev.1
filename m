Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7FCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4828C402B1;
	Mon,  6 Oct 2025 16:59:44 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 83024402AF;
 Mon,  6 Oct 2025 16:59:42 +0200 (CEST)
Received: from debian (unknown [78.109.76.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9549EE0277;
 Mon,  6 Oct 2025 18:59:41 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9549EE0277
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1759762782;
 bh=fUggBy0IsiRkvIlcDO7vL9W/cDKf/0kYe07yqDKy6dk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=YYQb3ZiYMtv9Kfrx/ks3Vin2g+qRSTtMf/vH9dqnSs43D5nLyFA45UDuG4F8s3k4y
 ili/qymvjd40JVz7aJiNvsI2171y19/2N8UX2B0eyi/uhwfD+omV4AZMS7iPGWerUA
 3VBndFPKlW3v/Cg055FyIU7AP1ZtYbpv+yjmAfC8K8pjq1kA4Gja2tGmr4lTwMHmO3
 AP+yM90cG2EBVWbrqs5zV9tlle6aY1B04IkWBEmmQcqnDT2phdVs9hWTC/cFnvV2yu
 su+9AxNiI6fWz4mT+joIf8GMIu2Kj+T0tibAjzV35NJ6Nex35H9dmu34MVjsCBlvPW
 Png0GPeQTgiDA==
Date: Mon, 6 Oct 2025 18:59:33 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: dev@dpdk.org, techboard@dpdk.org, stephen@networkplumber.org, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Patrick Robb <probb@iol.unh.edu>
Subject: Re: Use of TX offload flags MBUF_FAST_FREE and MULTI_SEGS
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654A3@smartserver.smartshare.dk>
Message-ID: <8ce42638-6d69-8ae5-867f-8d803214aa13@arknetworks.am>
References: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654A3@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2122161616-1759762782=:12358"
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

--8323328-2122161616-1759762782=:12358
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Morten,

I apologise for my original notice about the co-existence of these flags.
Were it not for my notice, things wouldn't have gone wrong, I take it.

Thank you.

On Mon, 6 Oct 2025, Morten Brørup wrote:

>> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
>> Sent: Friday, 3 October 2025 11.18
>> Subject: Minutes of techboard meeting, 2025-10-01
>
>> * Use of FAST_FREE and multi-buffer/scattered mbuf flags
>>   - The flags for enabling fast-free and supporting multi-mbuf packets
>> are
>>     now documented incompatible
>>   - Previously they were not defined as incompatible, but that seems to
>>     have been assumed for some usages.
>>   - Techboard discussed how best to resolve this incompatibility with
>>     regards to:
>>     - ensuring correctness
>>     - avoiding major churn to DPDK code
>>     - avoiding churn to end-user code
>>   - Options discussed:
>>     1 change definition back to not have the settings incompatible:
>> this
>>       necessitates checking drivers for correctness
>>     2 keep as explicitly incompatible and report error if both
>> specified:
>>       this could break end-user apps, and requires changes to example
>> apps
>>     3 drop the fast-free flag if multi-segment mbufs are also
>> specified:
>>       "hides" the issue, but probably minimises changes. Would need to
>>       decide whether the dropping of flag done in drivers vs ethdev
>> level.
>>       Pros and cons to both options. Needs clear documenting.
>>   - No firm decision reached, will discuss more over email.
>
> IMO, the patch [1] making MBUF_FAST_FREE and MULTI_SEGS explicitly incompatible should be reverted, at least for RC1.
> That will take the project back to the state it was in before we started this discussion.
> And all the examples broken by the patch (because they use both TX offloads) will not need fixing.
>
> [1]: https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-3-mb@smartsharesystems.com/
>
>
--8323328-2122161616-1759762782=:12358--
