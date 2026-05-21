Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE5CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 12:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 160F6402B0;
	Thu, 21 May 2026 14:24:42 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6CF40290
 for <dev@dpdk.org>; Thu, 21 May 2026 14:24:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=m5RdRouOFJACOM3OFdU0sNMJSFAUZuE9jF0qJKYNdew=;
 b=4R0HEX7yr9PFBfFCKFxD2Je6PFc/LypdP75of63ASqdNXB9ogmEQ3FqDl22qXFRjCD92lkZAA
 yLCA7x0vpKmYxZOy4XTcR4N4lh2OlxVJ2Q+lOokwurMCgM/REQESlkMoq4k/6WJquBoF7IuJ9mM
 4zmJB0CgMRLEs+lAVSbmQPI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gLnTM2TfrzLlSL;
 Thu, 21 May 2026 20:16:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 02FD240571;
 Thu, 21 May 2026 20:24:37 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 20:24:36 +0800
Message-ID: <cd4f1bcd-3d66-4ffe-91d7-7ac1fdfe8c2e@huawei.com>
Date: Thu, 21 May 2026 20:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>,
 <andrew.rybchenko@oktetlabs.ru>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
 <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Thanks for the feedback.

I intend to keep the current dict format. This concise ID-name mapping is quite
helpful and easy to read especially when there are massive ports, which is exactly
the main purpose why I submitted this patch.

In my opinion, adopting OData-style query would require architecture-level
refactoring of telemetry framework, which is way too heavy for this simple requirement.
For complex query demands, we can implement them by extending the upper-layer Python
telemetry script instead.

So I suggest we keep this simple form here.

Thanks.

On 5/20/2026 10:58 PM, Bruce Richardson wrote:
> On Wed, May 20, 2026 at 03:29:36PM +0200, Morten Brørup wrote:
>>> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
>>> Sent: Wednesday, 20 May 2026 11.38
>>>
>>> Add /ethdev/list_names telemetry endpoint which returns a dictionary
>>> keyed by port ID with device name as the value, so users can
>>> identify ports by name directly from the telemetry output.
>>>
>>> Original /ethdev/list output:
>>>   {"/ethdev/list": [0, 1]}
>>>
>>> New /ethdev/list_names output:
>>>   {"/ethdev/list_names": {"0": "0000:7d:00.0",
>>>   "1": "0000:7d:00.1"}}
>>>
>>
>> <rant>
>>
>> Unfortunately, the telemetry protocol in DPDK is not using a common design, but takes parameters specific to each path.
>> It should have used OData or something similar, to standardize listing, filtering, etc.
>> Then we could have queried this like:
>> /ethdev/info?$select=port_id,name
> 
> If you are up for implementing something like that, it should be possible
> to have syntax like the above work alongside our existing syntax too.
> The current telemetry scheme was set up with the overarching objective
> being simplicity.
> 
>> And return something like:
>> [
>> 	{
>> 		"port_id": 0,
>> 		"name": "0000:7d:00.0"
>> 	},
>> 	{
>> 		"port_id": 1,
>> 		"name": "0000:7d:00.1"
>> 	}
>> ]
>> or:
>> [
>> 	{
>> 		0,
>> 		"0000:7d:00.0"
>> 	},
>> 	{
>> 		1,
>> 		"0000:7d:00.1"
>> 	}
>> ]
>>
>> But now we are stuck with what we have.
>>
>> </rant>
>>
>> So /etdev/list_names is OK.
>>
>> I'm not really familiar with the DPDK telemetry, so I wonder if indexed arrays are normally returned as an object, like in this patch?
>>
>> I would have expected a list function (such as list_names) to return an array.
>> Either a simple list:
>> {
>> 	"/ethdev/list_names":
>> 	[
>> 		"0000:7d:00.0",
>> 		"0000:7d:00.1"
>> 	]
>> }
>>
> 
> I think it would prefer this, but it does get a bit harder to read with a
> long list.
> 
>> Or a list of objects:
>> {
>> 	"/ethdev/list_names":
>> 	[
>> 		{
>> 			"port_id": 0,
>> 			"name": "0000:7d:00.0"
>> 		},
>> 		{
>> 			"port_id": 1,
>> 			"name": "0000:7d:00.1"
>> 		}
>> 	]
>> }
>>
> 
> Agree that this also would be slightly better.
> 
> However, a *completely* different approach would be to instead solve this
> issue by adding additional functionality to the interactive telemetry
> script itself. After all, the data for the list of names of ethdevs is
> already available from the telemetry endpoints already present in DPDK. All
> we need to do is to extend the python script to have "virtual endpoints" if
> you will, which do the necessary queries in the background and then present
> the data to the user. I think that would be a cleaner approach to things
> like this, rather than always adding more C code.
> 
> /Bruce
> 

