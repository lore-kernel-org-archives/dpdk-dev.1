Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757C1CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 03:46:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C03C40280;
	Sat, 30 Aug 2025 05:46:29 +0200 (CEST)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8011A4027D
 for <dev@dpdk.org>; Sat, 30 Aug 2025 05:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756525578; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SP1t4Fzn55txWMpXBs2nUW+UxXLSOYgJ0auooVammLc=;
 b=D1Dl0QIRlxoW34wkOWDGv+NR2bn++c8GqCa8AwapcTK9xfqgWnGENOQkfxkwAjgz8FKbG0
 WQWJdcnopry+ae34FnQykLCYLAX1f4CaOGTN9NKG2XWEbi/34oRguvqifZCcFn0MaFYRWP
 l/P94cf4zvL/giuf4jN8dE9b0nPT/HSi6doG7OVi06f7tZJ51H/022chfg55IIRq81agiQ
 f+eJy7bvZLDVe3Y/wyD2tNNxi5AzEora9I/h+f+h+uaN2a1uRhIxhU4r35bGxf0QrP+geG
 77cRzMN9XwgJLSS0z53TiZrdGC/Vms5j7PuooEkT9+l8GGG5jA7L9FlCr+WWNQ==
In-Reply-To: <20250829132218.421273c1@hermes.local>
X-Lms-Return-Path: <lba+268b27409+c81197+dpdk.org+wanry@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Date: Sat, 30 Aug 2025 11:46:15 +0800
Mime-Version: 1.0
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([114.92.133.222]) by smtp.feishu.cn with ESMTPS;
 Sat, 30 Aug 2025 11:46:16 +0800
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>, 
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, <zhenghy@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
 <20250829132218.421273c1@hermes.local>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/14] net/xsc: PMD updates
Message-Id: <a3b0278e-6ec5-4ebb-8513-563b285951ea@yunsilicon.com>
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

Thank you, Stephen, I've got it.

On 2025/8/30 4:22, Stephen Hemminger wrote:
> On Fri, 29 Aug 2025 16:24:42 +0800
> "Renyong Wan" <wanry@yunsilicon.com> wrote:
>
>> This series introduces multiple updates to the Yunsilicon xsc PMD,
>> including new feature support, optimizations, bug fixes.
>> Highlights include:
>>
>> * Firmware version query support
>> * TSO and FEC support
>> * EEPROM dump and promiscuous mode
>> * Link status and event support
>> * Optimizations for RSS, QP/CQ allocation, and Rx path
>> * Fix for Coverity-reported issue
>>
>>
>> Renyong Wan (14):
>>    net/xsc: add FW version get support
>>    net/xsc: add TSO support
>>    net/xsc: support module EEPROM dump
>>    net/xsc: support promiscuous mode
>>    net/xsc: add link status support
>>    net/xsc: add link status event support
>>    net/xsc: add FEC get and set support
>>    net/xsc: optimize RSS queue creation
>>    net/xsc: optimize QP and CQ memory allocation
>>    net/xsc: optimize Rx path
>>    net/xsc: optimize stop and close
>>    net/xsc: support per port for multi-process
>>    net/xsc: fix uninitialized value
>>    net/xsc: update release notes for xsc PMD
>>
>>   doc/guides/nics/features/xsc.ini       |   7 +
>>   doc/guides/rel_notes/release_25_11.rst |  13 +
>>   drivers/net/xsc/xsc_cmd.h              | 186 +++++++++++-
>>   drivers/net/xsc/xsc_defs.h             |   5 +
>>   drivers/net/xsc/xsc_dev.c              | 361 ++++++++++++++++++++--
>>   drivers/net/xsc/xsc_dev.h              | 116 ++++++-
>>   drivers/net/xsc/xsc_ethdev.c           | 334 +++++++++++++++++----
>>   drivers/net/xsc/xsc_ethdev.h           |   4 -
>>   drivers/net/xsc/xsc_np.c               |  89 ++++--
>>   drivers/net/xsc/xsc_np.h               |  34 ++-
>>   drivers/net/xsc/xsc_rx.c               | 248 +++++++++++----
>>   drivers/net/xsc/xsc_rx.h               |   1 +
>>   drivers/net/xsc/xsc_rxtx.h             |   3 +
>>   drivers/net/xsc/xsc_tx.c               |  14 +-
>>   drivers/net/xsc/xsc_tx.h               |   3 +-
>>   drivers/net/xsc/xsc_vfio.c             | 399 ++++++++++++++++++++++++-
>>   16 files changed, 1605 insertions(+), 212 deletions(-)
>>
> Queued to next-net.
> I fixed the git hash reported as warning with checkpatch.
> Current checkpatch wants more hex bytes in hash.


-- 
Best regards,
Renyong Wan
