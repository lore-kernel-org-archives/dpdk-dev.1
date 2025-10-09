Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BBCCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F1324027A;
	Thu,  9 Oct 2025 13:08:36 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id CB9A040277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:08:34 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jrOMWiK1IrLYK9nDesqvUDqKiceqbiFc83lupxEyukg=;
 b=U5KFc9jJtYK0CbcO/8VZN0DeBCmSmjdnTgHk/xwkQKPLgFmmT2fA6TtU6mME5jzIDkAzh5V4a
 Q4OCMLpoGockzgAczK5MvvYvQPHmrYKMInmn5A8tNc1049bUs7bO1sQCjm3qi1Hi2Ks/3BDp1Cr
 RNmuJrgGMdBujP0cgOSIJxQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cj6Xw0Pnvz12LJY;
 Thu,  9 Oct 2025 19:07:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 80D55180B57;
 Thu,  9 Oct 2025 19:08:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 19:08:31 +0800
Message-ID: <a9555f5b-9051-4ed9-94c2-ffe014cf5168@huawei.com>
Date: Thu, 9 Oct 2025 19:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
To: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "vladimir.medvedkin@intel.com"
 <vladimir.medvedkin@intel.com>, "kevin.laatz@intel.com"
 <kevin.laatz@intel.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
 <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA2DDB3385FB29756363375A61CA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <BY3PR18MB478537EA13F30E686068F557C8E6A@BY3PR18MB4785.namprd18.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <BY3PR18MB478537EA13F30E686068F557C8E6A@BY3PR18MB4785.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 10/1/2025 1:57 PM, Jerin Jacob wrote:
> 
> 
>> -----Original Message-----
>> From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>> Sent: Wednesday, September 24, 2025 9:45 AM
>> To: fengchengwen <fengchengwen@huawei.com>; dev@dpdk.org;
>> anatoly.burakov@intel.com
>> Cc: thomas@monjalon.net; bruce.richardson@intel.com;
>> vladimir.medvedkin@intel.com; anatoly.burakov@intel.com;
>> kevin.laatz@intel.com; Jerin Jacob <jerinj@marvell.com>
>> Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and inter-OS
>> DMA
>>
>> Hi Feng, Anatoly,
>>
>> Gentle ping for below review.
>>
>>> -----Original Message-----
>>> From: Vamsi Krishna Attunuru
>>> Sent: Monday, September 22, 2025 5:19 PM
>>> To: fengchengwen <fengchengwen@huawei.com>; dev@dpdk.org;
>>> anatoly.burakov@intel.com
>>> Cc: thomas@monjalon.net; bruce.richardson@intel.com;
>>> vladimir.medvedkin@intel.com; anatoly.burakov@intel.com;
>>> kevin.laatz@intel.com; Jerin Jacob <jerinj@marvell.com>
>>> Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
>>> inter- OS DMA
>>>
>>> Hi Feng,
>>>
>>>> Hi Vamsi, This commit change is more than discussed, it add control
>>>> API which for group management. 1. Control API: I check this commit
>>>> and Intel commit [1], it seem has a quite difference. I hope Intel
>>>> guys can express views
>>>> ZjQcmQRYFpfptBannerEnd
>>>> Hi Vamsi,
>>>>
>>>> This commit change is more than discussed, it add control API which
>>>> for group management.
>>>>
>>>> 1. Control API: I check this commit and Intel commit [1], it seem has
>>>> a quite difference.
>>>>   I hope Intel guys can express views. I prefer not add this part if
>>>> no
>>> response.
>>>
>>> This new feature needs to be securely managed through control APIs. It
>>> would be extremely helpful if the folks at Intel and you as well could
>>> provide support or inputs on this.
> 
> 
> Beyond adding Intel folks to this thread, I don't see any further steps we can take to drive review at this stage.
> 
> That said, the table-based concept used in the current API may not be portable, and we may need improvements here.
> 
> Based on my understanding, DMA devices used for inter process copy can be classified into three categories:
> 
> Class A: Requires a pair of DMA devices (one on each end of process/domain) for data transfer. Marvell DMA devices fall into this category.
> Class B: Requires only a single DMA device (one process/domain has a DMA device, the other process does not). Intel DMA devices fall here.
> Class C: Other types of devices that we are not yet aware of.
> 
> Abstracting all of these under a single API will be challenging. Linux and other OSes do not provide control-plane APIs for this,
> so DPDK must provide control plane mechanisms to support Class A, Class B, and Class C devices.
> 
> Proposal: Split development into separate sets:
> -----------------------------------------------
> Set A: Focus only on the datapath. Assume uint16_t *src_handle and uint16_t *dst_handle come from elsewhere (Class C).
> Set B: Introduce capabilities for Class A devices with portable APIs (proposal below, without table concept).
> Set C: Introduce capabilities for Class B devices and relevant APIs, to be added when needed.
> 
> We can merge Set A in the current release and move Set B to a next release _if_ review or support for Class A devices requires more time.
> 
> @fengchengwen Thoughts? 

okay

> 
> Class A API Proposal:
> ---------------------
> These APIs are based on a new capability flag for inter-process or inter-OS DMA transfers for Class A devices.
> 
> 
> /** Creates an access group for pair-type inter-process or inter-OS DMA transfers. */
> int rte_dma_access_pair_group_create(const struct rte_dma_dev *dev,
>                                      rte_uuid_t process_id,
>                                      rte_uuid_t token,
>                                      uint16_t *group_id);

how about rte_dma_access_group_create(), and add pair-type as one parameter, and also rename process_id as domain_id

> 
> /** Destroys an access group once all participating devices have exited. */
> int rte_dma_access_pair_group_destroy(const struct rte_dma_dev *dev,
>                                       uint16_t group_id);

rte_dma_access_group_destroy()

> 
> /** Allows a device to join an existing access group using a device handle and token. */
> int rte_dma_access_pair_group_join(const struct rte_dma_dev *dev,
>                                    uint16_t group_id,
>                                    rte_uuid_t process_id,
>                                    rte_uuid_t token,
>                                    rte_dma_access_pair_leave_cb_t leave_cb);

rte_dma_access_group_join()

> 
> /** Removes a device from an access group. */
> int rte_dma_access_pair_group_leave(const struct rte_dma_dev *dev,
>                                     uint16_t group_id);
> 
> /** Retrieves the source and destination handles for a given device within the group. */
> int rte_dma_access_pair_gorup_src_dst_handles_get(const struct rte_dma_dev *dev,
>                                             uint16_t group_id,
>                                             rte_uuid_t src_process_id,
>                                             rte_uuid_t dst_process_id,
>                                             uint16_t *src_handle,
>                                             uint16_t *dst_handle);

rte_dma_access_group_handle_get(const struct  rte_dma_dev *dev,
				uint16_t group_id,
				rte_uuid_t domain_id,
				uint16_t *handle);

so user could invoke multiple time if they want to get differ domain_id's handle.

> 
> 
> Parameters that need explanation:
> --------------------------------
> process_id: Unique ID for the process, generated via rte_uuid_ APIs
> token: Provided by an administrative actor to grant access, similar to VFIO VF token creation used in VFIO PF driver.
> leave_cb: Callback to notify when another side leaves the group
> 
> 
> Example Workflow for Class A Inter-Domain DMA Transfer:
> -------------------------------------------------------
> 
> This example demonstrates how three processes — p0, p1, and p2 — coordinate inter-domain DMA transfers using pair-type(Class A) DMA devices.
> 
> Step 1: Group Creation (p0)
> Process p0 calls rte_dma_access_pair_group_create() with a unique process handle and token. A group_id is returned.

I prefer the group_id is int type so it could hold such like file descriptor.

> 
> Step 2: Group Sharing
> group_id and token are shared with p1 and p2 via IPC or shared memory.
> 
> Step 3: Group Joining (p1 & p2)
> Processes p1 and p2 call rte_dma_access_pair_group_join() with their process id  and the shared token from admin
> 
> Step 4: Handle Discovery
> Each process uses rte_dma_access_pair_gorup_src_dst_handles_get() to retrieve source and destination handles for other processes.
> 
> Step 5: Transfer Coordination
> Using the handles, each process configures a virtual channel (vchan) and initiates DMA transfers.
> 
> Step 6: Group Teardown
> When a process no longer needs to participate, it calls rte_dma_access_pair_group_leave(). Other processes are notified via the registered callback with rte_dma_access_pair_group_join().
> Once all devices have exited, p0 calls rte_dma_access_pair_group_destroy() to clean up.
> 
> 
> For Class B: We can add new capability flag and have new set of APIs rte_dma_access_master_ or so. When such devices comes or when intel wants to add it
> 
> 
> 
> 
> 

