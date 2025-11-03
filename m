Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC29CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 19:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BBE840285;
	Mon,  3 Nov 2025 20:13:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 35CDE40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 20:13:39 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAE92A6B;
 Mon,  3 Nov 2025 11:13:30 -0800 (PST)
Received: from [10.122.34.113] (unknown [10.122.34.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37BBA3F66E;
 Mon,  3 Nov 2025 11:13:38 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------MUAaQdY3fuR7Y800DDvHDrOX"
Message-ID: <455ee0d1-0393-4d8c-87b6-fa038b5ac303@arm.com>
Date: Mon, 3 Nov 2025 13:13:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
To: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>,
 "vattunuru@marvell.com" <vattunuru@marvell.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
 <20251103090717.2d181d95@phoenix>
 <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
 <d63bc45cb32848299574333fed5e5406@huawei.com>
 <20251103104803.30464227@phoenix>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20251103104803.30464227@phoenix>
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

This is a multi-part message in MIME format.
--------------MUAaQdY3fuR7Y800DDvHDrOX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/3/25 12:48, Stephen Hemminger wrote:
> On Mon, 3 Nov 2025 18:06:05 +0000
> Konstantin Ananyev<konstantin.ananyev@huawei.com> wrote:
>
>>> On 11/3/25 11:07, Stephen Hemminger wrote:
>>>> On Mon, 3 Nov 2025 09:12:39 -0600
>>>> Wathsala Vithanage<wathsala.vithanage@arm.com> wrote:
>>>>   
>>>>> MCS lock is broken, it's just a matter of time it will run into a deadlock.
>>>>>
>>>>> drivers/dma/cnxk is a user of MCS lock.
>>>> I am surprised that a driver would use mcslock.
>>>> MCSlock is targeted at case of large number of CPU's with lots of contention.
>>>> It will likely be slower than spinlock or ticketlock for the use case of driver.
>>> It appears in |drivers/dma/cnxk/cnxk_dmadev_fp.c|, perhaps the
>>> maintainer can clarify.
>>>    
>> If MCS lock is really broken, it needs to be fixed anyway.
>> It might be used by other third-party libs/apps that do use on DPDK.
> 100% agree it must be fixed.
> It would be good to have test or static analysis tool that could validate all the lock types.
Looked at seqlock; it seems correct.

Herd7 has been useful, but it's not a static analysis tool. It requires 
identifying a trouble
spot manually and then writing a litmus test to test the hypothesis.

--------------MUAaQdY3fuR7Y800DDvHDrOX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/3/25 12:48, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251103104803.30464227@phoenix">
      <pre wrap="" class="moz-quote-pre">On Mon, 3 Nov 2025 18:06:05 +0000
Konstantin Ananyev <a class="moz-txt-link-rfc2396E" href="mailto:konstantin.ananyev@huawei.com">&lt;konstantin.ananyev@huawei.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
On 11/3/25 11:07, Stephen Hemminger wrote:  
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On Mon, 3 Nov 2025 09:12:39 -0600
Wathsala Vithanage <a class="moz-txt-link-rfc2396E" href="mailto:wathsala.vithanage@arm.com">&lt;wathsala.vithanage@arm.com&gt;</a> wrote:
 
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">MCS lock is broken, it's just a matter of time it will run into a deadlock.

drivers/dma/cnxk is a user of MCS lock.  
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">I am surprised that a driver would use mcslock.
MCSlock is targeted at case of large number of CPU's with lots of contention.
It will likely be slower than spinlock or ticketlock for the use case of driver.  
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">It appears in |drivers/dma/cnxk/cnxk_dmadev_fp.c|, perhaps the
maintainer can clarify.
  
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
If MCS lock is really broken, it needs to be fixed anyway.
It might be used by other third-party libs/apps that do use on DPDK.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
100% agree it must be fixed.
It would be good to have test or static analysis tool that could validate all the lock types.
<span style="white-space: normal"> </span></pre>
    </blockquote>
    Looked at seqlock; it seems correct.<br>
    <p>Herd7 has been useful, but it's not a static analysis tool. It
      requires identifying a trouble<br>
      spot manually and then writing a litmus test to test the
      hypothesis.<br>
      <br>
    </p>
  </body>
</html>

--------------MUAaQdY3fuR7Y800DDvHDrOX--
