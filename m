Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B2C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 11:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD13402E6;
	Thu, 27 Mar 2025 12:11:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E91C9402E6
 for <dev@dpdk.org>; Thu, 27 Mar 2025 12:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743073871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=10LGOrxERDSYRjJHpklTZzgG6aVlfUQd1g6JbXhNwJg=;
 b=EC+lRxv/uSnltq1RisegwVJsGTRb1irVgt3/5FYSnDo+3aLo1o9uzJq+JNIhf3bZuXwQft
 LCFuVbXOKA2VZCShnKQEIMD1A/q6+zpHFj0KoNE+GSzR1dPYfluSAkDbwdAnYIKwSmyEM2
 UkOlePWdasP2UVjJ19VfeKtqMbg0phM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-TKc3Ylg5NsiA027YvVIvDw-1; Thu, 27 Mar 2025 07:11:10 -0400
X-MC-Unique: TKc3Ylg5NsiA027YvVIvDw-1
X-Mimecast-MFC-AGG-ID: TKc3Ylg5NsiA027YvVIvDw_1743073869
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so8215435e9.3
 for <dev@dpdk.org>; Thu, 27 Mar 2025 04:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743073869; x=1743678669;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10LGOrxERDSYRjJHpklTZzgG6aVlfUQd1g6JbXhNwJg=;
 b=CmJk1ItQhz9v+uxNkf4PTgUtT+MzcxwB9d6/Jrdzdo7EmdYvkjnK0HRH2VGuEwdpXa
 uehnsg5IBoqSJJcx+nfZ5F8Znpqs+oBXAtLi3UqfBNQ7yxwjhqIKIvui4MHeel4xdY5u
 zJLDevhkr8OubOIpoVcgVxYyzY6ktav3oYzgD/lzshBqMhARlZb8qk9q7vMxcc9XzRDR
 EzeER0GGqCgazobVc6rD5lKDhHm9VmCjcqaS4AKfuzHdQFBN5/vRDbxdqRvvrgvNZePI
 OG/IabZDzweBt4zgTBiTAFWOwQJpLeJ9MpParxcABCG2SqN79cJ0SLBCfSH5l8ujV6+q
 +vGA==
X-Gm-Message-State: AOJu0Yw+QhpJdbd5rEI+tNN+0MBrDvFTFXqXoRWadb+iSmAH8Rm2IfUE
 Uid6Pb86aDhiAN0TjyvDUUS0SEIjLxztxP1EccYbnGSSS8lBW+usqP1l4klTlFyQZTZr9uGXGYj
 /q0+LHMDAqqMrfBRu/J/tW3m84VnYaOGv/yQAZids
X-Gm-Gg: ASbGncuEGGQR0j+/HesvzNg6xKFW4zyQJuLJUD+5DVxHZZjV/a86iygJ7yYPKO2SVcv
 kGMfW+NsJqhDLcMsppZPN/xsgaUYYYtfUAa4MdBYgfV0tyIzoLzGC3RjdYFpA8kfnP4lzJDBnwK
 0vDQkcoGwkkMBHoDy1DodroaTdAnAH8OKs3odctVGOmA7CF8MKOmetnf0CZfPrwQYR++TobeZd5
 xFXxr6wYz4gzViwjPPLqZHJHgbMoIrTMsFdVUBepsQn2nZZn+qbxskbLrGm7lRsw7OVXKKa8wHf
 9a7TCdds3qDVAqiW
X-Received: by 2002:a05:600c:1381:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d84f8aa39mr24092765e9.8.1743073869038; 
 Thu, 27 Mar 2025 04:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwUcFpFft5PspfAM1ClmvYY2INsIL6Tv9uCHLqHtLc86JCWNSa+r4IF4NzLZHqoHqZ/nU6qA==
X-Received: by 2002:a05:600c:1381:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d84f8aa39mr24092465e9.8.1743073868671; 
 Thu, 27 Mar 2025 04:11:08 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.129.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ad32bd464sm1543936f8f.57.2025.03.27.04.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 04:11:08 -0700 (PDT)
Message-ID: <f7934653-c782-4b62-b2c4-229530349ede@redhat.com>
Date: Thu, 27 Mar 2025 11:11:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DPDK compilers and RHEL 7 support
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>, maxime.coquelin@redhat.com
Cc: dev@dpdk.org, techboard@dpdk.org
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
 <20250326122036.6cc7c02e@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB78@smartserver.smartshare.dk>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB78@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jw2OlOGFHV7sMwlm5TqI2gGjkEL4GDDvJfrxgwsUSMU_1743073869
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 27/03/2025 07:55, Morten Brørup wrote:
> + Red Hat tech board members
> 
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Sent: Wednesday, 26 March 2025 20.21
>>
>> On Wed, 26 Mar 2025 19:06:58 +0100
>> Morten Brørup <mb@smartsharesystems.com> wrote:
>>
>>>> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
>>>> Sent: Wednesday, 26 March 2025 17.22
>>>>
>>>> On Tue, Mar 25, 2025 at 05:22:15PM +0000, Bruce Richardson wrote:
>>>>> When doing a build for a target that already has the instruction
>> sets
>>>>> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or
>> the
>>>>> skylake-avx512 '-march' flags, as they are unnecessary. Instead,
>> when
>>>>> the default flags produce the desired output, just use them
>>>> unmodified.
>>>>>
>>>>> Depends-on: series-34915 ("remove component-specific logic for
>> AVX
>>>> builds")
>>>>>
>>>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>>>> ---
>>>>>
>>>>> This patchset depends on the previous AVX rework. However,
>> sending it
>>>>> separately as a new RFC because it effectively increases the
>> minimum
>>>>> compiler versions needed for x86 builds - from GCC 5 to 6, and
>>>>> Clang 3.6 to 3.9.
>>>>>
>>>>> For now, I've just documented that as an additional note in the
>> GSG
>>>> that
>>>>> these versions are recommended, but it would be simpler if we
>> could
>>>> just
>>>>> set them as the required minimum baseline (at least in the docs).
>>>>>
>>>>> Feedback on these compiler version requirements welcome.
>>>>>
>>>>
>>>> +techboard
>>>>
>>>> Ping for a little bit of feedback for this. Are we ok to bump the
>>>> minimum
>>>> compiler versions as described above, or will I continue with the
>>>> approach
>>>> in this RFC of keeping the minimum and just recommending the higher
>>>> versions for x86 platforms?
>>>>
>>>> For reference GCC 6.1 was released April 2016[1], and, Clang 3.9
>> was
>>>> released Sept 2016[2]
>>>>
>>>> /Bruce
>>>>
>>>> [1] https://gcc.gnu.org/gcc-6/
>>>> [2] https://releases.llvm.org/
>>>
>>> Considering GCC versions shipped with RHEL [3]...
>>> We kind of support RHEL 7, but we already require a newer compiler
>> (GCC 5) than shipped with RHEL 7 (GCC 4.8).
>>> RHEL 8 ships with GCC 8, which was released in May 2018 [4]. Maybe we
>> can jump to GCC 8?
>>>
>>> BTW, we should also apply the same principle I argued [5] should
>> apply for upgrading the Kernel requirements: There should be a need for
>> specific feature or similar - which there is with your patch - and the
>> details should be mentioned in the release notes.
>>>
>>> [3]: https://access.redhat.com/solutions/19458
>>> [4]: https://gcc.gnu.org/gcc-8/
>>> [5]:
>> https://inbox.dpdk.org/dev/CAMEVEZutf4sJ=EQFONw_bJW0tGTWqTbF_Tk_y38qzBL
>> ccco46Q@mail.gmail.com/T/#me7c8f1dbe4331ccf232d43512d6ddb51458c568a
>>>
>>
>> RHEL 7 reached end of life on June 30, 2024.
>> DPDK need no longer support it on future versions.
> 
> CentOS 7 reached EOL June 2024, yes.
> RHEL 7 reached End of Maintenance June 2024, but RHEL 7 Extended Life Cycle Support is available until June 2028 [6].
> 
> Although RHEL 7 not fully EOL, I would consider "End Of Maintenance" sufficiently dead for future DPDK versions not needing to support it.
> If you are running a production system on a distro that's on Extended Life Cycle Support, you shouldn't deploy a new DPDK version - and if you do anyway, it's your own problem, not the DPDK community's problem.
> @Aaron, @Kevin, @Maxime - speak up if you disagree!
> 

+1

Red Hat will not release new RHEL 7 DPDK packages now and there are no
new features/versions of RHEL 7.

I agree if anyone is running RHEL(/CentOS) 7 at this point, they should
not expect that they can just use new versions of DPDK on it without
having to resolve the dependencies themselves.

> 
> [6]: https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux/rhel-7-end-of-maintenance
> 

