Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDDD2D117
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C26894060C;
	Tue, 13 Jan 2026 16:00:18 +0100 (CET)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67]) by mails.dpdk.org (Postfix) with ESMTP id 11EC040276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 13:14:44 +0100 (CET)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b87003e998bso422696266b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768306483; x=1768911283; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:to:from:reply-to
 :content-language:references:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IZ6BWsm8eROj+k0NLi+FC27rTfCDSeozUClDCbwHOes=;
 b=PnjP6A6yyrNVwuDLhx9z8295YRJC5rChuqpzOpS18VLD6QRVImuPJwKjztkejPJBNI
 TJJ+8PT23BfrruIgKMYJ5nOwFXM1fbs2Irk73zGyBCD/5s1psoq2BJQfLWLpUUjJMdKW
 0JbiNiteqqUcgQSEDKChvO6hcsOA6GCk97yNWKnu/56rIXQsyJ23nOeEtoTbTCeHRvLv
 vJAQYYBKQ/jT+ivQF9rLVi4+tiNJDVvSvXNrYFtu3QottNeVQ2W4jkVvDYrFY7+RG/pO
 ZgASa+74Pr0AvA2kR3Z4guSY/xBFhdoUegJP46TKZuHsvmtne2l+U5Pkv68KzqWIivZN
 mo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768306483; x=1768911283;
 h=content-transfer-encoding:in-reply-to:to:from:reply-to
 :content-language:references:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZ6BWsm8eROj+k0NLi+FC27rTfCDSeozUClDCbwHOes=;
 b=Unz26BCsKlYg7jXlDaWnok/t+OGJX075lHS+alYnRFi/ms7HAefOTAwoetaj7SNaG+
 6Oza+aiKlOfDeMiLciXRfYLwQ6iqo1w0lP388yxq5rxxUD/fKGBQ0afi1XDEV6ofCZPB
 HA7C1wKqZQaeh73KDuBUJzkabI7xGIdm7wLnWxurQ3oank3YhFR0BIVVfZpHJri6PDNO
 QEBwskCH7R732AmQe3H1D6qXEPlH9506Q5zt1+0IwrOpAoGb0j6pFyxLk5AM0qHyg/Vp
 lO5zTMl6HTnErW+ANg36kfsfUvQRNCAY6kvgOuOHR2S44R8ykwFxfE9SOMcmyy3aRia6
 pThw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZdbA0yVbVV47BbHrp7GxZrx/aurcKtqRSmp7/SyU5X8THY9jl1to8z0mjOCwmkegX5rY=@dpdk.org
X-Gm-Message-State: AOJu0YyGNIwAqGz3rOkvfN3LP3hurwKvnwZeyueM3+j9bC65CW+/LaFe
 rvD0/hlL8UT5S7Zjeu64py8X/lgUk/Gw7s6Otz1KBlEw9l07VKVaPoT7
X-Gm-Gg: AY/fxX75xDSv+MCqx56Mi7eSmPAY+HMkuX+GA7V3NULLOnAi5MrR34CNUHWu0dM1Cvm
 NCB8Jths8v2hnv1XXvtEeF9oQwfZpT9UJCpSr8Hd+LZKBjMYW9EDupZ78TTFV3V58VPj9FR8yMG
 eHUeTH7OSD1dSuQjmKf56IoKcKly+xZgLR5F2Sz9RKrB26C8jmFjqKHhGP8czmw8BmDXVGlqHGQ
 gTJUdDk06tXwG+JMtA6Yua+rlncg2S6tya3fdAFnD2BG44Cl6NwLXi9L7LRwbeGzdI/gjBWtTXQ
 z1MFhVVuNUK0sIP8NezYB03rT6Zk4NCvTdhEHquDuN92TG+VjiHdbgKGry1Of4x7VLbKEaf21mm
 xDGXZbTHEfEfBCVzAS2eQPnJ77kQyCs2En58Fuk1T/70284mw2xpK5YK/UGQc58Gq1MmILZuUge
 04MtRgCAt/+h0vtCRa6b3z/EMST7ii0qGm6MwsYHQaR/MhCA==
X-Google-Smtp-Source: AGHT+IGwlFm/qG8pHkJbe0JwnJxEgSYDS2QYVGat1PhKWEMooDguyBF04tgYWrcR20KWLeNDWdmZrQ==
X-Received: by 2002:a17:907:72c2:b0:b87:2f29:2054 with SMTP id
 a640c23a62f3a-b87358d1e10mr234674066b.8.1768306483210; 
 Tue, 13 Jan 2026 04:14:43 -0800 (PST)
Received: from [192.168.1.118] (89-64-21-15.dynamic.play.pl. [89.64.21.15])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8720e090dasm501173666b.9.2026.01.13.04.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:14:42 -0800 (PST)
Message-ID: <9f794297-87d6-4379-9f2b-1d7f8a42ca0c@gmail.com>
Date: Tue, 13 Jan 2026 13:14:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bus/pci: don't open uio device in secondary process
References: <20240829085724.270041-1-konrad.sztyber@intel.com>
 <20241011111533.20746-1-konrad.sztyber@intel.com>
 <CAJFAV8wiAPumykSavocAZe6eKYFPobTOCcHoDe3yqnf_oeoFmA@mail.gmail.com>
Content-Language: pl, en-US-large
From: Konrad Sztyber <konrad.sztyber@gmail.com>
To: david.marchand@redhat.com, dev@dpdk.org
In-Reply-To: <CAJFAV8wiAPumykSavocAZe6eKYFPobTOCcHoDe3yqnf_oeoFmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 13 Jan 2026 16:00:17 +0100
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
Reply-To: CAJFAV8wiAPumykSavocAZe6eKYFPobTOCcHoDe3yqnf_oeoFmA@mail.gmail.com
Errors-To: dev-bounces@dpdk.org

On 9/19/25 12:15 PM, david.marchand at redhat.com (David Marchand) wrote:
> Sorry I let this patch slip out of my radar.
> I see nothing wrong in this v3, but could you rebase and resend it so
> it goes through our CI?

No worries. Sorry for the late response too, I've missed your e-mail and 
a colleague has brought it to my attention recently. I'll rebase the 
patch and resend it today.

Konrad

