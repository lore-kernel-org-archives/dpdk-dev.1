Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE2606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dk0YuPRe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 435E1427BB;
	Thu,  5 Nov 2026 21:06:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 45055427B6
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793909170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HPb5/QUGNBzNaZt2Sqv/M7u6oPjwZkhma3K5KcHr4GE=;
 b=Dk0YuPRe2eGbjdpqeR/eoW/DuSZuxOQf2kp2VY9waXFwHVwIrcv6OcDBhmtuuQ0exMXqxC
 IdJBGcmCI9g2IDPMIjwCx7yUqloVXQlWemCvGW695pV/0ddnI8QVXQxHrRGLb2f1YZWeyS
 ipeLdShjrJjlihNAQb1jllSAm5vlJMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-EqQRmKjdPQCQ6GPyEdi1Zg-1; Thu, 05 Nov 2026 15:06:07 -0500
X-MC-Unique: EqQRmKjdPQCQ6GPyEdi1Zg-1
X-Mimecast-MFC-AGG-ID: EqQRmKjdPQCQ6GPyEdi1Zg_1793909166
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso19065645e9.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909166; x=1794513966;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPb5/QUGNBzNaZt2Sqv/M7u6oPjwZkhma3K5KcHr4GE=;
 b=pegbbZVSmucdWThP2C2+6kUpErbUEXJSiYf00JFU8JoSDEMMYw3hfq/xuAsekbn1QH
 ohwFifyAT7/8aga/mUAgvjvRMEeiioWf5a7mIEP4xW/yHw65a0gGrn+/wyjKDGV2/xtt
 zMcSgUn977xS12oiOy8eDGWZihEwRcdl4n2uwoOPeiwaSUrZDO/dT17K/umpvmPY30qw
 fUsm/AI4HKBKHcd/qn63hNBN76j940HIOnvSrrIqV9ORVBhpVeQNLbHNZcpOtEgpqPX7
 b59vwNmYDA/4O5EWPJ8g/aCbAkZfSe6As7q/7po4LA5FOa3TeDJCJ4tqn0c8xF3iZR4/
 s1Vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRT6+vKlktCsbw3MIYI3t27VATPsZqgW/JI+/I3RGEtyIrsyCPGW9ndzBqPT2Ui3yEodQ=@dpdk.org
X-Gm-Message-State: APuU4Z86j/VG2DOMdNgDN2afUcLFTUwXUxyHB/wsp8CzlBb89qD+E137
 FyzFYdYuO+3yIqjPsjI61E2cUuBAI9RXEaOM14xXfc2GB3GCLqcu9COcePWft1DXohhRJawC0Oi
 5nScDzX5E5nr/3C55XGpFfbtp3EKLJMESj88846M9+d4Q
X-Gm-Gg: AYBFou1i5xsK7KmojMfb3zs2Fobjtrx9pYLladZV000PyNsBAyKaGG9rdBjpmYb+7DG
 IvHSyN83BOmYBeYeBT1tAbttk0Zym1HQVT74Hi4TUXGDoiQowHKKN3p7DjR/F9BP0BCrGSJogKn
 hSgMn6/SzlnUTUIP99QrnHOFbZQk/v92m1kXxRbhNmB4MIkkjBVNyghEq/G+Oshay9hKtlBdY7A
 ViIhE0Mm+LWuhb1kRUQBMbXOoPznBrHG1legiTjRjqWoQJPoZkxJmfD1yVtBV4Mc6KA2PzPC4qH
 Wc5PTCtzdAHnQV9QmfEOguBFIKUP6IlCFGSjmCRZ8gWbhtIo/RqJB8gVivJTElWJXzPhlpIwQVm
 9sQ2HfezbiZjDn/mwJEeaCiO/FXOacuZ6unsZIT+XsVij22kVIlQTtr2vhk0dR1p3DAaDEnT730
 q9/wfpLnCeLPW8JqzdO+uFZKA4g240Sm/9Kk3S6tDGqdIuuKq0AtcmM/ZIzdek3WnZxD6nDH0KL
 Ph2F3mMjDCtZL6JRTwTkwJlLyBLAb0WCF+dWYC6EbZUE+MFRvH9GTpVpeRm2Aa3+Zl71Lex+Q==
X-Received: by 2002:a05:600c:310e:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4b6dfbac4c3mr3457195e9.31.1793909165771; 
 Thu, 05 Nov 2026 12:06:05 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4b6dfbac4c3mr3456965e9.31.1793909165362; 
 Thu, 05 Nov 2026 12:06:05 -0800 (PST)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cae5sm132655525e9.12.2026.11.05.12.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:06:04 -0800 (PST)
Message-ID: <8b492ff4-3aec-447f-8870-90f553c29b59@redhat.com>
Date: Thu, 5 Nov 2026 21:06:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] bbdev: fix status error for ops dump
To: Hernan Vargas <hernan.vargas@intel.com>, dev@dpdk.org,
 gakhil@marvell.com, trix@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com, stable@dpdk.org
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
 <20261103172902.4152956-2-hernan.vargas@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20261103172902.4152956-2-hernan.vargas@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fmhBEHhqBwZgPGieiCwyK7xpLpbDs0m7FDpqC4L3vKI_1793909166
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/26 6:28 PM, Hernan Vargas wrote:
> The error log being reported by rte_bbdev_enqueue_status_str is
> displayed even without an actual error. The function may be called for
> such index (notably for queue dump) for valid reasons.
>
> Fixes: 4f08028c5e24 ("bbdev: expose queue related warning and status")
> Cc: stable@dpdk.org
>
> Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
> ---
>   lib/bbdev/rte_bbdev.c | 1 -
>   1 file changed, 1 deletion(-)
>
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,

Maxime

