Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46491CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 23:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 352BC402DD;
	Tue, 29 Sep 2026 01:12:59 +0200 (CEST)
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by mails.dpdk.org (Postfix) with ESMTP id 545FA40285
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:12:58 +0200 (CEST)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dd046b87so2578077c88.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790637177; x=1791241977; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6CbNFoB/3xkm6D9Bvg/uYdEBY3A5diTl5HhDJexWk4I=;
 b=VBS+loRaEiwDM2sVMsRTnXLFGdfVayQgisdNO5HwgcqwRq6ljzi4UTZuhhpG0zhTbn
 HN0YG1AaKVSv0Z4/I26kz4iwzkHqF74dbq5JN23LtfxeTczszooSxlHQZGz/7omQBguy
 RUrtJOl5YwXS32I783AvgTb8gTAGqvP+xSPF5l2TIkDj8Sniwaq1cJJR794dQMK+Og47
 PdfwxS9kdXwR13rC7fbV67bu5ioMvCSk0JvRKUe2DH2UE/kaPAT2GWijb0pQ1iD+qxAL
 sdbgJkKIhKfRp5TWl7KD1uTyADPiwnkGBt19uSXUdpGm+7wpCgPlDvTUIEpJSBumwNT5
 EGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790637177; x=1791241977;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CbNFoB/3xkm6D9Bvg/uYdEBY3A5diTl5HhDJexWk4I=;
 b=W1yc1/k3Ddkp4j9yuc9Fr8W3wEzA/gnNGPxqvJ4Npm9PGRWpPpoKmoKaGm0MbikAIt
 tTx+g4uG1vDljeBFG2CpaEOAU3WjoKBD7OGkq11mBFzgke4RSROVRLfYkwBY2tN57Emi
 esY0xsPqKsmaBoC0taSVytCrHM1BoqmuVfBw2pVj6muwU5EFQHnlunMbNe0bWq8Bd3L2
 k9ewNrthznNJ/W+VMW4NFGAyv8DwF4fqMJgKfRO6MA/MG+PRKdcVibMSG/hTOEuZJDRg
 EqzbMPRLkXzekoQaToSAcnGvEhY+Jc1cMZqqD5lc9v95SUR1vqapiIv4ppzMpvWcnjar
 eDRQ==
X-Gm-Message-State: AFuF++kl9/7nx9179ZGnQbnc3jC73vpQQlw42HH9QlKJaUbTAsgb2wg0
 9a5117WxRQzvNosndZuuP3bbYPEtubKjEGI5ty6APOh54ck/hU5ArHFya7BRpN9I
X-Gm-Gg: AYBFou1gTSq2gcXyURHSSF5IjvFhafvQV97ZcXg9aTB8jshdfg1mN60qnVPreWkE404
 hgSfrwZ0WGveE2AA91nLuQhMn5Yxi4ZpnNcIzTNIFq0M77XgYhUVPk/jorVdw9Y58TU6NgOlgSP
 s+cFeJnVKEZkPxXHaSgEJK9CdURxY6MyG6qGIXQPXR1qHS0kdUxWLD3NyiwJSbFJ7aE28KYIYhp
 6Hdk2a9x2ixp5C5/7Qt8ofga+fuH4ybDpnikyYhj/IKoDh0uT7QSfYg5g5/gpBzOs5xm5zbiNCX
 J3YEL0Rs3rNXWUdDNL4z2xfa11F/bGffh1+gbtqXWjLOqkX/oKToaBbo8lvtDI0Lu3eni+AWYiE
 kTlbNyvXNetR0f72V9vDW/tY5hJedwimf+QIbxTxBk6wpzC4qjzdkj5QbZ2okMgkppMj8d7V170
 FnXw9FZWbrdqFDe+IebmfXFyU6s7ix6+Ha02BcffJl+CGwl7WMz01CsCqVnFFKahjTuOz1K07a1
 ifKybKeoMmVCbirdqTH6weYp150
X-Received: by 2002:a05:701b:2710:b0:147:a81:611d with SMTP id
 a92af1059eb24-1470a816963mr11003096c88.9.1790637176926; 
 Mon, 28 Sep 2026 16:12:56 -0700 (PDT)
Received: from [192.168.10.104] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm19478685c88.9.2026.09.28.16.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 16:12:56 -0700 (PDT)
Message-ID: <c846b990-8b40-488b-95f3-c151aa9c6b9e@gmail.com>
Date: Tue, 29 Sep 2026 07:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: update contributor name
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
References: <20260927035949.36887-1-zhtfdev@gmail.com>
 <9RwQnWvjTRWvUBMvuRMoiA@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65A81@smartserver.smartshare.dk>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A81@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/28/26 22:33, Morten Brørup wrote:
>> From: Thomas Monjalon [mailto:thomas@monjalon.net]
>> Sent: Monday, 28 September 2026 16.22
>>
>> Hello,
>>
>> 27/09/2026 05:59, Zhang Tengfei:
>>> Use "Zhang Tengfei" as the primary name. Both addresses belong to me
>>
>> In DPDK we try to always have the first name first.
> 
> "first name" -> "given name"
> 
>> I assume Zhang is your family name?
>>
>>
> 
Hi Thomas,Morten,

Yes, Zhang is my family name. In Chinese the family name comes first.
To avoid ambiguity, I'd like to use "ZHANG Tengfei" (family name in
capitals). Would that be OK? If so, I'll send a v2 of the mailmap patch.

Thanks,
ZHANG Tengfei
