Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45292606A31F
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZLwDsT4w
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D61C40299;
	Thu, 22 Oct 2026 00:52:11 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id F18F6400D7
 for <dev@dpdk.org>; Thu, 22 Oct 2026 00:52:09 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso1312893c88.1
 for <dev@dpdk.org>; Wed, 21 Oct 2026 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792623129; x=1793227929; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K8st6DqPACy8Zh8UQnDvflOD/NrqYmRocaLFu/bHmJc=;
 b=ZLwDsT4wBXOeFM5cdYOp5zEEfN5UAleFmGXPgHEuu91JRllbiSoKEVZbn4Fdpk3d4K
 /C8hlDqEQW9opvcsQv/4t8UzTa8CH91moZvBljDlMVy99oe+LVj4Pi10r1wkGGMwcQZQ
 pH9pSF8mxX+56vIoSWAbjjmxaPdN7A/kelB+wDPVJ2H3BnCP+mPDvm/6qZTIAKufb5Y6
 m5pi7CXFTHKcbRcDefgfPLLrixyBKyy/qGrBKJSEF0BsqGflLrwp+zQy+j6JTjoKBaW8
 4lWmzLrNFeMvoji3I8UBIJcT7a+pL27c1votAavTt0LI2oa7oCHPJGgSkr4cmFQ4F3Sl
 R2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792623129; x=1793227929;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K8st6DqPACy8Zh8UQnDvflOD/NrqYmRocaLFu/bHmJc=;
 b=s8j+nk4k9AGvqV2/gIYp1AZu0qZwdfahHnQoqWyHgoDrNNCwVf+hkC+e0GETdAo+Ks
 GvLjxdvGVKmmv8us0NHWFLxpAP824Qr3+/Y+rgBToZAELw4IaVMaPfZ2NFbgEmMZv3Qg
 3ZsPWXhtEPaA+Jm5o5anM7VQnOW2DRw2QlWRZNt+xcdL8ori3Dt8ldGnt5ayrY1rVmwO
 8zWCdmPQfr6xXWEnzkPbOqDIF7xU8ZAIH6Wx/YQk6T2NBSYATr918mxWBv8P7kexp3MK
 09cKVUzxESZc89fBGavx+2tFItQb3gyTtD/Lk9AGVgj2BVLWx+hBl4MFflOtHsmzBNKN
 QJRA==
X-Gm-Message-State: AFq9FYLo4RKaTvXUH505CXBIF8SyimIrz37NZSpnjO1z9tAetSpjSROk
 LIfF2qhhRh04AIs/xmRb8Q+mVkMAij4Oh6Ww/+v0/6bWyIfwzFfG2RkMxdALYICi
X-Gm-Gg: AYBFou2kVWHcj6cOHKSOZLWBkLqWBm63la9kbemLWQyJHS0xDJKiC6sEWP8uBYc1WiE
 YNKOsJGHL7Q14rIdKgqNBuutZrckR6nZFERxyYiI0U58Vam+Oz8PqjGqfwmORFnguzw48eNUTXe
 uHUmupZa7OxtZTbwH89gzBzsguFTFTNZVgGgPTSrGaxfpameIjQBLQKCtlCznCshqVdQjDJHlE1
 su77qK4ZRkQgJaV7iysWOBLHOBgV/bTs7Mgvzm0AdeGuQjBur5D0mLLUdih1pRZLppXBTl7WXxz
 HPT/W3H269rsVUCGG+8JgC+uE+kvLN2e/ZIzvkdFjzEhUREqONv4uCYPhFRadi2ef7ZyC+CBQZO
 nH1VYZsUEpMwMpoaBZctIYZYLAYb8yRjGAPK1zgPJ0Ae3NWvCyHeXYmrPBPd7Qlg2Vz4HZC5kh4
 UbTlOcF0A1cOrIQ3GrH8KV0coMI71MEaP4kNwhB6TLn9yxB8wsYJUAfQdIKFBxIxCKtNxQ+iFMa
 Us/C5A9MYeI9BSdY/uZlKK0GHY6NvOJg2ekgL/oxejP//unrhRraa0OYfs34c5Vr4RQ/fPSsNus
 hJa5zETI6kJJGB6e8Hk=
X-Received: by 2002:a05:7022:6b81:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-190a6dc116fmr5969893c88.31.1792623128537; 
 Wed, 21 Oct 2026 15:52:08 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bf5d61csm9472447c88.15.2026.10.21.15.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 15:52:08 -0700 (PDT)
Message-ID: <e5a96ad2-83d5-493a-8826-68d221f27067@gmail.com>
Date: Thu, 22 Oct 2026 06:52:04 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <20261013074555.1ab5dc7c@phoenix.local>
 <3de75531-dd3f-4953-8fb8-1f654b74f050@gmail.com>
 <20261020081130.7241326b@phoenix.local>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <20261020081130.7241326b@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 23:11, Stephen Hemminger wrote:
> On Thu, 15 Oct 2026 00:45:00 +0800

>> Addressed in v2.
>>
>> 2/3 now rejects modes other than signature and perfect while
>> parsing, so validate and create both fail for a MAC VLAN rule.
>>
>> On 3/3 I left the DCB packet buffer as it is. Enabling FDIR
>> already clears PBRXSIZE(1..7). Rejecting FDIR when DCB Rx is
>> configured can be a separate patch.
> 
> Still waiting for ACK from a maintainer of that driver.

Hi Stephen,

Zaiyu tested v2 on hardware and provided an Acked-by on October 19.

https://inbox.dpdk.org/dev/005101dd5fb5$9e9e80d0$dbdb8270$@trustnetic.com/

The reply is under the v1 thread,but explicitly confirms testing of the 
v2 series.

Acked-by: Zaiyu Wang <zaiyuwang@trustnetic.com>

Thanks,
Tengfei

