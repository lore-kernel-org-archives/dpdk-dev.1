Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE6D2F339
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABAAC40615;
	Tue, 13 Jan 2026 16:45:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2DAEB402ED
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768319117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NA0PK/VhF3H8MukggCtddmKo6LQlir5uOgifFi3MIS8=;
 b=T1q+0qVVCCPKwhbZ0xYVJsHlLhSz1Jgc9hgpfLRNsXcx6BcJGKMB8J9yGKi+oUH1wII8Bx
 IvoN3mXbKuyGYY8UUKrpqSLNeF63HmeMAUjt3reI4qT5eXTmzav6N7ELf5Cn+DQmRL7Wqe
 w6J7vH4eUa7NNyY3tA6mxGI2wUz5Tn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Zai0_df-Pe6aq-ZYHGdNLQ-1; Tue, 13 Jan 2026 10:45:16 -0500
X-MC-Unique: Zai0_df-Pe6aq-ZYHGdNLQ-1
X-Mimecast-MFC-AGG-ID: Zai0_df-Pe6aq-ZYHGdNLQ_1768319115
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcfe4494so6086792f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768319115; x=1768923915;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA0PK/VhF3H8MukggCtddmKo6LQlir5uOgifFi3MIS8=;
 b=Mr8PhQ/gY7ryD7H+poV23laP2MzTegUly5fRfazvm4haXIENStDtJZyR32Wt6yoCWp
 z7ZbLffGS/fE1JmL+sn7+KWelYyxonmpEb+yeeGzY7RJseRy2SCvVpuG83GSeXtJgnBq
 mrDPPFekB4UsQ38GBLJwNo+gR1mRDCFWuaQZTib5CcqBLu0JZmGQul5wd/TqVzbDVSBC
 g6XOlAxjBWBn/qIWEPwjSd7Mtjg+OaaXaVRQfbMpdIjCcfgOt7dG+/P6Q88CNNUxZ0xp
 siTwEbUagL8DiFGe9ZADUujZhri4yZr8eddtX6p4+DxYVk7O7+HmAW6pK2Jd5S3GuqRE
 UlsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9pmsKwVqKqxWsPskc4Qa8d//2IxkTmrotngBwGzvxTdK1vjGxSCC7yRd8r/rDp/pPxR4=@dpdk.org
X-Gm-Message-State: AOJu0YznVik9JtiKSyCgP8oYZiY4hYRCFvWdicZmaEJ7ybcel/GJHE3g
 SOhoKQWP8P/ntoJP5t3G5dSougaII5+QuwoelOM9iMeyVbIBJ92m3G47R34t0Dbod+rYDYruFX9
 7x8mIMPdNIGgBmETLrGJ6UN7K+23gVbgt/TIK6Dm6FYWQ
X-Gm-Gg: AY/fxX5oLG0fpUY2h3efGI98ZInDeQ+6lms0H1PyCE9sg8jJ8bpP/SMblMYoiusAXSF
 Jm/QpWZBscwyaSFhhbK80ik8yHvYl9IB4xOhuhzbBQTI4bz31VzXa9R/9Iuinobdk9Z3hf9vpGS
 2+3CbUR0ieMB5qjrnbg4TUqoXxofYLxlkTwRUXgwvbdHIPvCqGr4q/PluBTeWHj79DIjh7tGobS
 n3YNGWnbcW24yk12f14ULBwzwYALjEArx+Sj9Ltvek7CLjT5RcfV+VYXFT2IRwY+f3NxVYxe0DF
 Qf/v9O9TgSI64l0uRQgLIn49vrds+XyWfcUZh4TL/NN4lKkuhQr7Kcjfl7MhcaAZPSVzMjXVKYX
 NNBzMNRJY3QWw
X-Received: by 2002:a05:6000:2011:b0:432:84ef:841f with SMTP id
 ffacd0b85a97d-432c379521bmr26591465f8f.38.1768319114709; 
 Tue, 13 Jan 2026 07:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETw9cbP4mJ6SBLtBxPyKMFzHhEccrtw6D+gmT5BKIHm/3SxodNvBV6HRCaf4Ebo4QnKcWkGQ==
X-Received: by 2002:a05:6000:2011:b0:432:84ef:841f with SMTP id
 ffacd0b85a97d-432c379521bmr26591425f8f.38.1768319114196; 
 Tue, 13 Jan 2026 07:45:14 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm46135207f8f.19.2026.01.13.07.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 07:45:13 -0800 (PST)
Message-ID: <dc0660c1-a55f-441b-8ecf-c2b0b16338a1@redhat.com>
Date: Tue, 13 Jan 2026 15:45:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 22.11.11 patches review and test
From: Kevin Traynor <ktraynor@redhat.com>
To: Ali Alnubani <alialnu@nvidia.com>, "Minggang(Gavin) Li" <gavinl@nvidia.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>,
 John McNamara <john.mcnamara@intel.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Luca Boccassi <luca.boccassi@gmail.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 Salaheddin Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>,
 Shani Peretz <shperetz@nvidia.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
 <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
 <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
 <IA1PR12MB8077E548000554C0B770779EB2B2A@IA1PR12MB8077.namprd12.prod.outlook.com>
 <IA1PR12MB6628D5EE5A1CBDF44D9F1408B3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
 <59833506-9934-4ba3-8af4-45f0fda38bf4@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <59833506-9934-4ba3-8af4-45f0fda38bf4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQ2uDqUbiW8nesCi18pBQXB5bdWjBmmgTrdBmeTDXoc_1768319115
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 05/01/2026 11:54, Kevin Traynor wrote:
> On 24/12/2025 10:12, Minggang(Gavin) Li wrote:
>> Sorry @Luca Boccassi, @Shani Peretz and @Kevin Traynor,
>> I double checked the first commit of the three and found that I did tag it with CC stable but missed the following commits to fix a bug introduce by it. This is the root cause of the mess made by me. The first commit introduced behavior change that should not be backported to stable branches.
>> Please revert the commits mentioned.
>>
>>> -----Original Message-----
>>> From: Maayan Kashani <mkashani@nvidia.com>
>>> Sent: Wednesday, December 24, 2025 3:33 PM
>>> To: Minggang(Gavin) Li <gavinl@nvidia.com>; Luca Boccassi
>>> <luca.boccassi@gmail.com>; Ali Alnubani <alialnu@nvidia.com>; Shani Peretz
>>> <shperetz@nvidia.com>; Kevin Traynor <ktraynor@redhat.com>
>>> Cc: stable@dpdk.org; dev@dpdk.org; John McNamara
>>> <john.mcnamara@intel.com>; Raslan Darawsheh <rasland@nvidia.com>; NBU-
>>> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Salaheddin
>>> Badawi <sbadawi@nvidia.com>; Wael Abualrub <waela@nvidia.com>
>>> Subject: RE: 22.11.11 patches review and test
>>>
>>> ++@Shani Peretz
>>> ++@Kevin Traynor
>>>
>>> Please see below,
>>>
>>> Regards,
>>> Maayan Kashani
>>>
>>>> -----Original Message-----
>>>> From: Minggang(Gavin) Li <gavinl@nvidia.com>
>>>> Sent: Wednesday, 24 December 2025 5:09
>>>> To: Maayan Kashani <mkashani@nvidia.com>; Luca Boccassi
>>>> <luca.boccassi@gmail.com>; Ali Alnubani <alialnu@nvidia.com>
>>>> Cc: stable@dpdk.org; dev@dpdk.org; John McNamara
>>>> <john.mcnamara@intel.com>; Raslan Darawsheh <rasland@nvidia.com>;
>>>> NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>;
>>>> Salaheddin Badawi <sbadawi@nvidia.com>; Wael Abualrub
>>>> <waela@nvidia.com>
>>>> Subject: RE: 22.11.11 patches review and test
>>>>
>>>> Hi Luca,
>>>>
>>>> The issue(https://bugs.dpdk.org/show_bug.cgi?id=1851) was introduced
>>>> by cherry-picking some of the 3 related commits of refactoring
>>>> multicast handling of PF in NV pmd. I don't understand why it/they
>>>> were chosen because they included behavior change in PF. They should
>>>> not be backported to stable ones from my point of view.
>>>>
>>>> The commit(s) polluted 22.11, 23.11 and 24.11 so far. Please revert
>>>> below commits to fix the issue.
>>>>
>>>> 24.11
>>>> ddcaa1671f net/mlx5: fix multicast
>>>> adce6d130b net/mlx5: align PF and VF/SF MAC address handling
>>>>
> 
> Hi Gavin/Maayan/Ali,
> 
> Thanks for the notification.
> 
> Unfortunately 24.11.4 was already released just before Christmas. If we
> revert them now it is scheduled to be April before this is fixed in a
> 24.11 release.
> 
> It seems like a serious regression, so we could consider a new release
> for it now, but we need to confirm if it's really needed first.
> 
> The commits were present but this bug was not reported during 24.114-rc1
> testing. Was this test case covered during 24.11.4-rc1 testing, or just
> specifically for 22.11 ?
> 
> Maybe it has been fixed/masked by other changes in 24.11.4 ?
> 
> If we want to consider a new release, then we'd need testing to confirm
> the bug (not just the commits) is present in 24.11.4 ? and that it is
> fixed by revert of those patches.
> 

Hi, I have an update to this. With CX5 I reproduced this issue in 22.11
without revert and confirmed it was fixed after the revert in 22.11.11.

For 24.11.4, in the same setup, I could not reproduce this issue. So I
do not believe we need a new release now. If there is need for a revert
in 24.11 branch, please send to the stable branch and I will apply for
the next release.

thanks,
Kevin.

> thanks,
> Kevin.
> 
>>>> 23.11
>>>> c070455e8b net/mlx5: align PF and VF/SF MAC address handling
>>>>
>>>> 22.11
>>>> 58a6421bc3 net/mlx5: fix multicast
>>>> ed3411217b net/mlx5: align PF and VF/SF MAC address handling
>>>>
>>>> Regards.
>>>>
>>>>> -----Original Message-----
>>>>> From: Maayan Kashani <mkashani@nvidia.com>
>>>>> Sent: Tuesday, December 23, 2025 10:09 PM
>>>>> To: Luca Boccassi <luca.boccassi@gmail.com>; Ali Alnubani
>>>>> <alialnu@nvidia.com>; Minggang(Gavin) Li <gavinl@nvidia.com>
>>>>> Cc: stable@dpdk.org; dev@dpdk.org; John McNamara
>>>>> <john.mcnamara@intel.com>; Raslan Darawsheh <rasland@nvidia.com>;
>>>> NBU-
>>>>> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>;
>>>> Salaheddin
>>>>> Badawi <sbadawi@nvidia.com>; Wael Abualrub <waela@nvidia.com>
>>>>> Subject: RE: 22.11.11 patches review and test
>>>>>
>>>>> ++@Minggang(Gavin) Li
>>>>>
>>>>> Regards,
>>>>> Maayan Kashani
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Luca Boccassi <luca.boccassi@gmail.com>
>>>>>> Sent: Monday, 22 December 2025 13:27
>>>>>> To: Ali Alnubani <alialnu@nvidia.com>
>>>>>> Cc: stable@dpdk.org; dev@dpdk.org; John McNamara
>>>>>> <john.mcnamara@intel.com>; Raslan Darawsheh <rasland@nvidia.com>;
>>>>>> NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>;
>>>>>> Salaheddin Badawi <sbadawi@nvidia.com>; Wael Abualrub
>>>>>> <waela@nvidia.com>
>>>>>> Subject: Re: 22.11.11 patches review and test
>>>>>>
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On Thu, 18 Dec 2025 at 19:06, Luca Boccassi
>>>>>> <luca.boccassi@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Thu, 18 Dec 2025 at 18:58, Ali Alnubani <alialnu@nvidia.com>
>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/18/25 8:27 PM, Luca Boccassi wrote:
>>>>>>>>> On Thu, 18 Dec 2025 at 18:24, Ali Alnubani
>>>>>>>>> <alialnu@nvidia.com>
>>>>>> wrote:
>>>>>>>>>> On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> Here is a list of patches targeted for stable release 22.11.11.
>>>>>>>>>>>
>>>>>>>>>>> The planned date for the final release is December 18th.
>>>>>>>>>>>
>>>>>>>>>>> Please help with testing and validation of your use cases
>>>>>>>>>>> and report any issues/results with reply-all to this mail.
>>>>>>>>>>> For the final release the fixes and reported validations
>>>>>>>>>>> will be added to the
>>>>>> release notes.
>>>>>>>>>>>
>>>>>>>>>>> A release candidate tarball can be found at:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
>>>>>>>>>>>
>>>>>>>>>>> These patches are located at branch 22.11 of dpdk-stable repo:
>>>>>>>>>>>       https://dpdk.org/browse/dpdk-stable/
>>>>>>>>>>>
>>>>>>>>>>> Thanks.
>>>>>>>>>>>
>>>>>>>>>>> Luca Boccassi
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> We ran the following functional tests with Nvidia hardware
>>>>>>>>>> on
>>>>>> v22.11.11-rc1:
>>>>>>>>>> - Basic functionality:
>>>>>>>>>>     Send and receive multiple types of traffic.
>>>>>>>>>> - testpmd xstats counter test.
>>>>>>>>>> - testpmd timestamp test.
>>>>>>>>>> - Changing/checking link status through testpmd.
>>>>>>>>>> - rte_flow tests
>>>>>>>>>> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardw
>>>>>>>>>> ar
>>>>>>>>>> e-
>>>>>>>>>> of
>>>>>>>>>> floads)
>>>>>>>>>> - RSS tests.
>>>>>>>>>> - VLAN filtering, stripping, and insertion tests.
>>>>>>>>>> - Checksum and TSO tests.
>>>>>>>>>> - ptype tests.
>>>>>>>>>> - link_status_interrupt example application tests.
>>>>>>>>>> - l3fwd-power example application tests.
>>>>>>>>>> - Multi-process example applications tests.
>>>>>>>>>> - Hardware LRO tests.
>>>>>>>>>> - Buffer Split tests.
>>>>>>>>>> - Tx scheduling tests.
>>>>>>>>>>
>>>>>>>>>> Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver:
>>>>>>>>>> MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).
>>>>>>>>>>
>>>>>>>>>> An engineer from my team reported 2 issues:
>>>>>>>>>>
>>>>>>>>>> https://bugs.dpdk.org/show_bug.cgi?id=1851
>>>>>>>>>> Did not reproduce in 22.11.10, git-bisect points to
>>>>>>>>>> 58a6421bc396
>>>>>>>>>> ("net/mlx5: fix multicast")..
>>>>>>>>> Thanks, are you planning to send a fix, or should I just
>>>>>>>>> revert that
>>>>>> commit?
>>>>>>>>
>>>>>>>> I reached out to the engineer who authored the patch and am
>>>>>>>> waiting for their response. I may not be able to get back to
>>>>>>>> you with an answer today, though.
>>>>>>>
>>>>>>> Thank you, no problem it can wait a while
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Any update?
>>>>>>
>>>>>> Thanks
> 

