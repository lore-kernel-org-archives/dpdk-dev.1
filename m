Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8ED111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 09:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B46B4021F;
	Mon,  1 Dec 2025 10:20:56 +0100 (CET)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54]) by mails.dpdk.org (Postfix) with ESMTP id 817B44021E
 for <dev@dpdk.org>; Mon,  1 Dec 2025 10:20:55 +0100 (CET)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5959d9a8eceso3144148e87.3
 for <dev@dpdk.org>; Mon, 01 Dec 2025 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764580855; x=1765185655; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=alYW/5TyMbNCOpaVrA7eQLFgdwUroTN/UPiwIVq70Lc=;
 b=gm1/5pxgxWVRE+4ZSD32BgjtMQzHN8kwhwUlHHT1ImKek96GKnZKfuqSbN1S3DKQtj
 ZZ6ltbVjoaVJrG/MkyTuUpcokOwKKy+KIPQO7NVSqsMRGQcEBa8ISAJJyoCMmFZefUnx
 j/ABQtCkz8cRoS27SXQMB3kjk2MosKmN2NcrWww3iw7o/hcZg5IU9ordmdhnOrWy92qL
 vgQvZw2T/sSj6PT/naWpKdcl+9lUmiVqDJWj6TBFvME1YCO835J+/OgenqRsM8EJEazF
 sx5Ljg9kX71fFZNjpyQjjzmb1DgFQ9OhTVCu7TKw93xTOyJzutU5BNhYk9StpUnoJZKm
 hnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764580855; x=1765185655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=alYW/5TyMbNCOpaVrA7eQLFgdwUroTN/UPiwIVq70Lc=;
 b=rxVjP107h+qap26TV2ExE85FtGxBbhsphlbVXWtQYozkEV/S/b6/MGeuVogmujQ3r9
 kjemesMzte+zuOU0lBShvVxerglvDS5P7s6Bj4jH/dKoQahTVnx/F1CYlVXQ30E3xLP4
 ifmaeIUWE/S0akGphyeJ0MZatTu6TwCH7D0n4YLgdcuVfeHA4EVPCwz/M4ih0jCfgrax
 nNVaw8eU+0klF99vtIrEA5h+o2gS7rvw2y8xbJU14rk0Mi6ir5SujoOu8DTBODi1qS5L
 XTYUTQgnAOZYC4Z27jtEmtCQUfi7rECgvDS1akquSmn1K/T5us0E9m1X2/zNBbfZKC0a
 DAYw==
X-Gm-Message-State: AOJu0YzwfvZ2hZhWR/vCQn5ibCDYx52GT+dJ1TGNpKu2eKc4sdl0LzB8
 mxGtCcX3kkI6mSdIkFGaGoVgA6Wjhz5lIiu8NhODKNuO67atOPYMqBOZ
X-Gm-Gg: ASbGncsdHELthbiaihdgkIpDC9UnvJ9lTTU8fFjJPTmVDbIKpU0UtX8UlQWBt4hc+7Z
 PseBL6fqVwdTRgYeH0SGHhJ1zpnxa5Prkx/CUSUeIrgsntl2Tbi9W1Fu9L1CYCQdIDDRQuH5m0G
 g/PLxOL497OhCibNtlIJK6bBJtERDz2ESO54F9NmfCg/w1Y+y2WTFyoep69evg+FtmOuTjhLlI8
 IIf1uxD5X3awmXmes1L0ZJVxWWqvucs/+VTWlOyU/pFi5U5b4gY84UEimLmKUHmDlRZkgOkjVEf
 QjoDSiYkvggBR4E8s30c+Ss0uqwUUjaraNulRUWTehEX+d/ePpYiu5E5u39xiuBow/P8TuYmEls
 HUMJTQElxPZT6zHovBnRtlxoyIn5jC25lgSxP6D3aqqsaALmkihKvd5/s2Cw2u6apYNUce8F9YB
 gfy7RP3CCOOsn3BI1tKxLAlDrgFnq+kur7m3RQBhmp0EMzErb+YSGUdK/F15ZkGtx4pX53l1K3w
 GgA
X-Google-Smtp-Source: AGHT+IFRavW5yb/ALExto3eEx8X+Z7e66ckqCjFgjjoc8a+dCjLx6szSKtQQ9gS6JevDyrsTHQgJMw==
X-Received: by 2002:a05:6512:e9d:b0:594:3615:a919 with SMTP id
 2adb3069b0e04-596a3edd5bdmr12224295e87.38.1764580854432; 
 Mon, 01 Dec 2025 01:20:54 -0800 (PST)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-596bfa48a9fsm3528632e87.67.2025.12.01.01.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 01:20:53 -0800 (PST)
Message-ID: <49bc7ad0-89fa-4b47-9720-94e5c54cf72a@gmail.com>
Date: Mon, 1 Dec 2025 12:20:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Assistance with DPDK on Windows
To: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 "andremue@linux.microsoft.com" <andremue@linux.microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>,
 Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>,
 "users@dpdk.org" <users@dpdk.org>
References: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
 <85f9def5-7f88-47d1-9dc8-524b060c54e5@gmail.com> <2455856.MHSsGVy7CF@thomas>
 <PN3P287MB02734300BEDDDD5A08219DCCB7CAA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
 <PN3P287MB027350E28CAF7DACBBF2CE9FB7DBA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
 <PN3P287MB0273EF115C985B4AF616B13EB7DBA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <PN3P287MB0273EF115C985B4AF616B13EB7DBA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
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

Hi Thenveer,


virt2phys does not conflict with netuio, because virt2phys does not bind 
to any NIC.

It is just loaded into the kernel for DPDK to make IOCTLs to get 
physical addresses.

There are specific instruction for loading virt2phys:

https://git.dpdk.org/dpdk-kmods/tree/windows/README.rst


On 12/1/25 12:13, Thenveer Poolakkanni wrote:
> Hi Team,
> Additionally, I have one more query: how do I use the 
> *virt2phys* driver when I have two network interfaces already bound to 
> *netuio*?
> Thanks,
> Thenveer
