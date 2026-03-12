Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39132FED2F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 23:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D9BB40279;
	Fri, 13 Mar 2026 00:59:13 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id B74CF4026C;
 Fri, 13 Mar 2026 00:59:11 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=WrMAWJA55zQV3WC119+AXCSY/oOf1ej0uZP71/SXFWQ=;
 b=EViF/nO7FAIF/YjCSN9X4MnFn5o//Gfr70KrmTqzU7KzmMpOt89Klg/93j4x314cXEaChW81p
 W/w7nIBDINwhxJfyaSEFb4LMw6c7ozr4H3rWGwZewwGKRZ3cAcRZeQpQCfBeFT1hedner3RUMGW
 SAs7mPwbPhj68854QWM3i0E=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fX4GF3TcPz1cyPF;
 Fri, 13 Mar 2026 07:54:13 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 842654048B;
 Fri, 13 Mar 2026 07:59:09 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 07:59:09 +0800
Message-ID: <37ff0e85-3f46-4b51-bf56-5d03b4910fac@huawei.com>
Date: Fri, 13 Mar 2026 07:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] app/testpmd: check for no arguments
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 Aman Singh <aman.deep.singh@intel.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-4-ktraynor@redhat.com>
 <51026e44-1045-47ef-add5-7a98c3ad4eac@huawei.com>
 <20260312100317.5b06a849@phoenix.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260312100317.5b06a849@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 3/13/2026 1:03 AM, Stephen Hemminger wrote:
> On Thu, 12 Mar 2026 20:37:42 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> Hi Kevin,
>>
>> On 3/12/2026 6:36 PM, Kevin Traynor wrote:
>>> For the case where token is NULL, there are no arguments
>>> and split_str[0] is used uninitialized.  
>>
>> In which case the token is NULL, if there are no arguments, the cmdline's
>> callback won't be invoke.
>>
>> Thanks
> 
> It still maybe possible to get there with an empty string ""
> which would evaluate to no arguments?

No, as tested below:

testpmd> port config  dcb vt on 4 pfc ""
Bad arguments
testpmd> port config  dcb vt on 4 pfc ''
Bad arguments
testpmd> port config  dcb vt on 4 pfc '
Bad arguments
testpmd> port config  dcb vt on 4 pfc
Bad arguments


