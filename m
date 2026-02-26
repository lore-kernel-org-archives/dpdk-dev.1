Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22DFC5926
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:48:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59C44021F;
	Thu, 26 Feb 2026 11:48:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A8F334021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:48:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772102915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uoY+MuzM41O7xW7z21C/XHjY1tpnAIojG0lbPJ1cVC8=;
 b=QelsEtJexLBrGXtDRRKv7RFDV5Bx+wQ3J/zBhD/RF3jClcRV80YYJCC7/h6WcPUV6q5G7o
 5pscJkjt6Mxh3zZX560Dty+rIgnvZvqMOvE3Un29w6+2oCS0ljFTTfxuRefRDsvnBRB2cC
 WQBo4Q7cSutYOV5dB5hqzseNkQL6Uqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-cuff9sXiOLyqLFZBS_v1tg-1; Thu, 26 Feb 2026 05:48:33 -0500
X-MC-Unique: cuff9sXiOLyqLFZBS_v1tg-1
X-Mimecast-MFC-AGG-ID: cuff9sXiOLyqLFZBS_v1tg_1772102913
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so6537995e9.2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 02:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772102912; x=1772707712;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoY+MuzM41O7xW7z21C/XHjY1tpnAIojG0lbPJ1cVC8=;
 b=EgzdGbrXFpSvrpQaTcb7s0NtDPeozjM+QuOT9fmcsiRGnHlDNxDffbfffUTRkphTR4
 wfmzD9wAhYhFakt9IcTmRWrgDLNKWm7YAK1vAM6EsBvtYu1J1zI8ewF1JCX8lp1fPuzN
 DhuRZCeEyVHS2G9malPrlnItV5b9LoTqiXiBHLaDl0uQtNK2IIpTaRwiGeVdlKpz5rP2
 krWL8dDLVoJ9dUwqSIDgpopnFsCEcAjXj1Cr9/qLwh8h5NDQQkyzVkAJM9gXW5AfL+yT
 /MnbYrl8C/X5HxHh+8Phr4SEbWnczfm/QwgK6R/afppplJ0KmKQJ86liCfY9/GtZI2mJ
 JyfQ==
X-Gm-Message-State: AOJu0Yza+0su2oda8DyjIJfStJVkZ32hUSU5QjNkk6jEiHEOUDlkGbw/
 PLkBl1Xv4eXYsTDXLm3dVD0pLiK5K/wjdJjvqZ720IrEfKH86dPr7Sdb4Q0AtLzQS410ZYb6Rgp
 r1mvGMoevxcygrqISxR3AGAI57gmBGCF1SVW6/2lUKFPr
X-Gm-Gg: ATEYQzyMcILZ+nfjBZd01XuwEA42vDQWGCK1tSfvI49FxYtSpYKVYKMY0/Ti0PU9ZXZ
 bVoRxeA0N0yd6G2wWV1YW0/jyjfg2hE8924vxZmmSy4M/6cAFlzEYTuikYGOonoPLety7YsyWDT
 Sr5B9zd4xoVJ7h8p7F1+fCl1y8AduuOseqQe2ryCLm5qBwybUZoCDoTUCcfiBA222M306R/a0SH
 Kl7TeGn2u7edZKOtQIMfikkzUz/wDi97s2yWn5DMHLE2xtmMaAW3g8w2bwqk0VCliWC4jJeqqYS
 tJg0ATO2qlS4pi+vdw3j/FMwz9ChYYa+pah1vFOR+2LV0BgiQxsRWR/le78JqzMsd1m48r4Hy5e
 gpeeWiaTQ0owfu32sZBFk+soS
X-Received: by 2002:a05:600c:3f14:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-483a95e1f15mr316180355e9.21.1772102912506; 
 Thu, 26 Feb 2026 02:48:32 -0800 (PST)
X-Received: by 2002:a05:600c:3f14:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-483a95e1f15mr316180065e9.21.1772102912099; 
 Thu, 26 Feb 2026 02:48:32 -0800 (PST)
Received: from [192.168.0.56] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfba9a5esm80206515e9.4.2026.02.26.02.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 02:48:31 -0800 (PST)
Message-ID: <aa40bb29-8585-4f15-8909-2086b0fd0b08@redhat.com>
Date: Thu, 26 Feb 2026 10:48:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/vm_power: fix format-truncation warning
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
References: <20260225173632.283928-1-ktraynor@redhat.com>
 <20260225103251.37c715f4@phoenix.local>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260225103251.37c715f4@phoenix.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZTBqFB9aptBL-i3fNlggFE3whdJXc8dE_Q1XajQxbI_1772102913
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

On 25/02/2026 18:32, Stephen Hemminger wrote:
> On Wed, 25 Feb 2026 17:36:32 +0000
> Kevin Traynor <ktraynor@redhat.com> wrote:
> 
>> Without libbsd-devel strlcpy is defined as rte_strlcpy and a warning is
>> raised for format-truncation. Observed with gcc 15.2.1.
>>
>> In function ‘rte_strlcpy’,
>>     inlined from ‘add_host_channels’ at
>> ../examples/vm_power_manager/channel_manager.c:600:3:
>> ../lib/eal/include/rte_string_fns.h:63:24:
>> warning: ‘%s’ directive output may be truncated writing up to
>> 4095 bytes into a region of size 108 [-Wformat-truncation=]
>> 63 |         return (size_t)snprintf(dst, size, "%s", src);
>>    |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Check for truncation of socket_path[4096] into channel_path[108] to
>> remove warning.
>>
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> Since socket_path is a unix domain socket path.
> It should be UNIX_PATH_MAX (108) not PATH_MAX (4096)
> 

Yeah, I had adjusted all the socket_path/names in the file to
UNIX_PATH_MAX as an initial fix but it spewed a different truncation
warning as one of them gets a copy from dirent->d_name which is 256.

So considering it's just an optimization of example code and hasn't
really been developed over the last few years, I just fixed the warning
that showed up.

